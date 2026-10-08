Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E923806D7
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465387; cv=none; b=fS9b6CDCtf20VGbr/JWLQaFHqZSYUeHOkiz5hXE+Rt8L+lBllrMq3VBWLylXUb8MWXqehgEJP3pCDPZQvfaB0QuhMhN1OPYuJM3yokgUcwkmlhNnVWTS+qNjyFr9GyF4eAE20TaUOXJXpDroOaXR5xtOFcoO366Hm5UizzKn07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465387; c=relaxed/simple;
	bh=eiFQBRTcjgz6XHurLmPpD2utZUb8d1NXbFgdRs64UzI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cXcw1NDjWjOvAnkssW+6kj9lauYATYIGErsr1Cvi0b9G0mZU2RL7ic9OPPy+98peoKINpog7xXxvulheU2t52WM9a48+J2RN+GkuYv5EyKvzJNh+OGGSZxQj66hv58SsfikGjZi89UYY+NypNENvzdcrNr2Z+38rDZ7EgHWBMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxmPzKXI; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxmPzKXI"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-49dfaa16190so489012fac.1
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791465385; x=1792070185; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=msHEWaqb21WQhIjI1gyBwkr8RlST1GqKr6R73cOiQeo=;
        b=GxmPzKXIjhBCyZMa5nqryBKL4BCshwmXRB80wu2Tg4sieWplA9VYpqhV+QwTmvmwvp
         UQxrt0PE1l7czhzVNY8Kcav7WO6DKm2tolUqXHgLiZRHYrlLI926VNVUFDffhgJm/s4z
         5Hq8PNUPgLCfFHptH2FKF8zozIAlgE+/+LLPGdpwqawpWW2BZJov6FR8Zqt7SN0uEhGM
         c7oYZ7n4p9DkJvMxhiS7khj4rLiQQ2Ur2uE1r11ujd8pKh8/nrUx64A4Kw30XVGn/FVa
         ja2qwyyabOhcfvnoJAcLkpPM3UqbJargNyx9KedLRdVYg2at8My/JLKDeP6T0pkZTQZV
         c2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465385; x=1792070185;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=msHEWaqb21WQhIjI1gyBwkr8RlST1GqKr6R73cOiQeo=;
        b=VYAArCaT5tZaTkqdnS9Y7OgeouBOctKHSJ7CTR3oBEvO8UdCRCQMwJMLD6iovqVlm8
         MnMpLCRjyFniCX8XiDRr0vPouMdWQG1haddU4+YiPqnP5LJwQbNuWEpIGJVPajTSEK/e
         b+DP6tHC+UqbgdJB/ckls99AmFbELea0bwAEoOrIrU8twsEMe4mGg6EXm9DNx5o1jsP9
         aNhK8UoujfwahaF4cgIGcWDi26b4iimOINveDQktYBU/nasxkzy+EmNxzeW4y/eWstzA
         bGg6orBQM0wsegrWTbmXNHfXCm5y9goaG6MGZ5sAVbHLooIcZ1AEdSOBx4LO5659bZXP
         Ja0g==
X-Gm-Message-State: AFuF++lmeAgRtF0FsW6L/bSXuQCG7hQFxoZgFXZKdT5VEAWTgCzrDrWS
	x9YuD2j0bSTWdAwBHyQ/TneZPjExO8ndIEjaYezbfYQ0J7mdLocEjYI=
X-Gm-Gg: AYBFou1kKC65LioYGVQ7twkDjcWqYKCX1zcc+02SnMn/Ib/zG/cvYuMC/ulHabZM86k
	qAP2R0ciSbhG5FIWctD3TfP4hMXRrdR/fsHWQH1qNCE1dfN0hT0ndjkczUPuLr6xM4o3YC+KdNa
	/jHHZ0bBhVoGo8266Hefh6c1L+RboHmU6zKnnF5VE2VqpxIW3+ZiWoDSptRNbWcpeLJbD2rBtlc
	mpPnFNwN5iEdckPA0gtU/aWIZwZWYPB/OBiWObsH1wqOPHyT86wbKAiLwZfNqiPsYuC8cqOhIZZ
	Mem+kUjl8C3RQtQaHDNvO5zuzazBwDJqu2qxtUmCxFByjIriseMG3sa/Hmc/B1p2QudNNoNsLlo
	xpp03eViOuk4sYeni0WFjwBmGnvi/n4bLcccY6TdS8rsVv+RXbYHk/tHL1ZlswXZykW9E4z4uP8
	l3Rnp2RD0avFCZPohOiNYWImHQXFCke+hO4FSZVCa7EeoU2LkoWXcwOVyVIMFiPMrJ9MTDY8edy
	RWUplKT5ZZQ52uJ2EuU
X-Received: by 2002:a05:6808:4444:b0:495:ca1b:7865 with SMTP id 5614622812f47-504b57bd0abmr1526519b6e.11.1791465383884;
        Thu, 08 Oct 2026 06:16:23 -0700 (PDT)
Received: from [127.0.0.1] ([20.64.17.52])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc484f6d10sm5674091b6e.3.2026.10.08.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:16:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
References: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: sockopt: test passive
 Fast Open early write push
Message-ID: <fdaf0b83-7071-1b06-da9b-a5d47c1bddd3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 13:16:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Critical: 83 Call =
Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: normal =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/377689=
75331

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/fe57bfbb0927
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181563


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
