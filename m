Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0B47043D
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715468; cv=none; b=EYBzFLBc7EvGgESzlDFowF0fhiKbcNJGZqbl18fvQN9JCfmP0FDT4sa7vdB30nwsMDA8xX/JSeLdyqv5bZaB7IBMxXCv2rHYdiLvj/6/c109yY4+VcMNl0uWD3JyEvT6oj5smsV/l4gA6dzAWQB2tWnDIx0U/jhE8ueyElk+76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715468; c=relaxed/simple;
	bh=q5PwC6xahcQrNywFz4ycoj170oo7e8oq4lhEqcLQEJw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RsJowo/aq3ffx0rcn5w1OiUtuS7zxEAKQtVmPsaTU7IcY4seNKHE3TBfBrp2HsYfvj7ezInH68p4Lwzun9ORHaFuvK8rprj9Iuo29Q4ewGdRSrAhe2lkjKlfN0ByV65/xRgqDgoaSVZ/vED9t2tNHgAPnDeIRgDE+lHibjCeLg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgVwTnDO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgVwTnDO"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso61009376d6.1
        for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784715466; x=1785320266; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9pnYf0NNh+DuAonfEXU8npLAy6yCawOK8t5RrUJwz84=;
        b=MgVwTnDOXjUNQKP1MVibUyfA6sydL/WWQ13UJJLqLwh1zGClsq0xwL8rZe7DNarn/d
         pVtumBJbUOjLUz6oAw+jQHFd4pSAJJ0EzxAvFvgB4Qv8PL6rfApy4CFaxzR6r0qX+/0c
         dSTtWHdM19moUna7XKvWhSCas5B+HSpiOKLGfz2aIYTPAku6o0BdVOtXA0YYE8QUD3nS
         wA9SwzUssQIA6jAnaW/LvLLh0Fn3aBkXxqxFfCcX9kz2IbhvG+06/6NzhQQDwLxoaET/
         Znfl/rk53/A/R0kh5BNLy+m4jhv/5k4T4vgVXOP/M8ce51EFUwZ6mXWXd1/s1G4jG6Qn
         GZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784715466; x=1785320266;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9pnYf0NNh+DuAonfEXU8npLAy6yCawOK8t5RrUJwz84=;
        b=BDIgPOnHOB/DXrDaV9MnlBOYXckGmCPhe0V453dvBs6RG0fX5LZQXVNSELtlBgDs4c
         sXX+IRLlv3vaNsiW38gs9uWAV4efrbpPSxCB86HaSXwgwLXxSX5nuFAepvEnQHQm/1/E
         Gn5ADo4iTDr83IOwhvtSQ3EQ4E74nrzTNbxw91t78/5/76VPXxKZc3SmPOawKaQFTmEt
         19+gJShkvxiph8wAAECRCjeb+6cYFhkSCKvuUPtVtg3rkUCCSgUIj3kq2iFW22ux4uJP
         A5S5y71T8doTXb2zgYcB9SVQDcyhUdCZX4TIXn84/vgUQ3zb/o1e0DYCaHVuCZmY+xOO
         k3vw==
X-Gm-Message-State: AOJu0YxFmBhuBOYF2Ih39znboZXDIkjDFUAKAzdTxA3/Gdt16EUjNXnS
	q0kp2aXFZnY74Xylto2J+K8N1Qa3lchLSweJ9WnhVfFlnn5usKN/PUy7IA1KO14=
X-Gm-Gg: AR+sD103SbuLw5fSoV/qJZHROHtzB2LxKmsThLqDB5nf2PlQQVD0HZdSKNJsrJlgw0q
	aC2nsxv9FstyZ8J2fLISA3lym94Suf50/QcdaYuDjEyqCoF9o7fIm+xH4wHCnND2zrjhqZzeSfM
	3sWg9c7jrdFohYKca6kB4O3PYruZo3FQCTLGyGp18FxHSxnCbjWAsIMpMJwMF+MyXBM+kySG2Ov
	z+QiediZruepvMwM18xEFW0XbG234OOatLWNpYfwASmH+VDdCpqVzadBqnSu7MqkVSlF5duocln
	L8iNBei0xQgjlfgIKK1an55w5G2ODnZQaFIkOt6Upa3MzFqsvBKPBA3X/6RtKCljV/9ahVbsnFh
	++qhQ2cMV1mRdp78h/s+eD38XbdWoWXDQKyeJDbb4m87SvldwHFybMldid/tRxef3eEeNZZmiXc
	T2bHvfwxxl/Bvy7NbmXw==
X-Received: by 2002:ac8:5750:0:b0:516:dc75:1aca with SMTP id d75a77b69052e-527a8178ad4mr33878151cf.26.1784715465636;
        Wed, 22 Jul 2026 03:17:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.118.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-527d3555e86sm12328201cf.20.2026.07.22.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 03:17:44 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Qing Luo <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260722091311.1218738-1-l1138897701@163.com>
References: <20260722091311.1218738-1-l1138897701@163.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: fix data race in add_addr
 timer callback
Message-ID: <5149b409-609b-dc97-7274-1b06c4e0000c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:17:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Qing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/299084=
53593

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a649cafbecc4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1132281


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
