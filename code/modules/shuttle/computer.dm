/obj/machinery/computer/shuttle
	name = "Shuttle Console"
	icon_screen = "shuttle"
	icon_keyboard = "tech_key"
	req_access = list( )
	circuit = /obj/item/weapon/circuitboard/computer/shuttle
	var/shuttleId
	var/possible_destinations = ""
	var/admin_controlled
	var/no_destination_swap = 0

/obj/machinery/computer/shuttle/New(location, obj/item/weapon/circuitboard/computer/shuttle/C)
	..()
	if(istype(C))
		possible_destinations = C.possible_destinations
		shuttleId = C.shuttleId

/obj/machinery/computer/shuttle/attack_hand(mob/user)
	if(..(user))
		return
	src.add_fingerprint(usr)

	var/list/options = params2list(possible_destinations)
	var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttleId)
	var/dat = "Status: [M ? M.getStatusText() : "*Missing*"]<br><br>"
	if(M)
		var/destination_found
		for(var/obj/docking_port/stationary/S in SSshuttle.stationary)
			if(!options.Find(S.id))
				continue
			if(M.canDock(S))
				continue
			destination_found = 1
			dat += "<A href='?src=\ref[src];move=[S.id]'>Send to [S.name]</A><br>"
		if(!destination_found)
			dat += "<B>Shuttle Locked</B><br>"
			if(admin_controlled)
				dat += "Authorized personnel only<br>"
				dat += "<A href='?src=\ref[src];request=1]'>Request Authorization</A><br>"
	dat += "<a href='?src=\ref[user];mach_close=computer'>Close</a>"

	var/datum/browser/popup = new(user, "computer", M ? M.name : "shuttle", 300, 200)
	popup.set_content("<center>[dat]</center>")
	popup.set_title_image(usr.browse_rsc_icon(src.icon, src.icon_state))
	popup.open()

/obj/machinery/computer/shuttle/Topic(href, href_list)
	if(..())
		return
	usr.set_machine(src)
	src.add_fingerprint(usr)
	if(!allowed(usr))
		usr << "<span class='danger'>Access denied.</span>"
		return

	if(href_list["move"])
		var/obj/docking_port/mobile/M = SSshuttle.getShuttle(shuttleId)
		if(M.launch_status == ENDGAME_LAUNCHED)
			usr << "<span class='warning'>You've already escaped. Never going back to that place again!</span>"
			return
		if(no_destination_swap)
			if(M.mode != SHUTTLE_IDLE)
				usr << "<span class='warning'>Shuttle already in transit.</span>"
				return
		switch(SSshuttle.moveShuttle(shuttleId, href_list["move"], 1))
			if(0)
				usr << "<span class='notice'>Shuttle received message and will be sent shortly.</span>"
			if(1)
				usr << "<span class='warning'>Invalid shuttle requested.</span>"
			else
				usr << "<span class='notice'>Unable to comply.</span>"

/obj/machinery/computer/shuttle/emag_act(mob/user)
	if(!emagged)
		src.req_access = list()
		emagged = 1
		user << "<span class='notice'>You fried the consoles ID checking system.</span>"

