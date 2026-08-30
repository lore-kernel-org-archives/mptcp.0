Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817F92F7F09
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123997; cv=none; b=fPOku8j54vxJ566ua3zPznvdmcmoMc+4Lq6n9aUAvQ7hH2ixiRSd0LNJmU1Vw2PE2C6JFXRcNGzh22hKGBacwx/OtXUVRcKl6VaGlqHVIn0joItiCBrKyVAoh8MrVLxHKpIhrOS/36ooxVcLwmIF2hP9zSSPxQ1KFmjMJMjolO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123997; c=relaxed/simple;
	bh=ezeYGV+ztmfNhp7ZI7WTEV2+Yj0XPs/UrCTWANd8OHY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=i6CvjwfAl0m4XYAEyuYHnmd5nhpmUrzYB23oV/4D8AWJ0FczWeEOpFwxR8PSBB+FcbBUvKOfuFVINai83C6m9eB3s3YreF8/Cj6oLwLS18oKylbOQB+KfdU25fOl+7i2KPiHVhz5Gg3h+CNjLor2op9Io/tAbhKF0pcifGeYqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIBA+wCQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIBA+wCQ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so2144545a12.1
        for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123996; x=1788728796; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YScqKkWsaFJxJlI8VJH90fPrDUtY0SCfOEb8lJJDsZ8=;
        b=XIBA+wCQ+A21uVCQPW+mqtqJOgTaTtLKp0o1ZKZktbaSjiM6A6iZK9kg+Ji3JPKiW5
         hg0Ax3J1LizpopK2nxQk4aRiIerLdH+twzdIp66z9es/Ba9EW8dbf+AgY9ifX19v1zVC
         NoIKVfbqJWBomVEkwACiDLrYauURwXM58kpge7StSvGSLGFg9aj+TxWI6kq77+/dwA6o
         xVj3ycEO3BKXnwSYDxbUAdNXSXCefE6E4H6ujbmYes9QHMoc/MOkHT65xPMSSHx36Z2a
         gCmjqwX79CWvqzRvx6c+WwAqUTwkMilHUFpSLXBWHs1+aS/v4YO1AcqI0kfP0ozsQs95
         paCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123996; x=1788728796;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YScqKkWsaFJxJlI8VJH90fPrDUtY0SCfOEb8lJJDsZ8=;
        b=Zepn7UtoLlzAiB24RYH3cbnt0xZN2cV2Vif/afKbwTjeWbFzcwrG+IWDtsk3miFqv9
         wIa5cxYZwX3NZKerXRx15bF+bulB4i80zix6bm5oXKvkniMhNTKn+AD45aeWIhoWYgf5
         9JusVZjaREZOBN1O/Cti5KzB5eZD0g/3OWik50tuljxsJ7XhpH5hdT+g9cnCT1kBKiBT
         1lK4jvwq/GhM8AfIFov8CmJyzoDmygZIEQnL1cKnpx98GA/LPhADpbhG9Zy2N9fa1CIU
         d0I+ECAtoeKwBoOp49sf4O7mUcU3buxwoFzDaBNdOJzNsKsFTz3awfTLYiXsDqFWDMSO
         Kk1A==
X-Gm-Message-State: AFuF++nLBhg5ILqjgh4twU3gNrEA9UIyYjMfXa/+W0x+eS2ojOtfdVic
	fp5oG3kBUX4oded41DxW6Bg+2HxhvsU4SU2G0YNMZtnT/2oksL5UHkg=
X-Gm-Gg: AYBFou2soxLEbltzFnsTJM3Qci3r8MWwLw+0rug655zQ1bXnK92I0ucjLzWNbH2e3dz
	3CnLWFfdsGvjUT5fOuj4C3XjCXwSOth6VZEavbF4Jap+PLMXSGySrLDQ2SpxXS6H0MNONxWajLc
	HhthVK5TnV/oCge+UjrQ7o0+UzWrCwMtLiWjWzOLMoXrLqBJOSWhFZHoiPccx14MybgE9Pg8jE6
	25Y7po+kGGSdoQGUarTpzasfMezKOkZql8vmIw8pFCP4WbOnlq9+W8e373aqKl/nPn75IukNYRk
	jVlkv6ZTouCXGzFdyJjEASyJeAiUZsD09UByoVjS7HTVPOAVRa1T8EmnifknyuBEqTEgZy2dfsl
	KjT9oPnVkEE9ZcVeLujWzAF/1AEB1xVme3+nt3U7mPQ0TOTneba/QXowVrs8X0lqIcS1qjwrd1P
	sDMI5RZYXAM7WoPlr4m18Z1eN6EZBADNNIEko19Rjx9jh5ZAYb8nVBXrmM/xpPpV4aao/diVLar
	Mpn
X-Received: by 2002:a17:90b:2c88:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-396d0f52a0amr35986529a91.8.1788123995761;
        Sun, 30 Aug 2026 14:06:35 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d3fdf6sm23609391c88.6.2026.08.30.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 14:06:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260830201650.67050-1-gnoack3000@gmail.com>
References: <20260830201650.67050-1-gnoack3000@gmail.com>
Subject: Re: [PATCH 0/6] landlock: Support MPTCP bind and connect
 restrictions
Message-ID: <d74957b3-d2ec-49b2-7033-5d56f185f0f8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:06:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi G=C3=BCnther,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued - Notice: Call Traces at shutdown time, =
ignored and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/33333805532

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/60feb91e76eb
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1153987


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
