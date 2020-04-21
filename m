Content-Type: multipart/mixed; boundary="===============5034697078944788101=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH -next] mptcp/pm_netlink.c : add check for
 nla_put_in6_addr
Date: Tue, 21 Apr 2020 18:32:10 +0200
Message-ID: <4440312dc634ce08e2a3f76e38851bcc8cd331c2.camel@redhat.com>
In-Reply-To: 20200421161830.uaiwr5il6kh5texr@host
X-Status: 
X-Keywords:                  
X-UID: 4213

--===============5034697078944788101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-04-22 at 00:18 +0800, Bo YU wrote:
> Normal there should be checked for nla_put_in6_addr like other
> usage in net.
> =

> Detected by CoverityScan, CID# 1461639
> =

> Fixes: 01cacb00b35c("mptcp: add netlink-based PM")
> Signed-off-by: Bo YU <tsu.yubo(a)gmail.com>
> ---
> BWT, I am not sure nla_put_in_addr whether or not to do such that
> ---
>  net/mptcp/pm_netlink.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 86d61ab34c7c..f340b00672e1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -603,8 +603,9 @@ static int mptcp_nl_fill_addr(struct sk_buff *skb,
>  		nla_put_in_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR4,
>  				addr->addr.s_addr);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -	else if (addr->family =3D=3D AF_INET6)
> -		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6);
> +	else if (addr->family =3D=3D AF_INET6 &&
> +		nla_put_in6_addr(skb, MPTCP_PM_ADDR_ATTR_ADDR6, &addr->addr6))
> +		goto nla_put_failure;
>  #endif
>  	nla_nest_end(skb, attr);
>  	return 0;

This change LGTM, but I think we also need a similar check for
nla_put_in_addr(), thanks!

Paolo

--===============5034697078944788101==--
