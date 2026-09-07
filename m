Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9C40FDAD
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788765003; cv=pass; b=dyKj4PfE2g9zhBiEVN2HJN6Zjuts3c4y/+2bM8QLKt2aHUibfqGNgnOmdHCZApYXY+vaQfeoQqgIYyQQIR2SoNVnwWDZANwlbYwGJ6J+pBtm+D3p5VsbC7uow1hHV9ZJdHcfSklaf0Gu/gw88rAqDSoyoPjGJeCMS+0cth0sric=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788765003; c=relaxed/simple;
	bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AreHnIqnnj9MdW2P6alcoJPj4/oIAJ5RzPR9kObDJ6Z20heySa5lhEHTbyIp3RG4B7vCWxWs+vVFsMf/WDc0VGMNQLifMG+frntkkzJLjfUSeRzcWMy4gMZS04giMlKgsSgkF9+D57yS5Z7GmFnhi5H66YeHa3kUXI9Vl2sDQI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZ7wD9Fi; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZ7wD9Fi"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-90cd8e45460so49443966d6.1
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 00:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765000; cv=none;
        d=google.com; s=arc-20260327;
        b=Bu29FmKhcJ5+rqSLsRcZtaa+Pnu1h30kNrtAGEihumYjNlEWHzgneE4Bw6R1yLEQQN
         QDEe+beoVLQRF/LmgzzllcS+MTuOwJQWh3exOJj9jPlSLxg5tIVvxAxJQsxiscMMVMTK
         LlTloXvyHV7fsp9PvI7lp2UOTbyxjV6AEBqgUf98iqWbYp6xOJoPIFvud1lFlOCo43IA
         JvT+c4wVhOFXBWNrYxWGIoHxS3B2/qxur1RSPDkXxpP7MH+WhCZhE39laXRzPMsJaPrw
         iiS3CL8GaHHudtNEzNQEedI8czYCENnm480zxxT4ZxOg1U5upSr8pbg7YWCEJLK7Q6bz
         tCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        fh=vKTzbFZIHMET9CVe70GB8kO/A8+XoGMF3ybrIGMwgD8=;
        b=BbER+N2pUlEPB87+LkAzC8+PMHqIYv2xJ8QCug0yOt9GELqdSj8XA5WKxX8xC96vig
         n2MtV/cfVk4Mh9yuhzmuWXcaxlIr8goENs42OUkgSDdimhpUyXj43FlW6HuZ8FdGr+av
         B+W6ZI+A3oiYI5xa+FJHkItgiVB5dePlqyEWnOJzbUaHQhoU0L9p8J5lBPGf5rsWVbS0
         8pS2XlAuJAY1ut20jXs8EzYSPssvs/fvQGFnJMPmzBfC5LwE2sWG1QImAC9KZXswZF+G
         GiCjHU5uNrHQD0J0jWoXPMyloDY14wyGamasQc+zynaGiEz4EW7NyIfnSGhEzysZJ1w4
         VfqA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788765000; x=1789369800; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        b=nZ7wD9Fi5sZqd0OUF2iQsPvazlf2H1A5PMCsKZ5xByTMYj7LY2TlsSbGzVqk9XLIsb
         SD8c32aib9dUW+iwtzVx+Yl0A+Lew7YZxLyNW2wuQLxek5AB6o/WX+5JQGwe6bMLCvhQ
         ZpPmcfl7NY+CQbia0XuZ3CshM03GtoYNF9sXHRx1IrVxbKMqD+52EcW2hF7uVwB0tL1z
         sjTGUxXhBmcFdfk4lJxm+skCzlus5Nn7hG1RDhUtu3gT5JHRRJ8hD4YBH3b0YwRlB9Mo
         w2vwYJJXct9vO7PtOUviQ72PXMTfSV+CTiGF7YFaoMTeQUNSMLDcz04VE5calYALnBde
         yJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788765000; x=1789369800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bY8T7KF0qJSw0FCfp2fmHHR9P2/vJUU2JRlv2EGdr60=;
        b=YzLD/y0bvTwAGPGt4grC47HxhxF8EdbsTAsRv5OwW3NXf8ytfNEmUWhu5BrLBl1E6q
         BM4VhWFqh3H2/xMfuAPHoM4Y702P0ZqGIDJHe4U6Mq4mYTJWWz6DbfCRAV2OT0IIIV4S
         K1uJnGGl9PkqinHSrHEnwn41/APM5tgYQhMLSleAD5NPDPcUTcbTBfAGzpyMAgl7YCAW
         /yN+h6uWbMqSNI+3d6+Hh2868/AY7cZAB5CXVMWQsk/FOPHLuQhy1Gpp6Sqi3RXZKrFf
         aSPuF7VKxOGEi1ULKj+tTfoMo4ITUvhQe+qfdHHlT4kw+zSAhLXAc9fQshNxsygWAZ61
         D2rQ==
