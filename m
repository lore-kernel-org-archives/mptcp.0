Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136DD84D3E
	for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253575; cv=none; b=uM/g6M332n1tXXnsMoTHYoYVrtsZe8G5LSXya3VmP8nXL7/4P0c9mzA7rjThDAcO+fPfbQgCpAN9f+RO1BOt/qkRQEdiYOefFaQsIlhnqmMRSdXWR2nm1E8ag9qS9YrrjTEsFCPfvEcXv0K/LJMDW2FNFGVFc/WQQI2I5iCQ49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253575; c=relaxed/simple;
	bh=vk6JfY8qrQ5jCabF1GPxdPSeYWAPJTS6S6pluDj/nQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GAuI5U93ABtl9xLLtMP/+abP8CBE5U2RJNl+fnqwzffMqnj+gThqBR0UdrvmHmiUwDmY2Y9rRFXqIa4+g/HxpzvwxG8CPY6dw+Q5dq61gYRuteyiJzW5WQLTKqVOy20pe7HAxTFK26vijFJ96Ixwh56ZfhFWom0jAn3RCLR7Kk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzWeu9eZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzWeu9eZ"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a523524e5baso478341966b.3
        for <mptcp@lists.linux.dev>; Tue, 16 Apr 2024 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253570; x=1713858370; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlc9OAtPyGThuRreoHGGq4JhsMFG7UIHgTXexs1GEKI=;
        b=fzWeu9eZ4JMhpl4YiN56F03DJe+y0fQldrzODpOykL1sQ8CvsWW4qzeCOLq7bYi7Td
         jjvHZdcXyE6LvWKppCKzjrtglz7Qz/pzotGXDm3YJ2sGS8pyH+mKT4OiakWLc9EmkPPz
         SdjAyErasw+pYeBE9tg/qtR8sRkw8U2N+TIx++P3nFkzglT590zCZgTmeTY3pdXqBvEX
         ss/Bn+7jVdjRSn3ITUgUKzP0H4OxOSBIO9lnL+D6QthfYlrhRKsUHwrKJahhELRHGLZP
         GeByBK+RvPhlkjDin2WFhBK+La1KQCBipoZtbRcOvsFQMvmkolDeAF9Ku4+p3rZ3o6Sm
         OvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253570; x=1713858370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlc9OAtPyGThuRreoHGGq4JhsMFG7UIHgTXexs1GEKI=;
        b=V9fYzB5A6Fu8d8eJ4Lc5B1NenHz/K3ExAmu7IpytBKZAZi9KlArkOzmzsdvqh/qDhb
         cwVyW34mtiOWIEiIAxOQKP5xu581rk3ssYfrRQLfd1NRHq2bZexABKB+n/QuMV251U+B
         812+snt+HSS3VN/TJTLTWA36CQVOpFMGmoKDRc53FjsuOb1kK8dXEIsbX8j25zF03MnV
         oa9g14FRdMkXSlLkJtHMex4nQZ1OmSu5JjkyjUXWWzY9IQ0QC/mQYdPOSHkpLfU79Yqm
         lXrguFclGYy9BimrDe7pTiONwKFC2zAwOIXgBRgdHEtLpFN83zocOfb98Yso5Oiqtodq
         F5/g==
X-Forwarded-Encrypted: i=1; AJvYcCXC7EAUX2T+xMlBohepWyc4vPO5jAJhgkc9VgEB0EwrnFLYHK1c0BnkNg5lwXBit2+FlG9PjnI1ybyQn9o35ratBbJs2Og=
X-Gm-Message-State: AOJu0YzNjNw28Afei2UkAcOAen/fiWzVJCZ+pN2K9snHigUJt5ba5Gqp
	I+OjtDYP2iIjO1Zpz2+4amno0U7hi+TaNWTeUsywbGsamQ27GjswI752OGInlcPuZNgDaa4eedY
	ezuRDBRuyTggPAYR0s5QW/iAtXuc=
X-Google-Smtp-Source: AGHT+IE+FjE3cfbMa11xSLAJqaup16gjkKCR1tUG07Qz1Ezru8a1zyUIoXUCVjxkyGQXJdp//WqMt/G70qfTGvg9+IM=
X-Received: by 2002:a17:906:1290:b0:a51:c964:3cb7 with SMTP id
 k16-20020a170906129000b00a51c9643cb7mr8240923ejb.61.1713253570188; Tue, 16
 Apr 2024 00:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411115630.38420-1-kerneljasonxing@gmail.com>
 <20240411115630.38420-6-kerneljasonxing@gmail.com> <CANn89iKf7yOUY9XA3M+Sbxhit5grH0PtJ8qyJt5gJHNaS7EHVQ@mail.gmail.com>
In-Reply-To: <CANn89iKf7yOUY9XA3M+Sbxhit5grH0PtJ8qyJt5gJHNaS7EHVQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 16 Apr 2024 15:45:33 +0800
Message-ID: <CAL+tcoAA+X3HTj5Lvir5vVzTbGMZzKx_tCw1z46uaxj8iYuOYw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/6] mptcp: support rstreason for passive reset
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 2:33=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 11, 2024 at 1:57=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > It relys on what reset options in the skb are as rfc8684 says. Reusing
> > this logic can save us much energy. This patch replaces most of the pri=
or
> > NOT_SPECIFIED reasons.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/mptcp/subflow.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index ba0a252c113f..25eaad94cb79 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -308,8 +308,12 @@ static struct dst_entry *subflow_v4_route_req(cons=
t struct sock *sk,
> >                 return dst;
> >
> >         dst_release(dst);
> > -       if (!req->syncookie)
> > -               tcp_request_sock_ops.send_reset(sk, skb, SK_RST_REASON_=
NOT_SPECIFIED);
> > +       if (!req->syncookie) {
> > +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpex=
t->reset_reason);
> > +
> > +               tcp_request_sock_ops.send_reset(sk, skb, reason);
> > +       }
> >         return NULL;
> >  }
> >
> > @@ -375,8 +379,12 @@ static struct dst_entry *subflow_v6_route_req(cons=
t struct sock *sk,
> >                 return dst;
> >
> >         dst_release(dst);
> > -       if (!req->syncookie)
> > -               tcp6_request_sock_ops.send_reset(sk, skb, SK_RST_REASON=
_NOT_SPECIFIED);
> > +       if (!req->syncookie) {
> > +               struct mptcp_ext *mpext =3D mptcp_get_ext(skb);
> > +               enum sk_rst_reason reason =3D convert_mptcp_reason(mpex=
t->reset_reason);
> > +
> > +               tcp6_request_sock_ops.send_reset(sk, skb, reason);
> > +       }
> >         return NULL;
> >  }
> >  #endif
> > @@ -783,6 +791,7 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >         bool fallback, fallback_is_fatal;
> >         struct mptcp_sock *owner;
> >         struct sock *child;
> > +       enum sk_rst_reason reason;
>
> reverse xmas tree ?

Got it. Thanks!

>
> >
> >         pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, l=
istener->conn);
> >
> > @@ -911,7 +920,8 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >         tcp_rsk(req)->drop_req =3D true;
> >         inet_csk_prepare_for_destroy_sock(child);
> >         tcp_done(child);
> > -       req->rsk_ops->send_reset(sk, skb, SK_RST_REASON_NOT_SPECIFIED);
> > +       reason =3D convert_mptcp_reason(mptcp_get_ext(skb)->reset_reaso=
n);
> > +       req->rsk_ops->send_reset(sk, skb, reason);
> >
> >         /* The last child reference will be released by the caller */
> >         return child;
> > --
> > 2.37.3
> >
