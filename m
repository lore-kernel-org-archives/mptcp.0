Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1A84A48
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652060; cv=none; b=YlvXImrSrmTzhhyGfpsJtj/R1wWzNv6o3J3+YibBMOHzsfE3ThaQ6Z7QzqXJwRBqXDZVkrBhZ4QrQWx3hDF6dIg3fOIlp8Ez2GIWpWm9u9VPhN9xH7TYvSpodEtAPiGC/alFgNfta+/1nqUgfsTjbSVddKrKX8C4XYf0t8Naxv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652060; c=relaxed/simple;
	bh=iIUOKB/KiZSavNnpvYEaRa3YhebIAYF/zRLbxFztWh4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Et9E7PXEYo2cDVcTipLaklUXFnTr1OsXFMYRu6cTvEtYB35IGniy+HjGOFtpUN/OH4pnIAix/ayWK7UrOeel+y6GyfqCO/9mE7ox94kcXbeyh4Jje5b/ntJiykF63npqiesxIZmEtWeCtehfhiCsoHEhiOBxF0h9w8d0mEdxyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdTVKSFf; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdTVKSFf"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a14dfa68eeso447487eaf.1
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 07:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709652057; x=1710256857; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKIQh7Rvy+3mAHB8sHBUz/lxuma3/WkXXoYcrXJCI9U=;
        b=kdTVKSFfgk0abz0k+Skx8gHs585RWaJNo5y2dhTK9GUzJBgqFLgVrYTdSBkc54tflZ
         xNujBWkYR9IPHG9BCDAVsaaLC0pauEW1Thv9hswUTanfHiuMSj8sQA844+Cc0yAxltaI
         ZFwdqhz8hBwrRq8jjnbtunn2nl6YKGLQ+j4GN4yrsqSIoXY3XCKKWfOhOdlHI8ssgG9H
         Ah/2CZmO5jP0qou/Mr31g1v1eNY92TWfG+UJF4BM/mAHl8JOnT/Q7Kv7LpVd9h0RZ9iV
         PxdakTUqsg1mL7RPITJ4aXeJwaFMBHAcpJlxv3ApB3TezgcZ1EBUSAoozCDBYiUBdOVo
         FAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652057; x=1710256857;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKIQh7Rvy+3mAHB8sHBUz/lxuma3/WkXXoYcrXJCI9U=;
        b=Bm44bvI765Pma6Fwi9KMYk/V5ULjIp9u4E4vYCd0kfwV1n35SWMCzfeYrPHKj8CkOb
         tcQB9ypBWQ5JcnGw/s/ZtkwZex52iEX9RGiQYZKa8usL/UhIt9FtQzfsVa9Bf5f18Xq8
         i35QG5PRozBfnsjzzgUagZczk9iSQ7o+twkZT7eDLbG9UCFjdMdaDacqJzN1f7B6+Qz6
         amvGzK1fnaHcKMmg3asS4J5f+WsZJNL4WzWSjXPbr3yuU1WbOlw+BXMcvDtbWiuHzH2g
         uYTEHDbm/GVXeS+H6uxKvc181tkwAkTvY7H8a17jG19v9zx54nsjUfn1NjcIvgBpvPMR
         7URw==
X-Gm-Message-State: AOJu0YxOMsuocFSQeSt+djy/fFeiwAzSGsprwcsQH3LpQDojcpJoPJPV
	odsuftVNXDqoAfHlupgwWs/vHbuTAopLQ6fv7Qx0X8x+oyqQdkw=
X-Google-Smtp-Source: AGHT+IGjPaathPpg0f/FOBcCGzUXIJONU54SgyhLXpGv4JM+2GWPJ2cLR/1iBeQbTDhBqjBsZXoBLg==
X-Received: by 2002:a05:6358:5910:b0:17b:62ac:1ddb with SMTP id g16-20020a056358591000b0017b62ac1ddbmr2403757rwf.23.1709652057519;
        Tue, 05 Mar 2024 07:20:57 -0800 (PST)
Received: from [127.0.0.1] ([20.102.214.36])
        by smtp.gmail.com with ESMTPSA id k19-20020ac85fd3000000b0042eeddf4e42sm2352892qta.70.2024.03.05.07.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:20:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cf0fb6eb68466bef37d685cc8a52cad3b69c4e7a.1709647631.git.dcaratti@redhat.com>
References:
 <cf0fb6eb68466bef37d685cc8a52cad3b69c4e7a.1709647631.git.dcaratti@redhat.com>
Subject: Re: mptcp: don't account accept() of non-MPC client as fallback to
 TCP: Tests Results
Message-ID: <1b5d0fb6-0755-5a0e-bd5c-15a0f1fabfd3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 15:20:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_sockopts =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5651700250312704
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5651700250312704/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5088750296891392
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5088750296891392/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e08e8f186d4d


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
