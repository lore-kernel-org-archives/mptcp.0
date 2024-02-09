Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECB80BF7
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502785; cv=none; b=NxN8fQJCCatYx6mxipUxcPYzs2OrJkVcK1U//BCYvxAb/EfugnQHuEivRbgYx7M02l2NLyhxbhnDLeWr2PxhydYBqHsIgHCZfcJ2rhXEMylFMqhPexewvp13x0JD7sPQPNNf9vKnAgBMCpHAalONwX3QR4HbYW+fAaOojAcjnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502785; c=relaxed/simple;
	bh=mkFzniYdMhSrO9/sWNzPXTFaouRm4mFrCxv7glRkrXQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AKXI2KTqEoaKcrVmHuzzhDYsTyMNVfs1Kf+PL9wfuk3EjX1GXSomXvIzQBXl4e8uW2Bv5p2LS7Ln9vZqGKXT8enSrysCOIroDCNrC4S2+lgF0j3JpRe1JRWuW4ZIxn1n91D1cwa6AJsPbJ1ErmC2cHqshX2dVeXEkTMVaZweot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhQt3GYN; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhQt3GYN"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7857947b179so90385685a.3
        for <mptcp@lists.linux.dev>; Fri, 09 Feb 2024 10:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707502783; x=1708107583; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9TynHR5S+sBf+KiPPj98JLtUaemqid6+19RMDWsrok=;
        b=LhQt3GYNFmhnBt29zbLHPmgqyASBVjc1biLgdIATm1XthiCS0kaVSbfhpi7owrIcwj
         W3CEBs6IIptgWg1hSvo7CPyMFAgxx2wl4SbkFBOVihX39/VB/IWnTKqVueySznDTf6ho
         BCgmNAua2vhYRwsGfYu8TnB+g7A257D5losEQouG8KQPzW27WTIvXN/bafiUwdLXJ9No
         bGembCQt8lRgdMfGYPO/+hGBOGS1+3xg1OXEZauMzUT8r5SW6ZYnaWaAV3Z/08HeZHsQ
         PfKZ7pH3bhf5xL+j8HATkGK8GCnAiah0sswUqD6KHwqeMVtzM62TqIzDt3zKayKIWIx2
         aQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502783; x=1708107583;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9TynHR5S+sBf+KiPPj98JLtUaemqid6+19RMDWsrok=;
        b=o31FLx+F03gPLzayWx3dVC4ZvY9zPje/lVO7J3SD8995z4Lwy8Z5j8qtfgdD766Me0
         X2ykp7U5UkpclnWBTVKyE19UepZDVva6gAE8XMCKMjYeDGQ34x1riFjL8SvfGN5ZYvBP
         lD2gpv3HdZy1KCxeoAmyGWKlkArf+zfontRs7iJCEtxwMipDHtDtXhTAfLKLqzzM1RPx
         F8Ue6ryfiKDfrpmkWH61ismF7ga57RqrO/3sVmttbQbXMd5IXLlSBENtBCJUYRDIfwG7
         +APxf0qvR6r8PiJcyoAZUR48aDHXWCn13lwQDle7DqXQquyATtMpaoYXqcoFDagN2e0v
         ujwg==
X-Gm-Message-State: AOJu0YxBtpRAucpRek0ZYwMWqoBrb5DJ1z0EJubf2quw1C8O0ATCBMEU
	RuPjSrZI0Aj8ds99FEQuXUyabWjelWKVwQ1FlcNjB/Q21ydxw3gl0jMhat0=
X-Google-Smtp-Source: AGHT+IGzRyun9ARAILtHGGJhm4GjilFk6gdTqytVb8xSFpf0Pro8mPE3ng2uKqR216FtfoxTJ9ryiA==
X-Received: by 2002:a05:620a:44c6:b0:783:e9ba:7d43 with SMTP id y6-20020a05620a44c600b00783e9ba7d43mr2687448qkp.59.1707502783190;
        Fri, 09 Feb 2024 10:19:43 -0800 (PST)
Received: from [127.0.0.1] ([172.183.138.51])
        by smtp.gmail.com with ESMTPSA id p4-20020a05620a22a400b00783fe340e2asm919081qkh.107.2024.02.09.10.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:19:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
References:
 <20240209-selftests-mptcp-uniq-title-v1-5-e4fb3a3b5f66@kernel.org>
Subject: Re: selftests: mptcp: lib: catch duplicated subtest entries: Tests
 Results
Message-ID: <ad37e96f-377b-73b9-f27b-6d4082356502@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2024 18:19:42 +0000
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
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7847651579

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/27b6d52de8b3


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
