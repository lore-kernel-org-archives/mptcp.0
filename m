Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBC34D903
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769765211; cv=none; b=m05UejiZUvnqANrlLZw8iMOG2vbp1G2YrX2StKSMetwMPLn32p9agx7RonmRxUO+zj8Qt6FEQlmNEIX0rpET3YcdMK1r284MGey0rUtephKWBGVwHUBVCQD7HMfm3V/MhlnjWyNyLEk3KZDMwS+lutSCvbHOW7lv9RySIxZvOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769765211; c=relaxed/simple;
	bh=v3aVIPfvr/pG2B/4cDb0566pqSCypuIk82wWY0k5CRQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Iptcgjroi4SPQzJw1Vul5Zy1JKlQUuK1E7HaveLaNelsBMBh3sHqT0KmTi4UvXWHf55fpDv/5CJjKv2uTQUGZSSW60qvEKP8CNTtNdRysuV1P0cECAag9FMI1VBqIyOSGERdy/KiN6AnzlgMEK7CQ7Q1368Yzw+x+nL/X9zdmoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEGmaGVH; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEGmaGVH"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b70abe3417so4474357eec.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 01:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769765209; x=1770370009; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JR3AvV/fPygcnBU3lg87W8W5pl78PhwdgLc05mpqLDg=;
        b=aEGmaGVHHj3vbvX6nD/pp0W7c1uvykHNyhLE8OnHkUAhejXpLZ79wQBdaySTtoTTUb
         bYRMDrsRez8xKA0KhxMRu41Hh9VwR7gRYOzeh3dix+nrG/mmu+lShiLo4UrtGAvh7JhS
         6TJghOtT7v7OrVh7RyqVDKC4wDbuCaW34Mn+mfL7jE73MtBmXUrnYnrENDeS0YWlZYgH
         sVSOMKySKJ5/1jSzkeUle21406D6GLsPm5TDQ9j9qRPPZ/x35cv5uAWqSmRJCUOBEsTI
         H2U0GO/E8/g5m9+HtyLSxlF0ZoqrAGzm5QzRzBs6riaeiMkF1YUALcbWmHAh1ruRixJc
         Cp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769765209; x=1770370009;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JR3AvV/fPygcnBU3lg87W8W5pl78PhwdgLc05mpqLDg=;
        b=p7nDV9RamU50gVWXpXHGZYbJjD1wFg3ADs1thE3B5des8t8B8Ap2AquPVXNb5k+hnv
         9VT73hygwLvFo1dMTfamjDHI5Xfuwpb9tjdCw3aLKHIz+AHKd+S1LdGsnfbdZZWbw10I
         RGQkobt/6qZhuYbf5/cczxQv+O1+5YXE757XMPT5C4T6Pkdq6+jRWCqlGDq4uRN06R0F
         SSCD5InFYlMvoSCZPANakNtecHJWFymR6HvgjIjJwOcNxfxextTo8/VNYxgI4qb/QkRv
         NWsYfl7DQSwwqWMfpKwDjZwDevCsXKBdxI/r5UONnUa8PWcEcSKZM3jA2cZtbTx3C1N9
         sXYg==
X-Gm-Message-State: AOJu0YwjY8+SU5alSE5iwIPgD7/1ESoztUMbN4LXPIL0APZGgHdNfrtC
	C+p0Rs9JIl5/8gcl16aROsqgbhRyrlStFJeboq79C3WI4edyfxaFBDbH0ob1wB4=
X-Gm-Gg: AZuq6aLOdALLm86OkjGvvi9Ce/uDCWlctXZRaObaVx1Zb4A0hVURxrPoU2eJmcG2CYJ
	M5WD96o4ug6msrdnR9d/7mbwV2LreA2mXVrGiU0h4U24vPyxpQsT7erA/x/6aAzTYw6fI7hRuS4
	sAx3BMCp3f9pQXyJe1PQjiQxtGTipPgBY5BlDRS5O9+8B0RBLZPTUQPsdmIckCcB9j8Rj+Q72yo
	lessQxmAKN8FGAE/kAC99bmXLdWiwlq/8ahL8gltm2h+yb2ubZ/TuSi9q500/bMBFgggjbGzvR+
	3//wVLFZ8Be2arARdGdEBfYttSx/7KWwYtRi6yzm/g62/nLml2TkBw0oDCo8rmMXgi1AT4BzS9q
	LYIyRntNK0nuUYxvFqzDsyhwGfyJ5OgJZjqN9b3whnLTioLEQ73fGW6Y47SssS8rzRXnqJ9l8VZ
	FZzNJEQdTIAwr7Cn05TO7Yzr0=
X-Received: by 2002:a05:7300:7493:b0:2b7:1320:f280 with SMTP id 5a478bee46e88-2b7c8663e38mr1137196eec.15.1769765208586;
        Fri, 30 Jan 2026 01:26:48 -0800 (PST)
Received: from [127.0.0.1] ([13.83.160.133])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1add4c2sm10214758eec.27.2026.01.30.01.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 01:26:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
References: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: fix kdoc warnings
Message-ID: <d0992455-4144-b72e-2662-fd7cd83be1cb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 09:26:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Critical: Boot failures =E2=9D=8C
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21508880773

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/855afa251f5d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1048865


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
