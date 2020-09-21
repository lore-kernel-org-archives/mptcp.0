Content-Type: multipart/mixed; boundary="===============7221652103566437976=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Mon, 21 Sep 2020 17:15:56 +0200
Message-ID: <ef95c4e2-37ee-bb77-0472-9fd7e805eecb@tessares.net>
In-Reply-To: 20200921145759.1302197-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5965

--===============7221652103566437976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi David, Jakub,

On 21/09/2020 16:57, Matthieu Baerts wrote:
> From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> =

> When receiving a DATA_FIN MPTCP option on a TCP FIN packet, the DATA_FIN
> information would be stored but the MPTCP worker did not get
> scheduled. In turn, the MPTCP socket state would remain in
> TCP_ESTABLISHED and no blocked operations would be awakened.
> =

> TCP FIN packets are seen by the MPTCP socket when moving skbs out of the
> subflow receive queues, so schedule the MPTCP worker when a skb with
> DATA_FIN but no data payload is moved from a subflow queue. Other cases
> (DATA_FIN on a bare TCP ACK or on a packet with data payload) are
> already handled.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/84
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")

A small mistake from my side, this patch is for -net and not net-next :/

Sorry, with these 3 patches with the same code, it really looks like we =

don't want to have this patch sent properly :)
I can resend a v4 with the proper subject if you prefer.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7221652103566437976==--
