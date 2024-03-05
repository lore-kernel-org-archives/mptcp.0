Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9389C4F1F8
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631115; cv=none; b=MHT24HWQL6RgeqN//ikrd9PBgKN1E6WjTOoJlT3SH0JmkSGgvD18pxUGXvo6jwhEREiAyAfZ+9MaQ8KUP++mlqbqfEHvVUdD6hIHqK4ybvhbKBkTuptZJvt6pi/glxjT8hcZYECRXogNumoE+N/eBvtqNMrGnkUsSmsUBA92krc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631115; c=relaxed/simple;
	bh=6liHx3iSjIuAy0m4AxQZLwdnsRBM3JlsMhcF7uO6r44=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K14jXoiRIWCDMNBCJg2ZAX3Lgg8I44lZgXVxu0KjXHbIN4UYC/+LjMo8hn0d5tpOCu5Ccv/4oFy3zHadLidnZviKchlqfGLgqcULv78uLKIaDbaldmVCa68CT3VLnb9ab3eKjIQTbhLp3ynnwifZg6kgq+5agEygkXvO623Lppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbh7a9iY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbh7a9iY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd1d9daf02so11143105ad.1
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 01:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709631114; x=1710235914; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sq2Et0F2Fxmsq3RyysMWTNbeAVpj8NPuTmGdd1P94oQ=;
        b=jbh7a9iY1x+3OmaEuEqWidMnSvRXKJFYsH4QOR4pmyWx3hUbe9jnd+cKHF83cZP7YD
         kwZI6u4O5pue4g31gUjEvSEp665lUCOj+NUGsMgldG5rYk5UTaJNI9yNuSTMAwp3l76G
         Pmzd8U/h+SwbbL//CT4PUu7yNieFTRhG+C+DioyzcQcKt9w0G5e2KrbRpVCcX1yfvV40
         09zr5S4j+4/pWoCdn1l0bts7CkufrD5h4qvkmUgfmyjf9SpsBQB2s8RUajbpQ3YobYMP
         n21CXn8ZDP96Jux/tZFEeckVGW/uqGlZ7bV/030GwWcJI7mZ2CpdFLhmS0+owhCPRAsi
         CNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709631114; x=1710235914;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sq2Et0F2Fxmsq3RyysMWTNbeAVpj8NPuTmGdd1P94oQ=;
        b=nBi36vzs6ILveP48CIiS6/3+6OvFuqPj9AcfrX4k9a9DWw6wIW7oRPNWqq1pKUTlPg
         FWEiNXOSi9fnGjBqIQcP75kjMGIvYZEBVTYngYHwefNrxop25PFv4ys88POciBux5Ib/
         5EDM8//fPIcWbFvKDqgqtsOMfWRaTCm0k8X7aDxZW6a0lmDZ1alQS57XxaXb74t02sQ6
         0RS6gOPO2zwOux4tCWp0X7Ck3voRp9peR6dp+md2gp0gEcZ5VC0jk1GPiy3cdo6gm/y5
         XHh1P2n9JIcKWaxPTA6cI4DCQ9OzhMBZM4c5rzBuBSVdIwED4U++jXhLNnDEEm02mwF0
         137w==
X-Gm-Message-State: AOJu0YxYC0ndUd9RNUXjN+bydQWarrD/huw4JED10FzyPum2rw+/H4Qw
	KbNMVNQ5lHaxEoXxf2RAAvZLRfJlHF6r2TFbN8dlfqKoG+8cZ006AQrxCUg=
X-Google-Smtp-Source: AGHT+IGf4Jy4Pvp/SFAMhN5HPdVuhEo60ElnWR7e1YOJw2d4Pi6S3694k0SErIu+t4HHlU1x0080hg==
X-Received: by 2002:a17:902:d4c1:b0:1d8:ab27:d76c with SMTP id o1-20020a170902d4c100b001d8ab27d76cmr1555286plg.51.1709631113841;
        Tue, 05 Mar 2024 01:31:53 -0800 (PST)
Received: from [127.0.0.1] ([52.157.14.94])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b001d91d515dffsm10017630plf.156.2024.03.05.01.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:31:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <93e203493c3ce7a0c7b4e17146baa37a9db2f568.1709626306.git.geliang@kernel.org>
References:
 <93e203493c3ce7a0c7b4e17146baa37a9db2f568.1709626306.git.geliang@kernel.org>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22bpf=3A_Add_bpf=5Fmptc?=
 =?UTF-8?Q?p=5Fsched=5Fkfunc=5Fset=22=3A_Tests_Resu?= =?UTF-8?Q?lts?=
Message-ID: <30ec97a7-fe9f-c349-64d9-a10ad346eab1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 09:31:52 +0000
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
com/task/6514107336097792
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6514107336097792/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/5290875752808448
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5290875752808448/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/29b98e5b5bd5


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
