Content-Type: multipart/mixed; boundary="===============0541305406207924869=="
MIME-Version: 1.0
From: Jason A. Donenfeld <Jason at zx2c4.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 12/26] netfilter: switch nf_setsockopt to sockptr_t
Date: Mon, 27 Jul 2020 17:03:10 +0200
Message-ID: <20200727150310.GA1632472@zx2c4.com>
In-Reply-To: 20200723060908.50081-13-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5320

--===============0541305406207924869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Thu, Jul 23, 2020 at 08:08:54AM +0200, Christoph Hellwig wrote:
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index da933f99b5d517..42befbf12846c0 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1422,7 +1422,8 @@ int ip_setsockopt(struct sock *sk, int level,
>  			optname !=3D IP_IPSEC_POLICY &&
>  			optname !=3D IP_XFRM_POLICY &&
>  			!ip_mroute_opt(optname))
> -		err =3D nf_setsockopt(sk, PF_INET, optname, optval, optlen);
> +		err =3D nf_setsockopt(sk, PF_INET, optname, USER_SOCKPTR(optval),
> +				    optlen);
>  #endif
>  	return err;
>  }
> diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_table=
s.c
> index 4697d09c98dc3e..f2a9680303d8c0 100644
> --- a/net/ipv4/netfilter/ip_tables.c
> +++ b/net/ipv4/netfilter/ip_tables.c
> @@ -1102,7 +1102,7 @@ __do_replace(struct net *net, const char *name, uns=
igned int valid_hooks,
>  }
>  =

>  static int
> -do_replace(struct net *net, const void __user *user, unsigned int len)
> +do_replace(struct net *net, sockptr_t arg, unsigned int len)
>  {
>  	int ret;
>  	struct ipt_replace tmp;
> @@ -1110,7 +1110,7 @@ do_replace(struct net *net, const void __user *user=
, unsigned int len)
>  	void *loc_cpu_entry;
>  	struct ipt_entry *iter;
>  =

> -	if (copy_from_user(&tmp, user, sizeof(tmp)) !=3D 0)
> +	if (copy_from_sockptr(&tmp, arg, sizeof(tmp)) !=3D 0)
>  		return -EFAULT;
>  =

>  	/* overflow check */
> @@ -1126,8 +1126,8 @@ do_replace(struct net *net, const void __user *user=
, unsigned int len)
>  		return -ENOMEM;
>  =

>  	loc_cpu_entry =3D newinfo->entries;
> -	if (copy_from_user(loc_cpu_entry, user + sizeof(tmp),
> -			   tmp.size) !=3D 0) {
> +	sockptr_advance(arg, sizeof(tmp));
> +	if (copy_from_sockptr(loc_cpu_entry, arg, tmp.size) !=3D 0) {
>  		ret =3D -EFAULT;
>  		goto free_newinfo;
>  	}

Something along this path seems to have broken with this patch. An
invocation of `iptables -A INPUT -m length --length 1360 -j DROP` now
fails, with

nf_setsockopt->do_replace->translate_table->check_entry_size_and_hooks:
  (unsigned char *)e + e->next_offset > limit  =3D=3D>  TRUE

resulting in the whole call chain returning -EINVAL. It bisects back to
this commit. This is on net-next.

Jason
--===============0541305406207924869==--
