Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D8135A44
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 22:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136222; cv=none; b=oNAHU6yz9AbC3/qPf8J9X42QywQYpSZYOvTpmU0Fmw17uxl22zl/Q6ECrwv4y68P9eazCYzatiZM6UARNNouMTqn4e3wfjQnN1XlPd+E02rmUm5M5ObXZJkilldTdFCkacPlnn7mrQI2rb6qCV1AbdmHAixHvYHXobqceXPwe2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136222; c=relaxed/simple;
	bh=UYuHyYUQhoNBFBwgktNws64qmnc8JfIVjhiVAVFzLyE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PCrwC47PFEEHdAvhmwq5Hu6LL73qoqYoFzfYI6nLP/Qe4BdMGWAxx4CeiX++tu11+/zAdkGjeDALPhn8W2PHkOvHXhd+DgmT6AZR7l1gVBcMLaXxDm1xNebhFW8q+TSBLgbre/9ISMl6sH9F1VHHLUOAA1rgWVm/PbO85wu3y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqmlw/6A; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqmlw/6A"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-781753f52afso412135785a.2
        for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 14:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706136220; x=1706741020; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS7SAD5hMqdwqOobeLkg202z2cPMqrnx6nQW8/E+s94=;
        b=Iqmlw/6AT6lzKL+xdVSax3WBiigbzK3e5JO3BeKHhjYuaVPMFVGflTPN1iw99MPn/Z
         vR3Lxa85Pf7euuu3eFpCv9WBWQ/vEhKkmkOUPWXN4tgcPUAJNyDelVW6CHs7/csx/V9L
         x84hFSqqr+15DNZGmsglCmUzBr4qbeSmxBdVijt/8r6x/JxEoWkQ5LrUTqGQ3vliNJPC
         4tLF4U2fxnerT4ICg1JvwT/2iQaJXC+8SKcfm+2m6INbvh7qnSvOsUh604CBjx+gpSp8
         tUpjUbn3q53+g4NxWKaiCjtvbckQOLjMdrnuM9Z3BV9sPC6Zn4Pe5w7p9lzH4huXIzeX
         8mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136220; x=1706741020;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zS7SAD5hMqdwqOobeLkg202z2cPMqrnx6nQW8/E+s94=;
        b=TGe3GteZIZxGz5RxO41anBg+J5wLAyrWqSlLVZiVSg0/BZ50WEyQT1EE1Q3H/bl+Hi
         p7iLomqYi8pq0bO48sy4kQHMYIgGxlRaql8wtup8hRRG9SEYLHlF+GDIZapPf0puW/T5
         uo8b0oIXT0JkkDMTvUSqVZcOzV/lPMw30lQl1cPUyzIH3aLqjiJgGbu5/+q4StyGVwdW
         PITCQ2ZYATgdyTRc7ZT1pdwQqXCX3VWVHUjZDhgJWm2n9SX4dkmXzZ3jR2sUSD3zLZk2
         SuE9fnSDSPngcNVv9r4ctV7qUh8/kuTWHP8ANZ4LyIADrFPkg/14KCZdXi8rBgEr4U/M
         YSmg==
X-Gm-Message-State: AOJu0Yx8Zul+gXRmtm4zXhDlzRs0I2Fc/SP/iapKm0r4sc5/M46aar95
	qaYdM08I/R1+9EIkInT7jIFzfX29HqddavvRB5GokpEkxb8/xxQ=
X-Google-Smtp-Source: AGHT+IE8lbgn4URKbtdPVnJDi/0Y9TBPRskapmj6LrF7BcARve/ntbKXJzLWqz0wZPq8JENppBwiaw==
X-Received: by 2002:a05:6214:2aad:b0:681:1481:e2c4 with SMTP id js13-20020a0562142aad00b006811481e2c4mr7405qvb.93.1706136219991;
        Wed, 24 Jan 2024 14:43:39 -0800 (PST)
Received: from [127.0.0.1] ([20.102.46.182])
        by smtp.gmail.com with ESMTPSA id ly4-20020a0562145c0400b006869d54c818sm2485374qvb.109.2024.01.24.14.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:43:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
References:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Subject: Re: mptcp: really cope with fastopen race.: Tests Results
Message-ID: <d4bc71fb-9b90-31f8-52a6-82bf893619b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jan 2024 22:43:39 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_regressions selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7646=
707610

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f24f750c6f62


If there are some issues, you can reproduce them using the same environment=
 as
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
