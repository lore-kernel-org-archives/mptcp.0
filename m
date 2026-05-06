Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC8368275
	for <mptcp@lists.linux.dev>; Wed,  6 May 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066382; cv=none; b=AzRw3JH63jwAtRSEQtdMaGfyb2B7mNzkRwOZ0f+xrS8TzLSXJcxERN2cRL25YAx9HL5v7LksgtoyLcJH3D68sijPKN1EjjYUimwtg9Hz5+4gRUcDrNdJd09+2Nptupm4rhumJnz7zQo4kHpiY1iUSmycSg6n7i2RJNIH0xSwnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066382; c=relaxed/simple;
	bh=eDY+P24yWPQUz6ga7858QByLe7ZE+CYCF6/QlYczVQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=V2lxViz/beEdbv//YsZn+gjZeN07tQkTP8L8rsSMdRip/ziRxcwT6rIE+PNePNf8ZUOHZN1ySJuZWLiW4NUQxSrMjiyIJ4sWXG9Y8xj2RwtInL5mnwpA+wk26sk594aT+XaGEiIHWadWSCSIZWx5CrIAtVDM/niqp/fI7SOMaoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcpMWjPk; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcpMWjPk"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b6ea7716bfso43315086d6.0
        for <mptcp@lists.linux.dev>; Wed, 06 May 2026 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778066380; x=1778671180; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZuLNVvMag585tow9qB2ftZpXU2shQZX8A+GWL3A8b4=;
        b=XcpMWjPkSFWXD7/zTiamd52MMAu6g58Rl5EzfM5Io8gYkH5FOXxDClb3DzvVOrmcKy
         JqS7nJmD0KkUNTr9x6ocrCLHHuxWcvZtBzrc4lf+LcFhrN6X/uu/7eRysGpZqf7sOb4G
         llIbUEAQERJovej3mlqBv+o2FrOtMvBm9g8DL28H9paUDdeZmujvwL7UTvjcnJ+CnW3l
         KCGd1hrookchRylQzmncB45qDPOtkT8Haem7I+0WBhlk/iElepZQ4FuvDYnfpeZ4nncl
         3i7TF+O6fy6oP/E1Y00z5an1xzcW9Rw8QHqJpbsW9dJMiVQHJm2qkVT7hGDXAZF86qOP
         6OaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778066380; x=1778671180;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZuLNVvMag585tow9qB2ftZpXU2shQZX8A+GWL3A8b4=;
        b=piQyPuXkChfWhfMaflaKw5+1S5RpIT6k/G4u4J6DS7aWMGGrkN5v0N4bR4GUBMF41Q
         Hybh29bKdUmRMiiTqnaAvOJMQK4E5un4nzhlkJ5M2DxFiZEaW79ousyfVIfqyIq+WcIJ
         0JIqLwcpWVzulj8ZMQ28ezYEnFmjN9TwJJ0XedhgoypoREvRG3b1BsIvl+LhoKztoizJ
         cPj9BqoDXZ+i0G9G7mhEjIZI11wCJt+gHlMu6a9HLbwqDTC6nGgjgpg8Qx0zl1s076pE
         H5/C3MbqbY6mvfikBKClXZJ+wEGKVdkAFsdUQfW5Y2BOWrBuj2xmrKU3E2rSO1x0byqp
         tFkQ==
X-Gm-Message-State: AOJu0YxMV9aeCLx/8UxfnBgYKrqyJ9QbMep9mXxR9aXJxoHqPuvdL9Hr
	ZdJVW7WExKaSpyVM8oQaotHhHrJ96e1sKjDt5RKhryDa+aNDDuwoFnOnz0mU
X-Gm-Gg: AeBDiesyHOuz5DVNWOHE4NcXauusPt+ZxkRjns2BZch37gCpwLVGTcm1B+7BFh/oQFz
	HRJfL+r5RbkYcXVQDxJsUR/tDoGMQ5wYZ9aR80bZBSdsOYN7kKZoN3F4YgNlPfFRKBeBqtid0/3
	Q830E/Q0GD+JuEd1W31nLQSiuDB2260QYasM6gRfI+bEH2LwyPcrUToLofmSLzB9BHjh6LY7ONY
	oe/mylhbapkzy+eE8WvPmh2eMWgAhzZ+SSO7YZlmO8+S+fIkE4Rn5j+Xsoes7HwEjTg3uiAaJK1
	/DbUyxyXDZFgZj6V8pOw791zN+rGMIeNrT1lscWP9CE4XsR6Y2C9PAKm4lH4lwgwR2XZll72nRv
	NqJ2Q9u2aQrRLhEWF2Dy0dJy1YG59xCubPxtaThf9oHNUqxBIl21o2vhmiXgQS4vDbIBkM/TQVW
	3d2MaAvExmDL2yZz13h/uPlmUsUWe/5WE6siHa24zB1iOGgP/CY3oRtLW66A==
X-Received: by 2002:a05:6214:410b:b0:8ae:5fcc:8069 with SMTP id 6a1803df08f44-8bc439108e7mr39170006d6.22.1778066380088;
        Wed, 06 May 2026 04:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.109.87.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538c1241dsm177707896d6.5.2026.05.06.04.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:19:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260506-window_clamp-v3-1-ade82fbbebb2@kylinos.cn>
References: <20260506-window_clamp-v3-1-ade82fbbebb2@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3] mptcp: update window_clamp on subflows
 when SO_RCVBUF is set
Message-ID: <6f8064ac-4bdb-92b7-1270-a0dd9ed91983@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 11:19:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25429148337

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4f281af32a03
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1090379


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
