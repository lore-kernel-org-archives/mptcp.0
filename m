Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758850;
	b=4km5h3dVDdvPnuSd8Mur4kdTRW7ZlHqhs1b7M+NFhP7yG4lo8PjeoWzT0OfBuHUmjb45
	 53NLoBFpn/UroGIOlZO4EkeED3uyF950817yW+MRkzG8ZrzBkJE+fPWCVjzTYvi6eWr07
	 v8F8533HmcjQMygXlSxHvnLgY4Awc9TNhZNXJGVX8pWZk+45FdydaXA9eAZk7YHaDwyST
	 +/08I61+khmkTiYxQoKekYXQ6vdkYIR7oBBkJYHpDfWoxF1W/LsPoPz+GXXyZgRqJlVh5
	 V1ImguUNbaAj4y1wHF//Gn/IElMhxdijSLI7eqAx262jpzwrSSFbzlCMhWm/U3Z94Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Ap6OTWnG8EkVIr23DcEWimejirQHDw3Kh65SbqOHB7s=;
	b=LOOQw3/nXHTk2XvtDxvBOKxRnK1s+byfUV5jTom0TTYHknox16z6oAtwozpeTrG1Palp
	 is4dr69ef7ZG1izD8aVr+b79GxOOL9SGmIYAH9iIQ8DFkquAIblDjFCfpVgZ7x1/AKLcx
	 Xhz5JQjbyLChDm9AQB4ZFvFxUM1CxUL0WouJ0HX9T5ULZC1tB32dWJMJv4UjAsKkUqlDQ
	 1HpYmqodBiuiq1/vyNuuweLBh44eNngHpaiZ0/jsGyYSa7/261uYXaP3EG51AhVPSr0Gu
	 9B6gBVItagqTFTUGxKShSGVcgGo6dRU5E1ldD5orG7BjPwXMBMbaZ829roityilED8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpBpHohz;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A56606A31B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 12:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A56606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BpBpHohz
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35f1f76ea84so1283221eec.1
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 05:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792758849; x=1793363649; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ap6OTWnG8EkVIr23DcEWimejirQHDw3Kh65SbqOHB7s=;
        b=BpBpHohzILzqh6sRd19LgMSSNcJC17V65WEE7aoTOSESVAeUSdz3Xqx2N7jyT2+D3c
         BAWfbn8xmb7K3uiBu9u0rSyfaZNNDu1Ovcmvcydg5hpA1LtbEjSOnf0Pxi2AbRvYvyJL
         MN+nhHtvwfySny09Nn+VaCv8O9mfy5G7+BeF1VBGEqZefB5NDaO2tpHPwCiM5f7fCp25
         BblJarkgSW0J99/iU3EU4eldm9QI3cvlnTN2o6KP6TnR4djF5K5SJVttRpH98AxJX2cy
         sf4vc8fZhOqAEj4xBmsFtzGrwb3tRHI8hckQPWbZS1DyFMdY6d26v0CC0Pg+o91l6q61
         YfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792758849; x=1793363649;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ap6OTWnG8EkVIr23DcEWimejirQHDw3Kh65SbqOHB7s=;
        b=ICg8fOx8RvaSfOS19O3C3SOkOyhH923O4CsgjXAZxg9AVBve/Jw91ABh9J2n0doNQM
         7LBF0M/54bz9TvwgvU4sUErtHx5NrkMDnxV5t6EY8kugOipfG5UqTyGza3r5AaICARAH
         PizAo5DZSob1Gt2dRYy6YHi8XIWQM4TWi10EACsZ1P7IF9ImZeGEPBs3sjPGRSFpj+vx
         J4UnmrkiAY30fDh9VGrUbk+I/8+EOvbRBrDITkezThbOMlIbEyXokbsnuDAWykNE65b6
         YVNA+c5yAnECeedMlATUNndsk+VeiBu1punLh7JFhHB1d6Dbc130jQL89AdOzJF0EPfh
         u8hw==
X-Gm-Message-State: AFq9FYKsTMCJb/bWREepokQNvel1PJ/jJ1g+nqmonAA4YgFNvfnrFDNV
	WOuW8+Zye7eWON2XPlDhPseD1rCh9gnXl5V88BX7ybgzQ5XL5x3Goco=
X-Gm-Gg: AYBFou25l4PgFggI0P8oK0XP7axaJateaIDpmQAU9FwAzuXn4PtrSotLzpRcZZXlWx0
	CHZUoxhRZIlKcYZBV4YZEfmswx1GQVhdSDasAhdU3GMzyZbdhKUlQiJuLuUrn03hFqhNWZXBkNI
	6PNz4MkmFYk/NDHzG/Nzkxdra+uwke7fw5fFz6ogD4MSK3OskcIrYUWrPOi6oRT7fqvBHgVAV/q
	2RhJwH2jTcTs/GXVUdUsMuTny6wK5gi+B5YklIdJvlbiSd9Lv5UafhvdkHgW5yK4UdgxU9kco6Q
	H2KqqJnkji65ol13GzTcAbje8qSwbraOK+bnE4PROPSrFmaS92Yn+xeKg6d5qUpWHVfOncnEjJU
	sO1SFR7YT99bTmxyszeK2YoGzJZw6UKehWlXP4vzrH+6r4xkm4Mxrd4Ta3TPihjPqUHLZDm5Uvi
	/Ijbm7TCwH2nSgPAgG1PgAHMUPgXk5JAOjo19goM3I7uxBEbVVTpUXV/wEZcWDJogQ/TGGnMu6u
	AM7T9bLlhouzjQ6/2OMMMvEqrpDlPKvLQxIaOqLl8YVkvozysVf6KatSoI2DkJwEvA=
X-Received: by 2002:a05:693c:8392:10b0:360:b8b4:840a with SMTP id 5a478bee46e88-369d9899130mr3023737eec.39.1792758848954;
        Fri, 23 Oct 2026 05:34:08 -0700 (PDT)
Received: from github.com ([20.171.23.187])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d5ea64sm9117567eec.5.2026.10.23.05.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:34:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261023110321.403874-1-w453y.me@gmail.com>
References: <20261023110321.403874-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v7 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <fd4ac963-d67e-5ac3-0e7a-7980d0a61cf4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:34:07 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Unstable: 1 failed test(s): selftest_mptcp_join=
 =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): =
Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success!=
 =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39945885343

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8237af68cd2b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1192064


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
