//start_unprocessed_text
/*list buttons;

list Get_Cats()
{
    list cats;
    integer i;
    integer count = llGetInventoryNumber(INVENTORY_NOTECARD);
    while(i < count)
    {
        list params = llParseString2List(llGetInventoryName(INVENTORY_NOTECARD,i),[":"],[]);
        string cat = llList2String(params,0);
        if(llListFindList(cats,[cat]) == -1)
        {
            cats += cat;
        }
        i++;
    }
    cats = ["Radio On","Radio Off"] + cats;
    return cats;
}

list Get_Songs()
{
    list songs;
    integer i;
    integer count = llGetInventoryNumber(INVENTORY_NOTECARD);
    while(i < count)
    {
        list params = llParseString2List(llGetInventoryName(INVENTORY_NOTECARD,i),[":"],[]);
        string cat = llList2String(params,0);
        if(cat == selected_cat)
        {
            songs += llList2String(params,1);
        }
        i++;
    }
    
    return songs;
}


integer listener;
integer chan;
Set_Listen(key toucher)
{
    llListenRemove(listener);
    chan = 0x80000000 | (integer)llFrand(65536) | ((integer)llFrand(65536) << 16);
    listener = llListen(chan,"",toucher,"");
}

string menu;
string selected_cat;
string music_url;

float touch_time;
key owner;

string access_type = "Owner";

list song_uuids;
integer current_index;
float length = 10.0;

key notequery = NULL_KEY;
string notename;
integer noteline = 0;

default
{
    state_entry()
    {
        owner = llGetOwner();
    }
    touch_start(integer number)
    {
        llResetTime();
    }
    touch_end(integer num)
    {
        key toucher = llDetectedKey(0);
        float time = llGetTime();
        if(time <= 0.3)
        {
            if((access_type == "Group" && llSameGroup(toucher)) || access_type == "Public" || (access_type == "Owner" && toucher == owner))
            {
                menu = "cat_select";            
                buttons = Get_Cats();
                if(buttons != [])
                {
                    Set_Listen(toucher);
                    llDialog(toucher,"\n",buttons,chan);
                }
            }
        }
        else
        {
            if(toucher == owner)
            {
                list admin_buttons = ["Access"];
                list params = llGetObjectDetails(llGetKey(),[OBJECT_LAST_OWNER_ID,OBJECT_GROUP]);                
                key last_owner = llList2Key(params,0);
                key object_group = llList2Key(params,1);
                if(object_group != llGetOwner())
                {
                    admin_buttons += "Install";
                    admin_buttons += "Set URL";
                }
               
                menu = "owner_menu";
                Set_Listen(toucher);
                llDialog(toucher,"\n",admin_buttons,chan);
            }
        }
    }
    listen(integer channel, string name, key id, string msg)
    {
        if(menu == "cat_select")
        {
            menu = "song_select";
            selected_cat = msg;
            llDialog(id,"\n",Get_Songs(),channel);
        }
        else if(menu == "song_select")
        {
            if(msg == "Radio On")
            {
                llSetTimerEvent(0);
                llStopSound();  
                llSetLinkMedia(2, 2, [PRIM_MEDIA_AUTO_PLAY, TRUE]);
            }
            else if(msg == "Radio Off")
            {
                llClearLinkMedia(2, 2);
            }
            else
            {
                current_index = 0;
                song_uuids = [];
                llSay(0,"Loading '"+msg+"'...");
                notename = selected_cat+":"+msg;
                notequery = llGetNotecardLine(notename, noteline = 0);
                /|/llSetParcelMusicURL("");
            }
        }
        else if(menu == "owner_menu")
        {
            if(msg == "Access")
            {
                menu = "set_access";
                llDialog(id,"\nCurrent: "+access_type,["Owner","Group","Public"],chan);
            }
            else if(msg == "Install")
            {
                llSay(-999,"INSTALL");
            }
            else if(msg == "Set URL")
            {
                menu = "land_url";
                llTextBox(id,"\n\nEnter a music url below...",chan);
            }
        }
        else if(menu == "land_url")
        {
           music_url = msg;
           llSetLinkMedia(2, 2, [PRIM_MEDIA_CURRENT_URL, msg, PRIM_MEDIA_AUTO_PLAY, FALSE]);
           llOwnerSay("URL set to: "+msg);
        }
        else if(menu == "set_access")
        {
            access_type = msg;
            llOwnerSay("Access set to: "+msg);
        }
    }
    timer()
    {
        current_index++;
        if(current_index < llGetListLength(song_uuids))
        {
            llPlaySound(llList2Key(song_uuids,current_index),1.0);
        }
        else
        {
            llSay(0,"Song end");
            llSetTimerEvent(0);
        }
    }
    dataserver(key id, string data)
    {
        if (id == notequery)
        {
            if (data != EOF)
            {
                data = llStringTrim(data,STRING_TRIM);
                llMessageLinked(LINK_THIS,1,data,"");
                song_uuids += data;
                noteline = noteline + 1;
                notequery = llGetNotecardLine(notename, noteline);
            }
            else
            {
                current_index = 0;
                llPlaySound(llList2Key(song_uuids,current_index),1.0);
                llSetTimerEvent(length);
                llSay(0,"Playing...");
            }
        }
    }
    changed(integer change)
    {
        if(change & CHANGED_INVENTORY)
        {
            llOwnerSay("Inventory updated. Resetting...");
            llResetScript();
        }
    }
    on_rez(integer num)
    {
        llResetScript();
    }
}*/
//end_unprocessed_text
//nfo_preprocessor_version 0
//program_version Firestorm-Releasex64 6.6.8.68380 - Zourew
//last_compiled 06/23/2023 06:24:14
//mono




