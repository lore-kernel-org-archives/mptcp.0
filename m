Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EA347B432
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 11:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780516; cv=none; b=u/6FlBZ1FLjGXLYP6qTRXmv9nRov49ohgGqIsmOCUC8PqYjAkmQFamvqpNJfK0DkMrsiEj4kV6xnSUEPvSvRs7q4q6xfG2vQdMPypp0FPtOu6csgzOBKgdAcU2mUhymkzkQVl4a+R/F7WStpWVW6CT7KilljHmuvK3unhODnmBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780516; c=relaxed/simple;
	bh=VllUB2z1zPwM1wuyerWy/2/UaoNt5SuqyOIUcNgCTH8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=mC/B3XoAPfuL/+vy3PPQdV/HgpWr6O0M4AzmRgSABBvpNV1OJuatWzsuZfPdITKBaD2smxfEaOv8gvaLIbCkxZh9Ws5hyeQC+sxegVOaqRab0s8ccaQIYnhXqcXO3GzkNArnof81z22J/Ex9wQOo23HQCReT5ei+a5Q1zWyMx4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvlQp6AB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvlQp6AB"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9399798ca61so203379385a.1
        for <mptcp@lists.linux.dev>; Mon, 07 Sep 2026 04:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780513; x=1789385313; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9TVGDRUQdf9UGi87InR8ONYeJBXmJPIQ3wOU07UEFFI=;
        b=KvlQp6AB2Fx4YCb48l9O/bPr28ljJ8/VmgVTlXwTFXVNppmTday9oJx125xYUeMLBU
         Lyo/2CqaUSKF8Ar2PiP/TiFSgSNKqWneStrnmDegWebbSFfd3vS1nLVSBwKANj9bgtBy
         E4/+vk/YuZZgoQsN8qgnxJMilyDe6jqcqxmPohp9hhTotk0QMbQFGat96tYk5fuCmibV
         WZyizco9PuL52NkTb3+/l3oFQZek6dY53vw1EON5iPK2KhXHE+T0ryGDVdnl0yoZDAfA
         UTVRtpTcs6hK4W/TGWc/+EA8qnIPV+zaOKd+ulWcjPaeyWKwtsX399XvOBU39K21gt6a
         UvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780513; x=1789385313;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9TVGDRUQdf9UGi87InR8ONYeJBXmJPIQ3wOU07UEFFI=;
        b=VMRUSyHNcGyt90I/X8VkA/FhDamrBY+Eko62fwiEIghX3RxsO8ahfBxcyWRsCc+Bi7
         1XNWh1a7JjUlZMojfq44pFLyfrnbCAmsW8TqiUk7lgd56E32XDnd/RcujH/WSUZKdMIB
         RZesljMJwVYmc5doect5IS+DsUoJ1D5oZBdRtdRPGfl9nYrRf8ruExLjAkDYU7CCM3ZI
         S5kAOXasyUz+ZQWPAo460ZC/dagIhki+jrPkCxccTu7pAHRLyOns1/9OTG3lyWOBGppN
         iqkNWNLXc7z/jwYzRJy4qRxEYZoIq08D02oQoMXSGG4WwcDK2x8EpclOWBTtVttiT/PB
         H5ww==
X-Gm-Message-State: AFuF++lTIm/+aaEHuGOgcSFqpH+YPslxAjiWrnEoEb0o02vqTz5ZqXDM
	29OMztjKy5NAljrMxilFTXJY4HMpG1gRjx7cYKMkbz33pN/5c/j2Yfs=
X-Gm-Gg: AYBFou16tlFBed4/DyaHoILGywSyFtHM4iYkyXHdlB0KOHPrscYudnmyWmbN+Wh0fOd
	ZQfiD5Gk8CWIsWOrnX5T1ulFVMo+T8PX2Ong9nFtGyzZ3Zl68DnNdA4IVCTb61hOFHgjJosI5Me
	vUARwAEa3SducXb7bcJwGL+Mrt+Gd33I9jFhtrFo+zJEg7Z71tJGygfDyudAs1C/XI8KeUwr4R+
	0gfrM7zOqSebPmcGCmaokOmxZcD1d0u07EcRLw5A/WAnwcoRsOqfpj+jQMlfKNVLXO7X2uitSiV
	Oy5RFZCITUh4Hz9ZR79KeQ0uhyOfQ/EDKPSAzriK8VinQk4lB7CtdIZYLZXx2q0GZME+tyh2mka
	Rk1T3yUFMVLKi8QYEDk290hEc4n1fgh6YVCLHRu4GEAuSLCjfxO3/a8xZpFb/ROkBaA9/hPHrzm
	eGZFwfCB62oP1eAAY0jJJ898cV93+yRh06hxAQ+Ld3nFZkRjTJl5z938+xqnhH/H+o1SHUMm5Mr
	O4=
X-Received: by 2002:a05:620a:4151:b0:932:ddff:1241 with SMTP id af79cd13be357-93980425ab9mr2383823685a.26.1788780512903;
        Mon, 07 Sep 2026 04:28:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.223.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397f9f4b3csm858117785a.5.2026.09.07.04.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:28:32 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
References: <20260907-mptcp-snd-una-race-v3-0-65ba0d5f0221@proton.me>
Subject: Re: [PATCH mptcp-net v3 0/3] mptcp: fix reported data-races
Message-ID: <4c56204e-83e9-d01e-830a-3026d4feefa4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:28:31 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/34112482705

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7d66f95769e2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1159615


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
