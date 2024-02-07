Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1B1D548
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318113; cv=none; b=Cs9QXLwKs0e7IkJUqMmiJZJmdBS/NjtlncdrF43iWwLXkBSm2bHodEVPdLEK8x9eNjIkKs35p8sPM8axa82rZIHhAVexBp3qlXQBSBQ3MvbTkJ4oYHSTvzERq+si7AuGrgUKwHjIdxuJKVYoI4JFeLQ85RPIRlx2CKJGVHjiltk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318113; c=relaxed/simple;
	bh=SAPvfbCrnzR+1cCBKkm40hjCKmVsiqeyhY723kAMCn8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bSMOsTvvmzqL3Vu7b37E4kMIA02z5DzIAWXONjbWXnP2tZDbnV7fL9jNef33QUSUmEthLjiKSyzts0L69Egq1KMzIqRVISypUS4F6ZrtW0xZ59UdNfXcDOce49zFCX8WO0tRX/AyAHFf6hxNfUqEGatxscWlDCYGX4QHhxMSh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3ZYTgzt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3ZYTgzt"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dc13cbce45so535404a12.2
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707318112; x=1707922912; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZzcGXawDVRvSvstWOEI8H1PT++XYFyWN9ZN9KoE14s=;
        b=i3ZYTgztsgG2DRpq50PgRAzWySa/HzOkAgnyvGeo8+xHydhDr0JMb/s5/4CEjUJXfl
         qCxG99Jdr/p5baynCnp35fx38rWP2sG9Clgp+2qcPbfEkFI/3nMSfjq60rzpc4PwFss2
         GkEnPs6nQkzfMBRnNWSx5DQKf+IXT750P77wf/K5S1RcjOVSW/mG0IdWeaK9zDhItyjR
         Yb1g1ngsL/xnmDp9+axHaZc2DEvP7qW4VAIKurS3FxQMKHYDDhRnaJ0bW3yMQSkxllDv
         kpM3SuvlZnMi3mxF14Y9LizjAwTwULnV5iJceVlQT0frEbqzywqWh73o/cl+vglV7kvl
         pz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318112; x=1707922912;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZzcGXawDVRvSvstWOEI8H1PT++XYFyWN9ZN9KoE14s=;
        b=REG43MGVuGdU3La9b3rKIgnNudI3oW0unbkL7zBlRpvoh2AhDpCozGpHNTS2GKP6uV
         eSo88yWwgxx4w4vNZpLa7+QkObuy59kw/AvYkq8W+JXf2f5rUpgvkTjaOZj+ZjhiKW//
         mvhquNslS+cU9HapPYLZg7si1yML69mQ3QSnth91pGgcowRPYca72Cyvukw2mBZvJ/pR
         HUJwB/pTJBTyW6p2FBGXo7V7rFifS7NKAnGQqr72Ds/kHLzjpv6HOjxI5hm08i327Y5C
         Jl9ZJAiovPYopveZ2vZ7kXCWVXfE0mz1ttTawmCM3ShrtYcWze8lY3161o2pUfxm2MWz
         Tvwg==
X-Gm-Message-State: AOJu0YyiSY6kc/70rY3z8KQny3mK65AGeJuCCxJMj6Q56EEP5/4W8koG
	Jbov7XDqVtN8JCwbE8EQ8FiGNoXbh84I5LOQecNeT/Lwh/oA6FQRwLvZC5U=
X-Google-Smtp-Source: AGHT+IFUfXLzGLLB9y4g1yCoWkz50+ROKi1oFI/0a151JqizdHYs6BuHv6h0O50WfuH2mU/IgG9ufA==
X-Received: by 2002:a05:6a21:a593:b0:19e:32fa:b178 with SMTP id gd19-20020a056a21a59300b0019e32fab178mr4604540pzc.31.1707318111309;
        Wed, 07 Feb 2024 07:01:51 -0800 (PST)
Received: from [127.0.0.1] ([13.91.69.160])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b006e05cb7fd1fsm1660682pfo.164.2024.02.07.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:01:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <836391d2a7f44fffaba4ddf664354ecb8eba66cf.1707314646.git.tanggeliang@kylinos.cn>
References:
 <836391d2a7f44fffaba4ddf664354ecb8eba66cf.1707314646.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <8812389d-65c4-ff57-87ce-2b0b94deb4ec@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 15:01:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7816265075

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/420e302e8846


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
