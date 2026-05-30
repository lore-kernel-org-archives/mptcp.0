Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5D51A682C
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780132479; cv=none; b=n30l99rcAVJADx30uBWfqk1GXpHQi8+HmhlKNJ6PPcSRuUK3DMCxXaoprn8JdSM9zcCRHfTcSL30fROkzI5/3vKy3V3SvOYrTvA9hxYO/DmEtYSM+mkyfm1otYi8O+3ZYWVB7hM+NpgxD8MjD/1PhN2ht+04eHyKk/p/YPd2tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780132479; c=relaxed/simple;
	bh=iimVomD/wyF8UjNH3AV1hEUOnvk1Z2ZA2LqHdPZlOIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ZpvGB+OprMcot2tC+NY6/clLhm2ny71JWibX1wHGHxhrcTMWgbYzCD1DpHglst1FmLdtxTc+jPO043stZ6J4LKrAS/jjattW79os0XlNZHOfypK3h7ghiyg0zZ1cWyKYDrvXOm2L5P31Nht+rEgkB5cmZbM0oEMpLehtNKEppQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQruFCPI; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQruFCPI"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9153e2708aeso71751185a.0
        for <mptcp@lists.linux.dev>; Sat, 30 May 2026 02:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780132477; x=1780737277; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43HgAEXc7TJAow8oKEH0+3Q22hT3xakZtxxi0prlNvU=;
        b=nQruFCPI34cfaXAxOsSsO4rPgY0kaC3aQEfa7UTNxOHqLNlwk9mBMTGfQ4i1h3CEOL
         W1PM0jEuopqlgiQOCvTXrW5OiOYnJIrVF2Fwa5O3BRyqCnD+SmAMue8spNbnPjZWdJOw
         1DlyuVlBYi+6n0/gz6ePRCM6vSVzfdWkLxiqjNO8luTlI3Jex5Z0qo1GsjcCxXTmZJip
         Xsxu35Lehm36buei6pIUch6VCo3oe3TL1jqjheUDZ5XOJ/KYMD85t1SeP70N4kurwtIP
         /Zj0j9sD65/iGOLokrOzTnSeOiK8fIEsHHlzh45nqqNsUpH3TzHs/TS9KtXIqZ1TCmwI
         w49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780132477; x=1780737277;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43HgAEXc7TJAow8oKEH0+3Q22hT3xakZtxxi0prlNvU=;
        b=nfBA9tOrwobgUcr+5smeoYcwU6YIS8OQMlW/Qj6+z2YvVFkapKyXLi9seilOg4mvbh
         4x/w9OTutxGhFmWd2vX7vOvOItz1++8SY4WaTo35UHjM864Jt6QwRq9oyO08d7xPt8x+
         ZFyQxEgkHpjOWMPN3wfLoEYpcn8hvya7xFSNWdiV45qhtSXAbGZbpAwkvkiKKfHaUTsG
         PaH5QPZO57Xr8aJh2N3FD42s7UMu2++vxJEgaZV1he8+PKLpLnSUyy4z+hipRj/ZzL3g
         vwgXcp1KCaaA8cuekRz+frfUC9uh6QIi02Ivai2W+QEOxKZD1cwXYPAGoOWeg/N03VPm
         CaYA==
X-Gm-Message-State: AOJu0YztS01OzQELDjUVXFihPqJTAagRKkX+afCTl393HY7XCzAXv3Pd
	0xaUbboKp/deGcDhPklG7xIJb0TvKXVVKA83IMhiMjOUZijSklCfBivpqdAp
X-Gm-Gg: Acq92OG5PLJAYlRBz0q35nAYnPVfMaMZK/ciuzaqOL4YZOcArtFK1q7BV79AQoj9XOn
	Zl7huuGQJ6Yy1lILoUlx/zMlrWw9Ofs2XhrC1OwcP9V1BGS1OVZuIuUVozrmVakVm8Y65RTBqpw
	GrY6M3T4tg5IfXlICVdafBxlU25wxa7YGRL2hiBwa5SYzQ0RYQxqd5cAau4WEKwTvFE+ZEEPJFp
	ylWmsD0PFq3JK29Peg9SKdsDq7zdQrpPnEHDe70z23422rxh9YmVTSJ9Dup6LcGn7pQ27EW9/xO
	3C++ECRlCbwwn0+5bXC8n4ZmA3f06UV/qMlATZAhdGOaJz9Ob98FSpybD8J+02pK9/FzO60Uy6H
	BdIj/6gU+JLhVxA77uACuixL7Gky5nYqxpumTAwuVz7CTxVjRVP2/CpSMC09lRDCF5tVGurfSJH
	30Z3Bu72Aw3GJpeEwFkCvBq6P3p1lVBOxOsOxOxHui6mi63O0W
X-Received: by 2002:a05:620a:29d5:b0:915:29cd:306f with SMTP id af79cd13be357-9153dbca062mr478738585a.55.1780132477502;
        Sat, 30 May 2026 02:14:37 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.187.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532480d9fsm482496485a.14.2026.05.30.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 02:14:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780127277.git.tanggeliang@kylinos.cn>
References: <cover.1780127277.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/5] Fixes for TLS and ULP
Message-ID: <0f24ea12-1cd6-21cb-1b92-08efc4d0e9db@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 09:14:35 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Critical: 1 Call =
Trace(s) =E2=9D=8C
- KVM Validation: debug (only selftest_mptcp_join): =
Critical: 19 Call Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Critical: 18 Call Trace(s) =E2=9D=8C
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/26678939084

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fea5f9852187
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1103235


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
