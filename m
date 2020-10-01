Content-Type: multipart/mixed; boundary="===============4147742642526635095=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] tcp: fix syn cookied MPTCP request socket leak
Date: Fri, 02 Oct 2020 07:31:20 +0800
Message-ID: <CA+WQbwsVq8n6-0f6qun9q2cVjTyXO3Nk72jCGQ536Y79ueLKsg@mail.gmail.com>
In-Reply-To: 3f4d9db3da99e2175cd2c071b53e4d380c8e9821.1601569789.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6148

--===============4147742642526635095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=882=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:32=E5=86=99=E9=81=93=EF=BC=9A
>
> If a syn-cookies request socket don't pass MPTCP-level
> validation done in syn_recv_sock(), we need to release
> it immediatelly, or it will be leaked.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in =
use")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> Note: I still see some mptcp_join.sh self-tests failures, but
>  I can observe them with and without this patch

Thanks, I have tested this patch, it works.

Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

> v1 -> v2:
>  - preserve rxhash/toffset
> ---
>  net/ipv4/syncookies.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index c375c126f436..6ac473b47f30 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -214,7 +214,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
>                 sock_rps_save_rxhash(child, skb);
>
>                 if (rsk_drop_req(req)) {
> -                       refcount_set(&req->rsk_refcnt, 2);
> +                       reqsk_put(req);
>                         return child;
>                 }
>
> --
> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4147742642526635095==--
