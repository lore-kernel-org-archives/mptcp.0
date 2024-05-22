Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0212DDBF
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378164; cv=none; b=C5EH1u84gOSwwH3JkccemmFfIafKAZAziLEcCDlimsPbEXxMAmltfy40IPNNwymtLNcdez3ghF+j94glNpRCIt/3TfEBSTs8/uOh7J4Z898rK5Iav5mPNwisfZ2q4mH3dh6UasZFzH2SI10ugkBU80DPbVtifZo/dxOAKj4vAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378164; c=relaxed/simple;
	bh=UXGAU5/8bhAYdc/8GPyJTWpQZy6H3uuH7j62/nch7tA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Mxu1s08fHsn1sdQWTFOENk0klxpMAyPwdlAei8uQ0WSBA04QIGzQUAs5LP1ucH4d+bWFDWIKbYGPgguPnjaCz+YyRMzOVNK0GtNYVICMs5H2h5T95WQ8wHQMe//ifvNI1MSwVwmWzV6436w8KYD25nCtV/Kqhz+1Zski+bOgG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdiQkahB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdiQkahB"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f2ecea41deso106284685ad.1
        for <mptcp@lists.linux.dev>; Wed, 22 May 2024 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716378162; x=1716982962; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPjT8NuPMbHNhTWigB3tFunE/zA+494mY1hKXRgwLAk=;
        b=NdiQkahBvpTatJ1dSM0aL2gVjiAVrEbzENQrWLYNM16Jfq6K89JlhvFwusZf98Ipp4
         0BQ5mJzW/UPI/I978p/nziEK02im2vwVo+N/5UtaKMU6gntR6L2J0CxwHcsTWEbK8FuY
         YY89DGixhcAq0vIzUxrXDiIjvYFnOXfuxui+hYOn6lCpoec+dUBbYaZb+jpZSTS8pj5P
         b/2hxIE7UMTd+tpNpnwbaMvmV4DoB4WvYYaJf/C1JtjhiSZwogG4hjclp4z3cwQLBccp
         TDamu0rNohGax8yvxYQh60TChAC1S7KellTG5MzvMudFlH+h9IHFQ1mNVjQTDUwaB3WL
         XGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378162; x=1716982962;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yPjT8NuPMbHNhTWigB3tFunE/zA+494mY1hKXRgwLAk=;
        b=goPdFsROXmtacu79QNEApWgiT8dHUNxRBCxn3ERMht8BO1TD3ug5uQ3uiYQ1zbXYMv
         VBAFaftQkAGUs+Fn6FrHkAJmlHuCaheNOYA0Umb5vodfBpitGxYHFw6ihZcH4OPy4Xwg
         tfhjWiO4wHgD2M3U7gwkLf4hOsfBl91J7wqTjm//32Dqfnlg7hFei3fmIeC8/dvpIeGU
         FQYX0xijACu5zsXOxxEizzcEiMTCkaBhWoCODqMYTBu/DDOZpiLmM3gN5nTXpiRR2qdP
         UDMFoZHL5brg0r96TlZMa7IN+Beet6QTHaPDZ9uyIFFyY4IftvbJeqxNbc+bpVafP8NV
         qzww==
X-Gm-Message-State: AOJu0Yyhw51O8gbOoMoyuwzQqNyN/KoH20QHFBdjYoATaF1g+bSREdT3
	AQOBMc3lZz8qJNywkA6INb/97f8y832aZeyvqd7Ks8ccbAxj3WE=
X-Google-Smtp-Source: AGHT+IEz7GyHXsxQOxg6+yO0rMAsWRu3UqJ6PvZYljnQuvddn9IhHB9dW/hKKM05Sd8gW38PthEypw==
X-Received: by 2002:a17:902:d141:b0:1f2:ff28:c751 with SMTP id d9443c01a7336-1f31c9f03f6mr13671835ad.47.1716378162013;
        Wed, 22 May 2024 04:42:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.140.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf31a67sm243670405ad.149.2024.05.22.04.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:42:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
References:
 <20240522-selftests-mptcp-disable-flaky-v3-0-a10c68bf2680@kernel.org>
Subject: Re: [PATCH mptcp-net v3 0/4] selftests: mptcp: mark unstable
 subtests as flaky
Message-ID: <918d5f82-4c85-fdc3-6e4b-258fcf9fa7bf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 May 2024 11:42:40 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9190142159

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/12b33a2436b5
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855015


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
