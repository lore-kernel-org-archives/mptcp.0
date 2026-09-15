Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448D041A504
	for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475465; cv=none; b=Y/ZLZLrhwIiLp5UA/JVDFIfpn2MzF8RWMAif0C7xMbDXh259iaexsQnJVD0Lga8ZUkude3KeWtbhuAh13rH1eIZmEzJozdEcq7SuCWUrw3z/sR8gcSb6cF3RXk5DmAbLh3DPsvX6rZMB1jO3BGBGcHzpjSQzfRKys5/ezOXMZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475465; c=relaxed/simple;
	bh=hUA5HTsaFGwJ56c5ytlNmYAg5kUCbb/bwhNPnMPUpdQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=LUv5BeMSV+oB6M2Vyqs8bKEouApZlLFBCKcDmgIcJkjl5OTczg0uZFuuATlqRnYWqHjUYsmFAzSipJRGnpO1uxj934c+qjcDushJ7ey0KYAYdBAWmp3jMohtiTlHNOCckJiQlxnXgoHIYkCjcMi8Ull7ISt8pGXYOYm2kBkUqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7/3f6ym; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7/3f6ym"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfe5a07cso1248536d6.0
        for <mptcp@lists.linux.dev>; Tue, 15 Sep 2026 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789475463; x=1790080263; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PphynifFV2pNStM+EM+aquKgIAFCT7XJtgTNl860MVY=;
        b=s7/3f6ymKpHVv0OwRiH5BqFoSGpdLnd7f1cIS+WQ6fX2ZoghcYc/IYVVCAPIsTelAe
         Bn7yQ4EF3nv+T/Yq+5Nw3j/NAdhPyrRee4VjhMOw5Q48BS/hK8uEYFKKuDj0F0hTZBcN
         Lclx+FuszqImPz86eMzYlF0spubTSi1/S95R0x8qAQcqYMDj+B5hYndTG8mitQYgQm/T
         zyPvmzY/gK4m+5RglAzl3yM6N3Plv2GS9v96oJVMR0+8SilUPt2dTxPZOwASf56hJSNL
         pITJ3jCWGjGDfDzdudhqACGGVMEzcIqrdw7dD2f9SFP84oJBEAaIuTKBmjnZR12EBPeW
         t4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789475463; x=1790080263;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PphynifFV2pNStM+EM+aquKgIAFCT7XJtgTNl860MVY=;
        b=ABB9RF5M4kY+l2Ta+R3WEsHQcWqAac2LRE3P8vx/UKAgopsUI8Ggxq0Yz9Yb6Dnoxn
         FUEEZ0kpnAwE1CJyq3Hbynfx+TpGNvjuh+WUSuCvhd7R1A5chf+nUcCtK+VHGNKwvfGd
         5HcAHGwpiJJDIUXKERPOe21OrodMKveUmuJj1wrvGntDDnAHIaaReAEnx3wnxAP2xSel
         Nh91WyCryFxXKcVu7QnxmMixh+7A4GnUbWfDtSl7KhJb1tfzIBD8P1owMd1PGe5ISJb/
         xkX9efl4KcukU94FSbyGhQXTL7RARqHae3obb9qTh8pK8RbbOpOWEv424S1FQ+JEBzNQ
         cIHw==
X-Gm-Message-State: AFuF++nfZrd6q+STxEWXNAzgNk0hdMa38lXRLw5hDXsbhGWtXwdgo+Mz
	215eIPb1oLOgcA54hPV8Mc116t7mkv/tgEl+w1Sz1pzdj/T7wvLL2Nvk1Zxb
X-Gm-Gg: AYBFou1U/Ia7EQjGa+PTKAaPo5+vR7EzXLYf/2mUjcKcN47Ee/HHrofgBqSY8icwFca
	hkNOrKDm3qkfbeFiXfarJkCcYhCT1vUce+XslSlkQeK4JOslKFM1Ez2k5ZEFZN8swg2LgdnHhsF
	rIjhL7gv2/g/rr1nmpR4BwMgPH2WfXOZdJfKEae5Dkb1ynKJDHZ1UqKJdSZ8J+hz3ldH1QHyAG5
	53uI9er+7oxpOptg5zllUD/KX9BTeBCoI4tMifb+OmwUpmwotNyIL+wF+8s9m6VXNmZ7GJw/6jq
	MisZpm6jv0y4Zo6M1WJJ4hUWPrNrWjX8g6grkTFQdivV0FfIbUNEj/3URL7qRCrIu1/OhB7Ec2d
	pwiclxoEodFEDUitpRaPVsW6Nt5wdzRB0sBqof3aiTmQi8C3WleVaA/fdzKcFtMFBP+zBK2iJyX
	0zRPfPns5F8b4Mhgj4ruZT3+lbiC/ea6xd8lxfG0rvLECioV4UoyMlSQoX+d7zbfc5q6wDkETII
	2otcbpMVw==
X-Received: by 2002:a05:622a:681a:10b0:531:2685:3853 with SMTP id d75a77b69052e-53126853ba4mr5526411cf.62.1789475462818;
        Tue, 15 Sep 2026 05:31:02 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f1a2e7sm1271503485a.8.2026.09.15.05.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:31:02 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1789469930.git.tanggeliang@kylinos.cn>
References: <cover.1789469930.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH v2 0/2] Drop redundant tcp_rate_check_app_limited calls
Message-ID: <c0925743-34ae-a676-ed72-bb360d01f522@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:31:01 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/349648=
39210

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/80478bdef8a8
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1165425


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
