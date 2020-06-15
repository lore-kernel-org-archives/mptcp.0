Content-Type: multipart/mixed; boundary="===============4335550269632445621=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: unify MPTCP_PM_MAX_ADDR and
 MPTCP_PM_ADDR_MAX
Date: Mon, 15 Jun 2020 16:44:25 +0800
Message-ID: <20200615084425.GA29964@OptiPlex>
In-Reply-To: 2638593d-82bd-73be-8ff1-3a4a7d4d5968@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4674

--===============4335550269632445621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 07:33:11PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> =

> On 12/06/2020 07:27, Geliang Tang wrote:
> > Unify these two duplicate macros into 8.
> =

> Thank you for this new patch!
> =

> (...)
> =

> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 809687d3f410..86d265500cf6 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -135,7 +135,7 @@ static inline __be32 mptcp_option(u8 subopt, u8 len=
, u8 nib, u8 field)
> >   		     ((nib & 0xF) << 8) | field);
> >   }
> > -#define MPTCP_PM_MAX_ADDR	4
> > +#define MPTCP_PM_ADDR_MAX	8
> =

> I think it would be better to drop MPTCP_PM_MAX_ADDR and keep
> MPTCP_PM_ADDR_MAX in pm_netlink.c where it is used. Each PM can decide
> what's the maximum number of addresses it can support.
> =

> MPTCP_PM_MAX_ADDR seems to be a left over from a previous implementation =
of
> a PM that has not been upstreamed but replaced by the Netlink PM later.
> =

> Also, please always add "net" or "net-next" prefix in the subject of your
> email to help -net maintainers. Do not hesitate to look at the netdev FAQ
> for more details.
> =

> Here this patch looks like a fix so you should have [PATCH net] and a
> "Fixes" tag. I guess for this patch you can use:
> =

>   Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")
> =

> That's where MPTCP_PM_MAX_ADDR has been introduced. It was already not us=
ed
> and never used later.
> =

> Cheers,
> Matt
> -- =

> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

Hi Matt,

Thanks for your reply.
I have already resend patch v2 to you.

-Geliang
--===============4335550269632445621==--
