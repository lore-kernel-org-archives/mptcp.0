Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B163CA4B8
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883668; cv=none; b=mnB8kNsAUMVzt5u3GDc7bvqWsXdGWWPuwckF6z6EL/5al6S8y63Ps/VWpJUt7I8x1zLQiati2+SoS36sbvpwnVJ8Sv4YTqAn24SAqUbMZLg4ETbAyY4xwT94sA33yqbXzzcXY0vC+dXb/pukwf3Ezv7jJYEKBBH4RDUgGJhfU2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883668; c=relaxed/simple;
	bh=OBO2GD0fU/lU8WB6eKjDWd9/PSgv436CA8FMlyzOhz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=VgmeUnIQ9ikfGaoVClIiF7dKJPi5lMsZhJkH0eylpOHM+QTydhIKD0vEfpHTjHSQApRBqVhi2NW6utOwlwzY3pgZT3X4cYG96Ndq+lYYPN1RWjeRVrqWnaiCrHxMKqbY4/PzwLVHujUkaItGOnLVzddhmRU5mOSL4kmKU8OqjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQtx1ScE; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQtx1ScE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b98482b253so190364376d6.1
        for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779883666; x=1780488466; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaIfOoTZtWC2Xw7ktAH/kFvFftyCoPtT94XDAluVxbE=;
        b=IQtx1ScE1fiuDMwSO8WfMoVf8va3++lqCJTjz7o3j+SxqbwLDfUGqBlYAJs8B7Ytea
         Kyw61h61TZ65Y9XXt01n1mRVEniM6JnArrDnjAQS0nnH+GN9+vwonKSxQuO1i/VTMXCc
         gpuU5eNbSVfVEU0b7xM0pLiWpkiP/3NfLdC39ELz8DeQeKmCjv+wlFsEz++kCqbpGnLI
         ZmVojQ6ZDJFUBWfHB8Yu4O+03vFWpiu22y3tdhBVBMqu1bvYr0HSX79A/BtjsKkk66Lp
         V+IQke5uzeP95uC2aaGdH4iCvRNB1j/RCNP6juvGSeAulHGLMYLxphR0FDT/i2Xa6IRC
         gqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779883666; x=1780488466;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaIfOoTZtWC2Xw7ktAH/kFvFftyCoPtT94XDAluVxbE=;
        b=UZq9tNq1NBNrW3Q4MsnBYwnykJbZgQjCd4UWnvao8HVBJR+towhQkKgq2n1gQiIwik
         Pgukf11pMVUWJuWGEfSw0JGO9n6Hl4OGvWk/UJbEWdt2CsLLrszR0Ta9SqvMkzbBpbMB
         3EnV/Zvm8JdUVnWhn0/np9a53CfV+TuZS0HJAuMPvdrwIAT8wsVTiTZXF/Dop1Rhf+6O
         oGJLuSp9jLVnEqJ3/LC4InnFq32FpRKuxBvRx34LqrgW4WD23PAEaFZpuEd5aWVtC/BY
         f58SFKZcgc/1bAqq4K+hp7y3MAWXw8D+lqzqt1yDnOPjvrKBjOxQWBXYnphWHeTD7TLf
         8XYg==
X-Gm-Message-State: AOJu0YyulKIG6pKoRrE4p1ATHWf7jgDNZqEkomE75gH95FfkMCSW+nRi
	dm8Uban89bXsdbVPdS/pQGMSM5sGJdAn7ltFeC8XqGlPRtpbptH9wHU=
X-Gm-Gg: Acq92OHsiT/3cbeFbVhPY1LcWG/i0NnKMAQUzBc9r0WuFwEd+SPIL+TR8swAHAOw6nm
	lnIlL+4ajOAdvOZi4BitABduf1nJGF2yTqRO2kd53TbhpT80OSgQljdsaGhWwx4anaBiHiGuK0Y
	83m7lHAvRKb26CHr09U1LhrPyjrLk5Eqihfxo5rVWdWRmgGm+l0cg4vRpVAnY4iKVzaKKSPCR8X
	GyLmco2XuC6VHtae2DMdsAHjIXCmhBqAANzcP+uobSSmT+o+0UmfMWEKjbA2wEibWMHBeT2Ivkt
	K/dRy/UWUHhIgLz5o2YYuouCboMWLpVScAoUEcvUE0QYmWL+axJ2OsLum6QJ9lmQY0aRejc2n+3
	7UI5yHpJeEXNWfqwnWX+iVbYIlwlbCeXasDfAgEGnLYRjn87b/7Yr+3Dfh+ayMGoXWAatmUIV1X
	BJMrJiGtaPtr7h2VDdcja3/LqALBBjlMbYWSRNLQ==
X-Received: by 2002:a05:6214:1307:b0:8ca:17c9:c8b5 with SMTP id 6a1803df08f44-8cc7b601423mr373063976d6.24.1779883666111;
        Wed, 27 May 2026 05:07:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.167.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80deae74sm166053636d6.11.2026.05.27.05.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:07:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779876523.git.pabeni@redhat.com>
References: <cover.1779876523.git.pabeni@redhat.com>
Subject: Re: [PATCH v9 mptcp-next 0/6] mptcp: address stall under memory
 pressure
Message-ID: <1f03e1bd-d1dd-bf02-1996-c92948619db5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:07:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/265072=
60311

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c82090742e4b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1101575


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
