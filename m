Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31215ECEA
	for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757361; cv=none; b=Y0Wv5FiJUtQtWr6FfRKrs3ZVa6t8lOvvv6DMwiffbgnr/leLCR++SSGPgbUYuLxnbz7zDULKY2wOx+OWB1IOE7GGWzGSp69tVprWkT13Wove7xVOWoOy903BhvtAS+uNFxFF+kCXmkNbXQfvQTtdt6yIz25Iu4fXLPHVYNrCzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757361; c=relaxed/simple;
	bh=2itrPDvQqyqeFaRt8NzSdpPSErUeSETmFVRFFPor3nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CU2fLXInLjPJiD+znsdyfery0mb8w64D7E7eduvSjmV7M5ZE7uGjwtoLgW9uOVxhaZXc+p48bCF9Xb7Wq0dc/y1LT+zJNquPce2WJUwyCHDnCTvzOx8lu1sY4HKc3PZDM0aWEyS9b1VveKZhEQzQi1IDHtUt7mj2DOm3COlsSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itx5WoSH; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itx5WoSH"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6f4ee104so3091576a12.2
        for <mptcp@lists.linux.dev>; Wed, 10 Apr 2024 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712757358; x=1713362158; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWQlsDTYX7kv+ayRisA7/g7aN7I7JCIFXwuugQXW9Og=;
        b=itx5WoSHNpazjFmlodMuZ9OD73OOHX9+UKxccrZGvedi3jaz1Z/Fl+dIz/7WtqA4Bn
         dlQI6iUusJNggGDUlZJac+7TxYiZdQXc5rieb3qI4Ql9jGK38iGvpGGC8IckTZvwP1C8
         ZGa6wLU2dikOzBCBHxH8cL0MfBXsdqZdZEWhsNV/wrtI7O8aw4LHznJC5sx8qdFnr+bJ
         DkXjcZTRJwq4xym5uCQ15vYGU/TIJp/BGTm76Mqd4Q+TJnAWRIWAPwZqkYExDxQ9VaP3
         yhC66vJSENx9Yuh1z8LinftRVZzM1XDROnKrVLsNclnDwc1qNpbMsHhjCP2nlpCcvOrY
         4ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757358; x=1713362158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWQlsDTYX7kv+ayRisA7/g7aN7I7JCIFXwuugQXW9Og=;
        b=ETiYXCciiQ06n0t6aUzBvYeDQvlJWxpz5rKBKY+UoJ+Jlq87G/A9JCEpjrrDAUxLNy
         yPLMe4E8fVfxLh9jUCZYbX92zqwKSEPt7Xo9lNhSWSE+Llogkm6ldxsJlpEVJc9tZC+J
         MXy+6FYS/Xlu84y/5bIRdzsKVcXhOJUtnp7/3ZzXcafCMH7aGm5R7Hs2g24U1gmye66p
         Nh6M68g79iFX//BsCtv5y9jooiFISVcpRJbtrTQIfzq/hiPXD0tmcKJ5F5Qujl+1iyjx
         4WKgWu6GnKjT93Hm1oQpVQyMvtnNV55FOn9r+3bpFeOIGqHJxcy2ZR2gKj6tGJ4nRdxj
         tuUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1NfIALrgW5basgRuumVJiD0oj7b22U4tBT15giMdvSC9CUI+qawE8QByTrqG8oyTso6asaPx2B9PFrZ5gUR/ktOGDItg=
X-Gm-Message-State: AOJu0YzO6Idu5C0ejF47KqaH5Bvu3DbY4qrL/LNG69C1d/1AVPXGoUPp
	jB0B7cZSHHi+paHf3CPxYtNG6gkLUQ7S7yHHXtovWX8j9tPhGWbRBwVt+T2fVOpARzedyuRUH0k
	DaHSveRwJx+9IkV6IWdHnBDDl6zu0Nc62
