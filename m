Content-Type: multipart/mixed; boundary="===============5899495031223907888=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH 4/4] mptcp: allow collapsing consecutive
 sendpages on the same substream
Date: Wed, 10 Apr 2019 10:05:56 +0200
Message-ID: <91da8a97d57aeca139f08b7495bd56fe563d0b05.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1904051701080.58453@aakhemka-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1058

--===============5899495031223907888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-04-05 at 17:34 -0700, Mat Martineau wrote:
> On Fri, 5 Apr 2019, Paolo Abeni wrote:
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 2fbfe3e30630..5df2283de488 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -47,11 +47,19 @@ static struct sock *mptcp_subflow_get_ref(const str=
uct mptcp_sock *msk)
> > 	return NULL;
> > }
> > =

> > +static inline bool mptcp_skb_can_collapse_to(const struct mptcp_sock *=
msk,
> > +					     const struct sock *ssk,
> > +					     const struct sk_buff *skb)
> > +{
> > +	return tcp_skb_can_collapse_to(skb) && (msk->last =3D=3D ssk);
> =

> Even if the last send was on a particular subflow, that doesn't guarantee =

> the next send can be collapsed on that subflow. There are other cases lik=
e =

> MPTCP-level resends or sending duplicate data on different subflows.

uhmm... I thought a bit more about the above and the code in the patch
still LGTM: msk->last references the last subflow we enqueued new data
to, that is, the subflow with the higher/newer MPTCP write_seq...

> I think it would have to make sure the MPTCP-level sequence numbers are =

> contiguous before collapsing.

... so this condition always held, when (msk->last =3D=3D ssk).

Am I missing something?

Thanks,

Paolo


--===============5899495031223907888==--
