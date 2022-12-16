Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262D634
	for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 08:01:47 +0000 (UTC)
Received: by mail-yb1-f195.google.com with SMTP id d128so1506177ybf.10
        for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 00:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tDONZMnOFQh15cqbq7ocnDKBXGu0x67Ygya01OaBMss=;
        b=QPXrAplCw82cRvnZZk9pXwXiz3pA72r0ROcpTHfdOYJaglBDwv3/p/OSRCQWdcK8nT
         0pijdIRRYXSiHWSlyt9MnO5ti9uHqVNWumk9BcfwiGBtoii+7wtOHpFZixBNVAzNK3Vt
         VHi+2hkqduKdC5+7zdaksQ1ZVDgmoypVBxL5kkSV7MZgFHoBFZlg2hq8yf2tljGEnORl
         /wwjetrVu0hPwGCjraO7GlqZD8mfAZYjwhikIwU/f5yGSitcB/90PTLaUCgeY7H+XihB
         R6P/HsmEGd3Xb1lC5AWp01blxCZ+dpPRSkyOuQz9+BCTZKBoBecffjTHjhY/QkSKCF/o
         L3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDONZMnOFQh15cqbq7ocnDKBXGu0x67Ygya01OaBMss=;
        b=3zrRK2HJCPm5PW2L8tLD3iMH/y4dZtyv+5e5U1y7QS1g7Wqjj5tgscS1Y/m/5KR+Pg
         mVEQupnzFHO3SHe5Q8S9TD6amAi8goZ6UFNOJlfKCJ45dxP1WdZjr4wjfN2YoHoLIfY7
         th/0Rm8Ogmh8HrifDa3mjxUCK9qhm4DtrHke9RqvVJvU2AX7TejZHkxJWoCX/l2KT4Vq
         pBY45wrq3bpZ8j1gS93tRjX/zwgkroMWKFL4RSJnQzI79KypzX0a3mQUe++zoA/6Q2eG
         F/ZpFu6isFznJ0/Vg3Yu9riPnNjVtnDD0A1drslpMiyVjI/LUPAc3xJ3P9di0+N/ufCg
         FPsw==
X-Gm-Message-State: ANoB5pkvuB8tXqKdcAjSanTtkIv7TrFBNuLebxhhT10LjPDBhKeC52Jo
	tix8ZcEu4DBc0k7xMBkaokTrHus2kmIs+Nlknvo=
X-Google-Smtp-Source: AA0mqf4tSwR9/XwIW5zv4BoEQuNquzfrtOKy8oQvhcLadbn1lLz9rYEVu+YHPy7DfvTUedtViqiPwy5Ad1qwbtY9ZrI=
X-Received: by 2002:a5b:b45:0:b0:6f8:ce8a:57a5 with SMTP id
 b5-20020a5b0b45000000b006f8ce8a57a5mr43612851ybr.26.1671177706211; Fri, 16
 Dec 2022 00:01:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221208024543.113633-1-imagedong@tencent.com>
 <20221208024543.113633-3-imagedong@tencent.com> <d6bcf7e63c35d5769fd6496ae6d23a283e36a678.camel@redhat.com>
In-Reply-To: <d6bcf7e63c35d5769fd6496ae6d23a283e36a678.camel@redhat.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 16 Dec 2022 16:01:34 +0800
Message-ID: <CADxym3aXUg5uhwTvUYTh9PGXcCyUvM92h-C3Z_GbOap=fYvb9g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp socket
 in use
To: Paolo Abeni <pabeni@redhat.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

On Tue, Dec 13, 2022 at 12:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Thu, 2022-12-08 at 10:45 +0800, menglong8.dong@gmail.com wrote:
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
> > v8:
> > - remove the MPTCP_INUSE flag and do the statistics according to the
> >   creation and destruction of the token
> >
> > v6:
> > - introduce the 'MPTCP_INUSE' flag and check if msk is in use by it
> >
> > v5:
> > - rebase to solve merge conflict
> >
> > v4:
> > - rename MPTCP_DESTROIED to MPTCP_DESTROYED
> >
> > v2:
> > - decrease the statistics for listening mptcp socket inuse with
> >   mptcp_listen_inuse_dec()
> > - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
> >   called on the msk. For fallback case, we need to decrease the
> > ---
> >  net/mptcp/protocol.c | 16 +++++++++++++++-
> >  net/mptcp/token.c    |  7 +++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index ffdccf26af99..775454a9d49b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -3005,6 +3005,16 @@ void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> >       inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
> >  }
> >
> > +static void mptcp_listen_inuse_dec(struct sock *sk)
> > +{
> > +     struct mptcp_sock *msk = mptcp_sk(sk);
> > +     struct socket *ssock;
> > +
> > +     ssock = __mptcp_nmpc_socket(msk);
> > +     if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
>
> Here I think you can check directly: sk->sk_state == TCP_LISTEN, which
> should be both simpler and safer, since this should be called under the
> (m)sk socket lock.
>

Then, mptcp_listen_inuse_dec() needs to be called before msk
enters TCP_CLOSE state, which means __mptcp_close()
and mptcp_disconnect(). Do I miss any case that a listening
msk enters TCP_CLOSE state?

> It would be nice adding a comment describing why the state check is
> needed, e.g.
>
>         /* Listener sockets do not have a valid token, but we need to
>          * account them, too.
>          */
>

Sounds nice!

> Other then that, LGTM.
>
> Cheers,
>
> Paolo
>
