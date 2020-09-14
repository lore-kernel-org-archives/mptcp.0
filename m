Content-Type: multipart/mixed; boundary="===============4656677384558095948=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] tcp: fix syn cookied MPTCP request socket leak
Date: Mon, 14 Sep 2020 17:34:36 +0800
Message-ID: <CA+WQbwuNsAFfnu2nnGPdmrU42_xJkA+GsbbV64kjkCMNKVXyAA@mail.gmail.com>
In-Reply-To: c92e068760b45b13cae7f29107acabf8512c5f3f.1599830705.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5845

--===============4656677384558095948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thanks for your patch. I tested it. It fixed the memory leak problem.
But I got this
selftest fail output:

11 single subflow with syn cookies      syn[ ok ] - synack[ ok ] - ack[ ok ]
12 multiple subflows with syn cookies   syn[fail] got 1 JOIN[s] syn expecte=
d 2
 - synack[fail] got 1 JOIN[s] synack expected 2
 - ack[fail] got 1 JOIN[s] ack expected 2
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
Client ns stats
MPTcpExtMPJoinSynAckRx          1                  0.0
13 subflows limited by server w cookies syn[fail] got 1 JOIN[s] syn expecte=
d 2
 - synack[fail] got 1 JOIN[s] synack expected 2
 - ack[ ok ]
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
Client ns stats
MPTcpExtMPJoinSynAckRx          1                  0.0
14 signal address with syn cookies      syn[ ok ] - synack[ ok ] - ack[ ok ]
15 subflow and signal w cookies         syn[ ok ] - synack[ ok ] - ack[ ok ]
16 subflows and signal w. cookies       syn[fail] got 1 JOIN[s] syn expecte=
d 3
 - synack[fail] got 1 JOIN[s] synack expected 3
 - ack[fail] got 1 JOIN[s] ack expected 3
Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             1                  0.0
MPTcpExtMPJoinAckRx             1                  0.0
Client ns stats
MPTcpExtMPJoinSynAckRx          1                  0.0

-Geliang

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8811=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:38=E5=86=99=E9=81=93=EF=BC=9A
>
> If a syn-cookies request socket don't pass MPTCP-level
> validation done in syn_recv_sock(), we need to release
> it immediatelly, or it will be leaked.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
> Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in =
use")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>  net/ipv4/syncookies.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> ---
> I don't really know what I'm doing here ;)
> But apparently it fixes the leak in my tests
>
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index c375c126f436..5c8390876cf8 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -209,15 +209,15 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, s=
truct sk_buff *skb,
>         child =3D icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
>                                                  NULL, &own_req);
>         if (child) {
> -               refcount_set(&req->rsk_refcnt, 1);
> -               tcp_sk(child)->tsoffset =3D tsoff;
> -               sock_rps_save_rxhash(child, skb);
> -
>                 if (rsk_drop_req(req)) {
> -                       refcount_set(&req->rsk_refcnt, 2);
> +                       reqsk_free(req);
>                         return child;
>                 }
>
> +               refcount_set(&req->rsk_refcnt, 1);
> +               tcp_sk(child)->tsoffset =3D tsoff;
> +               sock_rps_save_rxhash(child, skb);
> +
>                 if (inet_csk_reqsk_queue_add(sk, req, child))
>                         return child;
>
> --
> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============4656677384558095948==--
