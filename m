Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3410A3E
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 03:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732161312; cv=none; b=rQ1ce/k6e96cleLiCEHatuPmnCCNTMXFwlF6JI53M3xiZVSEP+mk9okL5Wd8NtQOO3nG8g/FehnIDXtI8cReshJVbDWNHUoREaie6eOjuluahwYQUbQSBrrhJOBbJmYaEWolHtE73QLW/SE/X//neT9/pVG4zzNdQu7lq4qTMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732161312; c=relaxed/simple;
	bh=KxotQa8K7ZBQtOInRg9MiG2uFs+eHkZncZCFF+LeRZo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=SjsXtSJE1ehaZAm3WBVYaOZuxX2EJsZT6jJYScx6LWUESrwtKTDzMG7JjeJSxlACUlCFdfm+T9goMnVCLU4+DMRqU6TF64ZohBmCVZADxXAFnai3B1aVMPB7jMsQrydx42V6+4rO9930SID4o7e3eb2pw1tgG0bBYoyBE0w8QLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lf+Al4Kr; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lf+Al4Kr"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d43e034ef9so4385616d6.2
        for <mptcp@lists.linux.dev>; Wed, 20 Nov 2024 19:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732161309; x=1732766109; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu9oVUgMEzArsKg1gG9EAuYtH/+U1JsPpgdCJllJiXo=;
        b=lf+Al4KraZRBfjk3BSQPm+qsMoxt2zyIX/GK+PP98aYZ4cxygzErfJCNQ3CJbN7AGi
         kfgmZDpoykaeE5W+oGEloOwEbpFstiIml0PEuT4bv9/6I4O/LUjDzY3WOKQ56Q9v5gM2
         8dH5FJ2ku+TSpbftFfgmvAzmJVEoyhnvvzMUX64l3u3AJW+paaCrfp+VmlO5bRuMief7
         KmS6SjqxzdgALXJHCW1mZbFDKERRz3PAW9bqhNRIoobWXhju+VqCCD74pJsw/6MPU9ke
         QQU1M2ndjwLc0fURsU7zPv4LkdQMvJUYl582BGMnDdH6Gx2zsWQSFSx2QrAjlHDDCLxl
         xG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732161309; x=1732766109;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zu9oVUgMEzArsKg1gG9EAuYtH/+U1JsPpgdCJllJiXo=;
        b=UYTGIuyvNTNx7cElYkhsHhruBqHmmI3YVkoGlDxpq/3XBhQhMB+gLWKTfSZ0h5wL9h
         rbcj+hUmpnJ4vqg6y8GwTc7t77nMd+XilJmI0MkbFXJ1mO041RLAC4praKQfILZ5PWp+
         YHHeMGx3Tj8uxnYs0n6Pj6ivdhQnEp1zLua5+ySLgTsBWxhuBia+hroZ3TiMtzm2kkIf
         9tSHVvdJndUqjf15KDjU3SkTGuyt6gTclrecwGY6oxHU5hL5kSBsGI2KajrPVkjaQ4AZ
         R+yFW96rLbXvQfnKAE776pHaWyeQCSmkltHCpMWHn4NZnZ4bJBJhbrVflEJqdTvpW70V
         o0iQ==
X-Gm-Message-State: AOJu0YyEp17Mw5gl1SEwc93sNFbfPhdeeXIMFpYm6OJDWbjpGO3D+mZI
	/8nVzu5iJTdE8r2TJcPbmPh2j2eu1vaCumrrlCrfokhzOvrebP64ZVkP
X-Google-Smtp-Source: AGHT+IFCLn3DbjhsPmhiXG8xHhVIrz9XEz99jWxNDaNGOz3hFkckXDjo3SFT3SrrkmJeK36fZe5B5A==
X-Received: by 2002:ad4:5f4c:0:b0:6d4:1a42:8f03 with SMTP id 6a1803df08f44-6d4376d18d7mr89562886d6.0.1732161309601;
        Wed, 20 Nov 2024 19:55:09 -0800 (PST)
Received: from [127.0.0.1] ([172.183.74.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380d7f4asm18076756d6.41.2024.11.20.19.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 19:55:08 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/8] split get_subflow interface into two
Message-ID: <e69a65b6-a012-0ba6-5f58-032a7e8994ab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Nov 2024 03:55:08 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

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
uns/11945771301

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/86555cf65164
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D911397


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
