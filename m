Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF032066FD
	for <mptcp@lists.linux.dev>; Fri,  6 Dec 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491026; cv=none; b=hSfhNqI1qSY2waHdaNZrNCOpMRTrJHsfgbX1T5QiMe2TULUUYzOfWxLA3ybhdDQ+lt2xFX6iM/3YQs1sfr25ZAYMbLtqPzUT3CNBtuFHyt4pYx2CpdASfs6HUxSN7wyBDYlP8SZlKJNPdiNjpYLO1JNMTPcX1FYRDnNjr77SbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491026; c=relaxed/simple;
	bh=cQQ0Gt+ZsUdUhvEBqD22gvtIdORI4IMMi7D2ql/Of00=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=aNmQuV+nsd+3W/6aiPkbS8MyTS//fzrnIzWsfv/h5vnhx6xCC2YXS/jwB7HxQWSsg3FElQvtcQtotdgNqIgP8mCqALD+08DfsS0GoO65J1s3rHAUeFer23zsWlloUnH5aPqrcLN4jD8bLp9XJ/mgs/Dses2cu2sCI9fN6/xb0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyqQrSYq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyqQrSYq"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b673aacf13so236110285a.0
        for <mptcp@lists.linux.dev>; Fri, 06 Dec 2024 05:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733491024; x=1734095824; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKb8dQmck5gwN+kSimnuSX2HV6t1FdGc8b6+NFBFcnc=;
        b=dyqQrSYqAOUifxbGEMFue7f+zknfM31n5GO2Rrpu4pd96r0l/aye+OE+HIBswbMJ+N
         BasQWoHUtfkphyyD9pBBWGmcPyFUjKt99DjsZizI3IdvM/IPH1TJkchmAOSUFd270rnI
         eksGn9p54hm0t6ItTHwZ8acYlPR47AvEt0gudJHCkocB2ccZKuzKrFgmpVPWsu7uzdPq
         PgQKDBH8pi/jJGG4wa4vvCRiojtfkxfuakGBXx9apcnQY4b+7Jzj94Dg7i0BB4URq7ei
         Mpgjquu0vbomDn93m1x8sTtmFYVOmiP+P4wvvV2kV7v4FJOeESR8JanTbdXNZiu1Wr+1
         mp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733491024; x=1734095824;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XKb8dQmck5gwN+kSimnuSX2HV6t1FdGc8b6+NFBFcnc=;
        b=oWxsvn3q3zCsCVJY7SZBFSXfnLLop9dALoO2HNkv12UuJ5l/qOzfxii1jqst+JiGEH
         hVq6Vb5QbaBzdEWHCJYhO57WjPXJ4CPFzZxWso0bZFjtzU8P8C3Jtel7ZExwiGbsW7SL
         yAemsT438VDmOdLDQ4CvLOtClWU52LUX1gWURcwtDrWHgB77/92px6FWJt3wIWdEPCBa
         Vx5wlvmD66JImqUILUY7NhZwK7VXHKhRQFDtBuYY+o5woIxpo9+Ty0Etlqz9N1J+v5u4
         NyvDPg2+bNcT3PFMVXOf0n3bsddeD53/UfL+LBPbkz4B4aEVjrKhVNNJvXwMtdcy0jkn
         b0HA==
X-Gm-Message-State: AOJu0YzxLqeGaE9Vkh1U/sWSnH96lru6pQANE6YhJFohDxmlfy7/ZbH4
	1QQUdUdtr0FMG+JizVrJJ7IDDVxsVoHWvgsWaPQtGMYpgDfd6m3FqPEU
X-Gm-Gg: ASbGncvyUtyaGP/SXGmBScf38berIRhV224dd2dbxiUcdYjve5NBPZfl0GiFwLGdc0J
	LI4msziS+MKbz4DhNKPkUC9DzKhfPmJiyTFoI2FHnWRShWS1Wrw/TxbwepjgW587dUCJMRwymvZ
	eSEjrhKW5ZtUAYoG8uTcxjwcSzd0wVtSgn7RlYkJNu6/AM2EXh9rldJM6+k5/9iHjF6XdgYyBgv
	AOUxqgfxkr0iSP4Sqxm3ll09XozPnz6O2GFj4ydDO5sQAbhs9DFbDNiqnn1cA==
X-Google-Smtp-Source: AGHT+IFcB+fJGDzsPXGBhAmmZBMAXqZ6qo82ksDpVx1xybMb0Yw/pTpktfElku5iOk2JtzzE05LKYg==
X-Received: by 2002:a05:620a:1a1d:b0:7a9:aaef:305e with SMTP id af79cd13be357-7b6bc911f13mr532273285a.12.1733491023563;
        Fri, 06 Dec 2024 05:17:03 -0800 (PST)
Received: from [127.0.0.1] ([20.109.39.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a5b38asm171487285a.27.2024.12.06.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 05:17:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1733486870.git.pabeni@redhat.com>
References: <cover.1733486870.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v2 0/7] mptcp: rx path refactor
Message-ID: <1426606e-e8c1-ac77-2a55-e0bc431ef375@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Dec 2024 13:17:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/12198751082

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1c3b9857b5b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D915337


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
