Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F319755B
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282115; cv=none; b=TEaaaM+bYk9gLylRQwYZlDsC4nduTV6Q545AxugMWvvgDI4GXPIRJsb9xxKUt2KDtWRbFgIQQbIoiiLNnSAyDvKgt3cvxv3wachrBv852erih21bkj8rLIdpSg5OAkq2YOvYGDCmELKwZ9pKo7NiTV4dbj25YKNpoTVZYz3hiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282115; c=relaxed/simple;
	bh=Oss+EqVYIg7uzSiIwOPqWCLhMLzHsEy12rj3LXq3haI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FIpJpAjXyBbMqSAUOO6B3y1EKcrOD+HPTHbmoEX6xLT9zk5Zznu/ed2PRHC0g+tMw0Brn/Om8f4aAmqBQMyHlFwpR7PF1dDNH3JClCNDJctk0HTtWQHl4wMZErcKPNlt3Z9dmBDziRscjLULiTYBlTEGKFEbtff6MKgp0VNsCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjA3+4Xi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjA3+4Xi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-267fac63459so18464535ad.1
        for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 04:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758282113; x=1758886913; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LglXIZebVQgf6h86EgN+kp2bs7NHDqw7C/mA8kDsewY=;
        b=IjA3+4XibBk4NL76+kmqHB8ABXnvgPHBf0Z57MKJ+jFCvAaIytC+hVmDBGKOTbS+zJ
         Go8RacKGpqTYBjfrwEr2jvMuidZ07XYBqMGGFsq6rMm5lXU3a8eDYWK0mvvrWDoonLxe
         3hzDWKABGK6vpUApQZBPE3tsp1JUK0tLwCaN0Umy1k8n7b0eOOrbCFsCmF02ZzUP8rJt
         Y8BpJmyDykbhS7COa25xHJPMzBqfgRkNjYur6Mcq6CjhRctsi553WKlJdHPauhebVPX1
         cJXI7syedsjqhyAa6TRPCBZ9ssrYp4hmb+SdoV/JEGGYlpoWFk2xVEZ3AXx8cyZBAp5+
         6aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758282113; x=1758886913;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LglXIZebVQgf6h86EgN+kp2bs7NHDqw7C/mA8kDsewY=;
        b=g5oMqWm4NuWzIkmTU/zvgdHFx77Yc4IVMQLGALMcvYes/mEJPtT5tM/eAGxTFYDriP
         bFeA9nnzTSgUMPr/Q/yIj1loXCRHr+kaL1UQ56VIrVqzxOqUPMzbta8JWlXICVLx15Sx
         r/96x0NVYMQBHWZK8BoEAtWwr9OyyrT6NOwqDapQ+mFxc6ixg/gc168pj0xcptYrTPtY
         S6959a94ck8FHFewVBd9erDei3noY2XVcgCdFixW0mJmCD+egk8FdC+t2Ckzwkt70Qcj
         Rb2zSgaImYK5HHxyiqtbdsenfvI2tUXnEcy9drhS9ohb1vjAmi5qMLQ8BXyDQVI5sj95
         hGzg==
X-Gm-Message-State: AOJu0YzS1jc5K/BxXwnjFn9so19WO0x66ZIHRB7MwgYsMxYcl0XUdu2Y
	tCpl4D5szf3V2D0k1gza0A7qTXPEV+3Z2oPzfu8VgMabCPADqju19jk=
X-Gm-Gg: ASbGnctbColz7EIYS/vy8JYhOsdyeX1+CZOE01yJQ0qmOku3bF+pnKmaVy5NOk/OTXO
	LxvNiq4oxL5iqw3xXqCzDdl2u4pRSyAsdwDV9HC9w4TkPVA4VlvgrbEfJHoSSnyz8nGBPmIOUk1
	A7BIRFKAbqwODuqOrmoq6t9rIwPfdq1AG5nXswo1HFdnWHeArpaGms72bWRI4tYCkKtUf+I4w+D
	svijWMBx9t352Qh05w/ZjE8BassbRa0vXmmuBre8QVM1WJpW+jpqWP6jmwm4N7aMB6SBF6HBS7u
	4oyJjeCt3Y6vPaa+oHNMd6okeKdNwxMAa+mIcjHeCtkxk7ZCJjvacsWmWVGxXxgNHWvCK4ZiHdZ
	R9SbPmAAb7ZZNx0aLt+PCKRntNdXh5gJhvrk=
X-Google-Smtp-Source: AGHT+IG+WGpnu/nJyEa030UcM00iQX/06VjbkfB5f2xDO5QtIHLQRGtxZgL5B8cNwYB4N7EMfzXbRg==
X-Received: by 2002:a17:903:22ca:b0:264:7bf5:c520 with SMTP id d9443c01a7336-269ba53b20amr38486365ad.44.1758282113408;
        Fri, 19 Sep 2025 04:41:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.212.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698018a472sm52646165ad.58.2025.09.19.04.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 04:41:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: pm: a few cleanups
Message-ID: <4f3f8b0a-75c7-029e-5599-7d6e7238bf49@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 11:41:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/178544=
65141

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e5251d21c56a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1004147


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
