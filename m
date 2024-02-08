Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE02EB14
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388809; cv=none; b=dPE6644eAjuIuJJeD9kFRP/pmJlHqJBSfkGu2J5zAUJ7JulZgQEjqk/fu5Jmk/F6rvc22vVdIkKJLMasiEjKk7tqUNVnKYXT/6X+c5Ovobv2FNU/JxDXjhBz8Xa1Mdhxy6CLM/FANR7wqp7p+CUEWjO1G1aZ5DVUEWHmnibJN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388809; c=relaxed/simple;
	bh=mefWco2osPK66z+1Es3as+81b4FacrzPNo44W7teCZI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Dprhf9BkAbmsq6aPo+0n8HaOOwVHDRHOkxDCD1YByGaUpwZa4Byc5LqIG4SFJMiwY0VczNIw8gUbBCEedjxeOYTpw3xJhQCfRkAQPomHajB5I2R6pO38L/LDVI9YviUjpcLNvE8E20cZHhryrOBgkYDFc/JHQ5fy8Z0pISyQz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwZ3fnLU; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwZ3fnLU"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604819d544cso17800057b3.1
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 02:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707388807; x=1707993607; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Isa2J+vrFTwEF/yWVncc/jExr6z2MZUTblGkNUqI4nM=;
        b=cwZ3fnLUOQF6mXCJsyLmeCYEortkdivnytRtwfhKVhd2LwRsSj8MjoawsdQa5mSn1P
         17fUWqQXxXFwi/izZOmBwZTYgIrDLxW7VhCmH7c2xqAMSxlXIl9cqGh7TpP8w8OyAZFx
         HVpx+sXMRNrwMtZh76bTUkB+RUO+S//ZUq6A/aEXvLK1ijK+CxKi+4iAMiw3c9AClGVF
         l0QMFV3zSJbdeShmfwuI7t3mZNqGWKAgQ+TnM3GgVDliavUxK7revPU8qKJ/pPLZ5l+K
         xVdZGf9tTqKSw/bcAzrVIMM7/Fv/Mnij/c5VFCAC6hgg6+7iDfFfqYDiTphKGOOSPngz
         rWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707388807; x=1707993607;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Isa2J+vrFTwEF/yWVncc/jExr6z2MZUTblGkNUqI4nM=;
        b=aqMq7RXqd6mrdXQ4+DrG0wFeOHlw+QDSvVCeCH7QC3KNqIx3tiRbodZUpP9IVjrptq
         MdK7hFnvd5yisfB7EoEgumeye//qHP0s2MX01dM0pOmHqgPmQXM1VgYpnTZrOEqQeaJn
         euyU9qvvrz2bHQWhHXxKeSz5L7Guu5pu3aAyjnqxlmjAYsxsSMiwsUcwfVBcM9D0kb9g
         IyKm0CAZDthZ6z9EHNQ7+8ASvBSiA/P+qkD+jwlsdrj/NpovMIDGLREMC4jirBZCducN
         d108c5SiT1wNrYaiaxN4D7XS5lEdsjbSVCP6p5m6LmcoG/FGzxjznnwIPIck+xyJYH1m
         gGqA==
X-Gm-Message-State: AOJu0YyPOezqwiW5bLDS9cY5uRvnO5FtycDDQdSVAWIgXdTOy/TIMuVN
	DZSrPz8931bT03HFdMsc4QBDgTx1P0ei+Y7AVstjjM9TOdjNyJ+H7s1FAfc=
X-Google-Smtp-Source: AGHT+IFSj622Y542FUA8irCt0gqx+bBvVfO8Oy7NysmzXlLxQPvIEZJdClds/+SOjft7JZl0Z5Zkbg==
X-Received: by 2002:a81:f206:0:b0:604:3d5c:e1f5 with SMTP id i6-20020a81f206000000b006043d5ce1f5mr8391909ywm.1.1707388807228;
        Thu, 08 Feb 2024 02:40:07 -0800 (PST)
Received: from [127.0.0.1] ([20.81.46.154])
        by smtp.gmail.com with ESMTPSA id jx14-20020a05622a810e00b0042c22cd9880sm1295619qtb.3.2024.02.08.02.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:40:06 -0800 (PST)
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
Message-ID: <196e2655-9d3f-b331-9985-e297e4be3570@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 10:40:06 +0000
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

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_diag =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5554170015514624
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5554170015514624/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6680069922357248
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6680069922357248/summary/summary.txt

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
