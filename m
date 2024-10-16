Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62717C98C
	for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109467; cv=none; b=HGQvS/kzksqKy892taOEn9AXIcBVaHYj9Q07o63rRKznGW2QDzMkE+WMI+TUEmpxwO+WJEZnk+zpy68XivfrO5scJN/YHms8BuN5Oh0YbZrqYW3kQQ31kZVz2kdOazqjtdkWaq/sbkI/0eFNq8OLuuKRu/aoKG1bIwq9XLsaUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109467; c=relaxed/simple;
	bh=s27nhfyWfMVU/hM9lSjncqd5JiUBpsJzL+iQmBM7uxY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LZnRyfmq5X3pnsiZpJtXvwSVQ5fXwEyZ1QPXe9cs6V/MrOqEPUpJHjyx2e1d9qa3SXEHUQQqffiAZn0DOU0im0QlDyquY0R5Otk93PzU6O1KDDBy6Q/GLvjJiyUsPmWnSkyRpnksrN4cuCRjGgSVn/0Rq7Gv9AbuOQIiMMPUf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICsTipZz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICsTipZz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca7fc4484so1420175ad.3
        for <mptcp@lists.linux.dev>; Wed, 16 Oct 2024 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729109466; x=1729714266; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMcSF5xpczV2Kid5GC4+k2+mSpSKTcNLqM0721rQ2uY=;
        b=ICsTipZznmE86NklLDVfDE4WOGFxZG+C7iyERujawqXQsTOtwI0lwzyiTSkvWaXJit
         RwSoVK6gMH9ANMSh6mINbDN77XlAJ/FIFvphIwpB7NeFISPE4pxv5o9JN/5WeeaRk/Z+
         fOb0lYUg6yQkDpiL7L4fMc06+LAPj4c7wzvgMwOsJsVu0TePAZeRwCv9/9AAXiMVq3Lk
         ZYdEeZoa/JpKm9rjbSiHGCgEcxdP0fxjaXbljZIktfNZF7xoFmRx7J9ud2znbqEz3JAt
         RlLWDqeSRF3V98w/LNtk2U04jARmZsZUi8YvPF/97uTHFs8eTn0NQ7gCQhz/6TG0mxej
         fORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109466; x=1729714266;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KMcSF5xpczV2Kid5GC4+k2+mSpSKTcNLqM0721rQ2uY=;
        b=PmKgLKemAHAIDO/TdF3Cbk1wmDDXUGtcHbsZ18emRxlZv32Mq+v8+cEz2Uf5Sv3DAj
         qJc5cxvTTzQkFYVqpai8+0q/a91wBH7a3ghVdQSE87wen42b6W9lfRl0P5F6spiXDltc
         GRU7dtSavG/22wR57/enb7GK5zYi9yCV8gFdhXhcoz/OW5LK+H8eXmsF/qVj4sKS7+7z
         Wi0RFucVk81FTMx5qJIab2JKhyXTBElCk0jMBs1A585LNzYRDAeQNBeVj9icjUp6QjGI
         K3lhfxhEWjc4Y8s0mn81SF+kwRiv4nIwfQWA7IxPEC+G/ZUUaTR7EM0GMHOQ+4wEvCMJ
         E89g==
X-Gm-Message-State: AOJu0Yya/qqUl48poa0zXa8u6nSV1WaWXq9hG0+MVWLA/WAPts+OaTiT
	5qGMrSAR9CYxTxOb3Nh0aoNoXci2FM3FHM4CPucNMof6KRKI0IY=
X-Google-Smtp-Source: AGHT+IEs7J+hm7B4ZljUhkKXhVDETc7bq0R6xVlKw0yWgsv1xB/hxFnZCvAKwv92y0XyoqVdX10Tgw==
X-Received: by 2002:a17:902:ecc9:b0:20b:b75d:e8c1 with SMTP id d9443c01a7336-20cbb17d002mr285258925ad.4.1729109465607;
        Wed, 16 Oct 2024 13:11:05 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.7.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d18036293sm32670395ad.179.2024.10.16.13.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:11:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-net_0/2=5D_mptcp=3A?=
 =?UTF-8?Q?_=22fix_suspicious_RCU_usage=22_warnings?=
Message-ID: <d51c20fe-80b9-893a-20a4-912b17c51629@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Oct 2024 20:11:04 +0000
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
uns/11372377607

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/443b0dde1d65
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D899900


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
