Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4C287507
	for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264273; cv=none; b=AY4D51MlOBF5mxCeOFN57fffWS8IB9i9DwSZGyDeKYOSj2q4mjjQZHPmq1HllZ840Ghnqk4fPJMqqEukqmFhAvtxscRhNS7Y33LYliZybzceTYrLDmOdk4owAmqQMIetvFj6psQhHk/FhY5e807nzVIjhVUZbQhChiVCLG2EuDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264273; c=relaxed/simple;
	bh=GWWId4po7d+i98Eivu2AXIke63pNRhguQnfnciMRBRU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RVD7dzqMFXR448CASgZFdZMxLIetWqsKxlansCiqWzFot2uItfZSH4ReAa3j8fgfAM0sjkymt3C8+EyLINh79Y4XAy6RvUP5TAOKumLHS8YuM4ZLjxbZDYVGuQyw3IjVd8gtrrj1Rr5/MZXYSrtdckE+/jTvKu5uBq6tKSu7OSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUz7yTQG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUz7yTQG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29853ec5b8cso13135535ad.3
        for <mptcp@lists.linux.dev>; Thu, 27 Nov 2025 09:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764264271; x=1764869071; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTBiMOT8yOdi0rkE7Xiz1khr2AjIqQcApXriR2FrOEs=;
        b=XUz7yTQGIvxoG6wRBh4SJNbbuHNz19k2iGNsS3QoR8VwfJcV12i1MR1Lkhm7VZr454
         8m4qWgXLxYXzAPJ3VW45jHWjSzSo0DopiEf9QlxUIyWL8VHDxAxQQTrotp/pdDv3DujJ
         vTWK3zL46UrwaFboIT0tj4C8Qe2at/NLBfMbUfUqucpm/XfMMmb5c8v9iv3ffdfdf0v1
         bKR/ZEart9CW1UgOagessahlxNkEnfPqGWarFgB9u4W1o+5jfYq+3oLxzj4hAsor28aT
         O5bnuTUVXrlzwhGewhHdhWz4PXRQIBHPvTjaA9P4nLyUot+dde7DHK36Qkv63sob9zOj
         r9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764264271; x=1764869071;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTBiMOT8yOdi0rkE7Xiz1khr2AjIqQcApXriR2FrOEs=;
        b=ntkT/Pds/Zq85/1BODzEMAB/aBLO0ZsAV2gjYLaK7pGx5r6xFn56TqlLDsH8CiFxSr
         OLEG+M79gldYlhpIELLsvzufHc6SmGTse06mJR16YPn9zCRXAJ8DaWt1R7zZXc8mrt5v
         WwfizH5Gbwv0ZFbOZEiocllY9KlOzzOhctyDQqjGXi9ihDWfBmhAlKORCUX7pI+yQKV/
         YUlCnVF5yRrPJvlfSo8mjKZnwa4m4ptCmhF3lFtmr+LhRNgDnuKeNSQBpbRWXwyIZjsr
         Ak6VBrdPJSe5kpIRW7ZoYCzEfctN0ezbp/rIxfaSI6GT7NXBDxutYo1RQmegt0vowqar
         U4Bw==
X-Gm-Message-State: AOJu0Ywkhq1cUS0Il3/IrbvTfsB/17Lxl46zx1901eBaKQwRQvdzwd1G
	lwISd/qSfC2Cayw4r5thk6+39fV1bS6kMBQHGnuGWsPKJr5dObXm7bs=
X-Gm-Gg: ASbGncu1SBd0KIrC1Xz/fdqKbIz2jG8p9asPYlyXxIaF61rtnd4owLY759MzVp2uCvN
	6ZAUc9/Q6U53fP6sGWyDBNFZby8ZY1wb+4eiZI891Sz0/3aSqLKQHGgRVJEV0x7fRRHG1HkXR9u
	n89Nvxs3pJkitiKN0afi8J988W5beBpMvwUY5VSuSfa57OWeTwTKOKT//YWWyT6Uvj6wYbaYaLr
	ZiohcwjL21FaVA03yvgTzo+D+mtj4g4xT+DiQo9IvGzvH3V9VmeJGAoKDlHVnUhAVLgNqHHmadw
	Y4hrVraQoZykh46GwbKLbXrybDj5q5TzqPpZSEkRe6IyWCXRpwz++n51+hVviYl5mOsF2HI612+
	C1ddOKXZBIWNni9KcfUtba1C4sIPCDXapsA1UvAo+4/ikADz8kz9clNyVqsb9oyURIroP7467/j
	Kmq7Nw8h3+epNA0XXBgVo1KtL5242pJQxtOw==
X-Google-Smtp-Source: AGHT+IFhdBEaquXK/QO3oqNvvo1u8mgEpV0v7Nc7Ex/Rw877zr6VRR/lN7IDrESNZzRI/Mh3ehYS0Q==
X-Received: by 2002:a17:903:2c0d:b0:295:39d9:8971 with SMTP id d9443c01a7336-29b6c3db364mr286677145ad.1.1764264271498;
        Thu, 27 Nov 2025 09:24:31 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb40ac4sm22564645ad.77.2025.11.27.09.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 09:24:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org>
References:
 <20251127-mptcp-tcp_rcvbuf_low_rtt-v1-1-fa080d67f2e5@kernel.org>
Subject: Re: [PATCH RFC mptcp-next] mptcp: support
 net.ipv4.tcp_rcvbuf_low_rtt
Message-ID: <16f03f68-10a4-3f42-5236-a0772771e9c1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Nov 2025 17:24:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19742476256

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3d5676c09a8f
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1028361


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
