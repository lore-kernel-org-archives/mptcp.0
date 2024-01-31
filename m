Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ECC12A165
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716251; cv=none; b=LDAlPiFNkp8wXykIYkouiFvQ+V+vjjDavBdgC18YOxZ2Svdqot/Q3O4k1M8nW3Kqdg6PII9PkUyZkTTqDqx2lMsTFd8+4idRmwabEGMRahUFW2DHrkOF+hdP19nmnuE5fSGxoyHgYww5WZyDJtbpsD2u+APOfTRbFiSr860iL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716251; c=relaxed/simple;
	bh=RyMYNKtu9X4YWKnOm6p/SrlHZ1bZMxdKiKpeARmDmOU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=J8Fc/aUK8Qf95klYr7I9FMHvdkdr+uKLwgF6aiOYlf9vvuqKuIOVGDkygkl9vDnVdfAebplWiflgvxXJdeS3QG+8+cZFf8KlG6OytwA6lVUEY1F8I64EnQdXNB4gaw9tY2/bfUJtGcJpDA3rcSNaNd9PVq7A9vLw8Sx3MLVPByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXgwv4kF; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXgwv4kF"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6933a46efso2825055276.0
        for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716249; x=1707321049; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYUiXu5riWty96c0xXJvMr5YPZlDQgbfmMl4t5S3PzM=;
        b=BXgwv4kFd0Ur27uD4Z6SM5RXyPIGvbQ/4nL+2ZhX9xPxruE6XxQYajJW+NCwUDRtdd
         f8KsoQ7upj0GivmICHd44l7P78neThTdkujPTFYMqdWERk77GIWJsQh3QUunSJkAvLCZ
         Zt+qGeqhY00ZbjoIsvXyKSt0si8yDCJ5JJhH3xOzGY9lfmScsBfuMBk2UrulTrO9dqKK
         WOMLPFMRBX8RYBNF4TpQwyvGTApdiQXD+kMyrXbDUNG9bhO/b7TBgc12LrR9rXVoQQpZ
         scw1PnIxXriMqOO3OPdg3ec+l7BCFcbiSODPD1/lPacSk4ATc+gaaW+IbgzBqhIZP06B
         MDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716249; x=1707321049;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tYUiXu5riWty96c0xXJvMr5YPZlDQgbfmMl4t5S3PzM=;
        b=VO6v8moXaLEt06hPCf2OJEF41AbOrSO51rCcjcf2fhu33IRB/WKHOpo1Fcm4f4JtXh
         73FeAQAYodeAXrwm11LgqwIPXmiHjSNHllgpLJkR1dUQKDPE0F/urcknAk7NV32D7MTD
         E5946IZX5+lJa/ZBvaCbxRT/6YAliNukiDX4SpRD8jBnYJd8cQo7NQj8ndmQVTEdMjl3
         SGbnDut/hnOZWA9GS1r2NK/fbDM+dYOAPfbIRr7fUgg/yYGSBA1oApKwYKMjKe2wKdAy
         UwmfTw829nFz3GmkjXGEuYIOTmMXqEC7bZ0mhem9qe0JiykcC9OdIgcjvjBUjiX2iD2Y
         N7iw==
X-Gm-Message-State: AOJu0YxIBuCyy5yiLVnnZv5gtgt4bFjlMUoraKVmrXYODlw+S15TtSdY
	mk9NIstZxNCQuWpxAR5xhtItaHDZEdaZfPe/0wCDfoFcw2Bw3zE=
X-Google-Smtp-Source: AGHT+IFwNaz1lMnQPl8KEvTQ5e7etAH1bvHAihi398YTaPROneWnJzpspGydYTqcmcIUYo1nsHONhA==
X-Received: by 2002:a25:293:0:b0:dc2:46e1:3d1c with SMTP id 141-20020a250293000000b00dc246e13d1cmr1964901ybc.34.1706716248636;
        Wed, 31 Jan 2024 07:50:48 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.200])
        by smtp.gmail.com with ESMTPSA id mu12-20020a056214328c00b0068c6d56d4f7sm651731qvb.92.2024.01.31.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:50:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240131-mptcp-check-protocol-v1-3-a06067f0bd08@kernel.org>
References: <20240131-mptcp-check-protocol-v1-3-a06067f0bd08@kernel.org>
Subject: Re: mptcp: check the protocol with DEBUG_NET: Tests Results
Message-ID: <f66cb7bb-fd7e-6cf8-77e2-423e3f2ccc0f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Jan 2024 15:50:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- {"code":404,"message":
  - "Can't find artifacts containing file=
 conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4603007531220992
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4603007531220992/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5728907438063616
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5728907438063616/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/399e99c4147f


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
