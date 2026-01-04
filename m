Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1916DC28
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524246; cv=none; b=CmgwzTicyGceh/ROyzuczGkrS6NY2kRTJkwsdn73c2AFoAWDBLtcxIAxDuIp1OUghUpIGfaGZrp0jDr0Y/+mV+gBpX3fJ2CM5YZ8okVdA3nCZnpoCvghwWpxdarQbIHGblkytqC9VuUVw/kRA3aerRoQm2wDwC1gro5C7GgDPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524246; c=relaxed/simple;
	bh=+n+22xqNB/9I5Bd8Vpp/KN28ndxj0lugQf1pCqlS8vI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mwXarL34Te4lSCe89VOIGdh88aHRXx1YcG2wsiuAiBMAfdtnH4W4KWR6xGy5S7hZovgeSyhVYDbS1vMDgoeZUnmvh8oLmsu5gEFeVi8szHbI2p+jNVrJwJzCMfI96wszGuiQeWYbzZw4yJSXeE2MU/HhP9exC1hfK2hZkaWOYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnixBFg6; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnixBFg6"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c026e074373so12685151a12.1
        for <mptcp@lists.linux.dev>; Sun, 04 Jan 2026 02:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524245; x=1768129045; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmbGP/px0VLyApuXRLKcWTYveoI/N1toiBn6zcO0KxI=;
        b=fnixBFg60EDnHvAHqreesUsBBe6UQIlb9rU32zSAgy+sj5CNas0WVr8Xj9WvlfmNIi
         OXGLV3qrSkcjiEvl508jP+5I8x0lMsebt7HiWe6X4fMNB7cUokhbfCNItLga7/1JLInH
         94JTUjh9Y++36Am3Fhdf2XcHnRhbR+hdlLHwUlLFDA0X6NeJC/Z8l98VJuQUDKvIFZJS
         aBp4JYAZaD9Jkx2HpxERxnJ6L7jN0O7ghxu71UMrSD1aHg5h+2+ZwCsbeG9Zqv22P+OT
         SnNg58ZXOqLT+K9DEv0cQgx+sgDVWOoscLtUqLzjKFsiM34dvrohxdAYSCcyBdAma0M0
         0zXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524245; x=1768129045;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmbGP/px0VLyApuXRLKcWTYveoI/N1toiBn6zcO0KxI=;
        b=iqFAXTWE8QOOU9C5vxX1KoTIrhCVnL8o32my8UTf+J0ZIz5ifP82jaIxuRh5LLTnCm
         Cc+YWEVrBvTlQUHJU1gfS2CjXwiib6Y1UA/0f+nB8m/xUjQLncGAAk1sz4fBK7zDvp/h
         LxVB1xubKrTo7cyDKvxZAOV8j2WIqbQX0n7EnSIgvQ1o2sHweOzwCrJXym27GuGv8X8O
         Q7FEjJjQmMNYbUAg+qph1dHUR8q7msUjSovWabfz2Zo1VlT4vmCpd+5+t2vYj4a85sIY
         lYNAZsodAnP/jRuMl3MMlNvCa10ZnzlJTFKT/wQx6Fht7KqjJaHfpFZPznRvGmFE0iAZ
         1HnA==
X-Gm-Message-State: AOJu0Yz4ypSGCTd7CUXEosWyIFoWPdog6RH5zBxZ05/4FDsvi1ZT2/nt
	aTD/u3ugMxj/5hnT4uwcM1Mw6hCFm5u1m3wOxr90CPc+hFxIgIA3c3nyytu2m04=
X-Gm-Gg: AY/fxX7I66RU/oSOmTNJiePkPrpmkIveSAo/XP06fdozsUr8dEr4TdE7xcep5jX26uL
	z8Nd3ABArYTHZsbXDQpYexs6ow3I+msFMHf3qzhCj97zTsdS686QUGg+YAPv3sixHoHn+Py8+mg
	n0eeT43wu0+9hyP3xSqIAQ6H+0FG0EnSLKCIRFwrTCNMlIuJL8D+8CEgsJSVoF2k5KXkxx+IsP2
	3MXXChPR3QB+ZfXCCLCXBFf6srWYCUbnVOwxMdc7WdnwOK81K/YShV/EfC9mk1Eveo9ocmmcaPJ
	TpKVebst0ppcpgEaHHkQrwiReJGWJAZXWfAwr0WBmNLUuwPo8rvf8LKGY6hhR4ndWRkqdQvu7ks
	7XcnPk3b8ATWrX+UU013sMOmJgVFh12x3iZQT/FoZnDX++eI0E2TpG09H1sQT/a4AoNWHpuVp5r
	JXuMIbcJrBuqCPWzWUeHTsW0OU
X-Google-Smtp-Source: AGHT+IHW+4EjVh6FQ1iObiciXLqK6rms1nI3nnMeCJxnXKsDWFCghMLcEHO98BUp9NxzHP+DTzhtGA==
X-Received: by 2002:a05:7300:881a:b0:2ac:21bf:e937 with SMTP id 5a478bee46e88-2b05e9fff5cmr42946019eec.0.1767524244504;
        Sun, 04 Jan 2026 02:57:24 -0800 (PST)
Received: from [127.0.0.1] ([52.159.244.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e8bsm8106208eec.26.2026.01.04.02.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:57:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <867d350fcac80ce446ae2a756f1eec09d4cc54fc.1767522515.git.tanggeliang@kylinos.cn>
References:
 <867d350fcac80ce446ae2a756f1eec09d4cc54fc.1767522515.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22mptcp=3A_implement_tls=5Fmptcp=5Fops?= =?UTF-8?Q?=22?=
Message-ID: <be28f9f8-a6b4-daaa-9591-c16faa0dc44c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Jan 2026 10:57:23 +0000
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
net-next/actions/runs/20691737339

Status: failure
Initiator: Patchew =
Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/c1=
70b3ef73e0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1038182

Feel free to reply to this email if you cannot access =
logs, if you need
some support to fix the error, if this doesn't seem to be=
 caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
