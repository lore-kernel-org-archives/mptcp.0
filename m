Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EEA30EF9B
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179279; cv=none; b=ryFBvRu/vaCx9u+euhGbweRkoQHvll7QrIMLzxKw95WSPDdaZSAK1Ht+QFQ4JnrQrO2lF28ceyB9P3dj49qvB+kU60rfkaq0tofmI/3T1Gh/CgR0JrlaqKEnaTAoEwba9vIEdd2ey3Gg1cEJVd9z8uPVRYQSFjzDPwdGe5daNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179279; c=relaxed/simple;
	bh=Sh1Dw+OHYeByjcTePTCZ1ElrFmSCQx9I0/pj/sH6WIE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=e41cS5ZfAzkS8mzIhukT6JC1LCLLfOdoTmFz2TeGyEvZXz8tubMKnMaswKiLC7BWAz91Af4E+6ftFtn1NtWX1GiGtFhxsZ10KyZX47iKjYzaqKQl5spGe2msxN9Ua8duzLr45hGy3m1pnABpckJiFD4tgnd4aW7WOS73DEccgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxAn+0bj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxAn+0bj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34372216275so7218803a91.2
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 09:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764179274; x=1764784074; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVhxNndWUOWRo2/Fz/axuKBwJiAMoorM/VtVBDGSHto=;
        b=QxAn+0bjW0GW5N4RiHfrZxyTSla71ympTYCUrnjtn9cV5kQdcPQRprIVB+XHB1vSmJ
         G1ThUvp4cyR43SdMzSOWvj2U8uQmRLESYzzC+8orl64YJqfmtayPg332kHxTbPpW9oVN
         JoRAeugIoZtyJG1jI9sQhE6Z+3EVuobeWUqog9FnZAcBNuXhRKcreVuervycc+CL9ezJ
         s/ewvfZ1q4MfX2afuPqD2CjiAFn0ecf2/qDYdO7EyM1U1bwNtR4MM86xiDT7werm8ahy
         Rien+GhtCOthX6kS+URftHd0YdGk0GIGXRyd+f5cy2F+GdCLHPClS2pWSFIoL6f3yM8U
         v80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764179274; x=1764784074;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVhxNndWUOWRo2/Fz/axuKBwJiAMoorM/VtVBDGSHto=;
        b=LXgd48/YzuOE7jCaYtID2vFQzLHnGVz5Ynkzy+V+qMVerncwjrvlIJk7gZ1V/b8zgN
         RQvjgkb/G3pDZSrR7fkXIdYhaKNESl+uJtDp2VdbEmAPscwUv1zTJQyxzcqnfQ34iqYE
         us5yMjwGMOE/eZUOp0Scj7++Ru9v2fEy1Km64JI3BzYl9GJnr1rE6g1AM18bqvKHCgUT
         6DDIyaTZaE3K0tKX7JoJt+RGNnPQZCTD5ubD2pS13HTjoyGzlk+t4CFWmEVpv9/nCEAi
         tZY/psTZ2LW5EEJCkgag8KU9vfgZaw8L2ssaPUY4Z0UjKJRTgXFMvGzAZRHWXVMxw0r/
         SbiA==
X-Gm-Message-State: AOJu0Yx6VMt0G+hS/hgD/8BXYhQ3mEXnbUhSV7lzXkFnqnicxbm5XUo/
	I/QHIgwZthuJbueo31uoyEepehSwwqNSBqoabQSoiHs9/idFyHV8Kso=
X-Gm-Gg: ASbGncv9spPAaLT7hPPLoetiaUv0Uqccer2EzAtSlk8w7ZdxXEHv5/BkqZEA1eZua6P
	jnt3QuZJc8o+dKh+zwsxgeD/My3Hbt4o6QHYYNm0haJNRFE3ub7M/oPtoNAPZfPRv/1OysMtIlN
	H9NQehXHBKIT16rxF0f04mRuk52dEEa8MzF5fjioie51pthpi1oFYta+KapDSishXSsEwOGMthx
	pDf2wb2G4b9U4YUsIhLVFbVsTcwvzLuQJabGPnV4Z3Wtxa7OSkwHHi7NKPg7bBJinEQYKkd0jUz
	U3vpN0BoOvD5yaeCLm+RDf0dysTi0wyis3ONbOVWJSOpFXVRybnPQgHcz4TY0cwLNhdZrXeeU/c
	q1F9AC6GXIzUJ7F1PoS70zczjm0rG6YXnDijMHUgWTUnBVllHec0HKEjHgFaVOpgg5p/2wr/DQP
	lpGFJZKBr8Tn1tXgtEQEw6lIat
X-Google-Smtp-Source: AGHT+IFWpVK2JMikYk//LLQract1DO2yALdCZZtn4lnTWQzdsnmLX5Pw5NYuOu6VrtMDSxWAL4ubPg==
X-Received: by 2002:a17:90b:510a:b0:340:f05a:3ec3 with SMTP id 98e67ed59e1d1-34733f5b79bmr19533386a91.33.1764179274041;
        Wed, 26 Nov 2025 09:47:54 -0800 (PST)
Received: from [127.0.0.1] ([57.151.138.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a5c44e5sm3222914a91.13.2025.11.26.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 09:47:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
References: <20251126163046.58615-1-ankitkhushwaha.linux@gmail.com>
Subject: Re: [PATCH] selftests: mptcp: initialize raw_addr to Null
Message-ID: <d1fd9deb-1876-4597-c695-e23db8aa28a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Nov 2025 17:47:52 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Ankit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/197115=
00234

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9a580f7b5893
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1027947


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
