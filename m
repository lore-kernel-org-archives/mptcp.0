Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7919CC15
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072580; cv=none; b=BWxSt5NQU3vVub9toC8SNMURF/07cQbHKfMyitmZDPdg7YNpvlKJqMFZCCxrg9iPYDrhKjyaweoubA6GtMtkMgf4h3NCNySkwC1H4C351ltqPAI7WtWWY1F3Jj+iYescFQbMH7GnQuqmP9xOdF3hc62z9atczHT0IZ57lzB/sV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072580; c=relaxed/simple;
	bh=M4/iFn28Od+6Cd2KcRs8NJ3WmDuoCaCTZ8vC36WHXrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3P3ICT9E1pwLcQHvqr49JtpsnUPCX5EKN31rWCXiTacFIIFjJkKuKPHzbJdOan0HPnP6/4nKZ4CirbBqsffW3oeFWRV3mPNACDrQ4RUtw6S1UplaYjTxZpi9ajfH6HdwuYThhkCPGJT/58woZxVg7QLfrdsLla+uyt4hSWe/mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRevS0vg; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRevS0vg"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846b934981aso9222241.3
        for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726072577; x=1726677377; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOXwG9rzSbHF4+3vXYNmuuV9HXBKhiP8rgnDE421J6s=;
        b=aRevS0vgv9RYtq8CPu9CwKgHjD1AIHF11Qes/UkslD5NiHWQBgOpFi3OddgEHxlaEL
         xor5sBW54lyGLTxPmOIGKVAWzvvjk2hguvzduQjMjpqKFJ3pktHEgEX4C8vZyIzvBuJw
         6WMpM2zbypZ47rgP1/6kUEpcDg9jx5D/q1L2pH2S2sPJSUynXVdVL634qyRT1aykzeie
         hh15F9mRJN2b8DVpxvwwjP1eATWeqjB5HPja7FjMFPJZUrykBcl40vvJPYpth53wTbh6
         jKsqBKQTEV0vculYTKer+UwtGrmGgulO3nLo+j31g0Dj/mp5Q3YrGWYIbgUYFaTUIB5y
         arZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726072577; x=1726677377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOXwG9rzSbHF4+3vXYNmuuV9HXBKhiP8rgnDE421J6s=;
        b=OstkfIWVk6B0cCia9nvNdlvJeQ0azGsVVPMI52i9xWO8+1PQYK/k7QppnkycflMzwb
         W0nKei/S0tkr2Bt/PQgS9tsfdibak7/3hlAxL/BWoee+VIk3sNmS8/JRwsh/qBOXACdO
         3v1dprVrYFlH9QgTaXQHpauq+4GqHsqebIiNtDqSBqmqmSwpzm/dxAwJUhUoOpLjIT02
         4i6jb5WmB5HK0fQpgTszkbzNO5btBayDQhBWqXa9YeoP1FsKFkSyahsCeB4judDSVOlv
         sLL+8dyOZrW/5LGOkrTxexbQEhC2/FIMKyo0OmNQSx8VtnGOnx0bY7bHIVnBENrrXjOR
         t7zQ==
X-Gm-Message-State: AOJu0YwGU+mzJ82WJNKtCqKUn5XkxbRaoxuyiSbROM7tyURZxSGLa1B2
	Eb2ZmWbGkps/fcEjNibCbL2133FIiHU7SnxEtrzGmFB2g69G1krdwolrA1VqIDh7t4/1MFTqDAd
	ccXa08lSbzrSHpL5r5diWqTLMKRs=
X-Google-Smtp-Source: AGHT+IFlrEh4yFyBVh1p/AqSpyGkTMPgPiuXU+UkvPQ3zSNnv+fHH9D1ljnqs2FP5w0wjqF0f+aNSpBzV3e7cnkQCBs=
X-Received: by 2002:a05:6122:318d:b0:4ef:65b6:f3b5 with SMTP id
 71dfb90a1353d-5032d51900fmr191489e0c.10.1726072577307; Wed, 11 Sep 2024
 09:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240911042425.978665-1-xiyou.wangcong@gmail.com> <81746edb-cf37-4c36-b23a-3aee2a6bd995@kernel.org>
In-Reply-To: <81746edb-cf37-4c36-b23a-3aee2a6bd995@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Wed, 11 Sep 2024 09:36:05 -0700
Message-ID: <CAM_iQpUMahuiFtuw9N0B6nV1hdAVZpGezEyrBxLeOhJwn2RvQQ@mail.gmail.com>
Subject: Re: [Patch net v2] mptcp: initialize sock lock with its own lockdep keys
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Cong Wang <cong.wang@bytedance.com>, 
	syzbot+f4aacdfef2c6a6529c3e@syzkaller.appspotmail.com, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 1:25=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 9abc4fe25953..747d7e479d69 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2325,6 +2325,8 @@ struct sock *sk_clone_lock(const struct sock *sk,=
 const gfp_t priority)
> >       }
> >       sk_node_init(&newsk->sk_node);
> >       sock_lock_init(newsk);
> > +     if (prot->init_clone)
> > +             prot->init_clone(newsk);
> As mentioned on the v1, if the idea is to introduce a new hook here,
> maybe it can replace the call to sock_lock_init() when this new function
> pointer is defined. In this case, it could be renamed 'lock_init' or
> 'init_lock'. But no need to send a new version for the moment, please
> see below.

Two reasons why I don't think it is a better name:

1. It indicates we only initialize the lock, but the parameter we pass to i=
t
is struct sock pointer, not any lock pointer.

2. We have to distinguish clone path from regular sock init path,
otherwise people may interpret as if it were called for every initializatio=
n.
Hence, mentioning 'clone' in the name is very necessary.

>
> I suggest the following plan if that OK: because the initial report was
> a false positive, there are modification of the core, and because we are
> a bit in the middle of other things, I suggest not rushing up with this
> patch. We can look at it in more details when the other things will calm
> down, very likely in ~2 weeks, after LPC.

Sure, no rush at all. Like I already mentioned, this patch should not targe=
t
-stable, possibly not even -net.

Thanks.
