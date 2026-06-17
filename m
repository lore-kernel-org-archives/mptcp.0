Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741548BD4B
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711863; cv=none; b=IXKcIN02ivjoiiamx1xVviBtd2ceopenmS5r/0vAr68NPcG7K0haZd8fFAj0fORmJyY9qgxDiDjYz+j4Xqp6yzPDDP5nWPqiLk+Z6+fpyG2f8YBHC8MmXh2PkPy61fUfKNNmlI9M5YcMCzyRqE5jZOQCi1ut7zqI0LDtLu7djOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711863; c=relaxed/simple;
	bh=jboX55uCXXUUjBqTdGB827sT6fc8cT8VWETW/e5t00E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=q8XnD47UleTffN4jEr3PXXkKMoliNPxyCLUJDBUIieUvjQFeucFQX807UzBjwipxivTXpQBoMejHBPNP14GC3M4jdZ7wvlNeTLD3wSY7g3m04RVViZCypB21fp9EXqM+V1n5F3wpMlgAZy/qjQbh3nnFk1/aQwM/9fXXtFnjK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5n/sl7k; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5n/sl7k"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-43d133d9a28so2346224fac.2
        for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781711851; x=1782316651; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DmKkgeOknA3HA/xTUQR8PWISVHCWzc+4j38BKtNT6Q=;
        b=W5n/sl7khwVGBfW4tr3vX1Qul9AxRoF3AFeEtrOdvyg+IXZK7vpdap1dDAYS1ybvi1
         7hZmY+xZSYvFa73QhmorWv5LY0IkIJF4S8v75QCmkw1T+CB29p0v6qG9+wf1jKVJfkG3
         QqnOoAmaQwRGA2NwxTsGgNGrxxigIZoOOGvnN9LNyS/8/9dyEHURIBFlC7z6mTLer0GF
         hXICA+eisYnDes/PlrO27KwQRzee2Vd8z0iR3zrWflOhUr/wrH4uwfkRgp5B9zvi3QVk
         XPH6sRIonD1im+ZWfkhmMnQxsWszLBuEqFFvilNdpuKa2TeOKKS2KqvVcVIk8D6c/pen
         Jjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711851; x=1782316651;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DmKkgeOknA3HA/xTUQR8PWISVHCWzc+4j38BKtNT6Q=;
        b=E0Np3C4e7jhlmkrpICDJEnv1fQ9Itc+YjLXneCKxzHgxhPZAJRyELLKnZg5S5zEQ2p
         6a0HXXePOl/nQh98M3fq7pikf+YgTWrazvQGWZnyTUh66GnUp8AyjiJiTHd23N0MF3Wx
         TpB9NT8IX+ddCuHlswyhdMNbGfIRhbeOfwdqWB4c7ae21OnbLo23bBxGAUHXFBCJmlGQ
         dGqfGj+JVuzoIkFv/dK/ojxhx1Fa7OYM1d4HOf/B6RD7Q4So8nkJFNiCeeQmQEJ83esB
         VRCKKOD9QvnEPgM9lJgsxojVhOO3QWB/gxAWuSoUteCmZW6eEnsy+MurMhF1Pe9y1v7W
         42Mg==
X-Gm-Message-State: AOJu0YwZIiNRVq5llwmx7PqHLDYN44ulraAmmqg6eg9orRQbb57WnlHo
	MgQh0ymv3R7Bz8wmz6lArKk3cHS4xaTuEK8lpDvCMxASiaHrvG51Os2Cs8EJ
X-Gm-Gg: AfdE7ckilFtRdtsz/Xd15el2kcQg/FCTW1xFZzFdItX7p4if7CuKFXNUKzRq3wwWMqP
	NR2lBjHe0Js43iArwUFJbei7z46eTdy9gzx+orXfFNec3qruFDXXPJPlA7MMZ5h6NhXrkaFIU0v
	mUE1BnoBMsTO5Je1vNbqcJVabW7SS3MGOkLAA9rBw3l3PxTdVuG7DXupRN25C8+qrooINCkEhcZ
	dtJrJGxg5mLJTGiDG+kJV2nfJQrsk6UtUnrKok+EgySvJc+1iDj4nb8o9aAhRIT9jKfChaY7GJ+
	lR5r5jvMTpUqesWsafxgFOAQcL1OKAyCYFN75ictder/kZGpENDZHoi/26TcgLAnOJxaMGtivQh
	Tz8GtFOgaJ1Pkvt/8Qi45CIjor7PFuclxBgAAiNVgyes4xJgKx07bMnSIpiEKA/9rvT93Qify5i
	Yl12Vs2mQzCfn2Ku9uLIl57gUtZ12p
X-Received: by 2002:a05:6870:828c:b0:43a:677d:241d with SMTP id 586e51a60fabf-4469049765amr3132749fac.31.1781711851003;
        Wed, 17 Jun 2026 08:57:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.155.229])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44308b0149bsm4374772fac.7.2026.06.17.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:57:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1781707101.git.yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/9] selftests: mptcp: skip the v6
 subtests when CONFIG_MPTCP_IPV6=n
Message-ID: <56765569-5bb0-b898-165e-fdf5daa34fb8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:57:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 11 failed =
test(s): packetdrill_add_addr packetdrill_dss packetdrill_fastclose =
packetdrill_fastopen packetdrill_mp_capable packetdrill_mp_join =
packetdrill_mp_prio packetdrill_mp_reset packetdrill_regressions =
packetdrill_sockopts packetdrill_syscalls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/276993=
27347

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ae964d2c6e8f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1112987


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
