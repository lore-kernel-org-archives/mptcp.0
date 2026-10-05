Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5263A3264CC
	for <mptcp@lists.linux.dev>; Mon,  5 Oct 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227792; cv=none; b=i6gIiZS9O2ez+LTA7K7Pp3a9lCCPvFqvHb9kM6DrdJ8QSOBIvhZBREL0bBTrn8CioKzT3PTmTm6ky5qTYZnolnm3xh+hN5iRn8ibuSLkHPFQqHIwAkmb1sISTIP26vLuSwA1ttjbVzp2KE5ACd3eqKrDoMAWpFJkkCoo4jS0+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227792; c=relaxed/simple;
	bh=hVC0jdKK+TM81BY/SU1uKvF3h/MS7MLldktVkKiWTB0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=MCWb/NmDEosBvgIl9PkHRMake0Z3LTZFZgmi9p5K4YNRjlKNvca7J+UsdK9WsbYs1OfOHHIUad85LY44giKVeOhSgweImoaNB2+h2FgSqTs44EGS1O+brcmn05WXP9Oy/8flE3d9RjDFqk3tDAEADgOvV+qn7165oF527clYuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+LBf3Io; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+LBf3Io"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8accbaa1c11so15141957b3.3
        for <mptcp@lists.linux.dev>; Mon, 05 Oct 2026 12:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227790; x=1791832590; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1GyAizoLAzB/Buiaf6+mMi8v/ZhxOwDkBU7jZdhFtZI=;
        b=Y+LBf3Io1EXuI0QJX6j1sUKwnG/UO4JF8tbQj8hvDKM3vyP8DMGF4JOj+OKPhUIG97
         f/+X4s4Bqtn44y/3IWXqYcB0v/k88smQzt/aaGSUQD3pETdqzq4XO0tLXJLrSQ4EuA8p
         0pT1MckPidFMvgyAS1QioxRBLjSATSPYTGtMGwgfx8MLLD3BKtjehhw78D7bs8binsNK
         I3T4nNsPkDeNnQ5jSieCuHV1mrZqs6unOKu9N3+3YiDcabC+BQvMea9lF+gJbtKZU645
         3pF202P1zeTXO4gJEXh9D2WfzXvVWrU8rDR/IuR5iYPcNBVKZFCvpv3kGxNIF+gYN3BQ
         L1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227790; x=1791832590;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1GyAizoLAzB/Buiaf6+mMi8v/ZhxOwDkBU7jZdhFtZI=;
        b=ZIRAaaPwXHmjeJ4vDD6tRSHD6zru9CqheEhUornjyLxvgpmcG+GpdIpVp7Ueao9DGh
         SfvLTLi9F8G9G0s7zln9eT2nq5iAwZXKSeHe1TDmzerGQhGlu4HSln1OBNeywYH+eG2y
         Wr6zGBk4TK99eUsMOScqqw687jfb2KyVRnJviG+Z3C3aiHiGBH1Hlh1hoEBLPTcw0RRJ
         NvhwR5EW1b9qW6Rk3cqz0ok2JB2e9hpH+zTCa27PoI+R4x8Hk4nHIOcZpWg03eZXj91/
         0XgoAHopggbbm5SJLJFscLE+GAxsCctHpFKkG4hqOdlizfaVPhJzgJNLUlgJ5iYwcNfw
         ZWJg==
X-Gm-Message-State: AFq9FYKpHGXZk3heEaBsM5WqqILbF3GvbUFh4HD3Pg4iwwewvhdERhGL
	E2aDZxi87mhirkRPY0hPgx9j3Mgb2L9f9F5DMqvPzoVFHnZ8TK1R5/U=
X-Gm-Gg: AYBFou28/nqnTex/y/4/6LeODKQ/IJbpP1WPQmt9fftJ1DrTtRQMEC26gmZtHiI9FAt
	pPzehWyDYHwyb7VDTBotViqPuWBY0BhnF8h/MklZWDzg7QiMDsa0SzFc7N9QNwH7y+O08C4ngPZ
	IASRN5F1wjc2aIEh6KV6Lo+IwwvGz5hOY6UoMhdP6/VrKmHIuJQx9luOgkDY4FAuBJ5HcMKrms8
	veXbWHx8/4vQalRtYSh664twcaeVZ6S5cTJ4+ZVr5XZwgGUMceyoFJYEU/zKJQ9D+1prQCzaeqp
	bC1wT+tOF/p4ZbzV0GUJChQU6BIy3wIdiIJgcaNqQF0G2idLjsvR8fFeWsJpDHKC1pWhp7d0CIQ
	gbvCzSgIJ5+3824S21AelDpKH1yAeF9KHkFAjlK8uw9caD8+Q61lyMEVNEX//62DVqLDg/rpqDD
	T8TukCT74HV3lLTC9xbXjvx5a3JAZ19/tXVeEYpMEY54Qu/53MVkAfKCIWeEB+f8EfSYoSls0uG
	WIBQGcJveCZz7H8bamiuFDP
X-Received: by 2002:a05:690c:c16:b0:8ac:46ff:d376 with SMTP id 00721157ae682-8ae39ab5f36mr46861467b3.28.1791227789306;
        Mon, 05 Oct 2026 12:16:29 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.122.150])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe64d5sm43872497b3.48.2026.10.05.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:16:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261005174116.3521187-2-matttbe@kernel.org>
References: <20261005174116.3521187-2-matttbe@kernel.org>
Subject: Re: [PATCH 6.18.y] mptcp: fix msk->timer_ival reset
Message-ID: <96956b4e-4a7d-bb1c-f83e-e65397972561@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 19:16:27 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37354848622

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/5e6b2c55e0=
be
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1179808


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
