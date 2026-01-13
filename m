Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E522C389E19
	for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298859; cv=none; b=pYbulzdq946l4MVtNDIzXY1Nr6PwVPUMEOonDESHT2h9xv8N1AkbrIg05picDlA3370FHhw8EQXERON9octWN5AZiBy9m410wv6eRxuhtx6zBD2sT19lKqaPBlx3mDeDDELp5eQy2rPGe4nJmAYkTyxGLRsYVY371AUDeSvBh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298859; c=relaxed/simple;
	bh=pHMd7qwJ7xwd/1CntOc8Naf2w5GbrqBAhZnAK4TjTgw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=flnjNO18JqxUamplU13h2xpPPSkoQzNZRtAYxWLl18SXXSKrNNWQb+5s9dDnahoHQ6IxHCKzvBMrLNDvFV1DicaOSSu6ehF7yJ3NwNfsO2XrObUPtte4PfGyFzgaQsYQJvud1dZ1/xHypvGDaD56S/smCrN5Ppg1ruAc05hjAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6nNIYyJ; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6nNIYyJ"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c24f867b75so755586985a.2
        for <mptcp@lists.linux.dev>; Tue, 13 Jan 2026 02:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768298857; x=1768903657; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/81AqrU1FoPYW4hMH1/GkfyGUTVfbXmfWY6nBynC4Y=;
        b=P6nNIYyJcIQ09VcqiU3MjqfGSwNqczpgE1MBL59ePf8HISmr3MwUYYEF+dxqt2IYA8
         oFw1tnNfP3Ph9tmhAetT2ICfSfQq2SSLQDFM4HhMbSAEiGRShIgh3G5gdegDtJxbC9Qj
         V7XAcAhVxuKz/PGnSm+cZR7ui2ssl9VwmxR9CfklhMH9R/JmycfOJ3925yB2YjjuisAY
         NWVPpN29TV3YmNXzrEsmWX/FK7BDD+L5ycbQgMFibCzYsQVPRqYrMNw9CovLS7XATTrL
         LzQyNivZ7cAweHgAwY9b9TpChDHlp6e/qpItmcmHb0z46aGAPA3LujTJUJvMnnM8xYil
         ekdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768298857; x=1768903657;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/81AqrU1FoPYW4hMH1/GkfyGUTVfbXmfWY6nBynC4Y=;
        b=KNT6yhkVO5KeGM5hXw7aHTk0+uFPIgPpHYFdx8uMJ842jg1NcoRCPT4sQtzc5QGbt+
         FMAg7hWklLadCwBFh70gPRm1YyhC835hUbo62LeDqonYJroKIzAgnhIh2uub/+8FZDbj
         8qyzENHRDQJNp5mlkndPxAV+XRRiDkPaWWA2UZ+PsT7EkVWcOXoDMbB5469D4GUxaHr5
         veVV+K4zdeGTy1LzyNH77z6vKiDk0O2/MWURFIJY0kZ/3dQL0b7YxEhCgDRXoqfq0+Hj
         9AV2az+WC8av+imPghhUan6PwQ65hhSAULUh1o8g+hCuhngaaR7v57Jphz2L4Ye5uwJ+
         tYNA==
X-Gm-Message-State: AOJu0YzzW6orZtx13v8GgEFfIAMMwdQdHQgDiZsAKhuQpUvVJ2UNJBek
	Woks7ZhV4KgxtjlwDkkq5y2Xfgh4eSqxiKGy+ITA5MGcjqGAgkQzIrsWxSTR2gg=
X-Gm-Gg: AY/fxX4JPAlQ3WM0rwESD6mCiB8KTcWaJZBxIhcyJYStE8kXcuXUCB9URQaGKxwC5QF
	oNhTmOZFzGqCG62j7L/ENXbvb6AQQ9sI74eKI2lwWPBCuL7YB1itF4FIAKALba8lV5gy3QOF5/1
	xggJmeEMWGs1MfuuFEIOuhMKsSJf6DbR0RV9OlJ6zSSKr/FE5GctckZiUeDPGJ5U3lGmtcF4mgz
	rrt9Z01kX/y4o2DY+cVmCSQVbe83zzoMl0s7f1yxm+IpqRUHUeJg3USQrwpiVdodCUKIqTw3x8i
	NsvvMa5am4VDFMUGhdi9o3IefpwJobemFL7WSnDyM9q/1D532fwcEcqM31QlIiyCUPY+unvt6Zn
	U55dHJX8sEBfKTGJASvaUJXZz7NZm90oMsRKMQ2hQm42Oa8gaIgstizXMQpghmO2sJ10uWXGokB
	1LIB0d9klgEM1dZPZOIegeeA==
X-Google-Smtp-Source: AGHT+IF7frVunsVd45Vlic9Jo47Hw5XtbQMrQsVqTCn5Uy9aH4IO6IbK/+6IJoggo11lUzIyrJPWzw==
X-Received: by 2002:a05:620a:708a:b0:8b2:e827:14bc with SMTP id af79cd13be357-8c3893ea256mr2886695485a.56.1768298856747;
        Tue, 13 Jan 2026 02:07:36 -0800 (PST)
Received: from [127.0.0.1] ([9.234.151.80])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b8b40sm1695676385a.14.2026.01.13.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:07:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <24196096819a0557b38926fd53ef1b9121465b11.1768291283.git.tanggeliang@kylinos.cn>
References:
 <24196096819a0557b38926fd53ef1b9121465b11.1768291283.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_mptcp-next_v2=5D_Squash_to_?=
 =?UTF-8?Q?=22tls=3A_add_ops_in_tls=5Fcontext=22?=
Message-ID: <42aa9bdb-e066-20d5-aace-d9db5812b5cb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 10:07:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_add_addr selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_add_addr selftest_diag =F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =F0=9F=94=B4
- KVM Validation: btf-normal =
(only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/20949913521

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/761f4fddebf4
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1041619


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
