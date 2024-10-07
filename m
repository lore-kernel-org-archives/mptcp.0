Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2341DE2A6
	for <mptcp@lists.linux.dev>; Mon,  7 Oct 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329869; cv=none; b=od7N2stdWNK2n2VK3H6LuzSCpztqwFUnl63y9LWDTYXD0hwG9xMY4SjbJRBIgqQQ5uSy7vBFH+KVXw+CNUtty+cmrtgIpdl0pQKouAv+n/lRt6ZhtTMrJlG2P/r24zFwr7N37zt7cXp7DzLPHSJ25bPUU8+EnEmglUxsMUs+aC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329869; c=relaxed/simple;
	bh=Myo0ru8sJTV9op8RcWnpWbazYzyd1uu5Aw7Mu8O0lI8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eqsnAAAOmsu1Jzt+o9LMUcXlESgGLTQDCfhhQ4eJNAlYSxaBzfl7dtlS5oIZtORGEGxobtioHyqfOKk5F4NUHEJ3F3X46MQguDvc82iIiVGnXDJpmKFKikaETfpenu/0V5259XYcMdbY0+rTpf/+J8ZQjQBdesTnf82D4Ez/Lxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT2L2m99; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT2L2m99"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cb2c5128d5so38349346d6.0
        for <mptcp@lists.linux.dev>; Mon, 07 Oct 2024 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728329867; x=1728934667; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MSO/Y7iK2TdCixM/EyMjTQ6MAboXKxThcZIRg3e+2I=;
        b=WT2L2m99mH3I3Zzy7nbcklu3AA/++F08xZgAxTJNlxOiGYm3g3A+zihQtXYhOSb8qy
         1VOv/P6/D3SOp0xUspx9ppnQxjVcB/X4RKUgamoFSC6qpYESofRF/k2v7GNleFKvfx5L
         HZg2J1kwaaU7ZEYaB6wtrJr5Os82A9rlYXcWthSbEZfVRHSN4gMQyp4ZKr1fnKR3/uNt
         c3vAE/qUbvE2MWa5bckULcyVHg4nQ+aaq7rnA2EONF2LcGg11olPm+IoggeLYDITsno1
         BmL+JSQntjadHBRYMx4ixfxZaVTtEqz66TEozMEiZU0FNwRo4GBWtad8EZNmpQfdiWmn
         jwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728329867; x=1728934667;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MSO/Y7iK2TdCixM/EyMjTQ6MAboXKxThcZIRg3e+2I=;
        b=AaUggqFay3K9N+h7mSARoWG9LSIZLmD4MDIGLinbfg64q2rkyYiQnAZQAESf3LvX74
         Dpp9Bzye0+WF+uI6SK8S7/zN1f/YQH6gAFBCWC/QJ+TjjycysfTN4kTmICjUqFxCHvXE
         d2NOD6Bzgd9NY7KtSCyHovON7GtMWcjS+HOaNSwyervCBIUMCrSK+mC8pEtZeA9JimBV
         dqEFkI9q5IHA1sr4upnqYG0wh76qSjj58pKLNh3u7n/aW7jj/drvmFH8z2R3C305CFsk
         QvGz/hwPx4VFt9hT26uFDVNv3dzz7Xk/izlNyoD3sKpR/ls93FYdeLyGnEdd0Rk+yrHa
         UApA==
X-Gm-Message-State: AOJu0YwnwTuubIyN5jRMl4PXNCx1SqesnP8I32Qx2yiJwGkaITQyFYzU
	JwZNSSft5/j4fz+iQKCylGQCugspRm4tVDyOsU2TAU9bpMRiTzwNMnpT
X-Google-Smtp-Source: AGHT+IHSp+6qqpa7ewYPWUe5ORQ2FWYwof5TGe+eS+2k/Vg7CedXQp2bIjfWZJLqDnqoixOk1U9tTw==
X-Received: by 2002:a05:6214:4b0d:b0:6cb:2e94:3e24 with SMTP id 6a1803df08f44-6cb9a306c99mr228764666d6.11.1728329867324;
        Mon, 07 Oct 2024 12:37:47 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.127.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba47606cbsm28501976d6.127.2024.10.07.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:37:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
References: <20241007-mpc-hs-port-v2-0-0c9e7827bd0f@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: prevent MPC handshake on
 port-based signal endpoints
Message-ID: <830af6ca-44e6-0eee-0c23-21e23ff76fca@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2024 19:37:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11221914489

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8f0ae8ed9298
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D896357


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
