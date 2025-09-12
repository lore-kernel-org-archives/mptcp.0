Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F0D38FA3
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693123; cv=none; b=FtuxBHuxuXdVvhcu6nx0D4kJ/5/6tq/KD52lWb7MH8dt6ORIGReTrVtv6Iru7dzWibpvSakstjsqV4PQFrVm3J06mDncxCSJu/dIf0XC8h2kmW7A4N/6aU/JOQB1j1Zi7kTjdOvMUxpf+imMuXiYffV87iO+3awOgP1D29H6tdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693123; c=relaxed/simple;
	bh=6CLlLONcdnsg4VugKirODi9HXv3FKZzFsd/BLti3SZM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r9tTfuee5Xdgi+MjeNGTj7nmILC8R8hhs7p17dVVLBre6iTg4PHxGkbdOEJRYeb0K5vQH4OWOORJupcsfuecRzhSahZiJPp/J0O0uOseRFHKdOXTppRFjDvgeq/nxFEUno+krwWxIuPXNzbz5qcy2GtbrKhV6g+Cl9ZP5y1OYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHQSOa2I; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHQSOa2I"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1901238b3a.2
        for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757693121; x=1758297921; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4urLH0JoSqp3D46fsfzv6o7X0QwVjumJLbGbd5kcEcQ=;
        b=FHQSOa2I2je88cIiZ45awNFaTBO74HoO/KoB935t54b4fP2ZLwbYaMK9VDpfpuE4oJ
         n6DY/tyHQqptdzphwCjhP/lcQwp52tZs4KMcUTOGHhqwh8mRwjYj4JJrEpx5FqilHaB2
         FzQBa/4hPRw8Tctx+RaINUh06XhtMF99nFJKeVXIk8+sm6LMRj51r3qEDUvx2xIQ2ADn
         RJoS2xCK5s/kSTjQGuR8P1aUNTvIH2U3teWqVYWD+6Y+t4OAXh2YhUI191+ZeUlIWxcz
         Xa1lSzjSY/RPfwXjFOJ0oQ+54og+rxYzsT98XdAPUBPRf711NMaqYHIWRrt/ipgnakEB
         ulaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693121; x=1758297921;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4urLH0JoSqp3D46fsfzv6o7X0QwVjumJLbGbd5kcEcQ=;
        b=limMKzgJ+/Udx6fXN8xQJt6T9vtEtqFmV4WXreOdoU/bYbIABn9wBv2f1U4X3tWxiI
         xUI2kUlK+bZKwedJXSLIFHDaIDM1sdGr5hnbfEnrgSX/Xr3ramE3jttzMKDfxzVGqUOX
         tu7pkAMHGuxu/gxDHPkPHHmRBKylvIWyAL3zgFpEoqUzj1kzNAV/lG779ZqAlhavz5//
         KfMyoGJ2A1tu2CzsU6PkR5Gl5NcGLC5QxNnli5IPDlMtuBDUKXx8UcKVH4IjXCtoaas+
         gWzRQxCFonaG4aNUjrC64PvHHeYYTJ+jpaYjH8YTqOJixA+azbcNxriNXWN3BRXaZubr
         klHQ==
X-Gm-Message-State: AOJu0YwyTBIlzfUmJTaKsq0aEUxK4MlR6s3FIG7UiNYR1RyJQDxcTKrC
	77ltCWrr3SK4Bpze/YBJXY/4RPTnd/bvovsbflt4XLkDgS2BOJjKHFNqdz20
X-Gm-Gg: ASbGncvKkM/Z4U14VbTZndGuOLTUwe+zWZDofbYF6xKrryioAX0fCjJJd8m45HfU7oj
	kn1g4CtLbt0OiXlT1LgE9nrsHn1Ye/mep5o9DmLl94US8DGL0/bpkMETqdsMS/DU/axwLprx+TT
	zDTD82NQ9VLIr5SeZH1cMlTIZZe72Dnh+aP4eAj7bkjTKDt7ZxySjnipSCq7jM0ayJFSuT14MFY
	/L9x0uBdqAJTG+4qT7Kh2PC2B4VLMQWooySTnKexo0cRxtSCwRyVFt9k/H2/VynnOMlzLEVRXsR
	HTJ/yD3t134rQ1ZeFgBZF8sYLoi//AJbuSdAgLylTVoXmmw66spwWKYi985ca85qsfN9Mtqb8bi
	nOofRnri0vrbL44Rdt3RWmxC6b02pRvqwLYP4
X-Google-Smtp-Source: AGHT+IFk8xEOmgejl350Nb+qLsdvm4D+v8mRtpckIRMBJrtF0bbONcapzQjwTxNw9B4UhLhCzDtCwQ==
X-Received: by 2002:a05:6a20:7f87:b0:243:78a:82bd with SMTP id adf61e73a8af0-2602c71d39dmr4850602637.55.1757693121048;
        Fri, 12 Sep 2025 09:05:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.126.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ddd9ea344sm5236267a91.19.2025.09.12.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:05:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1757686538.git.tanggeliang@kylinos.cn>
References: <cover.1757686538.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/9] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <296e4774-e1ec-efde-491a-f56025801e5d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Sep 2025 16:05:19 +0000
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
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/17677628486

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d377d14467b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1001827


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
