Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6120B80A
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140117; cv=none; b=C8dKXt1vo5xteZFxJW3H70x6w+TcKJa4atoSjSW84EfGW4OsEkVErVMqatc/zrF8iOu8MMxdvDXOdtUZFg1msp5z5/7L4gLv2f3dQgEpm9g0HpC17TZPM+5KEiHKm4p+0cj5/Rf6ROfOFwBFUu8E6K6qO9ZCIB7t90jv11b733I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140117; c=relaxed/simple;
	bh=7WYoOD8Bq3//fuC4vhkKHxZWuTVqQgppLzfkczD13Ac=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Wr2TixE+RXTTjizg9g0zqu0HrFGBb+BbROa3tTeAyX+fThGfw7+siGE61JnxVxDNZ5yQQYcFqr4Zj24YKPu44yrsw95Ud1LxhZQo6lagJ6pH5nq7RtX12AS5g+mJVoPIveAG0krJste3wRbQ6JT6qnGUWGRPmMkEo6CniLqySQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMefxv3A; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMefxv3A"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d95b08634fso48203385a.2
        for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 02:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752140115; x=1752744915; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfLFAeNDkxyWGUF0LELrivWEeaAj+6YnZn/zzFpTp+Q=;
        b=bMefxv3AFfgVAd/omH/UYAz4EAYplz5PTnkBdcqvyyWiKJLSM17u+RlbAgA9yjqIkG
         5X9yAAkH2aXnGYhPmYkbAMa8EU8yb/zdDelf+34Kznw9gkXQIGv1Bm0GrkJrQSRwyn1u
         4WZG4b2L4In0/d/MnAs4GZLDtkidSKuylSUKpPo7zbUqFTmnjJ7NarmjMWGBiFneNJmz
         L44FN+x3+WJo4QPed3KpOZnSRBsRnk+jOhI/d2ASMe+uw5gT1k/wzr+8k0v4HZ6dx2/k
         u3cw436ut52b5UEQffu4uEeGIS/qFtfNijwv5f83rCjCYdKPeAFFIUPBQy3NFaxKvYWO
         v/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752140115; x=1752744915;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfLFAeNDkxyWGUF0LELrivWEeaAj+6YnZn/zzFpTp+Q=;
        b=CMOrLtl7t1DDuB1ERBF7aSxZmYRytEUAz6tGVxU6uWBK185Ik3fGR+2V3AdfywbBMB
         RAAwXJVaiokSptbyQfihovH1ttHkvyyjMJbO9xWfnMvUbZoKUM6mq7uMlZveyeE1+d0L
         9XRAKiSFAtLKWpjF2h5M9tDCIqEHuzgN3ZV7EOnk1tj3rekG8tFx5E6TUEvnx/gV+hFi
         C/1dSbTGsTqVLFxWoMRh4AK8TyiM8S3XkAE1nxcjRwAfBwhb5LGSe/4hWmdCEj1HnjVU
         C4jZRNCm+ntDU4+yx59Dowoj1PASS47M6cxtFjcq5f1nkpjk9jReXgFJ7vQjkIvZ70q4
         OxSw==
X-Gm-Message-State: AOJu0YzUvHFv6YeymAK255/Djx253ZuhcciiODBluPrMkXa3AcdCRJiA
	/+BuFe4SpNKcSagEpItv1zfo/FIqle6EgVXtN5u73+u7O0Oo5/r3viM6oizk
X-Gm-Gg: ASbGncvVFDpiMybSnpbZys2ByRVpnYgfkD5fuYS7hVRr7dVpIugdyziax+wFnXBkceV
	EwgdelXAkTfzoS34G+0xWLoVgUR9bYG9pyvTZ2SCy/oy/kGFnnA8qQjQ2ykSd5Sci8Uy1U0hSZb
	cgurPUvK/gSyM2BiixeEbw8b3qY65/P3YR0HERiSRV3iU5z8l5cZpMJoi4DbAj2ZjqyS1cYpC5r
	2sHLeUBpiIZicmXAO7izo9l3UkT4pNwpygzB6In9/jJijn6SQZmDlRs0Zp9xi9bkfAp3YPwN1Oo
	A6Z2Hm0m/iVGFPaThpFmkQmHLOvyxz2cjp9wYwhYRutwjLHsMhPtoa+m3SFiDMynVM/ewguuFYg
	T
X-Google-Smtp-Source: AGHT+IEer9jIW8YYB1cXFcnFI3K3Y0hGl0EZLJl86oVzUE1dn5QvBkC9flZ6+6IjZ7E4E9Oj9DeOww==
X-Received: by 2002:ad4:54c2:0:b0:704:999b:e5a0 with SMTP id 6a1803df08f44-704999bf357mr15290896d6.34.1752140114689;
        Thu, 10 Jul 2025 02:35:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.81.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d5d659sm6528556d6.94.2025.07.10.02.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:35:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752129934.git.tanggeliang@kylinos.cn>
References: <cover.1752129934.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Squash_?=
 =?UTF-8?Q?to_=22implement_mptcp_read=5Fsock=22_v8?=
Message-ID: <d8b8620f-7d1e-cb8f-85a9-f86524bb6208@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Jul 2025 09:35:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Success! =
=E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16189539607

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/768ce545975a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D980877


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
