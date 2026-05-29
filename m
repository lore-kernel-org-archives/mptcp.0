Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BD38B148
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043739; cv=none; b=N0TyuviKZpUWr55q4k1Y0Vpr+KaBkEL067fAAx1YXFkF/yGNjsibZ09d2mlslYhd9bxo+so1dO3BE/M7vy++DTbnnPID5oXcpmT2VxDR/HDe4amOLqCYDzHS8E6gFfFaglLwLVq5xvjpUnEavg7C0lVLrwFL17kIqrhr8LhMsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043739; c=relaxed/simple;
	bh=FCLtOe5i76iS0oPQHZCRuMydrcvbVigWFkkneVKQ0wM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=W3fY27PLxxo35RCWATMRDGPnoYvr6wphU3JCIwrQO8D3yid+G26TiZjiygpn4zPAOs4DiJi0N3he8VXhqNFHQ+bxo9bJanWQI4SluomgckqdjmgvMxyW8w3rVtimARVya/PEoX1cD2CMlS16qBdbzVd/1bkyO8SLvq1AJi1Zcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=os36KNAn; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="os36KNAn"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4855003fa6cso4830438b6e.3
        for <mptcp@lists.linux.dev>; Fri, 29 May 2026 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780043737; x=1780648537; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EauKxNFD6TMPM9CukYR7o630rRwAOceOqnNMGO6zkLo=;
        b=os36KNAn6Z9C31xcXqFLnXks3oUZqk+i4ivK+yWCr2njgSNnQpX1NSOPQLvOVOGEGu
         RdXxNahGoJCsQW3ONMIjrkNnoRj/P21Hu1kGVP3i8U7JTj8lHG8vo6zNPs4MhFazVeTv
         nRo225tg5wg2WN0BBmZ0cwYP0hjXTXh6yWJ+yMBIJLq/+nf5P/9f41h1ObDPUFiywFqX
         oTpHEkj5zwzBBamFfsiVKfLjl4KO8f8sh6hLyDeNbMx/VNZ9MBffqm+MYHrEUjRpF91J
         KXT+maLt9m1HzSQ+Di/E+ZKyDeXs9rM1nbXB7tnL9MYqx8erDtOHd6FquWaRN57edHif
         oyrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780043737; x=1780648537;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EauKxNFD6TMPM9CukYR7o630rRwAOceOqnNMGO6zkLo=;
        b=ajkUeo6DleIDLmLB0mKwwFSGy39DfHnnV2U4L1woHqfmMzC2nNredl7Vh7KJ2Ufn1h
         MUu9dRBB99PAi/PwKPUjk8pQx1Y9HS8V0Tku/5uAMGiz6uWaJ8PRm45pBE0KS8uQ87nY
         PEYGVwlcTOmEyDAoVopbh1UgOIDcLqfi1FbScR68TdJaziYq29acHgaB/UgpYRYWMfUr
         8DbWBAaBSQYm609X2EIiLcNjcEeY1Cs6vzs8hiXD+Q2W2/sEcYQhi51Gavv2BOlZ77GV
         v7LKY+zqhX9I2+bmclQupHkZ58MpB7Xx7VMt3jDHcSPrzA/M0mBmp64S5rwrdrNzHt2q
         yvBQ==
X-Gm-Message-State: AOJu0YxCYiiPizg1KHrvC0e0WGAeDCHhecJdS0XJSBzB+Lx4CryHghBc
	eFvuOSm4HWuVHJW2lmsnehcJQfXjiBK7nFPg68ocy+CWrPdhZ9Affx0dyN5t
X-Gm-Gg: Acq92OF79B/Q1qjKLsYy7KQaeHdoghaHZxHv8C/y2q9hspC5Jo+9SgSuY/PRBrba9tH
	mDm4Mp5BeaEalakHmbiPKf2HYif7b4GymGa8XHbQN/9MVPH3KGXYaxtos4b1CTGe764EzcuehyN
	eAJxMkbL+0awr8mW7+a/fSDmhtJKw8MAoih+ogz2Rlh9GBOiRsK+sfM74sfYDDuolXbczANZA2F
	zkbxkv47sAnGaJaeMtevWVxf0DGHQrC32OZgZKrK0FKmq1bfpoharT1bNZ5R396WK27DnzfXMYl
	XrD7TEMtHn9QKMa4ftrGs72q2e70q8V07eM864QxIg2lgtQVScdqypjf/BS0pbPqpkT3PxMSbYc
	M3PX5mrdRx376yyDJ0VtUhQl2iRgk3bdGDAVKvkw2D96Z3iyy9pfW24GjpLsGmVT80W0DrHwY4L
	zPhxbBlUnW+sY7eNupNSk296qwhDuRM1974Q3Gz40sO9ioKjvq3v8NqoJgRqI=
X-Received: by 2002:a05:6808:3d6:b0:485:e704:4c12 with SMTP id 5614622812f47-485e7045240mr868990b6e.8.1780043736863;
        Fri, 29 May 2026 01:35:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.216])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485ee1bdecesm288795b6e.15.2026.05.29.01.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:35:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <c7f74bd00fd5073d39fae2818aaa12da102a3ad4.1780039666.git.tanggeliang@kylinos.cn>
References:
 <c7f74bd00fd5073d39fae2818aaa12da102a3ad4.1780039666.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: add TCP ULP module alias
Message-ID: <653d5b08-0794-266a-4a06-ec2699a51601@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 08:35:34 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/266248=
88148

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e041f284d365
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1102686


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
