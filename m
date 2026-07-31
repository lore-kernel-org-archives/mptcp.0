Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16F12DA76A
	for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509108; cv=none; b=GTd6kqs6I3O7J1T82iJJVJjPRAZ4hDdiSXGVWIYOGOoVpBwaT2ZIHzsLu3ZKGSe+xzSJ10lx7CS6sKrinl1NHRyo/UFkeuo4zUTobWbE/Z3K1+L5GDfK61gBlVJ1tSpY5GfsTTHxWcoRkwOVwvIYWGPKu0TzyBg7IM/LpOQ+10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509108; c=relaxed/simple;
	bh=h93XDm0vKj/HDFNdmQqSfrKL/9j9mbPM3Bc6aQeVmuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Jg5jAGuQ8fbpaMIrR62VzaFHumqYaWX8AMJUfYgHud/IBQSmd6BtmOSsOhfYWBDK3b2vNwAqNMOofwCmX+LJ6e40V8i6haYV5qnKuC4DuKA1R43C9K23t3JKA7t4K1ZA5CHcFzmfYCuC2IM1ITpCbEXihoatz30MwaJvvKlTjf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjZ/b9IS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjZ/b9IS"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39db07589caso9611201fa.2
        for <mptcp@lists.linux.dev>; Fri, 31 Jul 2026 07:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785509105; x=1786113905; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kYJFvYOVpEunv8eaZBtPE9OIXqHvKiUS0gAnkdl9eGw=;
        b=qjZ/b9ISbnCV5NR3oO5/sHzEdB5MOwxDH3FRoqg7HbF5x6ZR21DELiAdl3y+frhtkq
         oPzr8xjRC01o+6b6eP6aSlPxKL0r75BEp2fH44BQgRqyifNvmjpSX8fnyugaeHMUcb1v
         F0r159jw/lxpE3iiWHfHUGIWW9Sac3TNLzJptWmSFlwkgPL2BNu7I1Gt2T7S7eDS1++M
         kID2GRUggaUMCK6N8STZoZ5BLj0nrMbsvB2dNBuDRcc2Zbe+hgEgc55BpRiB4jYu6jRg
         Nbehu4M1jlYrpKtNd7okuHrUKHmW/VX+cCFuQZulK+rH62MfUIygGRkDdf4YKFepU/dc
         rJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785509105; x=1786113905;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kYJFvYOVpEunv8eaZBtPE9OIXqHvKiUS0gAnkdl9eGw=;
        b=LCAzoejtHXW3/tsR4b4NWJv53nf8rQcCPjiRjWDH1ktS4+gKom42hxxAXFyztwOdld
         hNJddPAHlNpweODFBvl42x0bfgp5/dTK2aoGGsp8qX1Bl7YFiA+5hO5sJt03JtW+JFAR
         kFT3PhwSiD8ajNzIPVAl/QC40girmQJEBoxpByBLXSB8xAZ8O1hYPJA6S4fi1WyVLCzL
         NIpd6jY2wnvFxBtihIHQVcB86vC+wqJyVp7cJfwLnpVhl4hyhVciSSDX4sj0xbhOlDfu
         WaOXxG0R2HOSqq/ObeqgkCS/4tbOlv2uRAfRtazoxUVD8MX1Db9RGy/uynTECC1uvI/J
         oIEA==
X-Gm-Message-State: AOJu0YzMI3F6F7iy0MpMNCEfzUU4bdCNL65f1m/3NtudiXtAutDQl6+T
	nqh3mMZFLWYH87OMnX4sBPkmtlXc7uIsQOJ2/3zcSZOjX9dkcxQryJ/vaQNm
X-Gm-Gg: AR+sD11tVqhH+k0WzIG71kHKAQe23I1BzH7nzKhsawrmHtK8p5MasF/sGIAkOo2fzG+
	RTy4Xb0tpKOT6Ycr2EAX3goKy3sYMSAugf6ONv+Z2B7dsycUZtpmmwJagYnvGEKKxU2N8jV/G0M
	Hn7Sn/V87o70joW5wO7Gl3IY+QD7lQ0NH6wwPjEOWpq1szmiQ6zYmXLeh4GMuiLp5q820qmxbBw
	V4Mgn4H2gXV1ubIoxvDvImv8VQM6bwdLZGcz4HiR+iDmBJQ8fzGa1lxrah773bUgGMDm4z28coW
	azGpgEA3+Dgp21J1XnDdLK0REJuS7DpQIaFfU6W+23HgN5lrFv/B8SxWOXzWU1gRMRCOV1BYBSE
	WVHIIAcFB9gNHik6tRbsZOJ8iKAVkRUEk12jhqJnluy1OK08/ibzuOT4l/GTifHiWGryS2KfasH
	j+ZkH8jAFXXSI3z8hjGzjoq3BurMOvHZwwzXzvfqtpOsjOksmTMJWM/CBy/J+Ky9M2PVjqTltIa
	w==
X-Received: by 2002:a05:6512:1044:b0:5b1:543f:f5ca with SMTP id 2adb3069b0e04-5b2e2002311mr520298e87.46.1785509104528;
        Fri, 31 Jul 2026 07:45:04 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.145.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e244dabdsm358054e87.63.2026.07.31.07.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:45:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
References: <20260731-mptcp-squash-fix-7-2rc6-v1-0-cfe460beb666@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-net_0/4=5D_Squash_t?=
 =?UTF-8?Q?o_=22mptcp=3A_misc_fixes_for_v7=2E2-rc6?= =?UTF-8?Q?=22?=
Message-ID: <efceb759-d224-0200-cc98-a565ab16c260@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:45:02 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/306366=
51226

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0090c801f5d3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1138152


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
