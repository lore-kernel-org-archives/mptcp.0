Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733A2C08CF
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271093; cv=none; b=RqxW4s+8cBwrESZvOzwL2mpT6293bQTR8JaSvKPdAGWG2pyuWUxAG1M3onkeU3AK2NwsqZwtGD1IgGKgQK6ausz5sh9XWyZ27zkQ0mY1bMVm4qSGlsDzHLD5w36HN94yQlmLDCOCeFn8JS2NM9I65y6enwJuuxvMxBrZkKUzAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271093; c=relaxed/simple;
	bh=ldxilzk/OSJHCkVe7lGBcfCTbtnJncxJmZiZ9LmaUwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=TZixjgGbF/c16vJioTLGMn18rFv2N89Vb4XmEPvNcv5Ehoi//Tt9ztAnheb1Zk1eO4/AVQqczHiuXQsDqp/Mijg0tWLrQuIrL/kRs5z+0yq6eej1NqBU4mRTC3wjUp80dopeuQGpheCU8jPTMiXKlGrQlc03h69PAPoiJkQEj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oI2/eFir; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI2/eFir"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4b21f09ec76so540102b6e.0
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788271091; x=1788875891; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SbefZNwZaE69oCnMrjIHq2SBvDm2AGxGYP0IaWv4n4g=;
        b=oI2/eFir3CG//Gb7BK4F6pcysIm7ukiX0wnwNiZk8lB+6opstL2NAw5WtzlSeOMgxn
         LWUCWghlpMkV/VUoid2+qIfLNcA1CziMjDmY66n/KCL4vQXLKSO8PlFZry2tWo4ZVAHx
         dimbYI1mgjMJ+YbU6rTB5BH52fcimHKoyLyssvgB/m5GK0aqcjfD2TazaSX9nrkevpsS
         0pdEQbWSSkB9jJRJEheRsiBTUgNRAd4N4FL2mxK2X/KLXjFSXkWCZuP7pDUfB4x8IoLt
         3mWCbkwwSYQPRr/6d0sbjD+4DJCKGbsOIV8esvqHRLIQuqCgaFC6Lmsen+k8NMiQSxeM
         4jhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788271091; x=1788875891;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SbefZNwZaE69oCnMrjIHq2SBvDm2AGxGYP0IaWv4n4g=;
        b=LFIh2SP1Mb/HhsDXXYGinEHNYG4vc4CdfBVRCAW+jdq8bDtAs3GBKsVSaGbj12TRXE
         sI2hgXDPEN+eGo31LLlINpH2IQtQxWF2YAs1R/0cHrG0e4eT9GxyuNGsBwGp7xc06TN9
         QVib8oH7VDmy+Oiis0snmJe9bpfl8FxYQQDA05Uayr9oRtHF1/9qxbsrXkgC5aa/7fN+
         ymuQrz2p2jtuo2awhCUvzAjCUnqBt12J0mzPl1IDb1L5X3sTw6pk655+PHB/wgio12SR
         /Q+Xu1KJNu9WvCvkL7G9yRBCFmKXaNslMNlbX2JsT1DxcZHRHMyzEsVzhHoqJP39psZl
         eP4w==
X-Gm-Message-State: AFuF++mFPcPOEqg9yC4O6U3y331Y+TSVWkYPLqZ8KnR1XSOMhoAFmuqJ
	jCYSFuYynGhl1CkilUQNsrIcfq3Unhpov/qchDv9jibTrfdTsYj+TPyKBZOW
X-Gm-Gg: AR+sD10i+ansdto44xZcIDoN+XL+ZgUKHHO61PVvbTh9hKxkl2Gb+rWWGnwdRebu072
	siF4CeVQVE7YJ4qATIdZ3fBhZDXgCtOvq07S8TIaqrRK5YB5gEA6pbtCHj2JG5Fzbf7t0VF+hi2
	iIu8PR2rUmSRWkFTDmd2qkUWimhu4fF3zLJHriB1IZgSfx5+t8yR9+r7YYvjmo6S/Ufl8jut0lx
	B6rMSQ3keT5+qygIgqMOLNiUZX+KTKxX/dyl7z5OWeQ3DrHM2m996zIaWpwEI/iBcnT/X3zKXAU
	0YQotWjENqzB9OuwuHZfRkUQa7bTtabnK5o6qEIkFe3s9ecnk1blN5RJVWhjLpiBPI/KbeRh5nc
	AwJPULKYLFerxcBDeLQaLhAZAdOHtcztFyFHQIb8k5Ug1/5H6D1XvryRsBQ3CBAaMXZUYy7+sHs
	Mw4lnXdomY2VMnF8BlFHqrPW6Ar5/nVE4SaRSHT8zG3g9D/zFEd+yhRUkYqUFaykLphgk5RWdhV
	A==
X-Received: by 2002:a05:6808:16a7:b0:4ae:f5be:fe30 with SMTP id 5614622812f47-4b3983262abmr31483010b6e.18.1788271090510;
        Tue, 01 Sep 2026 06:58:10 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.37])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a1625a1asm11236898b6e.2.2026.09.01.06.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:58:09 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1788248601.git.zihanx@nebusec.ai>
References: <cover.1788248601.git.zihanx@nebusec.ai>
Subject: Re: [PATCH net v2 0/2] tcp: diag: bound bucket lock hold in diag
 dump paths
Message-ID: <ee35d95a-2bbc-131d-dc30-d2973bbd7213@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:58:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Zihan,

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
runs/33511506538

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7e9e4886e6d2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155342


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
