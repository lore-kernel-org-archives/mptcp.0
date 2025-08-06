Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE41DAC95
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493367; cv=none; b=b5YQRXblNHG8Sgwg/QSZ2lRY5MXxkS5O+ztecTPz4psZqekF13pF9Lv+Am+PGCWSU+XTp4YdMZiHNJNXBEPCMvoYYBph6C9JKGmTG8YhFZLYet3bctwY0l7LyJZgNnFNNEqPexgJqxB8I2KR8v386SzZaH9QG55b1Bl1pDbKJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493367; c=relaxed/simple;
	bh=4YAFU5tpUt86LgJGza5Drqj8cJR+BjW69roRbIAvSdI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SC2QkFeUpyZCg/g/n7NtiPxrJBSCmDjmVX4rrBv/k6xsLEpIHh8EtItrGPsspdcgDx8JVVYO4bZwTI2GNEPpvpah+UL6iJX8L+wAJScz7ItvMqobepmRCxw4ssXiG+TW3+MSspqBDbeThriH6MiERKgTmPZEM0Yu8ajGSZ3I/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghnlQv0O; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghnlQv0O"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32138e0d9adso46232a91.2
        for <mptcp@lists.linux.dev>; Wed, 06 Aug 2025 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754493365; x=1755098165; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAlEFv5gk0P283pNFegQKrbYQPOdCSmBBcZ0u2oY2Ao=;
        b=ghnlQv0OX/txDG/RHh1meLHWgY6vn38Hm/DHg4DG4TwL6N+DN9QQbtMirntM7ynC0l
         amgB7RpIXgu2MNH3LN8mMYq5BWi0N7gZRTFr+B2EDEZw6Tzljbo89Y2OTPylCSVwcZsb
         tf9XHBnFv/wZ/PoTOTCpczODaCgj9qyWpalXOk7YIodUgHpPYP3Mk82UoXbPaqjISPEZ
         qAyir9xwk6TzBvwu5nFCOUrEsWb4GMG6+8rK46DcdZ+2T38vyQMtgeqLmhJNzblUahL/
         tmXOknsOll3qG2dvkHCWU6QRNWNy2HT0a2Ggft/hoCl0ZeJjGAOcejkPtJZE6lq3t0c7
         82cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493365; x=1755098165;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CAlEFv5gk0P283pNFegQKrbYQPOdCSmBBcZ0u2oY2Ao=;
        b=AREQ8ltu5GqTtWouXj1zAMxc1dh7ycLKvqt35bMP0dI9UulNlQekOt4e239i0WXR8t
         5cAA8sD8k+otPpfLSTbiTsoLmcdD/GjOXAWdrnZnCkghPu84cy+arCpAw8g95ftkIFdb
         W47kKFDIWAdmq38edMs4kyrQRvT8yVQMeCSobAO3a/1n3t0iqRIlIrX9OdYJ1K9TcjLX
         Jp3VMbq8tVxncHpz/8xbNsCUHBNnTnt5L1F9cjvpCO5a7IUAxezrkGkksB8Y8G5o6lOA
         Tl8uMPijQaM5QarVtFE3T4mgIlcNfvwiMiULccbTcfAHmTyfv2mqYtdUaiFDZjwqinzh
         P55Q==
X-Gm-Message-State: AOJu0Yw9VJMC1mulZSD7Mn3tbBG4Yo6O3s88o72OJlDPUZr+P2K+BQUF
	JheE9LdlHoeNS77mHxHzdM9eFDdP8kI9tKDH5XvK1EzALXJ5CbLIK/7mhPi3A/0=
X-Gm-Gg: ASbGncsFtgjXSHzhqQMa8rrasc3GEbAItlZGMJy21RMkuh39irpoicBcUpYeU6a/O/H
	KzMOf+5t/L89c8YMShAwbx5dVbiHbnzN4pqdL56Nb51yCpmxvrRYRGqDxEfSC3NB4N8kkcB3wuU
	s/XLEbwaT104X0Z5176aiz8iLz8yEcZSQdF57TsUHJu5D6kjx6HpSLpk9D3jBcuc4g7Sr3VgD72
	i1h+aycSNgcqEZNymVZdcM72Aavm0dXVa0xN6nDq/iE71ahTmHhPRR6MREF+yEd0vaQggERRqJS
	9OsQDCm4HCk3mXbeO1groX9UTfnwPhQdgFWwr3TRoHWzQKcXdoUVZPE2B84XqDjjH0vCyHkGB/d
	87dqukpiIGlB0pTc7kUlg3CinsbcPqQ/0uT7qIw==
X-Google-Smtp-Source: AGHT+IEt2Fmyh8PasDJYKoID0wCEqHxGXkA/YExuV7zABZpxbvKBbrlXJ/3vh8qFfVcFm7DxiGamdw==
X-Received: by 2002:a17:90b:380a:b0:31f:36da:3f85 with SMTP id 98e67ed59e1d1-32167520ee1mr5163559a91.17.1754493364926;
        Wed, 06 Aug 2025 08:16:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102acbc56sm9044956a91.2.2025.08.06.08.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:16:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754449726.git.tanggeliang@kylinos.cn>
References: <cover.1754449726.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: disable add_addr retrans
Message-ID: <e60d31c0-6711-c08e-ea7b-4b1bb4d54e80@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Aug 2025 15:16:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): =
Unstable: 1 failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/167786=
50073

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/eaa0db57b54e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D988603


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
