Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109539E16B
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682935; cv=none; b=hxPB2JLf2ISGV3/6Y4yMMHW4ghDSIDrZrOiOuWQQBLmEwpsTwdPMarXdXyu+Sjs6hr9JDWe0hzQbnBQ6xbJrELJTMI+YRGlT6AOnewbxBouSMg81k6rfvOj7NzqHUOBBc9c1r8kEGaL9JOEDaqVD1KrZ7l1oxtpl62Xfif+ZWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682935; c=relaxed/simple;
	bh=sFTMTkyXYAmdHNTlhAWo7+MHTHRJxiYSJXuskhbpQSs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cneWXmusEIwv+WT9htTppnS2adikB8y6515dfTCLoYOsuToombFKBSmpoCL9kLDMP3azKrX06Twc1+uxbkDbx7wCLWsnTs3DHDDhrCYmLsJ2r0jLl2G5I423EaX80aK+Ech4taWrt/YOOcl1KrKn8L3Zk8SzlA7xVa8/tgcy77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZZaie6A; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZZaie6A"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50d8da3e656so34151931cf.1
        for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682929; x=1777287729; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnJx0m2Ju3WxR8Np5CBDsQ4jiHNUtI4jf5HG4qX4zPg=;
        b=XZZaie6ADkDfFyHjvR2b5I9iYBjCXrQngYGjPl/SBYudm8KhVHu8EWjTogi+UgfN+p
         61mmJ2iXiPaDW/fgJYX4k1aUI9zARfgnR+yriQ++Ab5YGsInm4tZijtwTLLrLbEtdtkr
         Ipd0shkCoh4iY/nbhaQMHwC7GwNAXJ/ovb41zDZI7N7opDoWsdVcPzmmWLzL6UVDG3X4
         Ob+ew7Xp9FOOmBD0AA+XJZOy8jh303EEoPu5SYcRd+/Kcx0jCDiDzNN0sqJ9jgfl8VCd
         QMx/xVz5DWC41g2EuGMzp1K2Bsn/XrcmN8UGXuox3qU07oRxMAE0TbN1YIpJwMm18lnQ
         +xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682929; x=1777287729;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnJx0m2Ju3WxR8Np5CBDsQ4jiHNUtI4jf5HG4qX4zPg=;
        b=QYSVG6qG1XpVRTe+AJcsccRfOUmuSqP/8E/m2PlzKYE3afnTZ50pLIt/tXKjmKJK5E
         jHJDvWbAZhtrC7mfcJOtXUyo4A7vwzFr1LvHFy7/7LRPVWjYWU0/euVh4jpZRbp7vTnc
         Vs37UaYGrS4rg+o3LdjW7ChBis0XR/ik//IT6vHUc3OeRKrBByREqdLAs9apR/5HmqNm
         xuV7Zx1dKPdDNi5FsFK20ggWyndHcspiS7Qz0oRn7LKcUf/IBDkwSVbtIjQtN4K4HqHY
         1Y7T8FfGVC0C3X4OC4vo5e10RP5QdiYjihEoUT6zPjlu6MUP7Ts59MRpLODefQZe9shF
         KNzg==
X-Gm-Message-State: AOJu0YxLFns7oF/GD6wZEAw80k2US/7PdeD0R+sAlQdRHHLXdzReAp4/
	Dgy5n+7KS6JYm4w/5LcOJ73vZ8MZw12EX8puawGoOsJ+7Icf36uMK4zvlEuuvLg=
X-Gm-Gg: AeBDiesO4xiXEobwWCMh/0wZp7At+3OfHh0UbkjRjrIuy7lr3P/9FgaLRkgmdZUNKiG
	uMHEi7/nYHz5H8hVZs3ySDKKwYoEhkrLV5JNsnwtYG9hyWYQwC1zqQfJ1VAftUipYjJrVdIi2NZ
	vPy9FjHY3bItz2E/7JXwMxOyQJElir83J7yypdZH3EbJSHWTUq/2VWcpiVxP/QkgCl2Hd3GnoBa
	5blYDN23PTJq73B8Ao9tqbkVheOnlXIfhPubUdX1JzpWMBd8W0Qj5ZytAYaxjHSQI04weTe52Ex
	ya6HIHi3Hfv4WTOKDJnYCwoi2s75gSWa+99kLpkRPqWvG9yoLKaCXQ7x4wAQTwXsX/h/mPuOhpI
	0ICo52MK2PNs7RuyhwVR1vSTqVGUBYf31XO8JPBPchz64DvOYzeK8SQjTf2uZj+eKh7mk128jtl
	F4kuSGdIukyCzW1V70gECe67dDHdX80w/ddczzKUjIgy+q0uQ=
X-Received: by 2002:ac8:5c83:0:b0:50d:7304:1770 with SMTP id d75a77b69052e-50e36838aa0mr191367681cf.8.1776682929237;
        Mon, 20 Apr 2026 04:02:09 -0700 (PDT)
Received: from [127.0.0.1] ([40.116.73.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e61c191basm15840221cf.16.2026.04.20.04.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:02:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
References:
 <a82e275ccfb2609a1984d90ab559fa3af78f1e81.1776678050.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH v2] selftests: harness: fix pidfd leak in
 __wait_for_test
Message-ID: <c4885e4a-e0dd-9186-1961-3fea2e631976@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 11:02:08 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24659860268

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dbc5b80ffca6
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1083220


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
