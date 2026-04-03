Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813D3A9D93
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220324; cv=none; b=HWEaOkwg4ZnYY0IIpButytYezLT0lZeuUYJUZvaCGijyHgrSv9JM6ajnX8Lxdx5Axeivh0y94XB5CFLyKviW7SE1UBYlrBm28LTegIDjbClB6p8iI23WXJGeOYSB7wyqZ82tuRkxq4k0T90cY8VtzKn/MD41CWYl2HIEwiiLTnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220324; c=relaxed/simple;
	bh=ZFWq9fahOZlCpPnOCev2LCXMBVcyCOtI/YuBQF1bkJ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=odGKl36CBRsCk1XIvBPWCs/LX+heMnfDscQDrTJw45AsMmS0MkHM2N72KQqR35yZtQ6iA+nmZNRuxLMmupoi/amfuUMuAgbzz5B7cqE+FcSP1PtDeu4wjW/LtPYmKlqda2O6P97yUzv8CxWUNav10+HycFr3TXsTrUYJ7qVutAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tOZckh15; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOZckh15"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a3b0242631so24158136d6.3
        for <mptcp@lists.linux.dev>; Fri, 03 Apr 2026 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775220318; x=1775825118; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DdBBzq2PB44d6DAsnzwYxjYrQ6Uk7UaBxxe569Bm8w=;
        b=tOZckh15Pqk388WxLS+WZd3gO5pCXPHFCVoX/V5S978CSp8534hg+lVldt52Zt5+iJ
         icNSl43lfgRs38XRkjlXWpDrfxYZe6EM+SDCjcnIbWzHB+sPKiJ6AVIvfBaxPw+sfrEm
         PcjAqMwFIvnOPXL2RbHn1rzXkmsn5fQyPE1mfCZoOI/tE77NfXxvqEY8rtpXQUMcJzGf
         kntX9G7wf6/Xev5xpxlZj2uRis2XJxWDdi0W4hji59rYazRrqWVeSAdsiL4xPkq/22DJ
         SuJiU643xXX9TYu6Q2UlTgzQpklComKp2x60iBHIVrLaoMuUxL0MbRf4ETJ5Kf/9LWE2
         5kiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775220318; x=1775825118;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DdBBzq2PB44d6DAsnzwYxjYrQ6Uk7UaBxxe569Bm8w=;
        b=ElWrcisFxHhwL2Np4Y+rQPvqHPgYTvsBHPRkRvO2pUyavQIZHf5Y2ALHLR+Z18l2Ct
         yJ8GSpfwSN6owEy0chhGRQfYpEHYz00h9AHiH+mAUvhAT31c5HCOllYGdO6ejJck3kn0
         b8staR1Nz1LJawGJErXfpL1LwC7dwkGClvxcw1jSQNJonh5ETPpx6nWvI5GqD4LPm8E5
         KqFB7mSjWC1orwDHenpqCAcHVWbNZ+XxCDjekgRHK1DHescB4p3Nnl3Ji8rP+Qo4GeWK
         TyUPX5R2y3a1P/tBMN7BqqHthwWdozxS/4BVjg/gxbHvrfrwQQNLdObZ6fMg7hLe4OqT
         VWrA==
X-Gm-Message-State: AOJu0YyTzZGSfUxTCNqeaVCrD/cw59WHNua76VEs35aG2zhkBRakuHio
	5VQ071sZfR0otiVK+3StyKyOFyrZPLrSedJ1xtrcdEicEhcyQ7t8KumrTHDR
X-Gm-Gg: AeBDievN7YAxYM7kwEKPHc+ZDNGIheD9laygnj9L2whLcPqPXbmgXa56F9gXZvu06Uv
	q/aX6kHhJcuxBP4+R+KiMPXtOkjTvD+ZZVMgzvF6ych7GNo2Ylieoxe2wR8xex1ZHCCd0wCWG/z
	4V8mD1oks5TOWqA7JneXtxIXQPzgdSazL0g5njqEW9TTeDkWTRf7rpWfe0gh8AeNVuRMh+Z+JlO
	1rwbV/q5PffD8cqXtqmXZaHZGw36GkIGGmbyT+cuR5XH82gpjK7HxmFjomN3U3jknBvzpEWg6sV
	XfB9HLKgZr257VkRt33zpCoL+DON5jTEapBmChhsQCzdsLtj/7zmJgV7F03acDQeQumLtDT0fpF
	Amv6c7747Q/lDagBMDiLR/AntKRhjzcYpiUhF+cTdjWKa2T2XdRnm2cIsC0CU0OZuonbcNKJOlK
	qo6IlL7WvfnxsaXipxBgT8veYSbgvxZCE+mVh8DQ==
X-Received: by 2002:a0c:e006:0:b0:89c:4cda:3cb1 with SMTP id 6a1803df08f44-8a7020c0a1amr39633346d6.10.1775220318320;
        Fri, 03 Apr 2026 05:45:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.45.198])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593bf2769sm48369916d6.14.2026.04.03.05.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:45:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260403-mptcp-fix-better-mptcp-level-rtt-estimator-v1-1-b22152ecd69d@kernel.org>
References:
 <20260403-mptcp-fix-better-mptcp-level-rtt-estimator-v1-1-b22152ecd69d@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_better_mptcp-level_RTT_estim?= =?UTF-8?Q?ator=22?=
Message-ID: <39dae2fd-bb32-fb40-5bc2-cad29d5a9b4a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Apr 2026 12:45:17 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/239453=
39282

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/abb75c9867cc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1076965


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
