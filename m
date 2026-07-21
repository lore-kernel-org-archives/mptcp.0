Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFA27E07E
	for <mptcp@lists.linux.dev>; Tue, 21 Jul 2026 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605619; cv=none; b=lE+7c9NW9xKOuaIOiBWwflghNMwUJaQocNm+Dqcb61uX1pTv5qyvujbRLAPmnpm+B0zdJTeBPgGbMY/oW0d8/aktrKvcQ8j1Bv75O/wvtcKfk7UjP5qRn8LAsPqSnBXFc+F9csyez/zgddb/7ZkbwQEaq+IPh7lZLwJfX8UbGAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605619; c=relaxed/simple;
	bh=bl9rKYMuZwGjPvx7WimigfUDflMvWXUYZM2A9uW0Iqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=BRC1NrLZH9qziIDFIHyROdrlQG/3zBZLetg3ZJa3r0VeS8VboB1IPMTCJcXEh1n+r4th70IJWa8t3u0fI8k2PmHEMg57TvkjdHcPVjW7Dgy9q94fTrDuUpbtROr8qeU/4MmCo16drFWl4/+we8BS3jcALJO37F4ovzwSTAdbxYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrtBjF5M; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrtBjF5M"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c5382806fso63642301cf.2
        for <mptcp@lists.linux.dev>; Mon, 20 Jul 2026 20:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784605617; x=1785210417; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vGYqbMsQQcMT8e5Gou2Ec5rebosKeNlxPZ4lRCxDfnA=;
        b=IrtBjF5MaAcCIVotG8f+z2/QtcPSXwgtE89eCfKIx9rP83Refb1XHos3SdWSPEu+ax
         KlyyhlaEGLAFxU5vtIRvSfVuZ6oxtvmMPXbyx9RLudJG074pc083p6bx+rYPeH9xWbO9
         QltOHxsTikWUxJfJAHxl0668il0Fa9F+mXi1nKdQ+OWJjqoF3OQqSi5JqMSP5mXn53vw
         fPc/StKDDkP0gJDjOcRb+7hwIAyJcpR6meN9krohphqnUXT7VXXL7cPXTL4toGGxVoEG
         w1UOkV3epB/GwnrVSIoP74mYZ1HLrl/NFab7eO62vt5ZGBbw3VTJqRR4ChL0/fXIJlAP
         +uoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784605617; x=1785210417;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGYqbMsQQcMT8e5Gou2Ec5rebosKeNlxPZ4lRCxDfnA=;
        b=EzzQvJvxbhInnqVLZP2XGHrbK5sHYzvrSJEXvWTfPWS4Ppvw7MxfzhW5FYCgqdeK+W
         NjqaqYPLeLjx8bGnXFWJ2OwLfWQP7OfWnGrrnprkfROUu/icsMAxaOFrHs5NujB7DPMh
         P4Hex4popYDazlp0ZYJJus46iyavhtvWP5ZtL1SejI/xMlSyqkj4Oibf9Ba1I9D25yAX
         aQQClzEHChBB3Nd1RXv8AyfiCzFwBsKEPCpWOiIrWEmBdGClwL+kyr9IkRukdPKwBMWY
         ev3FAj5g+9r3M4CnKc0K6VdFV5jmtAHRrA2XvvyP+SSHMTgDvNCn98bsYK4YAOghqUyL
         RDfw==
X-Gm-Message-State: AOJu0YzT5n25lLxlOiccaQe+bvti30vQKOEwUF/v1+3B57J61X13KoUP
	iN744k1YMPk11v5aaObqpgrGdCOvAC0U13VhBytHR1EeMsNg4ILCTEd0XKFT
X-Gm-Gg: AfdE7cl4i6sHtWmUqivGV7LmXxoXLB2vzj1UvRBxqbDGGxCnf71+LX5vvIHTcLbxb5E
	8ViDHmiPyMO676LtZ4PyetaAVIUrEGbMrsVzcxb1QrP4wtInrn2yj32CDzJjh/5pCZC5n0eWNfU
	HxQrTyTsMFHGmGsPUbpn3F/qV6Y1SIKd10v2vpUXwXPoH0XXPbHcD0ZAwxa0oPdcxBTAhjURdS6
	dKQTrWtzT+2iMcwI7kpNw0OO4j19qQv+q1s8m6sPz1M8gmyFkHeI/cyQDqzDog8LycSN7hLv9ny
	jjntpabhxsHVnL9MeeyH4FoA08Q53TlZuoeSf3B1SuDiGqmIoPY9TbBusR4ZUfDiiq6kZWItPi6
	px4Wh17t2UF9Va89EvCMYqo0wxo/zdV1jaxtkuKCLt0RTq1D1K3x0FK79gR+4CRXnqxvUElXQOE
	lkBy9xTM+0nhyf/vAS
X-Received: by 2002:a05:622a:4110:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-5213d2b7109mr158045571cf.11.1784605616755;
        Mon, 20 Jul 2026 20:46:56 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.198])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214cda7dbfsm85836411cf.9.2026.07.20.20.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 20:46:56 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784601268.git.yangang@kylinos.cn>
References: <cover.1784601268.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/7] mptcp: add bpf_setsockopt support
Message-ID: <46de2030-2800-c6d0-6208-9cb007b0060d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 03:46:55 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/297971=
49050

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e51b04fa682
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1131261


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
