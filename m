Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952C3EFFB3
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896337; cv=none; b=A6PfeqoAl7xj7aVnjaKGQN4ZnSH47UJpC8YVl8lg08hGH86z5qBaab8uzR5zCAuyvC761fTlCpk0rHxCI1KkPpHtaF262iACZOWGH/fxQc5Lcw52VcsUPgM6hTCwMRd4UH7ux8/bJ0ZPOH32Rt/TORVq+EBxQakA0G98iQb4A7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896337; c=relaxed/simple;
	bh=aLOHPTNozmTbmkSFdIKeWjCz/rDqLhW/Wun+Grbsj9o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=vBrqIBW+zAWP2+bTi2b+e39Sae1pSR/HnVEmKQvKY0nwqByeeJX4UVT68p51mmvCzrGG+eJ/wKg/AHEDwNUEuKpqLrrT+HdKKpCZWjeLtjhW9niYgM0zqJ5KTuLziYCT5+3mSibB2gZtXDhNbF3yO30LebXW/LOrwxpHAhJhyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsTvRgl6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsTvRgl6"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0c68aa31so2910441cf.3
        for <mptcp@lists.linux.dev>; Wed, 01 Jul 2026 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782896335; x=1783501135; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5nZlyeAh86UdcHlJ7vYw3WgaqVc8b/AK09+s51nbgY=;
        b=rsTvRgl6VkYa353K4zICKlHDkrcrjP61o83LKsO8vfMO+EOcSiN1mg9oJ9kzBlRCfa
         UvLbfV+jAp/5A7hUwuydNzXmiqke/fGDV0X46wN4yhDu/zlN7IoTqNVGD4qXkni0OCaZ
         DnAJddVy8lBNfAYghUXoXX7cU/tsSZEhK/AvNumaoTGrv26fwq+ybFNpsKpsw0+ECuz3
         qQzcs7Rr/U1VI2UWABVWzrnHNtwFZbC1wLfaWUE2NqEJ1D57P3UVtbBBVSe/IIfBPyjd
         4xBjCa1LBQKKx9WjNGeWg0HM3ddPItsc+grMXv6ZDfgtJ4HqhN2KlYUA/PI2glpqD2Bd
         xxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782896335; x=1783501135;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5nZlyeAh86UdcHlJ7vYw3WgaqVc8b/AK09+s51nbgY=;
        b=rLfvuG6t/WlbK8jwEQDksYkUzYon2vHnqgjHoUoCnSotmiY81qYyIrtGVw5yQEQIWb
         S9+OXSHJXZ06W+Nf0olmH30C1r9tAkas0MphWVkFtRBmvY28Bx94X822Jzd5sahoaPGx
         yFWUNCHI0FYucj+D2mKP3ToQQcIWdWuilR+2grxtmEAOR+4/Q8pa9vRkpyFEKIvtMvXH
         onbRJyDayqEWVSIZWIGci9zdsjOWnb7gbWKPOe068SoB4Kkq5V7OH+oPUKCUVFSLdIGl
         s+ruCTz++NB9uPj1zvieTpC0XoOZULG4/rep6CbXp3CbENturW1WWB1jN2o9gfwUFmrV
         flJQ==
X-Gm-Message-State: AOJu0YwW2OabX5i94QOiQ0MIUpNx8/rxoi4ivgCUD2fcEpOcANV5O2CY
	zP3K6JylJ3My+D0MJPotuLheRPVxCJiPpffy3cwyBou+sA6KuI8Jd6XQcKVq
X-Gm-Gg: AfdE7clnEpVrLiXe0ArKBxVI5U3/ad24XeaFRfjj7kMMfmUbbJQkp463aq9ozmNiGtH
	Ml8BWmRwEdfkYUnkCMID+eX+cPxIo8YvfaJbqZwnH8oju5SGZxADklv8zyWocSJE+NMCtItyMzF
	5nlBqiicteDBDLXSAXpYZ7Wt5gPZZdGOpdi9VBk1tUnK3oxeMJzGy4kmD3gGpkf6LvOtpnw+VmT
	MrttBO+sDin8CGsFRcIhqmiktd5ooo6QpOqSpzEQxYzNRKT/cjETsqztf8Psa5v2TX9SoK6UWpP
	LUX4sly1THgCOZYOcXWeLxTBTofgTprfN8cKarY41d55TNshDKQYjLVB7u1JHLCrpLBuVi2a8dL
	uu77n692m0BYy95YwIy5TqCjtgeD5270epSZAt8LKCA2GNC73NP96OWtdh2YL7mH/xvBw/Hc2hS
	jChjEAwjK72zb/ooQb6inXegregg==
X-Received: by 2002:a05:622a:4d05:b0:51c:1b46:47cd with SMTP id d75a77b69052e-51c26a3bf36mr9904741cf.12.1782896335415;
        Wed, 01 Jul 2026 01:58:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.62.207.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3611d7ea8sm16410016d6.31.2026.07.01.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:58:55 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260701073713.197616-1-gang.yan@linux.dev>
References: <20260701073713.197616-1-gang.yan@linux.dev>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2=5D_Squash-t?=
 =?UTF-8?Q?o_=22mptcp=3A_pm=3A_init_and_release_mpt?=
 =?UTF-8?Q?cp=5Fpm=5Fops=22?=
Message-ID: <592d1bdf-656a-8be3-263d-b42bf95906f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:58:54 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_fastopen =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/285033=
96809

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dac4cb248a7d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1119502


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
