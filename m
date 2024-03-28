Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11051C46
	for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624576; cv=none; b=DcyMs9nFfFBMeKxnsfqOO7gmZRYW+nuySrmIXFGxLpv0ZOpjTLEETHNTKxNuGxU5n0lfToxpzQJLQQDpbzOkve/GeMnnAclQHeR5EG0Hhr2PjRCACpz2QXzqLylgfFF4SupCcP7X20Yq56yf6zlZA7zqRO5N5h/L956hOOEQbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624576; c=relaxed/simple;
	bh=NltXzkPXl4wC6x5xVJn1jvyWXvgtwBgVenoAvNIyhfo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UjEE6mOO2XCSGY+ZuyFp2FZ19hpPLD60B2uVL+193+fiZyY9T9WTp4Umpt9BqPIz2oooPr+VZ+6/WRYyzcEhuaNw23rEjT5YCElJnEUDWZSzSLbrhYasa5T62qZy2w7x25QMOWcysg4Akv/duoI3UKCMAkGKF/baSXDHpmS0s+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCX5xCAh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCX5xCAh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ea838bf357so752712b3a.0
        for <mptcp@lists.linux.dev>; Thu, 28 Mar 2024 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711624575; x=1712229375; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPhEI3kElm51cIfbhR/R6VFbzI4z5s9zD2B0crFD/ac=;
        b=ZCX5xCAh92iZ8dr3QNcHgYOaLg+nOW949dqLZdF1j5n9MLa9NtGpAYvQ1RrnN+Lzv4
         Cr8YKEnECJCj2bMTyDgbDcbImCwpG2vPXZegVt3Ed4taQw/i+2Q7Pig4kSIqD7hPbFox
         sM9o2S4CeOmHSQcvH311KyluRd8u6bP0SwstiaCgAimNs988ddBgK/GqsHbIKXAoAzRj
         J6Oj3bKMrtHP60WZ7qTSZUJhC52UJN06txMlgPHJ5uKCSkku3WL3+TEPaARhfR9wnU0p
         Z1+x1dKGuVXN0lPf0obPhSBJOtbHBSgBiH4dAZbnqn3rfC1MbUk8vLIvjqt3E45kIcDY
         tTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624575; x=1712229375;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPhEI3kElm51cIfbhR/R6VFbzI4z5s9zD2B0crFD/ac=;
        b=ECo3fy3EB3wiquRV/I//DuRoQSQYbykF0p2Adz/U1NbtS/hEO3Cv68LITx1s3qk/th
         I9d+V03Qcw5X7Tjn+PNRsHWdnbvLSnp6N4aWzID60m0kX5inRBC2E2xUhPkuSWtwREQw
         fVJivEigkgtRYvK5BsBePLOKCVLBpEmCWQBc0KYuM6mZycKFyEiO4OaBap4pKLVNkqR5
         Hm7+U3LyDTnmd5tvJ919v1MDvCg+EqDcRGcs3prSdp3fvG+29E1cgnsY5Mn7S6FFDX6N
         DEGebGisuxWpLDvO/eiDTUaNcikgzTMppd7pgDi3MSL/BPgf2A3KJyEZy5+69XmfB3U5
         DDJA==
X-Gm-Message-State: AOJu0Yyk9O0cMIlnlxWwPOBYn1hO0N43FHYWG0k5KhWBjeeOMNtUk5LJ
	0AajiyrCMKsiYZJDXM+WSYCB6hxYXwVXlF2w7iijT7+0JqkFX1jXyRolceE=
X-Google-Smtp-Source: AGHT+IERPjHIhmOe49tuEf4tL7xtnIEcezs93NQG1RfBkR5TWLR20Fv0lVgSOqgnDqt1eVzyHQivLw==
X-Received: by 2002:a05:6a00:464f:b0:6ea:7b29:3ab7 with SMTP id kp15-20020a056a00464f00b006ea7b293ab7mr2491863pfb.23.1711624574616;
        Thu, 28 Mar 2024 04:16:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.28.177])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b006ea7d877191sm1127218pfa.2.2024.03.28.04.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:16:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
References:
 <78a17486bd12d7afb4cce565d58dac3f15e55c49.1711620349.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH bpf-next] selftests/bpf: Handle EAGAIN in bpf_tcp_ca
Message-ID: <c6b02e6b-f4af-86b2-84aa-98838c5d3dad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Mar 2024 11:16:13 +0000
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
Unstable: 10 failed test(s): packetdrill_dss packetdrill_fastclose =
packetdrill_fastopen packetdrill_mp_capable packetdrill_mp_join =
packetdrill_mp_prio packetdrill_mp_reset packetdrill_regressions =
packetdrill_sockopts packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/846603=
0926

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bb4890f8d71a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839276


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
