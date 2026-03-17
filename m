Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2ED3659FA
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 10:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744117; cv=none; b=aRuyzAeEsx43Bddqfb8kx/ZytB+7GbTm39j3JBBkID1YeROybEpVQFPhtZ1amgNRIGeAVvkTFxnPCKqnUh1mvYGtm1nAyxAia/Q6DaV8aVNE/GO7sEgpfp7hmSkHX73EA0guJTnjzzZEhIw6GDgFnPb0CQcW0fTwfJ5GMi0i9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744117; c=relaxed/simple;
	bh=Tp67IfPsSPnDaNXGZirwd6LWVfHWeSllK1pwTX+SKoU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fOG3s9JaUMPPUKn4GamJU8cbB6mhLe2wCeVJnBL9FunHplB2IAjKKVw4Zdx5J4zChOm50bRshcbD6e7V59KYzWpAiRhHLZrwJVZYhazDChPLv/59RAF1J9hHtp5G1KSmeKaN9w22g7BwtUQ8NfxZFXIzTYeShJhGByY2silgGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3hbZv1Z; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3hbZv1Z"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d7447778b9so2775115a34.2
        for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 03:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773744115; x=1774348915; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECHOWPldW1AfgEuuDt6yziWred+Mvt+RCakgJyQrYAY=;
        b=R3hbZv1ZTVqUcSfPHvFhJ1ZfrePdyrcwAsv2EvYXn4UfZiT3kfj3fKeB46kmnDMml2
         8gZOyhpsmzjnTYcDJ/+i6GONRPGm/Ys69HKzxJrjSUTP0d83GuYTTX0xItDf5obaLmuf
         mL9jDkHN+xCICJKicDkjXzDHzuPO8Cb5061DscvQr5EDkvsgsrBEsP7RvQvOTByp2vms
         K14Mlj0h1OZ+4rWWcXUHnGgz6n+TRjkZcuic7ZxYZdR8d0n5/vEVAgFeluzZW5Y1d6JL
         iDZ8ZS2j+3IpCOUVPEr/PY4yoWy4AQw1GxB6N0poxbX9lrP8HZgR1RpFr+TPa0ipkFk5
         /a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773744115; x=1774348915;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECHOWPldW1AfgEuuDt6yziWred+Mvt+RCakgJyQrYAY=;
        b=q0w2IIQRsON0jCK/L00CA5EHCCVh+os2wlqQqcNME1HSXMR6hnS+RDn0uxsIulvXfM
         1d52VdcYcfoZDNJvVFPSxcAoCl1yd1QkUH5kNp9E2FarfJhfdvWGO+woQWjwSxvDOTcM
         fMohWv99VLE4KeNGdKHcYVjPV3EouwHdSWF+k/p+VCwSJHjAGypzo4W+rEgfTVnQ2FiN
         xDJ771Dl+EQ66KJdDKNd1grvLMQbpdR0LGGoQxdGuzt2u2A1Zu9zdgsky9SaaowgLFQY
         /7GuEQVTF2L7kL5Nrk1FSerRPmmRFfPANuuwcjEzHYx5uy2BKSspnl36cU75tTyfm3WE
         D6yA==
X-Gm-Message-State: AOJu0Yydre+tyNd0DBxEYdG1wkpUzzIXsjnluQiHU0PIxfHuXa5euRKR
	p2ki7kv+WnEtxKHTpiq9JgyYaoqFkjEvGjO7Rt66Zx6WLTKj1WY3txh3t7Dh
X-Gm-Gg: ATEYQzwsFcQ3wFsVW0Ua3JQ79/JNlmn/6zbJIEMhaeSDo23Ni/DEbNig51gt+b14kpl
	SCDV6j2ifKfkxFFpJ/4U26P6k5FbCGw7rB2fW5MrdehgLItu/RO8s5BLKsZbmekZN0dsv4ZdYAI
	Kxz9qzkkPrtzf4fgYhWhD/fKUNxK6vLueUx02SbOTDiSgIGDEUr6myrZicigD6jG6RVR9NzoArC
	EZCnGLlB1Hiqp3w+CZPcaBhY8X+e2tXb+JOAK1rZ2+2YD0D4N4Kc0zKltfkFzkH83eWBzBYhDJJ
	V+ZVVP/A5ux0MdXbRQa4jpczU1XcgBsD+2KdIl0Jv0G3IT1BAgbbu2x9C6XrSyz2UQrGAunsP4S
	NEX7SBZR8kjvr1PetBnHG6710t08hcPvHsVjUiZJhMVpqgETfEL/6XrQ2dKoFwrCni9pnCppIe6
	JKJ4/d0mo/EGdUWsic6vtY8iKnsaGvDbmRFVxf
X-Received: by 2002:a05:6820:1505:b0:659:890b:3f9 with SMTP id 006d021491bc7-67bda9845c1mr10339956eaf.4.1773744115098;
        Tue, 17 Mar 2026 03:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.200.57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9118c87sm11708904eaf.5.2026.03.17.03.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 03:41:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773737371.git.tanggeliang@kylinos.cn>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v10 00/14] MPTCP KTLS support
Message-ID: <347b9b69-7fcb-d7eb-a3f8-921d1a6060de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 10:41:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Critical: KMemLeak =
=E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/23187580083

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0a240102aca6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1067840


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
