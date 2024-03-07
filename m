Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2912E1FE
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824025; cv=none; b=tylbB1hYXVRLgHn+/y9p5bkxjipTjLKzJVGBxffN89zucLaI+PYreBbJA10Kyzz/5vMP9RMQNRE1QMinCbl8KgH+IlU6Sp3aLgRSul+liFRlKNcv7FueasDRswoAdFhLXTh/oKOdFjEUJIas7346kpqZAHUIvLrGXckbmk2XxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824025; c=relaxed/simple;
	bh=APXIlNJfybV+zcL55fn7BvkFCRluyOsEhkJR5cgZqXU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=vBBOd7EVaxoHsqeSMzZ0IEspUe3PnpNL4sTKahM5oNZNvk+oPMaXN5sGddB3/Km37fXBwlKvLNMrLGlPPn8/gnzFTJFqymg/48CHrm16QmS72e3vpxZXd5q7SZ/9G9IUBsvm3CY6EigOuHi8Z2/S0m1f7QeI7vkiJkeN48ciEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcKEZQ8o; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcKEZQ8o"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a122d3de33so463269eaf.0
        for <mptcp@lists.linux.dev>; Thu, 07 Mar 2024 07:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709824022; x=1710428822; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zatqX/fuAEzbYtiP6JsH557fu/SckEie5zaAL+dbwE=;
        b=lcKEZQ8o36P2TrHCmMkPTLhIQ1jVc2vuGLw3FfKv07WmwBOmaSZPWTuEccEeJbVVcn
         7avIki1CCvmGPxqtfHXAqagruT7jjhE7tRgUK/GuXF22SzTcsWtqEe9fte0n9ynHHnYW
         ctvNCHgpnzPPKprsklT+EYQQkVykDxzDIFRlnEB7kq7Lt0VtUsNZ4R5whdxw/mNoU3pT
         0QTNun4i9/g89f0tcGsQJzUPoE4NFlqaBzJ+DmdrQUH+KN92NJh1/BgBX5rEcQxPfANk
         PXtOFHP2e6qVW/rwuyYH+gOiBfjp36sAP9TwRVqhSgBxaaqdYqf9JYW+Ot8h43DjcFRE
         3JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824022; x=1710428822;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zatqX/fuAEzbYtiP6JsH557fu/SckEie5zaAL+dbwE=;
        b=EZfgbHmKKFOHtMdjyAYdbA3TSYTVxhCUAHOAvLOlQXGEATHIZHtvHeSGbHlTKJYcM9
         1YtzWEGlqb1HjJ8STeH9H8moFhH6ilBynVOShUEJfM6cKHFaOCxr9zx+3GZcjzZrsjhO
         g7cufdHl3Pd5HrtA1Txy3bxc4SlhrjYdTzqFeKZNVgN7Svl1iVroC7H6lxLNFWZK9L5g
         sXJwQiDSfvIbDDZ6+yhpym19gdYMFz1PAJflAX7QcSPlHwjweVuYziDysagRvtPv7bUm
         rijvPIwH0Wan5p0MeXnk92QtOAf6846x7kgcAN+FPYp4pkvkuejjIlF0FKlpdOwarnH8
         X3zg==
X-Gm-Message-State: AOJu0YyMv0CPm/Zl/hLWLLUFEyWt5vs3sInj4VaETeFp9lkLkd4ZTQVb
	M1wJvgJgMZuf2M81syAzQ7aBucV7UXZRU97rhQENhh6RctdtMBUepXxY+UM=
X-Google-Smtp-Source: AGHT+IERM2Nud9fxbjHU1sxpjcKn7Thx0Wu7LhtxvxNH8dPfg9Rt3MH6+XzjVQeTiKbE0h+O3UE+iw==
X-Received: by 2002:a05:6358:884:b0:17b:5c97:28e7 with SMTP id m4-20020a056358088400b0017b5c9728e7mr9094637rwj.5.1709824022261;
        Thu, 07 Mar 2024 07:07:02 -0800 (PST)
Received: from [127.0.0.1] ([172.183.106.197])
        by smtp.gmail.com with ESMTPSA id f5-20020a05622a1a0500b0042f01390d5csm2860421qtb.30.2024.03.07.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:07:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
References:
 <c8bd786e0c09f4f19d518ec998a36f9fbd64e0b5.1709815545.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: join: use += operator to append strings:
 Tests Results
Message-ID: <b7feea40-7757-051e-695d-3f4a24c57520@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 15:07:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6379905680670720
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6379905680670720/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/4972530797117440
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4972530797117440/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/43ce1abbfb36


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
