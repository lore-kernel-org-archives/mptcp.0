Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE638756B
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 09:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121687; cv=none; b=CyfevUv3kBHoaG0hWwP7/ifA/ShjPpryUCJhbzVAELt33toLgC8V65DA4xg26Lyjb6FC+CQQReEiILY5gyflCZxvdNT2xiSuRDJHn0qQKsSPrRHk2gW+MePM434lhlwtyQnGmiRt9zPHNhAvWEmqLVpBxpr0q8wylya5EmgbHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121687; c=relaxed/simple;
	bh=pYJHrxFj2EhQqH7/Pkjxw3xgVzMNEPjWxCVUiuNTFAY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IEcSeR6su0YjDqkLPsZ3LM9KuVmE2UGok93DYms+IsGtUcm2ODN/6osXfJZuakxFvDDfozIS5TCFTrti7yhpmsrhgFNbDF1vQTYGDh1GKGAnVlz53glrvQr+X21lx930FWe9WRamr748lxbj0fq21y41IRNFodXsjZX/gzJgK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTqWIVHd; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTqWIVHd"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd7c372929so76792485a.0
        for <mptcp@lists.linux.dev>; Thu, 02 Apr 2026 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775121684; x=1775726484; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkxIHv1wQouFiQ+uIb9KXUzrkrHyyLF2VvoeLqdWSjg=;
        b=YTqWIVHd/11rc89Z51X3e031yt7t6saWta/krcX7F3Q2UkIi5tz39Sye5dUaO/QkFq
         0K+5b1QuWbZU0nKkIwEyuNv1+RAzf8qWV9rWDxuyafcNVkbVHHAdV0doWikGzy2GJh2N
         LdGZCXEjToc6/2YYlwW+I3AWGzQd9paAfL1bYfacqAT3lhU4vbMHwMRV7TnhRF4pgSAq
         zfVbj3hFu+/ZxfVs0OYdwoIEgPq5S7nc+75/TD1WKYYIfzNmtAGq1euPN0PMRcGSPP8l
         pGjHLHn+hbQiT/uW0ZPkT7vAldBPsr5UKjDLQw10HRuFPP4XqdP/FYVV3why+0RM5NMU
         W1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121684; x=1775726484;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkxIHv1wQouFiQ+uIb9KXUzrkrHyyLF2VvoeLqdWSjg=;
        b=qs1Mdvw0aLmpWbk+HZZBfZfjkzFqtAsUAkPL2d367pppj5yxz3/hy7JDa9a0psfybG
         K4oQRbW98IA58i0fwEXKejCjkq/bzJKZn1KqXiWHCqRk0FZZxglePs5SHbSEZuaLa0DE
         ZQ2dRZWvzK2Rs5qf+34/kKJGoV4YVhaWyZki06T/LuZnpFMtUY0aVj13cj910QY1T/e5
         Ul1a67wlIhTh/Cxb1iJl1RXnng9OVSpowxLfc/TSjVRGB1ilixja+dL0oiLTAiBpiLdE
         NoIw99e3Cymb83/hLaDDkRSgZQG9n3lPUjVD0LMygM1i4CTqxZD5EgkHe7evjIQbTeAx
         F4dQ==
X-Gm-Message-State: AOJu0YyIp5Y4mwd08aVw+wWIVlrUE1GJWckf54u/gT2XNKVGRtI/fh0R
	emd3DfGPozXlLCLAaQEv/DNSSwnssufFDfsbWm6ojHHSht0xZTM2cAr+TmuqrDc=
X-Gm-Gg: ATEYQzx3A5hvVwRvc38YbkxeU8ykZ+2hVvUNfJJff3G3uwNPqT9k9Zgg6MAbelqhAwg
	F0I8YrdJ7/8CmZ3s2jey/UKCyVyCXUtem8MTCH6dd1hJijQNGKsBUZASOir7DE/8jb8uC8KV1z5
	jOQ+zT/shDHtpAWgS9254vlRjYRB1bswSy8kziP3E4+tVXRCrTsitehdlfzDSYWikstqOkqaROQ
	w1dk1qypA1r3pu1IyGNVt6q02Ahdpm5h3Bzgn3tDZf65ornxvZZGVujxdjnyB06MhuS5oY5SR/t
	GMcNmUZdFaqig0PMDelK2bdSl3mUC11X6diQtw/Yg7gZB2SqfspGd6rNBf9BtlHIYJ0vi7Clk8m
	51lfFdKMTrFG1fhVrnPDhUymWgbda4nP11PhP0EsPJ/FjkL3gPHEhNQp1O/2AJXPvHJmc2di3ML
	bvPTOFTtbbamF1f3uhwIPvtnaNE4BulBIaWSkW
X-Received: by 2002:a05:622a:4205:b0:50b:3e64:9b2a with SMTP id d75a77b69052e-50d4b9fc80bmr36152421cf.20.1775121684159;
        Thu, 02 Apr 2026 02:21:24 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b8d9f7bsm18581571cf.30.2026.04.02.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:21:23 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1775115102.git.tanggeliang@kylinos.cn>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v12 00/15] MPTCP KTLS support
Message-ID: <fd0f8787-5395-4a72-451b-d348429e66a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Apr 2026 09:21:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Script error! =
=E2=9D=93
- KVM Validation: normal (only selftest_mptcp_join): Script error=
! =E2=9D=93
- KVM Validation: debug (except selftest_mptcp_join): Unstable:=
 3 failed test(s): packetdrill_mp_capable packetdrill_sockopts =
selftest_mptcp_tls - Critical: KMemLeak =E2=9D=8C
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Script error! =E2=9D=93
- KVM Validation: btf-debug =
(only bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23890722536

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/88f07fcab32d
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1076267


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
