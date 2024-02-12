Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068AC3D540
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755309; cv=none; b=GEEEnK5g950PbRLdrxcRUp5a/Hul8BBMa6CwJzqElnEZAzH6tp6S17qn0Sbargyt/4AZQxDXSKkhHUDFRnSfXtUVy9iwZT6gl5ad2dsbzrAgHAv69+YTqKwAHJTeT35nI1+TIC0BUKdhxK3KOw19s3+G145djAPM+XOAXlkgytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755309; c=relaxed/simple;
	bh=TtHda/tQ0IMuBehMZSymjqkhHA0fQLyXJOL61H25Uyo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hWUpL1kZ+OgI6bAL0yb8qx5LeFAMb6JaOXqG4bh457XYJlrd7zvw9LgHsj7IcB5gi8axU3TZ7BboHg43k7PBCR1YvD1/Iuyw1GaJi0gmqJI3jYoIVdakwyW11T2NYtQzXT0Qa4a6OJdiIf2sHCcVrS7jzGsJQDVEympKMDSq92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfYFccib; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfYFccib"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so2114829a12.3
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 08:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707755307; x=1708360107; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHWWTRamt0yIpVqjcUEP72qCAWyLUuvb/PXWBSfmKJo=;
        b=BfYFccibekRWCtxbwqJJKZ03MQfTSVl5RPo1quYEQTOkVHB65yC5z2ewF5XGCaaGBx
         5dTiaKGezd7EOORuu9A/HvZTodRLvGCaNAYqaAip3pY3syPlfb1PuGLgAHfGhP1ID6t5
         sdjImv1CMCbtCFt9pD3l+sn2W4fwVXSGNlYXOQOruU03Ryx7w1bDdp0ffeN6qkJvdrri
         hn++Mqtg0yBPmZqnJaSwAq/5Ce+HFkbVmQv+ZzIl53fyAvJyBv38pBB1W1HZFIPolvA5
         5jUci5JqRAC6UQ+ZLUxYlJzblPTVyO2wqmnHmvMxh6yQAUlyQrm2pUsRDbIbLwvxvuIH
         55yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755307; x=1708360107;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eHWWTRamt0yIpVqjcUEP72qCAWyLUuvb/PXWBSfmKJo=;
        b=rJks3IYXiwX5y2fde3DrF2OgvcQ0bmeyakHxONYw5VNRuS1y9hRYuvYWMsM0JpNMj7
         c3Bh+bT0Qn6E3KTlJ9cosmuHULv0YHC9M4Ph4kab5eX+wv6bjuQ6JBZFRXK9T5LvS6No
         QGTiC46IeazB66Hjx/MA+a6n/nfbBx6C0fTBn/ovtOpfNZSOObbUntWeKDPnmiTuEFBe
         J9gJjl9wrrfOCSZmAFhn43l4skYmxSf1HNB1fJowdpWA62RXebOpH/E2AnY2sm3nJo+k
         OKOZvOI07gM2vM2PEUMquFTv/r3Tcu8/irqFngnqXm454bqjvDRkHjeKGmjeEZ84++Zq
         ASdw==
X-Gm-Message-State: AOJu0Yw9ebJ3IHNEVxuP4CFQOhYPmd4qcYy/U2vemjaVLWx7FfXlCuO+
	tIdcVg9WQk96ouaWgovPZCfqqDmr5ZvuADLoqROBh82/AzYAHqE=
X-Google-Smtp-Source: AGHT+IFS+lhjGNQqImMnrBK1/lTbSgKkpbOHrGV3UBJDWEJYZjI2ch1mMY1Suu2c5umAXnOiDSPheg==
X-Received: by 2002:a17:90a:9c2:b0:295:cf9f:a1de with SMTP id 60-20020a17090a09c200b00295cf9fa1demr3367125pjo.12.1707755307113;
        Mon, 12 Feb 2024 08:28:27 -0800 (PST)
Received: from [127.0.0.1] ([20.172.17.138])
        by smtp.gmail.com with ESMTPSA id lx4-20020a17090b4b0400b00296ba96cda9sm717273pjb.55.2024.02.12.08.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:28:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <da768759d9993dc8b086a1ea40131be592ae55ec.1707739536.git.pabeni@redhat.com>
References:
 <da768759d9993dc8b086a1ea40131be592ae55ec.1707739536.git.pabeni@redhat.com>
Subject: Re: mptcp: cleanup SOL_TCP handling: Tests Results
Message-ID: <ed428763-3474-993f-31ff-ee58e477dad5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 16:28:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Script error! =E2=9D=93:
  - Task: https://cirrus-ci.=
com/task/4764402235211776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4764402235211776/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5890302142054400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5890302142054400/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/11a409accb04


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
