Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363AD86330
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274216; cv=none; b=N03Nf59WIZ611K/4S6EhmeUt15iFXY1KWJc8/DMK0DPvVPiJu7cmoxEpEhRKVM8USQYkrV+FWGduErjvCtQ16Tpm8ejzEcnF/jaO2MF86QJQbdrJoY8MCddmzu1SfKx6SuBYhd3ubSN0EEqNzU30w2SvTbL6wQamLJ5Lv0n37b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274216; c=relaxed/simple;
	bh=6alccVq/tyIOiaxTHabujM5RAlLDwm1fZGsd89KLcjQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=auIEIpYKG/KAqPdE9jC5SJmYXwzH/ycP+y583/NjPCEUD/5I+Qcg3f3sePNuea13s1tTuq1P/s3tiTxaGtY14azpBbps6xhvK1WBkhWofM9pU27WOqfel2Nnl/yUgYU7Pmyc0OHhTp3B3mojsjSVSTkGAAupHW4SumiehbYrTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE5YsVn9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE5YsVn9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e8814842so1368643985a.0
        for <mptcp@lists.linux.dev>; Tue, 07 Jan 2025 10:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736274214; x=1736879014; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70MxEfSbLjqdV8/J4ij5J1VENf95CdNnfjKQomoPL24=;
        b=nE5YsVn9ZhEujDfh1XJpQ28NJDeRzdb2rjnq+8Pb21TZV3dC1LvLtmr0XmYc9Wuh5+
         h3oB7MTqcuT1aeVkOtc80zHWd+SIL3FsX5QfDfUiUL0MneDElTUkkwqb+Ng/p27FhYTk
         E8c9ZF9HIHpsvc7B8haaApgx9Wnk7Uskgbj3QeD6gffDaGE9ZIAK4nOvjLOZjYptdTls
         ry9uWYw+708BPhuoV4NFmdPM+KHl+RguSONyM8hY5vQ5PloNehO0bBOKa4Q6ernZhxqk
         dpFoBs33dMCKxGZKRU2wJEjAeMi8wyd38r7fzu3ltVeJJtnTtiooSh2eT5jy18Xm75KF
         CLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274214; x=1736879014;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70MxEfSbLjqdV8/J4ij5J1VENf95CdNnfjKQomoPL24=;
        b=IN6tAwCzl+ezPsUgggjQPYiD8U4JZpR2pCcl5EE2lil2okFUpxSwSQ3EEDbYlVlVIG
         U+IaeV24zzVTw12U996EVk4cP6ZJT9KebhOu6QVRksjURR6mhIWtTisd4ZHWbHVyS7tR
         T/3iBA7LxYREyIJg9Upbm3e/B1Bukor/LEzL8L35bkPMZeaXzLwTLyNc02/Bb3bPP3WH
         0ckFjcSb1+IWETgg7gzr9bd2jZA/7fXI628U1ZW1ncQT4DI6fen9ZN+RhZOJQGMDIknG
         /odr9n8JrY53f8Mb58GOvO3pnP31n63coQteFGHZgzA2ZBfPWSBlmH3PeGupzhTVomSn
         jSFw==
X-Gm-Message-State: AOJu0YyxbGUMTLakAC1cmU233uzVyUhlz6QPpUBZYKbC6mg5zxDfHtAU
	8PrcgDggts88wTnKVL6Q6ooelj2pQN7RYi3cwXOBbVSPa5DaGTc=
X-Gm-Gg: ASbGncsl31+hO76K8/FeDDKQzQu4KyxAL75FgQhnSrbxKMOisignlumQeHS/oZPUHWO
	f1Ph8ECa50iIXp9JZsK2/JcjZNFilzEGI3VXiodeUIzRYtO/W3GHfFa6dYg2hiKSrbq3+IMfGam
	+B5AmexUJqxaY8c3CXaUn6lVB47DXBzcpuYc+GmeAc5Z2kXRV48bgLYEOwdNVz850k2fLr55pod
	XW4u+EvvWsguMrK2RCNmuerI3YA33OlATqmK2kaNu3bN7Ts+4DNcDPc20jCUljCYHxDo74=
X-Google-Smtp-Source: AGHT+IEQCb23OBhjgi/nmtVALWsNrrBBqe7pVNiVju7tBLy5qwJ934AgCb4ri1Yp2WKO4FTIOcdMSg==
X-Received: by 2002:a05:620a:28d2:b0:7b6:e872:421c with SMTP id af79cd13be357-7b9ba703203mr9244008885a.9.1736274214109;
        Tue, 07 Jan 2025 10:23:34 -0800 (PST)
Received: from [127.0.0.1] ([172.183.77.251])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4cc3f2sm1612178785a.110.2025.01.07.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 10:23:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
Subject: Re: [PATCH mptcp-net 0/9] net: sysctl: avoid using
 current->nsproxy
Message-ID: <b58cb0d4-9704-f595-b8d6-5550e60be476@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jan 2025 18:23:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12656267762

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6e18f999ad48
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D923074


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
