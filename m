Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587906;
	b=t+828P4lcHxHjFL5hz4SNXoaAOrn7YL+8fcA0iaAjuzSFuCEbGVjxzjhLmCWfou6Gw90
	 jGrT2WSulz2Pnyx5oe07xNUwIG5nsPlj+PtxLQA/L3VXKZUkbvLFCXnXTgJqGoe/Ly6AL
	 Eo0WWqRGzAXuytZ+rE05G/KWtFlcCdmuXzvZd7y0lvBTWGcITJ49skFJ97FeOlF1jinyx
	 5Dq93pEPd0npwVu7JTgJWIrJCVtb39nSQmkuDIzA0PEjqOw7+En+VJ4ulZYsW0XRwBvCG
	 N307oAs33XLR7U3M3poBTjJLc+dG51/KQnR/VlUaDOq4weli3zc3jsxCFO8Af+SAnjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=1QkUuPNepMrOCXHsodBDdP3uz1poDbnw9ykN3F8JiH4=;
	b=QC6Ne/eXEjmNfK7dVkdFfwOm+p1FkVH1wODUrxkIbWyHSOTcHvOjp7f/bd1rd0xLD/1k
	 msiLb2R/ip/gHkvnC1AA8x9jqwDUN8/iEOUqUVRmBKs54ualAsDhrVeoro4FeN9+Hcg/e
	 gYrffR1bxcpxRLBS2AB1H6I4bB3dS6et9ktq///1mXnHSYg+C9KZxDbOkRGzY9hgGcsRo
	 ypmNLOQ+s4IW8/7ZGkACej5N/dvDcSMU2QQTqFjEuIfuVtSxskIBSZwV8E8D9t/9TgVVb
	 t4r8kzOFrUAuPQvUGfG/3NEekgZPRU51X5dzJ7PanXdJndfM8Gadsv1xIOtDf6vgXfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pAx5VPwe;
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864F606A31B
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 13:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D864F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pAx5VPwe
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-8256106635eso362829a34.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587905; x=1793192705; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1QkUuPNepMrOCXHsodBDdP3uz1poDbnw9ykN3F8JiH4=;
        b=pAx5VPwedcAcrKdnNE6+BPvNi7YO1+MA45j0bewfWXL4BMJiDHUzq5/6/lJ5xqa6o1
         tQ56+qFADjCOAvevjSkVrNYfLGGbkD0AeFeisAGopuhGXgTykbwu7nEqnNnRSOwNdwMM
         O2WKk6Aon+yEAvTYiHxnDpvYCoyoXPRo8jAGeIhhh8rXBzkgzpxzpUpX+jBCTAZOvhAP
         0IteCgDY3qOX713a+cgm09q+HHYHyjfK3j0OE2c5YRYlCAsTa0uu0Rt4qj/1PaMPiNXj
         mD0yJN6d4LVPDDYMJyK8RWGASWIlokZvFasqjGT6NQlruJm2Pc7CVCtXx7nm3N82esEg
         ANHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587905; x=1793192705;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1QkUuPNepMrOCXHsodBDdP3uz1poDbnw9ykN3F8JiH4=;
        b=mw62DXqsctc9ugPzSdLo99ww8IAtA+1RzffiXlaKvbkJgniAZl4LhGj5pPVIXFjS5F
         S7UVoniKXW3LO37Ob7FXycwenpJTNdVW7+5F2nktjt2vCqLyAjGOiEvYHj1opEy/2RL/
         jLMO0eitdvm7d8R7JCjD0oW+jdMyw1V1S9NeScmjhhFhPN0jkWPmiYleVYsi2UjcMx9H
         flLpEjKQLdQJ1R/CKbVTq+rDNKRAJd0SyVyfvj3rV12caB5ShAoh4A8hMgV3ZlFmfsdQ
         4D+RoXyYmM6jMmwtb7f9Dt+lyqHwMvrr+lf55TuBph8P//sse2KNM5T7ukEHvJUOuOT3
         Js0w==
X-Gm-Message-State: AFq9FYJsat9H4uiAIBe0a3lNo2tglsVZ+7FuE+slGp2uTKBVMLmw5xJC
	LUDg21L6C8xIobq17fy9qzXaRGNvIy7ygjK4ink06sLVGKiJcslo1Z2LdSIvm2A=
X-Gm-Gg: AYBFou0eLGBoD3aLbruTl+IVp2sDS2nnLVNKNxvBT7lJsBKTt/BqKQ8bCvdsl7jB+hT
	SfZl1+lTRjc5DG+8KS4VEYua5MCNJlPyBF8D5/mGyk3cbd9yVPhC5jtsU4vOCmVNTcCVgk7mqgM
	FNkP8zzb1MnzYZpRnVpBsqI186AeX3kPKdUkNU7xaPYaDc1PN1BFXf8oIQQ5tWh2YaxNsMx9h+u
	hNHjLo4gKZzQujIAw4eQ10N9n8AHv3uQxb32fVF0QJUjknpYPbGyUXYU3sUMB2AEukR16QW+oh9
	AN37JOYWLEwryd59Jw7EMoiFAoD1L2v0wpjIZC7R7dQbnHT++Iu0/3IFxaC4IyMtlDEHOhXBxxm
	Obb47PMWlO3TJhJN8ybsUbbyE79DZvu5yLslpx9g8/ptHGlzxz4zNmrB3vQCD4ELWeeu+t5uScF
	nvhPqAQbbr4sm59WtXP9EPOnsXnhD9iUQtaBD0uyiUw1Fp5AfvQv2xQ44Nu2hHbUD8NT4pV8kv9
	FqajkDFxPZKlJbHKIuk1pQ8o1xJ8VFF/LLdJgpJ7xIWbvQW4X8krzS1zyhpqpEO0umY
X-Received: by 2002:a05:6830:6ae8:b0:7e9:5022:3639 with SMTP id 46e09a7af769-84d07e0fe54mr1475028a34.15.1792587904885;
        Wed, 21 Oct 2026 06:05:04 -0700 (PDT)
Received: from github.com ([20.40.215.109])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cba7d4648sm2148834a34.1.2026.10.21.06.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:05:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261017-fix-mptcp-issue-640-v1-1-50a7bace7d43@proton.me>
References: <20261017-fix-mptcp-issue-640-v1-1-50a7bace7d43@proton.me>
Subject: Re: [PATCH mptcp-net] mptcp: push pending data after a sendmsg
 copy fault
Message-ID: <d4f4fc6f-61e0-b7e4-8c9d-9bca3c7806ea@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 13:05:01 +0000
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

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39579049675

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/21febefb636c
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1187936


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
