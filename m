Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539AC330647
	for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239881; cv=none; b=qU8hNW3Dkf4gE/UScpEwsOqORqMT5DJs0C/BlWA4xFy1dl3bfo2rKKmXqvoOeqBpxVPH5zgKcNX9FFLKTFsMx9AakR6nGqgfrADdvfl9auYIPrQem3tAH/RnGjRoo+FXLVC2MNslPYPj6ra16crEHJdeFH4TR7tO7s6VKsRuPfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239881; c=relaxed/simple;
	bh=j53G3NvCwxx1ZymR8pIM2thQo2QWVEBVE0LNOxMaY2Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=pL0PBxxxQJPJMMKwGc7ZFPRCBW/KUuJA712p58i6y9wq5FceBzMqfmwXmRDip55LOmg2uoONx1Z2ihwSsiPE0TX2KEf2fdIwlP8ceG4/ZrDJI2oeZvSgDiG+Yw6Nc9LAHIo+OHYo01lUeKmVcE8hgJ0yewAqWrU8Hmc3eGZrr/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e61Iiwo7; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e61Iiwo7"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-8137b129131so1261876a34.2
        for <mptcp@lists.linux.dev>; Thu, 24 Sep 2026 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790239876; x=1790844676; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ivVnlCXPKxtRs+Gnz6o7oLL37PQeMQbcjOaIZC1/GiQ=;
        b=e61Iiwo75nJuNeRW5avp02DkHS8QY6UHirPKS34ZeSFExmuE1ryjVNAEOm55br1To0
         4VKe6Xk5315+ipyKg5eXQvAMG5pZ6ztd1mjwRwhVmEBtG11ht11XmwCGsogbk4RQAzLZ
         is3DCihMmADgRe0HueL1NWMkagfIy/Tz8Qf256meno82I+LqEgZ2EFINa4ez47Ly+0Tr
         R0UDNjY8ZAC9gFbPKMACg3HW6erzJp4mQDICU3hbrHqUnRVZLA8AJK7LIlqKw4qdIQ2c
         3Uv4QA8oKbINPC1YZOHSICC4B82hZPlNSjZSCxZGapfQv/05ihbOWWqPLsHcNV1YL5zi
         Ntzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790239876; x=1790844676;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ivVnlCXPKxtRs+Gnz6o7oLL37PQeMQbcjOaIZC1/GiQ=;
        b=ExEMVEtW4QGXu+EvcVVh7VX/6VnvVmxYlFDe1my4jcmhIEqs+4tajNTWjMeGTwb2qj
         UFSgQK+vFPS+oHjbGKt98D/E+DjvIlywlDYJiXmL5dRhjS1hjReF3F28cq4HAB1LYVUD
         LwSUYAQUTuCZeSzZ737lf0FMeOgctIaPDoEUbtwxvb5OddEwybKSxzm13qxURmJ15Eec
         JTovCjC1pSeda5rWZROXdr92hPYbiVcGmvJtFjfCgGkZzEGZoA0hVRWONqzbeTbPnq6I
         CgP5u3fkzgBYAitXrf9f8f+M24trfl8J2R/iyQKquOpvYckWZb95Qm1a1VTFLFwJd1Ic
         WqdA==
X-Gm-Message-State: AFuF++lnicaCEKTY+3QMRKgDkSVJINkjoHhmALirUTYLE9DkxXLL39rq
	a/HTkSnL66pHzaapJZIAa73IwDKMsiAdldL7bs2l2qrj6Si3CPdvFIChXBRVrSA=
X-Gm-Gg: AYBFou2mNWw9eKD2RMXYcUTkr2FbhS3lJYHdYwLamtxVduYG9XK6LawQEVGlAs7wivu
	CtTJ/XVQ5V1cHxojaO2A14gtrjoqXH0o//e+J7Nr6NYh7b3BuFf0N42C8SJI/KiHgpWXZjrlYhi
	j8V/ABQdhNwroG9RbczSxlTnUx4D5m9i4UuFEvoffTipUoorPazpycA8tBuE3prdhIJH5BYBEOY
	j84ehKGh9YqIMSWQ9gpcIfuBoYW9D0SO9E0Dv0qmLk8K5lSKBiEK/bc8nfspDGkNGXiHaUdciCu
	8+7kF9+pjm334YkbfX3SA9DR2KzLN7h3CbxwodCqr0y2ilY/uglaWTA7cARLitOn9nA83bfrfWY
	G/hu287RE9PF50nWvza2PmykVgFeZf2WI/Ieo/b8MHUNlviUz6cIgD/MSwxbUkhHvpo6w0qpyEs
	RU2ZNLcGoaH2C8Ynq1TMprIbZG2hOyPaEFY4wDkbvjcsa0ITkHgDZxM4qgBQywEfJq+hKKM92wB
	DqggJMRiJNz
X-Received: by 2002:a05:6820:2216:b0:6b1:6c11:686a with SMTP id 006d021491bc7-6d43f98fd33mr1876556eaf.29.1790239876181;
        Thu, 24 Sep 2026 01:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.186.239.38])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816049b7b15sm5390875a34.24.2026.09.24.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:51:14 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Cai Xinchen <caixinchen1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260924080219.1036588-1-caixinchen1@huawei.com>
References: <20260924080219.1036588-1-caixinchen1@huawei.com>
Subject: Re: [PATCH RFC -next 0/5] net: charge socket memory budget to
 memcg upfront
Message-ID: <29efb2e9-5fa6-4889-dfa2-c61953c8328c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:51:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Cai,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35972467821

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/dba862a9fa=
2b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1172829


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
