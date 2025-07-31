Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB6613DBA0
	for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977741; cv=none; b=dtPEo3JxvkQnzGNj7SKKcJK5q+6VyqG88iw66JyjVtnd8KspB+zfS8G7rzL0yinjwntFpQ5Z/GDHsbkCTk5hMtSHQF49tn4BUwU76zAdEI0ePNB2AI7AW1TfZSOZFCexnBsEoOanENcqYWV+6e/YS7m3CzQic0DQJc39ofZ7LIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977741; c=relaxed/simple;
	bh=SaiAFvjsbAixRHehEj6kY73Sao1RXq1xuyWlPELxqZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZkivHI3vkvMwwcCwIyXfNUAr+ADCDsJ2GvA6TG/TCQd1Sclh0HooyBxqBKUv9PEzlnxTQGdro2bZ8Z4wtJ67QywfMVAPsMLkF2GDz5pui7EoFJwJjv0p3quFpJKiAGZhkWNLhD0EoI2A4T5/IQScFH/ffDmk+cA+Cyp1Z13y6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=U51XXhS6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="U51XXhS6"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso11742241fa.1
        for <mptcp@lists.linux.dev>; Thu, 31 Jul 2025 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1753977737; x=1754582537; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaiAFvjsbAixRHehEj6kY73Sao1RXq1xuyWlPELxqZM=;
        b=U51XXhS6DPwQ5AQ1QR7xnewovhlNcAMBgLR0nuEWHm/DHDSoZvkNx+ENQn+TYActa/
         gElwItLDAedTxi0cB/FuINdjfA+sMxKrcdnz+Fq40dXZLyw/mZ0N0c4fiJ5ZeX4BjVE+
         SWwRG8RxI5gGNyMHak2JlqkWwJtTbhgHTvtJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753977737; x=1754582537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaiAFvjsbAixRHehEj6kY73Sao1RXq1xuyWlPELxqZM=;
        b=ivV2nipd5Pi9zTQKQAVknPAlQ4y74V0VfseE0su5J6B1GkH8b/RGqXAXBg7iBsUTgT
         gs7Qx5WQ0kehaRwFcT9irvtx05+uBsYFuOevqi4jUHqkFrFH7QLrSQwGJXC3xCPKyvIW
         3cWPO3iS8/nG0PjkP1g/r6CRcqA1zEuXN+HuWKmRrgzrmFUnwmyHDxp53Hsvd+CFg6Z+
         86SYZewfaJUxHrMqhADz9k33CN+cNMa0hjBBgYN0k+SuD2cpt50SF9wvAtLEun8LTlvw
         W7WBqS0G3zED5lFG0YsPfZah9C/erQErHk99Dyerd4pKCSQ7EZck/tpkq65/2Yrwtmo1
         K6fw==
X-Forwarded-Encrypted: i=1; AJvYcCXlaCa4mhtPUK+ioJVKZmaychpfj4UnRvL9OCb+ofCH3FR39dezrKOgiyB65eScT5wqnQ8d7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+YvCc4q3HkqjeCIzdGX+MS3aklJoyIK9tc3PYVIeUCyfi+OcM
	wUndsuBKSad1TMBxhxGn8pleSGVClde/yfyCcus82muL88lFb5meWehAhurM6qEDqymTaAYMsq+
	xmRnC3+6dWTgAd5F8xspbAF/xgICG2/Jx1KzT4+0UDg==
X-Gm-Gg: ASbGncseWgZII658C1mBNusEI0MMfaurhTFUz2TkbTZXgf6+1tXC+CEynvtHo0srKLr
	hy98+wLF7Jmemhgl7/Uysza+LywWJPQcbbpOn5jxiyGVKuA7ncGCwyId2/yY/dbRkGBmtp7Z/f0
	1PGm8WoeRe5XZn3+ntTIdR6jK2/QUCGHtFtVB3vjOwiEIPQ2rFC4ncHxeU8vEpwcOktwZs4ZaMD
	09aPw==
X-Google-Smtp-Source: AGHT+IFLavFeg0RCMc42UogBxUxJ897pNl3YNiu937KvpqfZTRWu7RCzyBrGH4qkWA881+Z5B6hIFMC7OqFS8u/p/1M=
X-Received: by 2002:a05:651c:1402:b0:332:197e:f746 with SMTP id
 38308e7fff4ca-33224a54833mr19825471fa.6.1753977736055; Thu, 31 Jul 2025
 09:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1753859907.git.tanggeliang@kylinos.cn> <7f2aaa80eef99f64ff6d7a48ce0a6bf06d1cacab.1753859907.git.tanggeliang@kylinos.cn>
 <CADg4-L9m2=4d56kEpy48YYAaEhAe66m6fuG8qN_MdGi9W_GURg@mail.gmail.com> <9aa94cff-872b-4831-9f38-ce291f2c0a9f@kernel.org>
In-Reply-To: <9aa94cff-872b-4831-9f38-ce291f2c0a9f@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 31 Jul 2025 09:02:04 -0700
X-Gm-Features: Ac12FXxiYv9I6RI2-Rm89xMcQPNj6tjT44CDpPA0bUgSHO_4op2vw3r4XTzGfI4
Message-ID: <CADg4-L-yMQ8k82sVGjzPPq_yNWoWnGOrYXdYOOJmXJmmQNoC-A@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: setsockopt support for TCP_MD5SIG
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, 
	Geliang Tang <tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:40=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 31/07/2025 00:19, Christoph Paasch wrote:
> > Hello!
> >
> > On Wed, Jul 30, 2025 at 12:22=E2=80=AFAM Geliang Tang <geliang@kernel.o=
rg> wrote:
> >>
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> This adds setsockopt support for TCP_MD5SIG and TCP_MD5SIG_EXT options=
.
> >> The implementation:
> >> - Allows setting these options (getsockopt remains unsupported)
> >> - Applies them only to the first subflow
> >> - Maintains MD5 compatibility limitations with MPTCP
> >>
> >> Note that TCP_MD5SIG and TCP_MD5SIG_EXT are unsupported for TCP too.
> >
> > Is there even enough option-space to have co-existence of MPTCP with
> > TCP_MD5 ? I don't think so, right ?
> >
> > The only way they can co-exist is if a bunch of other options are
> > disabled. And in that case, do we really want to use non-MD5 on
> > subsequent subflows ? I doubt that, because the goal of TCP-MD5 is to
> > "improve" security.
>
> Correct, there is not enough space, and it doesn't make sense to use
> MPTCP with TCP_MD5.
>
> The patch description should be clearer about that: supporting TCP_MD5
> makes sense when MPTCP is used by default when creating a socket. With
> Go, all "stream" listening sockets are MPTCP sockets. MPTCP might not be
> used, but without this series, we have a "regression" compared to TCP
> because TCP_MD5 cannot be used.
>
> See: https://github.com/multipath-tcp/mptcp_net-next/issues/575
>
> > So, shouldn't we rather disable MPTCP always when an app sets TCP_MD5SI=
G ?
>
> Yes, but no need to do anything else, because a fallback will be done in
> mptcp_connect() and subflow_check_req(). (even if I guess an extra
> protection is always OK there).

Alright! Now I see the code in subflow_check_req(). But, it looks like
we send a RST, no ? I can give it a try later.


Christoph

>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
