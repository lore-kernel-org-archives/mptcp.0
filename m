Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6473DFC80
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769887; cv=none; b=DkI7uXpStyfuvM0MmfsoQBw71f2LHZNAAHnF8cjYsybQiEoCr27ZGuK1wGlwrscEutWW8u2zS3lK9yA/JLxN23IIahg+++ZDwtpbYqyFNfAtdpezrUSVMHLU0zqVals5phLYAtS+cowh2nSdaLIjCOPPCWFsj2YlneAy3UqeeKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769887; c=relaxed/simple;
	bh=kQjFbhkYB1wzUc4SZK9y6HUhoC5g6KPvmjaZvYcFdRw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=FK6S+LGnk10TACRVnk1XvIkRfckidLYAlsX3QuH3TK8iQJYvO9xuIWrAK3buVOrNUVffiu9Eo2+orN4XEXXzGO254DlnTYeBDuz2IAVB0EQh5fC2BdqL7Q4MGDXh73ANWIwxbE8UlLfJcHbtOv/TQy+Zm3dM+YGAfJ6hY9IMbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzCjAJFq; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzCjAJFq"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50fbd79350dso73296631cf.3
        for <mptcp@lists.linux.dev>; Thu, 14 May 2026 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769885; x=1779374685; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1ECkTxxjEX0Kd6W5Jf1rKhEBg9Auq7PsjDj97jOm6Q=;
        b=NzCjAJFqKn/CBbLrm7P4FhYqeeKmNBQYI9a4tIeyR/wO40yvBn+WStgJqWhvRqmq7M
         EdPPxPCIY175BhWnH8P+U++mVdZGnzJuxdF8xladrG+Nm+W4q5zPGrnKOjlPjEmDDbez
         744nxFrcGPsWlJA2jfNq10ZDE8Ie5dSkUvCmvJujNguAFQA6c4/TgEKxTgBb3EaqTPAp
         zbjOHQQpmNCxO76KRBYE5IiZ9cs9qdq0n1gfWBrmtk2/h/H3DpY+xHECGJmPViO0DT9q
         EiTy7LMvL86qPtLoKvte78NyNiCZ0/FAgjdjiKMOlsK5tyo1have7PCF4xTGXFPT6oSV
         a7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769885; x=1779374685;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1ECkTxxjEX0Kd6W5Jf1rKhEBg9Auq7PsjDj97jOm6Q=;
        b=BCjwtIA2TkisLBCMaxSB74UpxzUK6Gs3FH3M16BluJiJOQHd56B5A3he/fh+jn/Qqb
         fTVWzAk8h85VRjaitje9tLBwFBISeL/n3dkP8RzTeuViNnCZ1UknxMCepJWHmgsm81Ln
         CipC18L/HA0neBK269jIT0X0gSMPF1tuXvWsuabQMn1KZoMHDZg7nnjO4T8pSuZwLi+7
         g9juX0eeqqZmB5s23ymTEWMSyd3B/fk56twWCP7pogPQHI6a7fzOPy1y7wW7l+g1sMNW
         2Aucx50ge23jI8k4nNbbCSV53v+jtXRga3aco5VaM9uufNAsH6gR8fmi3FNDPAiY4mm0
         Xszw==
X-Gm-Message-State: AOJu0Yyt8q2iScviMqBfKqeALY3I72K/smShLtGFtt5E2eAokRWJ/kF0
	vy8/xNmrMBuWwqqNbGWekVQEHuzbK3zm+ccfOJo6UGxuCBZ7E8PQt2ogu8bD
X-Gm-Gg: Acq92OEOb87ry28i6XcL766YpUQ3p9x3w1JFgsm3kb6gQ3xrjOSaXelOfnH+/tiHwdX
	XKS4mhX691Rj7xbbUrbQXiBxas851ubQt6Qnpb9sQq0W3D7oN79bq+QasqOhXKyt02hQsSiZ7YC
	UCjzeA9721ddCFXXC06g5M/4Igv2kWlItVB5nM8huEtN1QyyJ6t3FhaannB3GfLBHMe3Bs6Fp4O
	G25PIM7pOtkkJbDCsgKAh+4+N5bjmPbDAXcb2ICivS7m8v6edoLAIZC8MzB2OVoVsCx66je+opB
	iI5O0Q16tHR8CRHd6kZ/f8kHQWrqu3hib0m39xTZVP/1Ea3bBdsCA8MoI+FL/g8pDiCQGZ5TImo
	C1mELZwM2OAYl1jyfaPbMMCVps34V2SMxdQAb7VaVcsBdDSwh8Df3WwkstBc9zGOuaRTpTqBWpt
	zQMQ71a9yEj/p3oUiuQ6J6SPtOD5j9DcJJ4m1yPn0KM+PN3JQe
X-Received: by 2002:ac8:574a:0:b0:50b:4001:ae11 with SMTP id d75a77b69052e-5162f680f1fmr108643981cf.57.1778769885304;
        Thu, 14 May 2026 07:44:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.46.104])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm19605341cf.31.2026.05.14.07.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:44:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260514132925.410184-1-cuitao@kylinos.cn>
References: <20260514132925.410184-1-cuitao@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: pm: fix extra_subflows
 underflow for userspace PM
Message-ID: <d272e210-c747-9584-80c0-22e81c4d8b1f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 14:44:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/258639=
48276

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dec78c185606
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1094801


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
