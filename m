Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5E634
	for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 08:04:43 +0000 (UTC)
Received: by mail-yb1-f193.google.com with SMTP id v126so1557871ybv.2
        for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 00:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wSM+B2Xemus7yYbXZmM4jZ4h0fo3BaU7obxEwoaZf4s=;
        b=Va8OwTJOspxi+GoY2VSTlq9a9FSX5vnYmZ+Ldz0d+UACYtACfKJ8LsbKnye5sKCLYF
         8LZCbCGrtHypcUCNEhduAS1V7gDl8PDK8RhKGeo4uVhji0YsyVokd7TtPhh7f0k8CUS+
         lUaeTdBpJDll8wI9mGOMkhT2XHcwE8lloCirRjk7VTCrY4Uw8B5XTqLU8LDFVkzoJ2FO
         va8u7i0ZX/AfQZ02CeIJkjHz9LiAqlTSuxBRRmFnKBEaQYbXgmMOzlb4sHRN4ms174/i
         1mUfZcFz4ZxMDUIEZIt0IrLwGGgjtXe87MRDVs4/nnw/gTbcFR1FvtecQZyNOs14Ogan
         YBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSM+B2Xemus7yYbXZmM4jZ4h0fo3BaU7obxEwoaZf4s=;
        b=tH4YkNWpVrLyCANFowoF1G5CbM9nXvhQaUSGBlYKyzJ8QYTtXxjzqDkTcZ8pGYZQPi
         4inhS8TSXzqKkKQJdMr0sP6SvZV7nFhJDaYRY++tBQMlPkVaco90wftU5yWXxg2kjBcH
         yWeVnxdDLGyM/cH06ULIPq5cjCUAuzLesTvgRCWgW4a6he6BiMhssEvjIGwsxGF/AgIa
         lEuFsyP50MnPgCbVMqskdmhsodT8thnwMFA2mKM0EGcTQF5Q5DVfFm+JgfNWgcXqHzu6
         8/aAeNVjuISeRp+ASsoPit8jtDi4ckKHO41P6kv5Xzim0/BX2CxzVCcKogSSDD71dAt+
         DVAg==
X-Gm-Message-State: ANoB5pmsysyyMB5ofLN7DKMP9/heQptZarbaBRuGcQxYGxEofLWSgwwd
	NvLsU5pbacUhioYU6v9oWVRm/eUsMX/FvHu7zXQ=
X-Google-Smtp-Source: AA0mqf4Yoc5H8Plq3C4G/QO+OFYXh82fEwwiJO1IHHprLk00TD8q0uxeewLEqPbKQDhLHkZZx4vwN6nr2o+HCTJN1ZI=
X-Received: by 2002:a25:ef08:0:b0:709:e347:747b with SMTP id
 g8-20020a25ef08000000b00709e347747bmr9192506ybd.188.1671177882958; Fri, 16
 Dec 2022 00:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221208024543.113633-1-imagedong@tencent.com>
 <20221208024543.113633-3-imagedong@tencent.com> <2fd384f250890912c039a23b2992b02fd4e313b3.camel@redhat.com>
In-Reply-To: <2fd384f250890912c039a23b2992b02fd4e313b3.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 16 Dec 2022 16:04:31 +0800
Message-ID: <CADxym3aWkRhy6JEZb3ZLc7JFHk68DrePe+Z8EvZ5dQ5n5Jm6-w@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp socket
 in use
To: Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 13, 2022 at 1:03 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Thu, 2022-12-08 at 10:45 +0800, menglong8.dong@gmail.com wrote:
> > diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> > index 65430f314a68..54064146175f 100644
> > --- a/net/mptcp/token.c
> > +++ b/net/mptcp/token.c
> > @@ -175,6 +175,9 @@ int mptcp_token_new_connect(struct sock *sk)
> >       __sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
> >       bucket->chain_len++;
> >       spin_unlock_bh(&bucket->lock);
> > +     sock_prot_inuse_add(sock_net(subflow->conn),
> > +                         subflow->conn->sk_prot,
> > +                         1);
>
> Whoops, sorry for not noticing the above earlier...
> Here it would be better rename the mptcp_token_new_connect argument to
> 'ssk', and add a new local variable:
>
>         struct sock *sk = subflow->conn;
>
> and replace the '(struct sock *)msk', 'subflow->conn' above with 'sk'.
>

Okay!

> Side note: the kunit crash is due to build_icsk() being too naive: it
> creates a completely zeroed inet_connection_sock, while after this
> patch mptcp_token_new_connect() requires that the sk_prot field is
> initialized, too.
>
> The issue could be addresses with an addtional chunk in token_test.c.
> Note that for token's test sake, sk_prot could be initialized to any
> available/already exported proto.
> ---
> diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
> index 5d984bec1cd8..3bffe8d0d36f 100644
> --- a/net/mptcp/token_test.c
> +++ b/net/mptcp/token_test.c
> @@ -36,6 +36,9 @@ static struct inet_connection_sock *build_icsk(struct kunit *test)
>         icsk = kunit_kzalloc(test, sizeof(struct inet_connection_sock),
>                              GFP_USER);
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, icsk);
> +
> +       /* be sure the tocken helpers can dereference sk->sk_prot */
> +       icsk->icsk_inet.sk.sk_prot = &tcp_prot;
>         return icsk;
>  }
>

Get it! Thanks~

Menglong Dong

>
