Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294BD172BDF
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806968; cv=none; b=IeO1lzxgpehbXEcleLSXSKD+dfd415Btp26KIV7ls0d6s9/wttPdX1VEKLmY/52QqMmT56H4kr/Ypv+5M0K/UaV727+ykT97FCwuzyaQmduUzlbb0YWtiEU+cvmX6AoR2HmqVHbb8ouK4LrVNStFdtJxDUfEfoP2pZTKKA1Zu+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806968; c=relaxed/simple;
	bh=0ez3cK8n5YHcTTq6288sP+I9nYFPTNOjDA1WOEKSvOY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=B2WQj245joSU2yosLSMbS9BBQ6ceZE9BM4ITe1eOA6v/QiKsUlv06edhXv3dJBprc/v6cJ7B7eGa7aUT6DAhKcVs0pm3gYyJsJbLg5o8ezsD8ScyZ8fltw4lyJA36rQqChY6Igw7blZGWo0gX2KUwKLb/DmDV9h0g6mTLBmli9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctd//UgP; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctd//UgP"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d024f775so136063185a.2
        for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723806966; x=1724411766; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itoF5VWkALz5DYmagaypFE04LfBMRoDZGnt/x0zlQt4=;
        b=ctd//UgPwM3SHtgotwNsadv1qOlcuCuWKJRG+a2/ZYMH1UaX/7HalGQyOJX/7QUa+i
         vgGO98RtLouc4TZQUAfDSB9yd3H0FXunxG/0FvgULio0w6QHPwNDeAD98w/9efzBCAmE
         14xoPCsA/J1s+C35iO1TjJGNYmMhEtXm/XiVORMxIUah9jtRDh4H5HDmM6YyB3a8jTs/
         nq/9Qu7xIf3+czlZhf8zCla0Fym5VwQkCBaAlb+eq1vra3oqFMMGaR+MDOVLZxZr9zhu
         mVxUY79faXAg7a+yvzifSN0ZA5kWF6ok4KD8VsWay+kh4d/LtLa/BJePUA8SOa4C62HF
         6DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723806966; x=1724411766;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itoF5VWkALz5DYmagaypFE04LfBMRoDZGnt/x0zlQt4=;
        b=E9tBmq4MkkIj6hVvcmtfHnpyWSLOnRIg5GQhmVvucAHJ2citILFvBvb+vgGwIgvMwS
         /GX2H7fgEq01X9XB2rSun0qTqnmOTWOaIu7H8hYSzArWGv+TtbydRbhpPPy6B+3xCdYN
         MNpKvTfN67fDD3JmFldjCsHpUCen4azhyzVb52ETpLCfp9tTM9pXBAV9SRjcKIcGsx/2
         1ta1Cpzj+3QESpACG94QojkL2QpL8Oc3SLfXB/8kdsm/NQO1UGTCm+BnsH4K8+U2DFTc
         KKzKtWEaGK/Bc2TpGcEy9JsZcW0c3oIKWJqKJjx89bVwFynm98RJ9c0SxDn6Rtlir0gI
         uFsw==
X-Gm-Message-State: AOJu0YzWVvY6ki6Rp0Ndag2K2/siUeJocEp/2ubnnAyfs4jZ4OIVtngx
	YuIzZE376bSebHNOFNYruHPsa/fPvZOj5bWHD44HfTFICS8FeZT9DoQu
X-Google-Smtp-Source: AGHT+IHn1HndtwLCjSyMACb3u9WNdU2PuAjTqIc1f6MKHz0trAmdKeLJBwxCRsQ0rYZ0CutXgNaS3w==
X-Received: by 2002:a05:620a:3184:b0:79f:b0e:2e70 with SMTP id af79cd13be357-7a5069bf164mr279610685a.55.1723806965769;
        Fri, 16 Aug 2024 04:16:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.122.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff06af6dsm159622985a.70.2024.08.16.04.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:16:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240816100404.879598-1-yuehaibing@huawei.com>
References: <20240816100404.879598-1-yuehaibing@huawei.com>
Subject: Re: [PATCH -next] mptcp: Remove unused declaration
 mptcp_sockopt_sync()
Message-ID: <e739803b-d7fc-671b-99d1-8c3b0a8bee91@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2024 11:16:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Yue,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10418496805

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ca2f2e90bcfb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D880284


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
