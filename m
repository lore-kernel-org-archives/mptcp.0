Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265FC1118E
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRRx7M3z"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a2536adaf3so25443317b3.2
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697190830; x=1697795630; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6RPI+AmmVlFElnQI1nu0oiFO2r7L++pGeSIx43RgHE=;
        b=HRRx7M3zSWBoDI0dl+LnYJRZ+Eaa4rkgJFChIZ64Zlv9B6QSnvkTFaoW6bAvp/mFRB
         7CPveXVa7uUbK1i+9EQIsZl+V9wEgvV1Lpd5sLhWINjHvUFgdll2GlaLD1UJQWMhBfYA
         tHjCKjmB6ys9EP9B1jx73inOZ8cNmBNXYR4Gr/j75Mj4qYqqCePs8jdKCoHVHPTQ8l4K
         OlXh5rTu8ZeTmVzKT8kh9gQLEM/CR+aMqLcrRBKTcBBbTzntGeNWTaE4/28A5nRZTQWL
         tXjfidFfqvGVd1Wnabzf3yLn2j5luMsDmdM8OWQ/XFTHc2BQFH0pcwVFXzyGmVYROkxD
         i1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697190830; x=1697795630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6RPI+AmmVlFElnQI1nu0oiFO2r7L++pGeSIx43RgHE=;
        b=JxzcJaHsECZusNBFQkgN3zNUg6dxcNEVMdfD1NC5FS8XF+8gux1URLEA3nIliFMVVG
         IdSZot7+0T2xIZGNZQSRhPeyutksa2i052fDMVOfLMWbtJpzHI7guxwjsUiJJ2dmAlEN
         jnxrrgeqm20avOQuI7NkOUMCi/hT8KPgWUmkMXPPqyyhfI6m1CtZTT+tu+4B8cEcgC1G
         kjy7GDm4zLQp0eQ4yDX11SIDKbDyaT1Hi74nMPMU0W5e2dujPaUC52ART3wL2niPuxMx
         Tq+Fb4UxOsdPFvb0iogL+ctnvcdRDMllzBI6Pxg1Zg4dBrH/P92BIg3iVr1NDLLeEBWp
         +urA==
X-Gm-Message-State: AOJu0YyN8QspZGNtpt3AN+z81P4MmNnWbo4aXKy0EKTcDW71nhNm4VcL
	ubbYR5IZ/+rpy+T47+RkJYc32up2bva9p+OdnQ==
X-Google-Smtp-Source: AGHT+IEbWtAuAIudURq7Y6vh+aTNWk+yzFlwiqDGqNXdoZ6EbrF9qiOkM8LQfcz6pcssekCIZKjVz/40NL3gWcesPVo=
X-Received: by 2002:a25:d793:0:b0:d9b:405:a104 with SMTP id
 o141-20020a25d793000000b00d9b0405a104mr1713323ybg.18.1697190829898; Fri, 13
 Oct 2023 02:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
 <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
 <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com> <8918fc5c5d112b6cbfd0ac28345a1c33afcb09b9.camel@redhat.com>
In-Reply-To: <8918fc5c5d112b6cbfd0ac28345a1c33afcb09b9.camel@redhat.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Fri, 13 Oct 2023 17:53:39 +0800
Message-ID: <CAMaK5_joufX_xyRfy=0L=2OnSu4ui-mnprqL_BUfC4_ftN=y=Q@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are waiting
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, mptcp@lists.linux.dev, 
	Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi.
My apologizes, i will send my clarifying to you separately later.
and thanks for your suggestion and clarifying.

Regards
Guo Xin

On Fri, Oct 13, 2023 at 5:25=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On Fri, 2023-10-13 at 12:42 +0800, Xin Guo wrote:
> > In my view, this patch is NOT so good, and it seems that trying to fix
> > a problem temporarily without knowing its root cause,
>
> First thing first, please avoid top posting when replying to the ML.
>
> I don't follow the above statement. The root case of the problem
> addressed here is stated in the commit message: the blamed commit
> explicitly disables a functionality used by the user-space. We must
> avoid breaking the user-space.
>
> > because sk_wait_event function should know nothing about the other
> > functions were called or not,
> > but now this patch added a logic to let sk_wait_event know the
> > specific tcp_dissconnect function was called by other threads or NOT,
> > honestly speaking, it is NOT a good designation,
>
> Why?
>
> > so what is root cause about the problem which [0] commit want to fix?
>
> The mentioned commit changelog is quite descriptive about the problem,
> please read it.
>
> > can we have a way to fix it directly instead of denying
> > tcp_disconnect() when threads are waiting?
>
> Yes, this patch.
>
>
> Cheers,
>
> Paolo
>