X-Forwarded-Encrypted: i=1; AKwUvBzse8ygSNuSPAqNyw5UyB9t3Wpe99fzMbHi7+L0yOP72dDi3rUEKeSlSKocdifa0ZzRPqXuZw==@lists.linux.dev
X-Gm-Message-State: AFuF++mvpV7k+xIHifUQqBEauSeYd5F8CvfuL4h9Zh5CntiJu4ZX0kqe
	WlYR2nLnMMDgakIaKOzu5H6/ONpHD9VlbpRv39j1J0+GsC5B1wDpRWBUg33LqPTI1l5ZOtAe0UY
	1E1RPd+5NSTfUA0ty1M4FfuZvLmjKCNr/wP6OIZT/
X-Gm-Gg: AYBFou0+HqWUE+2NXTY6YCMXbutJBibbfh0XSO/PdxgOnGH7ao5U6Ob/RsSvu3UrTVn
	SBKcZTX0d8fMGgWTQXuexwtav1fC4a4fyc3SQvNgV8DSU3Wb5O6JmGqej9nQ2Ld+9R521Sd/sSK
	Wgw/A78PbaRSDRob2rbZM5QWO6ZB+2cMG7efUpjp1HAVwMbNKcbBxvH4veA2Zz24R88KTY0M5xN
	siFmT1ltMXwfs/JPzHeC4lvj9l8C4IHh9HjlzQCOpYy0IW4BwaVlEWPaq4lVgpvxTUsqQUXDwby
	gPovceteZ4SeEPlI5PchQ/ukUDZFXt8mpVQPYmuw3pcjwvmvPSSG/Fju4Ie9GNPWF9aRImkbUzQ
	0nrIQeC5PEK0miRKmi9N36SrHErW7zcT1CingGH1VRyBdIpz5v/QQkBkqBPFR1cZj84A6
X-Received: by 2002:a05:622a:1f98:b0:530:31c8:a302 with SMTP id
 d75a77b69052e-5305495da66mr256081741cf.23.1788764999462; Mon, 07 Sep 2026
 00:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1788248601.git.zihanx@nebusec.ai> <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
In-Reply-To: <db1f34ca8461c7b0dc5ec504ea1b99c24b909e34.1788248601.git.zihanx@nebusec.ai>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 09:09:47 +0200
X-Gm-Features: AcwNN1UdIl3PlzbDUGiFbT4WHqVNX_a67HKQKn1qGUPRwr6NlLZpE3hbS-2nlZ4
Message-ID: <CANn89iKzChGpDLsJ6iKRsMvHKdW6r_9xvkQv9g6bTy_-Pt8xOw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] mptcp: diag: bound listener bucket lock hold
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mptcp@lists.linux.dev, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Guillaume Nault <gnault@redhat.com>, Florian Westphal <fw@strlen.de>, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 2:54=E2=80=AFPM Zihan Xi <zihanx@nebusec.ai> wrote:
>
> MPTCP listener diag dumping reuses sk_diag_dump(), which executes
> inet_diag_bc_sk() before filling the netlink reply. The listener walk in
> mptcp_diag_dump_listeners() currently performs that work while holding th=
e
> listener bucket lock.
>
> The time spent under the listener bucket lock can therefore grow with the
> number of sockets visited and with per-socket dump work. The resume state
> also requires later batches to revisit the bucket prefix.
>
> Fix this by collecting only referenced listener sockets while holding the
> bucket lock. After dropping it, re-check the listener properties, obtain
> the parent MPTCP socket reference, and call sk_diag_dump(). Keep a
> referenced cursor so later batches resume after the previous listener
> instead of rescanning the bucket head. Validate a cursor against the
> current listener bucket and TCP_LISTEN state before resuming from it.
> After dropping the lock, read icsk_ulp_data with rcu_dereference().
>
> Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

pw-bot: rejected

Please limit the complexity of filters.

Anyone needing complex filters will implement them in user space.
