Content-Type: multipart/mixed; boundary="===============6111168956477242829=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH V3 -next] mptcp/pm_netlink.c : add check for
 nla_put_in/6_addr
Date: Thu, 23 Apr 2020 10:34:54 +0200
Message-ID: <8546038508824f0a440f40bb9eef7ede61d223bb.camel@redhat.com>
In-Reply-To: 20200423020957.g5ovpymbbp4nykbr@debian.debian-2
X-Status: 
X-Keywords:                  
X-UID: 4233

--===============6111168956477242829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-23 at 10:10 +0800, Bo YU wrote:
> Normal there should be checked for nla_put_in6_addr like other
> usage in net.
> =

> Detected by CoverityScan, CID# 1461639
> =

> Fixes: 01cacb00b35c("mptcp: add netlink-based PM")
> Signed-off-by: Bo YU <tsu.yubo(a)gmail.com>
> ---
> V3: fix code style, thanks for Paolo
> =

> V2: Add check for nla_put_in_addr suggested by Paolo Abeni
> ---
>  net/mptcp/pm_netlink.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 86d61ab34c7c..b78edf237ba0 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -599,12 +599,14 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
>  	    nla_put_s32(skb, MPTCP_PM_ADDR_ATTR_IF_IDX, entry->ifindex))
>  		goto nla_put_failure;
> =

> -	if (addr->family =3D=3D AF_INET)
> -		nla_put_in_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR4,
> -				addr->addr.s_addr);
> +	if (addr->family =3D=3D AF_INET &&
> +	    nla_put_in_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR4,
> +			    addr->addr.s_addr))
> +		goto nla_put_failure;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	else if (addr->family =3D=3D AF_INET6)
> -		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6);
> +	else if (addr->family =3D=3D AF_INET6 &&
> +		 nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6))
> +		goto nla_put_failure;
>  #endif
>  	nla_nest_end(skb, attr);
>  	return 0;
> --
> 2.11.0

Thanks for addressing my feedback!

Acked-by: Paolo Abeni <pabeni(a)redhat.com>



--===============6111168956477242829==--
