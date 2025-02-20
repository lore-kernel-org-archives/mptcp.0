Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6741E1D8A0B
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740024750; cv=none; b=kJGLrHIq3UcJHNG8IJqx5MIqC0pjQduMlKOkeAR2rBm7RaBx32EazPYgixIQbfDJ4wvf1Y5t3G93C9Giw0h8/IwSJ5QRNILaUiPyhY1VYGylDV9dhRNLYOglplB1Xxoxy3Z1jMKA4EFGxzw976XAx8mbx2vh7FkVFI4T1gnD8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740024750; c=relaxed/simple;
	bh=PVRCJYYoW6VMRj0qRAFQa+uvb0K8dds1iCLhYhaQmnY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mMM3BNTev8Fz1h04qCsoINWMw4UImqIOFY7YsMQ3tW6snxYCfUV7ALiQOR8/cZAFhXfFaorhxUjQqwELeGjR06ycpP2Kfp75A802lAahuKEYsvVomVv8gCr1fNwf/se35NVWseImQj6W6wXjKI728LBDWCzM81xb5xwVlQa8fno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqOppUOM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqOppUOM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47210ab1283so6850261cf.1
        for <mptcp@lists.linux.dev>; Wed, 19 Feb 2025 20:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740024748; x=1740629548; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIJL6c/vum/K51NKSObNyXXlu8lFBybDeQ7W8OYm3M8=;
        b=FqOppUOMxP0eo6nnH1ILDJ21OYJd19avF/F1nunOa8SfPONTv5QBt43lJM1Afhqpln
         3TsXFrKtBCBpl4VO9RGJCqDf23Rz6YSXj5vsk7NAFSWqF66/Bjm0Zkiwm6vfEjcX/NgK
         aY36q17Uw2kfXmTKx2ZhpqTCWlEhYDOFUIf0GgGoG3B3UiePkUN1k7nyTWIriThh2Tq4
         whpvHayCU0HFnPDc2afiYmXcDpwVaRVHm3F0XwmVXa6nL0ubBYBwzztLHgzh3sLpWfGD
         P9aCwc4m3us4eLlv4pXSNn3DOZk2p7YqstWCnycKNL0/tWRFM0JMZCMO1NDrezAGVo+7
         dwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740024748; x=1740629548;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIJL6c/vum/K51NKSObNyXXlu8lFBybDeQ7W8OYm3M8=;
        b=C1NLOCm3YMWSqaySLB9WV6hjNZhixQP5J1mZv+nj/cP5gpoQPmyLXACzUTeL+mBDcg
         zvNlVokI8pCsdPfq19p0bCE2Pe5BZcWpPsLUuaqMEAGr0ZtK4YlPtTNhth3hq6+18bAP
         VfEwj/2D0L3v0OyoGoam36G9E8Iii86iXs2JBK6IFEj6JgLG4z3C3hzDCV3NGB1zLha2
         IOv/Vu+wBWA/3ajcobCCVFSrLuX9UoN4Z29qM2Cu0md2u0dFRr/UeH1JA+6g0CUYZCNJ
         p0M7gi9fpRgMngiWi34Te5zbYC4qtWpNMSNTRtT6sDBIigZcrmJMH4oFSvEBZXv2VMkX
         vA4w==
X-Gm-Message-State: AOJu0YwTl1nl7MwLg4nHQliBCUqJVSMynhrdzBvpwAJ9O5eRJ79YfDrP
	b20FHzAPXa25FrwUkHFV9Ibjg+tNRviN6VAmDAeOySff33GZMFibQ5ZKuCg=
X-Gm-Gg: ASbGncuUfdRjiepbwiGgJJT2QGfci/WVko3gLL2ZGlBdEbaWx6Qsm0GHLVqk/o7VFWb
	azaruVDrLAqYyuqabJhJKYE+kg4evRKQJODCENdgDpg9m6si44wdEsHklMGAOOzdrC4dKJMpThK
	MoCwz3g2rH35F144pkzVd56XXmwQUQbmq7kKoY3U2JcEtWeAzDT/zGQZMjIs6/KzCsIbRzg1R/D
	W/wQ4/9d5MF6AgLIXve8GAZ4rzyxP2QZnc7jXtXgSLOwVXsZhzeHPKBNyr8X9P3gNvFWn/BTcyf
	Fn5upUztoITcY+VehBXQcPWrAKk=
X-Google-Smtp-Source: AGHT+IE1p58sbchTRnEXfM4+j3I3KQKZaHcpQcJUA6z3pDIir3ZOMcErFtA2JFjX28L6AXKwpZR/zA==
X-Received: by 2002:a05:622a:1485:b0:472:6aa:d6be with SMTP id d75a77b69052e-47206aad99amr105247551cf.17.1740024748111;
        Wed, 19 Feb 2025 20:12:28 -0800 (PST)
Received: from [127.0.0.1] ([20.57.44.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47200b32b62sm26122611cf.66.2025.02.19.20.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 20:12:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/9] BPF path manager, part 4
Message-ID: <9fedf393-647c-aa21-cb07-fd74da918e47@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Feb 2025 04:12:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 =
failed test(s): bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/134271=
16230

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/468399415dad
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D935817


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
