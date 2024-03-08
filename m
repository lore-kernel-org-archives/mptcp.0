Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F852D634
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709884824; cv=none; b=FrhaSkh8v3RgAjYAujcurtA5AnOlG+KGpiIBLwHWpK0gJJxkJMewETOcb4BJJ3s2hDzWZ1PUD7zw6ZV9QpA3heIIj6uET2/iHn+2fKXl8LdaZt8EtPXBlluGVRz7vX/mIHnGbHdWgWZNEUYp12L92lNPwMGQpsxBoZG2l9/4PM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709884824; c=relaxed/simple;
	bh=L4DRmUiCTVPJDgUSUyV+KB+X5WHtiX7wazOMd7r3CN8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rUWlupHbIpvyQpBjo9jIPstiSiJkOEpy0F44jeEx0qcwRnWQZaNa4+7rVt7uHT8Z++U1mpZKrOoM9tRxa842UukQpbzqjlNgqNS8uMX2UOIk04tO4Aqf2X1j3uIjsrep9Fe2xRq35LyKf7qGVyNooeq+POEp6XyhiPM9ivR42ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB8zTvyy; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB8zTvyy"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7da6e831977so503968241.1
        for <mptcp@lists.linux.dev>; Fri, 08 Mar 2024 00:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709884822; x=1710489622; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPfItTryR75sIGnep/DWbd/qcEVFDb2uSZMhLyO7s+4=;
        b=iB8zTvyyxvJ6gZMMwgk/zzxdLF0ihvvRXGCwwa2AD7Cand+bx/AtnD+IurufPfVs6r
         MoWQARaezeiSTg8kkG17/umL/6pVFmhvXexuLiACCQJYI12YHFGbud8sg7ElWDhIN/ge
         zoDsU5RXh2JX8B7c09tg961ElqXVGm0RnfQ4E/gQ7mlhWlD3bt5oebhcGIGoIk83qZAZ
         8Ro1ChsFcfIu8x/S7gx5ecfRXzuniZS7zZkNXjg/l/FDW1k0yt1EMHCuJSg4d6M2EXR0
         flaIR/Gs0BXxsr7/uwnHOqDW8yyVGIx4n+02gpi5RuXrCq25FnuvZessgRX6Qj6ykCbW
         grDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709884822; x=1710489622;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPfItTryR75sIGnep/DWbd/qcEVFDb2uSZMhLyO7s+4=;
        b=vScaYhRwsqwoT157U7Kn+CpLjuuBWtzcsX1oZy1WuE8sytwKQBG1r4I9F/eyn2xzwK
         1h65QH9maGpNTc8IWERUHdVMVQja+O7+n/jC3fFav/LrYHkTuIfIl5C0Gc/lCq+pZuxd
         K8oPWQrc6KC4o31CAeX0GXX1ZXVP32dPivQWpFpxYgCY8UMpitLSrQ+07DvbEXxtHdnz
         vPlqhfoSoZTIstHDGcp6abrLuRXu+dcsA7+zjzhkA7Y9gpJx8oWu0QEM/JzWz9eUXGKT
         HArEfPqJBDwwmAcx60PdSE7ufk6pLkhfHhPhpsFkMkLZwFavODHQbM5gYeuNZTlqMhzu
         xvDQ==
X-Gm-Message-State: AOJu0Yz61xcjv7fby/oI+5hu+fFGfgerUnUNBFN5thmYn5Fz/Z7N9XjM
	/y/grFCB4MtUbbao5xNsFsEkWJG/fYkhifMf1MjF+SrBI/BApUL9UC/ZeOA=
X-Google-Smtp-Source: AGHT+IF6glbJKh+kc1sdE1jjuOnxUBxVdjpPgLTOeGhx6crfWN6W4B5CVY0WQDZYUEYFxYinU4lWcw==
X-Received: by 2002:a67:be04:0:b0:472:e8a6:ad0 with SMTP id x4-20020a67be04000000b00472e8a60ad0mr7891372vsq.18.1709884822033;
        Fri, 08 Mar 2024 00:00:22 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.100])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a10a500b00788435ab818sm2041060qkk.0.2024.03.08.00.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:00:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <1cbccb38bedfa1f606d0fd71ca992bc569f4cea5.1709876991.git.tanggeliang@kylinos.cn>
References:
 <1cbccb38bedfa1f606d0fd71ca992bc569f4cea5.1709876991.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: join: use += operator to append strings:
 Tests Results
Message-ID: <22189c08-d36d-0c64-7d2d-59fa4014bdca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Mar 2024 08:00:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5589567441469440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5589567441469440/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6715467348312064
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6715467348312064/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8829c80abe7d


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
