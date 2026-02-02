Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC21F94F
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770010577; cv=none; b=mnw/5kqdfRsCsm2EuUX9cdaiWnYBeSy6eX/nNVEEfS+Z6MyWpB2fghsevhOz3nUVJqlGy8KAI16Ir1439ek6nLTUVMu/4ure0DKqbvwCiW88KHLCH8LosKjAyqgBQMh5ff4swEP8GPlCrIj3GahGcoFkFi2YsCjLXP1nEKnqiZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770010577; c=relaxed/simple;
	bh=UOxkHOv8lyUP0uuDXsvr9MUWShS1SA1vdkqSDCATNq4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FdhQ2BZ4E3LyMErmflpFezDTeQwCYoeiPBQC17GdfZOzw+IEcG6iN7HyecSoG4IZ6dewuagthZkfMwptZ67Z5oMf2V4Fq3GCdrom+4ipLYmUD/20fMumZboJabkVLIvX6RIKyeLaQejaCerKVbDRDrkUzaP0v9vdfPpd+H11Eec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJXP6ggo; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJXP6ggo"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c70ab3b5fcso571021585a.2
        for <mptcp@lists.linux.dev>; Sun, 01 Feb 2026 21:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770010575; x=1770615375; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igwo7JdUsOHGIT5nYa4gsC6/YXLjbZztEc4GfLDktxw=;
        b=UJXP6ggo0Dh/MsdKlTRpf6CNm0JaDFMMH3EjGb1gbwVHchD/IFlPlx0M/U/klFX1Uz
         q//ApYL2gyTgjh+QAMI0Nox43rH3ldD4TbOEEI1j/Az/JdQ6BgB3+wVc+OtMt5826H1Q
         4nQqxAaAkzhVsmKQykmfk3KvxejacPEXHYhf1GpxOi5ZT7TO1na9Tsx/lSqadjMRyF0p
         F5WuoSfh0ZfcJTpa+/ymbHOKm/OdbHPQsJbq5l/T70MWRFin7pq7j/EK/Wb8lha+GZVx
         xPR0TH5c7peXlygeL20Qq7SyCvaDzix68+SVpl4ZRQd38xrpgNiJR16k96p7UhGdeWon
         GOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770010575; x=1770615375;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igwo7JdUsOHGIT5nYa4gsC6/YXLjbZztEc4GfLDktxw=;
        b=L3V73RwLlBPzLm4UuNm9HouWWh3Ar66ubLUJ6nUmxFG9G6F7Q5SpRaX8xULneAgO+4
         Kr08jSmM4NNwF66hfu7EIvOb3TMnx3HMxhe7d3nBcnyTGAQTUWfIsiOEEyeq0JOORTER
         8ymLwAk29Nh4ZXA7p1KJFJdNXirx+jizBxfEtJJAeORw4b6nurIaXPcoeNeUTOgV4wmP
         YpnKZfpMaIsENr8QyVFTbPYJVzJhbQD1UbnT/LW/I7MkVbi4X56Rf11+5bEjLxCcGSVH
         5GlgclyN0qRqv36klh4fkjkmhr1EN+RC7yjXeZrkyOaxJ8ezd8pbascU1hnukJQPQfje
         BJrQ==
X-Gm-Message-State: AOJu0YzYLCqnuBe4BJMIIQ8iWaTE8W5QABaKYBMtQI0j4tViSQLFpP8M
	TMgvmaOkOQd5t5UR/3BGxPORBT31P1mwqif4zClhdLP/MBY0zR+CPuYDfHyartc=
X-Gm-Gg: AZuq6aKoujtDFand/ukLawNknTjyF4F+40QuNCrQzvlPkF8oYsqF4VmGbgxN9QUjxXB
	gwPRp0e/yVw0quwAYtsqipCGL/nYyKwwbiLzunna0D4NJguPmkHdz8fLqkaQfcmuUnf9esF8eNg
	N4rhWlatwL/5MlTGQkJINaYtSNGhTACjzQv3GsE/pBipL7C4Ng6yf2W6x4F2xIcaH3c5DR/tjcV
	wSxnCBRUf1PMwcYqW7ip3KQw4DvuYxzdOcHLc2UywhxigMNDY6fUPgLsRIpfNHitejY4UvbVdEz
	+FnhmqUKqy7G/KfM5XF/AJS4/1r7Rnu9nhXoKrO3+7PxSSJOB0wwkByQ8dqwD9xAUcZKLT50LgO
	BFO2jpbmr6sRJfhnaVNPE0ldyzkHSsrwnCjyNeX6cQSR+VdBR9K6/jeB5ysVhbVGCOjxcw7BQCV
	QHweypKhIfr/82tqz1HAGlpMqPRQ==
X-Received: by 2002:a05:620a:45a6:b0:8c6:af59:5e2c with SMTP id af79cd13be357-8c9eb22e922mr1384416085a.18.1770010574539;
        Sun, 01 Feb 2026 21:36:14 -0800 (PST)
Received: from [127.0.0.1] ([172.183.135.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7b380sm1191426285a.10.2026.02.01.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 21:36:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260202040916.626066-1-gang.yan@linux.dev>
References: <20260202040916.626066-1-gang.yan@linux.dev>
Subject: Re: [RFC mptcp-next] mptcp: support MSG_EOR in mptcp_sendmsg
Message-ID: <e6e59664-df4a-271f-21c2-d0ace29f1703@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Feb 2026 05:36:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_dss packetdrill_mp_capable selftest_mptcp_connect_chec=
ksum =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/21577318531

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/37cb6cc02ae8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1049557


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
