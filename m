Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7172D6E72
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778451389; cv=none; b=aV6xzCRJCADPhYS6iiBxWUcUfqj4LQztiU8k00sVJrzvMdVJhJ/JD8/EAssAi85hZfsjW5JRll3Nr1hmaSK0FYGkwzb2qBC2rhQ0CyX1O6/vCtEs3Fp0ksQ6xvp5+1e2hYVJh66OyehPIVR3sJABHOqCLOU+vOP9n+ViTOoDxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778451389; c=relaxed/simple;
	bh=LYr+XY8V2+2QTJMG2oPh8fw/2gdzkQ+rMIczdv6iHrc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NX+ZQMFVW8iWQu7NolFGIzv37HYlSC18xqumrNpWmwAjYUxGlbFvWsbTQTXHNb7e5kFI0wE5K1O+KnpS1z94uvjUCG7y7XNP8ksfoWU+IG2RaRXpo/fo3sw//SyfLMeWF2w8o59/uj7R75WNxh+n+5hg6s4d/9TzcUq9kKrOzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWBMJCV7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWBMJCV7"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so2578139b3a.1
        for <mptcp@lists.linux.dev>; Sun, 10 May 2026 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778451388; x=1779056188; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZ0neci3l6+C+V5aAej6z3GSJdf73Wg2lkVbUtaTo0=;
        b=GWBMJCV7L2gD8/bCAgN54PEqftgGwasfVbQdXUgBm7rAxSIdzcmoge0hEimdlfnJG3
         TI4WcQitATKtKdMElp+WCE7nbdIIC4UsRw3ZrBw4xfenTvIAdeHQlj6VQInpf2yV79uS
         3/yThLJpOC2cynt8KQNfGsdkfc6Ni2k701s2NGpns4qq+WhMX1NQLlfsORZqfPkrg0oF
         kloE0orCHalUzh9Ll/fdE3aXu4OjQ/4tvoEih33FP4O21QOn47MBM/dq9H5xWVyxrpIh
         ANctgKZNB96KLdeXly57YAFuCNqMloloVNx5LQ1NtOLVDM+NPL4fjlYl5FAyP5O9X2WJ
         gXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451388; x=1779056188;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfZ0neci3l6+C+V5aAej6z3GSJdf73Wg2lkVbUtaTo0=;
        b=lAYUngl3X8PoEVXbTvandLfTHXhDUEiLRamrGcj/i+qISrVJmP3RGqoLnvHN1SGRVY
         wtGDerRu+tltAHXGVy03kNmtjN4pEe+UEqDjSyDP5036WQPBm6J7sg9EaXtgzuQbDy4O
         0PD/BPZCwErK4bx6U4fYgL9MQk3prjw8+35uDYPDpH27ZUgtg5qOx1eVbehtNFx1qmbY
         5vZbA2j3r6T2Z0LyrsKrY2g/jCMwORJd3x4EgQjYwSGXYB+K9xvfxrQSF9LWJGImgU9e
         N8ofs+TdXWPwAxRQN/K+DYsaVd+S7R1n1axvl25JxwL5MLW/gAXrnuQBl7Y+c6tyDZrI
         j53Q==
X-Gm-Message-State: AOJu0Yx1TippcLJBkMg/326Sve0eXuffpu/IhCnivfUEl0G7sPIc/uvV
	x9NF/XXhRInmgGxyaBsTdm+zJKJkGTne8oP6H2868OpRT5SbVsrrc9kQl2AM4+U=
X-Gm-Gg: Acq92OEhiH1ZFJhU7RtLND8eRQzcgPd4nYBTEe+A7cGFzjCVNkz+2P3UBBcIsYcAiAs
	ACFZ9dIvTuYFLNLumvZxZvEJEd1xya/bUOj5rKJU/1fsTIhR0tD2uhSc60lpPml08Hr7BSedsxd
	jKQLyVjE/sosQ35jmhE4CpVdNWTDmz6i4trzcZtlHOVIYGTbZCd7oBraJFSf3bSjIrghxHrbIqZ
	4wh+eKFFgoMRRjrAU1or8PnQw31ALHshT3tbKfjQP3+kD161r5Nx08RARsBZJc+hMM0bVpSUjr/
	g8YiNGfFr/8t5btbzP7p2voEamvv7j+0WcOOx7q0IP+NOKUZWHZLp4DjJtvBla4gg6zCrV9CjLh
	LbfpoXCYgQQK3tCIq1wMS5EQBCol9tdYBW4fZIObROjAHuBKT68v7kBaX0FEMdk5YQLiqXpM8FS
	SZGfcWFUqHBtJNk2ST8/KIYg/pJKtyXqK0QUmbuBi14dwa
X-Received: by 2002:a05:6a00:4c13:b0:838:1636:e2d3 with SMTP id d2e1a72fcca58-83a5e356454mr21129607b3a.35.1778451387535;
        Sun, 10 May 2026 15:16:27 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.76.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcf36sm22124955b3a.41.2026.05.10.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 15:16:26 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1778446731.git.pabeni@redhat.com>
References: <cover.1778446731.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v5 00/12] mptcp: address stall under memory
 pressure
Message-ID: <f00bdac0-b544-87b8-2ef4-ca4de0f045de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 May 2026 22:16:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_fastopen packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/256401=
83335

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/49dce7f2f3dd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1092385


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
