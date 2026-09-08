Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512A35C1AE
	for <mptcp@lists.linux.dev>; Tue,  8 Sep 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890425; cv=none; b=GOBDvgk0J5PL+YSmFbUiIguadAXAh2cCUlxv8Q7nWENibClCz5GcPS6EZdNBOBCEqaVgSFdot1T3BdKh4SsoE8zx3NWE6OTu3ppMM12NL54FFBLNDf1+IKd2Sz+6+5Q043VtXZ2YCEBrrpuweTOpTyanUgpDVDJ+MBGWOUK5ZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890425; c=relaxed/simple;
	bh=lTEjHmC2sLDSyiS5cnX+HyHhA4RGB15Ci0RBAx9Miw8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=gD+gWFS+NxDewgX52xVmsc6RrVOUmuXzg1Z0xAw0atDOYECRp/jDe5ir8CMkL/OIrSK3GOJGaGbDYbTF8NyNfVh8OLtXcGfGsHQbb67Xfhfq6/r1sihoQxbOYYC7S+zBgY0RLan9FVL1/OfPIGFSL0RTyS/NR4G4ciFMi5QI2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dquqzBko; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dquqzBko"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b1a1a442c1so3290569eaf.1
        for <mptcp@lists.linux.dev>; Tue, 08 Sep 2026 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788890423; x=1789495223; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pOFnD0a0YXvuzUg5LTCBHfkv3zKG+OFHIaBZABoEfZ8=;
        b=dquqzBkoJouJfNYFXUVSbOxAMhY+B+92FSUMs1ugL2vaHBi5CEJx3xBaf3EqQnQi55
         d8+GrCQwPG35l17vbPLXv6OKq+EgsxwG1B+KlgmncvWi2rn3HGsY5wzuLBTgjlNoUDph
         cGfFt6BAfh75ATBYoIB5tbCXUDotKvMZCDGZikG6GZGxRYb2F01lI3Ns5qfnYMnAnsVY
         HhQHAaDNd973HUABQgnT/vcQAkCrJ4xI+Icc+7lNEeFY+jQ4/5ysVPB+aMFJjR6Ke8/X
         PhRlGl5I/yR53yCLvk+FZoV0SsIILBXlTFjhumOypos6+Mf4lQWssqjHWvnh4ecdV0j/
         q4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788890423; x=1789495223;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOFnD0a0YXvuzUg5LTCBHfkv3zKG+OFHIaBZABoEfZ8=;
        b=EBnJCBL86CBSoRQ21MauDEVlSLhKu2a4PbC8+EixJ1SjPNFip6Cu6lA1/g3cTQgZC8
         jO+GK2JBp4SN9KFaRytdPncaWnQ7FCXJcpt9S6IPun06Ge/ylwHpiAAjCcK484vJDEm6
         QaOMt6hIKLMGwO3R/3lNt+kpcRaWQMlPknJXVa0ojVKDK0oScayhDjVm6kl3nD0wfHWK
         b0UdMuXquDZWx3A+zSpJcRvlX37Fdrs2FetGhYHlJraD3dD7rfH9jX6ehFzgr5Ga14Yp
         3g7nNQF0DiNLug1zzKW4Jp6OVLDeu0fYtXjaFRmEOH0lWfjagd0SGFnJIV9+Z034spfg
         g1eA==
X-Gm-Message-State: AFuF++lnMI7VbhboJfEqvd9nh/PAQV68e6ww4HSr+Yrw5Y87xIsdsdvY
	nMxcibDQxFAbW/4YCBehBvzt0o7peGK6Lr2bNdrbLVRtCcsrHQOdnNc=
X-Gm-Gg: AYBFou2lfrdjCOR2MBEKYZASnJSpqa/gZ3S4SOPw5T/bOetC6szUaFlnlgwmXSlz1IK
	yxDA2HmMbqakONBo0wOa25aH9mZB8vvzWyw8w331PwzJFyDkk+koAgySFAMQk/r8h5sDtSyNuYV
	zIfcQUnIYTQP3tXQJEre8Mmpc4TsjBklB/jg5DFM8PyPDTHiVqajRoG3eo3jx9brDZfB05fkxL4
	jOkwjvBQWkIzHZpMKZ9cZkhkcblHH6ufbT94iRS+RsQbQj31l7o36SlDXDRs9SPN42dj6P5neEt
	lXXsevG5jfARm2xFC/QTSd1l+PIFc6JgdhALHlx+/KJdIp60P0PyROTHMsJExFFGNU9xOjhq22H
	h36/MSAKU7On7XZq4g0Z4wcw/3mtnqh7dM6Ht/9a0wYM3m0uDx40MLulpD4uW2DQSFHm2onqqGt
	G4AQj1t7WJdu3lyL+2QA4IvenSNL1bovKDfG5OwNORBFWUQ3zAapKViWIraYzbdqleW5VTyfCQL
	A==
X-Received: by 2002:a05:6820:1987:b0:6b1:2f12:6c0c with SMTP id 006d021491bc7-6b6ff164422mr29400145eaf.34.1788890421661;
        Tue, 08 Sep 2026 11:00:21 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.32])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6bab80ba74esm7413068eaf.10.2026.09.08.11.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 11:00:21 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
References: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: options: avoid printing uninit
 data
Message-ID: <a888a483-363c-6dd5-5ab3-fc580692e313@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 18:00:20 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/34255429754

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9f6eed5cbeb2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1160710


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
