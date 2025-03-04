Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA78200BBF
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087646; cv=none; b=aL6gJYHZaw8FcHiymlmNILjy5isjP+qJV3Xxb7VD+oUGrw9HnhCJls9zE2OvpTK8lDe+4ex2x1wCvNd76XuSBhHe6m5dyHx9Qk/u1X9tKd3BBqNeQHPYKu36EHMxrhhnIYzJayud4HP2XeFGYXbfaBG1kjbNQgbDTRK3SZGkeCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087646; c=relaxed/simple;
	bh=3s9mjiwlPVBCVPl5J4kuAA5S0K2KBiKJcEFeBL4nQ24=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=d9hGBmJPhPt1uxV2l8af9420hLYNt4yMbp1JaJ9l5dWFHPt77fpbaNOJ+vtj8iPh820cEFOc5mvnEuu2iZKFrDWh0h6SkCnfe2ghI7JJkQq6CWBk2QMBAKahtzKslwpMjX63GNB3vnH1f2v2i0O2SpHZt65qgXNd7OIzaPTpTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpyGDaUM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpyGDaUM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fec3176ef3so5484098a91.1
        for <mptcp@lists.linux.dev>; Tue, 04 Mar 2025 03:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741087644; x=1741692444; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K61ZaA3kksPKb7EAhsFcdN2HNQlUYpz2QxuShhW//s=;
        b=lpyGDaUMuLgFxYS78eyb/+p2sPknUupxKQHxGfUWgwZnQ42br+4D2NhQLznrwcuKME
         O1j6qKRFf5qzqDNrHqaFzygzOyHFjYj9GKXtvUgvgAieDJYC12Sq/DkskiBs+3Uqg9kc
         qaDV8dRCnbPyMpI9Tpf1cnXTWwqxMUv3tsZm4bFV1UX3UzobMU8y3RnOlzkyAQZbHlC/
         e4NecXZHnSURFLUKMaboaxSAsGAN8zXIL/lPilVpsWAs9pNqnB4U0jd0ebOtw+iMveuu
         thQ2Mak+Hae0eTlRSVQf2YjY1VOWMtts1wPmk09ra4NHSto1hmyvQrwK7yILEYegTRXQ
         Aqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087644; x=1741692444;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1K61ZaA3kksPKb7EAhsFcdN2HNQlUYpz2QxuShhW//s=;
        b=NDqFKxHNJfMfd16bILhsD07vYHHg5K/1H7Spa4ew9IWBcBsooaKr/VIMLkIv3Ndezx
         tYL8RMdIKEqSM2kFV05KBfDfSDIwURqjhHe0+Rrnmq3bpAK/XfjPPoZXaBIyI5YvBiXx
         WYqdbV/Zg3Eng/m96TOQ3DXe8PQUvqh3q+YxllFdYaKqRUuudNzBAH0nJyo03OpSNM8w
         07WKDY/QO2XE9O0spiygUQoxaV8h48o8SQ6gfH38Iwlf31IfHm6z4Q6TRe6H49g6GMdz
         U3OW1hdbvdTRwvv5iH1f//8a9zpXBAR+vgMajEJuzIed7yuGZN8/y0nUPpBG/IJWKHDw
         O6aw==
X-Gm-Message-State: AOJu0Yxkxs28i+AJzSlqa6cHytMeZaWv1r2UWYY1NyB1xPOPyfVrd4sz
	M4TVJ3ai4ZvTl2rP0DumM1wljMW1lOrmGvvcx1EGM8xqbHsz96bcPCZm
X-Gm-Gg: ASbGncuRRE7U5mmsxUl64SLO6SPozjQOIfj7mrzXuq0m81bqxi+U0IqWmoreuAcjFfe
	xsf8v42f43xwOM7hzwmh5bLkhVViI2P784Ha0CRhxVaRZc3RiMaoVEIB+Zp3Jr8h+U6WlsDf8Ga
	KoQUPIojrlXOy4zkbbEDtrSY0r1u0HTOpl0oiH7kaOMWWCUwDY3Iaor2ROeJmmJ6wYMNTcphYvR
	lBgAVJvRlljDHlv4E7wkGKyb4lzXLKqx24F7pnWhGZRhqpau5/j8Jvmj9qdXO6gFJKyiLbbhThY
	RpKn00W9NFcPRWduDOcgGmQwIZeudcJYMPDBqZ0WaB22Is+21fW+9KFvZMo=
X-Google-Smtp-Source: AGHT+IFzOBFh7UkjE8gRjo6NAtkTPxHYWBJwckBMNIY9yud2Drn1a84PoT9gU3ZDGIZpbDP4e9TQmA==
X-Received: by 2002:a17:90a:c10c:b0:2fe:dd2c:f8f0 with SMTP id 98e67ed59e1d1-2fedd2cf9c4mr14474781a91.22.1741087644263;
        Tue, 04 Mar 2025 03:27:24 -0800 (PST)
Received: from [127.0.0.1] ([52.160.161.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe825d2be3sm13016608a91.27.2025.03.04.03.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:27:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250304102634.331497-1-yangang@kylinos.cn>
References: <20250304102634.331497-1-yangang@kylinos.cn>
Subject: Re: [mptcp-net] mptcp: fix NULL pointer in can_accept_new_subflow
Message-ID: <85cc2d8e-95af-e853-e44b-bbbe5c6e8c48@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Mar 2025 11:27:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13651705640

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/faf38b4d7b6c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D939964


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
