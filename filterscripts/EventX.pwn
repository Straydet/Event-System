/*
		Sistema de Eventos v1.0
		
		Idea Original (Marcelo_Play | marcelodell) - https://pastebin.com/ememJCKE
		
		Desarrollador/Traducción (Straydet) - Desarrollo de algunas funciones/comandos

*/

#include <a_samp>
#include <zcmd>
#include <sscanf2>


//=======================[Dialogos de Evento]=================================//
#define				DIALOG_EVENTO				950
#define				DIALOG_ABRIREVENTO			951
#define				DIALOG_NOMEEVENTO			952
#define				DIALOG_PREMIO1				953
#define				DIALOG_PREMIO2				954
#define				DIALOG_PREMIO3				955
#define				DIALOG_PREMIO4				956
#define				DIALOG_CARRO				958
#define				DIALOG_COR1					959
#define				DIALOG_COR2					960
#define				DIALOG_ARMA  				961
#define				DIALOG_MUNICAO				962
#define				DIALOG_VIDAVEICULOS			963
#define				DIALOG_KICK					964
#define				DIALOG_FIM1					965
#define				DIALOG_FIM2					966
#define				DIALOG_FIM3					967
#define				DIALOG_VIDA					968
#define				DIALOG_COLETE				969
#define				DIALOG_SKIN1				970
#define				DIALOG_DEFINIR				975
#define             DIALOG_LUGARESEZ            976

//===================[Sistema Evento - Colores]==========================
#define	COR_EVENTO		0xFF8000AA
#define	COR_ERRO		0xFF0000FF
#define	COR_INFO		0xFFFF00AA
#define COLOR_AMARILLO	0xFFFF00FF
#define yellow 			0xFFFF00AA
#define COLOR_YELLOW 	0xFFFF00AA
//===================[Sistema Evento - News and enums]==========================
new CountAmountEvento;
new CountTimerEvento;

new NombrePlayer[MAX_PLAYER_NAME],
	NameA[64],
	Format[2500],
	Float:PosXx,
	Float:PosYy,
	Float:PosZz,
	Float:PosAa;

enum eventInfo
{
	Float:Xq,
	Float:Yq,
	Float:Zq,
	Float:Aq,
	VirtualWorld,
	Interior,
	NombreE[64],
	Criado,
	Aberto,
	Cerrado,
	Premio1,
	Premio2,
	Premio3,
	PremioS,
	Carro,
	Cor1,
	Cor2,
	eArma,
	Admin[64],
	Vida,
};

enum pInfo
{
	NoEvento,
	Carro,
};


new EventInfo[eventInfo];
new PlayerInfoE[MAX_PLAYERS][pInfo];

