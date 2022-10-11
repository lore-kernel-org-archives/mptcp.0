Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3A315AC
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 02:24:04 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id p5so15168695ljc.13
        for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=poAFRhzeUJVJKOe7IY9/LwbEI7b0BMn333ll7VynyY4=;
        b=qfx6c8COoOwGxvrCyEMGB5ju7ws9EP4Az9N2Z6MXy/zJhiRPcTBexb8een0LmX4Z7o
         vYgTJGLIq2UdskKGxUn97NrcLzrate9okAx87w3UMGqYh4vlBcyP60FHB7V9QokDY+0w
         mkcQNxtyDVdQeCEDZkViexQL+v/DO/Qfkg5n/rD+EOCzjW1GSkrl+wGAXZa82cgs56Ln
         2LPIsFsfCzBIEm5zcvSw8ievNyxTIKIocbGir/O7FSBwwf1JlPDeNHdh1R0ZFbWZYX65
         e/2yOUvYvC+keg97OyZZqCNn67ps+ur4Zkw4snnFIBkWCf4VsHZytAOscOW67kPo8MpL
         Vqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=poAFRhzeUJVJKOe7IY9/LwbEI7b0BMn333ll7VynyY4=;
        b=ElpI7doqj8x2qiNs9CJC/s8OEtEu/GhvjWs7EWuGCmLr8vQvfsbrQCqkrvTRn+9k0s
         HvSGvcPEpQrjc3YV1/txWSwWCJNfgDJZA+0RkhSkc0KpNZWBd+nLX05XZH9YVL4gl5W4
         5wu4pvMLWYCDjQxP5wDE7Ou0JEt+fGndTtPHQ6ZFIBEAn/Jh14QM6OHYbuVeqQUW5soh
         rDPefM4+etJpL3OuyjK+mMprDUk/426aVR6p0llVF8y//1D8b5n4/CYxza1EL2806+nm
         iw30kDFll9gerfGo0WTx+C+G5bXQOeppK3oad0gq89Hnx1qKdoA1gfVm9TqBRKfVejps
         tRxQ==
X-Gm-Message-State: ACrzQf29fYCHrvFDPfbtzFa0dlbxDn8FoXwpSGCoahDTyXEgbO8Tx3hQ
	K017R+g0CyxCJomREi7EIdv9A4ku6rsfnxFsojA=
X-Google-Smtp-Source: AMsMyM6zm4cTgbl++rQBQada3AKvOJIYTszzg4hBp/t5KONZ0O1T8pSPFui6Kw7XV8EoCCOQqjJanlA8/mFqH+d7kO0=
X-Received: by 2002:a05:651c:158f:b0:26b:dd9c:dca5 with SMTP id
 h15-20020a05651c158f00b0026bdd9cdca5mr7877185ljq.400.1665455042925; Mon, 10
 Oct 2022 19:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221007092922.13169-1-imagedong@tencent.com> <20221007092922.13169-3-imagedong@tencent.com>
 <3b348f3f-5eb6-83a6-c1c8-6ad095b3d278@linux.intel.com>
In-Reply-To: <3b348f3f-5eb6-83a6-c1c8-6ad095b3d278@linux.intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 11 Oct 2022 10:23:51 +0800
Message-ID: <CADxym3bWocKAT7A+76vr84GTiZgMdDR4suYYM9=cABwQZir36g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v5 2/3] mptcp: add statistics for mptcp socket
 in use
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 11, 2022 at 9:11 AM Mat Martineau
<mathew.j.martineau@linux.intel.com> wrote:
>
> On Fri, 7 Oct 2022, menglong8.dong@gmail.com wrote:
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
> > v5:
> > - rebase to solve merge conflict
> >
> > v4:
> > - rename MPTCP_DESTROIED to MPTCP_DESTROYED
> >
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
> > index 04d92dc0941f..3d1570a9d3e9 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2974,6 +2974,16 @@ static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
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
> > @@ -2986,6 +2996,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> >       if (mptcp_sk(sk)->token)
> >               mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
> >
> > +     mptcp_listen_inuse_dec(sk);
> >       /* msk->subflow is still intact, the following will not free the first
> >        * subflow
> >        */
> > @@ -3160,6 +3171,11 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
> >       skb_rbtree_purge(&msk->out_of_order_queue);
> >       mptcp_data_unlock(sk);
> >
> > +     if ((__mptcp_check_fallback(msk) &&
> > +          !test_and_set_bit(MPTCP_DESTROYED, &msk->flags)) ||
>
> Hi Menglong -
>
> Sorry I didn't look at this more closely earlier, but did you find that
> mptcp_destroy_common() is only called multiple times with fallback
> sockets?
>
> (This makes me wonder if we have a separate bug to look at, not
> necessarily related to your patch series)

Hello,

mptcp_destroy_common() can be called multiple times with all
sockets, if shutdown is called before close(). Isn't it designed that
mptcp_destroy_common() can be called multiple times?

For no-fallback sockets, it will be unhashed when mptcp_destroy_common()
is called for the first time. So we can check if it is in use by this.

Thanks!
Menglong Dong

>
> - Mat
>
> > +         !sk_unhashed(sk))
> > +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
> > +
> >       /* move all the rx fwd alloc into the sk_mem_reclaim_final in
> >        * inet_sock_destruct() will dispose it
> >        */
> > @@ -3174,6 +3190,7 @@ static void mptcp_destroy(struct sock *sk)
> > {
> >       struct mptcp_sock *msk = mptcp_sk(sk);
> >
> > +     mptcp_listen_inuse_dec(sk);
> >       /* clears msk->subflow, allowing the following to close
> >        * even the initial subflow
> >        */
> > @@ -3529,6 +3546,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
> >
> >       mptcp_token_destroy(msk);
> >       inet_sk_state_store(sk, TCP_SYN_SENT);
> > +     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
> >       subflow = mptcp_subflow_ctx(ssock->sk);
> > #ifdef CONFIG_TCP_MD5SIG
> >       /* no MPTCP if MD5SIG is enabled on this socket or we may run out of
> > @@ -3661,8 +3679,10 @@ static int mptcp_listen(struct socket *sock, int backlog)
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
> > index 18f866b1afda..374ef75e4bb9 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -116,6 +116,7 @@
> > #define MPTCP_WORK_EOF                3
> > #define MPTCP_FALLBACK_DONE   4
> > #define MPTCP_WORK_CLOSE_SUBFLOW 5
> > +#define MPTCP_DESTROYED              6
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
