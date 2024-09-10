Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8A1386DF
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 06:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948128; cv=none; b=JZuVvUGxEMRgj8+/v+vZe8UrFDVbUx79TfA1D2B4cany0h/HW5BnSwwVQbK3Dj/GpV5M8YpGpxpCK+OkcZvGP94KlJ7SGWl5KxOnwJIncxDSnxPkj93WWTgo4NKpORrfvvDzUrPJP9DfwH/UarVIpVoL4iX8bdvBiwHNCFGccNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948128; c=relaxed/simple;
	bh=oL/w/tiZou/YOpTAYGFPHLi6fDsU9BOKLGx34sLDz0o=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=X4zicWjUAHZ+YA2KJ3+VO9eP+fpWChJYBwvyns4kpSWZnbTG6/ovMWUiyVxaTzyg9oeBc6GfiY8JdIrNtCt2kVcrx/Y/+Il6/VQdDh68ux/BbzRoKWbzy3jYVdBNb7A99ClZuGhTxFWrniXmcch1xOYF/PkIrBZuQKjRRGNeNoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaEuaxUA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaEuaxUA"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7cd967d8234so3310389a12.2
        for <mptcp@lists.linux.dev>; Mon, 09 Sep 2024 23:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725948126; x=1726552926; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgeKc84l26mrX1nvozj9FxeLq1DYl6neGyi7AfyciM8=;
        b=DaEuaxUAOcin99wz6xTS4u4tSh2+RyOjv1aJI+mRwoPdcBc4vF4+ZNtgxRyfHrAlwT
         f/AjvtsaeYQqZXixlIvhewE364L16TtmFWrcwZE2xmXdt4/4bMEAJ7akI0BzJVZH9wC+
         WidqHt9KF8COqVhaXKyp4RLck1sZBBmClag1NtIGXGLN815VDxsH3hVDMPw5TGDcVCRq
         WYERCdUvBcotsi/5Kxmggz358Ad74g3rdOPVzxdl6GeCNTEbfP7gGnk7qniUHXy5MVbe
         m7/ZJzRN9KkVkjLw047OXova0UEFi8AsaIPzuslte8fbhHfDcswDiYKdj/LYaD03o8Zm
         wBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725948126; x=1726552926;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MgeKc84l26mrX1nvozj9FxeLq1DYl6neGyi7AfyciM8=;
        b=afk6wQqLHWRDRJbYWreGtxpMzn72j6ZRPnJk6XMZCLZt0IHgMamBn/uTQt2bwO7Mvf
         d6tbYKXuEAeTpy50W1d2GcsuGmTM0OJui8GyQCjGO1cK5BQC6rGG7FTpRdrIy5nM3Qyb
         wHZ7uI1CyaChljecZHLEM2hCQNnY1q2cyTWVjDNu1MS6p0xEAGudiJwkjr5aBvqP8ZbX
         WlFVnAiISlXjauQsdulu4z7gX3kwF2TmWyjEXjK3u4ZgPfgWWN6a9ComClVgE8WUr992
         WLU0mtRrmJUwBiK0ESVjQnPF4OUikL3qmLroo8+7uKPlVOl5BUT3ytiloE0BvPUSImSV
         CALw==
X-Gm-Message-State: AOJu0Yz9/FiSB/rV6l9MOB0XQ4DrMwF36AY1raACyWjPRlz817DOeVOr
	qxXSR81nOcMU8ZwDY37KHbhV4TNE4baI52copr7RbtF1z5l8WKPeI1Pj
X-Google-Smtp-Source: AGHT+IEO9EFvVVkwO+U/gWE8wBBXUd3JUDdia44yfoxXbNPQb9T1g7XLuQykN0NNugN24C/sRBpA9g==
X-Received: by 2002:a05:6a21:320b:b0:1cf:39ee:f249 with SMTP id adf61e73a8af0-1cf39eef527mr7106540637.6.1725948125852;
        Mon, 09 Sep 2024 23:02:05 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.187.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d823cf3d58sm4160690a12.20.2024.09.09.23.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 23:02:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1725946276.git.tanggeliang@kylinos.cn>
References: <cover.1725946276.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/5] add mptcp_subflow bpf_iter
Message-ID: <34c218c7-bab6-28b3-1940-949977146e87@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Sep 2024 06:02:04 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/10786552828

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/ed=
6d012aaff4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D888713

Feel free to reply to this email if you cannot access logs=
, if you need
some support to fix the error, if this doesn't seem to be =
caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
