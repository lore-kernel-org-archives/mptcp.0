Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6637C
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 02:10:14 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id jm11so940252plb.13
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 19:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kXQoaHC3k2akRnlFUaySK0IotfjbrJ19A8rGhWQGoiM=;
        b=j0OoaSvP2JjwrIMHgPXq9bY15Mz1LQRrySltVO1OOkXw4/iwNcyOX5NUEqK557JtmR
         xYacO/mrARtQCOws9tcdjQEtSWHzNgkybzkBhnbXyNkxqpYT4ZHRDnXMEGpqbqcK7C32
         N+Laxv47MArxHooS4XCr8vQaelqIFcG4P9Vi/9h85TeRDYCNuO9CJj9V4pFLoEq7uoSx
         R0dEWPIEj2y56k49hJkHOwGGetI1GIKXxHC2n++dmZNRcpAyQpRK4lnO39VXR17foOIw
         bxvpNV8AJ64QSu7FYDNFaAhx7+6m6ZRWL96i0wyumD6h4zmqhoe2OWnnCWCU0bkavXlX
         lKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kXQoaHC3k2akRnlFUaySK0IotfjbrJ19A8rGhWQGoiM=;
        b=eZ9+RLQO41uPiyXCceskc2YTVWR9q0T9dut5CHhXHqXWvlMeMj4+NSoCNN+XUnl65K
         rzoZ4zVtsFOUUrNkqY+R+jRPNwHEtADuEYrXOPz+AIp4YGtMw8bn9bRPjXp6SUKdyPPF
         +w4d2gURl7MEYL0NGhdZQTDeZvCEoc5F8SHYSTFMR4XaaC3v5XENEj6sCazD9xtDNn6C
         BM/SbCwhxMt0f5rVoHiY6IZkDqgQWQYIjKJu2oqhC6fV3CzlUTLOz1FVrPhNa5v8c9L8
         UDnDFZHCBWTctlqyPrEFsonduD0/IdhplzvhAVkESPqfwmSG3rVvIF0oGJPM4SU/FOhc
         wsWw==
X-Gm-Message-State: ACrzQf3dI6nKPhQ8pDIx34xLniEFr5ZLM12ZGw3ItI3PbfbhOR22vUYM
	iefQQsuY8R3CHC3YMz2YE/DyQ1W+GNqL6pZa8MQ=
X-Google-Smtp-Source: AMsMyM48g2Y1hnCRP6x3AvCrCrM9sHVf160W3jznZ8ADj2yXQUmqEAaig5dzlPu3r3fQcyBLHl/PW+hB3TIVEyW4bx4=
X-Received: by 2002:a17:90b:4d0d:b0:1fb:a86d:e752 with SMTP id
 mw13-20020a17090b4d0d00b001fba86de752mr1286113pjb.120.1663639813462; Mon, 19
 Sep 2022 19:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220919132156.3649522-1-imagedong@tencent.com> <61ca3016-5f92-7779-9213-f8b75ff9ff55@linux.intel.com>
In-Reply-To: <61ca3016-5f92-7779-9213-f8b75ff9ff55@linux.intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 20 Sep 2022 10:10:02 +0800
Message-ID: <CADxym3a3q_Tz=SWPqfwL+apnVtEpCd1Ng47xmCbN9ywNXnnMaw@mail.gmail.com>
Subject: Re: [PATCH mptcp] net: mptcp: add statistics for mptcp socket in use
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: pabeni@redhat.com, mptcp@lists.linux.dev, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 20, 2022 at 6:37 AM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Mon, 19 Sep 2022, menglong8.dong@gmail.com wrote:
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
>
> Hello Menglong -
>
> Thanks for your patch.
>
> One minor thing: please use the subject line tags listed in
> https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes :
> either "[PATCH mptcp-net]" or "[PATCH mptcp-next]", so it's clear which
> tree the patch is intended for.
>

Thanks for your remind, I'll send the next version with
mptcp-next tag.

> > ---
> > net/mptcp/protocol.c | 19 +++++++++++++------
> > net/mptcp/subflow.c  |  3 +++
> > 2 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 45ed50e9aec9..4da77aa8b070 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2311,6 +2311,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> >                       tcp_set_state(ssk, TCP_CLOSE);
> >                       mptcp_subflow_queue_clean(ssk);
> >                       inet_csk_listen_stop(ssk);
> > +                     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>
> The code in this function is for a closing subflow, not a closing MPTCP
> socket. I don't think this call belongs here.
>

I think this is the path of the listening mptcp close.
The mptcp socket in listening status is not hashed
to the token hash table, or has 'MPTCP_FALLBACK_DONE'
flags. Therefore, the use statistics of it is not freed in
mptcp_destroy_common().

Hmm...maybe there is a better code path for
this part?

> >               }
> >               __tcp_close(ssk, 0);
> >
> > @@ -3067,6 +3068,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> >       skb_rbtree_purge(&msk->out_of_order_queue);
> >       mptcp_data_unlock(sk);
> >
> > +     if (!sk_unhashed(sk) || __mptcp_check_fallback(msk))
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > +
> >       /* move all the rx fwd alloc into the sk_mem_reclaim_final in
> >        * inet_sock_destruct() will dispose it
> >        */
> > @@ -3513,6 +3517,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> >       mptcp_token_destroy(msk);
> >       inet_sk_state_store(sock->sk, TCP_SYN_SENT);
> >       subflow = mptcp_subflow_ctx(ssock->sk);
> > +     sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
> > #ifdef CONFIG_TCP_MD5SIG
> >       /* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> >        * TCP option space.
> > @@ -3547,12 +3552,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
> > static int mptcp_listen(struct socket *sock, int backlog)
> > {
> >       struct mptcp_sock *msk = mptcp_sk(sock->sk);
> > +     struct sock *sk = sock->sk;
>
> Changing all of the "sock->sk" text in this function to "sk" creates a lot
> of diffs that aren't related to maintaining the inuse statistics. If you'd
> like to do that refactoring change, please split that into a separate
> patch for mptcp-next.
>

Ok, I'll split it into a separate patch.

Thanks!
Menglong Dong

> -Mat
>
> >       struct socket *ssock;
> >       int err;
> >
> >       pr_debug("msk=%p", msk);
> >
> > -     lock_sock(sock->sk);
> > +     lock_sock(sk);
> >       ssock = __mptcp_nmpc_socket(msk);
> >       if (!ssock) {
> >               err = -EINVAL;
> > @@ -3560,16 +3566,17 @@ static int mptcp_listen(struct socket *sock, int backlog)
> >       }
> >
> >       mptcp_token_destroy(msk);
> > -     inet_sk_state_store(sock->sk, TCP_LISTEN);
> > -     sock_set_flag(sock->sk, SOCK_RCU_FREE);
> > +     inet_sk_state_store(sk, TCP_LISTEN);
> > +     sock_set_flag(sk, SOCK_RCU_FREE);
> > +     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> >
> >       err = ssock->ops->listen(ssock, backlog);
> > -     inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
> > +     inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
> >       if (!err)
> > -             mptcp_copy_inaddrs(sock->sk, ssock->sk);
> > +             mptcp_copy_inaddrs(sk, ssock->sk);
> >
> > unlock:
> > -     release_sock(sock->sk);
> > +     release_sock(sk);
> >       return err;
> > }
> >
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
> >
>
> --
> Mat Martineau
> Intel
