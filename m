Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DEC26A1DB
	for <mptcp@lists.linux.dev>; Tue, 20 May 2025 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741211; cv=none; b=BkLqDsauXDdAZQDkq0zBbuEbguoLEqKGIgd6HLV3PGNozFbn9LHL5j+19/gjsqIAIT202MXcpOUO2pz0QGwdXAK7DS1cfi99J0nxcLPFNbD+5I/Z6z4jyZFqS+gr7OJWdxXSouOdiGGeMgEfOd+nPmupOOML65USoTJyoKnRNoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741211; c=relaxed/simple;
	bh=hdAWkxgGz+Pykmly39hUq5ac+JpgKeHf8f5E/umtuGg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=C5ccANywzQUPXsAKU90nFZq5gMLUi+EJz2jwlUKkua8VxIXOSb4nTUoWHvhcRKn48IHahzkyU76W2Miq4pIU2G1c8BkFaEFhPUC/ZJjifnrKNF0FLAx6CW4GeNk7pmd2Tsj+5Rw4VhWNwH1w1DX+PQpnnEJmUfd7tSR8PKiaWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLmuz6LR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLmuz6LR"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73712952e1cso5171171b3a.1
        for <mptcp@lists.linux.dev>; Tue, 20 May 2025 04:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747741209; x=1748346009; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/+aF6/mf9c4qLXtHpRcjdfON6/nYZqxMsxvZGmZUdc=;
        b=fLmuz6LRScVsTfofUftmXCtzn7eCNf1c+SaD9hr0rzuix6efTBZiWOD0BtUQTZ7ODB
         Np58i7fQIqbCo8fauFHXWFN0+FVoEo7zx7brcaCxTDPKZNaui84YdeqmuTGErx5I9djl
         s0HkfpZadO662at85CexZk5766DSpgFnHhJjVi1oGmDbqPksJUg6NTGt6x83fRBFqbf0
         JSslKplDGma8SMKB11+gWK7F2hNYpqQGGB9OW9f2YEzs857AA85L8beFtThGaK0CFWf+
         3wjg1qgyg6m7vJV2SBvl/Dw21WsbdriecjFMNRK5Bpvgo7l/hGK4QPBXy6OrZvXFqksb
         RDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747741209; x=1748346009;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a/+aF6/mf9c4qLXtHpRcjdfON6/nYZqxMsxvZGmZUdc=;
        b=Hyr/7Mbn3XW+2LYu5YW4Oq7PGKy/vdrSvD37G3mkSL5kmkoZBGpDoA8h/0wyrRW85i
         1F4j6O9VVhKy/I2ja4pUMOlgtgpro4FMo/NcIcEpRndpMl1Tuyn4IBtdeLBZAGWrqzDS
         sicQsOXpGnFoBnx2nftisjsNgK0KSn8atN1jTzonbLIhe/34TtXQsHZ3k8+zZyCPSk9e
         +Za09gqSA7/YohV2wXCkXgVIusD39uPumUA3d27tMUkeT4SGzDAxE1h2npXlDcxfLisd
         jDPtT8EM1onD7/tEavMNzQv61T9wNZuy4S2qDPrRAXM93pg9Eg+tY8g9eTc8Qbk3CUkD
         /tfg==
X-Gm-Message-State: AOJu0YyyozUxGL2Lq2l2NagShnl1MK6eVEc82JalMGPzmxWxin46F+hQ
	uPPbriKz06eKOVC0kRjR61YZk+t3OxGY8f7bb2HYEFaRSqRw2bekFYotV4t6
X-Gm-Gg: ASbGnctZt9SoiLOfMn4iCjFe1VwLOFpXuu166c4g9K2Hfmx56c1Xzh+BtT8/ioE0iNA
	ZHZjVresyivM2hRhNXSo4T7nF8nFwG8BARy2OyzX2RNNOiRa2DgAWCt01oN/2lieerPez7zb8G+
	mLC/GoFhPfHtcvTU+T4U9zi8B0NP9Cc9K8MXRKsB9Fd4n9FwCuSVUVwMhJdpAJD8T5yMyvqSdCt
	IjLXfh6Br1mCY7R0OTN7Nd7oCrwMmh793u5R8S9CpxRwnSVXHu8S6bCL5ferDoNFvJrRddCYJvr
	xDV848yU7peRtzP9A6PHvCRi7kJdLjXQCWu10M+8EV3Rk6srJMR8czJhBvnSSQ==
X-Google-Smtp-Source: AGHT+IFIiJQaAeZ9dablhdKJt+GD+zdTGethfFL/h2wdyIEa4GuC+4DPYOMqiP4PuFN30klDKtRvhw==
X-Received: by 2002:a05:6a00:2d0a:b0:740:6f69:8d94 with SMTP id d2e1a72fcca58-742acba67c1mr20770368b3a.0.1747741208616;
        Tue, 20 May 2025 04:40:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.9.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982b80asm7801929b3a.116.2025.05.20.04.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 04:40:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1747730598.git.tanggeliang@kylinos.cn>
References: <cover.1747730598.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Squash_?=
 =?UTF-8?Q?to_=22BPF_packet_scheduler=22?=
Message-ID: <2604d5f0-b79b-36fb-8a5c-600b5f027e03@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 May 2025 11:40:07 +0000
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
uns/15133544129

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/26fbacaac134
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D964483


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
