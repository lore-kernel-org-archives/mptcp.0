Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11621E1A3D
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783748299; cv=none; b=rDJeP1EChu11g3XhvW1shspMolQm2wW91UF5MjgRSvmkYgFp5HUedmCNNlve065wR336+QRDCNlH/YWJsGCNjawAQ/uscQ6Fw7fJ9WFzS4xSSnkkeu+AWF/97kvXEUR9BMY5srIrvsNp2rzZmkF5UQerk3Gq+pprfltgDfKBPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783748299; c=relaxed/simple;
	bh=Q18YxbyjssJN07Noy/VJyCa2XQOUpe1lcsiZ6tNuYE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=X64dSIzQc/B8D3w26PGQX1ZRcpkGkOltYnCBPtvBQQ/7oFHMKPFyxGlAf0UHAYcuLShSE8rlOQeBlYOjGCHZ79mHcTBQdDFHro6PSzGqz2HuGIHqMDTRsD/stT7/mQ+RIZHVJj6ICXPdarC8Kw3ZWEkJFkkxJx+q3quPfFri2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L73TIo0X; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L73TIo0X"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca957432c7fso1185240a12.1
        for <mptcp@lists.linux.dev>; Fri, 10 Jul 2026 22:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783748298; x=1784353098; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qAm6sKwZsnxnLXSPbi2wWe8omuOuI0RR/GZG16JTCzw=;
        b=L73TIo0XlC3oe6OU/yWGV1Et3tQHJ+1kk4DsI+LBfkGxkdXjnRn485ITPsWufUxPFr
         kXvub3lRgGHcYpeTRZ8YsHu9JR55h9CmnYFlK+IIFJQsp2d3k5wiBDjIrLoS67IvRGHp
         3nivs1ahobCC9OfyWOQnjszc2ZRk/e6VEJgGvpfC39ns/oRPHwdRl+R1FgdujwhTknqv
         ZP9/kpnWcYOCT3MyIxwOM0W8uhT7d/Y6iztCEcf2rlWVV/h3Zh95hpW1KmTXKnt8d5MX
         lZjQUzuAbjCF/KGaitRSVRtehDkR613hv7h8u73EuIQabeW48YyZ/6t1+Dj3tiJVlUhI
         UB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783748298; x=1784353098;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qAm6sKwZsnxnLXSPbi2wWe8omuOuI0RR/GZG16JTCzw=;
        b=rLiOq+wld9HS39pY2IxoI9qpgtiILCQYb2ph55LS8lB2LWNHe3uJCFxkCUIm3PIs6l
         /jBaf1Cb2OMlEOrEIvUELwvOebAvYyXE06mt2BG5b7okzxNnpI1nBfRuxOZEjzjnqpSI
         IUH9SzHGYcEUJcQ9WyDuVIUR3/EQbdAs9wlBhiLUo5hNSsUiLDdPEyKJM3sylmAH23Tb
         nbXpYi1DdBPXtRzaPn7Z+mR1t7NtKINatJFX3859TWuW3YPR19FNSqPAljJYf02coJNu
         EHFYLH2DwUvWWLcKaYa0G5h1OUe3cHjMWej57xI+jFC27Rrg4chfN9roerW+0osWnfJg
         a0LA==
X-Gm-Message-State: AOJu0YwBfcSdIm85VPlGO97i9zNG/lzu3cfkqlkwFoGLRHLtZuayFzEZ
	EauHRInQWjC3G5ho1F7rS2P1noQKT/DaLmkzMKZ9ibBDgjGLGSlkWQKAYDHG
X-Gm-Gg: AfdE7cm23J0ONaALL6tqfFAH2dgp895+YusdHEcb0v0PwYQZI+nKbcredm7x9fvmd1G
	HZUhBDBBIcSNaqCECLuKa5n+6ru1VPBoUjd5a0ORi6fG6YwjSHxettO4j+QKEP7m8fcY7fKHTrP
	Y0FsqXtVyPL1eB8ceT2zN1Kuscv9vpBftfuvZ0Zot76PkOqiE6WiV4vJJoPd51Ir6NYJ2YdK7MG
	DgCxAtjUtGCjX+F9+DCK/cErionvcUSzT36+eZ9olGuGiAR49LJUTkk3xBOPchLFTPxX3Qlx0eW
	JXF+64g6KHllNXKN954pfytnOnWM1JUHXfMeDoJqb6SXgbNiei75/IKus34AKh3bX7r3DqPoYKa
	yqdksu+B/omH/gJDVey7IYAmicjR9zEYA49Tiyi8tvoJrwTzUf7IInVvQwENJrxIjUy5elWegvt
	LgW3PAMhFAjTovk6j+Q+K4Irowheg=
X-Received: by 2002:a05:6a21:6497:b0:3bf:64cd:c45e with SMTP id adf61e73a8af0-3c11076511dmr2178710637.4.1783748298073;
        Fri, 10 Jul 2026 22:38:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm3462810c88.1.2026.07.10.22.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 22:38:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1783740443.git.tanggeliang@kylinos.cn>
References: <cover.1783740443.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 00/14] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <014975ee-a8f9-9749-b7e8-0482eeaa8793@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 05:38:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/291399=
16501

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3ba9f246f803
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1125700


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
