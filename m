Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FE170A2C
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507877; cv=none; b=B0ByJRGukCOOswFVdQ1QbtQNmNaDikCRLi5YPg1v0O38DeQmgtYSAsmvd0J59h5i91vkXhxHM3PzCuVcOlDFkUkjP17jCUY3Vu/FOXkwytJ+FgFTTPO6lqXHQ9gXGQwraTKuf6EMoS2v4N8/ahvxC7HAynb/vozyEwIHqoJdU/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507877; c=relaxed/simple;
	bh=xp5FOMqCLfoS00vTPETD9lDtWL8tHxJy3mQGrkiVM0Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=F+iy5Js91rPhT0wxNqh7PTGwuxV6yXSTygCuSVthe0pvFZDh55HLEJVDi+81mu5cctOF/zh4A73gxydLtOrqwcQpQzNw9x9DStbIlIpycIhJRs6l+aQGjte7pcu6GP2B6uiRxthB7FXzbjXr9vt0Ek9PkePf7ubxIgTaqOmQMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUOBh1qg; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUOBh1qg"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8231d67a168so1811512241.0
        for <mptcp@lists.linux.dev>; Thu, 01 Aug 2024 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722507875; x=1723112675; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi3D597WFmEla3h6IphmNb3kFI9UR6aANWqrWSU6iU4=;
        b=NUOBh1qg1hwGC22laz2X00I9meytJoaLZo0m2W+DPChxKE2mo27Gxqzk52QhFZWRdy
         IcWw2tHhI28mapRYtn4vqOLX9cg5Glo/Muw7L6xuq4qcopZbyeEGJeQzwWtyXXItazVC
         pH7OqqPcYNeGjj5ZDaXTKooEoTrQtGzToGStxNJ1F4uB0FGToi4QfMq0t+xDGf7Kb5wr
         kgw36vjPPGdhuXYc+uMsqM4wU7NQFt4N0n+6Y8X+592qZFFH0Ywb01FgjTiPtOxcR/ac
         yC4WOj3ZSbDLM4Pd/pDVUzdz9x2Ybdej8B67GTeBEGvLs7aKgiR2vSqrNwVcD1FE07ci
         wb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722507875; x=1723112675;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xi3D597WFmEla3h6IphmNb3kFI9UR6aANWqrWSU6iU4=;
        b=OVEU0MXbVVH1m69MF9bP3CaQsW89NNIs2x9GP9YAo+cW7fapXubcdz2OrZvU128GiF
         LOEfCaQJjgpcHZYG7IvavoO0l/ymDZmDn+hbsdDSseZ2sZ71il8sqduN1m2Mo3nyJddD
         ms7/mtyXyVfbxSzuZvHFzyqXAZKo5p3tqfdlcni2lUhxBAr6TUJJ3jc9hMRbW7PS4gLV
         L8Isd9MAolD9JlREdxKYnjSn1UwvDEt0ZKiFlPSzC4g4JvmrOBvyEMERINtxoyi8iCag
         xwLy4oY52ymmNmkYIdFbLQSMH5WJfz4bIexo6/6FXTrtXftJf221KdZjvbBTBOvOa0xL
         lwtA==
X-Gm-Message-State: AOJu0Yw4EovqIgwYr5EDLlfqB4dbqOSyqUg/gXZzkbhinGc8y+TxgbfT
	xMY5Hcid17zmcMFQoElQ28vQxMWydoi8jrA5JeHiF+FYMxzPXkVrd2Ov
X-Google-Smtp-Source: AGHT+IFDrkaMm9RwZ1HCtXfQAQUIaSTIgkRmEu07eDT9/ueTrNAkNKdDtrsdnTvGO3nlcaDtar1ReA==
X-Received: by 2002:a05:6102:3a0b:b0:492:773e:a362 with SMTP id ada2fe7eead31-4945099babamr2250906137.25.1722507874657;
        Thu, 01 Aug 2024 03:24:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d745ef8asm825788785a.130.2024.08.01.03.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:24:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1722502941.git.tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/4] add io thread mode tests
Message-ID: <438f6528-5c66-769a-6d13-6a1748b4c0c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Aug 2024 10:24:33 +0000
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
Unstable: 2 failed test(s): mptcp_connect_mmap selftest_mptcp_join =
=F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/101959=
63580

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f33956e6e0f6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D875830


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
