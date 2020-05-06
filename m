Content-Type: multipart/mixed; boundary="===============1189421282855652727=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Wed, 06 May 2020 19:48:16 +0200
Message-ID: <0cecd2b0c2568f2c796d32356342f561ce803a49.camel@redhat.com>
In-Reply-To: 20200505183101.GA99784@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4330

--===============1189421282855652727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-05-05 at 11:31 -0700, Christoph Paasch wrote:
> What about something like this:
> @@ -769,12 +769,16 @@ struct sock *tcp_check_req(struct sock *sk, struct =
sk_buff *skb,
>          * ESTABLISHED STATE. If it will be dropped after
>          * socket is created, wait for troubles.
>          */
> -       child =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, =
NULL,
> -                                                        req, &own_req);
> -       if (!child)
> +       ret =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NU=
LL,
> +                                                      req, &own_req, &ch=
ild);
> +       if (ret < 0) {
> +               if (ret !=3D -ENOMEM) {
> +                       goto embryonic_reset;
> +               }
>                 goto listen_overflow;
> +       }
> =

> -       if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
> +       if (ret > 0)
>                 reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req=
);
>                 inet_csk_reqsk_queue_drop_and_put(sk, req);
>                 return child;
> =

> =

> Yes, it does not get rid of the branching in tcp_check_req, but at least =
it
> makes it less MPTCP-specific.

I'm sorry, I forgot to mention in my previous email the following: one
thing that I fear about the above change is that introduces some
overhead for

# CONFIG_MPTCP is not set

builds, while the current code compiles to nothing. We will have a
couple of additional conditionals - one in fast path - and an
additional argument in the stack. Nothing drammatic, but still...

Cheers,

Paolo

--===============1189421282855652727==--
