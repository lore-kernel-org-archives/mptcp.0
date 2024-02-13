Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9F12E40
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800645; cv=none; b=ClZXAVvHDWkmrq6pmbgec9fcwUuXZK/CEl6XqWHQoTTd48vcveJjk+muMt9Y2Ro57nvg8iLp0EvmQwMgL8rsMplX0ND5g27dy8Z3xByZsyFx2GjA2PkDidjI6S7zCkDvM5PxvxfUFiZuLeExLzlfOkNjE7+EqXivZng279rlvQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800645; c=relaxed/simple;
	bh=frChhGPC8sJWutjri680eDfpB+n57YM9pwRALlR28Ks=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mg3owAt4riEOjxdW961fixV3IMKwRwSsAGnuirOp1PiG0riGhXU0qYcxz4NztX8EmMcVbrY/k+95876sZinV/M+s/bOj4/jtJ2+JxXQhRfCrS/6K6reaTq7R3n2vAswGLPqO8KF18nfMUoaVk7j0FOGEGTO7Y3eVqf8r/l6PzJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCzRE4R3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCzRE4R3"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-785bdb57dfaso261351385a.1
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 21:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707800643; x=1708405443; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji5ByjYvEssdNIZKsuJKroy4PMv6KT8UZNhdvkvfJ1Y=;
        b=eCzRE4R3i9bxjTzRTgCvfgeABJHbtLGrtHZ0XeiP1xqijdzx5kQ8RMwsx+5/Wlb/Sr
         lieqpeDiUhTPs0dYtmQCGvfp3VFQQax5/w4JcPAXZ7ku4sZ/WFtj0tz2JNyNbq2ahtMa
         ztz+uFuc+JxX9aWmjMVLz4Qaqt0J7FydCCvbgU7RY9tAgAJ2LUxnbYMSX2efuQWjFr9s
         vrdZPEsORhCTwxjCo5ffgKC/3OjWRaK0yTXmm70mzurPR3roJioygZXH90zyOHByrCHI
         VAv4ZHAPBy1Mb+fefVb0M5shKJfiCl2LkjHdS4zQ/uCrJL3c0btekOxOxsIUSz7YIV/E
         7Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707800643; x=1708405443;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ji5ByjYvEssdNIZKsuJKroy4PMv6KT8UZNhdvkvfJ1Y=;
        b=QBqQ34EFSJJj/UC3/iadjAKLRUMVaI2b2USvq5PmZzDrJ2LdggVHT8ziHVL7ASkvEU
         a0m9vKXkUNnk7Dtssd4sh0+B9IBGCqrDbEtUVxt19442pWAzgf5FosdjECTOepjOqq33
         iWEv1Nw+2gsKfesCinNteYUunMFVPEeK7p5JHfOn+YywUflIJOQFDfIrkuRtua4MmWT0
         dT0uM1ZztQDm2e+vgdijNPxdDOOXrCNOKvq9dghyRevfDKn/lwFd8nnKK6mQUiyk7l1+
         l1LKUCjaDi5rwduqy+qDw0PWN1xZDaXi5LzgIu3OE+9rIIttncJTpEnRkkAPswBPp4dT
         Dyaw==
X-Gm-Message-State: AOJu0YzNkKoKiL0RlI5hrgpV3lAN40OuznHVdoSlWewTd4fxmv5zVX56
	qZ9b2yJ2394QoR8QHYjdykVNr7S9UF2qacmCdbL+xWDKPfDotbCNMco7js8=
X-Google-Smtp-Source: AGHT+IGsQC14XQAZnsbso2lolx63NWPYwaz7Mo4XxVokh950mQb34CVv2bJd9aP9MonBVKLqARdqSA==
X-Received: by 2002:a05:620a:1467:b0:787:1662:8c26 with SMTP id j7-20020a05620a146700b0078716628c26mr2404648qkl.37.1707800643063;
        Mon, 12 Feb 2024 21:04:03 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.175])
        by smtp.gmail.com with ESMTPSA id l13-20020ac8078d000000b0042c613a5cf3sm816605qth.33.2024.02.12.21.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 21:04:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <874a6cca73e30babfaa5f6036a929314bf1a689c.1707797566.git.tanggeliang@kylinos.cn>
References:
 <874a6cca73e30babfaa5f6036a929314bf1a689c.1707797566.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: diag: change timeout_poll to 30: Tests
 Results
Message-ID: <cdad9ee9-b802-8d45-4383-91fe65189310@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 05:04:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7881714529

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c502a99a8f4a


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