list buttons;


integer listener;
integer chan;

string menu;
string selected_cat;
string music_url;
key owner;

string access_type = "Owner";

list song_uuids;
integer current_index;
float length = 10.0;

key notequery = NULL_KEY;
string notename;
integer noteline = 0;
Set_Listen(key toucher)
{
    llListenRemove(listener);
    chan = 0x80000000 | (integer)llFrand(65536) | ((integer)llFrand(65536) << 16);
    listener = llListen(chan,"",toucher,"");
}

list Get_Songs()
{
    list songs;
    integer i;
    integer count = llGetInventoryNumber(INVENTORY_NOTECARD);
    while(i < count)
    {
        list params = llParseString2List(llGetInventoryName(INVENTORY_NOTECARD,i),[":"],[]);
        string cat = llList2String(params,0);
        if(cat == selected_cat)
        {
            songs += llList2String(params,1);
        }
        i++;
    }
    
    return songs;
}

list Get_Cats()
{
    list cats;
    integer i;
    integer count = llGetInventoryNumber(INVENTORY_NOTECARD);
    while(i < count)
    {
        list params = llParseString2List(llGetInventoryName(INVENTORY_NOTECARD,i),[":"],[]);
        string cat = llList2String(params,0);
        if(llListFindList(cats,[cat]) == -1)
        {
            cats += cat;
        }
        i++;
    }
    cats = ["Radio On","Radio Off"] + cats;
    return cats;
}

list order_buttons(list buttons)
{
    return llList2List(buttons, -3, -1) + llList2List(buttons, -6, -4) +
        llList2List(buttons, -9, -7) + llList2List(buttons, -12, -10);
}

integer menuindex;

DialogPlus(key avatar, string message, list buttons, integer channel, integer CurMenu)
{
    if (12 < llGetListLength(buttons))
    {
        list lbut = buttons;
        list Nbuttons = [];
        if(CurMenu == -1)
        {
            CurMenu = 0;
            menuindex = 0;
        }

        if((Nbuttons = (llList2List(buttons, (CurMenu * 10), ((CurMenu * 10) + 9)) + ["Back", "Next"])) == ["Back", "Next"])
            DialogPlus(avatar, message, lbut, channel, menuindex = 0);
        else
            llDialog(avatar, message,  order_buttons(Nbuttons), channel);
    }
    else
        llDialog(avatar, message,  order_buttons(buttons), channel);
}

