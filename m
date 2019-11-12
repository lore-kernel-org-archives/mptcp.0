Content-Type: multipart/mixed; boundary="===============1840918490740138737=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 4/6] options: ack pending sequence
Date: Tue, 12 Nov 2019 14:13:11 +0100
Message-ID: <20191112131311.GF19558@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1911111646501.7818@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2482

--===============1840918490740138737==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 80dbe7662cea..b488bf07ada5 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -418,13 +418,20 @@ static bool mptcp_established_options_dss(struct =
sock *sk, struct sk_buff *skb,
> > 		ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
> > =

> > 	if (ack_size <=3D remaining) {
> > +		const struct mptcp_subflow_context *subflow;
> > 		struct mptcp_sock *msk;
> > =

> > 		dss_size +=3D ack_size;
> > =

> > -		msk =3D mptcp_sk(mptcp_subflow_ctx(sk)->conn);
> > +		subflow =3D mptcp_subflow_ctx(sk);
> > +		msk =3D mptcp_sk(subflow->conn);
> > 		if (msk) {
> > -			opts->ext_copy.data_ack =3D msk->ack_seq;
> > +			u64 ack_seq =3D READ_ONCE(msk->ack_seq);
> > +
> > +			if (subflow->map_valid)
> > +				ack_seq +=3D subflow->data_avail;
> =

> I'm not sure this works well with multiple subflows. It could ack a later
> sequence number on this subflow, then send an earlier sequence number in a
> bare ack on another subflow. They should be close enough that the earlier
> seq would be ignored, but it would be better to send consistent acks.

That would require far more changes since this means we need to move
msk->ack_seq update away from recvmsg.

I think its best to drop this patch for now, its annoying to have this
behaviour of acking data that was consumed by userspace rather than what
was received but I don't see a simple solution nor is it related to wmem
accouting.
--===============1840918490740138737==--
