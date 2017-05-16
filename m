Content-Type: multipart/mixed; boundary="===============6108429206793634809=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Separating MPTCP packet processing from TCP
Date: Mon, 15 May 2017 18:16:36 -0700
Message-ID: <f7203ed5-0457-124f-e649-7069c1bc3354@oracle.com>
X-Status: 
X-Keywords:                  
X-UID: 31

--===============6108429206793634809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am thinking the cleanest implementation would be to separate MPTCP =

processing from TCP. On the receive side, when a packet arrives TCP only =

does TCP processing (That leaves the code untouched), the packet is than =

passed upto MPTCP which does MPTCP processing and can either process the =

packet, drop it or send a reset.

The current implementation is doing receive processing in TCP because it =

wants to validate the packet and accept it in TCP  or not -- but why ? =

that seems to be an implementation choice.

In the case where the receiver drops the packet in MPTCP, no data ack =

will be sent and MPTCP will re-transmit, It can retransmit even on the =

same flow. To achieve this the code requires some change as the DSS =

option has to be saved. I think this is doable and is a much cleaner =

solution.

Similarly we need to think about the Tx side -- That is not so straight =

forward but we need to think harder.

I can work on making the Rx changes but want to discuss it in case I am =

missing potential issues and if this is not a got option.

Comments  ?

Rao


--===============6108429206793634809==
Content-Type: message/rfc822
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="AttachedMessage.mht"

WzxlbWFpbC5tZXNzYWdlLk1lc3NhZ2UgaW5zdGFuY2UgYXQgMHg3ZjJkNDc1YTE5OTg+XQ==
--===============6108429206793634809==--
