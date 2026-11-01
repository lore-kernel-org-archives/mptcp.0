Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793568639;
	b=YNWBcJtFqz4ZJbQB11SWIOYQTzz+ArWu2qu9Fvwd94Ai34XrW559ZWbUGZ+7FBct6veN
	 edIv2UFDe75RR3Bzdxo+zXGvOWm0wqiobwlRHjOL0Bl5Rf0N4lsHGrWgJi5ojIXoqcUTG
	 5rDNicqwQDhlamje++nf349av6j+olLywB7x/D6+Ngy3ag/iKBTjjC+sHq8hAqD5peq15
	 qixRkcRpZ8ahXN+RJAgIjLCCGlOll0nwpa2PG4c0GWIVSij5RSvwgz09+wx00kReRwlyU
	 EGx+u4dttfvOGe3mtID05mdrUu2ioW3TBYkhEQVzpPoZ27NXOfn2nFgxAzxcbBeD0Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793568639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=s3j3OPfA+LBuXpdOzOR8iLpoS3ivlfY7RkHziERaA+Y=;
	b=e4nKnyOC0nbv1z22ItV06I6LhInFDH492Z7gL8x2U6ImnW8zrqy6a3gMoTwLRC4YONlX
	 pRfnBXqH/+DRApbGBq10Cgmxp+4P7iZDGbNdedW9J5DbX+5p4EMphYaPk5UGJymqOdCmF
	 2h9jskf35+6mL2a8SKR6kC3/fjnBdlrmC9AoY5wk7Qkwv+vM8ARUIbloHTUnaoUJXdR+p
	 io1RgIs6njkzgkLPGZieAvDAP0+zEUmUwzi3KBULwxlRucZwgJjSC4pYCfCu/pXr2HBT3
	 kDlQuVSZagnCN5x3b8x/vklOpYzApiYFVndsb5Yl5Lf3/YhH3ijZ3a6lZbS4cJ8lSbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPJaLVfA;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02651606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 21:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02651606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rPJaLVfA
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b28d9537bcso1766530b6e.0
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 13:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793568638; x=1794173438; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s3j3OPfA+LBuXpdOzOR8iLpoS3ivlfY7RkHziERaA+Y=;
        b=rPJaLVfAIVBDXshcSIrIlM3y2KHj1MPNakhvJIVnbnQvKR+WQXZsnundvtEvpCojH6
         zxiqWDc0TDgwdDbIqFYTA1k0iBb/mIsyQg/WPYxIqVxH9DCw5QWjdicD7+iDr7fV5mxw
         nK9TpEvlU3Euo0Bf/HjcQG28hM9IE3LDikZcMnAAecAckDSPPvYL8ZBkn9o2aEXkKrhR
         UeeOl1+hqW99TR/K4XaGQnVXfGGsoJSubwUMlTtwJ0pGpGgZL8ORuoepuz+KeWCY68Vu
         6gypU3BuLP4K+LUJA2DU2D9SfI7gR8VQhttnotUuUTL1iMKRy9ukshPkxxip5ym0b318
         8z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793568638; x=1794173438;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3j3OPfA+LBuXpdOzOR8iLpoS3ivlfY7RkHziERaA+Y=;
        b=UyBv4xmxRFabSGfJgYnLHXefAC9N5JbHuiLv94YY8LZrAGclEqZ7YYn/g3fErgyLC3
         sMXvesrjZCLmjssHLVyE0rwv11Jc1L2t3qX17Tm521vllf9wdSHIiMU86DsJGEn+32oF
         glpODc2rXbclIv5ZB9YNbsOElYrFxd8OL4OrjqAOMnZuI664wnD1Ui64TpKcUZuIeqQt
         i0QOnavnsqJRNqNgG1k37mnvfF4VmDxLH8kw7mT1A92uGCrsDo3uHdC9zw/HrT3KQm6q
         unEnqB+2bW7i49cm8Qi2u/D2sQdpBfnPHb1+Y5l6Wt70kmOX/rwhBDsUw/hUdyFvTMw4
         RJpA==
X-Gm-Message-State: AFq9FYIsMwGIkg/FQUEEEWrakmjSsiYb8a7aSQaQccQp/k5/iAdg5aNS
	fOMpTn5IfHYsQJ/38bv4R3gl2pOiAhk5kTbDkVnIAoXhg1w4BNLCvNc=
X-Gm-Gg: AYBFou13WXxv5iMLvQd8BIog9bfkAOgZ8izLo6ZeNBmEJ3hUSY0XF6RJ+mWjVztOIex
	HRiEMljZuJUbgRlMdexnfD3O5SxNoOt9RD1pVLKyHsY0VB6ocm+lk+3ava7yk6MUoTW/ixplNZ9
	gBKAm6xxuG0dbxMQD8Sa5Mdh/BsSplsV+JKHpoadaYdYiqSAfsUpuQjvSrl/vxSOzi6fLUU4mY9
	nnRcyWX7tZs0kb0XQ4QkOwlEIP70lwoTQcN/rbzWfK+vhwmazxpBGcCWorI6SvdmKFjFj4VkVZ0
	C7d7j6hR/9Y07pO1iJ5ljww6BJbG2GJ4huP35cdKl3MWYfXB6c55ZA3fQ3tG8yV9u5ZQYVEZ6JU
	vcN/ailzryUrhxHlV2x0JMYltqmrK3l5F9pf3+r+5AoiakShW4vQxlNtUgjM8dFLkVxBb+RUxWG
	37RQUwlrqq1I+BaZZEgODwtDZn65nUmIggKr9pHluAjz6O+ZDynXHlegiyqeP8/d8JZK+Bpubrc
	+fYbnd5JDWAav+bXX4MEmSl29Kn4sTtxTh/i2bY4YpWctTiOGKt4rzMI3mJ7BrSH2Xd1cfnR+G/
	fUbCqzyRuENFdm5qjo4MSOEoDN7cLTe7acrASVV2Gw==
X-Received: by 2002:a05:6808:178b:b0:4a4:c95a:38d1 with SMTP id 5614622812f47-5640db2ba7fmr3592623b6e.4.1793568637747;
        Sun, 01 Nov 2026 13:30:37 -0800 (PST)
Received: from github.com ([40.116.73.178])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd93451sm6448490b6e.3.2026.11.01.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 13:30:36 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 00/15] bpf, sockmap: Fixes for verdicts, redirects,
 corks and recvmsg()
Message-ID: <ebf9060f-17b1-3b5b-4e03-5a9b3313dfad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 21:30:35 +0000
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

Hi Alexei,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Unstable: 1 failed test(s): =
error:sched-mem-pressure =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/41343383116

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/072b58d52e7a
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1198251


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
