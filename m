Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C28435E1A3
	for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765359; cv=none; b=vB0MGvB5B6lGLUpVFWSMkz4IazKIaRM0pUEcu2ND1xpJ02MYUKEuAY33/NRRD5HbDNNldNYNzvK9VKVVUn1s5urrZl1KcUyHmaCnRTM26RyiQ/gODVsjAQPmTUciOtM8LYmGZQpgGcf96P1eg2ME0rpnivflT/6xIkpE42SOcgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765359; c=relaxed/simple;
	bh=s+EXsL235K8jiaqgZ3JpUCPY1342JoXFIhn0zMqNuF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IIzExN1volYUP11yLJD7qjEPFI2Cehyzg5L8vdkJxSxl/Ct+9PHpZVmxd3VHrjcMejL8qxy0SzglGYH3fg6sU3F9DJZ+3iF+tXL54iqkEtFhwIDfXvfDpBD/nJ9VtPT7Y9vAL8oOFyWFbWecJw7osTXuat3/Ua9ImwiT6nAQ9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ee5kW2uu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee5kW2uu"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8548db7428aso334694b3a.1
        for <mptcp@lists.linux.dev>; Wed, 26 Aug 2026 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787765345; x=1788370145; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=udE3IjqOqxKT46s/D8KV8GhrnNFZ6/VukEsY6DommNU=;
        b=ee5kW2uu0f0HJt3b23wSzodJ/Q4eT7i1UVbQOBStdbkqEAD8S4/20UXZ4iNkQBHOPR
         jDzVTHeUR6tCzbL8QSsz5YtEY+s2dnfABtEc4mSrZ1g8fABDVRlfswMJVd/T/c09c6lQ
         lFFE2LMR6fB4wNOeTdxQv2wXTpKC6hzKxwoFUyGaGSVXxuiHAVWZNVCUgn/jnpWityQb
         e8hRJQj14KRbdWfz5DPkYy6+Y/1dOdwRacaQwnCS1MtDsBknTYy8QdGDU78TW513yh7e
         6G9/MzkesTed9ZsFJ8pApZuInqeLg8ff4LHaDDWS7V59J7FOJ7niiwgTz5Mtk97oqaqy
         iWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787765345; x=1788370145;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udE3IjqOqxKT46s/D8KV8GhrnNFZ6/VukEsY6DommNU=;
        b=qwgg6OL3pscuRB9CRq2eIR8eB6eqj4HCSEUTzNIhlV5Jwsa1N2Ic6RqjoZFNn8Huj1
         3SFlWDoQavYRDCu7m/K8Pj8Xi1oaIvmXy9GKmC7eNZw5FBd/0f056+gwHvw8tBFyBuVP
         T6Ei7fNMtR5GV7v0QKig9syzqCHkR6+gPUDfjK+NIj9NghP1bWruooP6UXK6xirBWBVf
         bEx7V4cjgfui3xkr/iImsRvpi4KD68qbLHSjxLXh4ZwjGgAyvBooplcN2n9H1tNP6Djw
         X6nZgEDQXnP03ZX12ss9p8HyGxfsOaRW27RHChAnB5hHhLQOwqhQueKw7AGWQS9dSLFI
         fU7w==
X-Gm-Message-State: AFuF++nOPQywuzkfNkgL/oKMbQ3ytYYY6e6vpSG4oomyEUXrLRZ2HYIe
	5toYHj5DR9of6lrq4h+tGBbuwGV80409lH1NrT/T3JwtWj67cbyn62EBxFtQ
X-Gm-Gg: AR+sD10sxoDrdWmd1NvuTG1LYRJ6b2N6Ni5CIcKjsroMHj3+eHadFhOe4XzbLeohdN6
	Nu8HJMV0t8QQwc42KlwlgMuGw8kcrleVsZ0irpaYJaPTNfRMFpZ+W5DSi6XJes0RnPZmAfWu/gQ
	vylsL8+6v/5r6Mo95hbVHV8yvBTgk5Fl4b0SV31bQQ/ECvIYcC1suigQy3P+9KaMziTSToCLPcz
	hI3HfUFXpI0eSq62O9VgXO+YDgC553ftR945CRAW0eSS7Kx0Bi0x3WjT77l+AGAqWWd5ll6MEYY
	qwOk/P3bqahVXj6TPcodE22l7rpOJxkys3Ccp52pkvCiubfVsZavQVEGQZeWm3Iqi3sDEyjlPPx
	Zng4uiM/bCWy8BaCHPi5rz94usf8opAIlfAbnehNfbtaOl80pDySpHOdKG3u6i7F0ZY5Df6Pge3
	Svb7DSgiukTjVi4c3OU4IZtpgJBEiZFHgIyocrBOMylF1OwHmJ/bd36yarxrJE2IWTrWMmr9e0
X-Received: by 2002:a05:6a00:6c83:b0:851:92fe:504b with SMTP id d2e1a72fcca58-85372faee4amr3652793b3a.7.1787765345403;
        Wed, 26 Aug 2026 10:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([4.246.117.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535a8b8bcesm1242190b3a.19.2026.08.26.10.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:29:04 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787760635.git.pabeni@redhat.com>
References: <cover.1787760635.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: more cleanups
Message-ID: <790ba958-f470-cb9f-efea-285f7879fe31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:29:04 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 3 failed =
test(s): selftest_mptcp_connect selftest_mptcp_connect_mmap =
selftest_mptcp_connect_sendfile =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): selftest_mptcp_connect_mmap selftest_mptcp_connect_sendfile =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/32989862258

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/be657f63f44f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152178


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
