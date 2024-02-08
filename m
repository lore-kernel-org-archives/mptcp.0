Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8866F535
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386780; cv=none; b=ubAyYURoC/EKrSj2m3hkVrUYoFiOU3QUwECDrDzbyGDji1CuDXpyUBjRs0NKX4DV9ssDclygq4vYFSh6a7FwF9LscpGMrkeCzEhaDaeJEXKGwtIuP5u6yo6yi3IXqG5L2LiZ7HzwN+NsXni7MQfPt8Ydq7jv7tt63NUiBSNIep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386780; c=relaxed/simple;
	bh=IqAPSX780MFQYRzVYrX6u0g+9ex6G0lTpeaBBpPqWTs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=EIhNR5+I2z8vxNUOC9kk4jxvj5aMIhq1HxWaFKvc5MZdo62EAl5J73o1mySYRs+Z6qVLB1LBSu0HDEwEi3wLoFr3igNiZBI5Yka6ftqfZZ8m0NKAfE7v5FZRMCHkbhlxtjiqP637OOuw5Ov5CJ7PGp4srOZHiIqLSE8Gi18qLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzt0NZ90; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzt0NZ90"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42a0ba5098bso7882621cf.0
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 02:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707386778; x=1707991578; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rUp9HVMdiGM0+26gKGWrCt0wWZvARUOH4NUZppXs/g=;
        b=mzt0NZ90RsaEtt82cO18LgIxSL6znnAqhhKTZXXYxvdDzS6IWqi0CwIzHArqbNT0DK
         5rR+1HgUZYW5tUJzQjxsiW3irQvrCqslNUOjA/Le3vGdrtqZuPItZjmmFiwMPfgbXUK/
         s6N+fzHyAj7Nzd4NdIYXxnEOIA3yq4HMu2FSQLWFCLVP0krAN96jT6Dxpa44SwKgGsmJ
         9YS17FOF9SshdVuMud0p1Q84DXXyxNSC942WSXvKgbxRRSYH+3gYe0ZDC6eUr8HaT1ek
         ZEnJFg93XujhtLanmQjdPzXT6+dan30VdbPN0+M8c2Nqw92dnqQEAJgOyx2yC4ZaxaF7
         w6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707386778; x=1707991578;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9rUp9HVMdiGM0+26gKGWrCt0wWZvARUOH4NUZppXs/g=;
        b=ox3iiriaPCnBLc8eF4IhTuj3uemyu8qm9tXD8lL0kLC+IxJakHfK4FLDQGn5nGm1qV
         iT6RWwA/u/pDEpA6p43do35sb8vaBi4GJITCH/Kpw+xUBG0SrUQ+IsYVbe0DhoqFqOpn
         GKQWL0JXqRyUWMr91iCjBcJE+DiiKQ2/ZjAUpbbJS5Cm+ldK4/2N9Bv+3L8zjU1SNs8K
         ElaFEBXwyn/DCOO68CgnoUCaRPY+AzO/jOB/3xrlVM2qfzlvhPDyEeIwdgcAawcIooKV
         X2yURe+6qL1wyMH/5NVwmTZ+wf5bVYKhccvD+67/9/O39HVnQpR/vDwH/aHOUy61vWPS
         kucw==
X-Gm-Message-State: AOJu0YxTNWZ5H2eXZPZZrTyFoTBfT5+6WbA050ZPPItbyHNse3ywXrh9
	yZMTBsGz4C5PFrpMJDOIim7PEVQaP+r0Vu8FzSA3d+cONCiPqWNNX5qxbiM=
X-Google-Smtp-Source: AGHT+IEzFDuPz9djBGp5koSGsG9X8YbXNxYd9gtGoFzSBRb9uLAi2+KVJPdWXvoxQr4pw8kedfYf0Q==
X-Received: by 2002:a05:622a:cd:b0:42c:21e2:b169 with SMTP id p13-20020a05622a00cd00b0042c21e2b169mr9161234qtw.66.1707386777985;
        Thu, 08 Feb 2024 02:06:17 -0800 (PST)
Received: from [127.0.0.1] ([20.102.46.181])
        by smtp.gmail.com with ESMTPSA id x4-20020ac86b44000000b0042c48c3b584sm568621qts.9.2024.02.08.02.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:06:17 -0800 (PST)
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
Message-ID: <b213e0dd-ab0d-13e5-a46f-91449edd592e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 10:06:16 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7827490298

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/d795f50e2612


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
