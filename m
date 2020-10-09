Content-Type: multipart/mixed; boundary="===============4358862217182426817=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: fix infinite loop on
 recvmsg()/worker() race.
Date: Thu, 08 Oct 2020 17:28:23 -0700
Message-ID: <20201008172823.3e1ea388@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 5a2464d778499bdc2ced43b56569008030b470bc.1601965539.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6262

--===============4358862217182426817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue,  6 Oct 2020 08:27:34 +0200 Paolo Abeni wrote:
> If recvmsg() and the workqueue race to dequeue the data
> pending on some subflow, the current mapping for such
> subflow covers several skbs and some of them have not
> reached yet the received, either the worker or recvmsg()
> can find a subflow with the data_avail flag set - since
> the current mapping is valid and in sequence - but no
> skbs in the receive queue - since the other entity just
> processed them.
> =

> The above will lead to an unbounded loop in __mptcp_move_skbs()
> and a subsequent hang of any task trying to acquiring the msk
> socket lock.
> =

> This change addresses the issue stopping the __mptcp_move_skbs()
> loop as soon as we detect the above race (empty receive queue
> with data_avail set).

Applied, thanks!
--===============4358862217182426817==--
