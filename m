Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFA4436
	for <mptcp@lists.linux.dev>; Sat, 27 Jan 2024 02:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706322279; cv=none; b=tnHyQJsVlsrb6hZ8irVo9lt9qoXhcJNWFqvS3DAJAFIQj4HLMkg4qAJGTgb+reQz9zg3Bj84tIeLrfg9yAN/sEgKK46Wr2TOcKfzSYjn7rts9EUd8ae6iSxhSq3SQ9+njsDZjLPi8xgSYUdtSPqzbY1z/IOxIeV46mQwWMyMtoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706322279; c=relaxed/simple;
	bh=qWh+DV4IhohZk2cLnZ6Uq4jFjBzr92EWumm8kSei+Z8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bAzQ5n6YNacIDy5KwM2GVVK682ttk6y28Olh/xP1Vkzal/oLr70XBbomw7CRUUd1DSuQ20vUbJG9yoSHyLW1MBbBfFpHgvIEmyPDIpwqtqF4w7+7XmCmJWoVsslfFjtJvacx4F94IV5+ABDidPnEATPhz5rj0F6fpRiMCtpkQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn75SUtq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn75SUtq"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783cf58221fso89701785a.2
        for <mptcp@lists.linux.dev>; Fri, 26 Jan 2024 18:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706322276; x=1706927076; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BIicvGdyKtVGH0XfdU55aU+pomwBTWgSkVRl969lFc=;
        b=Jn75SUtq+g2ArdSUKc5NlsRS0cUcYn7lGrdLsdw8/G7qlRAUPfPJpXmNrv4lPIjkqD
         4ugFz+zGx9/Xm2/82PcMFUq7PSjqL+b6CPq6rCPLRBiRwS6PAMnGyUDD0PeayhxzySdR
         E10v8HOK4nbZXsxaxiy4diTVWOb7brqwCp1m740uX1DwE8v02XVcvYQlXIgRj8ET6mWg
         w/ijrNzxC7YVFKTTGyaxwcVBMgTBjCGu48nwd3iJwyIz2yp6AQyUCWsODDm8U5AVHSaq
         aBDvi7lIzS4D8bhW92heIsfdhNk4Q2oC5NlCiJjtj73igSyUo6U6ognhr20LJIUi7Pkx
         gy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706322276; x=1706927076;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BIicvGdyKtVGH0XfdU55aU+pomwBTWgSkVRl969lFc=;
        b=NXa8VTMNi63CuyLOAn/qPo+FokErsIuJF4TZNq+gJa0SBHvnDuAw/n92X7MqMjHx7P
         uuO8qaGkLY/3ZyqbH1rSjhADluH1LLbunYLhVzJu92e4KxuGZYJ8x6duwWQFM+ToqPSK
         V6A5mAGmT3JbwFPt2yxSNQnAA6zlQ+iktw5RBt2mu2r9+2Dc2JFoVwy1S850HZQP+CI1
         95T2SJgPili1/GTqzvSo7ZohvcP4fkqFnTAUQj2flHD3CJ310h3Q6yZvKG9LmV3Ts1DP
         wY8NTeiMAVT8JiQK6RFoATd5UGxQ63zxKXKV1rv0LCGnem5zoJT/Hg1MsBB+5KqM8t+J
         VITw==
X-Gm-Message-State: AOJu0YxwD6+7XLmjynyeTnDlQhYzL36Qdk9ZKNJTx8g4qcRs49Xz6W0p
	7VxNemEek6MQBzIAr0CMyUYP2m8xVOkGBrCvi68u8c+zH4IBvYU=
X-Google-Smtp-Source: AGHT+IGcPqYfRZv7blrrHDkFVIviogbTTI3jF9mfibd4WIMoIzgobtciIbOM34Bq73bLZij2kwpWSA==
X-Received: by 2002:a05:620a:17a7:b0:783:8d13:998e with SMTP id ay39-20020a05620a17a700b007838d13998emr956466qkb.36.1706322276329;
        Fri, 26 Jan 2024 18:24:36 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.133])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b00783de3ddf5esm611494qkp.70.2024.01.26.18.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 18:24:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
References:
 <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Subject: Re: mptcp: really cope with fastopen race.: Tests Results
Message-ID: <fd730057-5b03-e9a2-e174-6dd1a6615ef2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jan 2024 02:24:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 2 failed test(s): =
packetdrill_mp_reset packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7675=
409892

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/00a670cc257a


If there are some issues, you can reproduce them using the same environment=
 as
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
