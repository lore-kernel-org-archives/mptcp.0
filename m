Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B1A4F5F4
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429483; cv=none; b=pV1f1uJ/PKQazESATnGGw3smLHJOUyhQgBQgRwvcYlpsyZD9BMuzMySJEYbWBdOvGe09xNkMuMMn17hmGk78CIP7qhtFyid090kQ+WRUrWDtYCYLAkHFhhJZDNpNlSskQmCIn0ti8qRQl5NtEl6s6+d5vpdV1ProXfSuXuYAAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429483; c=relaxed/simple;
	bh=y0UYq0mxPnBtR63w5Ch1dXAXFV/xxn9/nJBe/1tv0xo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ivVZDRAar0ZJdYWzdsQePQqOcoLbHsR/FU8sqTwz1q6RebdutfYxIT1kSnK9EWtESG8NEbKFqdflFZmH7jjPtcjepLSvqDyQMdpFH7dTvLYfxQsBqJc81E5vsR9K2t7oRV99GD7fBccldWokGaCBzVpj5jxqRIc8a+CqhkwYmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayJ61KUA; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayJ61KUA"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e0518c83c6so219236b3a.0
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 13:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707429481; x=1708034281; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tkl7q6ck8L8h3O03PtpMtFdg4k2gxPHvrvh4hkKBXg=;
        b=ayJ61KUAJ7lns7Z9/qXKtkKKKomXsw4oEEB8h7+dWm9vtVuswUZusUJ7Xgxqah9Mnf
         kWD3u7UugHToy0W3BUpX0+dzC1EiahiifqXLBP3jPseltpoFcMT9ln6swYF9Lx5ArsR2
         HROfAUJuyGZQvc3t+E/h4cqm/P4VisE00p7QIcoI4YVUXh5YrWMIYRgDcWpImkuUp6F8
         1ysm5kNB5ez7Dv/Hbh4IpcLTAI19u1+g+eosQvnOmkvIxgzrJyQkE4yEA7cHwWwFzc7m
         hFiIZDagLLiTau1rRovUIqUqDWKNi+Gp9h0tM2hXlbrK9oqk2xmBKZgRHo5/IYltz7vU
         tK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707429481; x=1708034281;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tkl7q6ck8L8h3O03PtpMtFdg4k2gxPHvrvh4hkKBXg=;
        b=lb/0ZJ4nTIUD7E1dLaHY+WFJeLielYw8PffZJNI5lhp+8kM2woBucvu55W5gDf5ixq
         gG3dOswNgvYg/xTX0tmOcpjxJjyRP03DbsCEqux87recPGBhkJ3acsHRIVZwfiI199xO
         /mdbDseOTmZWERfoWVa5kKfUmbqHy8HYFjro1RruNRLJgIAqLJjk5CWvaGcFhPDQijBC
         nlP/MBTiCyK1oxV6yF7sgluxBlMXDu6A4zNYNLPoVKlU6BUxavhd9Ec4BLZmqXImRKL1
         h/NIrk4lp1oB727AJwM1YLxQy9zgWBE6mov/8zFfaVQ8Um8O7ukpgJze12GvV79I0pro
         gagg==
X-Gm-Message-State: AOJu0YxSuTD0+/5LSOoWcsPQS1IMyRrgMOzi4E8P+yHfOwBYon7/WsJV
	ICpskvwX2uGR0ho1SGrh6DM4Cvkmjwme/SMjAK6c1c6vVCKgxns=
X-Google-Smtp-Source: AGHT+IEOkePCbik9ufrs7rfOVPlhRk/VtNraCcFumefvqHFXHE9IzaAi1Wq1PPghfw/LORjFc4TU2w==
X-Received: by 2002:a05:6a00:2d87:b0:6db:afd4:f54c with SMTP id fb7-20020a056a002d8700b006dbafd4f54cmr740762pfb.0.1707429481149;
        Thu, 08 Feb 2024 13:58:01 -0800 (PST)
Received: from [127.0.0.1] ([52.159.137.1])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b006ddc7ed6edfsm253182pfe.51.2024.02.08.13.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 13:58:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
References:
 <65ea8b9d71895455ded0ed44d74e0de0e2c2481e.1707418323.git.pabeni@redhat.com>
Subject: Re: mptcp: fix duplicate subflow creation: Tests Results
Message-ID: <7e1dd12d-4928-20cf-bef0-f3d134ffc98d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 21:57:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4813501529587712
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4813501529587712/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/5939401436430336
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5939401436430336/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2770999be5bd


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
