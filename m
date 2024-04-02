Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2F76996A
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058218; cv=none; b=Fr0kZ7Z2/5ZhIP1vG4/uIpRfXSooSlBv1PIIQLM67Q/IayqLJ0SDkxYlAP2FupWm6Y0YBtpxMGCTEnohzjzfYAL5dpob29FuTPJJl/AkKZGaSH3m84kdkv4kH3MWF9DiiVeyfGJGhbCaq1RSQkbtUh38JK1U1b+dyxtdPkNX+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058218; c=relaxed/simple;
	bh=dF6EcsCFu+gU98enWH29onF4Il9KY3Jh9gSIUBd+xFs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OZIj4//AJmOJTpSIekWlYn12tQsdQJViKTLnsGxfgjoonU2wrE2ggJ3we0rTnaAUX2FLv0WeU/vWZecuxjlJHLJZ8gme94Kgo+jzDWUVB4hKl/0uVqJGPDRuCKto5RmxflxrGM0gtqV7NACharPsIjhRQEN+ueIRC5JOH+erG/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1fmFl+1; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1fmFl+1"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-221e1910c3bso3108633fac.1
        for <mptcp@lists.linux.dev>; Tue, 02 Apr 2024 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712058216; x=1712663016; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjmBvYHPDqpd0ZB2NVdJbKqjSI/yX5KD9oQNW53Vtwo=;
        b=k1fmFl+1qO6ljmlxhGnRuu498v2S5/2m2DyrPr7vP3fieQx/mOJOGcJeR8WEbC8bXk
         cLm0L24qiq2zJyKL61DsaWfzCveZb0+B5lOYrm7aUd0ox2H/jemdE7ULrp9cuAavZpoM
         wVRRYj6+QtJjkguRpBM1vDKamfi8+ZbsbwO4xFV7IpUQLkfeIIOs/FFSKGVE2WcIh/KQ
         +kr3VKmRCguss8xvVmzXXiY5sSAYjnrMwaRO/wrIL8we+OS/4ReCz+Td4vZ/obxiuqXq
         +9GvwjixsrompIEPfm2+IV3y2CuPUeUB8sMxV3oHwWhh8pevw7KPz4u/AAdU7OHRptX0
         4kmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712058216; x=1712663016;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjmBvYHPDqpd0ZB2NVdJbKqjSI/yX5KD9oQNW53Vtwo=;
        b=vA1n7tigX6xuSm+qGTlTe2LPMkSZL5JiPLhbyDkYGGcYGkSlTmiMua/BMrwWMckT84
         awyEmh8tf1ZnegGvmclWK++QYgosv7B8HdB0ZXQutxmga0ThkCR/08WOQmo5irlGQTeU
         M0jiR2NCdP5+/Wc4jddq0lJLOWxLjer8MTI5NIF+dHd12QNah3A4aFepnLnWloLKw5gS
         CfAt3tJUed65e51C7uEAgpY8kKvm0RumW/5hLmUsZy6B+tyIjjoU5fQK6ati6u1QPJwY
         PEvwz9T4lDW2LCAB6lIIv3cVoYlbP1O4vCcPCIoxNmKKll90CuggLgSG8yRZOUPgQWy0
         9laQ==
X-Gm-Message-State: AOJu0YzADoMZZs/6VnhOyGZO1ofwK0rszK2gsZc6wSGjvK/r5JwM/pB5
	w9QEX7ntXhlJWxKQn9TpdacGLL34DMF/qLjREn8IGumd1IltMjntM6GJA98=
X-Google-Smtp-Source: AGHT+IFRjpprxAC4SM9seHDtoD3osEaeHDHuYTtCJuU7eWEg/KOgXWE8VPmawm1LzsbwvVMrJcfyxg==
X-Received: by 2002:a05:6870:51b:b0:22e:6973:f8ca with SMTP id j27-20020a056870051b00b0022e6973f8camr2256445oao.0.1712058216364;
        Tue, 02 Apr 2024 04:43:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.69.162])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b006e795082439sm9582644pfa.25.2024.04.02.04.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 04:43:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn>
References:
 <8987e2938e15e8ec390b85b5dcbee704751359dc.1712054986.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add pid limit for mptcpify
 prog
Message-ID: <ddeab7b0-dd68-230d-537e-3b23f736427a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 11:43:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_fastopen =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/852176=
5619

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b907465ec479
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D840571


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
