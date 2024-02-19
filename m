Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047A1241EC
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334238; cv=none; b=G6SY60fTH5zAnacUgyJhodHJVo1/rv9Xu6Td4GpAGs7rJ9uLvyJxPOW5K/M6ifOPSE5wjZtLgaHNaMRsORdVRVqDr4HHrzzaieCv9b7yWxQGF23L2W01aVfqiouJ7hevEbJdT83jxLvS3l3JEX8s1ov9iArmgJefJrhbJEd0vuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334238; c=relaxed/simple;
	bh=HYos4mbusyQsSEXRtWFSL52EuLfGXZRLII6G0s6XsC8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qmPIg/GgJPl8MpORKIdZiIcyHm1kmlpx69HSI/Th8mD1bICyYTirwK2SEBs7VxOwE48uRaJmLoBFXEisJb8u8ajzTYS13Ow6GCfnC1qJ1vD4yuwTjPv7YZqVSwJRaGZ+JWD8yy1WTvuiG/ouvXJ0BdkBJlcq2pBlg2X6A4RcNOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE18rCCW; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE18rCCW"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7875adf71b1so90538385a.0
        for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 01:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708334236; x=1708939036; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIMdF1zjLN+Zsl2szU/nHED7npOFr3WmS8D+f0mI4bI=;
        b=IE18rCCW+RIn7TfqGqaU71iVAiy+YwYxR/gTvNDkzFlT2KZwK46McZouOWy3ZCUy3T
         v9iSfF7HLqvhwVzgQDkY4f5dWhZN3ImwXeJxfCekciLW7JoemCKJlkuNXEv5o+oX/T8I
         16mxhYYbIBfw6VB4ISCej91JrBVIWfxOdPF2B8LDxfycDqHM+9x9gbEGzGiY6+g03j0V
         ziD/ZhXFSGTUW6N0xPWEarG3MFgG8wMtng+y74dCb6Wd/T65RTdG9nWv9hLexinfPUYL
         OJoZMPu5MKd+siwiND+mRMYso/KDvPSUPApsxSSK66/zYmLjVk+ZR4Ej6iYk4v0Hwkye
         tvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334236; x=1708939036;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIMdF1zjLN+Zsl2szU/nHED7npOFr3WmS8D+f0mI4bI=;
        b=kF91jLCwrMNP0mS9Gz3xyVxqF6b78Fedpr1cW5li1Ge6XXGNVpoUwOo584c0nljofl
         2a1BGJ42r+sgUyd9UTFQ1DjluNcvaTgj7BTOxI/djKWe6IU5Ah7024qh8VtPfPAnSMHW
         WUCMlrkA0TgiwEBkBP/j+8WpGdEkZdFU5na8mpHNZnbMWZBZIwCfZBYooUbJ95Go9sT+
         E6BJKHKxxpn94RJ8FS3vZ0/ohYTHs7qsUkj8Ysnw9joxyIPB+4dsmcPwCVyPBntJ1TQH
         RsaoV4gEsiTbN30oVETu/jJY+8SOuVBLeSOrRNAuF3XMYix/pqBJ2Jjdak3WvKGdafeN
         DP/Q==
X-Gm-Message-State: AOJu0Yxma2mbOpVgf3zuEqN9lKJMFkKRNdQXEj7yK4bZaCvuOWv4f9U/
	GIKdRuLR8dGLUUT7HXH5db0tlLIFPdxaPqUEa0evI5wMivbudrSNFhC/JN0=
X-Google-Smtp-Source: AGHT+IG5eiNMTgF+i0rzFQQ1Fu6Q8cOcP7vxbz7BDvHvHJ7n/gadVslSIKUrdK9CtIzr8ALs7Te4+Q==
X-Received: by 2002:a05:620a:24c8:b0:787:2726:e92 with SMTP id m8-20020a05620a24c800b0078727260e92mr27147411qkn.23.1708334235742;
        Mon, 19 Feb 2024 01:17:15 -0800 (PST)
Received: from [127.0.0.1] ([20.81.159.70])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a0a4b00b0078717dd799bsm2255953qka.117.2024.02.19.01.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 01:17:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
References:
 <428122f8879686b24852d3e46850b9e3538afb99.1708330720.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_check_tools helper: Tests
 Results
Message-ID: <d0fb82ab-5cb3-d7a6-f0b8-65a72d406b05@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Feb 2024 09:17:14 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7956717856

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6d4dc0d44976


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
