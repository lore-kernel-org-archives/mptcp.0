Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F7449650
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080527; cv=none; b=CenjDg77L3YAuiw79lWyhIFKZlPv04yzJYY+u9g3gvrch2jk6N0zF4r+OsKtxjdOo7WSs6au0jqeUltwmykse8rWhkROOvVlviUn13MbRLErLcb/6B630f1ME9bPwq73pbKglKPLuv2AH/i8ha0FeS+ddTyYF8K/mJYWSJS4BRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080527; c=relaxed/simple;
	bh=aQ7N7nFyW4odYxjRSNfzvvvHf5Hwqs5v6E2WE2fesFk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bRnT90wOvVt4bvEnNN8n+CWrQ0gxrisDniVqkJ5TZPmq11U095XE0V2lpOK+ftMVMWs96KjD2a9QWp1mMOeA7OH7RMxA2TmmEJ7L/nX/t9Zn+XvGoSEYwdtRf9wRlpUBpDpZb2rvoiqrCZXps7LwMJ/qpvrFMjL5Pqtty/Ad9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtVL9DhE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtVL9DhE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70af8062039so3207068b3a.0
        for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 14:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721080524; x=1721685324; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GtctIsc6vJZqlfMlaWA+DMM0I+B4FCD4RB6wr413mE=;
        b=jtVL9DhENPDtwFK16pjIQDgLuHKiwX10MUTqzwtISI+E21cND+Fmnl4nyNBSIrK3H3
         0Zmy76mxxeqSsO7XW6qoZMSjaaOg+zpXxiPCwtdt8YZTrc8RMF28cNxZG5tlCe3gHugW
         8Y581fQDVk4B4UgKxtM5xaW120RD+pAFdxh3uGdF/2ehUL8MW2OPgTCsfU4+zBHoEvTz
         kSDAeqEXRtGawvdUtRnciTOpDHQUvO7njeLQaLR23eOLkG0WrEGjU/JjbeTklx/qvJQ9
         3s8uIWQZCEZXNSzw4MmzkQ2SYhkyeysLFAC3Fogp70ivvghapbrsqEdktd2N59Q+Zm7B
         Ak9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721080524; x=1721685324;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7GtctIsc6vJZqlfMlaWA+DMM0I+B4FCD4RB6wr413mE=;
        b=vuFZtowTRxbXSGoLRYT70ySzmh7yFwJ/Cz1WdDNtPXCv3ppNabtsky7/F2NKv8GKZk
         RMzKS9ka5zhHFMH8gx95FzdmmCdoXzaQHC4kMq4s+0E26w5ysP4mzd4j6/5QGUNEfZ/p
         5E3fsn5Xj1Z7QjBrjZ7Q9cJWsBrLQ76LxStaLeN6vdBA4I2ldu6+8NzQOitbV8914cKT
         ZOBaSY4NTdFjbewqKZrMiyvMhOkesOLjo+/TGv/wuCgmg7gP6q0d14WL4zsmxooemERX
         WwKvYfx7yPwYuPCK2pBBmIj4zc0Vo696AxTOKTvOOIHXyEdve2m5Q1ZaGm8+RZM4bm++
         DGyg==
X-Gm-Message-State: AOJu0YyfI3wWPKXq3yi9kOWMtHe4Tep/zHUh00CDO9B3InZGo2iDsYOq
	3DbBzJMCSPWCFrCsl6QciUH1cjHaZ5BxhLRHfSlHdFqNUrbWaxI=
X-Google-Smtp-Source: AGHT+IHkNU3RKlH7nCKR8+J9Hcv3ZNUnPPo0WRapfSd5Cs3OHeH0MjOrZPfsNK3NHqZDsTTcltbgkQ==
X-Received: by 2002:a05:6a00:2410:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-70c1fbd51e4mr463101b3a.13.1721080524125;
        Mon, 15 Jul 2024 14:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.38.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca758fsm4866560b3a.162.2024.07.15.14.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 14:55:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
Subject: Re: [PATCH mptcp-net v2 00/17] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
Message-ID: <afcc1c51-162c-07cb-c687-f3993a4c5653@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jul 2024 21:55:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9946799319

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/303d54a702ed
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D871305


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
