Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A938C64C
	for <mptcp@lists.linux.dev>; Thu,  6 Oct 2022 05:20:44 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id f37so1065310lfv.8
        for <mptcp@lists.linux.dev>; Wed, 05 Oct 2022 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8KVS99KgIXMHophLAOqt+btFaRDFkE5w9tJA60L1/Aw=;
        b=D3gMQ7NYmrFArebHM2XMCrd68eUpzIdnqnd8/Dj0c8FMR7XC/5x+qtZJ//g3KH5Vsn
         q3dmT5oQzKv4PS1ncPWqCICcc6vZi3rZryjFZtlhHyt/dkkkjd3rS6H5xj4bMQvGkzDH
         j4OFf2yOrZlHi5/i6XYjqKZBH+EHvExzmDogux8q8uhk7M40aBNyhNk+EKHdlFAQRsU1
         ayHJaQ+sC2TkowYQ9Odx70wMG4rRFtP6+fPenDKrEaW0Ua2GSiONSOvpjGkgTBU5wRJJ
         daUTA7oryjpZXq5bHrJu1NH5g9wvTCpQM1m0KPmr0kSU0Aji/79Q3ESNUrNmN+bk4ffV
         pvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8KVS99KgIXMHophLAOqt+btFaRDFkE5w9tJA60L1/Aw=;
        b=oT22tb0yN3Tgn7YG1Wp/XbfnDaH1aUZ3Jb/Glq0uxIdcoLoLhI82hnhkhbw9VRk65i
         IP+Xz3J7Wdv9C6ZezP8HJbKwyi/DN3ZbEAiqcrhMJHzrF+YlUth3zAcdeynKYMLbrtx1
         E6Fqn7zU89l1rpYi5UqFpu3YfBh/a3uUJfT+hZB8Ag9XyaOG2+zDaP5PI1N0l9ByZT1L
         w4uiH0F2G7q2cQKYWRdLlc47xpD2mIY4E0nANfErJNBTa64yCJ5jNx9/QLeRHdwYvKFo
         bk80Vkih0lMXrnl8xw6cQ8j8OrzkxJIwfPR8LAzP4ri05xC1BHJyKGP7UFO0H9q83pkr
         +dkA==
X-Gm-Message-State: ACrzQf0RBFHM9OAhzTDVYDHmZzFrh8fKisidoUg3BLADRX6DlcHKC3lc
	kptk4creDck2QoD5nNWgBbqqPo2qXP5WSQBpVPQ=
X-Google-Smtp-Source: AMsMyM43gMVMs1K1ceozu36GUxnwgvqaQ2tXZJlH4R1YAJ/k9a40tXblPQSZkOvT3RcpZS19TBgOXEvyozaSHJcpLRA=
X-Received: by 2002:a05:6512:2295:b0:49e:f3d0:4cf8 with SMTP id
 f21-20020a056512229500b0049ef3d04cf8mr1264498lfu.616.1665033642590; Wed, 05
 Oct 2022 22:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220930024607.128202-1-imagedong@tencent.com>
 <20220930024607.128202-3-imagedong@tencent.com> <6ebd4a84-3be5-17fa-6e03-3ca69740512b@linux.intel.com>
