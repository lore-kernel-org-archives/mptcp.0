Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984C1D63EA
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074701; cv=none; b=b+BVgfvhDSoopenWxLUeRTPK1N4h9LnNVEM8XhPc2tgzs1nnSjyp2RYBcE5/n+LOEexFVEK97HvdgHHr4UCv8N6CZ4Ta3W6p8mEZJm2L30J6L2G50XX5V3Njt6Cd7TtURM8vBcuRFXCJM7ksujhlf4gxs5WU02f2Bfm3LcSUvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074701; c=relaxed/simple;
	bh=w4jS0pv6Z4HqBhLHGnQ5XExgg89dyXCgT4/S1zoIH4M=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=OUv4nzlDl1fqLvNldO94XQPrK3XfdAG8rz8ZyFJBJUI5viMARCpCqLZ+utcCxzUH8w/X5OkRr9ZtIunBXB/K9G1CS8SNJpqVgLKNpt5oh2xZUb76ducTCdW7XAx9Iv6N7YVVO8fvSaj3IWv8eVVUjm/x1W7TwgyzSevwKB8b1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwim8153; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwim8153"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca7fc4484so32051445ad.3
        for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 03:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729074699; x=1729679499; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoqP4qtsjJuVyfWPPnPYD/V1WzoonZmdYRJBgc3FCgo=;
        b=bwim8153R7wZucR4Ou9tmcctxX7tmwJkfbspc9lGMJ+FhBqLTWBV/b1N22rX+VbZXp
         FP7kJ2cvc8RQr8iKf6zbeiSnij8GYvbwDqWMidQn8Z+r/j/HYucYY+ExdqmtrbsmORzb
         vA3vhqETuMI1M26xmDsURKCQIx5S1sTzbDsV1h019ZX8bRlz81GlGn5sw1JQTnlOZz9L
         iBGUQO1ZKtL3zrHbq0f4HVJVadJZ8sSm/kPK/nZYflBW8nQOkQx347fc82zlOCEnYwqc
         JUvYAyLYePCNOQJzuMPGHQ9q6/p8C4BltcZoP5NQO6r4iJqbKT4kW8csQMb//J7virgM
         dOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074699; x=1729679499;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BoqP4qtsjJuVyfWPPnPYD/V1WzoonZmdYRJBgc3FCgo=;
        b=NfmdMSzF47Od9x1LuTOa4n13mUN/VwiUkEc5/hrD/ttK8bA1Pdp9t1dhGRHGtybIyo
         OifwVluoLSAeEgz/rdbgGAmD5N8DRDr69bIFNnJ+MPN4/YJPRGCHK0Joh6EBO1XFYxpj
         j/oJvySu306cySfky92CGHz4Ik0foa+eAwxYOfdQh+6Q4C4L2XB1qqOUFErMhma+diUB
         3/V3NeK1h3OVrURATnMqola3IrWCd3+IdegGlra22bhh97Wrwaf/UISdb/leVoO06zIl
         fO547YUTOdT373HSUB1B9JyRVx8km0CusuAjiYOUu4Qxpx0ZsV8jRoutnvYbxQpxw964
         DRUg==
X-Gm-Message-State: AOJu0YxiERVRSEOB4BRVPd6iaGQhtmNZW15fT4n4Sq8vxSSAj0kLk94s
	BHdoe6EiYGSXausVMW7bv6jutTbMXNqcdKXkM+SirntxQo+0H5obtoX3
X-Google-Smtp-Source: AGHT+IFjimDvzK34aTmG/H1fFOHolJPAri3Uchk0/bPeHL2d0IKvgPBPSw0MTsHMyaLQpmbxiBdNXQ==
X-Received: by 2002:a17:903:2342:b0:1fb:90e1:c8c5 with SMTP id d9443c01a7336-20cbb1b5cf6mr233065065ad.33.1729074699538;
        Wed, 16 Oct 2024 03:31:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9db77sm26181715ad.98.2024.10.16.03.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:31:39 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729069853.git.tanggeliang@kylinos.cn>
References: <cover.1729069853.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 00/33] BPF path manager, part 1
Message-ID: <43e01256-bd44-22f2-6690-c2b6e0d8c7c9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Oct 2024 10:31:38 +0000
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
Unstable: 1 failed test(s): mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/113630=
09388

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d7dcbd82b26f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D899688


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
