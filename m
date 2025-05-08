Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A092641C3
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697328; cv=none; b=mUI9N4hQCd1EM80JVEAvkI4XMN6vSBKt4yG1dS1lAcgQSONhj4ZSV4VtgKRZvOvrYM1IY2XF3JKGVc+QL4d83aY/oV/ADJ4CMlx5QlZ5MYEkO+NucZq0ND99wLb3tK+hN9YXheH/elKaC4yA1k3QelNdcDIi1NgcBJFqJuaJ6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697328; c=relaxed/simple;
	bh=WvqRSj/GQ1UitKibbGxtSL4lbxCGUlDYEfodUUw1sxI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DamKkdi/tS8p4C7AMISBMQZ8hsls9PnoxDrCvtO6U3divr4P6Gw56YbQ9LsN3hRciYteVixVQaKEUnLSU15eK8L1j6LmyXlmFFTuPkfGYYZ7uCFS2K/ZmPE+JTOOAzGw210iJsCYIwn1+Mn9Hyxm9LhpXFHEY+cEjDBlxevfHkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aG9ImCn1; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG9ImCn1"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f544014883so4717666d6.0
        for <mptcp@lists.linux.dev>; Thu, 08 May 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746697324; x=1747302124; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uqC1gxbJe+jiVFgJx+sqtKU8YXFWSYunKezYGZJqag=;
        b=aG9ImCn10W5jfv0OafmeTCDH6HNb6QbplUzQFAx4XDuGRHjH5dLFOxcse8t9nOqxYx
         Wd2qZTH28IiH4td+BT1riOPFYY7vJJmRSH/hL6WnMLHgeyrNUiq7V4NSywTymINAJzf5
         VIWrg1e83UB3TaQHq9HmO7sMleEC4JF7aY7PvRjEXjrrfgXbzJrKyRQUhzTzmr+saf5t
         WnND4aTwDREtplKrzzWJrgNXLiXuv5NMqXYDtqR3DYyMILEzePpoZny3S6axGhv5mNYF
         1CcgF8NDHoBHX9FqBA4flQGXrdphxhGm+/GaL0HmQeqQdFo3aRoMOAAVXv44AZZr0mXC
         6wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746697324; x=1747302124;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0uqC1gxbJe+jiVFgJx+sqtKU8YXFWSYunKezYGZJqag=;
        b=bN53yEsFIEGCaNzCm9IBtMOtBDsidnLIaapVuCnkUpJ9iHMhYoWfFgRX6ZZP+O3Jiw
         5Ekk9NCcu7DggKiOYVE5Mwnqa31Q8QrX+rltQrhquhShjEgGp99uoG5wSBzUapisELBG
         PBQdPLKHu8Q1ehCYK/hfWqAvdZ4veQnzghgiTjUEwnL9D8kksBlJY+uM0D5gIpQn1Jp3
         PVgrRlPRs5bvdGx8Gq3jAA2bdOKjRXEV2ql0neKRherNpWJLzh1pSr9ABtuYRZGLkEpq
         WpRAdrtJGBNIshh/J3AiWBhkYqI4FL1qoK6gVpEg6KNMFIlAxnhztGl6eb5voOafoUoe
         tJuA==
X-Gm-Message-State: AOJu0Yw++XiquvLldeGaihFcvDjYj0zds0QEQmMS1JjniqWf/mCdvVis
	XuD9GbCKgKVdNL8B60siK5UQBFvdql637RKb9pUBJMdGzgNSgdw=
X-Gm-Gg: ASbGncswK214tqm0qwzHIc7I3y+MjFS4ioS7PXf1TeOQkWl3lEg2FQwqGhpOuGuljpE
	t7ZDj0ndyAuI23Z71+raY3lpVieq9T5WuPG4biZ/RKiOCxGJguQCxhZ9FBKZmBLqD7HAg+WlbLA
	eKhl4GLTZaFKJmqbDGGBE722HqZgC/FlN1McgQcr3coNJ9uFjPzM4Ue0EsHwLiucb2WRU/jtWdP
	HGTZmJdofI2OfB06kDh1qYXaI1o3kvjfXzZKMUHrFXGy7vb3aR+SpA6k4s5JCUWAPg158cLJWsl
	iQi7eGuJtBsY29oxhfGiL1bv8iHjJ/lk8MTzBf7cEJ6fob5Chp08
X-Google-Smtp-Source: AGHT+IF0plSZxMr/aE6mHaiO98DiFWAlNP5k1fzJI7HHUShGAtl1GEQ2k+BkQ586bwDWCBsykH4+YA==
X-Received: by 2002:ad4:5aa4:0:b0:6e8:f3af:ed44 with SMTP id 6a1803df08f44-6f54c3a94dfmr34699786d6.12.1746697324598;
        Thu, 08 May 2025 02:42:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.71.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f5427b31a0sm31221086d6.113.2025.05.08.02.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 02:42:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
Subject: Re: [PATCHv2 net-next 0/6] selftests: net: configure rp_filter in
 setup_ns
Message-ID: <77133da2-529c-7868-715f-df8eac95f11e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 May 2025 09:42:03 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

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
uns/14902280970

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4395dffc7a5a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D960799


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
