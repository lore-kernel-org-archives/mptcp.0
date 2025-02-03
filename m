Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2872036E1
	for <mptcp@lists.linux.dev>; Mon,  3 Feb 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588220; cv=none; b=Gdtyw3se3lYsc7W15akR/SVG6MRV2PkWL8LAO80RjnyVGYP55des9K/zZO3utJDYU1yr1u8kBvQ2Oawt9+uJFe9D5Q2c0qwgT7qCMSMOUBrZ6wfk7aHiOStyg3/f4bB3WPc6foSGeg5ZV3RxkWJnX+MIvzRJj7K1VFFWTLIKS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588220; c=relaxed/simple;
	bh=XCgouKvooC4hHfh4FMWVwhkAXvkO4EboDp5h6COR4qg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KAGj1tNQMLPmZWj+2p4V8OODH87eGVTz1uCAHQOcUZ8kE+o+Aw5BF9w6ZmPWkbgzZnbOMJUEKtsQnRPLmmPIkFFea8om7pbW/1giNCL2X5uzO7Cq8JGQSlntFCzRlqkZ4/0lHpxlvBG51QgezbB3OpJYLkTQrEV4FSbDnlSoze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY2pYj5c; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY2pYj5c"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd1b895541so85042696d6.0
        for <mptcp@lists.linux.dev>; Mon, 03 Feb 2025 05:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738588215; x=1739193015; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gf8D/iBxTz5Na6kMo41tbV626T2toNktxvFUxVNV+34=;
        b=DY2pYj5cPxKkRb/mPYyjiIm0UvNOR+2YUxtDraU7CbiuHrwdodPPMx8GjJUVL7QN56
         zIvh/axP3XHMfKKXXRItZaSYSEa6Qxyq//VcDrI0mSucmJxyeSucUHtOOtT3B72iWSvL
         yX0iKANpYF74jZEQD4/F8+2NuFzpSbbsNOmeuyKiZ0DVsClRvZQJIwMzbdmnVlqPD71F
         HqePVv/2ynfrjqwR0zrr0K216jvrHnSKeexTeBJLsYz4cGWylhLbKJYVpsUPH2Ub/q0/
         GoS61YnxZ5t18zWl84ikaNtOVfbPQlQMdj/OoW7gWLfjBa5dOUV8EADXIcoe27ajiTn0
         /WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738588215; x=1739193015;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gf8D/iBxTz5Na6kMo41tbV626T2toNktxvFUxVNV+34=;
        b=MRvpdAjQnWaCajU+niSJYIw+fkeXfIMuixvwN5D3hV9U5swDsW5yNjY07MH9xVEOWd
         JoYoaQNT3rOXyN5/b4ikPtFyuH6Z+VlUC4FYeXuFXompvfFQuZA6bOyeysDh6asd12re
         MKH262kiZr20T0hSMAzsaPYXPmC5FS32o6TeYMmZkEgNL//jakqU2P8xmv56oMbMKx1/
         XhQFM77GCidNkn0ZDJ6xFSs+y5fSQwiiU0O8utZHgTEuRVMicDcpurWIgNTGx5yqnxOK
         i+FhngwzDmAwZRo5TDsC3gGkZ9eWSfhK97XfSMh1X0s6z4DWIwC9Eaef6QSTvZQuhug2
         fgpQ==
X-Gm-Message-State: AOJu0Yzu9S54KJM5/RX3KYtwgOm52rN1LHtylu4DIflPIFra4v5ID48v
	W2QbRiuP3DesV28VmMTIV53wIazqqDSH996+BS4JsR8CGiIINXbY35hJ
X-Gm-Gg: ASbGncsKhBmN3nCQRbVlcwZlIK1pr9UmclYRwl3JHzbMxYnydf7NHNBOIcIldQfTh5g
	aiWsiqttori0XiQxJr/WvA48gkcJMZONemUCb4WehjIswhLKSV3f8QV/RW++czkSY4bryNLfMcu
	oHkHR+yWtz/mxkD1CUoqXERGI624dliFHY+vhWS9jwbqsdNk70RUOw9bk9+wz2JAfVTAKn29Sry
	ek4B9kpRpzMbXE9tBcy3E98qMxqiH6MlgGA2amPKkZgcQeQMWP9ha2J+vnXdWjatQIEyEs5cEbU
	h8d3T2l/5gR6LraFijaV5ZPMaI5xA+4=
X-Google-Smtp-Source: AGHT+IGqFvLI9kwHRZ4lYRIe1ckTJH52mByirGw5rHC/OyvROY0uHGlYHcrzTrTH0WamqBnK+ZPuUw==
X-Received: by 2002:a05:6214:21ad:b0:6d8:ae2c:504d with SMTP id 6a1803df08f44-6e243c82dc1mr277921486d6.41.1738588215317;
        Mon, 03 Feb 2025 05:10:15 -0800 (PST)
Received: from [127.0.0.1] ([172.183.199.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254922e00sm50013526d6.72.2025.02.03.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:10:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738470660.git.tanggeliang@kylinos.cn>
References: <cover.1738470660.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v2_0/5=5D_Squa?=
 =?UTF-8?Q?sh_to_=22Add_mptcp=5Fsubflow_bpf=5Fiter_?=
 =?UTF-8?Q?support=22?=
Message-ID: <854acdf0-4d6c-2ce2-e042-6d0914c49368@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Feb 2025 13:10:13 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13113192213

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/05f282a539fa
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D929774


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
