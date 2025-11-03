Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BB238C0A
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203489; cv=none; b=oyuxZeGVkORATJZsJpumqFeVQl5mrqdG9gbOOo//LtrRspMpR79uzfyML+1Mb/FU2taZX/CtmJXhanMI5BCo/tg6cclzuwEaSJJMaFf51UbA+Ok+qLaQrfCtnwgZnOBLyWssShnaytPBWOT7fq5adw6b9KQAHhVs0U4CQzVvOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203489; c=relaxed/simple;
	bh=MPiece1TVMLsG9lfcfbjCbcxl9IyvNP0AfsR+ZjAwLQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bWHrPk7xMLIS59VK0zZUFZDEHG47XY2O8+0ToUtjzlt2dV/kjE0Xg9XbPY3kpxC6cFlKB6V8rqIHAXUel4XFGlaOALAUdFgzSkgPJxyHV9IoBy81Dq6zJS/qvJRkf6yJnAgF6iu/8MuJPsrVBZQtuMWi2SeHNyWBLWRIvAq+tpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOTOq1Lo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOTOq1Lo"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1486200b3a.3
        for <mptcp@lists.linux.dev>; Mon, 03 Nov 2025 12:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203487; x=1762808287; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6VT39MmEt5OUunyOX/ljuO6YvFBEOK9qc+/eA53Gjw=;
        b=ZOTOq1LoVC91lJJ+LjNMY7UVBg0384CruwLgklBs702ZldTA4h2MAl8l30fY6Yv0GJ
         Bd0qbt1GmlIUwmpAvN1LeW8FCMGZ/T7eg0VZAlcDb70Gsg4Pl0YReID/2Eh1JtJkNGCU
         bCR0gGMlu9rc9jS1nrZUrFoTYjBvXgtzOyS2KO60hGaw5QnlFnjwflX1Ftn0O6Q8gBdA
         lL/aZ7npUWJdFPVT4ajNTaNCeKYWCJL8DFfyao0nEypR1JJYzWqKwZ89jE4v38Id/xWr
         Misr070yyrWACX2loTgf85edaWQV7mERmWyVx8xmNaWCiNvjRBk+05/pYPujD2qxYRQm
         8Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203487; x=1762808287;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6VT39MmEt5OUunyOX/ljuO6YvFBEOK9qc+/eA53Gjw=;
        b=I50BTqR7PnV/EMgNDbTt8Ox0Uj4HZgYDFSsCSCbXz4eSEDbp1WnaMm9BATBl0ky/79
         FmUF9+MaGdGXT+Wv+FufyF94k/iBk2l7jmaPVPgkzt/v8H4MAtyoJo25ImcbCgdJoYCx
         N0rQEIPb1UftF3T132cybcfnkrgYLtQGxWT+82QL+qKcHsxqDOAatWFBg0IQeNsbQnMi
         /GYyBNntm5h7Bs1vqeQwuTUCUgghFuE8/fH0Ilg4ofgcBllquPqtta1IKAXlB5ga8n1e
         92ObBHjNoMZM+mj+zORnMuLMwU4kMMxJPIj9YR9tdkYGolPUxgWHh+5TrefNJwLynWjZ
         5FSw==
X-Gm-Message-State: AOJu0YzqVwQv5mKcRgyF60/nFsVBUcVyG0VJcnA5uZWkKDbI0niE8IIa
	hbHrH3Dd9OkVHx2cOoi3hkijp8AHH4Qv0Mlu4h14A3N+7Uoq84b2gTs=
X-Gm-Gg: ASbGncssPcLOVvvOofZM3AskFMum3KM8LkgYQhVXcw82wWR5ji/oZGcA868SNOVl2nD
	GdxvajaaC/DR7bCEy1IyF5KUJC6B8WhN0RLrNrtuavaMmYVUi3L+dKDMPBZBDu0MLuHsivo5ELU
	n1Bm32znp7pdtpNj24J3GTIdY1i7D4UmdaaE1llSKHXtVfBdQMAB4sLVBjzXFAcWf5xuVNirhkH
	4A0+Tj675Gjn+AYU9SAkFmV/bRpeehD3J/OxzUfNIYzLWjribhXXqiSrWZSzL6nTKVFugDxkroC
	TBWvYoILih7UzsMcXAd/CiYUaLaFKoxyyEYL4vZMsX4azhSEorXd/rVNyEcSgPYodLBrKJiIzIk
	Ue9obQAxC48B+jSakSYtopC9mtkBtDGPZeRuw00MmqK31fy8N8Qi9PUOmRILpe8MJCNCvW2gJQk
	GDq8Z7q50FSytI0iBfwaoTFvM=
X-Google-Smtp-Source: AGHT+IGQmnr6I0nKd7K6XYuYz/VHs05DC2y8QWNZ0iCu8D/I1diD+NKzoAGGjz7rFWfcU0PyppxA+w==
X-Received: by 2002:a17:902:da8b:b0:295:2cb6:f498 with SMTP id d9443c01a7336-2952cb6f55emr133998875ad.7.1762203487227;
        Mon, 03 Nov 2025 12:58:07 -0800 (PST)
Received: from [127.0.0.1] ([52.234.45.186])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f942a9d9sm55118a12.33.2025.11.03.12.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:58:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
Subject: Re: [PATCH mptcp-next 0/5] selftests: mptcp: get counters from
 nstat history
Message-ID: <08d6eed5-4177-3a1d-d1a7-4aabcca38b9d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Nov 2025 20:58:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_fastclose selftest_mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_regressions =F0=9F=94=B4
- KVM Validation: debug (only=
 selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19047087376

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9e66ab4bc31b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1019082


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
