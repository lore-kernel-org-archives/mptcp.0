Content-Type: multipart/mixed; boundary="===============5235747716982820540=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Wed, 28 Jun 2017 12:13:27 -0700
Message-ID: <b75ffc25-0b9d-0b2b-0794-7abaf64aa14e@oracle.com>
In-Reply-To: 20170628045317.GA2728@da0602a-dhcp200.apple.com
X-Status: 
X-Keywords:                  
X-UID: 61

--===============5235747716982820540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,


On 06/27/2017 09:53 PM, Christoph Paasch wrote:
>
> There are several reasons why such a packet might not make it up to the
> receive-queue. For example:
>
> * tcp_receive_window() returns 0
> * the sequence-number of the ack-packet is not the rcv_nxt. Then it goes
>    into the ofo-queue. Which is why we had to add tests for mptcp() in
>    tcp_data_queue_ofo() to handle DATA_FINs.
> * tcp_try_rmem_schedule() returns false
>
> Such kind of conditions will make that the signal from the peer (DATA_ACK,
> ADD_ADDR,...) does not reach the MPTCP-stack. But these signals should be
> delivered to the stack as reliably as possible.
>
>
> What if we rather use the error-queue for these signalling skbs? The
> error-queue has already been "abused" for tx-timestamps,... so this might=
 be
> a good place to put this information. I think that would be cleaner.
>
>
> Christoph
>
Thanks for elaborating. Now I understand. Your concern is not the zero =

length but the general constraints with queuing. Yes, the current =

implementation does not bypass those constraints. It treats pure ack as =

a zero length data packet. If this is an issue with MPTCP the fix is =

very straight forward, in fact I want to make that change, In =

tcp_data_queue() where we check if the packet is a pure ack and make =

decision to deliver it if the socket is an  MPTCP we can just call =

sk_data_ready . An architecturally correct solution would be to have a =

another socket specific function to deal with non data packets and =

remove checks for mptcp.

The goal is to (When possible) not do any MPTCP parsing/processing till  =

TCP processing is done and the packet is handed off to MPTCP. This makes =

the code look cleaner and less intrusive. Which is the biggest complain =

that the upstream folks have. They are not concerned what we do in the =

MPTCP code.

Rao


--===============5235747716982820540==--
