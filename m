Content-Type: multipart/mixed; boundary="===============0825548016912313279=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 4/5] mptcp: update mptcp ack sequence from work queue
Date: Mon, 17 Feb 2020 10:27:18 -0800
Message-ID: <20200217182718.GC4028@MacBook-Pro-64.local>
In-Reply-To: 060467ab4233809bfddca67c69b05d5c2848a6da.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3677

--===============0825548016912313279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 17/02/20 - 09:40:10, Paolo Abeni wrote:
> On Fri, 2020-02-14 at 17:39 -0800, Mat Martineau wrote:
> > On Thu, 13 Feb 2020, Paolo Abeni wrote:
> > =

> > > On Thu, 2020-02-13 at 11:27 +0100, Florian Westphal wrote:
> > > > +static void __mptcp_move_skbs(struct mptcp_sock *msk)
> > > > +{
> > > > +	struct mptcp_steal_arg arg =3D {
> > > > +		.msk =3D msk,
> > > > +		.fin =3D false,
> > > > +	};
> > > > +	read_descriptor_t desc =3D {
> > > > +		.arg.data =3D &arg,
> > > > +	};
> > > > +
> > > > +	for (;;) {
> > > > +		struct mptcp_subflow_context *subflow;
> > > > +		bool more_data_avail;
> > > > +
> > > > +		arg.ssk =3D mptcp_subflow_recv_lookup(msk);
> > > > +		if (!arg.ssk)
> > > > +			break;
> > > > +
> > > > +		subflow =3D mptcp_subflow_ctx(arg.ssk);
> > > > +
> > > > +		lock_sock(arg.ssk);
> > > > +
> > > > +		do {
> > > > +			u32 map_remaining;
> > > > +			int bytes_read;
> > > > +
> > > > +			/* try to read as much data as available */
> > > > +			map_remaining =3D subflow->map_data_len -
> > > > +					mptcp_subflow_get_map_offset(subflow);
> > > > +			desc.count =3D map_remaining;
> > > > +
> > > > +			bytes_read =3D tcp_read_sock(arg.ssk, &desc, mptcp_steal_actor);
> > > > +			if (bytes_read <=3D 0) {
> > > > +				release_sock(arg.ssk);
> > > > +				return;
> > > > +			}
> > > > +
> > > > +			if (arg.fin) {
> > > > +				struct tcp_sock *tp =3D tcp_sk(arg.ssk);
> > > > +				u32 seq =3D READ_ONCE(tp->copied_seq);
> > > > +
> > > > +				WRITE_ONCE(tp->copied_seq, seq + 1);
> > > > +			}
> > > > +
> > > > +			more_data_avail =3D mptcp_subflow_data_available(arg.ssk);
> > > > +		} while (more_data_avail);
> > > > +
> > > > +		release_sock(arg.ssk);
> > > > +	}
> > > > +}
> > > =

> > > Overall the above move the pending skbs to the msk receive queue,
> > > increment ssk copied_seq and eventually let TCP send ack via
> > > tcp_cleanup_rbuf().
> > > =

> > =

> > It's only moving in-order skbs, right?
> > =

> > > I think we could avoid touching tcp_read_sock() in patch 2/5 moving t=
he
> > > skb directly from __mptcp_move_skbs() - no call to tcp_read_sock(),
> > > just queue manipulation and copied_seq accounting.
> > > =

> > > Than __mptcp_move_skbs() will call directly, as needed - need to expo=
rt
> > > it.
> > =

> > This makes sense to me. We have to do another layer of reassembly for =

> > MPTCP and we already know the skbs are in-order for the subflow stream, =

> > and there's no need to handle partial skb reads like tcp_read_sock does.
> > =

> > > We could additionally clean-up the code calling __mptcp_move_skbs()
> > > from mptcp_recvmsg() before looking into the msk receive queue. Than =
no
> > > need for the current recvmsg inner loop.
> > > =

> > > I fear we need some tweek to handle TCP fallback. If I read the RFC
> > > correctly the msk can fallback to TCP even after receiving some DSS
> > > data (e.g. msk receive queue contains some skbs and the msk fallback =
to
> > > TCP. We can't call anymore sock_recvmsg())
> > =

> > RFC 8684 section 3.7 (Fallback) says that "If a subflow breaks during =

> > operation... the subflow SHOULD be treated as broken and closed with a =

> > RST". Does that cover your concern, or are you referring to a fallback =
at =

> > connection time?
> =

> uhm... it looks like fallback scenarios are quite rich/complex.
> =

> @Florian, I think this discussion in important, but does not relate
> strictly to this series; the problem is independent, and could be
> addresses separatelly - if we need to address anything ;)
> =

> The scenario I was thinking about is (e.g.):
> =


I'm numbering the steps for easier reference:

> 1. the client send a data segment + DSS mapping
> 2. the server do not send DACKs, just plain TCP acks (because e.g. MPTCP
> options are allowed by middle-box after syn)
> 3. the client should fall-back (we currently don't do any check there,
> so we don't) and sends some additional plain TCP data segments
> 4. the server sends some data seg, and should fall-back for the same
> resons

*if* in Step 2 the server received data without a DSS-option he already fell
back to regular TCP right away. Because at the beginning a sender MUST
include the DSS-options in each segment:

"A sender MUST include a DSS option with data sequence mapping in
 every segment until one of the sent segments has been acknowledged
 with a DSS option containing a Data ACK."

 Nevertheless, the following steps can still happen if the middlebox is just
 in one direction (aka., server to client and thus the DATA_ACK gets
 removed).

> 5. the server tries to read from the msk socket. The older data is in
> the msk receive queue, the newer in the subflow receive queue, if we
> call sock_recvmsg(), that will corrupt the stream.
> =

> I'm unsure if the above wording from 3.7 applies here: it think that
> the sentence "If a subflow breaks during operation" applies to the msk
> socket after that the first data segment is DACK-ed other, otherwise
> the 2 paragraph just before that[1] would be unneeded, right?

Yes, this scenario here is about the start of the connection. and the
paragraph [1] applies, as well as "In the case of such an ACK being received
on the first subflow...".

Thus, once the sender receives the ACK without DATA_ACK, he sends an
infinite mapping option (DSS With data-len =3D=3D 0) to the server.
That is the indication that it has to fallback. It is guaranteed that all
data is in-order because the client should not yet have established a second
subflow or sent data in an out-of-order way on the subflow.

> @Christoph, could you please assert the correct interpretation here?
> And what about the other critical fallback scenario discussed during
> the last mtg? (fallback due to out-of-order DACK / plain TCP ACK)

If that happens, the sender will receive the plain TCP ACK and fallback to
regular TCP. It will indicate that to the receiver with an infinite mapping.
(Cfr.: "The sender will send one final data sequence mapping...").

Once the receiver receives that, he knows that he also has to fallback to
regular TCP.


In general, it is best for a host to always include a DATA_ACK option in
every segment that it sends. That avoids these kind of issues :-)


Christoph


> =

> Thanks,
> =

> Paolo
> =

> [1] "If, however, an ACK is received for data (not just for the
> SYN)"...
> =

> =

> =

>=20
--===============0825548016912313279==--
