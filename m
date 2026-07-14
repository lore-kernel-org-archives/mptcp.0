Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A7D3EC2EF
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022867; cv=none; b=t0mTMnSFjMPG0isPKVNx4FmJHmr1kdVSoirndLujucNv9/9+Ej3bb3u4R/6Pgci1qNwya3eynROeMEZKL8dAxGfIP9Fumoyi0vH/7rsZN/nM4cKOj1MbMiIKEVHitP5RTWI9JFeRRVAG51+LRU4za+kzH0e6T/pwhLTbdql7wUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022867; c=relaxed/simple;
	bh=sXUmEUQgOe5wXyR8NF72VkHcIPeHfrAUVhbZYSqvxqk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=AYEjvVw0sWgRRUGrXr/bk5zRPFQT65gmQqsHjGvlYFKQ7E5EjFnl9j4MUSSOyz4OZ10UwQDMT69zN4IpvjOGqBP99emEuL4Mu4HnEINQeFJLIQOuuLal+gskoD+Bux3of7rl1ifQ9NDcTqhT0FqMTDiH4ecknVcxJgcfNdEpHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+lPOuTK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+lPOuTK"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso2766129a12.0
        for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784022863; x=1784627663; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pwSJIg9MVGZ1scGi75YhBfm3905NWOnL7AkFrEFm6KA=;
        b=K+lPOuTKiVgROtIBua67xofF7ab6RD3LG0PiDASfnH0dJgtvD+ZDDgKHlEo9ZDND80
         bXaSqAS6B89Dduw57mV1agIlzzE56FdWHpX7D8NzLtBOUtjubdkoHaDg8yAwco3Xaqc1
         ne1E658QEigeA4AjzDP3vcdm3tLIZz8cwS5qaUR2NELTcjgwhI/XZ3w/4jdJKM6oPRTw
         3HUKzLtezchQoQIw89FE7qRcyUvcgaqM8qhiluAHVuWp5+hv7GpSfKs5WvWIjb1ot8aV
         0nn60ZBsufx2fl/XSIhDwPXD6hmR/bL5K9IILk8Y3MdEY4gccUQ/lZfiBcVDe9JcTrgo
         wtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784022863; x=1784627663;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pwSJIg9MVGZ1scGi75YhBfm3905NWOnL7AkFrEFm6KA=;
        b=g8XfwU5uP2LOVOX7geZUqxL545dFG6bGERtNcwsy1JWZ3CGeQ/PkwGG22ji1Ei1/2c
         4eqwKPi/LStXGWEUO81cRYsZcGvXXqtzO567BHC3GDvU6gw8yokVlP2olzaVBJ+VQx80
         ytW46rmIcUpmq7zNnayl471GUytp2ZKt1zpHafYgNX8ElGI7U333uGaIEcze1Z6ZQJF3
         sjjKWfHZTt1uVP9s08eZKpoPpvc+YnPJ/iA8/IWPtizPc4NKS4piNSX/0H+xm1P6Wg8M
         f9anRDErd/EXTBgzwevsvWuvWy1AroCj1ZPKx8DkEz14XNBTbpYaocwfobGcXSt54HS6
         4uFw==
X-Gm-Message-State: AOJu0YxZm4IuPzZv4vqy8G1VJU8i1M45/N4Q9kU4jTc3cs0Hi/KLwAb8
	hA54sDxvQfFwAVrG7+nDlUbymAzJ/aubkQAyJjBiJWrYT46J7kNWPjqoeiai
X-Gm-Gg: AfdE7cnw1G7kPTOaPDzd4scixl2le3B3BQiiZJ7b/9B42YiaHmVI13HhFOsKuDFLx4R
	vwCZPZIGEMAHS2NgvVBN1fA7ugKFv+z+dWShOMaoQ0tOJZ7AjR25/lY/C5bn2SEFWJ11JmGtTBH
	TiKLMRISJTIndZFiEPkaPbLinLsRdXObJfk6crISUlka/Kks3Rgw2Nnv4NXRZbPes0FYGy4ZqZW
	m0ksrLFiuFY3h7Kx7HNeo8YZPYinKArJoNRYD3mBsh2Oc1eDuHIUQ+o1l7RzoQUfYqQU/yAy/Np
	ATk6iaMMcipS1ZrgxXk0av5MrKbDpUgl8fASR6CewweO3mBXiXH20a3Q3kg35U2Pg4K77Gu5WJh
	2g+rdfKxu4bBmicruLMM5jp2TwFsLg7u/qq92WpgbrmD4WSf5HCF4pSBIpAuOqA/S/jN3GZ8DjS
	uNl+U50JYAClJRbrc9AQue7C9SuT7O8cx1+XVvRQ==
X-Received: by 2002:a05:6a21:7a43:b0:3c0:9c19:65b4 with SMTP id adf61e73a8af0-3c110a7b347mr14593301637.76.1784022862762;
        Tue, 14 Jul 2026 02:54:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm67495738eec.20.2026.07.14.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:54:22 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: luoqing <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260714080356.805839-1-l1138897701@163.com>
References: <20260714080356.805839-1-l1138897701@163.com>
Subject: Re: [PATCH] mptcp: pm: Fix address ID overflow when all IDs are
 exhausted
Message-ID: <dc9b3354-2da5-4d57-06ea-ee7017145793@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 09:54:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi luoqing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_pm_netlink =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal=
 (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 1 failed test(s): =
selftest_pm_netlink =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/29320601438

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7832e6717726
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1127208


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
