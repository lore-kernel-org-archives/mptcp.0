Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795696988;
	b=Myjwc8GqjtPGJ9o63cQZLCeOInGIoXT+ZUZtv1x1rNk5qh9vxYResq422s+3FdjhC/Bh
	 X6gHOn33J2g4eOG30C97CuqDcDgOotd/m0VKCeHgezZ13J3eS/y1KBDAWRY+KTaeBeYJj
	 rMR64FK5JTtBVdYIezpKeWmHEIB6dPN+7qiqIzzKID79r21IO6e80+FUgzQdVawCoL088
	 NNYHRqGUcRx3OO0CWtszmSzvc/EEN26dUHu79/RBTEX5ctyQzJnxbds8myNEJdszjxdmk
	 ZRc0W+Ggf1m/EbGJ9bE7Vv1Ub9ZGgZ1T1M42p6ljoQjqp4rJXVuRwh+0pTxfmOWnaSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=Gsv41a6F+cpuCQyIvFQzkLHq8ieEJQHanweMaZ3GU6c=;
	b=tKirJT673qCuYY/y9LVAdf4Jvs5qBKWSX7rrxSyypFgAdUY7pOeOD2q0dvxOKweX4W9U
	 Pfm7nU6XoRk1mX2RIHmcdvxM/lySb7hefTYOBtA1G2d5HpQNxGuEipeW2YokBKuWoARBk
	 pOdfYidJarvEkgFnwH3TVJCnzYtchfE5XSCKm4xIlemH0jdlP/5dIZMqxHMMF+l3JzglS
	 hAFDoz2WAH6rjNowemYvitV8fl9jTnfAAsy4iMVkMePrQYlCBw9yrYuMn80l6llKsTaq4
	 cdEMxMXvxEX35IXZgD9Sua4TXy/6SZVZJU3djiOm+wgLFA8SObPQ7NPRIzq7GGBJm0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfQWrZL6;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABF4606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 12:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ABF4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wfQWrZL6
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a3c08d6928so10350385c88.0
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 04:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795696987; x=1796301787; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gsv41a6F+cpuCQyIvFQzkLHq8ieEJQHanweMaZ3GU6c=;
        b=wfQWrZL6zlef38ZN7xtUdPx0fAxhJX5iC5tfXDYC30j9JckhouzOwc19iRHDt8BMgO
         Wc6DY4bxQw1LD36eZHCvchmDRmi0cDD01r8l7o0+Yzm0jaPtLnj0N/QG4r9ObL1/q0Fg
         TjR7Xw43EaCHDUcrqO0sMKi2NIFYT0vBSlO539EOpIH2kkCTQdhxMkyaSIvLg04SxDFV
         aIZXfGzyN93ojzcN5f3Ae2g6yNmsANrTGHWlTA+8jSTgM5ZbGP51lrNfJz9VIeCv8GVM
         Qe6PgHjIes6A/VBohhYQEB0VtA9cWj/0fvzY2EGHQqPy2MFzcbHoXDdpccRHCdW2oN1E
         VycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795696987; x=1796301787;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gsv41a6F+cpuCQyIvFQzkLHq8ieEJQHanweMaZ3GU6c=;
        b=sksnSdUimtYOzyk7v06trbPWt7snyXU0Sg6FX1Ggd7DWRIM6ctgzLU1IqX+6vG5ba4
         FP18EL6QE4sw5x+pUPTNOzXcHS1fyal4O9PA+FXO9zCAvU0a8qiM4Oz/i6M/VQXFUVqz
         QZvvkYKKMIX78K8oD1B1DvM7QcUmafuxBSAS71L4dzTH8tUIJIpq0cHUAv0L1EAp6h2Q
         gx+BUrUrQ6ABA6NHnu1dm8YYdYu2+saQc7eNNQELzoyOKgtKetLVSPM72jGCno4tw7fc
         X87Lo8PRB9wiAXmrDSuW/uchKHaAibc+elBaAPkp3+KHMdvewt38rjcRzF2oeXj48nqV
         wFnA==
X-Gm-Message-State: APuU4Z/kLMWbifCbbX39W52Ui4gcW3tNFyuHsmxXV83WiPgignsxfCpW
	utqUwBiugC8v+EtU6rzYJcHD2SAz6irMf5o9PvrVVxlaOpPfAcSejfE=
X-Gm-Gg: AZFdTZcmvXOExBbPV9nXQ5a+mRFh1fGhViUSxEAI0W+DenmFH2L133gr3qPuJwbS5eQ
	e/Cd1KY3SJYJZO84IKY8yXc3sG++xhsQTAlyGmZIykYwwI9IVBhqrBCOdHMnNjVKiORek6Qz/zp
	6dA+v5z49HnthBUsCThloXZ6HBiGV/YxYm0dpNMlXEvZLRfnrQGQBANNjrMrf9wr5bsCLKIn6WE
	BTx0TP1fQL39EiFDRWX7OiFjrOZCndHFLOc+Oi2ZjcQc9wN8b5Msr1bjVTloAcXNb/jdkXpdXLu
	PiycaHnwImhLsQr1cCMckrQsPvMjBX0/CBwxjxa1YweKXL4kIkzBuzmfa5j+OLO868tjTltrAWw
	daxC4DJ/ffRjKhPrgndFTFWGCNAdhVbgMvmHhVIAK8B4k+kMxlHonqvGLmuvIqeEG54IdEijsNL
	xK2848DxwDBDmsmutxl9pouNGyq6J1ovZjRAWQvL3oLtqc4Rjms9kTzlNZEOnoREMhc0HKTZyIh
	2TOaCv/GYDgLafDhx0Nmf7YJyirzNIUqjd1fndmnenxajgqBgVFdP04tF2nSnXCjxF09byOW+tk
	PsrFtKwTcOudBzrtPl3tILJUmkiffIg/+ogfRaBJ
X-Received: by 2002:a05:693c:8803:20b0:386:9b9c:ef1b with SMTP id 5a478bee46e88-3869b9cf99amr15903449eec.3.1795696987027;
        Thu, 26 Nov 2026 04:43:07 -0800 (PST)
Received: from github.com ([20.168.139.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm78162336eec.11.2026.11.26.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:43:06 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261126101818.3916631-1-w453y.me@gmail.com>
References: <20261126101818.3916631-1-w453y.me@gmail.com>
Subject: Re: [PATCH mptcp-net v9 0/2] mptcp: pm: in-kernel: fullmesh:
 re-add of the initial subflow endp
Message-ID: <94763821-5f89-dd8f-4e9b-861d4b73b591@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 12:43:05 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 6 failed test(s): error:sched-mem-pressure =
regression:sched-clientlim regression:sched-rmem(4) =
regression:sched-serverlim(2) regression:sched-weak-secondary(6) =
validation:sched-loss =E2=9A=A0=EF=B8=8F  (3 improvements, 93 new outliers =
to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/45804549509

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/789e9a53d013
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1223221


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
