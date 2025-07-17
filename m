Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E04A11
	for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752724109; cv=none; b=bJXaLblpWsm1mPn77UrZ5Eb+qTRzYNDG3zu+3QoQGH8T9zPCeCJ2ECSmLlWgmFSBKd4cB2LVV+3Ekpn/vVk3NwbkKoNzsTV3bOblKQwhI2XP+r0FQbHkr0vcHnSzmqJt3G8KOaFbugfNv36vk96X2Sygpwd/2PaM4RSjrbf9rxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752724109; c=relaxed/simple;
	bh=MpZY9u6EbOpzSR41VNywppY/CEAm+dfC9z94Alojyfo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KCQrIzYBtWA7FZ4B/jytsheN+kRfFetBIojctkWYQoHdtMwofyuScDn6lJ5FCED4oaK6nL90WzjV6ygx+wb8Zw71sWLlBwKE/2dIipzZ5rDw2dg3AnXsQPShJPRJKWbca968AaV89Dh2gSlDL/TQ4mBMsMbH8rTK59AX/ifcmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czZPM0Ub; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czZPM0Ub"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490702fc7cso384277b3a.1
        for <mptcp@lists.linux.dev>; Wed, 16 Jul 2025 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752724108; x=1753328908; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvp0ecHBqekNazlaYAemjhFCf0rfJFhT+x235KFEKWQ=;
        b=czZPM0Ub1HBL6y8ZeREb5mie97Zuo4636Q382afoyRuOg+foHQkCAow3WUAA+YwcKT
         xCQbjfo8T1x8L7+QXHlOiE7Ur9c9zCplianNwc2ZcotjUrf72ZLP+f1Jo2a7B0isl2Ku
         Fu3hnq8mrB7cKtRmWid3DkaXZZ3EW9IJv+bjSHWdJNm4qEKrBhfdOOtKmmTA3klak0dQ
         9X2NX0CLiOGL64bHEEmqSmq2v4zRmtbMwyxJEcFJcP2bWhWnY+gs3hfhhta6Q8IARcJH
         CFU+tLoFBI+P4OhXNQvF+yezgxTdfxE5Z6+0TPnzey6u2ej79sybMXHE3b7gzUZNs1e8
         y+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752724108; x=1753328908;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mvp0ecHBqekNazlaYAemjhFCf0rfJFhT+x235KFEKWQ=;
        b=djTj9JiPY8IjTVYj9gA9PBsnngIfPmJb3jQO7fdYImmTr/G1MhI9l8o2OGBmahEd21
         B5+Cxju9i7Ly+AHdItlpow9sk6welXmlmBP67Byr+usCA3gsNV/tgEHoovSzQCgzfjZd
         3pG+1+rr+hg1x01KMlBH7Ik+NQAC+vK5T6cPb+A+S/qUMooV6XXz6qurupsKcmYDxd1S
         yur64El+i+y5EQ11vpxr0SmHQjEn3cA3t4L+EuGVVm1fq1HUc2ayHRPtE2Y9qbGyjfST
         WjOWNHizbF4dAqnr2s/sTnXBEEHsXhNtRFtF5thqCRL/VQrNoyopTC5j9ljCHimivt1N
         XZsA==
X-Gm-Message-State: AOJu0YwP2pmvjXsvDCxlwNfSY8miRF/X09Tk+RgturyM54rJLACZz2Zg
	gjRV5UYMCBZtVophcelK8NrVTcmvnGRYIpwy662l2g6WouQPH9XN2Wdw86gQtWw=
X-Gm-Gg: ASbGnctigpb/3KOM9QBgCjMaHGlkGaWWjPWG6H8ITY+AdOg4X0YWDDxRudigEjS3j6s
	bQO8/+Ddqqte5VahqIuxU+0OTOumam0Qe3ol0/N9cVQdrlYP7AYgCPQJE9ujjKwTCFxR2yHWygZ
	dDSBt+NwKpnx+0DJZM2bVshTKXzdhJDvXvXy9SeyTIVKHQ+hMlaNRuOO0EChJPRtc2HnEbRthHG
	O6aTcAsr1T/qwMfvBV86EOcnbZpS/TXzl+EQniztt25y0Hem7PrPC76LWAQAF2xsXca5PqopRuw
	jZJn5CPA5t9pFeA898dubELgugGnJ8tt/8aFyernV/01G0KUZ2b+8D7tTctl+mZAsodoAEiWYI6
	ZRoVvVMr1bYHXJGOpyHWD+/Xu5qVbO1zllA==
X-Google-Smtp-Source: AGHT+IG36/kne5JGxhC+b8zaNq2SE0UyQLlze/SmXc2/N2DtVXwfbwO7l+WSJ3+QctuvwHfPI4o56w==
X-Received: by 2002:a05:6a00:240d:b0:73d:fefb:325 with SMTP id d2e1a72fcca58-756e7acfeb3mr6430936b3a.5.1752724107661;
        Wed, 16 Jul 2025 20:48:27 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.57.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5fc9sm15082487b3a.2.2025.07.16.20.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 20:48:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <ba6be90c7ee54384bc8e3ee5b35e3b0166d03aff.1752717857.git.tanggeliang@kylinos.cn>
References:
 <ba6be90c7ee54384bc8e3ee5b35e3b0166d03aff.1752717857.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_add_TCP=5FMAXSEG_sockopt_sup?= =?UTF-8?Q?port=22?=
Message-ID: <b8601f66-380b-2f00-2ac7-535a4f9c92fd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jul 2025 03:48:26 +0000
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
- KVM Validation: debug: Unstable: 2 =
failed test(s): packetdrill_sockopts selftest_mptcp_connect_checksum =
=F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =
=E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/16334696816

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2bebb73a5617
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D983150


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
