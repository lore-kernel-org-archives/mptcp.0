Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AC8F6C
	for <mptcp@lists.linux.dev>; Wed, 11 Sep 2024 04:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029972; cv=none; b=fL9J7uLT5BfCOwtndDtF97n+iG0wdcsQzFQ8eLag15iswnKtzbBwyeKDJZ1jdCMcov9uMYj4zyI8JFO5w5Cc+kQpNy1K1cT5etKlNVkz0LGqLwww18yqEVhVL1fKl8idwHqlziYNnNgaHVgtqzhypgqP59GSuhRxJtOo8pMdvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029972; c=relaxed/simple;
	bh=THHzlkNd8nPJkU/GZs04NO4jf3Kk5xH1RcvV0EM2L1E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mNEFCFpst8nqqqiH6tRhPHm9LQMDXJ3lyWwFarLRLIbClZpQVg1i8mJEXlLOmY/X3KgdGrRdNz4Bn8qP53DPwktEM2j1jdg5JrWT06OTqw2pDke6QxLFjsGG26xKc7Xl4xca0ukE+nP/e2ybefkyM+Y7AFuYsifKnkzqTL6E6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrGoPApZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrGoPApZ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c34dd6c1b4so39144346d6.1
        for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 21:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726029969; x=1726634769; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOFO8V24yjwXTm6b1CYFFAY6oz5fQ2d4HWx14pqi4js=;
        b=nrGoPApZ0cgh4owzGxkAkZpiWUuFPD8+jB/EM8zvk0/pa6zM2tmzGsU1erkkI5FrJy
         wJJc7nMR+SBlQNnpyckNvecMMZLp5/IGy2uPYoaoRPCJdo8Kb2JhIZKztJZUYiF411Ei
         1lEL6H4KUEKSXjpIdj60OzR22JXdlhrmiubKMcHeiB/Lb7rFo0dOu/QI0Qq7wTOmVo6N
         7cvOk2DGSnP/L9/a0XyXHlN9rT8gReUKIA7JtoUTr0ST0Rd/hHFhNbGWvQ+2YsQq7UyH
         p4Wwuc6iUueoMuSXNMP+TZlheWsaJG38bjk4ZD4FOAMaVZwA2J/YAaH2ouhY9w+K4/ko
         Oweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029969; x=1726634769;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gOFO8V24yjwXTm6b1CYFFAY6oz5fQ2d4HWx14pqi4js=;
        b=DWfPcuUmx8CB60Uhf2xLdMaWRmZmfLDgCxi4Y5X6H1Hs5mJ2qYv2yGFFnvLJ/3RQp3
         RwRMN9ky0rpHSNX21w25ZRBiyVywje5h1P9JF0IyV3Y3GcgXZEvb1H7zpGjvrbrxpJNF
         yTasZkX0sLo8fKzr3hYechHM2JFB8+9T3Y0BC/vaRvlBAHKJTguatVbycM7Iab8soaIG
         tmEPTdJ6It7Z52jx/wlJV0Lj9BC5qzGdBbRcNCDvMkhWguCuT5XUc1CePwkLE/MBh0as
         XvBsDreJaycRL+5s/1r5/GYjjfQwdEt0tVW7uneR9W8idVd7SGQefW+XIDn7942R41pT
         KpiQ==
X-Gm-Message-State: AOJu0Yzw9Vo7/lgVui/KOc28rswNF0Prv2997gfd2PmZR+6jJVa2MVO5
	kT36pUlOSfrdISS6Rt64CUnEOHwyObniD9PwQFPl0geNS16dRtAAuw3H
X-Google-Smtp-Source: AGHT+IE8MMg5VG+EYh8Gk+mooS1+dsj3dROm//NqcmprBeIu+YYLhO3xAGrmJrsGw0r5gtaf6mTv+A==
X-Received: by 2002:a05:6214:418b:b0:6c5:119f:de71 with SMTP id 6a1803df08f44-6c532ab64bemr174109536d6.4.1726029968803;
        Tue, 10 Sep 2024 21:46:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.122.147])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53433aca2sm37026106d6.32.2024.09.10.21.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:46:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a92cdca650b2e3e6ea40e783331d1fe83ac9aae6.1726026758.git.tanggeliang@kylinos.cn>
References:
 <a92cdca650b2e3e6ea40e783331d1fe83ac9aae6.1726026758.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3=5D_Squash_t?=
 =?UTF-8?Q?o_=22selftests/bpf=3A_Add_bpf_scheduler_?=
 =?UTF-8?Q?test=22_-_drop_has=5Fbytes=5Fsent?=
Message-ID: <e1ab0c79-0926-5f65-6dbc-293fa7b19c5f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Sep 2024 04:46:07 +0000
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
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10804815101

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0da13d6a89d3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889138


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
