Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E13242A4
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961658; cv=none; b=jttJFW+6JkGIydpJlnlmCePCe0Tw0sp6Or60vD143MAeiTutX1zKVKvOut/fRJz+zWLM3BatqDQJv2o+/pj0b5lK+hXW8OasbxjCz6MiVBs3F4DpIgWVTYlNupDYUuJPMKWwW7ND5Ya8+wCwA6Dl6lT90lNr9S44TJjIFCtBF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961658; c=relaxed/simple;
	bh=40zN8SSkAn8Fae0lLxdZtDnlbhaCQ3mPKoGfBviBcBE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=HOZsbom3dJb3Ir6XZOIoj+ykeguzPMcsI0bwQ/yiP7iwBsss/MPTtqw9T0CwzJZx6lDI2Dp8zEgbqxv8hya0o5yxi4jnuheVI7f29OzYKw5d+LHke7vdPoRfYjJ2sXCTajJxvjJE+MFwwzXquKi8SiLBOpS+qbo3HKkmzFWla6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw6xDZKQ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw6xDZKQ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50babbce85fso47807181cf.2
        for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774961656; x=1775566456; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTW32d4F6xVTarYPeBkRj6rDnssn7u/6VK+6xyYncxE=;
        b=hw6xDZKQbz8YUx9z6mKNgZkI7wNk9kYwXPiF2l92vIow0TH6cX63vtMBWz4MZ0CMwr
         AHjY9GNRC6dbIe1lHr7xiWU5sbi/bEs0xtGGRSALfHvO8h4WeAlaaGYLPs3bpotRxIPN
         ih+9lkz966ojt8SY0jePhfnIqAeVLLeYLs67aXOYSZ8hK7UBhpvNKqA/awsNtDS/RWXq
         K76M736H/RlFLH3huIFhqrp4YqzR4tnjdY8ADJI4VCj4D+7YvQgZs3+Pd4oA2tFmi4rm
         9uymbGVUN8lqOI0vpAB65iU6J7IMWuP06lrC3SHHB6GRClwJQGTGpTBCDCgmHnjCLSK3
         gwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774961656; x=1775566456;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTW32d4F6xVTarYPeBkRj6rDnssn7u/6VK+6xyYncxE=;
        b=Xb+Wsx1Ur6ExjK14vK7P+CNeKB7+gmvY7KHnPDGidummFWbr7SZRCKjmxojIugvrYm
         aRu8mzqtApcBLMv4WZ4uqkeiSvyLU6yPq0wLVpoR2BVGhBB8xlOjUk2Hy1HSV6YMQMZB
         qN7KtB3a4sdOkY76kowpPo9QmDzq/mxUphLGuTqfUQEewdLE4zwhbyF4lSvCqBUyDxDS
         EVm51hC/3I39fqCyp6jdpANC8i0rvP9PUWchAJTe6iVHoah7qXWfDOtk8xXnATuq4QXX
         jZXwlHdIspwq7V4RXkgfAjIJdFO+v8tBEHo+7qB04c54uj2apX26q2tsbbxg7Jsqt4mV
         dkfA==
X-Gm-Message-State: AOJu0YxqqlWva2q816P3lTiIYPk6+s0p3FEXpbsQIlWgN3axfatFAozy
	M+E6/FvGgTMhEfvWPLYQOTGDDvVnmCygaIokev0SIE6eW5BpoL4QpDFJF2c2IzI=
X-Gm-Gg: ATEYQzy+1P1LML6s4k0uBwyLe8eXQLSJV5FLSZg9OsrH/lsEach+gA3YqLQFkrTHjh0
	IY2Jd9XW+rhLjOTGLyDpjJRPsomkTyAYatGN5CgCUatjCDrg0q5wcH4W9SV1uWi0+FUI1aoHnJB
	S/7MtSgNZvb5I/FaSowFQbcZkgMbq8Vcg0c6LPH4Ot9MaAVWGruQ5/ROy9ntie15SM8eezquUOb
	xiMr4v4MLIYS5Ab5s8dmaf1Jo+xnOm8x0+m5fwLBsiB/enE8vfkXeX1fAnqTV9Tkbtz4cyqcZlk
	fQad1ARrc4XZykzyvUC8qJiRdLysk/52gYid8vzq+SlNFm9FIF/+zcYf058p+owNTw9mzkT9Y2y
	z2eG+hHGh39VJqDB45i4j3G1qu/4yV/2zvzZRhiqBCUjc6lssesDtH3TlIgdv4coUYaTz/XvOij
	jyGV56+lCpstl9UmX4NRHcFX0gjgbmIofg/5M=
X-Received: by 2002:a05:622a:5cd:b0:509:4198:5468 with SMTP id d75a77b69052e-50ba37d1cb1mr230854351cf.8.1774961655647;
        Tue, 31 Mar 2026 05:54:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.47.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2e687ebsm90054811cf.31.2026.03.31.05.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:54:15 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1774952107.git.tanggeliang@kylinos.cn>
References: <cover.1774952107.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v7 0/7] NVME over MPTCP
Message-ID: <cfc867b3-5144-843b-c60a-823f0380a100@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Mar 2026 12:54:14 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_nvme =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_nvme =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/23793209886

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bb47ecd003dd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1075115


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
