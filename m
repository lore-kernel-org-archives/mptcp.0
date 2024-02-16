Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4138F
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 00:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041913; cv=none; b=ft6roC7TvsRuMfepv9DQQL52ZBWkvbV4FfZxx07imvLZHUKHuol+ER4rOd6DiK00Zaw3eRmt7nsK4Pf0e1bQQcfUCTqOnHMMpdkpZ8MmbKfpv13veLrp7okoCU4b1vgM8C+z7Z2bt8FzB0kg8szuCxDxA5lU29ifl+g2awnIFxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041913; c=relaxed/simple;
	bh=LoOnC4FQRv0F/O+cUjwXbOIDhDRls+e8GzdMRDc8KhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHwBubuagHVcyAu2b/ksV9jaSVqqZUpAUKBVjFv8coMRZLYLO9HaV1jZ9xfbhqQPQw3Ydw3clKqxDsUbMaKHg5rWVg0YpUkep4akz/K0VXQOfl6Vam9TjyXZfe1vjtfZbmYMQI9YnhcdG/6FqmGTPELM7ei2uFmGO2Q2+cxbD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdZRh0BY; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdZRh0BY"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5c890c67fso723604241.0
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708041910; x=1708646710; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diXWtKNJBAfA4PgnFo0WoPDjp1XguB77YFwSlLLsiFQ=;
        b=xdZRh0BYHxhwRpK7+94+dEHiznpNHdV1zZ/TowK2eYKr944KRxEv1UkHg9xyvZcLNZ
         IRSlnTiK8CoxG2nHslbDagLU3kU5mFuchZAPNzdgKCewAGLyj1J3YbHwEkJPgsY9r8v/
         QKqEtxGeKZ9c4M0FM2wy1RUmtPxW/uuDxVSQem8buh86JLquk9UwX/21wFnw11vfGaLv
         DuLRqqfx3k5hosy0060R0O2duByWGvDuFa/pDDsXLBNHBiEOwz1MmMuELlSEwH+wtQNs
         /Bns3LKCwGNl8EX3E09ZeHwsr9+4wZ5M4inc0BldewifIQF3Muwe/q8va2/DVttHjaDK
         MkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708041910; x=1708646710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diXWtKNJBAfA4PgnFo0WoPDjp1XguB77YFwSlLLsiFQ=;
        b=QaG+CL1CUULEA2JmEvjm2GKOFKyGIBL7WGjrl/aZmhfhAYDZLI7Spb4M11dut506pa
         axuGe5HDMI/AMQPJsoqkUoM3lkOLbTf1PNQoi04r90b6AY3JeYzmy8bNA+wlxTy5b7v8
         ajg1soCatPUc8covb+IokFY/isRmoIeq1W4/bdYlL/sdig/oe52aDDPk7pJOkSZUJq36
         Deb1MsNvNySAmXmeoQNZg7+Cy3Uz644IFYMY6ytfJPZ4IxSxiHjirTfdZ4TcNygXzsZz
         PmCEH0VgZYensTp15WU5AWSXBVfbm3nVQLwm1p1nDO5mADldJqMfMC0iwvS8D52M1vyv
         uxxg==
X-Forwarded-Encrypted: i=1; AJvYcCUW4Sa4Q+73OgrF+GNMcaOgn1tu7vpqPU2d/tXZdN6VZs6w6PmuxwPT4D0Sz7KG31R2I8eQ0gKd6sojQz0yE4n7v0DbtLw=
X-Gm-Message-State: AOJu0YxgfjznIzdn14z2+PQv1dXG+Owkpum2e66LCicvHw7Mt5ZBG6W9
	7G+wXvkigueaaPvH586ZMHnDQJ1puRghnRWhm06//aeDumk4Ee8YJGY+2eJvT5EzjJF7bmBLrPs
	y0J2ufGXevnVbBhBWYtnufR7pC4a79fwFemYa
X-Google-Smtp-Source: AGHT+IFIplzGzmriL1xaco+Og2hYr/egwhzq10LIBoz2G6IYXCZo3nz2w4ZXagy0mqXn2T0wS9sEvcT0l7HtxNN29lo=
X-Received: by 2002:a1f:edc1:0:b0:4c0:2181:81ac with SMTP id
 l184-20020a1fedc1000000b004c0218181acmr3240323vkh.14.1708041909812; Thu, 15
 Feb 2024 16:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADVnQykqkpNTfO30_aswZEaeSkdu5YNuKag++h-RSguALdeohw@mail.gmail.com>
 <20240215201627.14449-1-kuniyu@amazon.com>
In-Reply-To: <20240215201627.14449-1-kuniyu@amazon.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 15 Feb 2024 17:04:53 -0700
Message-ID: <CADVnQynSy8V9etoiL9jLMgqAdGwbLXnCYia4j3pp60pxbdg7zA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] net: Deprecate SO_DEBUG and reclaim SOCK_DBG bit.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, jaka@linux.ibm.com, 
	jonesrick@google.com, kuba@kernel.org, kuni1840@gmail.com, 
	linux-s390@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	soheil@google.com, wenjia@linux.ibm.com, ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 1:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Neal Cardwell <ncardwell@google.com>
> Date: Thu, 15 Feb 2024 12:57:35 -0700
> > On Tue, Feb 13, 2024 at 3:32=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >
> > > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net=
:
> > > remove SOCK_DEBUG macro") removed the macro.
> > >
> > > Now is the time to deprecate the oldest socket option.
> > >
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> >
> > I would like to kindly implore you to please not remove the
> > functionality of the SO_DEBUG socket option. This socket option is a
> > key mechanism that the Google TCP team uses for automated testing of
> > Linux TCP, including BBR congestion control.
> >
> > Widely used tools like netperf allow users to enable the SO_DEBUG
> > socket option via the command line (-g in netperf). Then debugging
> > code in the kernel can use the SOCK_DBG bit to decide whether to take
> > special actions, such as logging debug information, which can be used
> > to generate graphs or assertions about correct internal behavior. For
> > example, the transperf network testing tool that our team open-sourced
> > - https://github.com/google/transperf - uses the netperf -g/SO_DEBUG
> > mechanism to trigger debug logging that we use for testing,
> > troubleshooting, analysis, and development.
> >
> > The SO_DEBUG mechanism is nice in that it works well no matter what
> > policy an application or benchmarking tool uses for choosing other
> > attributes (like port numbers) that could conceivably be used to point
> > out connections that should receive debug treatment. For example, most
> > benchmarking or production workloads will effectively end up with
> > random port numbers, which makes port numbers hard to use  for
> > triggering debug treatment.
> >
> > This mechanism is very simple and battle-tested, it works well, and
> > IMHO it would be a tragedy to remove it. It would cause our team
> > meaningful headaches to replace it. Please keep the SO_DEBUG socket
> > option functionality as-is. :-)
> >
> > Thanks for your consideration on this!
>
> Oh that's an interesting use case!
> I didn't think of out-of-tree uses.
> Sure, I'll drop the patch.
>
> Thanks!

Great! Thank you!

neal
