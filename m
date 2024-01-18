Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203A208A6
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 08:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705565034; cv=none; b=QQ/S6P8p4gXoNS/UnXIBIzhlgkvC7hhapWhnzNvMmvye+gm//DS/z+55VG+MiePkJ9WKRCvADKk7r9KyDmlTUMmuGA1Pzu6j88OCPxSUuucyMj0p1W7t+oUoEFkWB0Kjtghuo23i46MdaZwEk+QCCiaL+/ulzsBiFYoyWYXWubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705565034; c=relaxed/simple;
	bh=bJFgup9700dkxFXr2PpKMGVE/bZ2fOppoPra8U6rHVU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=H7rx+cCjJCxNfppD/CYmC/2NoCEPsFYtpIorJL5i/lh3my0s1dVtjJXFbPZOb/1qHM2dZfpGx5mHL0fruL6UVBSEQYi2zOq4du7h3bxnpD3vrB5q8F3uKGEJj4+QzAuEZ2mII7MGo2y5pF82AlHNyhSkOO+Kzzwd5zUXLa6P3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVmb45UY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVmb45UY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d41bb4da91so70403575ad.0
        for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 00:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705565032; x=1706169832; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6uIxv/oK+lpFtnDFlsu4e09LkOW5LPTwHmEFooFIV4=;
        b=LVmb45UYSaMsbHhyhA3gs6sUNXFpwMPXYtR6kqIIXcqbWpPyZxA2x/71sSNDSerBCg
         YHnUZv6H7Tjo3YZutcudQWpp3/nTJVXPqLT8ekvod3oAKwQVGC/HSQGTeV7HS31TzYvS
         b791PTmicL9H4odVi03NTUsnGpZle2U08LFugZPu0DUMTmIKagZ/nT2g82CgtRNAhkRY
         KdYBFA5B+m10K35JXI0x29VMBRrTD7JNmXwtsJXw0WsBXeB3xa6BXlffE1rgcohzq9Ym
         G+fhhCq+ktH7FGocrL1AXLB3L1aqgFovJ18JIo5FemZar4LnJrOZV9mxuzA3W3+fZHbS
         mq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705565032; x=1706169832;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6uIxv/oK+lpFtnDFlsu4e09LkOW5LPTwHmEFooFIV4=;
        b=dLROrfDBdBw05Gx6M3BC5UGkQgx550cGF7/0RM9mnNa/SqH6W2peZqjehRaRWu93R9
         c4IY7bHajibt/MRfCopOWQA15InUEfnZ8ig2UkRjP6vHDNoe3nNi9l14bWOziMyy1AVu
         vOnyQAac/xQoJ1Ab7SQByic+sO1oj85kxa59EcNDRiQcOMXfr+A+GjkZs0auSQ30j7bh
         J3J5CX5AIlcX6NXuam+lGVe4LU/pV1gxiN12wIVKuve3mHYDlxY0YlxJSrkLUoGE0bnp
         ol8VhlPksVb5ClaNouQGFl4mubW8+WWDH2Uw0MA6pFGQBN6RN55ZBo/AsVKfsbgPFBoX
         4g8A==
X-Gm-Message-State: AOJu0Yz56oGWzRxnES+kM6JwEDlce1lKFoeIBPFfJdM60aUUKKXTP27J
	3722BxlOiFCjmfyWljjCysiChMh4xnXAbi+JvIRLXG8Zuvk3KcMva5i8TiM=
X-Google-Smtp-Source: AGHT+IHWiULvoJtr+1IRBo6TQDmd9bxBrKNdMRIzznsbqZjC87GsIxhX64w5MchDr/jFHARcBqQ8rQ==
X-Received: by 2002:a17:902:d34b:b0:1d3:ee8d:25d6 with SMTP id l11-20020a170902d34b00b001d3ee8d25d6mr470442plk.29.1705565031933;
        Thu, 18 Jan 2024 00:03:51 -0800 (PST)
Received: from [127.0.0.1] ([52.238.27.192])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902694800b001d46274b533sm811073plt.138.2024.01.18.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 00:03:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9281e7e64896c26a3d33ea78be3abe3041fe37d8.1705558030.git.tanggeliang@kylinos.cn>
References:
 <9281e7e64896c26a3d33ea78be3abe3041fe37d8.1705558030.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <56696f46-f21f-f1ef-7772-44e5d4fa5a73@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jan 2024 08:03:50 +0000
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
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6537673670656000
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6537673670656000/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6455025212325888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6455025212325888/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/08b2c98e8cef


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
