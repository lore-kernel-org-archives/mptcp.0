Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8CA23
	for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 08:42:43 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id y135so8637544yby.12
        for <mptcp@lists.linux.dev>; Mon, 19 Dec 2022 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l/sr8WI6YIXF2WQ3m0jaDiQP2aL2hu5qHzHjcbNEpCs=;
        b=A6SqfjmM4VWYvjEBdEeanYsHNcYdcePkoedMUahw7Cx460H6uUUp6GUz8eB0/BKYVt
         ucwIT8zrH32QoFKkabf028frFE5xmxAXuKxpG/gcbHfwRQG8DP8yhqrpZrhLDXgnfe3y
         aqCK49TUPBP5LO/zk9SJS+9N4UpmVhNkJqiRNlS4eGd9g1yV96OxozxkLfitOAgyYaBt
         yt/K6h0csCb6EDfkMdoCD45qDziLtJtHpMDoNtQulHJqKDG0dxE7xIOI6jv9RpfqKQwW
         MIb+KI1Qs5L7TCTpaAzGm++S5K95XGXNa76yOTkwA4s11MasILLLcZvpm0vFTcow5VC1
         RkFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/sr8WI6YIXF2WQ3m0jaDiQP2aL2hu5qHzHjcbNEpCs=;
        b=ojmnsSialtn/GmSItGBtRb5CJUaqC//EXG+iKZKvDTF09bDezyw9lfiVbE8OQ2uqtE
         pPRBDNLlyVpQTMq6X5cgCsicQNRK6D7mzqK6ma3Thf/mFxXL4rl1vbxicvKM05cr9MMI
         EHnzg6AVedxxY8SOIkcN4m3cxyz9sZgWLsPbAU+2cM6f4vrtab/3e1E4nhGy4nWrLrtJ
         HUQ7per/RNGTvdIxBeavHwGrF7gQTQdnVmhl8iNG3ZhFKY255Q0pAz7X1LS22zNqIb++
         9l9iDSJQOOyIkni0lZNf7soCU4gmuIoHQa4hY4WTxBtTxITQACbq9S49Jb6XH8tNylxP
         ihdQ==
X-Gm-Message-State: ANoB5pkxvpSM9NV+vVECxU71AC0HLYHk9BM8jjaKu22whHM9kLleF4hu
	Bpz7L7h/7DGHQm4aqGplIzpB0CvWx4mCW1jCObc=
X-Google-Smtp-Source: AA0mqf5oqPDVVktGQx+qnhay0fuoV/vHy6V+Mmigjo0gL/zAncwO6IoXHN6gt1ZUkN5O/qpjftizU8lyxRHnOz/bNxU=
X-Received: by 2002:a05:6902:703:b0:727:1318:3c5 with SMTP id
 k3-20020a056902070300b00727131803c5mr3399575ybt.496.1671439362854; Mon, 19
 Dec 2022 00:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221219075048.255811-1-imagedong@tencent.com>
 <20221219075048.255811-5-imagedong@tencent.com> <2225c7fa3484a262aa143b2e250cdc87beef410b.camel@redhat.com>
In-Reply-To: <2225c7fa3484a262aa143b2e250cdc87beef410b.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 19 Dec 2022 16:42:31 +0800
Message-ID: <CADxym3YH_y-qfVFTt_qt9+TAcZwou59KWgezR02JnM6tTQmxRQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v9 4/6] mptcp: init sk->sk_prot in build_msk()
To: Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 19, 2022 at 4:32 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Mon, 2022-12-19 at 15:50 +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > The 'sk_prot' field in token KUNIT self-tests will be dereferenced in
> > mptcp_token_new_connect(). Therefore, init it with tcp_prot.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  net/mptcp/token_test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
> > index 5d984bec1cd8..0758865ab658 100644
> > --- a/net/mptcp/token_test.c
> > +++ b/net/mptcp/token_test.c
> > @@ -57,6 +57,9 @@ static struct mptcp_sock *build_msk(struct kunit *test)
> >       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, msk);
> >       refcount_set(&((struct sock *)msk)->sk_refcnt, 1);
> >       sock_net_set((struct sock *)msk, &init_net);
> > +
> > +     /* be sure the token helpers can dereference sk->sk_prot */
> > +     ((struct sock *)msk)->sk_prot = &tcp_prot;
> >       return msk;
> >  }
> >
>
> Since you likelly have to post another revision of this series, I think
> it would be better moving this patch before "mptcp: add statistics for
> mptcp socket in use" - so that self-tests are always functional.
>

Okay!

Thanks
Menglong Dong

> Otherwise LGTM, thanks!
>
> Paolo
>
