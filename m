Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31E3B3C11
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560852; cv=none; b=qwZ7kIcInh2vx/8qlwuyT13M0FXOY1u3P7INbBVvi1T/waSps4i1/hBj45YbsyY1Umswu7t8ipxv+XsvAVlj6w3Wik4vR9G9aAdw68k2QvZbfVViKwp+1DNP7j6Z6BfgvD0WS30RRIzwffGQB9rT5cGAZPGN/hVuV06uhKqiyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560852; c=relaxed/simple;
	bh=twmZNAEN0TTe5vonqaKlxVhi/rfz5PESUS7SEDMw2bI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Yjt3z88lxWBDHmbErDJeL3HzJonyihdrve/n2Q1RvSP16RcLGRMxW2XYW3yzQPuhEPhf/4RgpcwYkvDJbzlHBwD6lJn8ct/pLSwfXa3sk3VYyeoJO652K4dRShwydCfxQAsBuRONBDSDGvzo8e8oQzFM1ZaVlmLtNfTiGvAvCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IukXBEhL; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IukXBEhL"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ee125ec926so3477646a34.2
        for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 01:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787560848; x=1788165648; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ono/WrCo8jFPr3BO4iPfzCqeoK4W/UKSip1WPDl513M=;
        b=IukXBEhLiQW8za17nscw5N/lh8sRzhb+mYYOQw9tvvt5SidLIYnh+8IFaxz5mXM4+c
         uP9C4Q7gm8YbnYa1LGKxM3HFu+dcS3WDFVe1ufpqogzntTg3/uAUfVkJcGi0gatm1AN/
         /Py0a+AXu++uc3vgf2hMKsCI8evVqqrBitTe8Umfv6HBJKcg78FqnwMK0UPgOB5KuzK+
         m3WKHVFt7/O+cWRJ18gN7D0noOldHOCPfIgt8NP/JEfFj2RS0J2OQatrljjW3alDTRcF
         ZFEmMPciLmFXNblk/E5ESqywKcOSKIX2iohLiO8+arsNv+9xH4HccLO/U4ES5Pi+seuV
         xYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787560848; x=1788165648;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ono/WrCo8jFPr3BO4iPfzCqeoK4W/UKSip1WPDl513M=;
        b=BVHh6fxz4CSVyhRPixrcgxrkb6WE2THl6qwMna86WHFPlpXNJrOZIUTHFdp/bpO4DP
         aStyfO1mogLz3e91bOAPKjkXcIuKaifx4JTv5fovgr+JJePq9vYpWgZoBM6yHALvAGVz
         hB6IMHa0iUrQxWr9l1+/iVqKYjmP+cHoVwWPLUx7JNSPt42cIejD9CLtCGrg3MkgBDW5
         VEgJFbeRMb7qSh3VXSSSPYLWQ5Np9UysSBhfqQN94ST8WuQovDM2+sBVjmn6brRngSPj
         CswVidC8iN/C0yc3EKD86tOoEXO82/c1prxBh2mur9qOwRw9NH7balVk9GOSm0f9x+/f
         0q0w==
X-Gm-Message-State: AFuF++lANjbS1ekcoJNE41udogS6BMrlk3Ihy/sRRiC0xzsGqHAtAP2w
	kIfhIvXUXZM0gmRAdBmEv4C2N3Gq05v49eWyeAJ1el+RVh9wbA/5qRnK5cZL
X-Gm-Gg: AR+sD10wWR6Bc4yme+sdZ3zbQiHuUedr1Eiknr9g1YmhmBL0FfivZhoxfbBgjgXFk78
	5VXIyCXt/q6ceJpU3qWNkcZoao53DhupMDhsimjkBD1cYUFGxrBQS5KFm5MR6JrF2i/shz7bEK2
	7/R8phWjfNq25rAFUZ9VAZMZi6BIHAUo9rJLeSGnODRutZgIiOWI6bJ5eWKeAkZm7uPkqSXq3rr
	C93qQ6ZjENotO/+8L9nDfOaL+pIGNrKsW8JSIsAvUqSU9pYUmv3Jyn+TFpPvKlO0y7hj7rTySxy
	VyhfiC++kdHIaQT67ucVyIVtQIqNMD3PRv2a258JojbsG/ZS9MEQmFN0naxbe6SfjQ6+9Se08Db
	kVyxfiTT3aKZTNkb7sHP7YWd5b0hkW1X2SbNw735+cPn9wTeo3z3hP6FEhkPfffnuvRPFlMJfMV
	pyjAaBY4/PSgeqRP7KFnJO13luigcSUQY1hzX2tJEGS2zEXCxKPracSKAY5NYaiotTK83jAmJ0c
	wZOnqCDv00=
X-Received: by 2002:a4a:ee06:0:b0:6aa:dde4:6468 with SMTP id 006d021491bc7-6b159378bd8mr21557085eaf.19.1787560848436;
        Mon, 24 Aug 2026 01:40:48 -0700 (PDT)
Received: from [127.0.0.1] ([20.29.37.164])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b17c8328c2sm3320139eaf.4.2026.08.24.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 01:40:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v4 0/5] implement psock_update_sk_prot
Message-ID: <3828511a-7a21-0dbe-7b80-e102885da329@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:40:46 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/327019=
57766

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e4b106e7b0f4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1150669


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
