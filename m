Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C74359A82
	for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776510194; cv=none; b=aFgD5GfceySQkSqJL5uIeZpyHm5Ix7+jXYHpA6Ix1cNlTMbUFSl07fwuxoMo72B41fbNmAoSgGhOM6ABr2pRLXRCtd7OMPnlyQojVFOwiTSY4w2Hh1GEDvTzydxOMcA1cVg8QqewF0+7TqDyB9jCHEvhlhx/kk8KgWCwqGftqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776510194; c=relaxed/simple;
	bh=u2AnkD6jmi06A2Z2mlmrDNlwAVICKlMWb6cFOm78HoY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=OldzMn+tBGa1LLaFQVKBNcMo9Gq9HRevSxTHyyRVI132DC3ixQJQU8FE2m5bohN2pa/xqEX76zA9l2F3OK2eyMFWsGHUGuzcO7a3inntdJDX27tcKu1xaf+cxJbPDTVfrPFqMAs0ACuluilMFL7VE6SCuwCdzjQnxzsSatd4oHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UioxwyAm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UioxwyAm"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8dfb9139008so101378185a.1
        for <mptcp@lists.linux.dev>; Sat, 18 Apr 2026 04:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776510191; x=1777114991; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evR0Hw1NaYGq5EgtC+l0P/UoeV+Rl3RTpNDCV7Pap9s=;
        b=UioxwyAm20OrxPY7jznbXo1e9fDWD4I2SGkgX2a2JnJEXJWqMWrfvbLruboEHraj+e
         mdnzfygg+GH+NLkK6EVuWbud97r1LuRIVP4u9wsqxWXPZ+aHjmFBYQCSZvBx9W5jNm7d
         GktE2Hfa3+4XdByIYMd/Cv/LwQigTRAumQuutXthi9AlSOWiFqGnq6JgveqNuru9wj/D
         AqhxwTOxWnJItXnGYGSpI+K2cHMawqORxAUQGLPKSqoEfiBM4MAiKsyR8xRr2XT8Cwxo
         FHxYASRI4wetHCaYx80oTcIpra56xNRJgWA4M85poGCiavpgetB1/mOfKUCW8uEonbtI
         KLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776510191; x=1777114991;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=evR0Hw1NaYGq5EgtC+l0P/UoeV+Rl3RTpNDCV7Pap9s=;
        b=sypTBwtmoDA2F2ObHI5nfdGygQOVhvsTTbdJllVQDhjO6UaW7GY6U5ICNfyEzFXmdN
         xxgG49Nx7Lk0X+D9hsu7qc+rW49lQWQrvxavDRt9TTCKNkGcIOMvHD0ioTxLiHOMmnAh
         Qo4z1cj3/QcTODZhoGeKeEuxr2FKBzHwP0aqF+ZCwt4AWGU8gYItiN30zE2MD8Driw9Z
         1rd6ep3lQRngS0QdVEKGRhWIfoyQyOwL+E9tPaqLXOPF494LU/vnPZ0d5K4GM6EFCdb+
         zC/g/FqI6JOydOu73/8wuPKZ369MFVvueroXjj08kx2ldMh0CkqjO72xE4v6qPkNfgln
         9fYg==
X-Gm-Message-State: AOJu0Yy2PuJtYeW6dstzI2+6R+gbYS8nixfioVSyRFdhbKLFRYecZdxT
	82vCw51ZFqGQVIuqm3VGfpPBBC3BC23hqN67YS5SjLvEuRcml7wetEy93Y4u
X-Gm-Gg: AeBDiet7uRClPMsx5XS6yyVJNWNR4t7zgFohGnZ8UwO5ok5U21vdsxH4ohw+AiW6lNq
	2ajiV3rWANPVj3wlXFqyXnuO+iJlMAw2FiZTCWwZLwwCuhRYzmzMZ6rCOmy8lhd2RftNnwFpT78
	zQQcZ9ngTjlu0m/hX11Ezb9C5/FXaYvlGrtsnqIQbBk7gtrIaXPhw9xLprUXmX56xvD9C6rGbAv
	3wqmOu4YTMu2fUjf79VYFGsIxrnyD22GeZSq+n5tHAAlDfXXMAwX+WzL7sw1+dwjs3Tgkk9ZAIV
	W4vHIsRnJGH/FTI4thpDao/M+5IwXIHWcxyHCHwg+0gEzrfcusQ+EP7ZePCJs3BnsnsXdoCDalu
	LBcZ+r0hIV02Uz6X6BfIMlQ7863zi+UKnic33mjDWVVRwfmjUpgo2CF+/ELPYdWB+hRWp6z4Jtb
	UfW0ZmedFEBs/P5tXMYs3lwk0dogO0ucHSbcDARXVEo1UlU8odYA==
X-Received: by 2002:a05:620a:2587:b0:8de:c429:552d with SMTP id af79cd13be357-8e790016461mr864262685a.20.1776510191485;
        Sat, 18 Apr 2026 04:03:11 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.196.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5febde5sm328112585a.4.2026.04.18.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:03:10 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260418100018.2219500-1-lixiasong1@huawei.com>
References: <20260418100018.2219500-1-lixiasong1@huawei.com>
Subject: Re: [RFC PATCH net] mptcp: pm: fix ADD_ADDR timer infinite retry
 on option space insufficient
Message-ID: <2eb6da2e-1393-c1ff-46f7-24fcfdbcb7eb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 11:03:09 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Li,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/246022=
64963

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/32c3fb79b0b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1082765


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
