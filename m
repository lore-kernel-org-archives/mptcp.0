Content-Type: multipart/mixed; boundary="===============8905231346981924547=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: fix caller of mptcp_handle_ipv6_mapped
Date: Fri, 17 Jan 2020 18:29:28 +0100
Message-ID: <112467d7ae964f42b650f4fc9ec509ddf06b3246.camel@redhat.com>
In-Reply-To: 20200117172413.1377116-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3405

--===============8905231346981924547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-01-17 at 18:24 +0100, Matthieu Baerts wrote:
> This was causing a warning: 'sk' has a 'const' attribute. Good because
> it was not the right sk!
> =

> Fixes: 77c6b6aec34b (mptcp: handle ipv4-mapped ipv6 address.)
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> ---
> =

> Notes:
>     to be squashed in "mptcp: Handle MP_CAPABLE options for outgoing conn=
ections"
> =

>  net/ipv6/tcp_ipv6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index b3eacd3549c3..33a578a3eb3a 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1208,7 +1208,7 @@ static struct sock *tcp_v6_syn_recv_sock(const stru=
ct sock *sk, struct sk_buff *
>  =

>  		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
>  		if (sk_is_mptcp(newsk))
> -			mptcp_handle_ipv6_mapped(sk, true);
> +			mptcp_handle_ipv6_mapped(newsk, true);
>  		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
>  #ifdef CONFIG_TCP_MD5SIG
>  		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;

LGMT, thank you for fixing my faults!

/P

--===============8905231346981924547==--
