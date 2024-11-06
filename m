Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074F11D9668
	for <mptcp@lists.linux.dev>; Wed,  6 Nov 2024 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886272; cv=none; b=RmKrM4pOtbFWvIurKOheYN74AnCA14qUQEfoguQvHBNkbaTPPQY9onShv45kC2V8XsiK1Wn5RH0+WXnny2oXyPwvxzTHCyAb+4JWDtjCPC1D0F9tuDoKrzRH38F2mhNx0vjeEEXXqF5GZ5667DXlLy5N5BDd137kMpSebZ292Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886272; c=relaxed/simple;
	bh=rqymGM2g9fxhufjqoGk0tVZ8VBhYPZV+Ir80dpAulP0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Qn62NvXp38ap3e0oSThTP5Av0pvgfNWgeToImTeZaK06SDcY0Gh41NrC8WU/elBZgSOUaLEyvXgetI6ROSEqQuAmPNHfSAOxmVKPj+KdtDWu2SsbV2OYIDe2s7EPFZ59lTR37o2AfISr5c/YonQxgVSWu/+7EM8Tw0AB/54OCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJCcjiIH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJCcjiIH"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b14077ec5aso60716185a.1
        for <mptcp@lists.linux.dev>; Wed, 06 Nov 2024 01:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730886270; x=1731491070; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7F/PTuG4aKX2P3zpB3EXfkNXjcDUwoc2DoWILGqQuGw=;
        b=RJCcjiIHquYDsX2/Fe2Y38neKBuNT/hfmp8DmFerf0QIRJ4pi7mF4Y3NA53FDl5JYj
         N4JO1t7ehoFLXcZtjl/yZ9+vAvZDVb7u9qGfpNCtJKdPSVCixOP8yPuJSo8zRW9ZHyl4
         UmyOYcfFdaGHu1HoqDudjvP4hou0MDwmCm7GIXcLFEa+nL4dpk71GJB0iW84loHG1l7M
         j8vrA+zKDW2DqZqqi/kOnVxssbUiTd2o+/57VlSjVmSZoLmam69/xjcRVtaei5HRGLBn
         WdRG1OVwD1LyG1oDrZdOlOyKjuOSSCzigE/RGZumKGTEi1gs9jcnBTxcNr8lK4//ITwL
         aWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730886270; x=1731491070;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7F/PTuG4aKX2P3zpB3EXfkNXjcDUwoc2DoWILGqQuGw=;
        b=vHR9rX8lN6tZdstCJPmW5LhP1Q7QzdVC223758w9wJuLbyW17r4NUNRcRG4wD0p7qJ
         1Dn7RKEt8KsSa+DC9ktrDUASpRlOgjPnaJHgwzCFXhUUVKoAErzftOrc/v7q3lwcuhfa
         wzM/GWKyGibiedApsBqK6uBCVLFpSthI9PNs2UsGn/YXQwjjcUdM+3eF1iQsqMH8rSuJ
         b3A9d8vCZF29RqyK3yR9iePx499vYxu3Y6aS3wKWMgmFw2O81MJZvvfVnNUc4QGOUdIg
         4p4X/YV20sbUVOl9VLfLDbNGqCirH3Kf1aNshWTXIsLE6xy5+kqM4RVCnKVauqEkRtUo
         qwvg==
X-Gm-Message-State: AOJu0YwAKxVIqncSPvKxoNxXMnL+++J+SL3SaYZXL7JrQcrDZrfwfLN9
	gkEsTLZRxemzRMHBZtUtuA9YXh94n6QWB3rE+TQNwQddA51/xfc=
X-Google-Smtp-Source: AGHT+IEJa5XZulgxjLFIAS8J/bBsRnsXWw7/euvF/vuNbnUI9jdM4LpJIiZnB+SRAFBBhxTBZqFvbw==
X-Received: by 2002:a05:620a:254f:b0:7ac:b197:4037 with SMTP id af79cd13be357-7b3217d084cmr339514185a.18.1730886269877;
        Wed, 06 Nov 2024 01:44:29 -0800 (PST)
Received: from [127.0.0.1] ([20.55.14.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a112edsm606748085a.58.2024.11.06.01.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:44:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: MoYuanhao <moyuanhao3676@163.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241106071035.2591-1-moyuanhao3676@163.com>
References: <20241106071035.2591-1-moyuanhao3676@163.com>
Subject: Re: [PATCH] mptcp: remove the redundant assignment of
 'new_ctx->tcp_sock' in subflow_ulp_clone()
Message-ID: <428d6f98-58f3-4a1d-c5f6-3a9ea5aad152@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Nov 2024 09:44:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi MoYuanhao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/116990=
95104

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4a7996ada8e4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D906766


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
