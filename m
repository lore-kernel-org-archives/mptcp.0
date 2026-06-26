Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB33E1D05
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482291; cv=none; b=r0jA9m8N5ynRptR3rSvW/oZaGXv1Ey67W66dPw2596HPFCN0ps1ZmOXwTpVuNTXHQVvhsHxZfBMgyLlv1jrSbMZyHblBfSFjHaxBffO0lDn1/1g9XfR5R6QS4Z+Qkk1jxhq0VRNBN47afMOS63SVi7Qf0MWzYS7aXF1OoxATq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482291; c=relaxed/simple;
	bh=/QomP4eagjH/iSS3qZRzeZ/Gc5S+NS5b/gOWPUiuEak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NlFCA77qSRvPPiuv27u8r/r/tB5VtKzbNAEKRMtG/UYQLMpyBj0snZQ3UrMFx9ZBCKahLn0jttxbVh2IbwRFq0lEIBSKoMghHur0j64z1UFROaIciuQHkgGrAToxq5MdIbyRPtmZEgBe7n1OsIkDmXBoJj+BhOM9BJ+l6lbX68I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxFc+egT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxFc+egT"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1214350188so108335966b.0
        for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482288; x=1783087088; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NRxxD3YYytAkAhkHXt4tLU1/oHSdIhBEVxIxnwFN5Y=;
        b=CxFc+egToCpw6mFZyTltrA6BqfxQleu+qccRRcvw46NdqWRqFadh8YAUaDpnJSu2AE
         ke6CtW200/06liXFvE64T9mxuS6qDckUCCZFOy0jNrlmy6z1vRJ6EBrztDa/2d8KFZom
         3Il6Cl18ZxwN97ykrWW2PEUV9ExH+SKnpsZk4U7/LDOMwR/kBwZgWcp435SGlfVnxITE
         lZLTA/geExr3quQrCiJIiOviBPg7OSqGK+PAN1fRC3VPrgNZj61Nb9ZczKXI0vQDaroJ
         j7sN1fpOsXHklWXU9qYn+vSAliK/GJfF1mupGI8AOZF31bfR3+ExIE84uTUhiwkiZhAM
         UVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482288; x=1783087088;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NRxxD3YYytAkAhkHXt4tLU1/oHSdIhBEVxIxnwFN5Y=;
        b=RX9inTpJ0pyUUdIKg5xWtdQywDDdWYEEZ04d7jueR3tBSeRZhn29/tFTvRl5wmd0jW
         sh8zf+3UMohcFXMMeRt8xoDB2UkPbJLnUI8YoE4sgg9VJdK/O5BWmN8sRQ/+GhWi5l+W
         uni9XeMBuUUkD045Js43h1NrNB2QJaV4EHMPi0x4F2pAHP1jzjRWp4yokVyR/2yDtl5O
         0mZlTEkNkkXWnQrA8E7mcQvFAmPxhLIigWvjMMGFxKS8w5pVIRHGufBqTP/flJqbegE8
         KrsDnOTtB1EUmJETPAVa1bN6gQhyvYc/haeSqEL7bmdQARuAcUBT2XsJNFQajmXjR5a2
         UiPw==
X-Gm-Message-State: AOJu0YywHiR+HPRGrngCcfKjTi5i+X1eeCflJm4lEAc1e7moJ+fzGBoq
	CrBtUpJSCdSv0bkU/VUytpBgZ93iBt38foSYX/KIk+Rg4lI4FiwwE54=
X-Gm-Gg: AfdE7clLSgmQukudymJjFKQEAx1ji/i0OGUyZMVbPkPL2G47gwuQNv/hcEOCumO7g7N
	PeV4BKCtBt83OKnSJM/7C9XTrV8a7NkiV22Hi8SBHLuXjP8lDrGPpZRrCuREBpaA2y3NOdout0I
	xn+oaV+UnsiQBrpt+RJ1qcMnjK583GFD1pT73x+CP8AydCBO6B8ejC+6/1n4FGluT4xKHKajKYD
	nWUaTlA/ByZtjCf2yWxCiPtED1epvO2YMOclIIAfRYDUiot1nI9au5Ms6S4pXaQuLEteRo9l7RI
	CpIdghbtGdxLP7PB8FRNi5aFD8q0iyxY587VLx9b46FGEFZpGnS9XR3TJA6V1QsozgPTmyyCcMZ
	4KlWfnrr0OoCAeWjSGzMcAFCI3oXWFvTEfcX6bKpf/dNW3Yhdx2BLKLZpwvST/GF7kDYumGNMj4
	NUHQpW0Ea/NLBIBl+GkbX/BY0msg==
X-Received: by 2002:a17:907:d5a2:b0:c12:1992:2caa with SMTP id a640c23a62f3a-c1219923919mr282259766b.4.1782482288036;
        Fri, 26 Jun 2026 06:58:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.160.166.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f46e15besm2821656a12.15.2026.06.26.06.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:58:07 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260626125058.868855-1-kalpan.jani@mpiricsoftware.com>
References: <20260626125058.868855-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: bpf: fix NULL deref and UAF in
 bpf_mptcp_sock_from_subflow()
Message-ID: <dacd8d71-19df-dbf4-9001-954027e6e92f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:58:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/282402=
66592

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/712483977074
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1117109


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
