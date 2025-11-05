Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119F2DF3F9
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342069; cv=none; b=Xcfd/3jj8XA2W+GzIMr+B3T2ZXE1qujpIGNHTh+a8nhjs2B8hdAt53nzNiRbOWspU3t3MdHGWIdBk1PlETw2HuDp8wGiYknV7W+wgN8ETx0hIWU0VKZH9iiBf5S6VLkGZdUBQcKiLa3k7wuI996HkjCmRAa0QHrIx86Pk2RjKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342069; c=relaxed/simple;
	bh=bcMIPW034AMDgn8fnWINshGEkeLEeZq0syzCuCZiky8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=WKsmLwh8zWtKO8x0V+r9XebTp5fLCw2N8pReU0glUaw2JrdiS4ngbgUPDkpF5A5vraTY/I9Aq1wIvuxBd1CR0vGEgn4xyQ/5n6zLuhE/UcqcnIltrdyeN2+pOyYft3HHlIbHh4njDlR2fj9UGpK/yUTb+HUVfy4iX9StEVKR7Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yd5+dRla; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd5+dRla"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so241762039f.3
        for <mptcp@lists.linux.dev>; Wed, 05 Nov 2025 03:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762342067; x=1762946867; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujp2WaH0Pg0ZpDjf91SFAAkGxNnHYc+0aSSkHMe2VSk=;
        b=Yd5+dRlaI4M2SSeEgSiclTawCcSL0vVGGjqXvl7yESX5bDhtxolPmvdyI5E1Fp4eQJ
         JiDEEYWawGIxRj/Q6/XPcIW7IgEcPZ78uG4C7ft4ploaaLu37/LE/opp08IbQay/FayR
         4DrCpl7bM59Mwmx+wJZHV4xSrJVidBqjC8ob1nwNuf2E4ZeEwSUsBrMIP/h0UpF8zcVX
         dZ/XsBXoGMRY27w3E0GE9TyRuiHF4/v9JSto6Y8Q2kU+m1O/Ukvg1dxHWS3LrxuMe2kP
         k0q5Kws0rF0Qof6cFa+vhqT+oMx4CFM0QTVRGxzI3nLUjZUgcTMlZbGMqfBkzNTehqX8
         871A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762342067; x=1762946867;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujp2WaH0Pg0ZpDjf91SFAAkGxNnHYc+0aSSkHMe2VSk=;
        b=vf93s2k7655+tlbIhHYVF6VDISl4kDFxcI4grO4RiUrUOH0ELpQ5pysZj8E5/ztkpG
         oM/JKcxOFtIHaWDuM03y5afelH4gX0rPM3D3KHoyyEnwp5NVYLpA2CxBgy+fSdFzmVyx
         JWWmwq3tQhUJoKC9Nc9P2+XxGnGP4xo36X9BNms2yjk8Z0k6Us4mrE6CziF5K90YiBDZ
         XGQZ+EiZRHlmp0taXL03zwmYZ/Bj6bw2cnH9fyQiWcFu5jcfFjEBlJsxuFcAGqh6m1fQ
         2ysz0nMw+rKtG09eXGtTs0hDd78mRx6V1bW5g7QuqAaFCB+hWkUrnrAqXReDCGI05LrI
         XGmA==
X-Gm-Message-State: AOJu0YztNuuYU5V7CtBocQGfwSrXaqFyTMDAyaqRTzN35mdh+Am1IPSg
	ucNT+OsFy6xl/MnppoUmTZLpV7i/tVZ7Vhb7MAw7yPyxT8t0ZhpEBBk=
X-Gm-Gg: ASbGncua+mg+rBAlgsUPMrlg5uo7a1N4Sx4/E3VIkCk8OQDcgKErLJeXthxh/lFixbd
	K2Y7z2WoD2EnDiglmdZc+SRItfgDMYbQ7QAunFrkNZZ5Cv3zve2kOrvC/4eAndZFgkUrFhn+h53
	MdN0bUF+1fGOFf56x38ZqVfITdFkdeMcgF1gEy4kD7tSW0FHcdEWOyHwfi3Gwuam+v+91wahQMC
	6p26kSnD/28pqEjOsYxh60HgElEUWxb+B+7n9q6YwT0UunD71yRyVxGfyM2y4P2SYUcU730pado
	/PEB3r329wJ9KgLMfdmnPOhSE0xXE/AcFS4TI5+jz2bp8m2PCSu84cBD7Y9gsGd4966zHHVRO0X
	sZ4CpNyDghOJeG5aTJQYv8xA9gB8DUJjK3KgvpseqE2949XTy0AexIPm7ToVUZ3fljQu1PVxUgz
	aRgJ+7jtDsq5hoHQ==
X-Google-Smtp-Source: AGHT+IFqUENBDSTk0TW4sSwJ9K4tFzMDiDCLzURgO1/By4QYX0+1JOxBezSoxFN5+t2ctNvOkp2+OA==
X-Received: by 2002:a05:6e02:174b:b0:433:3322:e35a with SMTP id e9e14a558f8ab-433407bd4f7mr39167625ab.15.1762342066675;
        Wed, 05 Nov 2025 03:27:46 -0800 (PST)
Received: from [127.0.0.1] ([52.176.124.187])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7225ae7d9sm2315736173.22.2025.11.05.03.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:27:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1762292476.git.pabeni@redhat.com>
References: <cover.1762292476.git.pabeni@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 0/7] mptcp: autotune related improvement
Message-ID: <1245ce10-0932-ff15-cc6e-f57f150ae6ae@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 11:27:45 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_mmap =F0=9F=94=B4
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/19098415180

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/45957e0ea29b
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1019624


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
