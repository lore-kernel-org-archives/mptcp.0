Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAC325716
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 07:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099128; cv=none; b=QlFubkIdnegn7oLMhJaUCjL6HeHvUnw+7k3TGFRxyq06q5LSd5kVlZCAUbZnKz4IDj6RynclTGCWoAsC2admMFoUEuF82noy2QuhY4sDBXWz627slMKCxq1XF8NAAqNaQYQWKr25fyMPf3Y6g1Ho4Y1kt+sgCvBhOOakciEhbS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099128; c=relaxed/simple;
	bh=4ukAd0loiChyfR6ekbyFExzBgxXW55D9nCwGWs9px+o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=nmVbsCNEUZvUZGbymx5aaXajtEdmieRS+p7XaCfClQ8qySkQht7Z4vwZEoQ4nAzEYciDujx/VDI5C9Und15p+saDgmzX4G7V7EhkOslhUCK+ZnaMmZMSMS6afU3S69R+PvsBrJzPjEJE6tQxBotrOpNclfEI6u6gj/Wh7QAvVw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlo2YgQ3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlo2YgQ3"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1696598a91.2
        for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 00:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784099125; x=1784703925; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HKnrWFk9/ZEoAshwAsx4q7al8G8BkJLMW1k82HMA/pQ=;
        b=hlo2YgQ342HI+UuQCQfBcHbYLUM/cUv1CV+SJeVE7P/eDnqFU+4PA1N4fy9uhMF4HB
         tSyiy9xx2B30fAKbBgciGR98wocHXDrNt+6v8UTnGYFNw8EfrNaWQIRJAKF5xzaBBxgU
         MsEvMAtAisEhEOj/Tbn1iO17JUA3DUUkC7Fxsa508Ix2DxS0W4YV02IgTuMdjvDA4i8R
         u7KTD4Ho81wj8uIhtb7WEKadsO8GKkVs07mMQPHPini29rrrWGGX4Quobde0Z1rdIa92
         cJqXzyqDDal73lDmedN+doiUuXTzO/gVMnSe2pwWWU4zKaZlcjXwcjTeDGUaQpTa5S9v
         JGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784099125; x=1784703925;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HKnrWFk9/ZEoAshwAsx4q7al8G8BkJLMW1k82HMA/pQ=;
        b=FYeufT46cRi7NwbcpXPA3ZfSc/Ruxv7neTokoVsyXpqTLKeTwFT/Y1HXSUCrZmB0Rv
         D8zZQlxEexnv3e7DvDRYyfhLK1yaH4xFRENTO0o10CYsoBY+e0eHZoV5MH2fDST2Cuj5
         h4NZ4ZK1DHEP/tKcWweoHeDrnrzPJBi3aVWK6JKfSW8jEkq5wD7C8f+d0+dxPOvQmjgV
         d/9t5PHLiZnfoaK8X7pxfiaSxhbbUgRwtJLVyOTX9HBlcS3+665i//+Y1gR+dnZZ0yD5
         ojAQXCgzvIchk1RHy8dzydN1mwWfr7wDvFURUz1PJUSmEnuZA5azI5zda0NiniRnmE65
         jcyw==
X-Gm-Message-State: AOJu0YzdhGf+1HJ9ebaIlDb43i5jePb9IV1MDbYhWPGmHuCFLyhv1gOZ
	8hTdIxOE6oy+tl+QaBo4tjg6iUqNS2tv9Q4CfVHD+pVOzVN/4f/c0j8kpVIq
X-Gm-Gg: AfdE7cndcZHznj1+bYljMlBxV1CU96Xr9as2a3RP24hOTTx/F2yQjMU6PH9IKMi5ggd
	2d6Fxk3SIkKERavoqLTLie5sadEVDCNdPl60l+7p042jEwBXHbKnRrgvYR1BunAzgYLAB+vnKNo
	3I+nbvkeK+qFiEKePK3/Xxm4JC8nUKDFrz13L9YNHfEE6U5l5X5f9ccO1gJzg2SZ9alpv3VvpqZ
	Mc0YDJv8LhLe1XTOIj7RMDmBJEY3mWQNM7vpfcQdmyfIb1rDR9IbYY1SlJkxyasoxz81qCJhfAs
	a45LVmnnUjJ/7G5MkimiBfOCoIhkNyKGIUELhtFJ1MOKL6tsSkHpGcaZSe5VZzFlR5cn7eEF0fI
	arE2ReyFA5lHu8xSTBODAWANsJpGbaudWJg9NjxaGZJc+EIy4uNP02yd4YIOCfP5dMth0E+BnYe
	Jenrmyg4yl2tGPILvxz2d2kG99
X-Received: by 2002:a17:90b:3a81:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-38dc782ab92mr15442646a91.6.1784099125067;
        Wed, 15 Jul 2026 00:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.6.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172fd17asm2653924a91.12.2026.07.15.00.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:05:24 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: luoqing <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260715060550.655299-1-l1138897701@163.com>
References: <20260715060550.655299-1-l1138897701@163.com>
Subject: Re: [PATCH] mptcp: pm: fix data race in add_addr timer callback
Message-ID: <1a0d5418-d101-b5db-63e3-c090adcabf58@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 07:05:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi luoqing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/293939=
39925

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/21265c43c46c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1127895


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