In-Reply-To: <6ebd4a84-3be5-17fa-6e03-3ca69740512b@linux.intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 6 Oct 2022 13:20:31 +0800
Message-ID: <CADxym3bn4O-Mj345_S4s+b+AzmVeeVvX9j2h3x3eajSxOtbpMQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: add statistics for mptcp socket
 in use
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 1, 2022 at 7:25 AM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Fri, 30 Sep 2022, menglong8.dong@gmail.com wrote:
>
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> > Therefore, we can get the count of used mptcp socket from
> > /proc/net/protocols:
> >
> > & cat /proc/net/protocols
> > protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> > MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> > MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> > v2:
> > - decrease the statistics for listening mptcp socket inuse with
> >  mptcp_listen_inuse_dec()
> > - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
> >  called on the msk. For fallback case, we need to decrease the
> >  statistics only once, and mptcp_destroy_common() can be called
> >  more than once.
> > ---
> > net/mptcp/protocol.c | 22 +++++++++++++++++++++-
> > net/mptcp/protocol.h |  1 +
> > net/mptcp/subflow.c  |  3 +++
> > 3 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index d817fdb2f6ef..e6d358027b7b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2913,6 +2913,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> >       inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
> > }
> >
> > +static void mptcp_listen_inuse_dec(struct sock *sk)
> > +{
> > +     struct mptcp_sock *msk = mptcp_sk(sk);
> > +     struct socket *ssock;
> > +
> > +     ssock = __mptcp_nmpc_socket(msk);
> > +     if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > +}
> > +
> > static int mptcp_disconnect(struct sock *sk, int flags)
> > {
> >       struct mptcp_sock *msk = mptcp_sk(sk);
> > @@ -2925,6 +2935,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> >       if (mptcp_sk(sk)->token)
> >               mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
> >
> > +     mptcp_listen_inuse_dec(sk);
> >       /* msk->subflow is still intact, the following will not free the first
> >        * subflow
> >        */
> > @@ -3096,6 +3107,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> >       skb_rbtree_purge(&msk->out_of_order_queue);
> >       mptcp_data_unlock(sk);
> >
> > +     if ((__mptcp_check_fallback(msk) &&
> > +          !test_and_set_bit(MPTCP_DESTROIED, &msk->flags)) ||
> > +         !sk_unhashed(sk))
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > +
> >       /* move all the rx fwd alloc into the sk_mem_reclaim_final in
> >        * inet_sock_destruct() will dispose it
> >        */
> > @@ -3110,6 +3126,7 @@ static void mptcp_destroy(struct sock *sk)
> > {
> >       struct mptcp_sock *msk = mptcp_sk(sk);
> >
> > +     mptcp_listen_inuse_dec(sk);
> >       /* clears msk->subflow, allowing the following to close
> >        * even the initial subflow
> >        */
> > @@ -3542,6 +3559,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> >       mptcp_token_destroy(msk);
> >       inet_sk_state_store(sock->sk, TCP_SYN_SENT);
> >       subflow = mptcp_subflow_ctx(ssock->sk);
> > +     sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
> > #ifdef CONFIG_TCP_MD5SIG
> >       /* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> >        * TCP option space.
> > @@ -3596,8 +3614,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
> >
> >       err = ssock->ops->listen(ssock, backlog);
> >       inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> > -     if (!err)
> > +     if (!err) {
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> >               mptcp_copy_inaddrs(sk, ssock->sk);
> > +     }
> >
> > unlock:
> >       release_sock(sk);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index c0b5b4628f65..675de024de10 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -116,6 +116,7 @@
> > #define MPTCP_WORK_EOF                3
> > #define MPTCP_FALLBACK_DONE   4
> > #define MPTCP_WORK_CLOSE_SUBFLOW 5
>
> Hi Menglong -
>
> Overall, v3 is looking good. Thanks for adding the tests!
>
> One thing that was requested in v2 review was to fix this spelling:
>
> > +#define MPTCP_DESTROIED              6
>
> to be MPTCP_DESTROYED. Can you fix that and post v4?
>

OMG! I forgot this part :) Yeah, I'll fix it in v4.

Thanks!
Menglong Dong

>
> - Mat
>
> >
> > /* MPTCP socket release cb flags */
> > #define MPTCP_PUSH_PENDING    1
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 07dd23d0fe04..da6cfa73a3bd 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -747,6 +747,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> >                       mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
> >                       mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
> >                       mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
> > +                     sock_prot_inuse_add(sock_net(new_msk),
> > +                                         new_msk->sk_prot,
> > +                                         1);
> >                       ctx->conn = new_msk;
> >                       new_msk = NULL;
> >
> > --
> > 2.37.2
> >
> >
>
> --
> Mat Martineau
> Intel
