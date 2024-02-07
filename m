Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6107FBCA
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320780; cv=none; b=tOtagp8DS4yxHnZgESTiCSxmXZxo9/k2FsP9QNd7LLJKGyjTmm1hzoBvbgZTdydFdHt1C9BufUqpN5/wKmW7z7GKw3SB3w7DgDTgeewMU/fdcdbh0GJeVm7USu8bRrd8Z5aZRfEoU0Al7NLAByCLLxB5Z31ez4B8CuTm3UFZ+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320780; c=relaxed/simple;
	bh=BqZtJOsJatrhoiJwmaNFiGkByHmlr+9Divytjain/uk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R6g7jZGALtlzvITuzKml6mLz9ijE4PrmBcHpgQLtTaCFPH/z65ACUzK1IiT/ARwqgoN29hsen1i+Sf90ZVRWIYBpK2Mx8paJhRLzZ+Rvelii7LCrFAQmfzOtSpo7C49o4wPP84C3DASIY6dKRLcaeVhLLE0KEtl+Se77Hr8yBzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTJpGhdc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTJpGhdc"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7857947b179so47995185a.3
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707320777; x=1707925577; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjvS1rLrvCTwCNCkYWJ/iTBgIBhWSbezmpH6vKZEcvA=;
        b=TTJpGhdcTAlVheJNDCqsfhgCTw/GhZsAOeiuSFl495L0ZwUbkFAHc1bVn5TW2DxPnD
         DwIsAEEhjxkPziGseiMifqRwlubYHUOfJABCpwDWKucB4BpMWKgRwcRHqzdX+pxsdoCV
         nYZfpMh3fOwetAhW8NPUWnOvdwwgUC+5fF2BIBvp9EG9KYOtAQpRFUs/ogv6MU3a4SXL
         lhDvwaSSAGfrAZ7oFEyM20i5CCfKCwsf0NLUGQIDj8YhUQxIVAzgFGnOER1U503+0H11
         KPfMvBjZZmE/MOLHI6Cs9l9cMcu2G0fGfBoee3OUftVRbeGKffizt0DJ/Yr01vNfjJFM
         j2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320777; x=1707925577;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yjvS1rLrvCTwCNCkYWJ/iTBgIBhWSbezmpH6vKZEcvA=;
        b=jp0gpksg6WWJanl00NHT8mzGs9ST3bybYEwR03+ceof85Qfoe1u1tI7V4Z7kP6Wd7K
         G567/LB06K67U/FUVjNhvSBNl2t0uHDa0QIY+H0Ze2bKZ7qzlqCFN+5JAVtq0ZslL6Ru
         OJVEkXscaKwG+Y7IqYOpHjwRja9MdGseukT/gXfygTMHpCJpUMSYL1JkeSy0vj6f3fBG
         JQg5w4CAUdTxVYy/ERMwfxGsbxJ+gG0KsJO2nVFWzuz9uHq8GIrxagpMZvHFe8RSlebM
         +lsEW4L6xeRZ+romEw61EaasWBKJmLI4Q2c1S9MCV6BFN04e1dqqtOBH+HN9GhY5O8V5
         ElVw==
X-Gm-Message-State: AOJu0YzRVVnfRFMLJK+HX94T7wGSMYHG0BfFArO9pOwDpu44eOcHr8+x
	RdOJxYSoul+hOi6UW/Q6n1ALKCFxGwefEEKXY/BGyvhooePkktyz28djUFQ=
X-Google-Smtp-Source: AGHT+IGYuI2elXHVjXCJMzGQTYA5UJcxS+vzHBDsvVswrUWv7mauIMKnWWIZmJVz8935C2prnU839w==
X-Received: by 2002:a05:620a:c06:b0:785:40c4:dee6 with SMTP id l6-20020a05620a0c0600b0078540c4dee6mr5818904qki.46.1707320777470;
        Wed, 07 Feb 2024 07:46:17 -0800 (PST)
Received: from [127.0.0.1] ([74.249.5.99])
        by smtp.gmail.com with ESMTPSA id u25-20020ae9c019000000b0078366823711sm615734qkk.119.2024.02.07.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:46:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <836391d2a7f44fffaba4ddf664354ecb8eba66cf.1707314646.git.tanggeliang@kylinos.cn>
References:
 <836391d2a7f44fffaba4ddf664354ecb8eba66cf.1707314646.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <1b038cd8-7dc8-81a7-9593-91dd64b2e091@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 15:46:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5151649740619776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5151649740619776/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5834975782633472
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5834975782633472/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/420e302e8846


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
