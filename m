Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0483654673
	for <mptcp@lists.linux.dev>; Mon,  4 Aug 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754327376; cv=none; b=GdigZW4AJHBR70nTNOvIebMMCp+32KL58Lf9IIo7EJQ5Zb+BLWbjjA91U7IwDThi1RJINv7TaD+/n49+6o8vJBdVkQ9gvlBM2a8iGW7/C1XvgRotS6y6Wad6tU3DRdB6IjFMWDmELlBUlUArU+5+L4WNRMMYiwy4jmO4JukJNd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754327376; c=relaxed/simple;
	bh=fwpKlMWerpu2njMUN8D1Ry9INUNMAzGtQKQK3oCUUeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GemGy3wnHl7LyLdLmNQYpy2Z+sVvemZgna9zfegJhWb4kwjin7BLtTYYR91mIalfrARTylOJuAFB3mNsDQlAQaWFZ4A2Wo1ie8lAVj1Na7of1+gPkMg08GBon23w+Sb0jbhqF5x/xaDG74+gd6kauPuF/rUeaKSPbDdH5K9reJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YQ/A4R9R; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YQ/A4R9R"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-33211f7f06eso39726601fa.2
        for <mptcp@lists.linux.dev>; Mon, 04 Aug 2025 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754327373; x=1754932173; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwpKlMWerpu2njMUN8D1Ry9INUNMAzGtQKQK3oCUUeA=;
        b=YQ/A4R9R09/HRKoVZcnCjLsbwUXTvsjVcxjU0Ip07jC6kRPTWmHtCTKp3wBvuXgL5x
         6ZgwIIwNGGYyCEw0GMx/TSikI2C49lqNwpaYQ7EncR8ntBN2qilYv7YxyvX6UlVf4RYM
         ovqybhhnJZsay5FzRcfKvkoghud6vDtnsFsz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754327373; x=1754932173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwpKlMWerpu2njMUN8D1Ry9INUNMAzGtQKQK3oCUUeA=;
        b=jb+ICts1yqnSG01R3fMypZ+RkFp4zJWmXAFvxZE93CrywoBt3QEd2uvKZWjvXPZDUq
         RNCd40D61jada5hMYoMp1YTUSLbTkAm8nZVqn8/Pq48BwsH0DlAuh+3eCZn1lKAQ6df8
         FjXcmZPhNwINwEeBc4L9hYVI6OKr2KHOzn5cT/RMKhcY5LhacktD9bovWjYFbphOi1nN
         bQHKK0AKOSh7XCuRh5Ol3GLbpGQO79lbN7317NAs+icwloWwosZUoeoeWnRlvjPCM8j0
         XIjCz8ZybJQ3D0Xs2snnj1nIzBUEAM1SvPfU1X9PlAze/R95zbN9nJVLz1DXgaTaSMm1
         GrIA==
X-Gm-Message-State: AOJu0Yyxpjh55fgVpKeTUjk/ZDDi25hxiZtAl6GhVawamKU+PPH/PkZr
	Zu9/CTK9fkCBL+8vSXeJzJgB2CbKE15Y2z37voONsJncF/6h4jILJuXHi5MdFwUJitMCL36yJk/
	U/SCYQnt0x6nMzc3SFKFFdoR4581YkUGc9z639+mTCp/M0zHeB+L88qQ=
X-Gm-Gg: ASbGnctgn3clEgRSioCM96OWRjeZDcusL/Z4XuoBo2V1y9+CKD6BxucBqbx1G1izmCn
	zKdxDPbeTSILEdFei8bFopllJ/fl/D3B1fMTZf45YyQQTgDys5pCtfJFjl3tfisgPRRJhTy9ny5
	U8Sin9jCw32CaVslrcfqb9xzLpMsVfqF05XM851HWzQCGVuL1UM/P+oNf9zqjeLQlhh36DASi+8
	z25D/40
X-Google-Smtp-Source: AGHT+IHovRfLx8dF5QVFrc2geKkdc1Ira7CaLBVvajiSMBX15b+KunSziGntxPHRZkW7tvYK26/nmvrad8GvTaCmZa4=
X-Received: by 2002:a05:651c:b2a:b0:32a:888e:b30f with SMTP id
 38308e7fff4ca-3325669519fmr26385481fa.6.1754327372945; Mon, 04 Aug 2025
 10:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250802-b4-mptcp_setsockopt-v1-0-50d4905a4c2b@openai.com>
 <20250802-b4-mptcp_setsockopt-v1-2-50d4905a4c2b@openai.com> <fec77e23-020c-4bdb-b937-df11685dd6ca@kernel.org>
In-Reply-To: <fec77e23-020c-4bdb-b937-df11685dd6ca@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Mon, 4 Aug 2025 10:09:21 -0700
X-Gm-Features: Ac12FXwLXryXADYwv1dKvrFPyEARHdzEbjwBsLeKOyjUZzvvgqu3QhooUnqxMk4
Message-ID: <CADg4-L-nk1-WZjBZ0iQ_ZNvrjttELypJ=4YvQx3AG9wtmjUYBw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 2/2] selftests: Add tests for SO_MAX_PACING_RATE
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 5:04=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org>=
 wrote:
>
> Hi Christoph,
>
> On 03/08/2025 01:52, Christoph Paasch via B4 Relay wrote:
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > Add a test to check the API for SO_MAX_PACING_RATE in MPTCP.
>
> This test only checks if some values can be set or not, but most of that
> is checked by the code in net/core/sock.c, not really related to MPTCP.
> Do you think it is worth it?

I think it's useful :-)

> Could we eventually have a test checking the expected rate when using
> multiple subflows? Or would it be too complex? I guess not something
> easy to do with Packetdrill, right?

In a past life I have implemented packetdrill tests for
SO_MAX_PACING_RATE. It's possible, but means that we have to run
packetdrill with minimal `--tolerance_usecs`. We have to agree that we
want to go down this route. IMO getting rid of --tolerance_usecs is
possible and it is a good thing to do. You can get tests stable that
way. It does take some time though.

Another approach to test this with selftests is to set the pacing-rate
and do some simple bulk-data transfer and measure how much data
reached the receiver.


Christoph
