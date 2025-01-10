Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC74E205E16
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531739; cv=none; b=KVO5fAWfRPemfp8VaZNZIgh4CkD9zqiiOXmjLe9jy2Awzb1r/bNvHmPjsjSAAoFKlro2mupm4BabNy5M8l+h/qeq4nU3nFGE7x0+IKhCLaCxYX4pWCZ6jv0hDDeZyQDFjgrSeDcTFSzRw7ftMGtl2zPMA4XbwGW8iBDSIqcVbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531739; c=relaxed/simple;
	bh=YKjprGzrM8yGTYQi/+VHYz/CuL7esBNILsJXdKZN7SQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Tp6FGAJGHHEOWBGAdO/3FYCTy6DggcSv6NKxvV6J8eiCtjP8ANCttKNfRT5lK91J7QFtkjGBTDbwm6cwK285O2iBcxIe3/MDSD/dpy/5LGnWwrrYi177eKXjjjTwaEO+IpvXTAIHoVmwUdhfe0f70QKHBPmB7uG2147uO7l/nYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYF6wUWe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYF6wUWe"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e4d38185so208456085a.0
        for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 09:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736531736; x=1737136536; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBinPWlUYaCREQ++NxlHz4Yq3Hsf0WoCxqhdwLpuHBY=;
        b=TYF6wUWeoy4THNiTbur2WTclqwfQWBCwXV7qFQaHJfv6lo/ocnELHAUCirWFiANjUo
         3LImompyCTMM9HvLBbtMA64iHh50YQDdSY831r4XQURwGYUp07k2s0sagta6OD+OKkTC
         n1mbWbM1qAO2gLoIZTAC3wlFJdwfz4su7jbc+wOHI4UrdN07WMK/GerydZbEuiw64lOR
         d/+5tjOpOWxK5dB/Hq/826ZP6SLuoG2+wS5YL7FKRy31bovaAOZYCdIACNsUjfMmdgKZ
         bzY+hccvSaK/8XYys48O5CnWQ4SJKgucgYim3FCPiyNFLB+xrCtgeY4RK3ou7b6GwV4X
         Z5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736531736; x=1737136536;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CBinPWlUYaCREQ++NxlHz4Yq3Hsf0WoCxqhdwLpuHBY=;
        b=t1YxvEm0cBY4tXqM1gE52S61PXNdnAq0IozD4q0swElMe6ij0vDgFoEjlWtsPVjhQ/
         eU3euOzcx8TP1+7ibDsrPLon0yQK7sJl86OGO4szQOfFg+Ca5pVFo+uoXJ2w6Hg2hAhS
         93UsunnJMvH6AxkXh/8iIPvzDMw26DhqTR8XV+f/pnReisWhdVKKAHFpubh08E3K1chY
         AOWRJLtg3ZzxbRZiOmZcjGpJhssIMNsj37TauTCqGBNQEpb5QFlOG5dxPTzeV4dcUdCX
         xy3QBe9y8iH7GturhXb6TUa5NrK1/4OJjFGc7wPK812m3we/TIZb9QxnpDLe2X5D5OvG
         yP+g==
X-Gm-Message-State: AOJu0Yw0tKTRBvU0GkY4DmI5Q8cN90TvEy5sea4v5rddiKvDJmnI3VVJ
	MtQeHY/aLiTR9CAo5kjHnYdQiMjiBxJUDXMkmvmC12lGfNksS/RglZgB
X-Gm-Gg: ASbGncvqxnLkXykfshI9ynWPpoRYW88XUOZ0N2ndRB+HO76vD9SV5w5hQR863//54m/
	Kj6NalZ3eLwadMJ8Mvqp8jV83lnUo4utGFQcVgeMisGj2YiPOjvXKiltUAJGRjOoJxw2v+Fqv9k
	FI++NDuXWaawJRH/hPLlb+KxhmlRiXTa8jcHLPBmwpHbyIYu7AD+h9nd8VN+ZicGw+OivAmHXy0
	90/us3fMj5q85SQymYNnxj0nTaasHTs32BZbuPsK3Tvg2UPgvopgoJFOClfd9luBmfznw==
X-Google-Smtp-Source: AGHT+IG+niWMDGSb/dw/tvTXqd7iDSFOklxRX5w58GLf70+AR3zuaKC8M6plY4hN44gGbYfshTanBw==
X-Received: by 2002:a05:620a:40d2:b0:7b6:cb84:8135 with SMTP id af79cd13be357-7bcd9758b24mr1986381685a.48.1736531736624;
        Fri, 10 Jan 2025 09:55:36 -0800 (PST)
Received: from [127.0.0.1] ([40.76.238.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad89a052sm11473796d6.47.2025.01.10.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 09:55:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1736527092.git.pabeni@redhat.com>
References: <cover.1736527092.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net 0/3] mptcp: a bunch of fixes for ST flakes
Message-ID: <0d4ca752-105a-428a-99f5-d7da81eef4f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jan 2025 17:55:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/12713850045

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/69da18b21696
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D924334


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
