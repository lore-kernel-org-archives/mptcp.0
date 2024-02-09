Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36DC4A29
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707441354; cv=none; b=mq5VzZceXpRK1f92HwrmcGDuLvmp9yFZF3sPAfcx1IsEkdVLoIuas0pmBgfG0cV1gnTaF2WeY/bVF7F/uW6nteKspYJQdt6BLW+yhQQ3no0NurEVwCw6vfFPDv4fXaHZV1WFEMjU3+XTcp2To4Kaa/0zGRkB89szxNCNjaMhPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707441354; c=relaxed/simple;
	bh=yEAL3wrUEyQUiXmQb9TywbLExTQdlre+zRanmoUmhns=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Uyia/yUphA9C8ZcpF0cUpIIC4pYPVTv5MfvF8zDFSVYDFugx5NHTszDXbZrYzScIoqjSUhi+vsL5rN6NiZYtfkhivwtLTFCIqLKvpQ2bqSr9N0mY9Np2v2/OvJEy9pIgyi8FM3tCb4bBHhzbA5rIo/QeEy8lVj5iFkqJPGTZH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ1Opa7E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ1Opa7E"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0311797c5so313329b3a.2
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707441352; x=1708046152; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aWaK8Tt2ArEgKWsJh19skvsV1LxesWLYdaTBN6/U+4=;
        b=EQ1Opa7ER2irlNl1aoBb0Q87f+ICxgLHF9EyvwWUfQB4Y3rHH/KzUFpENGODFW8hco
         E1ocTe1LoAfRqRy2NJ9uxGk+wSzrsr8hEkbKs7uBYPhfgETNHvAWQ1TNBZY6mcKJ0geH
         TUwUyZEah/8K9fIhC+mzwAc7X4LmNdH8+0y8MCxe+UNYKHplU7BlvSVsyYRb/YKDMiko
         3Y4XFyeqM075DEt+GSkysve48RocWsM0Sl23tZ7FZUshGBAXOgyQkcxnGzrzdeDXvfaD
         l0n281Y9GCXKSfHEp2gLvai5MEclAdlGm3sIrDRvmun1mXpupWNEFz0TtrX4ndGBAlxf
         KqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707441352; x=1708046152;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0aWaK8Tt2ArEgKWsJh19skvsV1LxesWLYdaTBN6/U+4=;
        b=YP4lj+8+aLuDEsJpXatDc3MH8QrjplcgiYAoD673H75nEcb6/sPxj2n5bG/RGJ6Zzh
         4zWbWF/0pieQExtjwwf+dSiYWPUgmJHq5uQi0v0GYnK49+DW5PiaiM0D7WLK+OuRaoFw
         3g0obJvKpUeZDsEAT9G1KPx5TpbOeUffNZiQvj5WfU6ZfrLM5suDm9pjTH/bhWVqwpCg
         pI6qwh9fjPzEfloKxAv0A4EFPMuce+93gqHnTmkYEL9he7KoP7Tgzyy8vwRxGfH2XrJT
         6VdXpwg1dMOcOoF5BzNgmt6AWr0/FCPgeGR/ilWfH76yrpVEcpWbRESxQYQlXuL75w1Q
         1G6Q==
X-Gm-Message-State: AOJu0Ywcx1CnQXjeKm6mVIwdm3MHz679OQvnlJRHkFbMbBteSxHq5lkD
	gaxXAEu42D3qAbDUvEE0UCQp92XFCcsAuiDRjSUl8rCfGY5oYtA=
X-Google-Smtp-Source: AGHT+IEh0mEPiHl76SCehEuGxiuIIN7UfsywxBx4Qpfjgs4whhRd503gWORHjLaGLdu6bO40bCSj9A==
X-Received: by 2002:a05:6a20:bf19:b0:19c:a2ef:c45e with SMTP id gc25-20020a056a20bf1900b0019ca2efc45emr270123pzb.37.1707441352014;
        Thu, 08 Feb 2024 17:15:52 -0800 (PST)
Received: from [127.0.0.1] ([13.87.243.38])
        by smtp.gmail.com with ESMTPSA id c9-20020a6566c9000000b005d748902a01sm424350pgw.43.2024.02.08.17.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 17:15:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
References:
 <20240208-selftests-mptcp-simult_flows_faster-v1-1-2859ca46e582@kernel.org>
Subject: Re: selftests: mptcp: simult flows: re-adapt BW: Tests Results
Message-ID: <90dbdeeb-8af5-45b2-2cba-7d9449decab0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2024 01:15:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7837948894

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/cf099624ce51


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
