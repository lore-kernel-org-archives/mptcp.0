Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BF46DFF6
	for <mptcp@lists.linux.dev>; Fri,  4 Sep 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518129; cv=none; b=CgIdZebRGRACXkeCIXaM0y0wF9acPkgAZUUbfseu1Q2shVrCeXVH4WPk3w7XTI557Rl2EhOnhtOmy5RB/YfkuJH3dv+qC4CyNNyvuv4vcbmL+JoKJcX8OdSxdPoWEwyfBUAj5UoC1y7OfYSA3z0O5N9tm8eDElGtsmW9jZDcUxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518129; c=relaxed/simple;
	bh=iTyq+Xmag/KloYMe7nGYpstxqTEi9wCJg2V0kQA+7d4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LPLD2bJ2m3j36N3gM2dZa1QaKyrkPrSyIq6m0HBks3oTecDQ+3j+yKvU8EWcwcq79j3Wij1kQbhROcVI74pSq1oeqEitsvJFxrqW14V9stv2Sc/DysEF7RRf0gN21wBo0LBLMzQKWwtDu+kKN11VHKIWJKJb04MStG6IkiiBIdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0L40N+Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0L40N+Z"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39675172593so672330a91.2
        for <mptcp@lists.linux.dev>; Fri, 04 Sep 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518127; x=1789122927; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TrzOej9TQ6SAaEyJ7e5V3sdqQLO/Z8Y8rxf6+hJuU7g=;
        b=l0L40N+ZuwciJOnEJrpZzRrF+NbqcomuRw8F6+ZO0IS/tPro+GtwGIPgZMSgvIPPS0
         qqeTI+aPW0CpXp8Wu9mmAtSG7Bjc73ovvneK9+vfK9mdh/4SJnMq0w9lpyr3HIo6UOF5
         jbEg3autnWffSExekhkKYd6w8B7PgbkeD4MzEezvwoNYyypKAGcZuS2YB0JUn7p7gAoR
         NDh6Yt0wfoSAxSm85Mtk83saKeRgZOb1G5gyWWLB6DyT3DJK5LZ0Ds5VpEyiJ4vBCXOz
         G8ASI7k/OclYZeDmHHC61BZit0lzwdYOYc/LlfSh5ObqGiwtdZ5RFYTPwzJNo6dbx55e
         ywug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518127; x=1789122927;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TrzOej9TQ6SAaEyJ7e5V3sdqQLO/Z8Y8rxf6+hJuU7g=;
        b=IIHEhauDFLPj72+HSQK1HnwONuK/HVHcWdf7VzthfYEUbIinukWAUAkIGbuNknhsPH
         1rP4kKh/v9iK+xTW2i/AG1Gap39KfsPWZTa41xYBc+Y+nhjt8mg3RLRCPojwIgdoSEvQ
         SsHMrb/4m2WgjUakhIMFQXX3t6ex9vsmO+GsZm+atWtPbNmp18JgXtEcW7hJKjk4EczC
         3HkSZviUQtA7sVDx+hu7ttvcE9Y+mV+tveO6XElQuc8lIQ0tptVPlM3+8KYT2UdK64Uz
         tBg5OLpIrEa+dnPERLtikwSx4RAl0XBp/HbttBaMsMSrk9lLUIp2UXlQfH5hS+gxJRRZ
         mUQA==
X-Gm-Message-State: AFuF++kulx7iOdE0nxUm9Sq6DsY3l4hVkjRvHmbIOAHeJkQNYLmyQ3wd
	qIMxQAiU6Tu6alhd7soMTShJCzXl+0jRvWPPggpg3qWjgWnh6oe6mok=
X-Gm-Gg: AYBFou2Qu15/4K5tfCeohxeRVGE1gNUHG/yCcxfrkpUPZMWnpRDpjFudx0LmzJRES6q
	9HvlTIf5A4gxK2oEeeKJCJd3ZW/fQsbWo1IkSXWczrTBAErnacrmd9tFMMZqd1bxyiL2UMGifuN
	ATsqJ0AbAb7BF9ffaxSBX1bGwiKX1FCNvKAjr3tYoe0Ibsl+9iRkmyBj7RmZt88goWoZCGTg6A7
	sh+EfzSNYt2DmFbT1oiBo7MT89m7g1Kx964/kYR9YvfBaHbHzCvWrlMZBk0AvyFtuvrkLp3M1zH
	EgewcyvCSQ+S5+qK/0hIDyKDjorh5M0tyJLqc0ChV3SCAsie/ruiC2HJrz7bjiERq/j7/Cik5A4
	wm7X2WUWCzJCOax7DIsQ5Qj5shNp1Jus2ffOMImN0cBUDHUFc0KY3BheoepPYTlC3zYFhv+ZV0S
	p+K7TbOF9Q9aY/Pur70j3G7P9qarMrUk9vWKFrvVqxNJURa9y+vKG0JmrbOX/sNS/UaD1Zi8Y=
X-Received: by 2002:a17:90b:5287:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-39b26202ea4mr7826712a91.12.1788518126622;
        Fri, 04 Sep 2026 03:35:26 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.50.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm8397620eec.15.2026.09.04.03.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:35:25 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
References: <20260904-mptcp-mib-inval-opt-v2-0-a72003dc4425@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: options: MIB for invalid &
 drop suboptions
Message-ID: <5031e0f3-5710-4484-e729-d0d9551b0379@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:35:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33858828525

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/09c2ea6945e4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157752


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
