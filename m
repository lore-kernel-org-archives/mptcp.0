Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37637280A51
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110775; cv=none; b=dx41B/GIarOY2a0Hkry8r10DcWHvk6y9pI0kCeoKgNlofQDnO/zGo1Y9lfJ69fwm59+iwmL5+KUELIG5j8TfpCNE7FNuNFQb79oh7jEw2vLOUPqkgirs/MTu/qZWS7ChropYADuG4RqClloVz+TOCfB+4r25vklvnTn3UbilTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110775; c=relaxed/simple;
	bh=O0IZdLuQgK+Cr3xyvVFL40F++wkhu86mv7XQ230J2fQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=W6xBHR+eExB6zXP4AuMC/3T0Tukp6eHct8Rt1bdJD82SbBm78Pbx75+Mw1IoUVa/5EH4s3xc4P1tMsT+H84kmLY4FhkgDC+y1n+NsYgfGoGDPgxrqVgXKgnFFmJ/CB5+uhtjFY8RO7h9nKcRcjhhxYVPB/F6IGoIE2Kkg1wC+fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfDeVzEo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfDeVzEo"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92542fa7d07so14505685a.0
        for <mptcp@lists.linux.dev>; Sun, 21 Jun 2026 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782110773; x=1782715573; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km0KO6DVsIM8WKMTAgr56jpu9+5jDxtHHIgmbsGLbp8=;
        b=pfDeVzEo7WnA9yvCawog2O4dGBm56ThjB2IJbC9yKZd2iCCuecj8/UH3V6LDySYgDi
         KtPAbEs8EKr8pblziD0KIpv6pFqv3lzjCoPfsSJwhFwhHQowKSahxOCai0cgPMINAIcF
         TL86Jnif9PzdSvXH2dSppIkEnH1T7nNzZjEeO6wp/kYsxNGLfFI91yrUUJ0GvgI4RR7j
         5+YM2n7m7eO2PMHGjMhqk5PU4PH7rttvkHlUW84ItQUFXFrdAjJ5KqNUNydDMsL+mk8c
         wuw3k2WR+rzo5D3zZ67tnrM4YDosAfZEC4kbRZtEMSbcVwJY1yncBhLMpvVlyGddgTdV
         NXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782110773; x=1782715573;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=km0KO6DVsIM8WKMTAgr56jpu9+5jDxtHHIgmbsGLbp8=;
        b=aVMwUxcKLAVaH9g42Q4GoF6bZd0ULAPiAomIo4t+a/OCk4HLcPJxyQjkg0vtTgnTvP
         gXATQNlTlaHFHb4lsDq3ymQ7/vU6E3XZnhbb7pzrlco4ydkAZtIsTosTS38uiCnVL02b
         t7806oN6mkmNbAtODHZ2LjdZo5uRKfwYfR9ThwNbs7BGqf3Qoig89dRtDQI170dWv15M
         SAIvIz9oPT8AGv3CvO3HA9o3XjOAEH8/BVP3R00BTqmUrRWObtmRF3ury6FSeB+RIBoY
         idU7nwAWjxUA+e5bqj9Wz31XPdQoP0IwMJr43EFFD6h25yrPFo3w1AKrk/75z4DRsGCJ
         N9Lg==
X-Gm-Message-State: AOJu0YzX+DI4+i8t6xBcjQdKRoIwQORnXc/HAZ7Nki9GeaQEXE/Ge1VL
	NS0gEjAe9UYyhzAmJNP0p55Lzg3oOURekKfwsO7Bp2aWxR3ytA1qbq5wGLMs
X-Gm-Gg: AfdE7cmfVlgk0LQxAf+Ukxg34KogDGRW4x9/YRbWxy3KRJD+unRUvVBIDFR3YsjdALX
	sEI6sRy34ytCRMDy7RUVI9nvquoYtY4KVrztwHAzwB3arKQ9tfFM83LCvBpV4vD7o7F+n6CMHUb
	3uBX2f+znL0tS5XqUtQJ0pj7nPeemQGqYG9D8TS+mNJ3kAR5LrweM8U8bgL5JpO3N5HdcdGCJnd
	PVOTNUb+x0XK6ShBsZXIsux9JZt03GMZC4pGgee+4KF4fwAl3OJBAzVGNFNkU2q2Hk1czWX6QDZ
	+e2CRamhFsJoace1h0zv94SVtbQYt29DDBC/Jx32G6Cc1PgszMe2Df7bB9Ec9WsmyjnELGii7A6
	kqZJrYNwfdYabo/3jlmSHr/qHX5F/gbIWsFxT3s2jBXhyQ0XzLgnX4fV8Ruroc/vb1NWdGT4o61
	kkMDdugJ0aGsHS00UW+6RkaU6upXs=
X-Received: by 2002:a05:620a:26aa:b0:915:422c:a0 with SMTP id af79cd13be357-9208c814572mr291257885a.22.1782110773073;
        Sun, 21 Jun 2026 23:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.94.135])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921daa80d37sm854785585a.27.2026.06.21.23.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:46:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/7] bpf sched updates
Message-ID: <d70c3354-cd48-1706-cf96-214213dbd65e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 06:46:11 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/279330=
86171

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/09e091cc5517
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114517


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
