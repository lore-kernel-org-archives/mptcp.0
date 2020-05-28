Content-Type: multipart/mixed; boundary="===============2175540080087180110=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 2/2] mptcp: add receive buffer
 auto-tuning
Date: Thu, 28 May 2020 19:40:19 +0200
Message-ID: <20200528174019.GM2915@breakpoint.cc>
In-Reply-To: 20200528162630.GD64606@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4534

--===============2175540080087180110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Christoph Paasch <cpaasch(a)apple.com> wrote:
> Hello,
> =

> On 05/28/20 - 15:02, Florian Westphal wrote:
> > When mptcp is used, userspace doesn't read from the tcp (subflow)
> > socket but from the parent (mptcp) socket receive queue.
> > =

> > skbs are moved from the subflow socket to the mptcp rx queue either from
> > 'data_ready' callback (if mptcp socket can be locked), a work queue, or
> > the socket receive function.
> > =

> > This means tcp_rcv_space_adjust() is never called and thus no receive
> > buffer size auto-tuning is done.
> > =

> > An earlier (not merged) patch added tcp_rcv_space_adjust() calls to the
> > function that moves skbs from subflow to mptcp socket.
> > While this enabled autotuning, it also meant tuning was done even if
> > userspace was reading the mptcp socket very slowly.
> > =

> > This adds mptcp_rcv_space_adjust() and calls it after userspace has
> > read data from the mptcp socket rx queue.
> > =

> > Its very similar to tcp_rcv_space_adjust, with two differences:
> > =

> > 1. The rtt estimate is the largest one observed on a subflow
> > 2. The rcvbuf size and window clamp of all subflows is adjusted
> >    to the mptcp-level rcvbuf.
> > =

> > Otherwise, we get spurious drops at tcp (subflow) socket level if
> > the skbs are not moved to the mptcp socket fast enough and reduced
> > throughput..
> > =

> > Before:
> > time mptcp_connect.sh -t -f $((4*1024*1024)) -d 300 -l 0.01% -r 0 -e ""=
 -m mmap
