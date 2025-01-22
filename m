Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD514322E
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737554614; cv=none; b=F/Qgthkw4+GF184TWGxgA4lzYTE7UXecR5taLLJDTCr9ZItg202qpf1il1wEesnL5oBRaSAu2b3+rkYwdXF06F8itAc5GS2ukHYJoAa1H7NTY66J8oCeRRxhnAk1RH8qZyGBNAWtrFgZLjDRuNK2aB4uklSHg2M6+ZkuY5l6Is8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737554614; c=relaxed/simple;
	bh=fthVtrFlp68PYFZEChqHdu7ornnbDs1cziOMYB1vjP8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jGN86z2JiiXz8auzduimIcMKF5znpvImz7a2Fp9TDoO/JbVgphDrh7LWK9Ko/LLghBarfwhLG8TrPb5hpwln7mIN6pfmDDNnyCEl2iZridOG1Kno+yzJFeeOxzTbb9KgIwHyBmyfSIkSQqbCykw1plzGKF/aoyaAkuaVGJfnjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHfVLYyR; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHfVLYyR"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6edb82f85so906698185a.3
        for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 06:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737554611; x=1738159411; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1AZmFBP0BamTJEKWNgA/TNQI0X+lVOv01IIwy9Sksc=;
        b=JHfVLYyRBLGa6++KHKC/4zqNFmK9Lwz3tpa0wGk42xjuV3FflSDYy0Iv+hlIA5EYal
         0dvTY8s88j1+QDnXl3apuRSAvFCTzLSK6/0lw995EChqZw0tcvclmNxz6kdSMHFmszJR
         USMBDvVqrhClpqK1V6wWASzOnQE7SyVouaMF8/MJVh2+0bbJd/XyduXAv/9Hhtv7eVCF
         vxqu1iIexqtoo1luM26jNTPpl8RYTbWosL7rsJFrt6xLwhHVyVUht8z02vElLP1pGYcs
         l77+6VJIpjlDl9LptQinFXKAZJY2ziIvKiEDcT4FLgzBtcZzFO12+Dh023u0+7jIJKC5
         XVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737554611; x=1738159411;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1AZmFBP0BamTJEKWNgA/TNQI0X+lVOv01IIwy9Sksc=;
        b=EcX1r/YC6Fix9ZIiPJBnIyLqhNHfG/ob8lE3Y8zHWEvcD+Wc+jM/VUdtp6dsHcW6QN
         rXQUTMc4RHVth6m6znjlF0l7sWJxViaX0LiWvL3OQEF7F3yWwNCwarlFKA5NWly+1nN+
         fZk4tcCYKlOtKoJHqC03ytdJZb1L2NwT0cK4argAywO3YZ0SpOMnzNJ3KseRDulWWkUS
         1a8ddjeCHCJMDJsylxSGEbHP/ysHa3ekv0Qi2XCopBlmLWrLd5u+BaH7lUnuvl/ACIn0
         MCN77JGFrks0WHFoLXO8cOWiL06D+LIMDDrbYLZbg8xRU3GgWjR7EBrZzJKdLe4k2rmU
         CkNg==
X-Gm-Message-State: AOJu0YzbN32rkkM/YJyNr81NekWv6N750vh7OOqqTKCMJt7HRf0dwDev
	c2nF3iuBi389EgqoPHZh4UwGPQDjB3x0m9uwJKv9wyOfugn1Jm4=
X-Gm-Gg: ASbGnctFZypqY5Ffu6jhS3pN2OZSSPXtr7RGqBBfU5/8a4XWfk9kiO39fzwU0+Sdfti
	QtA4UHwfgM+k5T7UKzQsIoQToLYJxjNQx6dFR8YhNM+lLbsISaRW13pee52ALb+B8dNRB4Gry6F
	1gQ6wPzC3AzDPJoiqCPYXISFKw2P88fcXO9Xxxb8QKe0+RTGwVSpR85WfI8KLPmZSwRbirbDzT2
	OnzOaq7jFmBamx2rmFvI2hemUaxZeKnEsPq1kIiPnHuOPiOzuGBl95mDj5T4n8SxpN653TJnORP
	hXBAC/ElhA==
X-Google-Smtp-Source: AGHT+IENAjaVmtZiN3q/aV5kP8ousFL4j7bIv5dUlatRwnvenLZWK2kWVeWX3h6Qh0JqLN1VhftyMQ==
X-Received: by 2002:a05:620a:2705:b0:7b6:dc74:82a8 with SMTP id af79cd13be357-7be631e7136mr3456635685a.9.1737554611461;
        Wed, 22 Jan 2025 06:03:31 -0800 (PST)
Received: from [127.0.0.1] ([172.183.133.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6f5e6befsm482609985a.78.2025.01.22.06.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 06:03:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
References: <20250122-mpc-no-blackhole-v2-0-13e6670d512f@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: blackhole: sysctl SYN retrans
 + fix conditions
Message-ID: <c7204414-c3c1-e994-871a-543e61a679d0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jan 2025 14:03:30 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12908221707

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/922f9e419c68
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D927518


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
