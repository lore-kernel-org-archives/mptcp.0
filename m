Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487329B229
	for <mptcp@lists.linux.dev>; Thu,  6 Nov 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419870; cv=none; b=vAk2G++j6CQFwWxycB4Fpel9KyDA+zSih454jSwyD3k+S1QtX/uuJZ6RZoKGZ/6RyvWE9okpnlVwu1OyKJAF3tbdqInOZt9etJyByJM/XEyEj85z0geYXqL9YI/YyHK0ObIOjriWe2EqnqM35i4KwHwYC/JK8rcBAX0JYerb+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419870; c=relaxed/simple;
	bh=p2apfm6yEigDPhxw4uuFcFQlEqhxOGB3vosOItJmAHs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ZC3Tn/dVtPdAU9qlOpumji2JKzbpqk5k5pr0L+ZS0Kj3w+a7iLbA6MVKeKpcudKv5svIufAcYt9TjsOgVz9X/4QHSqcuD/MxmFLuOXwpcPZ7yPhVjWJzgm6RjyKNNeyoan2nupWeBRlJ3HCmBQk5r7jDrVBqDR8LElZron7BTTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoMuoGaq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoMuoGaq"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-4334e884b9dso3677175ab.1
        for <mptcp@lists.linux.dev>; Thu, 06 Nov 2025 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762419868; x=1763024668; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8od+Y91B0M00ZyKvzWrR3qps5e1nJR17o8jwtt+m3lc=;
        b=AoMuoGaqe4xXOqTL4aEB+qIJIb2wKL6g2HwcAWBw6crRGYOicvOTWaBEJQWVKD72l2
         f7QqAVi3ZlxNuBsOD71H3o0cWhsrVeha8Q43XudA1h8X1fHSBtyy21/KwGiU/INQu+/l
         7013XbCJ/CFzG2G6us77z1D0hZB2X4k/NOoOhICIiwLLLLAY8YrPGJQ2IaHW7Qb/gWZI
         4qUEPOHdQLBteEjQsZOsrjGbtLntTV8tTQWuvvnvGd4Mitotlw4L635hUQ5QVRKM6n/G
         dSt81OthsBBNm/OO24M2MB9Lir81gsLRNaj7Wym8RdC/N5QPUIRITYQ2XPRTyqPocRg/
         1lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419868; x=1763024668;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8od+Y91B0M00ZyKvzWrR3qps5e1nJR17o8jwtt+m3lc=;
        b=Vpsw9xkgYmOnpyf51+reG1S1POhS59Vz020R2eVlbQgg58H9XO5UW/Bou0fZSRKME1
         Qwc8w7M/2b2CQ80rLzyvd/1963fItuT42EBY2F2S8CUdUOxe7q1lFof31Jmut6AxISDU
         /DntZS01zrWzfIN4jzmWZVgOQiCqojwR5vpfBt1d76zMkSX0xDYgDOIe0TK63GlwI6lj
         NWVbFEmo7DGf94bo/+mWp/vy6qeQuYcrISFH1/HbfoA0GtIFl8XrDDX//uVtNN2yuJKQ
         G4YC41peLdnzvsLzv2dicRcOIsswFJE04ruet5iSeeZIFlkss6mRfG+5a7ITIf/Ko2S5
         PtCg==
X-Gm-Message-State: AOJu0Yxjkfl2Cr9zf79zxA2owdlh9lqS5jB0GcNPWNGi6LLeUknl+/Vh
	u4Y/K5bdyBqhQdnd2u4VYZW/E3gtkKnWMLcCOhuk74Y3NyOjT6EOPvLdBEQfBnM=
X-Gm-Gg: ASbGncsgfug0aa4+oTl2jz2vWe3zquIOECBpCCm16cK6S+1lnaOFOBZibwT2Fj/GzVB
	b7l4vXmRFXjTH7/t5+Ytr8f5neSIW9WhNU2BgrTDTshWcIpNQPD//SgZRJtMW2rHMoDp86AlIZv
	h6Bm+acz39aQPelnHPhaAp4qBjJPETAvc6K6tDmEsXn4rFHbgER5hwbpoJw7nNEEWhfzWAA0lty
	uvaIlhJceFm7ob6samYpdMec3+gKnZ6QjNWB3RKvEE436HuxiDGt9Ash6XHh05KBukBqkOPAcmJ
	N0Jds6aVrq/+FxrS+nq4JtpOZi9VLHpC1vr3SGKuEybYfP/QGXtWUmP/+jA0916OTwGdIAX4CK5
	iFc3F8+Kr8ChSEwRGAAmAzKOr53alif/C2nG2bDjOAygZg684KxYohzDrMuuNFZEhOUdrH8wzzy
	7oPtx5twMBx2rHMdoXX54gXRc=
X-Google-Smtp-Source: AGHT+IE8x90PKPe03Ib+CVLrVFPLAe0qFmgwmrloBJQGdb4/HtN5/Yw90Gs0cNJcEtbA90UhTWBsug==
X-Received: by 2002:a05:6e02:1567:b0:433:2400:2eef with SMTP id e9e14a558f8ab-4334ee78384mr35483335ab.13.1762419867604;
        Thu, 06 Nov 2025 01:04:27 -0800 (PST)
Received: from [127.0.0.1] ([64.236.200.83])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f4e366csm7222185ab.27.2025.11.06.01.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:04:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251106075457.41025-1-gang.yan@linux.dev>
References: <20251106075457.41025-1-gang.yan@linux.dev>
Subject: Re: [PATCH, mptcp-next] selftests: mptcp: Add a check for
 'add_addr_accepted'
Message-ID: <98c5efd5-afe9-5b4d-38d2-94ec5c85ba65@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Nov 2025 09:04:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_sendfile =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/191291=
23754

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e9de5b91f0a3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1020287


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
