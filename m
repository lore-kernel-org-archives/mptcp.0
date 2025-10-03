Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FA129BDB5
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507859; cv=none; b=OAAW7DwT+vc0WABgaPfb7L544vzRjKFksg5pGwoB/QXMhy2WDcVcBrV4eX1+m4aLIX2TNgPiNj1eQMs1sEV4v98ZHCw+5lruY0IUnVdtIRyl3UJRFZXc35E+zMGyLrfn8DOCRq5D10sD/LWTGzBgdzhYULYqnUhNdL5xYagsgjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507859; c=relaxed/simple;
	bh=UADNYhsAspA/puse60QL6FooCRISnknJsOF4JFV0+zM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rtvjZXmiVUkJzKZe0AL0BfqY5Hfl71opfKXvXCdOsMgSFG8E5r26irS2X0Nghyzmjvbpy+7ybuPho5ZsyGxuN0tJNTDDFb7n9KtqgoNHXY/WJMLX9VRKCrl2jHBK915GP+yFly5SIB4M+7w6yrIy1vB3UJRiiEdD8aD9lYJpJ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8nOLjvK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8nOLjvK"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b5506b28c98so1695879a12.1
        for <mptcp@lists.linux.dev>; Fri, 03 Oct 2025 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507857; x=1760112657; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgRuiLQ5Cd8D7z/8y87HZoB9kqjeburZflK0OFqZNo8=;
        b=b8nOLjvKRSLoQo+wOltXjApF0ERldX4nJp4odRtpvsyteQ1cIB8LYbnlN1SZaOBBb2
         4cc6Q/L2cZvcGqJ+u4O6o1ppZCrlTOWCRh18Uk2kFxABkqIHJiA7GaGD53/PhJmbz2Oh
         gwTuL7/QsMIeYABdKOt4q00kLq104vIzDuylObGxPALwUXQPbjN4/SlFqIvFZLDBePx1
         6tlUsxsr6DwcjNkHeaMnoYqWvoNuH5JVWJBWtufLFT4EO1qvOGb+w76k8u2UDXzEWI7N
         UvVy3hgcCnY91wiZBg6D6ZIKBZ2NvANkspg4rMr4olVgmYKdtofAPJMUAUZdVdGYSZBS
         tsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507857; x=1760112657;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TgRuiLQ5Cd8D7z/8y87HZoB9kqjeburZflK0OFqZNo8=;
        b=cSPGCOUyuT0KSgCNmg6Ywq81iv53Yl49ahXuWtjyqyeKZhtGyIOaKV5OoJ5mAqC+Fg
         XxdZJB4A5rHdvs1Qf/io1jdeaWmwwgUmUXk5lxRerQt0No7Kaum/l6MgWJuf9mK6JyAV
         WDNvzIbgB/8BQrWhDdw9Iw/Qjwnc+stH7/4dP/JYZNfw0G8jbGSbW9+b6sVmkTZ/UaPj
         rVDjpYm7gy5oYyJIP4B9f9jzr28Y/GlbpjjjRf7oZ6seS9rs+r+qu1jGxIJoob5emWar
         2muL/YUpt1nlvbtXD1jvnRVpb7XPYF54S78rl8tVSf3JMTBaRTd1CcjZ8Y+XwYKKgenb
         yfdQ==
X-Gm-Message-State: AOJu0Yy4LlDS5vdeNLR8SLdANJn9zVt6jPX/3/0ZZSqrdoH4poBbDCr9
	1BReYEDiZD+XZy85ztPbIlw81UO/fV7VKEhRou9SKzkSeLzmXkL3vOXasBmL
X-Gm-Gg: ASbGncsauP44dbXvq51rnCm5F6MSrWxD2NWP1N3a2Juz9bS6wzdyTzfj9Jl1xmp4Lfk
	4nmp9OJ+KBEctzM2NueGblYA51PxIsk7LnXE3sRzyifPUedUC+Gdx9IX4Zcoh4n+EGaweUGvo7Q
	QpRK4UFQa6LP7b1TLPFvw2duEhfO26uvRfBZrZJATTuv7gRpTu6r5NCaa0zaQ1ZLdOQNzNPXl5d
	thtIgKK3b6wKY88ECxGWMmhLZhvZDcimOOf5o2fZ+rqRkhDvCehDz4U5IA3omA4OCOCuhuKfXEE
	4KNgf5lcmMthoL94lu6J1kRTrhymIriF+RRm4tM7RMGw5HUTVBBsfy0vq1qh36Kc897kCmUoS0S
	DJacEhflmBNv4b/wKDz0j7exJCwpXafa7QRCYIdmWvkVTMIEEY5za7zXalQ==
X-Google-Smtp-Source: AGHT+IGsegoeoZNT3iQV9uwIEU7gP85VzzGh7JKpQ38t6TH3DtKVMWBmJge1KafZ8srSHdUbeljpGw==
X-Received: by 2002:a17:903:320d:b0:264:5c06:4d7b with SMTP id d9443c01a7336-28e9a5ff70emr41265815ad.32.1759507856905;
        Fri, 03 Oct 2025 09:10:56 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d12608fsm54914535ad.33.2025.10.03.09.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:10:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1759499837.git.pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 0/8] mptcp: introduce backlog processing
Message-ID: <f74bb6a3-915c-b5eb-b6fe-cc4ad870ed63@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Oct 2025 16:10:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join - Critical: 4 Call Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/182266=
65550

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2ed154e487d2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1008293


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