> > [..]
> > ns4 MPTCP -> ns3 (10.0.3.2:10108      ) MPTCP   (duration 40562ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (10.0.3.2:10109      ) TCP     (duration  5415ms) [ OK=
 ]
> > ns4 TCP   -> ns3 (10.0.3.2:10110      ) MPTCP   (duration  5413ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (dead:beef:3::2:10111) MPTCP   (duration 41331ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (dead:beef:3::2:10112) TCP     (duration  5415ms) [ OK=
 ]
> > ns4 TCP   -> ns3 (dead:beef:3::2:10113) MPTCP   (duration  5714ms) [ OK=
 ]
> > Time: 846 seconds
> > =

> > After:
> > ns4 MPTCP -> ns3 (10.0.3.2:10108      ) MPTCP   (duration  5417ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (10.0.3.2:10109      ) TCP     (duration  5429ms) [ OK=
 ]
> > ns4 TCP   -> ns3 (10.0.3.2:10110      ) MPTCP   (duration  5418ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (dead:beef:3::2:10111) MPTCP   (duration  5423ms) [ OK=
 ]
> > ns4 MPTCP -> ns3 (dead:beef:3::2:10112) TCP     (duration  5715ms) [ OK=
 ]
> > ns4 TCP   -> ns3 (dead:beef:3::2:10113) MPTCP   (duration  5415ms) [ OK=
 ]
> > Time: 275 seconds
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> > ---
> >  net/mptcp/protocol.c | 117 ++++++++++++++++++++++++++++++++++++++++---
> >  net/mptcp/protocol.h |   6 +++
> >  2 files changed, 116 insertions(+), 7 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index b2c8b57e7942..7c1b50ee751b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -207,13 +207,6 @@ static bool __mptcp_move_skbs_from_subflow(struct =
mptcp_sock *msk,
> >  		return false;
> >  	}
> >  =

> > -	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> > -		int rcvbuf =3D max(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> > -
> > -		if (rcvbuf > sk->sk_rcvbuf)
> > -			sk->sk_rcvbuf =3D rcvbuf;
> > -	}
> > -
> >  	tp =3D tcp_sk(ssk);
> >  	do {
> >  		u32 map_remaining, offset;
> > @@ -928,6 +921,95 @@ static int __mptcp_recvmsg_mskq(struct mptcp_sock =
*msk,
> >  	return copied;
> >  }
> >  =

> > +/* receive buffer autotuning.  See tcp_rcv_space_adjust for more infor=
mation.
> > + *
> > + * Only difference: Use highest rtt estimate of the subflows in use.
> > + */
> > +static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
> =

> Overall, I think this is the right way to go, but I'm a bit confused by t=
he
> logic here.
> =

> It seems that rcvq_space.copied is a cumulative counter of the number of =
bytes copied
> to user during this measurement period (in TCP-terms copied_seq - rcvq_sp=
ace.seq).
> =

> So, it seems to me like rcvq_space.seq is not needed (?).
> The substraction further below (msk->rcvq_space.copied - msk->rcvq_space.=
seq) seems
> to be giving rather the increment compared to the previous measurement.

> > +	msk->rcvq_space.copied +=3D copied;

This is the number of bytes copied to user so far.

> > +	mstamp =3D div_u64(tcp_clock_ns(), NSEC_PER_USEC);
> > +
> > +	time =3D tcp_stamp_us_delta(mstamp, msk->rcvq_space.time);
> > +	if (time < (rtt_us >> 3) || rtt_us =3D=3D 0)
> > +		return;
> > +
> > +	copied =3D msk->rcvq_space.copied - msk->rcvq_space.seq;

This is what we copied to user in THIS window.

> > +	if (copied <=3D msk->rcvq_space.space)
> > +		goto new_measure;

If thats true, we copied less than during the last time rcvbuf was
adjusted.

If false, we consumed more and should consider rcvbuf increase.

> > +	if (sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf &&
> > +	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
> > +		int rcvmem, rcvbuf;
> > +		u64 rcvwin, grow;
> > +
> > +		rcvwin =3D ((u64)copied << 1) + 16 * advmss;
> > +
> > +		grow =3D rcvwin * (copied - msk->rcvq_space.space);
> > +		do_div(grow, msk->rcvq_space.space);
> > +		rcvwin +=3D (grow << 1);
> > +
> > +		rcvmem =3D SKB_TRUESIZE(advmss + MAX_TCP_HEADER);
> > +		while (tcp_win_from_space(sk, rcvmem) < advmss)
> > +			rcvmem +=3D 128;
> > +
> > +		do_div(rcvwin, advmss);
> > +		rcvbuf =3D min_t(u64, rcvwin * rcvmem,
> > +			       sock_net(sk)->ipv4.sysctl_tcp_rmem[2]);
> > +
> > +		if (rcvbuf > sk->sk_rcvbuf) {
> > +			u32 window_clamp;
> > +
> > +			window_clamp =3D tcp_win_from_space(sk, rcvbuf);
> > +			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
> > +
> > +			/* Make subflows follow along.  If we do not do this, we
> > +			 * get drops at subflow level if skbs can't be moved to
> > +			 * the mptcp rx queue fast enough (announced rcv_win can
> > +			 * exceed ssk->sk_rcvbuf).
> > +			 */
> > +			mptcp_for_each_subflow(msk, subflow) {
> > +				struct sock *ssk;
> > +
> > +				ssk =3D mptcp_subflow_tcp_sock(subflow);
> > +				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
> > +				tcp_sk(ssk)->window_clamp =3D window_clamp;
> > +			}
> > +		}
> > +	}
> > +
> > +	msk->rcvq_space.space =3D copied;
> > +new_measure:
> > +	msk->rcvq_space.seq =3D msk->rcvq_space.copied;
> > +	msk->rcvq_space.time =3D mstamp;
> > +}

I think this could be simplified a little:

1. instead of incrementing space.copied forever, do this after
rcvbuf increase:

	msk->rcvq_space.space =3D msk->rcvq_space.copied;
new_measure:
        msk->rcvq_space.copied =3D 0;
	msk->rcvq_space.time =3D mstamp;
}

So: msk->rcvq_space.space becomes to number of bytes consumed the last
time we adjusted the rcvbuf.

space.copied would hold the number of bytes copied to user during the
new measurement period.

space.seq would become unneeded, instead of

copied =3D msk->rcvq_space.copied - msk->rcvq_space.seq;
if (copied <=3D msk->rcvq_space.space)
   goto new_measure;

test: msk->rcvq_space.copied <=3D msk->rcvq_space.space

Is that what you had in mind?
--===============2175540080087180110==--
