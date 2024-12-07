Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB4323D
	for <mptcp@lists.linux.dev>; Sat,  7 Dec 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537428; cv=none; b=OInPnwC/NInzfdpCWMx0ZkjKKm2NuCTwXgrSu50ynQ59uhnh6cebp+35QxiRZpZf/BQGLG5JT6dBlvMKZMGIGfJK++enUA2q6Hv/rfH+Y7VA8xhQZOayt8a1yMHYrIRvv+5AEXXfkT2rHIeYDAZVbwpa2AzPRI3Q4ZYtDTmaP6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537428; c=relaxed/simple;
	bh=3J2EF9YtQT2peRcQrmwArqJaQm9OgkK2kKRfxO+0Fbs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=sLSxlIDywN1HQN44pM5iGSSMkYaDeXz7a/TT/bzSPRpxpTFzM3jmXIDiSoKuhzZj+SFmyXygxGTtTUWTtCHdT0YK9alKMERPjY/htYq6vn8jp/t8vvhwm4DshCHvIsjxsA0wBOcbuy3iGVdWf3/lhdCLYdoeUX/AgOgoRyIaems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY4QOta5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY4QOta5"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6c375b4f0so37468185a.3
        for <mptcp@lists.linux.dev>; Fri, 06 Dec 2024 18:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733537425; x=1734142225; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3huexnSo0VMBIfPynxY6EUYCT3Tqpm3F2h9wiN6epY=;
        b=KY4QOta5aA8xm4FzGKAc8gZr/u5z3Iv4cMpPwgMxd3PoQQgJnRMfc9wfbuQ1HnqiWX
         Z4DF6Q0gH6bIu/oI3kHBbE9/yKRgwdAtnwU1lXb8HSfDqw6x0l6z4BE4fBIw6Y/sW07k
         A+HaJferfssJ1pntTgZ3J+dcJMKmUDkObAKeIL9VZwdAMtSKjfJuUBeESr1SpK8nYr7+
         u61heVeZ7SWRMTdCWmnhU3ohNQ0wvC5Iu5e3A+R68myYjfYc/VPx63ioRcNCb8I5Mq51
         EfPzasfVhJcvEjOB4jqh+6VkAH0tWDWJUM4rO+bQWdzTJusAfyw35Oy8BDiC3pRlLPRB
         FyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733537425; x=1734142225;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3huexnSo0VMBIfPynxY6EUYCT3Tqpm3F2h9wiN6epY=;
        b=FrcjVZ49uGfzTyf0kwKt16LCBDApBCBQR4cMa3aBWBITE75dNX0moas51rzeymFbFr
         SikPnFCpwSom+skGNItva2/W79PGEtivdpO5AGHWmaaZa48p+sBFZwBaefLA9suy0OMw
         pC59Ucq7dTjrBqqs7pcvjnJXqWvhRJfV6Z8Y9Mg7YJDknQEG76TnrQEVuH68HO2lYcXq
         uMBzQugPMITZ7/K1SYO4scReTIDYeNxp9sw15+o0RNf2C/m0tAwxV3faHmDG1wVIhI+Z
         gS334yEek6i11tSpYYnX2QhTE4LF0cdOvDVmgN64vwXtMrKZrAxojxqhGt10qCgsaV+4
         y6Vw==
X-Gm-Message-State: AOJu0Yw88pxhyoMKlz5U73S+A+I7lxhJugeH95dTljmkC61MIzdP/6nn
	7OueRNcfff5wCMS5FbhgWgtzt6iJfCJITTHlTl4ufT5PzoVRBkoN8JvL
X-Gm-Gg: ASbGncsB1+Fhrhyl77B6DviMeOkmrYRPBa8toPhlScbCqRewsZuRbMqbhLFS2U1kHlN
	PoKt6u/q9BeWuHTFUckcw0WG1vV5ntXgI6tR3fQOctDwcFRi5PJp3B6mDtvXSmpqnR0arjDPkZP
	1gJLuUkALfWvomEttbXV6uJYjV9wMPR5pbrTRdGk7+M241x7Vy7+gpnGaa5B3+XRPkgua45NrGa
	r5+O+cPGRpGHVduJ6KQdMMysUZjWVZ6rfKisTX+TBrou2xdPW5zhXCLX+0kEA==
X-Google-Smtp-Source: AGHT+IELVfnT5albVS8f2CDrZmRU33jfKi/0/1mDyZA1yncBHp10BJ96/WBiOa3gFMI84c4/temoPg==
X-Received: by 2002:a05:620a:2956:b0:7b6:6c46:550 with SMTP id af79cd13be357-7b6bcae3e75mr646597085a.20.1733537425398;
        Fri, 06 Dec 2024 18:10:25 -0800 (PST)
Received: from [127.0.0.1] ([20.55.14.168])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a465f6sm230682985a.19.2024.12.06.18.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 18:10:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733533215.git.geliang@kernel.org>
References: <cover.1733533215.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next 0/7] BPF path manager, part 2
Message-ID: <70d0e4b6-743b-b1d4-86f5-a573bcad684f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Dec 2024 02:10:24 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12208688734

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ebd7946b8eb8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D915561


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
