Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69E1CAA3
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705426637; cv=none; b=NGcgVVbckZ52u+LiVsjxlF8FjMkrgUQwV/2UydWrOMpjzT7P1Bh1yIhlgEd5/CN7fI1WWHBUAsZlelKB3oDai7+HD5KVbL0jn0F3jNcSev3Lu5nK6Iq205Kp/6ZmuwkZC/4e9sGBFYftqq9t3MzHtTlDzTKbZep69EILNYAcUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705426637; c=relaxed/simple;
	bh=FPR+wArbKuU6beqfJ/Kaf07yd5aps1RqrXb0I92BQZg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=TTNSunT7fq/3xYtNsvHZZukXUlsQChMYiRmswwiVsKrtHUiSaUZcInZsMeecKamkb5LwmvU5YPnJGd8fYOxgFdgkGMC/qcm2ergRNh13UECpFovBr8nLmmtJASFs/A8x+cW+MyiM4bJQQpRt0kTGn/536vA6Pey39sDbjgr1ILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEShzFqj; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEShzFqj"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78329cb6742so496704185a.0
        for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 09:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705426635; x=1706031435; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrTlKCyFjeAA09dFviZP/XGkLXJ0ACX5qboPFkLJteI=;
        b=IEShzFqjjoCQ1RpjTIBIAvJYHRMFmZ3nE0/TYA9voOpaYwmF/xinifwpbX/EnIMvu2
         ole4pGG2nL7ggEuESxGncPWW/dmDqW6Vl/GnXZVYfSo+iDeVgSbkhp5xTes3bfUibl6I
         sWO7pZtI3CgBgUaRwPyidlDvX9Ul/gCtFI0byZifBX91uG3uedZbb0DifzqeVa4Qikmt
         wWFJslt254wrYQGMoRsJ4aEKDR2zgeVVfoHizTofVIuUy+REcq+yxHZ7kSPniFIxoycu
         YhbbL9VgQbMbGj1398ye5Rty82E6hW38yIJ/vyLtpZtgM1AMI3YJwUDncUkpPeyMqe7f
         rPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705426635; x=1706031435;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrTlKCyFjeAA09dFviZP/XGkLXJ0ACX5qboPFkLJteI=;
        b=eaKYVw1ykspUlQ74H1IOD2gBDvyR8k//Yk4TEAegKPC/litNnXApC1lv2FU5PZ1CQw
         5fZ4rlErGQDLJ1BbEgQbvsfnB9p3/5wyhgFa6FY06ycmtXLXkO1memC+cxe9NfdHo+2N
         AIhaC9jBVsoeL5s3YB/YslbxpdKQjQfS8kZ8bEmmqjNXr5WlhEKGiIB/HfeMjWP8yQKz
         b7GHyaKi/QemNcG8bzhzkgiMEIayYWqAy1XHQ5sZY6g54ajH9WAE9636smK/3u8SFu33
         fheuIfKqpGmw3Bxp2z8sQH20Y7NrwKWuQRcFSY6fKCjmKyVG5tDcdZNagkvC+7dE0SVl
         jdcQ==
X-Gm-Message-State: AOJu0YyvR6rl5zLVR3tG9HKcQh3gakQXNBSF5YBXdgaVchwJkqXtTA8v
	9K2G6H1nUtiMGVA0HodDQs6549tt4A==
X-Google-Smtp-Source: AGHT+IHROCq988qwEhaf4dQHDWlm/N82l8KCoZKTc4QAMM7akfhHH9cwdCiWIznAmwDaCR1c1W3x6A==
X-Received: by 2002:a05:620a:158b:b0:783:3d0b:6f3e with SMTP id d11-20020a05620a158b00b007833d0b6f3emr6581909qkk.149.1705426634779;
        Tue, 16 Jan 2024 09:37:14 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.181])
        by smtp.gmail.com with ESMTPSA id oq6-20020a05620a610600b0078334ada139sm3870156qkn.7.2024.01.16.09.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 09:37:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default: Tests Results
Message-ID: <0e3a8962-b12b-0cdf-c9e8-fdee3728bafe@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jan 2024 17:37:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Critical: 1 Call Trace(s) - Critical: =
Unexpected stop of the VM =E2=9D=8C:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7545349968

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2572fed72ac3


If there are some issues, you can reproduce them using the same environment=
 as
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
