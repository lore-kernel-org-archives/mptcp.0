Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A4825F983
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740740924; cv=none; b=OnAijVJV1NNUlwVN0weQWTPBElNWK+cxvfhgA7Onf4Va9I9iCxH38ARDyp14EQmAnFcYRegttCjn9wF2QCeVJFoOVeXn6e8qqgWf1O+ffV33ONPKAThIvvEP2p++TdYvEpzrqyXtepnhx2P1mfkr5y5oRFyvECDu2NryCRzR/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740740924; c=relaxed/simple;
	bh=a3Xdz1AKF1YJtREEzNGH6XpKGcOIcsPx+2cyU+F/ll4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=l/3lIkAOJqKI2nAYlUqvzuhOYwWnHAf9S/4UFta4106FHwg16okRwGBV9agdI2YnmKeTprcnxCSeTvZd4Hq8t09H/FRG9y+55tqEmX7+p/8ad3cS3jf5hoA0oKCkqOqy2SA44UZ+ZmZ5Sbb6NRC0TtAa1lC3wFw4qS15lB3W9I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6xs6u4f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6xs6u4f"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22349dc31bcso35740925ad.3
        for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 03:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740740922; x=1741345722; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzC+GsFhTqZSSvi/38XhTv1OGjsUCCRRF34apEy1a4U=;
        b=V6xs6u4fVQ9fmXSI7QaVtdk0D7p3rPuSSGdwSKylrqczMxuA5sSEEbXgkkEv3N5PPG
         c2biXvaD4xXVUDVMD07cSFTUSikZhVy+qnow+iVuxpYnVVxp6F3d6f6+mcP+ZFgznACX
         VnByNjOC00qPHiqJRkSYO6HJFTN0ocBT0ecjSQd2DXWfyBuo74sSRNptq2iRedY0VUMw
         Mk0wjWf1G8/JR+0KCDIVC+ptE0iuglmgYnyJVySrCF1klvMAmmFsT6nVS8uXj8FxF2bm
         Yy1qd25X0MfG9i/OoSbmdU5P01lYvmFhpTe6Li7oYbeMFE53UDV8gc41T2/gK8j8tanG
         Hx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740740922; x=1741345722;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rzC+GsFhTqZSSvi/38XhTv1OGjsUCCRRF34apEy1a4U=;
        b=fkGZV+ZZI0XKsL609crsjf73T0BZcjTCzZ+MMTjX1L9xHz3jbQK1vpJpJcpcyE4xGL
         BW5TAbT7BpdAzXiDFrHQKr4a3P6UdFdZYiU9z0DCui4QkocJSuuWvdNjhgE+j+YX+w55
         JdtZMBzEBM2gjZgJtZXfsc0oXta7HV1zJvFqp65eJuvi+P5POYxe/RbEgCyS55F9W5xC
         DMbKjaVd3eHhAGEAP9EIHfnG+OLpbsu4I+KRxho0QMP3tFXGDUOxjR50ZjaMjSckO38f
         k8DKI8AMx6Soo3Y7GX2K51Z2C93CAuEuRDlU//8tVPkpqUzkMXIX3odBCErhOp1TGSIJ
         MTpg==
X-Gm-Message-State: AOJu0Yx6V49hqMTuBGoKj+updLyuE0jprItQtrAd1k0p09A7UvURKmLp
	Wy7YBV1kAR28dCg29b8oW4Lxv265BuzkmG0x/Oql5hyiBMfN3ev5Iw5K
X-Gm-Gg: ASbGncsTw0dbV3LG7EnR0Oai3Im1+bNpuX4YbMzV9CJomDru14fk9Pek8wzdURXGCG4
	2H7f7RF96tr5xaf7ImMlerQESDEybHA7unN3CIcurb2wDlygDLrSs5//TRR9P1ukvBNxw29y/fK
	5cvqB5IYVX5rkaWXQ8dVWpCeX7lt48R3WEeGPjEg9/eEx2TjIrI7DYlk2GXyCYyv+Slq22MevoE
	cqroGKMF2KpLFS/AXQLxQn6gA0MDtZ+og5WBcVArP72r0sfxMzT7mISS0iywqBmktg/gBnvetbY
	IsVrB4I1OMIk483a8523HSug9LvYeJKzFettpJg=
X-Google-Smtp-Source: AGHT+IHFiWNA6/xnpKV2dFsXrY1l/n8cEJql1cOijCzTt4G6iSepQUb1ndzFRZdb9kdXwPkJy4GRsQ==
X-Received: by 2002:aa7:88cb:0:b0:732:2923:b71a with SMTP id d2e1a72fcca58-734ac3f4b31mr4571280b3a.19.1740740922233;
        Fri, 28 Feb 2025 03:08:42 -0800 (PST)
Received: from [127.0.0.1] ([20.43.245.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48849sm3437111b3a.46.2025.02.28.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 03:08:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740735165.git.tanggeliang@kylinos.cn>
References: <cover.1740735165.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next v2 0/3] add sock_kmemdup helper
Message-ID: <2bc80e68-eff0-230f-ed99-5d97f997284d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Feb 2025 11:08:41 +0000
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
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13585962844

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bce1a3afe292
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938919


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
