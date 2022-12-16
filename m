Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA120EA
	for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 15:24:10 +0000 (UTC)
Received: by mail-yb1-f195.google.com with SMTP id 186so2706591ybe.8
        for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8HFmklnFaeR3V8CnyZNDOV3xpZX2u8WmsmdpM7gbbYw=;
        b=WRcHb8q/pz61M+cTPWmG6gbDBar5kUmqmBJTTR/YYl/DmaKmYa+wOxtFfEpTXQ3S7Q
         m9fvVXmSUxGty7/ck567GqAZfA+o3NnpBbuKuYGoSZl13Sl5z6zTOxm6iDIUzpY2NHcV
         VP0G6LBezQlWsbS6MEXpdOmx6/h+y5/0dfQc1CusiHfKkp1Iumbo5nI1z+dZzN9PM2I8
         yrjWL+OwjXODCH4JOWhE5FunQjiBWKyvEqKVRRjibdRLGg0J4ZD3JcIQSP9RhVDM5AhZ
         THc9wU9m6soiWrQ2lpg/icbjODSNF0h5TX9rKv0iVzTnlgfuJC2QnH65OsZlImw1tVlI
         UFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HFmklnFaeR3V8CnyZNDOV3xpZX2u8WmsmdpM7gbbYw=;
        b=QidryyPEU7konfWpDcc0Zv33tGfGSdfSjRb/ntyswJuhMYhkcHtP1kmT4QZjxCdgxt
         dYGxUDktfhSFP91TuQsXGotrpIt2NGHMMEgKnSwaOO12u6dhbxoSglW7FcwCvtCIbhve
         DjS7Ra3DGEuI37jQ34knhAUhV4G3m9M8Fdp8KCv8bzfocHWoRB8yD3LVi6e5KaRljvO5
         2ksTs+MvhoreihdXvu5ncxjkDEOOn3sdvn5WOHXNNMJmcVzMMGmm7Uz2WX0GoJV2Yn5w
         1V3T5D0Sz3+QAVdv70PLPfo23FrGlCMHfA4d7fXkRqeZDdy49s9DWOxghg8k9zdciHeh
         Q4ZA==
X-Gm-Message-State: ANoB5pl9kNtqiIiwpaRsL6wqLGkoB0aPDEOqdGbMSq5D4Gqgi+9nmQU2
	EQgvirqTXKPoUJeJi1D0DyJU4xuYpo8KcUeUqai0mAuahv0IWg==
X-Google-Smtp-Source: AA0mqf6BGpngXNiXBLKcDH+sscSm0P1vAdWHwU/la74d/JJPN6jyaBK0eNOsl7qcWpNNtn4YNEupjJgLHWcQpsOHyzU=
X-Received: by 2002:a25:ced1:0:b0:6f4:8e4e:6f7e with SMTP id
 x200-20020a25ced1000000b006f48e4e6f7emr54507843ybe.285.1671204249689; Fri, 16
 Dec 2022 07:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221208024543.113633-1-imagedong@tencent.com>
 <20221208024543.113633-3-imagedong@tencent.com> <d6bcf7e63c35d5769fd6496ae6d23a283e36a678.camel@redhat.com>
 <CADxym3aXUg5uhwTvUYTh9PGXcCyUvM92h-C3Z_GbOap=fYvb9g@mail.gmail.com> <7da5b207620795939388bf906ebbc443b4d7fa75.camel@redhat.com>
In-Reply-To: <7da5b207620795939388bf906ebbc443b4d7fa75.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 16 Dec 2022 23:23:58 +0800
Message-ID: <CADxym3abYtfzPYV1xbOdAp5ndJjxoqFgkwmrv03au753fWZMdA@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp socket
 in use
To: Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, Dec 16, 2022 at 4:45 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Fri, 2022-12-16 at 16:01 +0800, Menglong Dong wrote:
> > Hello,
> >
> > On Tue, Dec 13, 2022 at 12:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > >
> > > On Thu, 2022-12-08 at 10:45 +0800, menglong8.dong@gmail.com wrote:
> > > > From: Menglong Dong <imagedong@tencent.com>
> > > >
> > > > Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> > > > Therefore, we can get the count of used mptcp socket from
> > > > /proc/net/protocols:
> > > >
> > > > & cat /proc/net/protocols
> > > > protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> > > > MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> > > > MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> > > >
> > > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > > ---
> > > > v8:
> > > > - remove the MPTCP_INUSE flag and do the statistics according to the
> > > >   creation and destruction of the token
> > > >
> > > > v6:
> > > > - introduce the 'MPTCP_INUSE' flag and check if msk is in use by it
> > > >
> > > > v5:
> > > > - rebase to solve merge conflict
> > > >
> > > > v4:
> > > > - rename MPTCP_DESTROIED to MPTCP_DESTROYED
> > > >
> > > > v2:
> > > > - decrease the statistics for listening mptcp socket inuse with
> > > >   mptcp_listen_inuse_dec()
> > > > - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
> > > >   called on the msk. For fallback case, we need to decrease the
> > > > ---
> > > >  net/mptcp/protocol.c | 16 +++++++++++++++-
> > > >  net/mptcp/token.c    |  7 +++++++
> > > >  2 files changed, 22 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index ffdccf26af99..775454a9d49b 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -3005,6 +3005,16 @@ void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> > > >       inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
> > > >  }
> > > >
> > > > +static void mptcp_listen_inuse_dec(struct sock *sk)
> > > > +{
> > > > +     struct mptcp_sock *msk = mptcp_sk(sk);
> > > > +     struct socket *ssock;
> > > > +
> > > > +     ssock = __mptcp_nmpc_socket(msk);
> > > > +     if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
> > >
> > > Here I think you can check directly: sk->sk_state == TCP_LISTEN, which
> > > should be both simpler and safer, since this should be called under the
> > > (m)sk socket lock.
> > >
> >
> > Then, mptcp_listen_inuse_dec() needs to be called before msk
> > enters TCP_CLOSE state, which means __mptcp_close()
> > and mptcp_disconnect(). Do I miss any case that a listening
> > msk enters TCP_CLOSE state?
>
> AFAIK, that is correct. Note that the number of hooks will not change
> compared to the current patch revision (mptcp_disconnect() +
> mptcp_destroy()).
>

With the changes you suggested, I need to the move mptcp_listen_inuse_dec()
that called in mptcp_destroy() to __mptcp_close(), as msk is already in
CLOSE state in mptcp_destroy(). Isn't it?

Thanks!
Menglong Dong

>
> Cheers,
>
> Paolo
>
