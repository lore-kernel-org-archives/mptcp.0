Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21283CA4B6
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233428; cv=none; b=dwNep2nkolbqREBRpSecVtvVKAftWDr4UWVPi+3J0q7BUt08fGVO6wM9CejnCxQ5Qa+MhoSnPZP+Qiaw40qyFASuAdUT+2wCmW2OpvvprkWqWCdUV7t/LiMzpi4NlQzvy6DmcDQCq8cfLDvrTCagdReqbrcE5D7BF1YgZT3Jfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233428; c=relaxed/simple;
	bh=T69MMkis77jYlQhvxyBzFID/vgwG0Mu68IKlgmYMpyM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=g5Gvvcd9BupNwBO8knZ72zei5/A9MXYYagcPGMhKDW2xDmIBx34HHfqKA94QcCaX6xDUWV/aMcbpEj+yzYddrizc46MH+k27pbhldGoi3/+MT9V/ZK7qrOIXxwEtFMJbSzoR6z8E1rEjsoRODzl7EvbmMcSYCBQkoNujOGwTr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZXAC+pr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZXAC+pr"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5091d71aa11so26243941cf.1
        for <mptcp@lists.linux.dev>; Fri, 03 Apr 2026 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775233426; x=1775838226; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDJ9OzWxbLdm15W55n9VnnRs62Oc45V55VB05oCTfPY=;
        b=SZXAC+prD3gyOVZ+CSaIjTHef/Bf6x71/45GzGz7uhvk+dmh7uXbEYn8nCb2CetPUp
         1588usOoWPfhlEcBFEZNCBiEjT/zmM+nuZ98yCx5v8ENf+ep4XNUSBCbuqQqq+9VvmWD
         PhCnnH4jg3WVZmxEj5jb4JUhEdunhEPhL9POIV8UUn5c1FaD1jiOoHCu76hxcblfyqXM
         hJ0JEM3jzs1tIwtkRKLiHuj9pEhx3JJ/nWZ67U2+s/wEAmExTMmRHuALP8NuAr3M+icB
         RXOz8Wdbz20fwZhKg8HmtsLktEshpV//ZgRny/A1uAdGJgChT52IfBQQnuClJXSHLBIQ
         kDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233426; x=1775838226;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qDJ9OzWxbLdm15W55n9VnnRs62Oc45V55VB05oCTfPY=;
        b=OkPRQLYCmysOEtOziInYBmfSdNeUItBBOEMwowk5m7UwkcJNVLM6MvZUFezevXsVgI
         EVtjkPRNPDjXr+8vXSEizJe2yEph10LR2a9EpsLgglN6G215mdEXD2CNy/E7QnbaGkHR
         EIozO1q8s0YaEsgssltUouwfWPzD7eoZ+PwtdIr271ptcthb/Kgf5PGj6oi4fe0CvngK
         XT1Zy4vDG5DgAOL0WqIIRTtu0LCXCARfdyjv99qxGnp/NR/IrcPh8gkpADEu3vBearGM
         XfLD7LTZHcN+L1vEhNq7jyWFw5TCUyrM9H/vOdso2KrNdFYLDHGWoJzIFkoOGtvEswyI
         D+Ug==
X-Gm-Message-State: AOJu0YwiDn6zopLD4kmW2YrARauWq2j+qnccwAPjVCCYiv4ApaLg4IqI
	nWylQ2VLQGBuX8gNSQQ+EWwba8VXcy7UQ9apcvZoIBiNnEXDB+GEghioZ+K9
X-Gm-Gg: ATEYQzw64InQYQ6cQvxtCm4nc/3oalNge/x7GnWjSdDjy/SdxcwMSVD7GcrOEEdsF1W
	vFvVGWIsPvqyGy9OOc7ZTKnxI4ccKJmaVNh8Fw4c8l6CEFZRf3IiIz5O0lpC8xuAxNaVXHzbmS2
	VoL9VMJL2YI3PzfLC7HfsyTmJ/FOoHtpROZVnwYYHgK/h076lbaPPnqojAY0jyiL2w5j/tFBJSj
	EXK+XVB0pC8tQ4dMhBBJjRRcOA7xLfOvVzNEg5CIHlEmiR7zE8Epu3ozqY0OEztBeIpcHszGS5f
	EcJ4R+kj0ZoGm+wVt3+gL2e+QrZJEKthw7VpDAY6Wd7p8VfEX/+4ptGyP8Ns6mLWMrqU9wIQjFu
	m9ZTQaHxMgQ0cqEjbsnsV6LYXQBFnJsULj3hVTQaXe6cXf3RT12Ef8iJ9D8bcXnWSzf203/zdam
	PQDv96ZdrObMR11tr3pKudXVKx3i8K+y5YuYxr6OrYV+ldbUg=
X-Received: by 2002:a05:622a:1449:b0:4f7:a06d:c4df with SMTP id d75a77b69052e-50d4fcdd1cemr83638451cf.33.1775233425691;
        Fri, 03 Apr 2026 09:23:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.191.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5933333dcsm48923576d6.5.2026.04.03.09.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 09:23:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v13 00/16] MPTCP KTLS support
Message-ID: <a43341e0-f252-04b0-6e12-8191dfe4658e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Apr 2026 16:23:44 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/239513=
27562

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/389ddf18b735
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1077056


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
