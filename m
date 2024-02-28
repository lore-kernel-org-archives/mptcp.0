Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396331419B1
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117566; cv=none; b=QK3yEhBdPL5Ke2SV0AXKFZTaw/U8jTr0nIBJ0Lgi7sAOlZswzWEwX1FremK3FykaF9kDGpP2o+1fAe08WJ1bbwC/aKjPWawvHoI8FhoQoVDI3/hUCniDSH4XtuH+70zN5RKDiXy3cSO1EBSjbWnp6KwFdrld73LjNJ4QXwTv+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117566; c=relaxed/simple;
	bh=ogG+YtCz/T0aotem16brkhNqBvessF/NX50O9YiIWSI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=LS/MB5ztYq+wUuPLPLr3oOkhgrDpexTdHfHGb5irZet94pk50KtxS/Lp+HeFPqqZUK6173S8S2Mhr0AvGgyLWpVgLwnLx45ssRK73ScN/CiKk2atGiVjETEUChTduZtu7ADOHSeEeaDCmJJP/7BUA3PMJb0BEaq9xFM5c3ZwLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUICN916; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUICN916"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787b0b1deeaso316050985a.3
        for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709117564; x=1709722364; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaSfdlSjBf4ZLls9FDW3/dYjp5O666mb5BVL/9pV5SQ=;
        b=TUICN916sjrQmazvyZjOQ2sgPNTydwTcBxB+ziSj5vQ7lUU5B25ESal5PI7SeG9mjw
         36xy+g1S9HGdUT8WJ7BEG89PfWlnYKIcm5PBe247Hv5ek3YjAV/mgMGsVbiMEBmA1arO
         ZIJ5aXIx1bYKIPSIRGpLj4RfwgyBMxxoZUhCat+9061Gwxe8xNdL1ximk+tngHU3xzjv
         GjaO7MtHOFQQWNjs8d0k7N3kPIiomqRPB347boRH8pyDUB1sYWZUb8iILpp5Zxpwrie7
         po7QVRdnQcEpto7o6R5uMOx/S/DZ3mm19mg//lsawXGaIN5pRiJzlUkYZogQfqMy5Yho
         q18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709117564; x=1709722364;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qaSfdlSjBf4ZLls9FDW3/dYjp5O666mb5BVL/9pV5SQ=;
        b=f3fNKP6ENF2BWQOyCZSBr5gp2N/f2j0/pdCyVE6KAlsjvmjHUDluOXxqTvMJlxCeYA
         PBfKZ19wxsZdmA7NUHQ9IC05qvRsBohnvLD3KeJN8f7g71UTecZtz/aXxL6/7wBclEMM
         qb4nz49Ugi5KD2pm2FdgWCCbvWUZI85fs/oUhbXcMtIrVFdRlmPjO2Nzmabi/sHx6SZ6
         Gwcqt7ZxdY7xf0nHGuEFpAhmm89sLdM0HNCbdsnHex8u/3tbHtttZq1ykAAVDMuCIpGC
         VYPxvx/pqm4HT6sZiG8N2ztAPvY7pxUPV1Gu1mT4eCX6hML9rBD72Ux6HSwY0pabx4xh
         3OXw==
X-Gm-Message-State: AOJu0YwMvqR29MFoLeSxPAQ3L2S0TVzsK/QUmFBXASTMy2xkUo/8L8AK
	lrKFWwwYEY7nrFPdFGQh+oZYhYQEr2XYndaHJvyDRLq42k9aJY9UoQ/eckc=
X-Google-Smtp-Source: AGHT+IG+7OJ6KAJkxf0hLjuGNkH2FxcQsx+M9IR47MQSYGbGXDKeaQo5Vwq/7K36TnO2hT8nzj5ZCQ==
X-Received: by 2002:a05:620a:1213:b0:787:a853:607e with SMTP id u19-20020a05620a121300b00787a853607emr4936151qkj.58.1709117563858;
        Wed, 28 Feb 2024 02:52:43 -0800 (PST)
Received: from [127.0.0.1] ([172.183.53.135])
        by smtp.gmail.com with ESMTPSA id wg8-20020a05620a568800b00787c6ed9a68sm4098136qkn.91.2024.02.28.02.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:52:43 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240228095858.4117568-2-matttbe@kernel.org>
References: <20240228095858.4117568-2-matttbe@kernel.org>
Subject: Re: mptcp: continue marking the first subflow as UNCONNECTED:
 Tests Results
Message-ID: <f3d87960-9486-e4dc-9ef4-b18cfa9fb77d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Feb 2024 10:52:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- {"code":5,"message":
  - "NOT_FOUND: Task '4593138182914048' not=
 found!"}:
  - Task: https://cirrus-ci.com/build/4593138182914048
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4593138182914048/su=
mmary/summary.txt

- :
  - :
  - Task:=20
  - Summary:=20

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/405bf7b2a541


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