default
{
    state_entry()
    {
        owner = llGetOwner();
        llClearLinkMedia(2, 2);
    }
    touch_start(integer number)
    {
        llResetTime();
    }
    touch_end(integer num)
    {
        key toucher = llDetectedKey(0);
        float time = llGetTime();
        if(time <= 0.3)
        {
            if((access_type == "Group" && llSameGroup(toucher)) || access_type == "Public" || (access_type == "Owner" && toucher == owner))
            {
                menu = "cat_select";            
                buttons = Get_Cats();
                if(buttons != [])
                {
                    Set_Listen(toucher);
                    DialogPlus(toucher,"\n",buttons,chan, menuindex =0);
                }
            }
        }
        else
        {
            if(toucher == owner)
            {
                list admin_buttons = ["Access"];
                list params = llGetObjectDetails(llGetKey(),[OBJECT_LAST_OWNER_ID,OBJECT_GROUP]);                
                key last_owner = llList2Key(params,0);
                key object_group = llList2Key(params,1);
                if(object_group != llGetOwner())
                {
                    admin_buttons += "Install";
                    admin_buttons += "Set URL";
                }
               
                menu = "owner_menu";
                Set_Listen(toucher);
                llDialog(toucher,"\n",admin_buttons,chan);
            }
        }
    }
    listen(integer channel, string name, key id, string msg)
    {
        if(menu == "cat_select")
        {
            
         
            
            if(msg == "Radio On")
            {
                llSetTimerEvent(0);
                llStopSound();  
                llSetLinkMedia(2, 2, [PRIM_MEDIA_CURRENT_URL,music_url, PRIM_MEDIA_AUTO_PLAY,TRUE,PRIM_MEDIA_PERMS_CONTROL,PRIM_MEDIA_PERM_NONE]);
            }
            else if(msg == "Radio Off")
            {
                llClearLinkMedia(2, 2);
            }
            else
            {
                
                  if(msg == "Next")
        {
            
            DialogPlus(id,"\n",buttons,chan, ++menuindex);
        }

       
        else if(msg == "Back")
        {
            if(menuindex > 0)
             DialogPlus(id,"\n",buttons,chan, --menuindex);
            else 
            {

                    DialogPlus(id,"\n",buttons,chan, menuindex =0);
                 
            }
         }  
        else
        {
           menu = "song_select";
           selected_cat = msg;
            
            DialogPlus(id,"\n",Get_Songs(),channel, menuindex = 0);
        } 
                
                
                
                
                
                
                
            }
        }
        else if(menu == "song_select")
        {
            
             if(msg == "Next")
        {
            
            DialogPlus(id,"\n",Get_Songs(),channel, ++menuindex);
        }

       
        else if(msg == "Back")
        {
            if(menuindex > 0)
             DialogPlus(id,"\n",Get_Songs(),channel, --menuindex);
            else 
            {
              
                 menu = "cat_select";   
                 
                buttons = Get_Cats();
                if(buttons != [])
                {
                    Set_Listen(id);
                    DialogPlus(id,"\n",buttons,chan, menuindex =0);
                }  
                
            }
            
    
         }  
         
         else
         {
            
            current_index = 0;
            song_uuids = [];
            llSay(0,"Loading '"+msg+"'...");
            notename = selected_cat+":"+msg;
            notequery = llGetNotecardLine(notename, noteline = 0);
            }
        }
        else if(menu == "owner_menu")
        {
            if(msg == "Access")
            {
                menu = "set_access";
                llDialog(id,"\nCurrent: "+access_type,["Owner","Group","Public"],chan);
            }
            else if(msg == "Install")
            {
                llSay(-999,"INSTALL");
            }
            else if(msg == "Set URL")
            {
                menu = "land_url";
                llTextBox(id,"\n\nEnter a music url below...",chan);
            }
        }
        else if(menu == "land_url")
        {
           music_url = msg;
           llSetLinkMedia(2, 2, [PRIM_MEDIA_CURRENT_URL, msg, PRIM_MEDIA_AUTO_PLAY,TRUE,PRIM_MEDIA_PERMS_CONTROL,PRIM_MEDIA_PERM_NONE]);
           llOwnerSay("URL set to: "+msg);
        }
        else if(menu == "set_access")
        {
            access_type = msg;
            llOwnerSay("Access set to: "+msg);
        }
    }
    timer()
    {
        current_index++;
        if(current_index < llGetListLength(song_uuids))
        {
            llPlaySound(llList2Key(song_uuids,current_index),1.0);
        }
        else
        {
            llSay(0,"Song end");
            llSetTimerEvent(0);
        }
    }
    dataserver(key id, string data)
    {
        if (id == notequery)
        {
            if (data != EOF)
            {
                data = llStringTrim(data,STRING_TRIM);
                llMessageLinked(LINK_THIS,1,data,"");
                song_uuids += data;
                noteline = noteline + 1;
                notequery = llGetNotecardLine(notename, noteline);
            }
            else
            {
                llClearLinkMedia(2, 2);
                current_index = 0;
                llPlaySound(llList2Key(song_uuids,current_index),1.0);
                llSetTimerEvent(length);
                llSay(0,"Playing...");
            }
        }
    }
    changed(integer change)
    {
        if(change & CHANGED_INVENTORY)
        {
            llOwnerSay("Inventory updated. Resetting...");
            llResetScript();
        }
    }
    on_rez(integer num)
    {
        llResetScript();
    }
}
