Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE51E3DCF
	for <mptcp@lists.linux.dev>; Fri, 21 Feb 2025 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120097; cv=none; b=ZyOAHrAhlNeFN+Pv+tj7mec4vVrfG19yr46KRMFxBDv3oiu4JetDqw8rkbmcVrKc0q9wyhWGmWPXIn3qm9firvfpjHwULYLzRdi59fjDVm0yRrNJhoyQtyzKB0J/mEb0zkwpSHgaGbkWF8nFqyKt1/FSwmftVdPnfBGhQSMv4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120097; c=relaxed/simple;
	bh=MMePdUQZ2LTnL5QCiaDPF+zoDORfyHBD2Mh8rC/lwU0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R1L/rajm6lFW1W3C+KEn8Tus4LgjrCp3W3bdTB8TyPkiizXdrxD1gtfwC7+AuDkoxDWZ39bcstvnlvhXvUHTm47mEsgOB2uC95YCAzvuR8s57hUFnDYkv19v8nggG8kYW1zFLAiieZe18D/XWX4/nyojOXKviG7+iEXLcG1DAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkXXU/Uh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkXXU/Uh"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d39a5627so27075775ad.1
        for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 22:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740120095; x=1740724895; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2XcQwiz2SdunBowx6wIHQbdTwOqgXiN/WOiBLrSZ6U=;
        b=AkXXU/Uh9ylLY9ih89i+Z7UKGo0yka2HukxB3PQJchEnqaDcIGyqDU9DmIcNWFT4iT
         gH7FnsI/55Lu/FPZKCgNcwlkLAdjm3EK6/AJfJFvtT42b1RiasM9PrnrTFTYZPwV+84S
         orfdpKxXPz3K+PwNUBaG4HqX8+zeProwOmjuDymkXUlqqW7W01HsDia6vshE0qNe08oI
         nWr+SsewAlE20H5kxm+0VPWYROSyIm3NEwCf+Xg5CKqPl+90m9yD5U6+8xBF9wcBTd9Q
         IRA4Dx1N4MagkNwfDI8r9DGcb/dLzpsOJUI8b5aAkFe5BoTbjztItLaL5yJY+u2qrDM/
         VYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740120095; x=1740724895;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2XcQwiz2SdunBowx6wIHQbdTwOqgXiN/WOiBLrSZ6U=;
        b=STr7MhVA3Q9V+RNycV8TXLG7CBvWVGoacZalgAS6LX3NMO2g4KR356zrnEWDuiCLRq
         hs9VEZQhswv5+DKSuZEjYoNzRTzIQ42DzEjubIfATeTyZZ8XjBvXYFCf1cZY4juUVfC9
         F7r0QAg7/m3suGYdmuq+dlv1pq3xUp/gLfT4mB7TGFU3C9LKwkxbhrjHiKfSk/J8GCsV
         Sdjfo4qSgohVEt6bPOUPjai6O6S9tHZenpb3Qv6XIl/7Wii/fFByeaBaGePf8Bsjw8kB
         lEK8Haw8td0f+lfINAG2x5sKgDn5LDM+8dvkB/Ryz9locCI7CQNcBfJ1St3xKBJeb39W
         PaZg==
X-Gm-Message-State: AOJu0Yxaqba7eXgyEYQXT2akx+1zwV7isZ6CkBffkCXwdAvb+MqGLlMd
	bft+1yn/QASZH0Cm8BgwNbos4YyWlmsxs+Zfb82aIDgimroH5NBuGm3r
X-Gm-Gg: ASbGnculkov0T5gWLV7hNTV3+eaTP1wWCvBxo6wYcMTnURXiDGJPwmFTAvFAUmUymTS
	gRpszFwDzQkIf35/QS87g4foCUKynVT4pLNxE1zpuFF3M1v5+oHo/hyAbL06RBmwMTVKSN0/mqy
	usrtRUfPrlVa+fFO2uu1EbyFeUguDgToJlSpBKHD4Pzfckpu20lzZbhwjzJcNckx21ch4mnixHk
	jO76tSXa/005v0FHEGMvjLiWHaKo79+tMJqStAfpjZ3yfBSVAYogAxbGhBgUVmlktagL1zYbnE9
	GY4CvrGsqwHwj0jXKZBX2puwl1vSPJ4g79g1a7Q=
X-Google-Smtp-Source: AGHT+IEfLskAzoHJYZdH23f4mytODprZaS0lkajZYwpRKPH8HMPzsc4VWUJm8GVMOh0ieN8BkjVLBA==
X-Received: by 2002:a17:902:ce82:b0:217:9172:2ce1 with SMTP id d9443c01a7336-2219ffb8403mr34026645ad.22.1740120095496;
        Thu, 20 Feb 2025 22:41:35 -0800 (PST)
Received: from [127.0.0.1] ([52.234.46.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb05f29csm538123a91.21.2025.02.20.22.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:41:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740115494.git.yangang@kylinos.cn>
References: <cover.1740115494.git.yangang@kylinos.cn>
Subject: Re: [mptcp-next v3 0/2] selftests: mptcp: add tests for increasing
Message-ID: <bc877e17-659f-6079-68d3-ea4205b1b767@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Feb 2025 06:41:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/134509=
23351

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7497c36e994d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936296


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
