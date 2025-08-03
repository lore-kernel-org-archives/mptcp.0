Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DC225A659
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754212860; cv=none; b=Nxoo4gaKO9Z+fNkDGO2NOlJgjMT7s8u7iVxPejvyWkghqaIMtNUg1hV+RC1Lzlg3GbXtRTRL3Y5wIkRXhcJSwwAFcyc7N6eloyQy4HnitVVK3BCF9fEITgGXEAensL6Eo2B3yCAsCKCXxKEfjBz6eBbwqfaGhp6OnAtAlgebQDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754212860; c=relaxed/simple;
	bh=4SFGTav11VlC7uCfN8PaHJcrYclJqt4SNwIqOGVbICE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=n5set+fcRz8gkHwq4be4iMt7znccAlw3+xg1utcqql3kI4UxayurXaL9qvRusXOeQXBYcyRbbqhb1R+Q7IdydqsGB9ETRQKM2eWj29UYN9Yt4mdIkSjilFpQTf3zKl+6OP1Ke8xVGu70z3FsodzrPsIuOVMI6hzbpz4cuIE3MgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXAQFJ/B; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXAQFJ/B"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bd7676e60so1634339b3a.0
        for <mptcp@lists.linux.dev>; Sun, 03 Aug 2025 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754212858; x=1754817658; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xVFKUV+v2H0/TqKb6OaGrj6JRLj/dMM0T2rqvSNtss=;
        b=jXAQFJ/BYQgz+LDBVz+5HyRnbheTcznl4fwN/haBis39cBFxclDrk0c08rFI/G5dxH
         GBZ43qC/zLXc2iRr1eAj5MKnQpR6fc+6Jv6eGDc0BrWJulX61pr/mlfitB06mD6TcZn7
         lcBtnD0hNk5C8lzwZSWuDXM8nV0UjJiAWbuE4GJEoNvTcK9oUjoGt890QnkQ5lIUlNoZ
         fSGtJKezbxLTqD2CG4ZcLeHyRVRDrF/YqqdekEXgxIYEjJfMigSwmzvtYpgIUjLjSwos
         yvI/DLOdhTV6w42TdoHEBCsqXHenZVyqsU5PcLfT1MxiCukiWPBJEa1+FI1IAwVr7+eQ
         YBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754212858; x=1754817658;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7xVFKUV+v2H0/TqKb6OaGrj6JRLj/dMM0T2rqvSNtss=;
        b=hQNikPl2M22nwmnDXf36Z/wC7793mnGEIGmMyzaLrtcfjWjRerTSGKsBmvMlswEEbO
         Fcpu18PnQHLz+/xZAGUP0JWOdS679yFjgGQSHSe+23OXOFzPpKYLvPxLsEEe6iuoPiKj
         0fQLAKOhTIIGALxztvyWi6yicS36wUPW/r81b7Z6iV8A1anNkW89iTq4BmgcFLsSYvA0
         n11jto0VXFFvbeJxXXRkI/U+JUCnWfHHtXkRoNkWh8Djztstj3dpDKvb0wyAfuno6nUq
         3KeOcqBfSWxT12oyV4Y8e9cuT65EWKUI1zK9f668c2bfhgREptoZ0M2zhVkv7sodoZmF
         rKuw==
X-Gm-Message-State: AOJu0YweVM/ub0mbWdwgZ356+BaBqMLvT0S2GesXkfn73ySjX5O53QPX
	5IqeaDjCD5v0PPqU0nliFCEm/iye90TPulrH3bhqpBF0/EOYQjzteOhVuMct
X-Gm-Gg: ASbGnctvKwDY2l5iJY9ZDV4n4oOOOjP0dp1xqTwPGe9rsCFPAxFW+9c9T59sJWpVCI4
	yxqjj0u3KDX30MH8+zAikhoWTZrh4VnIYikDluv3x4rjKTLbG71Ei5D5bGwSyAw5ICSwa4HeD4I
	QDt5omBFmWpqC9UmBc6d4ImZPdtE80v4PANmAE65D0TrLYT9kzzRKToY9v4kofHn9Qq4YC2Woet
	8tZn5cCB2b0mzY9OkSragbJBG4spGz3LqoAEd0Xw6up//VONkYb7/So65NiXRHdsEXLaeG4Buh3
	85sk0tHh3yxUFau5H6HyG9IfRehN4qy+mWoWkx+uNuQz8LwUNJ8C7kw2uXOAS04PC/MEnanbMF8
	2b3SYWNXx0d9wHQRKl1cmB3V/aqjpCSjsrtP2AJ5BULE=
X-Google-Smtp-Source: AGHT+IEyAiV6zntOOuzpe/qJPo18axcJnL/hQbEnwdp/0bXtjyZnHNW/rsEeCLZR4HW6qHdefmg+pA==
X-Received: by 2002:a05:6a00:ccf:b0:748:e1e4:71de with SMTP id d2e1a72fcca58-76bec48130amr6259026b3a.14.1754212858252;
        Sun, 03 Aug 2025 02:20:58 -0700 (PDT)
Received: from [127.0.0.1] ([40.65.61.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcfe18sm8004944b3a.93.2025.08.03.02.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 02:20:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754126092.git.tanggeliang@kylinos.cn>
References: <cover.1754126092.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: add more sockopts
Message-ID: <63ccbbdd-62ab-87be-30c0-80c49580aa8c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 Aug 2025 09:20:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Critical: 1 Call Trace(s) - Critical: Global =
Timeout =E2=9D=8C
- KVM Validation: debug: Critical: 1 Call Trace(s) - =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Unstable: 1 failed test(s): bpftest_test_progs_mptcp =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/16702556221

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/acf2cf2e5c=
af
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D987858


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
