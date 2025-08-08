Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58621990B7
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628731; cv=none; b=sDxQTByCblH+hyFYYWBEXDCB2VJoLfX27FTsQBHDt6RXwQnos7gR398jl4aVFIGNMJof49kTAhujftAM4egfkMR8uGXHhvVacXBvB6dD3IAZ1Cr6MGehMchcx6RR6LcGF8XxwJPiuCc8BEFYJbDNsalxA3nz0OxdZMh6GKVoB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628731; c=relaxed/simple;
	bh=++118OEF1eP/WMuoT4NxMhoXTInIc7AKdCcNpbpA2Rw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=h4IFnIeoMFvvbYLBrFHb3rtP9alOS7D7YMtpdKAV1hD0+7E/wyLzWdi8b1l7OyrZCOa8wx4w+mrV7AFLcUZDe8kibc7yBqyC8sl0BIby0qAnkHTKAcr3im9/vP41mgdGDoMjOmXS7U9OLVbZyKpZ7n7lVRaqzRu7q8dGi+KkwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0Qlk+ds; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0Qlk+ds"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e6696eb422so204458585a.1
        for <mptcp@lists.linux.dev>; Thu, 07 Aug 2025 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754628728; x=1755233528; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdxjV5xv09RapV/e42hfqilPtUapTSr343PB5WkL2lw=;
        b=k0Qlk+dsMLfum1vQ4FFZnv4JBAtq5pSAGf2diZXi9nE7crIxJWdZVK9xl5MuTU9lnU
         s2VRt9qbwP7ugjhIx43UIZqfhjZ/FvL3jDd7TaMegqpsFD63ZJ+XOyp3mEwKq/DPSKzr
         82pF7Dzrnod4Kw8DbgFwiJG6IBN0rbOc/8p/IIRvseQlz3bFacXsU08YyUj4RP3Vi+Yf
         GaW3IbLUJ6zbkaxRf8EE1DH986nqSKGeiJxRS+Kuy9bPth6A+Nc65bRk7CQRIgyjnzhz
         olqA/cY2qO5YBpwdBjeLnSUleXnP68A3E9kbKB7LREreqK6DdYVnsME0eW78FXu5Rb8p
         RI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754628729; x=1755233529;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LdxjV5xv09RapV/e42hfqilPtUapTSr343PB5WkL2lw=;
        b=H6/aNWTYEVQJmLCSxTUh9o4rFEmt/dh8+6xPIL9w56aU4DyJuqMH2ryD2bNm44GL3C
         19VmM7A4Y6r3ASB18gJjwhzQx8YNzAOKXpJOpWI3mp1VA2voZSz/cNtT4Dqm9NSYN8Gm
         lRK0yJzQWoUtDl7TSZfTeavqQt2Ik0KBgyuMXG9D9Mffvms3tUlY+1oARxWjzr7pr/L5
         PhO7WBB+jbrJ7BwOF+Qh/+4u+bThiLyEO/aiI6m4fJpZ0fxhhCTi/7r4JSASjhalStLy
         1EvjuFi8zW8pCqX00CjPDCRBBt9ln+f00xguq3oDKBRhGf07QJuvkjW10fDBgCQf/SqT
         MNrw==
X-Gm-Message-State: AOJu0Yx2tlTUNukRx13MRXh9lrxWW1KGu99F2nd3Kg76WZN4aZlLi06D
	kBD+X2UXyL8vsyEF1tZYqa8ruavoiYQHFXdb+sdnZEDTljEz+NFZrK5jv+A2
X-Gm-Gg: ASbGnctTz5Sd5tn98Ffx33XED9bNO3cxuRuLbTz7uQypTGw+hvfd5LPVpKJmYarnAoL
	ATq8sVzMpUP61DxFs0yUDN8/9fibiN0hk+6LwsefbZVfYYyMRf6UGRq8FsQjsDICEXX1ffJhFyf
	n9E/3u+HEKGN48Tui62dBzoRO5u4qwEUz4uEkN7nqnWiZEyW3YbrcPfaTt82v8Qnnfnv0tWmK8g
	5VHRKyy0MDWT+9rulFLA0Emqbn7q5hpgrnziX49vGe2mlnVKejWcXwEYAjKFUYLb0elM1gQ5R1l
	BsdlerLmEZpoLfmAdckU/tviakE2ZZAktfDRCu4d3AUnO/I2+p7dUgm6UzgQcEoLBCEAxivZpGV
	Abo/bpJG2Lg3PidDJPCLfrq8YU74ADxvYZA89nA==
X-Google-Smtp-Source: AGHT+IGC9hjp25z08ZI80EyeeBCkEKRt+mi0ktS7rkLVd1Oe2dZCwc8Zuh5HfjXfgQNxHUoYvIJ3KQ==
X-Received: by 2002:a05:620a:aa1b:b0:7e8:1ab9:7ef6 with SMTP id af79cd13be357-7e82c64c67amr228703985a.12.1754628728521;
        Thu, 07 Aug 2025 21:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.127.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7fa35144esm695250785a.48.2025.08.07.21.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 21:52:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754620968.git.tanggeliang@kylinos.cn>
References: <cover.1754620968.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/8] selftests/mptcp: consolidate TCP_INQ
 testing into sockopt
Message-ID: <8d34165c-4360-691e-f6d9-69cc76a6c412@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Aug 2025 04:52:07 +0000
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
Unstable: 3 failed test(s): packetdrill_mp_capable selftest_mptcp_connect =
selftest_mptcp_connect_checksum =F0=9F=94=B4
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16820854650

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/28969c6f3b95
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D989270


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
