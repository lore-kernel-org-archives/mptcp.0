Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA8384CE5
	for <mptcp@lists.linux.dev>; Thu, 23 Jul 2026 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781140; cv=none; b=jhxLjR2n8Owk8I4Gkf1/ntPT4aSHGGOIPKa7UmD5DeaKNLNF5X0FxPkjRN/ca92qJrjwaf/VKYTTxwzbPpJ+38tWU5CflMDl+5+t9tAc3SEj6UG15BjZBIeNfj9zvZGrFjX1F7Jxsr5HhIgnZQwVO2Y8BfsuIbhd5cYea6+VBF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781140; c=relaxed/simple;
	bh=Jh+j6dT9IioEapW9/wYwCKX0mHTJGgXPcioggbxXZSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=R9isdqUDZc7T6S9hTwM8hKouAhzvceXhFlSKK4+zWEbV+V1I/btaLF7m06ImbiuuknxZs1OUgF4hqHGquCK5iplpvGr/E9hXo3d8kuxN2AmGElmpoR9jmwtzgh7DaiHDEI7hkm0jhNySOo3J3kN7OVk+vgltd02wZsz7XXE1kBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRTdSPhx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRTdSPhx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cad4170e8eso3516415ad.3
        for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784781110; x=1785385910; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=33llZZ5Ev+L2gr3Leb4K7ySsJw3k3EkLi9Nv8aCi1t8=;
        b=dRTdSPhx1C+W/Aj+/7ptM+nu2je/ULra2lKTJn7o8MzSTOToLKNoWfJLEqReWOp/o/
         6yRkB1OHk3mNaclPl7j16QOxi0Jx/9UlavAzWo80YnRL1IP+1m30SwYNKyOU6eji+K1y
         xtNjYlSsoUJAFMb9FHz3oBqZvmDxiUYYcL7buJMHzdhDp1cJHnBWWzfqLl6hRFBcqIRa
         rzPsonMUKBbSI9wVfJD7h/tLEbO1+AEdagX0b+mY2NCG4ipvR6waSfPEszK1/7Rppf5X
         TfGaxwVFTHdWmz1urCDgJdkmNTDJxz+ePpvoMlY+kXG36CIDqjpyh8uLFwi78XrrP90r
         5K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784781110; x=1785385910;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33llZZ5Ev+L2gr3Leb4K7ySsJw3k3EkLi9Nv8aCi1t8=;
        b=kr5HcHUJ8Bhl4qqNeISueZRfeI2ucj+bVR7gHg3dIqGz/nxZGfq/v58m4jv8+A6Al4
         pfzmWIfD+5Vqwp97aXYeUMq/wpRVjDgrW2iloZeTA7DGqQGWb0bQCjvX1RUaNVP+Dpes
         li3ydm+kx/YQquMmvB8FMK8I8oApgJbNQHKyBqq4tCQzHauzGi7dLH5ySKCEwOY9rYyb
         RS/zHmnoNxgOcyJlXJysgKeN7wuP7GHsys3sjKfELQ4yys+boOKbKFwW7pOD6Eab/x1A
         EakilAi3247/7iEPVKMzuUYlgItZFbPaHFzrHbMTBqdi7NnWExp8pA9HuAH2odM4mwAe
         KhIw==
X-Gm-Message-State: AOJu0YwK/R7p7mrpO5TPduSdCJ3WvARhPZKg56Yvj149n4TVSzc2Y0Up
	Loacrp31iv7xDE/M9ab3REgj+r8uKL1pD9i9mHBg0fMLKvlzhk5jWGlsxTzy
X-Gm-Gg: AR+sD11Wqt3GA/ZAgE8Ovu2rlf/B48hSL0Et7CbPA5kOe/e24v9hkgKdBJv2HFKYpO+
	SWtEoIPQFCyyLqUioS4wQ+yl6Z4LNDX8ZuQPBUZljDe5k0UZC8WExmipQL2B70+vBeNnsj3cHc7
	0Ew3VV8SdyV3SVOo1bmDmJqJF2hGOKICfalMxtNXk8/8fx2wQIRyOo9k5mcgO+MYfJrEJDnCpAj
	Zkf2ZL3L6JqHMjjADwf82+Ts31niP0QCRyrwBEXH9eogTXJ0X3i/5LJpElHs6hKS8ut+pSJC7U3
	qiwCHWDQmQ+GcdCjYuKidDdrtbzsauXXiNe0aVLr/EQPCT1CaUC7mM5ozLrdxPOrqStkFr8vA5O
	qr52inFCc73soqVjwpytqhm8Mg5Ezc411rbDyjR3nITQnyQ2PTDoLfdJN5Rc7AeqhX3ADBVxia5
	Gty2VgL4IKkpPPrmg=
X-Received: by 2002:a17:903:3c24:b0:2c8:1f58:55dd with SMTP id d9443c01a7336-2cfa6a43f89mr20953965ad.9.1784781110128;
        Wed, 22 Jul 2026 21:31:50 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.67.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e07000fsm28052224eec.21.2026.07.22.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 21:31:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Qing Luo <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260723032324.189675-1-l1138897701@163.com>
References: <20260723032324.189675-1-l1138897701@163.com>
Subject: Re: [PATCH mptcp-net v4] mptcp: pm: fix data race in add_addr
 timer callback
Message-ID: <62e52f72-7c47-97dc-3198-8c1e33d39b5b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 04:31:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Qing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_splice =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/299776=
60387

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d751a7841525
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1132868


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
