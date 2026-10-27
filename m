Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793103421;
	b=PnDp9kfr/ZcSp22AKfgB9b5N0Sg6sXLI04P7ydfXeoDfUB1sCg1NvEgqQpdBHCp9O4tt
	 QfDDHN9U2AN0tjOMZCfYRX0Y5AXqPaTbA87VtUDriILZbFVNZW72ngIzn77FY0p1rkfEd
	 rtscYuObJgnNZGwBwG845rNqRfkazPKYP7lqawQ396KSS267vpIYPTantw5WMBbxRicCk
	 NCPMY+YXkte1v4/LTUXT/6uzf4w41v40N6LGTS3QRo318jeFCTlNRBn08tts7fnJSHPLO
	 xqUXcKmcKfpY7LNd95sjBxdhY2qEKTTDBK/Aqz7qjnmDtMPfKniDeZ1nWZMSDAURUIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793103421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ou9L3ul+7gUQ6PSYXY9EAXRI3nWlT3VTxyhetg/M5uI=;
	b=29JbyT6eaE5DcXAn2IVeL2FaSPWRUiEWbC2HtjgL1bPNpePdlqrjzpGKVO3Irfs6TD2K
	 R8lFTkAWfkFiDApzUYKmXaLawvNk1Csi+oDUS2Tzjbksc0Rm2FJ/GpsFfoq7KMillYAsu
	 f5nSQskwA3/PqINUm7rmH9doezpn12mIESNtLyqo2r81RYqOshRO+DiysUTdPEODFJ5YO
	 FmwswpgMVMHh/BFKZWKiDFgvK6z1UpP+C29XEiHn95dsSsP19hii43WRx4dBllxIsdtfj
	 8z8X0/YLkds3HpmHi+xhDxi0GPWTYjblttGIZtdQf4vbp3gFv+BUfTdYMh/tP6rh/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hEHEC1xb;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDE606A327
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 12:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42CDE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hEHEC1xb
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b52ba422cso31645486d6.2
        for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793103420; x=1793708220; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ou9L3ul+7gUQ6PSYXY9EAXRI3nWlT3VTxyhetg/M5uI=;
        b=hEHEC1xbxBRt1edEdZvkuPf0UUWSKcqlUi2HxD1opxw5+OkDPD9ILyXwmnTvRuU2rc
         IaJXwnlyXOa5WOUhBlHYesfZjYULnFUITsah78JdBs83jpU+APAO0dbuCvoDl1Y4LeR7
         2QjN6Homgd+uhCWViWKINIk3HI0mmycOVd6O96IPTFNcHo6zc5kzLY4r03RWeUpRQ2iX
         +lfophviJdfpu5inCeLqbFbKxNCb1ax0fZN1xE2w5Nzc36TFe4xXfRyZz8aUA0uuxVH+
         KMUp/6m/8MeRs7xrIgBITE3UP4cnNV16J16UDGf1D8I6Teb07Rygwgf9w5nm9RUk0sxY
         DOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793103420; x=1793708220;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ou9L3ul+7gUQ6PSYXY9EAXRI3nWlT3VTxyhetg/M5uI=;
        b=t770BBNnATa3o8m2azQDa1Mh3VFrjJvwtotnBP6yvK6LhwEko7hinK4LOv7ljX/I8P
         BISbBcW+ffGwSeR1h2Hg+b2B1bxbKPukq3yLqhPiarRK4hsFrNwIEDRxvLAmV02nP1Et
         Jw2lZA6+3d65JbTmi0V1q0PM/ZZnPOfHmwA0+Dqg+WSz9qMaLy4SIoaxS2Rp8x2V1Yeu
         Mf3nXn33aM2L/Hs5hmu9+AdpU/t4X5AEy2taph1k0iMFyxj230ytgcOmPDUPb4OIplia
         pSdKTYdpHBEw1IL8Ydj7B80bzGtomcqCwfjRRp6E5TqqWje6VbTF7J+Ml/XayzpmWm9n
         oj2Q==
X-Gm-Message-State: AFq9FYK5o1kZ385npSxaAiUkDO2T53R2RPTBOItHrOnY9I0hR1uqG+nx
	ID6bYIff+VxE8JhGN74+oCd77jxPMgPZFvIMPTrBuVj556fncplw8kU=
X-Gm-Gg: AYBFou1qZAZRyROY5oQD7f/7GpdC/x9o25J+fm5MX3ATRhxw2Ad+OjMG3cpLoPJEr7/
	1VnXkaMcC6lvkQnNzs/Tkm1JOWUzXBgXPJZRIefClydYjXiYwVbCsuQEQsAbKe04+p5N/6MSnos
	v2E46rxwiQJZQ4tp28ZMDql2bUXeuAkTkI/TGfcUCCC6NTgr/ksxAlF6KHYz9Tj4DE9EgDroxbl
	zJHsnrqDDRhSnH+5qQsgVGUIOAn6u8/WIgmQu4oh8SPH2u/9Rg1FTJvKQk0XibBVvHDlUqzXXd4
	Cka1jJqbr/gig1b8xulzQ/WdpSjj+loXpKT+Ao/cnLMHC25jZDzIYvBYbvx9d/LBVOMqSVFQj4y
	GpKReVkM3eHnEhh2u2h6oC6eLXHUdyfLiaJcihr93EGGLmX2HCWbKngn/DiT08tVAlfc/coX1Pu
	mFk1qqZjHsZlZiA+PX+UDkgKnvShtl3mAfrF189KDAmHmXulSXpQZBDSL0SPGrWAk8Na8Y9IXVJ
	6dMVbam1kazXAfuqQ8McxkP8dEdCuHzwDgYHvyJ18MdkqCbObexy0GAPkeg3oXpNrk=
X-Received: by 2002:a05:6214:19ea:b0:90c:4422:84d1 with SMTP id 6a1803df08f44-91c48ecb259mr161684576d6.30.1793103420012;
        Tue, 27 Oct 2026 05:17:00 -0700 (PDT)
Received: from github.com ([48.214.53.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a69853sm101141326d6.6.2026.10.27.05.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:16:59 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
References:
 <pm-mptcp-objects-candidate-0066-v5-4d1b83d62fcde2d57e8d@gmail.com>
Subject: Re: [PATCH net v2] mptcp: protect listener backlog reads in
 diagnostics
Message-ID: <68e32ffe-0caa-31fa-5efc-63a393d2a0b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:16:58 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Cen,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40495986533

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c23b9941dd=
f0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193841


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
