Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF581CB53A
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725299294; cv=none; b=Jkme8YhVgosul06M/RXtOE1zQcenCuP7YpP4HIxtwdKBUmrvRh1CMqt0fv+XFuAeNsGUmKy9vFa+eK73fvZ6mlGAH7NshgsQOiRdfeERNWmcc6OnWET98dbeN7+sWxEZXCZpkQA89kNP6UAD2N8ameNuINXvRA0m1096Q8ORW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725299294; c=relaxed/simple;
	bh=tLLFVhABh9NDEuxNy4bvbrmvh11TC791ho1TFJTq+Aw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=R3m86SazC5j0KEZJ3ENtLS7R3a8RdDvHQY6Foy4fZjLC9NSB4DTEMwJ0QGyKeqlM7JyGcYCJVzOLz4K4OomP+x7mPMwrToxPRjIpcMT+vW1c/LeBatuz3t5KAvFwPXbSva10113BaZoQCDcBxIlbEoZuZ3ArFx1KijH22aHSWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSlnzyuV; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSlnzyuV"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a9782651bdso21843285a.1
        for <mptcp@lists.linux.dev>; Mon, 02 Sep 2024 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725299291; x=1725904091; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeeg1SMysLxmqxQrHzhPeYUEkk7O5/U5560qnBteJus=;
        b=BSlnzyuVaFznYTzk7bEocTSj+WH0XPuIagZvm8YOBceab9f3FhfkMFzy7HFGU6zMQV
         ZPgKxXLFKPEBd+atB4bSjcEUGtsKLEkCryj2SULr+Xq1n3YA8sSTEV2DWtI/hD66nhAv
         rGh/B9wlJGHV9cQouJF3mINuqv77Utybcjgy4/EJUmQakWNw4INL4bg/rNBtLgvfs75f
         JNH7eDPzEMGQ3t0v0qm3eve08oaUXn/M4uki/C1qGYUds0viH75z2lmB/1cVj5FzwglY
         OtMPx62YMoeZwHA59nkktYoWrCHKlQer5i3uQI73uRFvN3aIC7qZL5H/gP4sMQLE9yNU
         pGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725299291; x=1725904091;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yeeg1SMysLxmqxQrHzhPeYUEkk7O5/U5560qnBteJus=;
        b=OnR0YMVlnztL+4ZLL0ozUuI3B2n9wANtNsfLoVwH4MAxQJXS/3UsnfH8MhHftiW+Hu
         s9Z7+y4Y2zq+eGHV18qlJJyGpsb/4mTWM1aDN6CS5DdijeTlycDcqFyocFDGKSBTXXF7
         qa8t2gAz6m/0LcgL9JFAK4qIcwkLQ3chJJqND29cP4OEpNZ7SJfRdMIqaaUtrNBruoTd
         2EdscT5gXB6Xezn34Dp2NsKZaxVak5xQ/O+xD6/7IbSwNCZeku1CqIB/9qWtZ2iqt+O3
         pxeWMyPnCf9k+G87CagI1obobDIPhHOukgnUdvqjc8quzEJUDvcWqJAPwYPj1RJeGb/O
         e2FQ==
X-Gm-Message-State: AOJu0YyEum68ObxI7tVBrBIr2NG1VeWql3OUqDfIIW93P8sqeeomCKOw
	faTaBv2WoOzbPuVROop3x6ruo9Tuub9FWt68PU0T0kkoAM6LmXMFVgu8
X-Google-Smtp-Source: AGHT+IFJZUA66zqUUiBZg2ozU/t6Cl0aYcQ1r5S+HkxyhCU0UKUU/hp3Nd7FNJ7ySDdDYylbmvP2ZA==
X-Received: by 2002:a05:620a:2408:b0:7a8:2e6:6a0c with SMTP id af79cd13be357-7a811f0af9fmr1902005585a.14.1725299291501;
        Mon, 02 Sep 2024 10:48:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.14.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806aa8e53sm439774085a.0.2024.09.02.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:48:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1724899785.git.tanggeliang@kylinos.cn>
References: <cover.1724899785.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v5_0/3=5D_fixe?=
 =?UTF-8?Q?s_for_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <81e34547-f542-cba1-73bd-8ebd3d94970b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Sep 2024 17:48:09 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10670887546

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6898e3d0eaaf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D884526


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
