Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F87011723
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801907; cv=none; b=RpxyCn+2wwzFuuAM9XibPUG8dXWeMsp4AeEhi7upzLTB5XfWSqWPh+Wpdaza/26RT806SVxeOVc5c40l6ILw744vG6GsVr+b99Z4pGiXUoYqGRB91oUWa7mMiJJQM/zvz9K/KlMo6/B8lU240Eyrjsq4Nyw1WWAAkSmKbYTnBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801907; c=relaxed/simple;
	bh=+/eJYSYpBJNE0gybLSdYheaxJvzGTxEfnvF9VmjA+Qc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=nMn6IRSaU7hPHHLHceEIklyn5a1oGIte17WXljsUTgKemLyzFbITrapTxSLv444Y6Y2P8/ESVbOmBPCRY352t3ccVKSSUTbnJ7vHLv2FC1KSilZUrfJXZfACkeRpM3eNMCNS4cAUkCsChsaGSYd4+TUsFSZ3w+WZLVNGFv8rqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVZOQBpk; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVZOQBpk"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-785d954b236so63230185a.0
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 21:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707801905; x=1708406705; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz42BNUBA32PEyTOB/PFuCDit3n8BThKHKIXBk2cN5k=;
        b=bVZOQBpk4QKvz8bkfRPIn2lZHPn/l0yKu8LAt1FJUAnTyOU9uqnIfYEIeWkJ2jO0hq
         ZpaZvmB4Tpu2jwWDUUFDHeMx5pgy4BYEDoUc7+7j2OAgsdeYakHrhLKW7PDNMcLfnM0L
         MSwRqv9A5SjMzK0TBsOxm6rS02cphPCh3bnTc1tpgiXsVcW1/WonIZf7RWk+j6f0DiHe
         vkAcAkCnBd7C8h/m0XqGpQSi2P8yuWvGkOPI6zQH5dp/thyRGtqNDbET6qB/O8v4AiqL
         krRhnC1W/COqoZaQDCiZMKWVMo/N0w0SVGgc1bilayQ006n/AiSbC+eXaxMnPrzTaNXe
         dgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707801905; x=1708406705;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pz42BNUBA32PEyTOB/PFuCDit3n8BThKHKIXBk2cN5k=;
        b=eqwkK7fovbsF76feCEAmQ0cL32W1TDZczoteZLDQrMN5O9AuetRHMOx2kUGzyglR1w
         lkZJbJvLPejbAzmMQSOemo9BV7DEc7X3CWk5Y69AaSafq83tWmzDmuc5l69ywtdxElGy
         QTYvcQpUdN81cHgr4mB70xiFBbaPKjuiWNiIxksbZDZzDW51ZNVTcaODgRs8hvPmdncV
         HxD/GsMlehHB1JLgngIUP+jayuutqt9GTBhdtAZIc1lR/pYPKd6bbhNQD8YcAWIpJ0gT
         JQPcdikzzVHseubGDWYlW1sJW7x2ctJaNsMvVsOb3vbkpIXTnt+LvRsQiGreC6I4DDBi
         LLIw==
X-Gm-Message-State: AOJu0Yy7UvcuOWJrlPZGCQ8PTIDn5uYSh3fVl/sQiNWkQcfsHq7yzYqD
	QXKyNMHmHFgMEaD0zcFTb7Yza5YCJ20L2fJpwxKrYE2zza9b13gK8Kno/1s=
X-Google-Smtp-Source: AGHT+IEJ6o4Pqe/upj6Kb83Vtam1Ud1gJ7vHM1JzXL15WLVncd6AVBbKzqgFFU+193F3VVNfNesCZQ==
X-Received: by 2002:a05:620a:3881:b0:787:1952:2760 with SMTP id qp1-20020a05620a388100b0078719522760mr1154304qkn.18.1707801905037;
        Mon, 12 Feb 2024 21:25:05 -0800 (PST)
Received: from [127.0.0.1] ([172.183.154.176])
        by smtp.gmail.com with ESMTPSA id g11-20020a05620a278b00b00787218d6a97sm25200qkp.60.2024.02.12.21.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 21:25:04 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <874a6cca73e30babfaa5f6036a929314bf1a689c.1707797566.git.tanggeliang@kylinos.cn>
References:
 <874a6cca73e30babfaa5f6036a929314bf1a689c.1707797566.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: diag: change timeout_poll to 30: Tests
 Results
Message-ID: <bf6f3a26-2151-a604-99a3-f530fc3b9e30@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Feb 2024 05:25:04 +0000
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
com/task/6220816166158336
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6220816166158336/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4813441282605056
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4813441282605056/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c502a99a8f4a


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
