Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB473F822B
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373649; cv=none; b=GPZRkky5mvIsPhxlfoeUgKi89mC0RgF1ww76sQAuM+tfZJX4LK7vN7kHKqTuuqO7+3m99Lct39yDCfTUlzV6HTlYjmdM3SK5VzP4eipULNmRICvscEJZHaX8hN1Qf0sFSlzCjOiCmQM5eYN1Qb0/p8qySPrFn92DNse22PKt3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373649; c=relaxed/simple;
	bh=s/b1vAQfQVK9WPnLmAIRz03zKgPrgn5JoOTkZ1Ula7Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=P7b9TnJeaxSinxcO3vHYPeyK43UVz74OQRICEpqFOcTgsJEH/2L1SoI/SLZihGjk3NUIvNSYNBjKDwrNho06GY5sIey/Lfmk4dED2Nk6KgnpFNY5UceIg22YJ9Voj95Y1vuWOnDyjDxvNt3XdvpeR/26ft2DUHsX+pGJkCQZE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXK5T73; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXK5T73"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-804f7045f3eso439091a34.2
        for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373647; x=1789978447; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XuBOIMBbqGTM/5CG8gmjHbLalw0Q/L0XcNctZzi3VCM=;
        b=ezXK5T73mshVf9WB5M/reIdP79Hc4zq1IMyDoG8oevcaWQfNvDliRRdPTDkGVCetXM
         RFc6hrhjG2xK95776CrgjDZRwswp+HyNsm9FIliwK4xc22GC0igN2QR9i/MJ/ChK/mQi
         zKW0rS0tVdep3EU4uPQUluO9QfYzEy9FDO5BPx8aeetLMoxhiqbK+P2KSRPQIx+3pwcP
         2k66POfmwrK7rXGMc5n0Uy64FjatrUxUyACr6CSk1Ojif4RYXPgk4GCbh2RqyFton7Dt
         AVVwmVKdaJCmf+spUtgYZwB/q1E4qq2OLyEgp5AALQRPUOozS7WsjAyc5sDq8SXXh8bc
         boFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373647; x=1789978447;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuBOIMBbqGTM/5CG8gmjHbLalw0Q/L0XcNctZzi3VCM=;
        b=MG9DWRGqdivqcTjYhpaYvuUWj+v1+Y74bSDnu0zgfU1wIIl9wHymbmzlnCI3b3an9H
         DOgUi7KIR/ZcuReuHsM8eWByEVeOA2w5wk1bFIOy9ZSvPnX1oe6Nhfpwwdxidunm+YnB
         9lcO2mRomcl5TeZeqOQWdVkIHsKUX0fSNoumNuf7DqSTCUTLpBvCBbFb0kZuw2CQsWmO
         aIC2CN9CkDbHLc1eF4SvlaODmNzLed9NkAT946I7I0OibGvN3CRc/pzFxKQz5usHhKiJ
         QhH/5XH/PMR+zvvtkWFw/EfvF8BSj0oDBvRiem21O5sMLBzPFIGG+iyBqWozDz4DIxss
         FrfA==
X-Gm-Message-State: AFuF++nXdDrK22JoTjTA6eHH9t/ltHruBA8V3mvzGrtR+xqQsCJV28yE
	0JUJH86XTlPTDkYt5gf3ELDRUXsVGGNFYqTTOLqW4QkarTqOl170y9eUU08eFpc=
X-Gm-Gg: AYBFou3KTRMJqDwHrqFLyyBjxTM1561HQS6cqpFAL7qaV4/TEXX/7ghqXOTNXluRQQC
	iEJBws/lsOlim7UmfoFbsL75DIIIja5oiX252kpprkpXFMEuT2sb68t/AXvZyief/dvXh7Qz2bk
	dg7VJnkpmo8FPUm0Ux1Oh6/xSwHK9e/drmlcKmkLKfXmpMYVd1LVu0Y9aWMvJH2lwfHhJEGuPhR
	7P1LzQfGKlTfcMDxCZD55hCXRV78MKOsj4BmIPi7lS8rrNlHVAWu+pf7NEEUf/9PHV1FP6J7p/6
	pIcxznRpPMV9aEj1Ug8ah7M1nexOxGWqLwzxeyENTLrnC9k7nx01JeMLGNcMKCoQJV0CUfnAbVj
	h6ZhO8N2M46yWyyRChvE5fTS+1vS0iAFcrzH2nosss7RbJwjimYKfPacUigMxsSwApaqu9bj3B2
	xJwIw2ei1TMAjkKP/fcAL6RfjqxllUt4nebrwbUGfND3OfrT0lRwE5HjKyZ5eHKWIMqwDWG2nWF
	b5pWU9dpNU=
X-Received: by 2002:a05:6830:2a89:b0:800:2de3:45ab with SMTP id 46e09a7af769-80897893ba3mr812039a34.8.1789373646965;
        Mon, 14 Sep 2026 01:14:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.242.243.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-807ba3acfe4sm2520899a34.23.2026.09.14.01.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:14:06 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1789368148.git.tanggeliang@kylinos.cn>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH 0/2] Drop redundant tcp_rate_check_app_limited calls
Message-ID: <638aee3b-59f3-b6d1-691f-8809f7ed9736@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:14:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/34818072039

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0add685232=
c4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1164231


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
