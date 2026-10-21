Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582746;
	b=c/JBh4kMadmh59d16PYl7yJeElObAlo+TxKDtRV4NbWyDhdSXa7DtxAelXzfjBRLXZUT
	 8sitJN3NWx/8G/7Tweji9cpt2vxBMWHA2O9jCr2M77qZeKNv07c48DGSZV45ktM+cTUu3
	 ZbDK0z1keINX7jsw1mGE/K0l/Q0O/JEzn1ke3FvqpKpQfsY05Tw4dbsKW5m+1aEgXTngk
	 50m8S0ccp/pHkaOt2xb8yhXoQfRAZ11jJL2Vpk7J6Zn9/VwhyyOD4SAlkwxr5hYk+8Wo4
	 +1PGoPP+QzpmCR/GmuSX1JMPosPY9rOBVktCsQf972chhZ0iuINcJ7bXjlSAjQyvh8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=WC1vIgyRgPO14uqubIS2w7nKZqTsGIT7Nh8uuCXQFhk=;
	b=SA8V4mgkxbvnZwCPNopyQKBzFyN8XXUHKqv2+aXZG5N/tm0VK+old7yXC8VxaIRNiVuS
	 o4Dw2L/qMcbaFND2NuopxefYmzUb+XwE83goGt7U4ShTYnjWAbSzpzX4rt+lvIOJ+6qdg
	 DGi1CDpLiVMcJrFYnNLdwLnifJc93LLDYLmoLgWEEegSYHirf11wpX4VWkm1kmJ2J8yp1
	 dGaEJ/0UwSXORgQxJxD/JLKPq7h8Bd/at/JsHVEgW+dYDjor/P6d6WhUkGyoG6WAv/zO6
	 4c9qRNGbOaPDWLdh+AZsh+iC45onD68EnshnWFqtoXiY3LZCob9B+IDcUzk4OuT68iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XiiznElM;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C6E606A31D
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 11:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21C6E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XiiznElM
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e5d0ee1951so4018015ad.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792582745; x=1793187545; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WC1vIgyRgPO14uqubIS2w7nKZqTsGIT7Nh8uuCXQFhk=;
        b=XiiznElM3KFCPZRbpzEttqAL68eC+WqTGhMm2wNL0sfAC0nlBQbGmXnhv8uhamN/OE
         Cwg2vuUsC35jiMal8i8jRkg2emKXq7p/K2oC+x43iIWY2qirTOYT9AtmNJ97BvPlVEH7
         KZ8rnI8M54uhdQ7/5yyWZECqbsYrbluNrE5cDvCJx1/yctrIlBJLpnk4r1zYVoItB8R+
         i9l+LJquIOFGtuDyY2lwaaVDvdKluGeWkILR3uLFGifAsIn9IBbgnk2ZcUcRbYg4+h94
         k/lfezaCpxtVAk+ZOt7mjPlNS5ILKBW4p5YuHq+i3E3n3MLLjOkIrQoojtSE+SfW0PW1
         d9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792582745; x=1793187545;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WC1vIgyRgPO14uqubIS2w7nKZqTsGIT7Nh8uuCXQFhk=;
        b=W3yq/bUpWSSmpMauQ/hZwkhNW/FhlBRopSiqHwYh1TrC0uvADOcNMB3w1dCATZbt00
         QfWPDb3R9xrfVPSRTb3Jl5oxCsyi6Oak8JxxJgiRabVDoyuSuc8dRjr/4nPvF3vYt6hS
         KmrhK5HP4Fluk5OF49JluqW9vfEM4yhFvMoT4A/EJgbXTrdJJVD3yYyLeeFDclOw5CBJ
         GW8D6OmTCB1rDNCtxdHxJXAlngrzH1/BttAC+haha8YqplpjCJMcht6rovjTlnUenhtq
         8iwn97aZN13yB4k6bJ+3bAXow/G4rkagwDnrIUVhiwERFUl85sc06QS1BCZBISRGxcnx
         fXyw==
X-Gm-Message-State: AFq9FYIGkpxecVG1l+q6jtAiX5ia3nS9G/Ooi2BPYo2EnhtaY+yQdQSY
	p11HQUsZY+xmjg6lRNp5TbioeZawuoOR0oVX10fMrErqjPtP3mE6Gv8=
X-Gm-Gg: AYBFou1klks/uxMqqHERYr2A++iGZtSbJcnTAekyFzu6jEq/l13O26JmwuTyk8Q6+YO
	hPA0YDKIlcUSZUCzqzWzATtAWGJXI2pImhvnl1rrEmPnthZ2WDjufHkibyLRpaw4QIDXuVcjl+t
	HTn3oRILO64KgCANxHme2swq//kGqF1S/6NE03Ta222EhWoqq8EQ49J7gi+jMabgZ86bHQ7/D2x
	6tUcqanEbt3l4crknVFdNbk0Lrj99BUDmF9kDy02z1m1R8WFbGQ+1ywEgF/Xe27wV7dVZbMebK1
	hX1AEJh0WxDlktYJsO050To9S+ad1ayCSTWQoGlyoizBZjgTcDKfBXiHBnG2QIg+l9vZf25cgMQ
	IFbVQfuj2wPjSlXYDHygHWqvyjWWmzud6xysQAWylXXQ5enzOtJ4IwebOeqFNac/v2OP1+2TTb+
	ieYOiOv+Ebt6KypjiawSINbyGHtETDxNsZ+aTpcxOKnJ+I1dKGLd0OL4J6K/JEJ3d5Fq0zeCC95
	9W8z6+UXXiT439b54cYw952meJ5HbEros60z8/pgET9SwcOdNS0ntLGgq0u7obnWXnX1qMYQ8s2
	9FiuCI4wi3oWiBt4
X-Received: by 2002:a17:903:2c0e:b0:2e9:c569:7050 with SMTP id d9443c01a7336-2ea43d39c85mr15554555ad.47.1792582745226;
        Wed, 21 Oct 2026 04:39:05 -0700 (PDT)
Received: from github.com ([172.184.211.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4ae277sm9977455ad.76.2026.10.21.04.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 04:39:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261016-fix-mptcp-issue-638-v2-1-cc32774a8b0c@proton.me>
References: <20261016-fix-mptcp-issue-638-v2-1-cc32774a8b0c@proton.me>
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: sockopt: pass total
 bytes to do_getsockopts
Message-ID: <305f47ae-8617-e1a4-a839-87a2082ef58f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:39:03 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39578668072

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/04d6a9f052ab
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1187817


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