X-Google-Smtp-Source: AGHT+IENVXsgKB+31fO+svP4FXBa8f0BYNY349jc/+9Z5zgvSx/G+YkJ/+z+Q4TwbSXYF7YRjy0MwLX/L1AUCXb3Tl8=
X-Received: by 2002:a17:906:1b4a:b0:a51:dc1f:a44b with SMTP id
 p10-20020a1709061b4a00b00a51dc1fa44bmr1604044ejg.29.1712757358225; Wed, 10
 Apr 2024 06:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240409100934.37725-1-kerneljasonxing@gmail.com>
 <20240409100934.37725-3-kerneljasonxing@gmail.com> <171275126085.4303.2994301700079496197@kwain>
 <CAL+tcoCk_RTp6EBiRQ96nrdN7cuY1z+zxzxepyar4nXEJkAB9A@mail.gmail.com> <171275527215.4303.17205725451869291289@kwain>
In-Reply-To: <171275527215.4303.17205725451869291289@kwain>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 10 Apr 2024 21:55:21 +0800
Message-ID: <CAL+tcoBpAOhbLC5TqwMBG6Q3hgiJYSV+ZAkZfLPNmG_OK22r1A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/6] rstreason: prepare for passive reset
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	geliang@kernel.org, kuba@kernel.org, martineau@kernel.org, 
	mathieu.desnoyers@efficios.com, matttbe@kernel.org, mhiramat@kernel.org, 
	pabeni@redhat.com, rostedt@goodmis.org, mptcp@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 9:21=E2=80=AFPM Antoine Tenart <atenart@kernel.org>=
 wrote:
>
> Quoting Jason Xing (2024-04-10 14:54:51)
> > Hi Antoine,
> >
> > On Wed, Apr 10, 2024 at 8:14=E2=80=AFPM Antoine Tenart <atenart@kernel.=
org> wrote:
> > >
> > > Quoting Jason Xing (2024-04-09 12:09:30)
> > > >         void            (*send_reset)(const struct sock *sk,
> > > > -                                     struct sk_buff *skb);
> > > > +                                     struct sk_buff *skb,
> > > > +                                     int reason);
> >
> > > what should be 'reason' harder. Eg. when looking at the code or when
> > > using BTF (to then install debugging probes with BPF) this is not
> > > obvious.
> >
> > Only one number if we want to extract the reason with BPF, right? I
> > haven't tried it.
>
> Yes, we can get 'reason'. Knowing the type helps.
>
> > > A similar approach could be done as the one used for drop reasons: en=
um
> > > skb_drop_reason is used for parameters (eg. kfree_skb_reason) but oth=
er
> > > valid values (subsystem drop reasons) can be used too if casted (to
> > > u32). We could use 'enum sk_rst_reason' and cast the other values. WD=
YT?
> >
> > I have been haunted by this 'issue' for a long time...
> >
> > Are you suggesting doing so as below for readability:
> > 1) replace the reason parameter in all the related functions (like
> > .send_reset(), tcp_v4_send_reset(), etc) by using 'enum sk_rst_reason'
> > type?
> > 2) in patch [4/6], when it needs to pass the specific reason in those
> > functions, we can cast it to 'enum sk_rst_reason'?
> >
> > One modification I just made based on this patchset if I understand cor=
rectly:
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index 4889fccbf754..e0419b8496b5 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -725,7 +725,7 @@ static bool tcp_v4_ao_sign_reset(const struct sock
> > *sk, struct sk_buff *skb,
> >   */
> >
> >  static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *s=
kb,
> > -                             int reason)
> > +                             enum sk_rst_reason reason)
> >  {
> >         const struct tcphdr *th =3D tcp_hdr(skb);
> >         struct {
> > @@ -1935,7 +1935,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff=
 *skb)
> >         return 0;
> >
> >  reset:
> > -       tcp_v4_send_reset(rsk, skb, reason);
> > +       tcp_v4_send_reset(rsk, skb, (enum sk_rst_reason)reason);
> >  discard:
> >         kfree_skb_reason(skb, reason);
> >         /* Be careful here. If this function gets more complicated and
> >
>
> That's right. I think (u32) can also be used for the cast to make the
> compiler happy in 2), but the above makes sense.

Got it :) Will update soon.

Thanks,
Jason
