Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AD13AA46
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115700; cv=none; b=HVD0NmuO8s0Y/uWKjTH7rYekGg6hQETxxNUOLYRPggy9pBXb6s4lkMnTHM5IkApqmSjITxsHNxVWFarYYoCbRlWjiMVb2M42aCXUoyWuX3+BQoN7f9Sckv8Xmy0OLHhiHn47OxAKm5Si4gcpuR5KMyzUrrlQU4xt1LEAEwSS51Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115700; c=relaxed/simple;
	bh=35JCeqW/2y91SsXJmEK42EQ94uxYNKefTf2Q8Jxgh1U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=r8Aj3X67NE6iVvJ4pcdgz2tvWJ7J68gBl4+kYYaH3iD1rkyy2PNFTOG1U31H9peudpagrc7CpdrovmOLrl4P/sNUqzMLKTlUHlySe6I0bvKwIocmr21MtsTxo2cejYdgx0pNwKMO+PI1u/zdEkQz53ShqoOyORJqP1pIhlOnRbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMsXPRcD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMsXPRcD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68f044907a2so12522306d6.3
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708115698; x=1708720498; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2Ppmsv/NW3hZ7fXOt2Ttojk+u8ZWgJFOOBsm5KuHa4=;
        b=eMsXPRcDB4ymfszLnRgyQs5mCZCdME491LYiZskcrHzdptwtOPK5ylIcBGei+1/IRQ
         n01Q/8vodkE9za2erwIr5ZRY0BMTOTXvzIA1zf40khfFItMhWL0/JGyy+n/zGosK7mtn
         0OuBTGoYNLPwV4/fYzob5kvRHlOKqfrgjkdilFuQeu8i8PPDWvZbYqTiu1F7WfKpbWM9
         oX5EoUsEXLUBTPyKW1H1UTYCBczKK0vl2zwDVuDIu9ASe10XH9AQAo6jGgase2xNHQ/m
         knVz6Tu2Tc+xKGQz41HMzvHuqMP64XRBLhDKVOCeHEMyt2od8iamoHgk1ZqDxLEMKOHd
         q2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115698; x=1708720498;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2Ppmsv/NW3hZ7fXOt2Ttojk+u8ZWgJFOOBsm5KuHa4=;
        b=Z2AdXDoOvq3VJJIUm0zs3YhhXKVdXIhQjjsRWxvI5sbvcZxT8/L094GiG2fKflAU1M
         f9wIRFUflnemzzSuLCh4NbJJ6JK5WWmdE6+QnAueovxtc9cCmwzo8d/GUXqF9w6U83QT
         hThmqQXA1MKVeRK7R5aNdIuXbUSYgZXim9lC8kViRBvcTkZ8LPbgV0G6oAyJuwWY91TP
         MAXFjfocJkM/1YE3gAy2d/jnJlooL5jKsN9j7ctRMNSIiDEkFZoLQzXF87yNxIOGAZ9c
         LnICR3MR+8sxEvDxgFr5YdDG/DtCr9g4qA6IMyDvzWQUFDaAI5SSrbeS4PVmld909rpk
         MYsw==
X-Gm-Message-State: AOJu0YzQgRmO+MkonkrQfIECJBd3cBvnXXXTQMQh2exAmOW03kdqxyeR
	p6tks05eTTIq4EM/SFLzrTJhzfRYV77o4ujGKXVYcMfnxlc9Dfk=
X-Google-Smtp-Source: AGHT+IFU4uUg8gLQzyoAEAwnIf05e25NMXwNLsiIAnOHug7fispgxjo5ht+Rx1ls3VIMagt+1n/clw==
X-Received: by 2002:a0c:e105:0:b0:68f:2b19:5359 with SMTP id w5-20020a0ce105000000b0068f2b195359mr4596004qvk.64.1708115698127;
        Fri, 16 Feb 2024 12:34:58 -0800 (PST)
Received: from [127.0.0.1] ([172.183.51.71])
        by smtp.gmail.com with ESMTPSA id lz8-20020a0562145c4800b0068ca9ea78cbsm260198qvb.21.2024.02.16.12.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:34:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
References:
 <cd18123f3ed884b835f17e29b77511e5313b8b2d.1708082765.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup SOL_TCP handling: Tests Results
Message-ID: <936a0d6e-3d55-efd6-de99-32a67e7e8b13@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 20:34:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7935569600

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/758a441415a6


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
