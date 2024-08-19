Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7915B11D
	for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057667; cv=none; b=BKkzv8P/3G2z5rvMuJPLPvTbnKSlJLGfNc3uxAb2ydahnLGzc1kM+qQ4ItdKOaiOLsDbZlIRbR4SN1euEpMun2ST2ovYhptwbBA2tiVEiNFv+z1MXKNhZRpr5N3GFbf2uqecoW4DnAbxMKndaF8VrYRZH5FhgvB3JIV2T+LeL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057667; c=relaxed/simple;
	bh=obEOVBZWPEGuAa1VmKMpFrHef933YrMyftRVeVN+iT0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eyge836w/l4IfAPUN/zfLe3SCFchuWNJ+Rci9j8j+RNgAvOrs9rATIjxzLrrnKA6n+4L1OpD2tivOrp0SIaZ2vqYkm0UWZPEvUce4bjyZpe7JKB+EkQT/y76sdqFayS2AZuvsa4YPFlT/2kVz2Zsv9CzhoH3E5JBCU7aqIz6qyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1xaRurW; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1xaRurW"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a35eff1d06so291329385a.0
        for <mptcp@lists.linux.dev>; Mon, 19 Aug 2024 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724057665; x=1724662465; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHwhriS49cKLaYSk+rnbBPRvl1IANO4K3uzlaqTDnJQ=;
        b=j1xaRurWpoyMSZAFeVgx9J65wPozvBeSGXSaB9DjTJGeZAg0ZxBFPQ+XI7lQxFu7uZ
         LtPEReC3sopAOM+9bVoFiptWcgXCRAdWlIKRPC+jR61qfLVUrhf077NkQjjnqfp6Lkgo
         fdIO7kQQny/cy7M3nHQ3Qf1GMQgzrQJby+n08ynqfe/pz58ro0WLokU0eZDCPW7uzY9P
         7qy0ahL0OjKf5HQlIyfYZrnN7RWV5cZMyBzjzTg9pgQBLEJxgz/FkZg2F1NeeSzdOtHD
         A/DmG5jgenjhNE2XD176LLMV6lxSEWwlGoI8NWPiY/An3hobZi1ZVEU7qtrzSQG0zB92
         PR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724057665; x=1724662465;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dHwhriS49cKLaYSk+rnbBPRvl1IANO4K3uzlaqTDnJQ=;
        b=FlA5GPgesIkuNHECfk65xmwvDBAwoa+JJbYuOMElGktZ1ypHz8xDoMW3ND4iqYPtDz
         mhDo6KJaBN5lf2ZlR4VtP/O3LduoWVdLLuzJcHPXUDBVAdF4iI+STS4r1+xae7KZxapB
         Ls1TKSu+Y4R6bZkUQR9rDQ0HjsHBbnVDBHK7oHpp9HEAiqpDjVG+4yqyOxrq7ZD0FJbB
         JK1K1CIE7or9FDHKMIk64u/xLWTF815HXAuoI6nvksOJFiTdD9D6+Wnzv3U0Ae5IXfAX
         DKvecEsPK4dPZyrY012po1TFwMD+IKDRmUTAwoflSMFmzRaAXd3k7hVs01lFIGmfqtYh
         uh5Q==
X-Gm-Message-State: AOJu0YwJgNr0vWm8J+bpWBrFbIo+KKmN4/T6bjV6wQm12RdrxiqQHylz
	mfxr8Klbt6RlPDM+cwpSrpO4sS9qA6dMNdrT+hHZDpX9z9ffbRg=
X-Google-Smtp-Source: AGHT+IF+yqC98dEDCmv5L5E/82ON9z+FXe5jfsaWqd9rD0D7FbZXntn7l+vHVtwY9Nw8j+Bhykn5YQ==
X-Received: by 2002:a05:620a:244f:b0:79f:d80:592b with SMTP id af79cd13be357-7a5069d3c98mr1037774585a.53.1724057664956;
        Mon, 19 Aug 2024 01:54:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.200.199.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff106232sm414005685a.108.2024.08.19.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:54:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240819-mptcp-pr_debug_n-v2-1-97cbe3f7d975@kernel.org>
References: <20240819-mptcp-pr_debug_n-v2-1-97cbe3f7d975@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: pr_debug: add missing \n at the
 end
Message-ID: <a4750611-b915-6625-a359-2be932008e53@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Aug 2024 08:54:23 +0000
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
Unstable: 1 failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/104496=
81118

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/41f8faae83b2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880801


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
