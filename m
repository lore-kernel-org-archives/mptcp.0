Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856AD5C83
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044333; cv=none; b=CgbOmEOtoBg4zBcHQYNoC5mNLHeI91sxEXdBJ62ErFcppPTcRKUqWqP75mK/PIs+c//WN6BzwkKZTjEC2lCy++nfvyapKKjR0qUVF6fER4NYj9R2XZs0F9zJFAn7RjQvxM0G4K6rLpbkO6umPfyI1qEJZwHW5Gh/5EiEegdkkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044333; c=relaxed/simple;
	bh=VpsFeGOzQn4Wpr8wxu66sdIJCEajXKcAu1la8Fh7qbc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=l2aKvzGGiZb5gc8Q3Px/y4ekmqye/VeHwNlgRwTVfK2wueu4ySfsVaph/1Mb7udQYfKYWoaFy36ZdQqSyM85OIl3ZobRtIBGGifgHlHJEdkTpc/Z0iezcX7imrRdpk5C0RLK8E+ZBX1ymYHQui/cEbagXgkaF68i1ty6mebW11k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFw+C2Xf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFw+C2Xf"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78731e444daso82773985a.2
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708044330; x=1708649130; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds08WRs76Vh5dLnJJwepm9eSduao7yRyhs/GnUw6lu8=;
        b=SFw+C2XfJOcnRPZAcKHwlq7sLMoFd9bM2/LRs+n4gzHOdh211BXLIP1u1Ah8yk4ZTC
         1IBLan5InI4pPmtMggphg+sH7FsT24WkBchCAMQEPkyr2E7XEISww79czgmWEijYMw/6
         Parbr+ITUM6Pa2eCUvbpSqQfDhD/T1Z1UEnYWD/nQm22LZaKJUxW2fDjjbL72t//5pfn
         LGNxEh+hH902+DtIvYs7JXIyVTpO5YJnbz9Cw14X17JR0mTm7vBuwtHpCnJcv3yMgmCZ
         Pb3BJU+AjtPICbdygJCmG20DHLHjKupBAEqBF3/UGxC/KsMt03XiVa4oQzPNa7yYeHBh
         O3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044330; x=1708649130;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds08WRs76Vh5dLnJJwepm9eSduao7yRyhs/GnUw6lu8=;
        b=Ys65lR1AOt0/p6jKRMULjCs1ASmA1Ca/vY/TlreaM/ZETAHqRNpuVcbbC/n7JdH8gC
         rPTn/T0u0NVN4JMN9VyWPc+8f1hzdzMOLlvxFrsb2NEqm24SJ7o/3ReGg4YXPbyP1Ob8
         GSkMuZlG8Ohn4EcFEqZPeWja5xnffNgO7NIXDNVV3BscscvnBz0jTSFx6utluZTFBbdR
         HqtwouzOfYh41UD0+xeEVnogsa+/BIaTIXYCxFEpPFDDeT9G0bVXYTB2TMrajr0t31hm
         hdxppoFeQPbXfFjBRhKfVaaF93DH8Fmn9YZGoSWQtPYQbuE6YrispiyqMdmMOrjGE/T2
         hD5Q==
X-Gm-Message-State: AOJu0YyHW/Mzj1vlmQjA/f22l4J05kZOjwjlOpmVeQOG1UbQdm6GrPWb
	fvqbBOcZY8PNmtui9+IqZgpyE3ytcdH4rnnrg3eePuNmrzCBzqTj/rXD0KU=
X-Google-Smtp-Source: AGHT+IEEGBnWeaSihUhTDPR+ZTWHekci/4e7NzVcXvqA+qo5e9tTJlu684cIwReU80SOMP7G047VOw==
X-Received: by 2002:a05:6214:2a4c:b0:68f:29f:9d9c with SMTP id jf12-20020a0562142a4c00b0068f029f9d9cmr4506458qvb.43.1708044329330;
        Thu, 15 Feb 2024 16:45:29 -0800 (PST)
Received: from [127.0.0.1] ([20.49.54.2])
        by smtp.gmail.com with ESMTPSA id ly10-20020a0562145c0a00b0068c4f1da09csm1192771qvb.120.2024.02.15.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:45:28 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Subject: Re: mptcp: avoid printing warning once on client side: Tests
 Results
Message-ID: <9ca7ea00-9b98-4c87-4087-2dc50cde7bce@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 00:45:28 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5597464493817856
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5597464493817856/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6723364400660480
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6723364400660480/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/70f039ef7f55


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
