Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA411DF271
	for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 11:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755775322; cv=none; b=jcgLNXfJK24W5ICLs3EXKt8775817CNAKX4FznCI6FQIvU3rhmrcnoTd9xdVLkBCgw3Vn6ErbNX31UYaEAjJRO6Cd3OLFiKhTMEyYr0wDijcSW3c13j9IgAd+kM7ae9FUKyRst+TNTp6vt2kOlBuBPOVWmCM/l91z8KUplMrA00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755775322; c=relaxed/simple;
	bh=WR6ADfRAvmXmq3wYrZqQF0LONF0lkwsYg5NJsBJJbdw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=fGvLR55RqDfbD15LXuZWToG7vu0y0u1rcNtAXD3oP8UFdNKzL2OEvRrym0eZHyWxf8J0VIunhk5v6lyP3k1koHMCL1pP3eK0u2KFT10thTSwmXj6076H43hL75ABx/T3yVlISkkRmQ5UuZ6SG2vTUgd6jUBr6DCAuQgZIN17j3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORIgks6O; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORIgks6O"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88432cbf3fbso68845039f.0
        for <mptcp@lists.linux.dev>; Thu, 21 Aug 2025 04:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755775320; x=1756380120; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktnoi9XgkT7ruOAWbe97meT+mxYzKmWb1kNhn835JWU=;
        b=ORIgks6OtvuG1DDIs+JlTUTxVDXZoNiLVsOkdIP4iaKb5EGW/eTzdfsj/9DpiO4HtI
         udvgP6Lcp9VbCeGudLLaxA4iG8lkRvunUZ8a4A7WO+88AoCjA9ruSAM4ERRCAHmonfhb
         0YiPczesuy0Cti2RxgiSzZYn5dXfB7pnYfrb9b1mYr6/CVYtDcvoFRhCQy4Tidu0VBLC
         T0VaMF6hhbBSAL+fWQOop5CyVzaniVeAEt1yEv4webleOy8Up3A7TVPuDatU34SnaoP/
         8zB53zzaXcPxDlj9KU9W1Bj7vLZCUa8hM3f/3Oo2V+o9YRdr97dHZ+EmY5X7yd6CmYi4
         nKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755775320; x=1756380120;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ktnoi9XgkT7ruOAWbe97meT+mxYzKmWb1kNhn835JWU=;
        b=JTlUXZ2uxhWWPRsbjSbPCqmOa8oV5NG3RvNpi9am9W5jnjLcFH29HxhynNte+GDcM+
         rbxol5kHjwCB0RkXi2wy744/ydp3B3RbKoffAQiGWXlydOmachQZIOdtMIpUGpBP6e9l
         OSK1oGqrlNUgkhSDr7LjSnuBtqQrIrpXh8OxBXioo/xUyc/KNGsINybv5lR8mMRDpKW0
         qnchfzWHFaJkPxZJ2/mlzwQmZ+YQyEv9HQQf7AwmMpoczbFbNkeNEMrOkwGyLj85Yb/l
         WF+Z0ktbQB/X0H+NvNYXxvKOqQpyD9GMufSPHEpDxCZx78Ug6Jz+prIy+6onPuhSOnOS
         vJ+w==
X-Gm-Message-State: AOJu0Yz4A7vBz4UzErygCWWgqTXS3/QFEhcuZNJgHByKsoBsMvZoEG9J
	W9hQvuxlx3NGlCvRVEO94vrVgpnuYCIFYPZJ3F4+9Jc+DAOkMmKR/DfqCuUv
X-Gm-Gg: ASbGnctvsEV+ubPP4rsHL08+AtdIeNRqIJLBExU8w1kFZiU4wTrSySExj6e/ajfqDjy
	XaKsY46HqCDVJbn2wQxPs0JOkZV5e3yvfBtiLpRdSAaLYkt0/nKWWcY9tUBe+YmaUj4F01XFpla
	icwreotBH5ci62ifSiE5po1faPqhgwtX5BPE2of9PQKa946oGlQ0IFODq6s2aiOgmyxyfOE2Oyu
	whvaGKLMPu2+zCnFHjzkr9ZmgDNhKnJM2sbkGmWqLxXyAlsYzP5Box25Nb64GO2uJiClZ1BIMvL
	Ew/Z65rA1JUfD8v2kdsIaJB8jDSjRAo93/o3WzyE3Xhye6WWckw0vURen2xJTZ1Xn2Ob7eTMXXZ
	Y8ehPSi7BsJ4+2ROqg46a1xtAJS3oT8M52iww
X-Google-Smtp-Source: AGHT+IGdKR0w6j+reCTLa7+mgZ9LdDY13+GzZhQoA6r13Oy0ssyAT+KiGgE/3+tO/mk+aw1ujo4akA==
X-Received: by 2002:a05:6602:14c3:b0:879:c609:f5a1 with SMTP id ca18e2360f4ac-886b48a1839mr397668139f.12.1755775319615;
        Thu, 21 Aug 2025 04:21:59 -0700 (PDT)
Received: from [127.0.0.1] ([52.165.251.249])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c47a4sm646543739f.21.2025.08.21.04.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:21:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1755680616.git.tanggeliang@kylinos.cn>
References: <cover.1755680616.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 00/10] selftests: cover more MPTCP socket
 options
Message-ID: <1db07cdd-e376-eba2-cedf-3285532c97d3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Aug 2025 11:21:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 3 failed test(s): packetdrill_syscalls selftest_mptcp_connect_che=
cksum selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/17122626757

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bda4263505d6
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D993905


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
