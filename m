Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C89814AA0
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 03:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696945; cv=none; b=Dw517NajGa7J/utkMsLbg0lrawFIodyqS+Y/P61R5nDsi3jDV7XcLa8xUUE/MFNLea2EqHUC8RurkWZx556tweLdvP33ucEFHZ/cHrwbxV8ZbUcgNzNkPMVgyxE2nAFPPRpc8XV/0MwG2T6lkhCyFM6yBCphshpsfDC45iKYIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696945; c=relaxed/simple;
	bh=XUygXPQv/AJpOi+oYlcRPZyZ6dRw9bnmD/fRELrwSgE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SHgDu2zOhz+M+C111nHjYayTUOzwmgGefQLdPpCLTakyakgMEVx6BDMP2B7jmGVFMpwLRerUTHdWLbIqRrqh+js3+mPS77gv5UUbpu6C1+qjnQqejGOCSm7WaG1T0VDg8IMvLcxRx18yPK9NnRuJUkZTUBWvVP0IUBobyEVXhWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbsZ9WPI; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbsZ9WPI"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c872002187so27726439f.2
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696943; x=1710301743; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkpdF3cLDsX0wJaTmehAxUSXVngET9ff3NpFitO6Y7w=;
        b=GbsZ9WPIohxilnvR7alamaYtbUlP8g9QGyCIdloVtXhKY/2SRSYGTrQFdtWh+Zr2UO
         f7LpeDxFzL+LxIGUsPHfLeP4H7tNJmNo13nk1FPB1zeXZnjE6Zx0LG2lqcCSzA7BxiJo
         nqrZAuvv96yD+4O0FeDQQqkpcZRKlOfnY6hqkUjAH6C9eIoHuVC0fI7CPrF243KIVVNZ
         LN1lh0JGGRGqqHWxigHu866tc5Q9eWA13HPL7gyLc70Mx44Mh+Kn8fICZC8bnF5fwzxj
         YcF4EhzZllBuQWeqOjf7NY01W5mh3mqzeqS06fe1zuiY1g9OZGcsNJiAQ49AyVXCGrcK
         lj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696943; x=1710301743;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkpdF3cLDsX0wJaTmehAxUSXVngET9ff3NpFitO6Y7w=;
        b=ALtv3HZSjiVc2frlOmh6trc3Z9M5xxsUpb7Rxkvynfm8kuxGjsHMwEIRUD7sd0evod
         wxnlYyTFKtOQCEvcEbHO09dwRgbCR3ZeZ/beq/pNS1vON7u6FzM/9/QbjyJ/AH9tSyfG
         8SRhe/83jfnAjg6Kkd9S9Fk+kLBbC6AdZ2O7Gj3rXo5Bd4PbJK7Z6tPGxqQ8Wt4TuLyw
         ZqbfmpYk3bGkYHLsH32tFTAG6cN8FUiPHdaszOgimXvvg/gxMKdpaMPWs/xtLQVC2/0x
         +Twe7aFluS8R9ghEHXO1yOaapdJ+X1SQLYyYM61rq59rNEsh2bh+lUt5qdYR8PVYNcJO
         NF0Q==
X-Gm-Message-State: AOJu0YwgVOqh4BnC4KL/OtYy4PEZSM3wTK3s9afMskg5alod8xNbYFMB
	n2Q0GfC/LP6dlG96cbxvUt0GA4BK7UWky5eQYABdf/JY6XKYQ/S9dY7Bvbc=
X-Google-Smtp-Source: AGHT+IEjWbKn9puKNHTzmG6OPG4vmdjd5GvHE6/0UbHGrLV7hKb8La6j5L8zivshsVQtTRd7JAiLOQ==
X-Received: by 2002:a92:cda2:0:b0:365:1035:83ab with SMTP id g2-20020a92cda2000000b00365103583abmr17279666ild.32.1709696943561;
        Tue, 05 Mar 2024 19:49:03 -0800 (PST)
Received: from [127.0.0.1] ([138.91.70.190])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b005bd980cca56sm9866837pgh.29.2024.03.05.19.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 19:49:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
References:
 <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
Subject: Re: mptcp: react scheduler when subflow events pop up: Tests
 Results
Message-ID: <b98d5624-110b-2d6f-9684-88f348cef60a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 Mar 2024 03:49:02 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/8166369924

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/218fdba4f2b5


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
