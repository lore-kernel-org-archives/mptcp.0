Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2F1FF1D5
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078952; cv=none; b=cepguQ3DC9JHvq4dZMuuSwKJ+GN+hbZaWnd2THaJkLfCVhVgAcUdTZIDkPehTDotBMadJ2TFNC/1/EoeF/cc4ItgTenckvNjMtuNYr6m8QJ34s4WQBgm//YG82brHqpRBhemrWWLUBdL/d0vHYjtKWIRsRwyMbT7BRR/juzARh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078952; c=relaxed/simple;
	bh=UOauI6cXHCeGs9nP0fGoSW3AGl5jeUB5amRWhAKH8wA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=TpXFz8jc7B+I/SnTk4pnpPIs2et+EhqjTGofk2RRRD5swtmeFCrYLWwT4tqhGH+obklaEs97Ojh1LrLz/LV0+kPcbPyp//x5RvpTBpxIy+4hTBYB/NfdepfuBLS6CarQ+VPCF4+cFx6BDY7fRZtbZmM+3+/x2KDQSkS8aiKhYys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noNXfCOz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noNXfCOz"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22334203781so101235515ad.0
        for <mptcp@lists.linux.dev>; Tue, 04 Mar 2025 01:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741078950; x=1741683750; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0QdbILieJxlZABCAhJsy3vXe83xZwjjVbdaaRZkVqU=;
        b=noNXfCOzpvkTC9FdUftVarFc6+Br9zQfG6y5yK7nRejAYO/eQxDO/ghAWiHA/hQVui
         0w+szWW390BFjdNGcbaj/0m/j8AH4Eiiwxqdok3ImIR3cMghqPoT7mx/aEjkRyY//BY9
         nHWCZUDnoR0mg4CZFfQL7BHQtaxS7Q76cGhA7u0/O+6v7FEOizjqM8gyVqgPZSjG8JVy
         1x50i0uWpAZ/RsrFktGwrGhgTvnFYhJ+3C8gDfIEtBTXjUoPlBwVhzY+/EhRpvsOj6u/
         /fCoqJ3bjgQwUOvoloIdjeViNy4nmtOGP5PjHJ2H+ffUVlaAiCM0nI8+gmUCP8UpMngl
         aIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078950; x=1741683750;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s0QdbILieJxlZABCAhJsy3vXe83xZwjjVbdaaRZkVqU=;
        b=S66x6iqs5+hpCWBJmQMIh55b8XGNg+NDlSFd4EOB+0aydQ8aYDmpg3oPK+FMD6pR0q
         y74uuhf2ViETEzrQAIhjb9+0Fwp5G90vR8yi9yYvPKCYkZF5auCz6oPTjDZQcqjUGT0G
         mxj69vgw5JJudWo7xf+T13AiXQJqQvdDzfGUkKdKbVDEmQxJBtkNggoWZrArbBjUgPjS
         jwIo235Qo/sTzIGe//s7ksjS9l/97ckzIA1sHyvsiEC7EBp03hF09IPnsJX9f+1QB/en
         Gj+1vbieo7GreajHdvj6vtjEX7qJvs2FUBUoXFj034SRKqjC8/BBbRHrpTs+NOmxzjbG
         kZrg==
X-Gm-Message-State: AOJu0YyNaohf80RWO2ZWXNhhelwat6BGNep6je5VYvom5xzyGiu/1pmP
	UMkwlkX0f5GBwEKu4mVuME3JdcDmXkGiCMrSWDhtC45S0yVax75SazQR
X-Gm-Gg: ASbGncsfMxUGV4skl6dCRV9Hmci86x0e2qeLDzR+YScSvQRKOjzU+yBk+zE/sB6xb4r
	zLhcXmFx4dTjDHU639wW6FFCxHwdxPVUHXs3GslomA2X+BhwW7qDHkD5MficvrQzopQEo1HMZFr
	GZ7oOUS9BvKcN1be7QmRwIwZ8v4aPSzAqx+3d92pPsDWkDSg7z/KtpEPOt82fTTiTMMSmVs2K67
	8Zl4II1Ve/mnKoA4AH2ZQ+4Xpk0TQsMnCoF8TfbE7yMMudeFR3jQk4PetT47vXMbKyF/Zr1zcTS
	GyAyA4L8U8R0+BSQe7x+ncysvu28jpOMl4a3JNMYr8QXugKADEmIEiLI
X-Google-Smtp-Source: AGHT+IELPHmUPm+ahYmWyu2k3W7EwF9UpNuFGOYTaxP5d+Mjab2jtPjusbf4/MAKqYNhqXsqB3ZWqA==
X-Received: by 2002:a05:6a00:2d1e:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-7366e5990c3mr3995774b3a.4.1741078950356;
        Tue, 04 Mar 2025 01:02:30 -0800 (PST)
Received: from [127.0.0.1] ([20.169.14.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0040084sm10354713b3a.121.2025.03.04.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 01:02:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1741072099.git.tanggeliang@kylinos.cn>
References: <cover.1741072099.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/2] pm misc cleanups
Message-ID: <fd59c834-7e09-3302-de45-83d2fef57e93@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Mar 2025 09:02:28 +0000
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
uns/13649066260

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/88e393d9b0da
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D939900


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
