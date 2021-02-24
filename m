Content-Type: multipart/mixed; boundary="===============0965866743764780685=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: mptcp reset option
Date: Wed, 24 Feb 2021 11:13:14 +0100
Message-ID: <20210224101314.GA17911@breakpoint.cc>
In-Reply-To: a4936e57-c3c-9f92-f351-433af57ed4b5@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7934

--===============0965866743764780685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> On Mon, 22 Feb 2021, Florian Westphal wrote:
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 59ea64e5e914..e95bd8fa5e62 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -1648,9 +1648,21 @@ static int mptcp_event_sub_closed(struct sk_buff=
 *skb,
> > 				  const struct mptcp_sock *msk,
> > 				  const struct sock *ssk)
> > {
> > +	const struct mptcp_subflow_context *sf;
> > +
> > 	if (mptcp_event_put_token_and_ssk(skb, msk, ssk))
> > 		return -EMSGSIZE;
> > =

> > +	sf =3D mptcp_subflow_ctx(ssk);
> > +	if (sf->reset_reason =3D=3D 0)
> > +		return 0;
> =

> From what I see in the RFC, the T flag can be set even if the reason code=
 is
> 'unspecified', so I don't think MPTCP_ATTR_RESET_FLAGS should be skipped =
if
> reset_reason =3D=3D 0.

OK.

> I would suggest removing the above two lines and always including the rea=
son
> & flags, but if it's worthwhile to optimize out either attribute then ple=
ase
> explain.

Hmpf, yes, this isn't sufficient to do what I wanted.
The intention was to ONLY set any of these attributes in the nlmsg if
the subflow had been zapped via tcprst option.

as reset_reason can be 0 in the wire format (and hacks like 'lets store
v+1' are error prone), i will add another bit to signal the field is
valid instead.

> > +/* MPTCP Reset reason codes, rfc8684 */
> > +#define MPTCP_RST_EUNSPEC	0
> > +#define MPTCP_RST_EMPTCP	1
> > +#define MPTCP_RST_ERESOURCE	2
> > +#define MPTCP_RST_EPROHIBIT	3
> > +#define MPTCP_RST_EWQ2BIG	4
> > +#define MPTCP_RST_EBADPERF	5
> > +#define MPTCP_RST_EMIDDLEBOX	6
> > +
> =

> The MSP_RST_* defines could be useful in include/uapi/linux/mptcp.h

Okay, no problem. I was reluctant to place them there but
given those values are from the rfc i think it makes sense to have this
in a uapi header.

> > +			struct mptcp_ext *mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> > +
> > +			if (mpext) {
> > +				memset(mpext, 0, sizeof(*mpext));
> > +				mpext->reset_reason =3D MPTCP_RST_EMPTCP;
> > +			}
> =

> This chunk of code (with slight variation in the first line) is used in 3
> places, worth adding a helper function in subflow.c?

Sure, will add one.
--===============0965866743764780685==--
