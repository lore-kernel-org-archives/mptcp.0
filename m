Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43A7FE
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 03:34:29 +0000 (UTC)
Received: by mail-yb1-f194.google.com with SMTP id p81so4485796yba.4
        for <mptcp@lists.linux.dev>; Sun, 20 Nov 2022 19:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UIrS1NV5tXgKDOZXeEn7yWmZt32NjQFFxv6vt7t/xQ=;
        b=RZ8WepXTfkHOjMy9pOfQ/WL7KuqdT5jbmKU3UKxLIsNYxbla0UpDWsRn05xqhRn9Fd
         72WvnIKDPsc5US1hSvAMkWVhvt1qB5cPzhubkEgk5gYuR+CFhsOL1zRKvzUuKadScYrz
         OzJgLplYVYYVXLsEVkiRnZZNTvCXEp9yq63l/9wbV8OJPw7enHyDktHidTKmw9TGak8v
         DCpZysShgkBYdeALsGxzRRkzhiiP+popA+kdT2Dj7EEFzvC7u3VhhqFZ/kZQjapNM4U1
         If2Tf4qJso7h3QjYmA9t9WB3DKZxGEZfepe3/6IUE86E3jkNEKPS6VKkmB5UPa6sDzeg
         M+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UIrS1NV5tXgKDOZXeEn7yWmZt32NjQFFxv6vt7t/xQ=;
        b=bLPyO+YeL2p1v9DSMYKoLIRBSTnxTF2/tQG9KZMlgPcxE5OmyG2gLJWY2WDpH2qUuO
         4uY1vVY9aPdiwjW8rDmyqnbao/GH63IKWEXXGs/KuFSs+RxARw9oVnHt4G8UiCYUYvXL
         VsxtPQYzOZSREXCfuzGlARjrK76gysD2VWYaEPa7h1gZgCwvA7LzOK/JJF3XOliYk4mE
         aor3k7VuQ+AH6tWoKUWTHruNSP9/Onw7TODEXRtGxg/rRh15671Ey/Y8dAZRE2otMafb
         UyQbQieAVaTTlP/IrXArb06gfu+CQLpHYBEaZ0oCc+cTgsz7CUITGJu1fBdWW9+Gfz+I
         wBtg==
X-Gm-Message-State: ANoB5pnaSJxBTgdr1xyg6W7Z5ZdesxTIZnRkyDVpJAqRsPfdEJqH3Vlr
	3C8UMFyGbFkil2rzJn/OUI6pWUePi1Z36Lyitqs=
X-Google-Smtp-Source: AA0mqf60mx6VzMn/pXcv+22jVUU7Y06AhcZD5xMGs1XTrvHc8SS7iISVE3EAoAfis70MM+h2UdZ+Ed18MQ1lA1nZkvM=
X-Received: by 2002:a25:d914:0:b0:6e1:547c:7a43 with SMTP id
 q20-20020a25d914000000b006e1547c7a43mr15582932ybg.231.1669001668242; Sun, 20
 Nov 2022 19:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221118072030.3500578-1-imagedong@tencent.com> <7e47464d0af8c4c0d02cf332bcefafd8f06fb50e.camel@redhat.com>
In-Reply-To: <7e47464d0af8c4c0d02cf332bcefafd8f06fb50e.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 21 Nov 2022 11:34:17 +0800
Message-ID: <CADxym3bvDDSP2dpEdNk_Pp0F45KySTsisHTFL3+M4TB09R5zPA@mail.gmail.com>
Subject: Re: [PATCH mptcp-net] mptcp: don't orphan ssk in mptcp_close()
To: Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, 
	Biao Jiang <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Fri, Nov 18, 2022 at 6:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
[......]
>
> Thank you for clearly debugging this scenario!
>
> As noted by the CI, this fix causes an UaF, as mptcp_close() frees the
> msk->sk_socket struct, which is also referenced by ssk->sk_socket.
>
> Without orphaning the subflows, later tcp code will use ssk->sk_socket,
> causing the reported splat. Note that there is the same risk with ssk-
> >sk_wq.
>
> Since:
> * all the network code carefully checks for not NULL value of ssk-
> >sk_socket before accessing it
> * access it directly in context where it can't be NULL
> * uses the same policies to access 'sk_wq'
> * it looks like the SOCK_DONE flag can be set independently from the
> sock_orphan()
>
> I think mptcp_close() could instead directly clearing ssk->sk_socket
> and ssk->sk_wq - just ' = NULL', no sock_orphan() call - and
> __mptcp_close_ssk() could be changed accordingly:
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 8679eafeeca8..6b9f390966f7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2340,11 +2340,7 @@ static void __mptcp_close_ssk(struct sock *sk,
> struct sock *ssk,
>                 goto out;
>         }
>
> -       /* if we are invoked by the msk cleanup code, the subflow is
> -        * already orphaned
> -        */
> -       if (ssk->sk_socket)
> -               sock_orphan(ssk);
> +       sock_orphan(ssk);
>
>         subflow->disposable = 1;
>

Thanks for your detailed explanation, and I'll send the V2 according
to it!

> > Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> > Reviewed-by: Mengen Sun <mengensun@tencent.com>
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  net/mptcp/protocol.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 3796d1bfef6b..5ac1584baf61 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -815,7 +815,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> >
> >       /* Wake-up the reader only for in-sequence data */
> >       mptcp_data_lock(sk);
> > -     if (move_skbs_to_msk(msk, ssk))
> > +     if (move_skbs_to_msk(msk, ssk) && !sock_flag(sk, SOCK_DEAD))
> >               sk->sk_data_ready(sk);
>
> I think this is not need right? sk_data_ready == sock_def_readable,
> will check carefully sk->sk_wq which should be NULL after close.
>

Yeah, this check seems unnecessary, I'll remove it.

> Thank!
>
> Paolo
>
