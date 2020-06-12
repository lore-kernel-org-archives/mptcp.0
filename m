Content-Type: multipart/mixed; boundary="===============0164042173620994691=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: unify MPTCP_PM_MAX_ADDR and
 MPTCP_PM_ADDR_MAX
Date: Fri, 12 Jun 2020 19:33:11 +0200
Message-ID: <2638593d-82bd-73be-8ff1-3a4a7d4d5968@tessares.net>
In-Reply-To: 463f48a4f92aa403453d30a801259c68fda15387.1591939496.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4661

--===============0164042173620994691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 12/06/2020 07:27, Geliang Tang wrote:
> Unify these two duplicate macros into 8.

Thank you for this new patch!

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 809687d3f410..86d265500cf6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -135,7 +135,7 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, =
u8 nib, u8 field)
>   		     ((nib & 0xF) << 8) | field);
>   }
>   =

> -#define MPTCP_PM_MAX_ADDR	4
> +#define MPTCP_PM_ADDR_MAX	8

I think it would be better to drop MPTCP_PM_MAX_ADDR and keep =

MPTCP_PM_ADDR_MAX in pm_netlink.c where it is used. Each PM can decide =

what's the maximum number of addresses it can support.

MPTCP_PM_MAX_ADDR seems to be a left over from a previous implementation =

of a PM that has not been upstreamed but replaced by the Netlink PM later.

Also, please always add "net" or "net-next" prefix in the subject of =

your email to help -net maintainers. Do not hesitate to look at the =

netdev FAQ for more details.

Here this patch looks like a fix so you should have [PATCH net] and a =

"Fixes" tag. I guess for this patch you can use:

   Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")

That's where MPTCP_PM_MAX_ADDR has been introduced. It was already not =

used and never used later.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0164042173620994691==--
