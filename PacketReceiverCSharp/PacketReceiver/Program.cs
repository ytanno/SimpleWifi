using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Net.Sockets;
using System.IO.Ports;

//ref http://stackoverflow.com/questions/1119841/net-console-application-exit-event
//ref http://stackoverflow.com/questions/12864999/sending-and-receiving-udp-packets

namespace PacketReceiver
{
	class Program
	{
		static SerialPort sp = new SerialPort();
		static void Main(string[] args)
		{
			//if exit
			AppDomain.CurrentDomain.ProcessExit += (sss, eee) => { if(sp.IsOpen) sp.Close(); };

			//set serial 
			sp.BaudRate = 9600;
			sp.PortName = "COM4"; //update yourself 
			sp.RtsEnable = true;

			//set network
			int receivePort = 33033; //update yourself 
			IPEndPoint ServerEndPoint = new IPEndPoint(IPAddress.Any, receivePort);
			Socket WinSocket = new Socket(AddressFamily.InterNetwork, SocketType.Dgram, ProtocolType.Udp);
			WinSocket.Bind(ServerEndPoint);

			//Console.Write("Waiting for client");
			IPEndPoint sender = new IPEndPoint(IPAddress.Any, 0);
			EndPoint Remote = (EndPoint)(sender);
			byte[] data = new byte[255];

			var before = DateTime.Now;

			sp.Open();
			while (true)
			{
				//receive wifi
				int recv = WinSocket.ReceiveFrom(data, ref Remote);
				var v = Encoding.ASCII.GetString(data, 0, recv);
				Console.WriteLine(Remote.ToString() + " " + v);

				//write serial
				sp.Write(v);
			}
			sp.Close();
		}
	}
}
