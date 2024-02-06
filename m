Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003D127B6B
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201817; cv=none; b=HHKWdbVCa2oSY6BQ2qilf2hkBMVlUk8rwJknxFU2iKkSOQAqjg+uNHH4InBXi1iPeE4kD6vIYkselMEWq9Lx7r9bYENb/tJ2SARY00vcdeW8qXIGs0xanWUJDXhkW8mObQh4dPqmvcYz43MT+HUyvSTzESz0FFLSHhZj4ZLAjk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201817; c=relaxed/simple;
	bh=CvMnqabdGjbiy0kkXXTjQSljUDqtLYCH7vSicVgLplg=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=bgb8aOLz0gbWsKJY4WyLaTBZoIy5kxjIOHNb171YEdrC1b4yOckIMg+fsKRhFcHTY9SU2BYGlLo+MUMU3o98ueqfU7sok3r7fcIT3gu6Bb2u7iLM2o+I48tPhws+O4sMpYzOjKdh4T2ECKUvoHBiyZrlrJOlSnUaSELt0pGY10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAkO5qg8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAkO5qg8"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7857964f57aso97163785a.1
        for <mptcp@lists.linux.dev>; Mon, 05 Feb 2024 22:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707201815; x=1707806615; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=purTfjwba1gpuL66hftf3Xu2WYX9UdX8II11PxNoZBw=;
        b=FAkO5qg8Nh7rgGLct7BDvRrsvzUDmzHeocDXbz9Hlt62/4IgWVpa++O+PUrgsusZGK
         poQfvy/zvzhbE+Uu/DChm/KpDNaM4vamyN6mSZV6Svcr4V8T6lhXvW8BMBoSi16xplx2
         jVsKXz9LrqnQXs5NSr68gzuuy5bduemKy662n26ciuB0qWUd5+eppMStVPScgLYa+UVV
         I4Pyjz3uI7QM6bn5FA1g3ObNkotFVwLfD7NVFa+ID475AcZV8fwWPrSW6KbpFFxRmYJ0
         E51kczilruyCyHYperRmdKfZc/YDPFzTf3fagXg7wts/TeVK4hp3IpxS1if9ZRqRKHzm
         UmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707201815; x=1707806615;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=purTfjwba1gpuL66hftf3Xu2WYX9UdX8II11PxNoZBw=;
        b=KSaaHCz42Wi5gNYj4CwDaJN845Mr21jOuTS6G1yXZhZ7t/7OP1ZELuif7e3In6DubY
         0THhYjpEh1xx0GG70f+xYdZ9n8cHon2S2sqX78uvuYCtMFq0q6NBVGtOXePqxw+ZSdKH
         4ucQFSPsuxWd/dRpWvkeUuDc1aCw+TOgvzfD2BnxbTV1j4301cLQplkB5wbB7JCNsbLZ
         +gHzG/jPS0sKy7wO4JrMh/f+CkJNrZcfnDfcm6uxVoH9sL93GCUqC7Wdo17zUHreBQTL
         Nkb67S2PNiBXCmLVV5RVk7B2CuVYSywBWz8yyjfP+IkUsLGYAqOwByQP7pDZpAXqdd14
         VsYQ==
X-Gm-Message-State: AOJu0YwdVR1GS4QWjFDAgdBKqxtCkdVcB4BQ06ThJFLseFaDRE2HYMn6
	AFrMqJLVf3hVeqEw6DvolWfP3MUA4+Y/JhdkFh8W/gzGV87o/CKUK5aQMjA=
X-Google-Smtp-Source: AGHT+IEbKcTFN5nwTU94mrjeIEWYO28liMfhi7LS74nzokT9EPNYp5YXcpMVUevGK8q2yIVQt04rKg==
X-Received: by 2002:a05:6214:29ea:b0:681:937f:6e68 with SMTP id jv10-20020a05621429ea00b00681937f6e68mr1088302qvb.63.1707201815043;
        Mon, 05 Feb 2024 22:43:35 -0800 (PST)
Received: from [127.0.0.1] ([20.55.15.37])
        by smtp.gmail.com with ESMTPSA id j3-20020a0cc343000000b0068c59c49c8dsm730693qvi.132.2024.02.05.22.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:43:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <683704e855c0b54d003d6d635d0850aab0b71525.1707198093.git.tanggeliang@kylinos.cn>
References:
 <683704e855c0b54d003d6d635d0850aab0b71525.1707198093.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: rm subflow with v4/v4mapped addr: Tests
 Results
Message-ID: <f0e477b1-204c-5f3a-7aee-1f26276a8a87@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Feb 2024 06:43:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7795362577

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c83ded2d90fc


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
