Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883E617106E
	for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481994; cv=none; b=DYyzOQYnceS7/HENa0AMOwNLL5XUVvkhrnx0xGXGnCc61LHVQaP+ubKHPevkelVOW0IJ1O+OPTRcMmxOvOnnPVXIv+ImCirKd7KUZzTAoPdFWs5m6l82Jc5mve/a+1gFRTJHpvAAZrBe+9sPFt5o/7vdkKP0Dj4/4WI0Xx6Ezzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481994; c=relaxed/simple;
	bh=MLpWvhuWOEXrhuurXv9VdvMUUZGzHHkGk27V3HEBh6o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=B+8hnV9C0Mwew7ExZZEQ/5GwOqpFkvTvk7bKEWEnwMeUwa//iZ3rupb27wX9QJ0jn2yPHCTPHT+GDDAdZAL+LKYlnWgr/2iopafYUV/+xhpyxeB2Vtbwp3mgLI+bvmZSMKbTWSdqt6aDpc8BPDALk9IJA15ke+REomWTSCOoCzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDP7je8F; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDP7je8F"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b27c660174so580807a91.1
        for <mptcp@lists.linux.dev>; Tue, 30 Apr 2024 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714481993; x=1715086793; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GozPfm3MY7QW/cnBV865HXfdV8Exa0TxdsuLwScECtk=;
        b=dDP7je8FeVPccqRn7QOGusYh06Jh7iiUuFvqCsTf7iB/nJHfqi3sQQVYxpbtUrHZ/A
         PDldrSpVVRpdRC6Z7k9Z4q9eKp5NCJh0spNDtaHMrDtbQWNrMdDKxHedBiVkrbj4N2h6
         eS3x0OGJgv4gLzpXsrUPdOiDnm6gyfQV2Hak7ONI2SKpESYBSZuMvO9Q1O5malcAPnfH
         MOoq8xOBq/1YYxYDhXU2Blv0EkXDSOwOlIKT0ItNLhpKdeP1Aj8slaludHjTMgBgJ6l1
         9NwqI9dSb1RW+C63mSPmCd63dLr5cDOGgs9fBgAMzyWYpG8/5+awUPEbV8q+65g7Up3P
         StYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481993; x=1715086793;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GozPfm3MY7QW/cnBV865HXfdV8Exa0TxdsuLwScECtk=;
        b=gYu91/dy0XtiVZ1bv3HNcVCJ1936ODfa2MmWe5jvbLItJsOwLEuplyS4uzbn+YKQrI
         onmGxAgF6x3jGzY2/SU8Wlx4Dy8fo5ob/2hOhKMfuBP2fixYy66htktezQMaEgFDF1pZ
         83s6FP41ZbVShYTM3Vf+322TPYQSoy80vTH+JB6KBJoVlgpPByBSSfXWA8OMv0vRfDho
         FJ/MaoGXl/39b6zDCWFhyppT+R9ex2sBzBtt3KIS0EuJo+ayGtAq42lJOx96UaTOcACr
         FsTlmwWKmPeOAu7yUCtNYozXhXiLjtA7jh6xtMvrEbGlOJZaZ2tSq3vrS2KL6BKfAvaX
         Z6Nw==
X-Gm-Message-State: AOJu0YxP3arp+Q50Xdl4E8OqHSlHSzSNzyPcMimRglIYs6g7q5Gtel++
	OaAL2dUG720rBogJpgHsHxAZhQwfbK4Nh66N+eUQhsz8U+S59PWzecNK
X-Google-Smtp-Source: AGHT+IGlWC2umDLyZkHJ/+LEaQrE5fnYdRut+ixT1GvHUg/uVy0pxd1hasQ/hYFep2xc8CUN1c/YZQ==
X-Received: by 2002:a17:90a:4a90:b0:2ae:7f27:82cd with SMTP id f16-20020a17090a4a9000b002ae7f2782cdmr8750808pjh.7.1714481992781;
        Tue, 30 Apr 2024 05:59:52 -0700 (PDT)
Received: from [127.0.0.1] ([52.238.25.7])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090ad68600b002a20c0dcebbsm21215169pju.31.2024.04.30.05.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:59:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gregory Detal <gregory.detal@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
References: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: fix net.mptcp.scheduler behavior
Message-ID: <a9304a47-a0d5-b157-4302-ec1e6886f169@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Apr 2024 12:59:51 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gregory,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/889462=
5435

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/de7bcee71937
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D849264


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
