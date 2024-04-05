Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253815FD05
	for <mptcp@lists.linux.dev>; Fri,  5 Apr 2024 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308306; cv=none; b=XcQ3TZgmU7gSIOai9fPU1FxB0cd0UNxMWfWEYGeAeJ7vshUf+YiGammVacUqBzs95k8+KnTw4OM7TBJqqflIUeT3ttABjNCgrbO8tdnuHeFY5XFt4HMVqzZqFZ0w1Qs121NzEMBXT/VBkDOu9/gekuJiBLs8im51ihlSN+oHqI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308306; c=relaxed/simple;
	bh=LmBXoWInajfE9xBuj2UZYG0+rLoVhICctMDwspO9QyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fk+HfBFA88KjSXjtjnQ0mdH5aQsOrhIBPUNh2zDPz6aLM7nJdI83tDQAhtkGZOGoJLVY8X+PdqaC4C2vKaA0g/GwkFZg6ifubLDhjnWdY3RK75QLNuwyv+eneevz4vyo47bSEItY2arJxLxyhOjrz8H78jGJo21XyI7b1B+uHbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmJuLl1R; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmJuLl1R"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a519ef3054bso86090466b.1
        for <mptcp@lists.linux.dev>; Fri, 05 Apr 2024 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712308303; x=1712913103; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LmBXoWInajfE9xBuj2UZYG0+rLoVhICctMDwspO9QyM=;
        b=GmJuLl1REDMYB+RvpU03gw1zqYdAIPK6J/UgZ4k46EXfXiyZIgRpr2MATHgcbTeRLQ
         yN1Ob1xVHeoPDTilY2bZPjtdxz139s7xvlzzLkprsn9TbCY1x2QdoMu/n//P6ihAY7RR
         oKoZZIYuGu0nNk30DdFaYeWpIPXZMcuseHXbbvlYaC8PpwEc9M2b0qfuy3RBsGTUp9fY
         DhN08leOMI4DOxaiaRXVsFuNLcuIgWuhNKfqtev1o39GDshUKLRz5HbybX+Fq3LYve/5
         FncPoabmgPptheFvIWMLMf5IqcA90VazK2Xe4bakBReylgFm68nV10SDlH3JjPXur9Li
         V2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308303; x=1712913103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmBXoWInajfE9xBuj2UZYG0+rLoVhICctMDwspO9QyM=;
        b=CZNUPUA7FJxQ2nTjFnh82EhqiiiJrS3qngFYoqTfMYfpu9+kbhzN5yz7JtsanWT9BT
         45L1rvtH9ctCl7Wg1aXWmptRNg0CLt0FwBZWgJi5nh4N05wbBHdZA58XjBLL9I9Rnfdn
         09s9mDwCcWgss019tXqizzWVlmYvYrGHPWhTdHHiOsouCZKclmUB6bAnwBe3J903ZUKX
         8tTqiEB2Tcbib3O1FcMac4oTKZH+4Pr/IcJnlaHvIB+yygxU5g5/CIIob45qlLc0g2Zi
         rnxwXAN1KZ1HvXGJkMfn3VTGGI8o5SP4V2x8TQW+Jp2XKs9z5fHwvQe5if8tv3B7svO0
         GwdA==
X-Forwarded-Encrypted: i=1; AJvYcCX0+kNojclT64dAPIVR1wnR86NGqEFM+01xUZjGApl2MYC2l2Gps3w6827TFVVDImzHnsKGAxITqNw8o0ItMfBx8aPZoYQ=
X-Gm-Message-State: AOJu0YxZTxqXcnnNoVP4LvIlNQc9auH4IGctB1JBZ6IT2SXxh3+Iryr+
	VicYKRob0NTgtYsfn0KzYWNSwBj9wdjIlExQo1Cdqbie61AHG75BNnuQUYb3sOLrMvmMkkntX4s
	sqSFdLRcDsrLOk6yaueSxOF7gS4E=
X-Google-Smtp-Source: AGHT+IEEPo8HEBxHiQd6Gt7/FDnKq9efCmeTXDQp0f/A+PCZoOWH/Nuodq5vo9IuIrQXcrOSGB7QK6gmH6ao3HKBn8Y=
X-Received: by 2002:a17:906:ac7:b0:a51:98df:f669 with SMTP id
 z7-20020a1709060ac700b00a5198dff669mr480152ejf.43.1712308303134; Fri, 05 Apr
 2024 02:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
 <20240405023914.54872-2-kerneljasonxing@gmail.com> <a0e75cbda948d9911425d8464ea47c92ab2eee3b.camel@redhat.com>
 <CAL+tcoBEkK-ncB6zdJrq7kkd3MEdyT7_ONOyB=0cVVR_oj-4yA@mail.gmail.com> <6b77ce4f71dae82a0be793cf17fac4fda0884501.camel@redhat.com>
In-Reply-To: <6b77ce4f71dae82a0be793cf17fac4fda0884501.camel@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 5 Apr 2024 17:11:05 +0800
Message-ID: <CAL+tcoBFS9Z-=H5g8hoyDVuvcmT+wEuAdT6GxyS-vh0hKdE8cw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paolo,

On Fri, Apr 5, 2024 at 4:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Fri, 2024-04-05 at 15:58 +0800, Jason Xing wrote:
> > Hello Paolo,
> >
> > On Fri, Apr 5, 2024 at 3:47=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On Fri, 2024-04-05 at 10:39 +0800, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Before this, what mptcp_reset_option() checks is totally the same a=
s
> > > > mptcp_get_ext() does, so we could skip it.
> > >
> > > Note that the somewhat duplicate test is (a possibly not great)
> > > optimization to avoid jumping in the mptcp code (possible icache
> > > misses) for plain TCP sockets.
> > >
> > > I guess we want to maintain it.
> >
> > Okay, I just read code and found the duplication but may I ask why it
> > has something to do with icache misses?
>
> The first check/mptcp_get_ext() is in mptcp_reset_option() /
> tcp_v4_send_reset(). For plain TCP socket it will fail and the
> execution will continue inside the same compilation unit. The code
> locality should avoid icaches misses around there.
>
> Removing such check, even when processing plain TCP packets, the code
> execution will have to call into mptcp_get_reset_option() in the mptcp
> code, decreasing the code locality and increasing the chance of icache
> misses.

Interesting. Thanks for the explanation:)

>
> I don't have actual profile data, so this is an early optimization (and
> thus root of all evil), but sounds reasonable to me (yep, I'm biased!)

I'll drop this patch.

Thanks,
Jason

>
> Cheers,
>
> Paolo
>
