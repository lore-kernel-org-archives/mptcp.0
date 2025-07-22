Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A127289E29
	for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171829; cv=none; b=I/GQp2g7/nkPE115oktCRMWDrXgtlHqm7JX/TaGslzkTvdpAJbUyPlDCuEZ5S09kfPOljtk3RNDPec9msqKHcFjhQVrmbyVsH+AhEH6x3Gpenabsgvs/ojkVe2g47zvX6R3ZAC4jaL74Y2typUadYhA0zgZw8GJdKqWVm4hd86g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171829; c=relaxed/simple;
	bh=NA/7uS+/pT5YVF8T4NFpk237NVzIYEfOTCV0Qzu+O9s=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jMxOh+cZVvpWMoukT3rmJXT1IV/tR4PrElLUjWJmLlK32AKXe1RmFgRyfyoWe5FShyyj1Ay2KpDzW8UnM3QhlGqPR4xgaAREVLbjo3khfio0bzui3s2NK3qxL5LXoingoug+RIYHjfrD7MhkXOfUx20z9zz/oRkdkMSffHRJ5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3H1lZS+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3H1lZS+"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e1d89fcc31so523359985a.1
        for <mptcp@lists.linux.dev>; Tue, 22 Jul 2025 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171827; x=1753776627; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc5P16V4RCnhYF6PjGqqSre42eJyb6xw3LyXGQEZtqI=;
        b=O3H1lZS+M1Mi3JDhhYRYFDP61Qq9SQjDBSVtoy8G/q3nPd3aq1UZCf4yQ52MjzoY8Z
         LevxMAZTBOC5I3WqbbWrL6QVC2GhMjltnFOKF9Fr++vUfYiLJ5BDLq1iXBJGXeCD1dpZ
         WR9fTRJvguW0ciIvnSQwojs+/wD/MHA0RAvAeB5v0TFZmzwdKs+DFxT2egaUgfTyWIv7
         DNsHmlGrcq0JXOieDtR3b/zb99gbN/xwj3KPc3bRV6nyGYTAg5UwybrIQLy18d8R8ISm
         ZNjt/uW2qlxOZz0ifFRRLyA7NP2L7VEqFkmb5D76Hc9wKOg5QrG/4q2O/vL5Yb3qYLap
         jj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171827; x=1753776627;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bc5P16V4RCnhYF6PjGqqSre42eJyb6xw3LyXGQEZtqI=;
        b=mnIiowGcS0olOaYAT1mM6XznTGd04xdoe5LdWb/iH/fAlCz/Dn0PVK462MX81Pu0zv
         P8jflDkh9xM8NIerPE6ZRY74InUDaW3HE4L5o4jr9bIRBoRvYnxaqTGJbhCwbNktCJqP
         rbP2UBfk+G9TFge13dAGzi4ibpGM22APf9N3/oLQp4XAhsVj/pScBgSPv7Zi0eXOrSr7
         eN+E3OEHFVwA6JW0xig9dfpbMnsQthKJTPkxLBqO4JmhgdjeOX0kx0NWDVVrxP9ydInf
         J0gSdzukZS/NNukWrVHqp66OWmXYBavoGRn1lX7v91RkUPG+Ir44nZs5T2DDS8gD1CwM
         Mzzg==
X-Gm-Message-State: AOJu0YzbgQnk6qjk9I3gz0fs3R3PxMHtlpYfdGLlZkNhN8NJ2ftAjz8y
	OYD3Z81fw/vX43oWVGL3pl9PM+sbUXVzrXit/xnyNsqZJysYb5gy/4k=
X-Gm-Gg: ASbGnctRM6H5q7j5k8kT3K7t1dWB5jcOiIvm8mRxISzjkxBBbVgnuons2f6wybqgasd
	X6DbDO6u3Ev8Z8YMEGWmyYJTcn//Tc5CTiFQJIwUTFee/73Gorr8aElPGGVw1BFF07S1a0E+YON
	5NbBxqF5bX8WF2232aOKMTxCXK33oSXHPp8QiPfjmpFugYmGj3k0CRAw0eMRnZuqg/vQdg8zRYJ
	5tAfpm8sUzZg86m63HuFihF6d78mgdbdHLSRk6G5WT204MHDLdVDATAb88cZgdOtTdBFVvKjTTq
	mg8Zb45FgNx0u4llh9XiZk5SrPvgPguRttNG0xmCkQ5dkLyyjayi6DMDhZSTntLLH9P/JJB74fT
	6PLWsWCJB42YsiLXKPapjDzSZU1Tcsv1cn8E=
X-Google-Smtp-Source: AGHT+IFnz4UfzC5satFpFNuJkMsrmGVeaAq1KJtErFf8Z2G0G6yVRnhZciI6gueY4bikirJj65ZZnA==
X-Received: by 2002:a05:6214:5007:b0:704:8a24:7bb5 with SMTP id 6a1803df08f44-704f480f466mr295421556d6.11.1753171827049;
        Tue, 22 Jul 2025 01:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.172.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b738sm48631616d6.64.2025.07.22.01.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:10:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
References: <20250721203624.3807041-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 00/13] net-memcg: Allow decoupling memcg
 from sk->sk_prot->memory_allocated.
Message-ID: <341b60e4-59cf-d01c-49e6-2d7a5ea5c222@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Jul 2025 08:10:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Kuniyuki,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16436561761

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fdb62a4fb078
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D984458


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
