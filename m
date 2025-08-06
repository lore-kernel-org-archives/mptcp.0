Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34081D63C7
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496133; cv=none; b=EA0bOaA/qNtWgR5Gwdz0XrNWO96BN4MhS1UkU9AW+WXrHouhXHvUUhYzi4CUMfFSZSF5yyFN8Ja6+jDaDT1wis0MCHkdkbfl9yV9mIvBRzh51z5EnLP+tUJm/O+0Q6/FlA+9s12z+GA6kvK04EsODEiNpkYfWpRtSyGHaBvdmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496133; c=relaxed/simple;
	bh=GinRt/paXYjgs/CsvmixYIBttwH8SS/sqqb0uoxJzOg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TyAIfg23dxXXPNWik0KoAg3BG8Ze1kABvKvsl7LPMoasnYl18CXxxzZC0oJWLyCQe92dyQbg1unL/dQ42OU0vY7FtCaHxPqPfzsBgI625d7hQ7JwY5KmSkxYLFfjnmN8UWbo42VucpxKy7msePk9uPlWf/jSKITXqCBRcRYnxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ3AMlG3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ3AMlG3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76bd041c431so115424b3a.2
        for <mptcp@lists.linux.dev>; Wed, 06 Aug 2025 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754496131; x=1755100931; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8ByLma/0/v3ecajF1DXiAx+1FLDy2dUvfa2WwK8tIQ=;
        b=IQ3AMlG3QnuMorlFxSVSZTjHwFKNLnjzRKQrx0afxfdfmd5oWqggxL2SI2ueQ8BKcC
         pI6jqsm4JSAG5GmkUBo59ZndWNmKFepLCpeb0UhH7J76xsFZdyyyVdzU2QpEZWC1FIrU
         xSVA7ryJtUsARpQK3SCSEe5CAR3dxaj2TtH1ACJokkCvPun+aOstuGOGCz34vM7Yt1fc
         4xm3EEOFMnQ3M9eiKlFoBllWBsM9D8x1nqo5hi58zNSLssjzGIostRBjw6XLmyVVI0pZ
         g5eMoAfTqgWwVOOk+GrpM3Jurupn7n0KvMpTqQ/4P5FIeYcsHu7sd5NEBkXVcBjua7QY
         75bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754496131; x=1755100931;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8ByLma/0/v3ecajF1DXiAx+1FLDy2dUvfa2WwK8tIQ=;
        b=HW8NckPpuI7IvUEz2+/Frhypik9BwRbtJ2QWUa4ldJGEVQOGp9THU2fxtpkm8bqFn1
         KWcVHS+1BmmqBNWNEjqbzeHpIu+KCRJq4QPcxeDcy4MNiwlDMh6vhD/KXpKx54oECgpm
         uAF90iG7DCoeczutI2wYJu7sXVU2D+hJEvQFPrY+gfeunzr11xZmahn+8EeGIwYzcp0S
         tsTkKkiFT09VIzvEYXRtb3y4UZjYPrj01BxwtNbcbHMzS7VIRDPFUhcpfqk1IjZrM/h8
         LQyIZzk64qzzmOPxjNayhEjIBW/1QJgriRejpmiTXr7JiB8LnrQ2Bd7v8xDHLmGAmRn+
         czZQ==
X-Gm-Message-State: AOJu0Yy752s20L4XrvZkI66830ffsbRs41a7Q0Axf0YlXT59s7Cm1bLX
	uJP8CTz9njZNTNo+iQcqxLJkOIx1hTrkxTS+0C2bJ1Odtp+/YJZNSmhYt0Xo
X-Gm-Gg: ASbGncu/v/qwCWl+lWAJSPt16rSb1mDL/MgToIDvXq8iJ+5++1jrROY+o6kG5rpnHBu
	VHltZIp2vXI0HYQfEDeht+2hjE5pPGktmL5aL5AQL9SqHTqVEbpJIyXxvWQXEzS8lMdVfjbdrML
	8iP0JF+LvqB9HdCcKOcYslv1WQ+BYLgKuEaqa1Vd1JV10Rre2CZtEvWXJQRDQ+86Ht8wCCRRziZ
	A9ubPiSdGef8iUh5Q0ey73LWXdyrnHpQzsYRr/g6dwopCwAmaZNQwKQqnwLMOseDIYf9vEJW4tE
	TLgWbA/Qina96ym9H89ZZs1rrxiyZ7W5snTXKE2BevKE2XGx7jqGzgQrmYK1MgyR4Gmhy2wueYK
	z2ktMm6r27ikL+3IBNcdw/3f1FTsaM6ZgR5Dt
X-Google-Smtp-Source: AGHT+IF5LSCFRAUMHLO2QMTeat3YrNsxacCL74Oe1pdrww8HjpEdyK536IFVlxJsS7znMCp4vy/Jfw==
X-Received: by 2002:a05:6a00:3c91:b0:76b:92ac:27cc with SMTP id d2e1a72fcca58-76c29b1433bmr4358897b3a.0.1754496130712;
        Wed, 06 Aug 2025 09:02:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be2f2a4c2sm12898074b3a.110.2025.08.06.09.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 09:02:10 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
References: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: pm: kernel: flush: do not reset
 ADD_ADDR limit
Message-ID: <8ab71bc8-1bf0-7a9c-c710-26eafd1e24b6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Aug 2025 16:02:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16780011899

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e165b9888212
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D988782


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
