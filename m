Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940083;
	b=r+lu2oFIJjiqscCVLpiJ+GH4xXRkd39uOdlThN654FVV8zGKNBesjuk5JNNCL48VjChY
	 J4NXvCLzhg77tmUeYH5wBd76YZS5fF9uDSz+yi1uRPE7CI6FD9sKFA24w+Lj6K+UwQZOH
	 B4XsIJg3JVZdXP+3DbFZDn1UzQUPv28DT76lnZvnUUWhIdwmOdUU32VqcEJZSvxG3yBKG
	 Fwh8U7+hao/aSq8qPURA08TNbV9t/8iISqZ5rPKHeVp+YB3HwF/pRZP3Fhsc3gWL8mUxc
	 DdRah0+TICNpLx1bFnwCVk3hmsj7fdcxa/YUJoIp0+3eQu07BdiYogFR4qrxHA6CKTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=LPd1R5sQq1Wmdqb/BhEs16Nl9eG2A9tDNFnEOqgZLF4=;
	b=SJSVn1584eI6UP5p0tlM0oApN6Pi0GS7YPPioVLUAwjWXXKJlk9zEvQNr2IefGXp0Wsa
	 Fuhe4M7MSEhPUaiYikiFj7dveKI9DeM3z+9218VZgF3zXNlMcevrp8bj/7LwFLu2fSk/N
	 +GSpe8VPJtNL/qP2HN78/Vm2Jq83aA3G7lR90sN71Tv5xjNAoyGsVRaS5SZSylgC4PRXU
	 FZnjbedkFotUbLGHSFxHBfD9l1rYGG7rrvzf6U/0XV0KVLYapB8dvs2cwgcBiYcszyLBp
	 1jTin9iJvezXwdTmsbRDomISIO50MKcn8zmk8N0ffWgeLRRLXgN6Hs2HTEeQil5fyng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TUDHQ+yW;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78132606A31F
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 14:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78132606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TUDHQ+yW
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6de2f213b7aso973106eaf.0
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792940082; x=1793544882; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LPd1R5sQq1Wmdqb/BhEs16Nl9eG2A9tDNFnEOqgZLF4=;
        b=TUDHQ+yW7riZU12mQLt0MYdj6aoCe+1fkP7LLo0kYCC8vczFLz8z7eqiq8LKgCGYYo
         Dme+EIpLJRyla9TiB7h2k+HLnBooHEFabstTfi8Lf+DcZ02AJFJugs6MvR7umLv5sgPR
         rKLJYXkrQXnqBeiBptCyn5/8Bik6TkCIcLHGzZHCtNGxHqFuJeSgk3DokUoCRIo7y4rD
         V1AMF4dJAOywWn4QycJYYy+nKvcdaS7dSOu5hVAIHEJAuygnP82PtXEQFgoXXmirbJ3e
         BuurW54uL8QuXCAnp55Q2C1AynLVT2Ni+eVU0tiEu0i+FuOkz9F5+fcZGllSysoux+dZ
         Az2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792940082; x=1793544882;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LPd1R5sQq1Wmdqb/BhEs16Nl9eG2A9tDNFnEOqgZLF4=;
        b=tVNmaXaZxlPUsewKeZo6Gl3sUellD17vDcGP7nj9jHVHxZlBWOOUnnKoP6L7eZ/+nm
         6nmtRYdUoTJuI+J/sPqitEIMWUxRwJJ0IiWVJg6DHVRaQjS8gDAFEHUxsexSWgS29Y5J
         6AOgT0wirHUPu1obuQV0SqUzTmHfamnXdJpM9GpAh1MhpCDHTJKsBPyokmwlEPk2++xk
         JekEvH4AIj0Y9dqGGZaWTeNdXuzj6w5nGrB5mT1FsawNbPNEJ5v+egJ3hEvAtsamDZ1A
         zsVEIYqIiU7pC0tgZUM4YAkhem0G/PwpWBnF+K2w7F7Nf2zJ36Vp8lfzFYUvMNPQ8gBM
         0GvQ==
X-Gm-Message-State: AFq9FYIjCJUEnVbKCMpGFGvwYK69S3w+LbAgTD1/tg1A6uIF2GhxqX68
	GvRZBShnyqvExbvF9oKapPqpPyR72S5+uU/K+4hWc850CDXtg6wtU4o=
X-Gm-Gg: AYBFou1qgSgnX561F+waRWbtzEA11uZiFdQUxrm5KwKX/FAGLDAs1omwnh2tasYpkPJ
	Az3ghmbmVKp7FhT7na0D9mreRhixWmSmsu9BAtHN2pkcjTFVJOHgNm3uJarvfNhpu2sTSwsec52
	64Y9g32PxgPiq7/oSEzPFSuf9cKafn5y+QFEctTxSMKlwcz/WyS8hh898JV2SW0HgEgVBauu2xM
	j66FIFCm9zmtoCyy/14L6BEi0UH+YG1mTVhdxKf5HWAbhUbCyg7xGCPYY5LdqPnQYljsBPaGvi4
	1FCgklx2ocNmdsLwgx69oKUXOxALFCE3QiXXuDKcny37WX/E6KY2Yaj/QE3K8DrgWzuyQxcf2ht
	zg+yBZ30Csx43ODtI0+0zBr4JxXEXm5MlFyIAYpz9GFGYTcDbcPiVa1b50KNH2dldxMl68dFW8H
	EaHP+vVW1aQ6eDzItSJ2Ci3d60iNd7evRdy/Uwms0sX8F8wjK+J4H9UOFo8znQs2lcB9fOwaDcZ
	KpaeNo7L1EwIaCPAoV9txd3FdEdwqlAvp54zu6zJUuyPwBA9rVujU8F60NCcLXu5YbQZvAAysM/
	/dG3paIEf3v6ZA==
X-Received: by 2002:a05:6820:f023:b0:70d:cb53:ee71 with SMTP id 006d021491bc7-70dcb54267fmr402263eaf.13.1792940082329;
        Sun, 25 Oct 2026 07:54:42 -0700 (PDT)
Received: from github.com ([52.173.162.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9da521b6sm4756319eaf.0.2026.10.25.07.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:54:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261025134643.1537069-1-w453y.me@gmail.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com>
Subject: Re: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on
 an idle subflow
Message-ID: <451da49a-47f6-9060-3402-924dcd6f883e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 14:54:40 +0000
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

Hi Abdul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/402003=
88982

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/41031047963c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193018


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
