Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com [74.125.230.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5670A327C08
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 03:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790739467; cv=none; b=tVJcXM776KAiPBZSBEFhoYV5sOmN/98cqfq0ys/1RVRLKmlIpOFuA+PvcKGPBeC15zORtxypaqQ8RUKO8ZPYs+SmmZ9Oi2Xa/Wz1iG4b4t2nZxyCZgR7sVh5syxAlkyt+xuo3Bg9s4xAFnv56NILdOOTvFiupJtg82XLKshaKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790739467; c=relaxed/simple;
	bh=hLF5pin+p8Qy3S5qPL7uH4WeE6Ewv0Vv/u1Af5gSwas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=tHyanZTlDTYVCpRV/hgDyEbluB4CfB7LOEaX7fTAzZw66IFe0p/SsqpvxY2f+i9hlCNun949lRVG8Nv82EvxN1YjCcX9r0orGs8N9SZaAeh0YoK9rZAi2rdUwDnituAS3dOQp6TMxHSmdzuhPeWAELDJfEziykADbsec+WdnI+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZJSgK8f; arc=none smtp.client-ip=74.125.230.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZJSgK8f"
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91782711448so14823546d6.2
        for <mptcp@lists.linux.dev>; Tue, 29 Sep 2026 20:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790739465; x=1791344265; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gBf0NxxCfHxC5ZoHNNTohli9GUWmAeS/lLjH2Co7q9Q=;
        b=cZJSgK8fxGN/JNqOYU4AH81jTt2Z9Pkv7vqQrXSBXNk8KBeCLtQqB8qvJxTrSHVqCm
         c80vce5lPcQU04TpnCL2bNQQY+bx6d3bOUD5fJH6KfXev2YTLPUP4bnRNUEHWY+DCDVs
         EfSUV9jiCutD36jR/S/smLlwQP4yk2Sb7fljk/k61il6+s0Ow+NlV4fVs5bX4hA4yVu4
         cfwh8kmxild8aeKN+GFtUq6V72yTQ8e2lFXtHXJAjawHshIJt4g39gkRe+MRpTA2Fk9g
         b6G8x2m5VkDkgG+6vk0edbqK8mqkle1btgf3ygYYG98sVWVcW1oPKCd/6PLx0+0lCau2
         S69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790739465; x=1791344265;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBf0NxxCfHxC5ZoHNNTohli9GUWmAeS/lLjH2Co7q9Q=;
        b=rM0v9T+Lk6mhXar5gVKONxmNKrZ9eNlqjlz3NarVpZDjlFudeHVErXaGt69oGuMZga
         6rqf3GInQh4y6oww+/faGQTbArjAfZ+uLHle4K7zEvziubQj9OQZ8BcQDP/NbfIgr4p8
         UihQzOFbfa0H5bqXsaB8cz1X51fScsHbxV2D93rvL0Zk69PC51EgrDM7yxuanoy1zN/C
         prsg/jgbXKNupwpZJHtiuDiDtitN9wk6lT61b//CsCXM/z/dRSUw/W9PD8kBS9PSmlpE
         XDZ3PLuQ2UyLE+DFS02z2GoPApFE+ap7R0WkSlfP8JzgFKxEhH7r2/X3oX79UJxVUfWJ
         UfYQ==
X-Gm-Message-State: AFq9FYKhDLal78SYxNkQU5miqZDwpo53wttczSgRvB299RILe48fYjQ3
	R0Y7GxNotSuwVTUbAW5DGIDy4pV/yqrrTaaNLDAkgjrJL7Ornq/yF2wt2aKz
X-Gm-Gg: AYBFou3D1vHEkzNEIs9sS1NmaORhzy5Mmq2rRGhIiSdvxhx5aPLmZPECpxV6QuDdkU+
	m80v050qECVFyB5BOehqKeLEa7IX74wpgSvEml06+NgKHTKr33JTMM0YLhqLDcMRP7Me5innEzL
	hLgrLIwVz4AwXIKt0Q7ImHkP/MhNWEHDNO5gYiZnVVA79+LBJ0E2Af6vTEdw+iGo/gbjFaQiVWs
	tHM0h1rsPeHCMXbL1uW90PKhws2A6654IaEXlhx1jVQe03WksZQu5TfrEbi4zhbN3PWhqCZ0tm0
	LiGU69cpM6IXL2EDEH5dxY0DouwvVYwrNQyYq0EKSHmhFGU1yYu4Bir0Bg2jxl58c0j49yVODMS
	7bTwmYfg6ZP2awVonVdgHpAPs6AOWDNcG7l3Lbkb6ExiZwIuMqMtDi49OgNmKPFJA55HQWBOBji
	UeYy/X/SWgy744ZLbwSq19bmkjSunnB4cYnU4dctpQAuHdWPUEcvbi9aVuAw8ECoHDd375OdRBj
	ocjDG5Q2A==
X-Received: by 2002:a05:6214:1314:b0:914:4e89:132e with SMTP id 6a1803df08f44-91799b46f91mr22907036d6.26.1790739465068;
        Tue, 29 Sep 2026 20:37:45 -0700 (PDT)
Received: from [127.0.0.1] ([20.94.54.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a03cff1fsm771516d6.31.2026.09.29.20.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:37:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v14 00/11] Reduce the differences between
 TCP and MPTCP for TLS usage
Message-ID: <b3fabc8c-796e-ff55-0c3c-7e2ba5670bf2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 03:37:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

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
et-next/actions/runs/36661539144

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e903b8eead=
de
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1176484


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
