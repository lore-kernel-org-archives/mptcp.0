Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BB313E3F
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092082; cv=none; b=BC2V2t2vM/PKLc3cDf4pd8eYg1XTRUxPDfPEQ95k/LBOpGLGP+1YwWfTgn7nA6kl7ZcxvCbroPQ0VMKkX7WuPxYawA8CYlYZ1nNfKvhIomBJrZXzTt5BSPzT25Ir09i2TOzaqLXeUdqwfEeDM7NEO8XeOayRa5hhq2U/mw2k984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092082; c=relaxed/simple;
	bh=JKJv681Y+VIXhq7Mb3A3EgErKUQKTVfjknlPPuHV92w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=BgZVuml74VOh9FVa8nWLNwtG65qFVxRGC2OXap31MZYnbmEqEQXjSMJUazCoa6+Me5noqfENf4luujqDUNlC8373CL/QKyzMb/a9s1kASY2QPccX+McDTzMDhY25rIMJd9HXKzGwrq7lcGDMxtYs6Dmb1+cqc+vSMoYLyXP343M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUUcWkFQ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUUcWkFQ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-91066394ef8so167775985a.1
        for <mptcp@lists.linux.dev>; Mon, 18 May 2026 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092080; x=1779696880; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+WCsoQt09RV7Pq3bB9PRGnpTI5hkqabEaprtyr2j7A=;
        b=YUUcWkFQbDYWNOj6R85dhs/spI/Q6DcHIBUlWnmbfBLodl7etn6LwRnbN7LS1I/M+H
         iKKoHkSEVunYQ0bN8cIsPNaB5Xw0l1NVeLUjXjmY3WNfoDAho0LHK5d16viLc0u9tz9s
         6wrtuY4p1CbNOJaUoLMEdeYjfb0lTkQFNKUXz9M39LUlTQbijwR7npqnF23qoLh3G2U1
         RljVmWOwI6nQlwjoqS7V8pu8v3Y4TpsgXpZ2qzsy/XfmWcynEZCGB+vCqRxdC2u3VAfk
         AJzIMU8hFeIXJ4Pdnb7g0MBfZl9En35o/uhjhHVOGGG53Z8irjFN0n5w7Yz8ra+Sf/IX
         2ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092080; x=1779696880;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+WCsoQt09RV7Pq3bB9PRGnpTI5hkqabEaprtyr2j7A=;
        b=l7bdb/CaSIl/qK5tdS6z3FZyEJf2p7Um+UeMQ9Ob88w/65tDIU9IlcbydWFDjOtQB9
         oH5zc1P1jZzSI5c7dwBgtBnxNJ9V/ysk9q+CDfR7ZzRYwR0hUl9hxoQB3v5ifeVomhz+
         vfW3D/vlscbi89GwcBTikrRAXxhSEzGTL2kSBW9jk6f0BGVwBgKObh1T5ejQrKQeWGvW
         97YNUyXFLmcE/VW7UhsdQQrX0kPAhYdMaqoTiqdtgQf2Zx5iAehPCNKAyVePblnxLPgv
         sCm00hDVjmJbpLfuVi7Ua4BZemPboqDccZEGjau1WQnim2h5OKQIDokMkafulH7zUVJ4
         bg6A==
X-Gm-Message-State: AOJu0YxrJIa+VNnjEbjEwJb6EpxGU8GwvcgxB2BnTrsdlv3wsnObcBvt
	jwTH5wpOOkzLHQl8UJ54JuYbcz4HjJeuWyset6LBMCX3rXTOi4Yss3lsUo0l
X-Gm-Gg: Acq92OHT31vngtTckkc/atfiUJSuli5Q7BQB73xMgXbcmgUcnJ5rISYx87B31OI2Tgd
	WvoYWQeeRHNibTH6orY4TNOLLetjjPvsf3Fh6qiMt/Zpr5rVXxh/Y92R00Pv44qoxQgdhOsxHIE
	VgmPtDSuhqpdCUv97+Z28Wt4hPy5WwsyNpaOQ0pqraS9wByG6+SmqXW+UkU5kwbQ7RkwU1AmEGz
	ritglb+hodBv4+LsQ9QKJA4o//fDeWSK5SwLO41F4U9iuo9v/z7IWn3WQeDe6H0MJfPdIma/WzW
	pVrpOPuuP7AX866yOaGiXsAE3Iil/BpPPf1wdFpWxRmmMj5tyHpRe9lUvWO4rVI3s1HSBsrY6y8
	JteEoQFyIXNHmLN2WJCQLPbHvqy0rmdN9RUwbRzlyz2pq9tTxnsQI/BS0lqyi8KLse05NqsGHLB
	Ot0+jSlLM4ILJ2Wg5zzRerTU3Jog4pT5Q+vb30dg==
X-Received: by 2002:a05:620a:28d3:b0:90e:dc5a:c07 with SMTP id af79cd13be357-911cda50a65mr1944870885a.8.1779092079631;
        Mon, 18 May 2026 01:14:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.46.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd62e233sm1422349485a.45.2026.05.18.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:14:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v12 00/11] NVME over MPTCP
Message-ID: <331ab24d-0664-f87c-d773-8359d5a69d4e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 08:14:37 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/260191=
06340

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/7a564b289d7f
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1096359


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