//------------------------------------------------------------------------------
public OnFilterScriptInit()
{
	EventInfo[Xq] = 0;
	EventInfo[Yq] = 0;
	EventInfo[Zq] = 0;
	EventInfo[Aq] = 0;
	EventInfo[VirtualWorld] = 0;
	EventInfo[Interior] = 0;
	EventInfo[Criado] = 0;
	EventInfo[Cerrado] = 0;
	EventInfo[Aberto] = 0;
	EventInfo[Premio1] = 0;
	EventInfo[Premio2] = 0;
	EventInfo[Premio3] = 0;
	EventInfo[PremioS] = 0;
	EventInfo[Carro] = 0;
	EventInfo[Cor1] = 0;
	EventInfo[Cor2] = 0;
	EventInfo[eArma] = 0;
	EventInfo[Vida] = 0;
    return 1;
}
//------------------------------------------------------------------------------
public OnFilterScriptExit()
{
    return 1;
}
//------------------------------------------------------------------------------
public OnPlayerConnect(playerid)
{
    if(PlayerInfoE[playerid][NoEvento] == 1){PlayerInfoE[playerid][NoEvento] = 0;}
    return 1;
}
//------------------------------------------------------------------------------
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_EVENTO)
	{
	    if(response)
		{
		    switch (listitem)
			{
				case 0:
				{
					if(EventInfo[Criado] == 1) return SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}Ya existe un evento Abierto, Finaliselo para crear otro!");
					ShowPlayerDialog(playerid, DIALOG_NOMEEVENTO, DIALOG_STYLE_INPUT, "{00FF00}Creación de Evento", "Digite el Nombre del Evento:", "Continuar", "");
					return 1;
				}
				case 1:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					SetPlayerPos(playerid, EventInfo[Xq], EventInfo[Yq], EventInfo[Zq]);
					SetPlayerVirtualWorld(playerid, EventInfo[VirtualWorld]);
					SetPlayerInterior(playerid, EventInfo[Interior]);
					SendClientMessage(playerid, COLOR_AMARILLO, "[EVENTO]: Fuiste llevado a la ubicacion del Evento!");
					return 1;
				}
				case 2:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_ARMA, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Arma que darás a\ntodos los Jugadores del Evento:", "Continuar", "Cancelar");
					return 1;
				}
				case 3:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_CARRO, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Vehículo que darás a\ntodos los Jugadores del Evento:\n\n(0 = Nenhum)", "Continuar", "Cancelar");
					return 1;
				}
				case 4:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_FIM1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Primer Lugar del Evento:", "Continuar", "Cancelar");
					return 1;
				}
				case 5:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_VIDAVEICULOS, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la Vida que deseas definir a los\nVehículos del Evento:", "Definir", "Cancelar");
					return 1;
				}
				case 6:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_KICK, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Jugador que deseas Kickear del Evento:", "Kickar", "Cancelar");
					return 1;
				}
				case 7:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_VIDA, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la Vida que deseas definir a los\nJugadores del Evento", "Definir", "Cancelar");
					return 1;
				}
				case 8:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					ShowPlayerDialog(playerid, DIALOG_SKIN1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Skin que deseas\naplicar a los Jugadores del Evento:", "Definir", "Cancelar");
					return 1;
				}
				case 9:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					for(new p = 0; p < MAX_PLAYERS; p++)
					{
						if(PlayerInfoE[p][NoEvento] == 1)
						{
							TogglePlayerControllable(p, 0);
						}
					}
					GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
					format(Format, sizeof(Format), "[EVENTO]: El Administrador %s congeló a todos los Jugadores del Evento!", NombrePlayer);
					SendEventMessage(COR_INFO, Format);
					return 1;
				}
				case 10:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					for(new p = 0; p < MAX_PLAYERS; p++)
					{
						if(PlayerInfoE[p][NoEvento] == 1)
						{
							TogglePlayerControllable(p, 1);
						}
					}
					GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
					format(Format, sizeof(Format), "[EVENTO]: El Administrador %s descongeló a todos los Jugadores del Evento!", NombrePlayer);
					SendEventMessage(COR_INFO, Format);
					return 1;
				}
				case 11:
				{
					if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					for(new p = 0; p < MAX_PLAYERS; p++)
					{
						if(PlayerInfoE[p][NoEvento] == 1)
						{
							ResetPlayerWeapons(p);
						}
					}
					EventInfo[eArma] = 0;
					GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
					format(Format, sizeof(Format), "[EVENTO]: El Administrador %s reseteó las Armas a los Jugadores del Evento!", NombrePlayer);
					SendEventMessage(COR_INFO, Format);
					return 1;
				}
				case 12:
				{
                    if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
					new Float:x,Float:y,Float:z, interior = GetPlayerInterior(playerid);
			    	GetPlayerPos(playerid,x,y,z);
				   	for(new i = 0; i < MAX_PLAYERS; i++)
		            {
						if(IsPlayerConnected(i) && (i != playerid) && PlayerInfoE[i][NoEvento] == 1)
						{
							PlayerPlaySound(i,1057,0.0,0.0,0.0);
							SetPlayerPos(i, x+1, y, z);
							SetPlayerInterior(i,interior);
						}
					}
					GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
					format(Format, sizeof(Format), "[EVENTO]: El Administrador %s llevo a todos los Jugadores del Evento a su Posicion!", NombrePlayer);
					SendEventMessage(COR_INFO, Format);
					return 1;
				}
			}
		}
		return 1;
	}
	//------------------------------------------------------------------------------
	if(dialogid == DIALOG_DEFINIR)
	{
	    if(response)
		{
        GetPlayerPos(playerid, PosXx, PosYy, PosZz);
        GetPlayerFacingAngle(playerid, PosAa);
		EventInfo[Xq] = PosXx;
		EventInfo[Yq] = PosYy;
		EventInfo[Zq] = PosZz;
		EventInfo[Aq] = PosAa;
		EventInfo[Interior] = GetPlayerInterior(playerid);
		EventInfo[VirtualWorld] = (GetPlayerVirtualWorld(playerid) + 1);
		SendClientMessage(playerid, 0xFF0000AA, "* {FFFFFF}Posición del Evento Definida!");
		ShowPlayerDialog(playerid, DIALOG_PREMIO1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite cual será el Premio para el 1º Lugar:", ">>", "");
		}
		return 1;
	}
    //------------------------------------------------------------------------------
	if(dialogid == DIALOG_NOMEEVENTO)
	{
	    if(response)
		{
            if(strlen(inputtext) < 5 || strlen(inputtext) > 19)	return	ShowPlayerDialog(playerid, DIALOG_NOMEEVENTO, DIALOG_STYLE_INPUT, "{00FF00}Creación de Evento", "{FF0000}[ERROR]: {FFFFFF}El Nombre debe ser de 5 a 19 Carácteres! \n{BCC3E1}Digite el Nombre del Evento:", "Continuar", "");
			format(NameA, sizeof(NameA), "%s", inputtext);
			EventInfo[NombreE] = NameA;
			ShowPlayerDialog(playerid, DIALOG_DEFINIR, DIALOG_STYLE_MSGBOX, "Creación de Evento", "Elija La posición del Evento", "Aceptar", "");
			return 1;
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_PREMIO1)
	{
	    if(response)
		{
			if(strval(inputtext) < 1 || strval(inputtext) > 100000)	return	ShowPlayerDialog(playerid, DIALOG_PREMIO1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}El Premio debe ser Minimo $1 y Máximo $100000 ! \n{BCC3E1}Digite cual será el Premio para el 1º Lugar:", ">>", "");
			EventInfo[Premio1] = strval(inputtext);
			SendClientMessage(playerid, 0xFF0000AA, "* {FFFFFF}Premio para el 1º Lugar Definido!");
			ShowPlayerDialog(playerid, DIALOG_PREMIO2, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite cual será el Premio para el 2º Lugar:", ">>", "");
			return 1;
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_PREMIO2)
	{
	    if(response)
		{
			if(strval(inputtext) < 1 || strval(inputtext) > 50000)	return	ShowPlayerDialog(playerid, DIALOG_PREMIO2, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}El Premio debe ser Minimo $1 y Máximo $50000 ! \n{BCC3E1}Digite cual será el Premio para el 2º Lugar:", ">>", "");
			EventInfo[Premio2] = strval(inputtext);
			SendClientMessage(playerid, 0xFF0000AA, "* {FFFFFF}Premio para el 2º Lugar Definido!");
			ShowPlayerDialog(playerid, DIALOG_PREMIO3, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite cual será el Premio para el 3º Lugar:", ">>", "");
			return 1;
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_PREMIO3)
	{
	    if(response)
		{
			if(strval(inputtext) < 1 || strval(inputtext) > 25000)	return	ShowPlayerDialog(playerid, DIALOG_PREMIO3, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}El Premio debe ser Minimo $1 y Máximo $25000 ! \n{BCC3E1}Digite cual será el Premio para el 3º Lugar:", ">>", "");
			EventInfo[Premio3] = strval(inputtext);
			SendClientMessage(playerid, 0xFF0000AA, "* {FFFFFF}Premio para el 3º Lugar Definido!");
			ShowPlayerDialog(playerid, DIALOG_PREMIO4, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite cual será la Cantidad de Score para el Ganador:", ">>", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_PREMIO4)
	{
	    if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 100)	return	ShowPlayerDialog(playerid, DIALOG_PREMIO4, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}El Premio debe ser Minimo 1 y Máximo 100 Score ! \n{BCC3E1}Digite cual será la Cantidad de Score para el Ganador:", ">>", "");
			EventInfo[PremioS] = strval(inputtext);
			SendClientMessage(playerid, 0xFF0000AA, "* {FFFFFF}Premio de Score para el Ganador Definido!");
			ShowPlayerDialog(playerid, DIALOG_ABRIREVENTO, DIALOG_STYLE_MSGBOX, "Creación de Evento", "Evento Creado, dale en Aceptar para Comenzar", "Aceptar", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_ARMA)
	{
	    if(response)
		{
		    if(strval(inputtext) == 16 || strval(inputtext) == 18 || strval(inputtext) == 36 || strval(inputtext) == 37 || strval(inputtext) == 39 || strval(inputtext) == 44 || strval(inputtext) == 45) return  SendClientMessage(playerid,COR_ERRO, "[ERROR]: {FFFFFF}No Puedes dar esta Arma!");

			if(strval(inputtext) < 1 || strval(inputtext) > 46)	return	SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}ID de Arma Invalido!");
			EventInfo[eArma] = strval(inputtext);
			ShowPlayerDialog(playerid, DIALOG_MUNICAO, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite las Municiones que deseas dar a los Jugadores del Evento:", "Continuar", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_MUNICAO)
	{
	    if(response)
		{
			if(strval(inputtext) < 1 || strval(inputtext) > 9999) return	ShowPlayerDialog(playerid, DIALOG_MUNICAO, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}El Número Máximo de Balas es de 9999 \n{BCC3E1}Digite las Municiones que deseas dar a los Jugadores del Evento:", "Continuar", "");
			for(new p = 0; p < MAX_PLAYERS; p++)
     		{
            	if(PlayerInfoE[p][NoEvento] == 1)
				{
					GivePlayerWeapon(p, EventInfo[eArma], strval(inputtext));
				}
     		}
			GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "[EVENTO]: El Administrador %s dio una Arma ID %d para todos los Jugadores del Evento!", NombrePlayer, EventInfo[eArma]);
			SendEventMessage(COR_INFO, Format);
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_CARRO)
	{
	    if(response)
		{
			if(strval(inputtext) < 400 && strval(inputtext) != 0 || strval(inputtext) > 611 && strval(inputtext) != 0)	return	SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}ID de vehiculo Inválido!");
			EventInfo[Carro] = strval(inputtext);
			if(strval(inputtext) == 0)
			{
				for(new p = 0; p < MAX_PLAYERS; p++)
				{
					if(PlayerInfoE[p][NoEvento] == 1)
					{
						DestroyVehicle(PlayerInfoE[p][Carro]);
						PlayerInfoE[p][Carro] = 0;
					}
				}
				GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
				format(Format, sizeof(Format), "[EVENTO]: El Administrador %s retiro los Vehículo de todos los Jugadores del Evento!", NombrePlayer);
				SendEventMessage(COR_INFO, Format);
				return 1;
			}
			ShowPlayerDialog(playerid, DIALOG_COR1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite el Primer Color que deseas para los Vehículos:", "Continuar", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_COR1)
	{
	    if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 255)	return	SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}ID de color vehiculo invalido!");
			EventInfo[Cor1] = strval(inputtext);
			ShowPlayerDialog(playerid, DIALOG_COR2, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite el Segundo Color que deseas para los Vehículos:", "Continuar", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_COR2)
	{
	    if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 255)	return	SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}ID de color vehiculo Inválido!");
			EventInfo[Cor2] = strval(inputtext);
			new CarID;
			for(new p = 0; p < MAX_PLAYERS; p++)
     		{
            	if(PlayerInfoE[p][NoEvento] == 1)
				{
					if(PlayerInfoE[p][Carro] >= 1)
					{
						DestroyVehicle(PlayerInfoE[p][Carro]);
						PlayerInfoE[p][Carro] = 0;
					}
					GetPlayerPos(p, PosXx, PosYy, PosZz);
					GetPlayerFacingAngle(p, PosAa);
					CarID = CreateVehicle(EventInfo[Carro], PosXx, PosYy, PosZz, PosAa, EventInfo[Cor1], EventInfo[Cor2], -1);
					LinkVehicleToInterior(CarID, EventInfo[Interior]);
					SetVehicleVirtualWorld(CarID, EventInfo[VirtualWorld]);
					PutPlayerInVehicle(p, CarID, 0);
					PlayerInfoE[p][Carro] = CarID;
				}
     		}
			GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "[EVENTO]: El Administrador %s dio un Vehículo ID %d para todos los Jugadores del Evento!", NombrePlayer, EventInfo[Carro]);
			SendEventMessage(COR_INFO, Format);
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_VIDAVEICULOS)
	{
	    if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 5000) return ShowPlayerDialog(playerid, DIALOG_VIDAVEICULOS, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Use de 0 a 100! \n{BCC3E1}Digite la Vida que deseas definir a los\nVehículos del Evento:", "Definir", "Cancelar");
			for(new p = 0; p < MAX_PLAYERS; p++)
     		{
            	if(PlayerInfoE[p][NoEvento] == 1)
				{
					if(PlayerInfoE[p][Carro] >= 1)
					{
						SetVehicleHealth(PlayerInfoE[p][Carro], strval(inputtext));
					}
				}
     		}
			GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "[EVENTO]: El Administrador %s reseteó la Vida de los Vehículos del Evento a %d", NombrePlayer, strval(inputtext));
			SendEventMessage(COR_INFO, Format);
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_KICK)
	{
	    if(response)
		{
            if (strval(inputtext) == playerid) return SendClientMessage(playerid, COR_ERRO,"[ERROR]: {FFFFFF}No puedes Kickearte a ti mismo.");
			if(!IsPlayerConnected(strval(inputtext))) return SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}Jugador no conectado!");
			if(PlayerInfoE[strval(inputtext)][NoEvento] == 0) return SendClientMessage(playerid, COR_ERRO, "[ERROR]: {FFFFFF}No es posible kickear un Jugador que no está en Evento!");
			new NombrePlayer2[MAX_PLAYER_NAME];
			SetPlayerVirtualWorld(strval(inputtext), 0);
			SetPlayerInterior(strval(inputtext), 0);
			SpawnPlayer(strval(inputtext));
			PlayerInfoE[strval(inputtext)][NoEvento] = 0;
			if(PlayerInfoE[strval(inputtext)][Carro] >= 1)
			{
				DestroyVehicle(PlayerInfoE[strval(inputtext)][Carro]);
				PlayerInfoE[strval(inputtext)][Carro] = 0;
			}
			GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
			GetPlayerName(strval(inputtext), NombrePlayer2, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "[EVENTO]: EL Administrador %s kickeo al Jugador %s del Evento!", NombrePlayer, NombrePlayer2);
			SendEventMessage(COR_INFO, Format);
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_FIM1)
	{
		if(response)
		{
			if(!IsPlayerConnected(strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_FIM1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Jugador no conectado! \n{BCC3E1}Digite la ID del Primer Lugar del Evento:", "Continuar", "");
			GivePlayerMoney(strval(inputtext), EventInfo[Premio1]);
			GetPlayerName(strval(inputtext), NombrePlayer, MAX_PLAYER_NAME);
			SetPlayerScore(strval(inputtext), GetPlayerScore(strval(inputtext)) +EventInfo[PremioS]);
			for(new i = 0;i<7;i++) SendClientMessageToAll(-1,"");
			SendClientMessageToAll(yellow,"[Premios del evento]:");
			format(Format, sizeof(Format), "1º Lugar: {FFFFFF}%s {FFFF00}| $%d | Score [%d]", NombrePlayer, EventInfo[Premio1], EventInfo[PremioS]);
			SendClientMessageToAll(COR_INFO, Format);
			ShowPlayerDialog(playerid, DIALOG_FIM2, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Segundo Lugar del Evento:", "Continuar", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_FIM2)
	{
		if(response)
		{
			if(!IsPlayerConnected(strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_FIM2, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Jugador no conectado! \n{BCC3E1}Digite la ID del Segundo Lugar del Evento:", "Continuar", "");
			GivePlayerMoney(strval(inputtext), EventInfo[Premio2]);
			GetPlayerName(strval(inputtext), NombrePlayer, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "2º Lugar: {FFFFFF}%s {FFFF00}| Dinero [$%d]", NombrePlayer, EventInfo[Premio2]);
			SendClientMessageToAll(COR_INFO, Format);
			ShowPlayerDialog(playerid, DIALOG_FIM3, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite la ID del Tercer Lugar del Evento:", "Continuar", "");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_FIM3)
	{
		if(response)
		{
			if(!IsPlayerConnected(strval(inputtext))) return ShowPlayerDialog(playerid, DIALOG_FIM3, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Jugador no conectado! \n{BCC3E1}Digite la ID del Tercer Lugar del Evento:", "Continuar", "");
			GivePlayerMoney(strval(inputtext), EventInfo[Premio3]);
			GetPlayerName(strval(inputtext), NombrePlayer, MAX_PLAYER_NAME);
		    format(Format, sizeof(Format), "3º Lugar: {FFFFFF}%s {FFFF00}| Dinero [$%d]", NombrePlayer, EventInfo[Premio3]);
			SendClientMessageToAll(COR_INFO, Format);
			SetPlayerVirtualWorld(playerid, 0);
			DestruirEvento(playerid);
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_VIDA)
	{
	    if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 2000) return	ShowPlayerDialog(playerid, DIALOG_VIDA, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Use de 0 a 2000! \n{BCC3E1}Digite la Vida que deseas definir a los\nJugadores del Evento", "Definir", "Cancelar");
			EventInfo[Vida] = strval(inputtext);
			ShowPlayerDialog(playerid, DIALOG_COLETE, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "Digite el Chaleco que deseas definir a los\nJugadores del Evento", "Definir", "Cancelar");
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_COLETE)
	{
	    if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 2000) return	ShowPlayerDialog(playerid, DIALOG_COLETE, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Use de 0 a 2000! \n{BCC3E1}Digite el Chaleco que deseas definir a los\nJugadores del Evento", "Definir", "Cancelar");
			for(new p = 0; p < MAX_PLAYERS; p++)
     		{
            	if(PlayerInfoE[p][NoEvento] == 1)
				{
					SetPlayerHealth(p, EventInfo[Vida]);
					SetPlayerArmour(p, strval(inputtext));
				}
     		}
			GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "[EVENTO]: El Administrador %s definio la vida a los Jugadores del Evento con %d y de Chaleco con %d", NombrePlayer, EventInfo[Vida], strval(inputtext));
			SendEventMessage(COR_INFO, Format);
		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_SKIN1)
	{
		if(response)
		{
			if(strval(inputtext) < 0 || strval(inputtext) > 200) return	ShowPlayerDialog(playerid, DIALOG_SKIN1, DIALOG_STYLE_INPUT, "{00FF00}Definiciones de Evento", "{FF0000}[ERROR]: {FFFFFF}Use de 0 a 200! \n{BCC3E1}Digite la ID del Skin que deseas\naplicar a los Jugadores del Evento:", "Definir", "Cancelar");
			for(new p = 0; p < MAX_PLAYERS; p++)
     		{
            	if(PlayerInfoE[p][NoEvento] == 1)
				{
					SetPlayerSkin(p, strval(inputtext));
				}
     		}
			GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
			format(Format, sizeof(Format), "[EVENTO]: EL Administrador %s definio el Skin a los Jugadores del Evento con el ID: %d", NombrePlayer, strval(inputtext));
			SendEventMessage(COR_INFO, Format);
		}
		return 1;
	}
    //--------------------------------------------------------------------------
	if(dialogid == DIALOG_ABRIREVENTO)
	{
		if(response)
		{
			EventInfo[Criado] = 1;
			EventInfo[Aberto] = 1;
			EventInfo[Cerrado] = 0;
			SetPlayerVirtualWorld(playerid, EventInfo[VirtualWorld]);
			SetPlayerInterior(playerid, EventInfo[Interior]);
			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 100);
			GetPlayerName(playerid, NombrePlayer, sizeof(NombrePlayer));
			new StrA[64];
			format(StrA, sizeof(StrA), "%s", NombrePlayer);
			EventInfo[Admin] = StrA;
			for(new i = 0;i<5;i++) SendClientMessageToAll(-1,"");
			format(Format, sizeof Format, "[NUEVO EVENTO]: {FFFFFF}%s {00FFFF}abrio un nuevo evento! Usa {A8F93E}/EJOIN.", NombrePlayer);
			SendClientMessageToAll(0x00FFFFFF, Format);
			//=====================================================
			format(Format, sizeof(Format), "Nombre: {FFFFFF}%s {FFFF00}| Premio para el 1º Lugar: {FFFFFF}$%d + %d de Score", EventInfo[NombreE], EventInfo[Premio1], EventInfo[PremioS]);
			SendClientMessageToAll(0xFFFF00FF, Format);
			format(Format, sizeof(Format), "Premio para el 2º Lugar: {FFFFFF}$%d {FFFF00}| Premio para el 3º Lugar: {FFFFFF}$%d",EventInfo[Premio2], EventInfo[Premio3]);
		    SendClientMessageToAll(0xFFFF00FF, Format);
			CountAmountEvento = 60;
			CountTimerEvento = SetTimer("CountTillEvento", 999, 1);

		}
		return 1;
	}
	//--------------------------------------------------------------------------
	if(dialogid == DIALOG_LUGARESEZ)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					SetPlayerPos(playerid,387.4625,171.7353,1008.3828);
					SetPlayerInterior(playerid,3);
					SetPlayerVirtualWorld(playerid,0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Escondidas{FFFFFF}'.");
				}
				case 1:
				{
					SetPlayerPos(playerid,1539.8459,-2579.8042,13.5469);
					SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid,0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Avión de la muerte{FFFFFF}'.");
				}
				case 2:
				{
					SetPlayerPos(playerid,296.2429,-1612.6998,114.4219);
					SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid,0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Avión tumbador{FFFFFF}'.");
				}
				case 3:
				{
					SetPlayerPos(playerid,-1399.1525, 1252.1205, 1040.1183);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid, 16);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Rhino VS Kart{FFFFFF}'.");
				}
				case 4:
				{
					SetPlayerPos(playerid,509.2815,-72.9995,998.7578);
					SetPlayerInterior(playerid,11);
					SetPlayerVirtualWorld(playerid, 0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Pelea de borrachos{FFFFFF}'.");
				}
				case 5:
				{
					SetPlayerPos(playerid,1330.9161,2141.4485,11.0156);
					SetPlayerInterior(playerid,0);
					SetPlayerVirtualWorld(playerid, 0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}DM{FFFFFF}'.");
				}
				case 6:
				{
					SetPlayerPos(playerid, 1417.3047,-47.5880,1000.9293);
					SetPlayerInterior(playerid,1);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}DM a DK{FFFFFF}'.");
				}
				case 7:
				{
					SetPlayerPos(playerid,-1399.1525, 1252.1205, 1040.1183);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid, 16);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Rocket VS NRG-500{FFFFFF}'.");
				}
				case 8:
				{
					SetPlayerPos(playerid,1670.0000,-1266.0000,233.3750);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid,0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Torre Terrorista{FFFFFF}'.");
				}
				case 9:
				{
					SetPlayerPos(playerid,776.1259,-49.1077,1000.5859);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid,6);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}DM a Katanas{FFFFFF}'.");
				}
				case 10:
				{
					SetPlayerPos(playerid,-1004.4861,946.8848,34.5781);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid,0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Carrera a pie{FFFFFF}'.");
				}
				case 11:
				{
					SetPlayerPos(playerid,1106.8707,1529.8383,52.4007);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerInterior(playerid,0);
					SendClientMessage(playerid,0x33FF33AA,"* {FFFFFF}Bienvenido, acá puedes realizar el evento de '{FFFF00}Autos chocadores{FFFFFF}'.");
				}
			}
		}
		return 1;
	}
	
	
	return 1;
}
//------------------------------------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
    if(PlayerInfoE[playerid][NoEvento] == 1)
	{
		PlayerInfoE[playerid][NoEvento] = 0;
		SendClientMessage(playerid,COLOR_YELLOW,"[EVENTO]: Has muerto y por lo tanto fuiste sacado del evento.");
	}
    return 1;
}
//------------------------------------------------------------------------------
CMD:cevento(playerid,params[])
{
	#pragma unused params
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,0xFF0000AA,"* Error: No tienes permiso para esto");
	//--------------------------------------------------------------------------
	new Mensagem[603];
	strcat(Mensagem, "Crear Evento\nIr a la Posicion del Evento\n");
	strcat(Mensagem, "Dar Armas para todos los jugadores del Evento\nDar un Carro para todos los jugadores del Evento\nDestruir/Finalizar Evento\nDefinir Vida a los Vehiculos del Evento\nKickear a un jugador del Evento\n");
	strcat(Mensagem, "Definir Vida y Chaleco a los jugadores del Evento\nDefinir Skin a los jugadores del Evento\nCongelar a los jugadores del Evento\nDescongelar a los jugadores del Evento\nResetear Armas a los jugadores del Evento\nTraer a Todos los jugadores del evento");
	if(EventInfo[Criado] == 0)
	{
		ShowPlayerDialog(playerid, DIALOG_EVENTO, DIALOG_STYLE_LIST, "{00FF00}Evento Propio: {FF0000}Cerrado", Mensagem, "Seleccionar", "Cancelar");
	}
	else if(EventInfo[Criado] == 1)
	{
		new StrE[1000];
		format(StrE,sizeof(StrE),"{00FF00}Evento Propio: {FFFFFF}Abierto por %s",EventInfo[Admin]);
		ShowPlayerDialog(playerid, DIALOG_EVENTO, DIALOG_STYLE_LIST, StrE, Mensagem, "Seleccionar", "Cancelar");
	}
	return 1;
}
//------------------------------------------------------------------------------
CMD:usersev(playerid, params[])
{
	#pragma unused params
	new conteo, surviva[400],texto[250];
	for(new i = 0; i < MAX_PLAYERS; i++) if(IsPlayerConnected(i))
	{
		if(PlayerInfoE[i][NoEvento] == 1)
		{
			conteo++;
		}
	}
	if(conteo == 0) return ShowPlayerDialog(playerid, 279, DIALOG_STYLE_MSGBOX, "- Usuarios en Evento", "{FFFFFF}No hay usuarios en el evento!", "Salir", "");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfoE[i][NoEvento] == 1)
		{
			format(texto,sizeof(texto),"{%06x}%s [ID: %d]\n",GetPlayerColor(i) >>> 8,pNameXZ(i),i);
			strcat(surviva,texto);
		}
	}
	ShowPlayerDialog(playerid,279,DIALOG_STYLE_MSGBOX,"- Usuarios en Evento",surviva,"Salir","");
	return 1;
}
//------------------------------------------------------------------------------
CMD:ejoin(playerid,params[])
{
	#pragma unused params
	if(EventInfo[Cerrado] == 1) return SendClientMessage(playerid, COR_ERRO, "* El evento ya ha cerrado!");
	if(EventInfo[Criado] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* No existe ningún Evento creado!");
	if(EventInfo[Aberto] == 0)	return	SendClientMessage(playerid, COR_ERRO, "* El Evento esta iniciado!");
	if(PlayerInfoE[playerid][NoEvento] == 1) return SendClientMessage(playerid, COR_ERRO, "* Error: Ya estas en el Evento!");
	SetPlayerVirtualWorld(playerid, EventInfo[VirtualWorld]);
	SetPlayerInterior(playerid, EventInfo[Interior]);
	SetPlayerHealth(playerid, 100);
	SetPlayerArmour(playerid, 100);
	ResetPlayerWeapons(playerid);
	SetPlayerPos(playerid, EventInfo[Xq], EventInfo[Yq], EventInfo[Zq]);
	SetPlayerFacingAngle(playerid, EventInfo[Aq]);
	new string2[100];
	format(string2, sizeof(string2), "[Evento]: {FFFFFF}%s {FF9900}ingresó al evento {FFFFFF}'%s'!", pNameXZ(playerid),EventInfo[NombreE]);
	SendClientMessageToAll(0xFF9900FF,string2);
	PlayerInfoE[playerid][NoEvento] = 1;
	return 1;
}
//------------------------------------------------------------------------------
CMD:salirevento(playerid,params[])
{
	#pragma unused params
	if(PlayerInfoE[playerid][NoEvento] == 0) return SendClientMessage(playerid, COR_ERRO, "* No estás en el Evento!");
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SpawnPlayer(playerid);
	PlayerInfoE[playerid][NoEvento] = 0;
	if(PlayerInfoE[playerid][Carro] >= 1)
	{
		DestroyVehicle(PlayerInfoE[playerid][Carro]);
		PlayerInfoE[playerid][Carro] = 0;
	}
	SendClientMessage(playerid, COR_INFO, "* Has salido del Evento!");
	return 1;
}
//------------------------------------------------------------------------------
CMD:evsay(playerid, params[])
{
    if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COR_ERRO, "* Error: No tienes permiso para esto");
    if(EventInfo[Criado] == 0)  return  SendClientMessage(playerid, COR_ERRO, "* Error: No existe ningun evento creado!");
    if(PlayerInfoE[playerid][NoEvento] == 0) return SendClientMessage(playerid, COR_ERRO, "* Error: No estas en el evento!");
    new Mensagem[128];
    if(sscanf(params, "s[128]", Mensagem)) return SendClientMessage(playerid, COR_ERRO, "* Usa: /evsay [Mensaje]");
    format(Format, sizeof(Format), "* [EVENTO] %s: {FFFFFF}%s", pNameXZ(playerid), Mensagem);
    SendEventMessage(COR_INFO, Format);
    return 1;
}
//------------------------------------------------------------------------------
CMD:lugarese(playerid, params[])
{
	#pragma unused params
	if(IsPlayerAdmin(playerid))
	{
		new string2[200];
		strcat(string2, "Escondidas\n");
		strcat(string2, "Avión de la muerte\n");
		strcat(string2, "Avion tumbador\n");
		strcat(string2, "Rhino vs Kart\n");
		strcat(string2, "Peleas de borrachos\n");
		strcat(string2, "DM (Cancha libre)\n");
		strcat(string2, "DM a DK (En desmadre)\n");
		strcat(string2, "Rocket VS NRG-500\n");
		strcat(string2, "Torre Terrorista\n");
		strcat(string2, "Dm a Katanas\n");
		strcat(string2, "Carrera a pie\n");
		strcat(string2, "Autos chocadores");
		ShowPlayerDialog(playerid, DIALOG_LUGARESEZ, DIALOG_STYLE_LIST, "{FFAF00}EV {CCCCCC}- Lugares para eventos", string2, "Seleccionar", "Cancelar");
		return 1;
	}
	else return SendClientMessage(playerid,0xFF0000AA,"* Error: No tienes permiso para esto");
}

//==============================================================================
forward CountTillEvento(playerid);
public CountTillEvento(playerid)
{
	if(CountAmountEvento == 0)
	{
		EventInfo[Cerrado] = 1;
		KillTimer(CountTimerEvento);
		for(new p = 0; p < MAX_PLAYERS; p++)
		{
			if(IsPlayerConnected(p))
			{
			    if(PlayerInfoE[p][NoEvento] == 0)
			    {
			    	new string2[100];
					format(string2,sizeof(string2), "* El evento ya ha cerrado!");
					SendClientMessage(p,0xFF0000AA, string2);
				}
			}
		}
	}
	return CountAmountEvento--;
}
//==============================================================================
stock DestruirEvento(playerid)
{
	EventInfo[Xq] = 0;
	EventInfo[Yq] = 0;
	EventInfo[Zq] = 0;
	EventInfo[Aq] = 0;
	EventInfo[VirtualWorld] = 0;
	EventInfo[Interior] = 0;
	EventInfo[Criado] = 0;
	EventInfo[Aberto] = 0;
	EventInfo[Cerrado] = 0;
	EventInfo[Premio1] = 0;
	EventInfo[Premio2] = 0;
	EventInfo[Premio3] = 0;
	EventInfo[Carro] = 0;
	EventInfo[Cor1] = 0;
	EventInfo[Cor2] = 0;
	EventInfo[eArma] = 0;
	EventInfo[Vida] = 0;
	for(new p = 0; p < MAX_PLAYERS; p++)
    {
       	if(PlayerInfoE[p][NoEvento] == 1)
		{
			SetPlayerVirtualWorld(p, 0);
			SetPlayerInterior(p, 0);
			SpawnPlayer(p);
			PlayerInfoE[p][NoEvento] = 0;
			if(PlayerInfoE[p][Carro] >= 1)
			{
				DestroyVehicle(PlayerInfoE[p][Carro]);
				PlayerInfoE[p][Carro] = 0;
			}
		}
    }
	GetPlayerName(playerid, NombrePlayer, MAX_PLAYER_NAME);
	format(Format, sizeof(Format), "[EVENTO]: %s entrego los premios y cerro el evento.", NombrePlayer);
	SendClientMessageToAll(COLOR_AMARILLO, Format);
	return 1;
}
//------------------------------------------------------------------------------
stock SendEventMessage(color, string[])
{
	for(new p = 0; p < MAX_PLAYERS; p++)
	{
		if(IsPlayerConnected(p))
		{
		    if(PlayerInfoE[p][NoEvento] == 1)
		    {
				SendClientMessage(p, color, string);
			}
		}
	}
	return 1;
}
//------------------------------------------------------------------------------
stock pNameXZ(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, sizeof(name));
  return name;
}
