Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967C52F7D
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080323; cv=none; b=cplJAtY2Prqe8z2vKrvtVLFakpPah64lft+EDwTH6uMu4j6SCgsif0aRhg4aPrDbb71YBWzoh2657L/GiVx1aB1Dof5irO0Xf9Hg6u91mFb1xyxF8REFt4RlL9YMn9ywTv5ry57XTz9ECdMc9YQ7PphgpWih9xViuU139bkteZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080323; c=relaxed/simple;
	bh=zB8e+UnRopj3yd995TlalWkA6ge+8J2zeIJfPVK00NM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kOI16SX5mhaazdxHoEAMeLbq5bnDnLT9jf4vZXaHG72KXpVp4NYH0pq//ogLf2EpXIl5B6OjOEUjMcnWE9YB1eX/VhBxKGO0CUxhTiGtZ7E4WUtcICnZsfLPJhV2pFmh2uMyLIqnfaQ/E/76293IhZeQc2ksDz+CpAp+TFjdRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H78dSPYe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H78dSPYe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d51ba18e1bso19357125ad.0
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 02:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708080321; x=1708685121; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWrxMP0VFjHNGTR0ZiB/+PhO43MndP6EMTv6R+vB9PY=;
        b=H78dSPYeOhB+DMskjJeSnuDm2Kv1B05o/5/oidh42RAsQVVaNKo/hlSZeeWWypoquH
         raNCpSWcwRCSHBkT0dEExkN//AUDgiCL/kQCzn00Bl+lDCBK7k/5gX2sSqoX4AELeoqF
         SVFRJQvR9mm4dYrxePcm4CgglpzZNjBYqJHhhkZ/V9Vaj07WLa7XqchWqjhRUU9Gl+lF
         lM+sDpvb5utWS8RI344D7NNPWjmi0q7iNGlhZbiTlXkcORwz6AoWRDEi2Xq3OknzTFMo
         Q3ZrvU1ujAxw+R6V/ca0LqWyVGxrfbAZY6Sr3Sy8iS88py4S9gvmiYNzs3uKiALyqrFO
         3wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080321; x=1708685121;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWrxMP0VFjHNGTR0ZiB/+PhO43MndP6EMTv6R+vB9PY=;
        b=V5FGVPPJlNHKFqvHkTobo5B8BiCBR834oscRyORT6P5Dw9pkp7fu3AkeL1C/peMAqz
         g5JCKubuPEWZ2ePGmRaUc79UGw1YM4ZHLlEUIqu+JIPN610znWQBgp0X4++PjRdzDeNA
         BN6yGxReVjhRh5O4dPZrRpBvXq5JlGRCI+/GpwAYm0Pcvks2pzd51fHp+MGLow/BBAuw
         L4xlcOhh8jfGi0+SgJtPkF1Ajvtnyr/jLm0HP6zFeHV+ZlLpboMFzhZeJJOe1iSpL1Wj
         wcoa36NJHAtdhf43sjKUdOsNb1iTACXRLMIXQ3Smu3BQ96MkSub7rIyI8BX5oYPz3iQW
         YnUw==
X-Gm-Message-State: AOJu0YxqWzUl54qUy5YtRnpc0XDKJrQdVFMksue0Z9X2/ryV/l4Pot5i
	mHMXP7huuc7Y2dE+PqlkdJUjwgCtKnkJph34Iz9KUt6nPET2QbkI1Rnhj2A=
X-Google-Smtp-Source: AGHT+IEac8RJJTx1vdTTGiYzuLazXfGSys7KKhPMxcueJoAiAu/O4UI1u1yOGfLmV5qWUjuOKFajzA==
X-Received: by 2002:a17:903:98f:b0:1db:b495:1391 with SMTP id mb15-20020a170903098f00b001dbb4951391mr179987plb.36.1708080321441;
        Fri, 16 Feb 2024 02:45:21 -0800 (PST)
Received: from [127.0.0.1] ([20.172.5.33])
        by smtp.gmail.com with ESMTPSA id k13-20020a170902f28d00b001d706e373a9sm2722210plc.292.2024.02.16.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:45:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
References:
 <f7ca03a3e2d9b8c8a49e9226d88b40c935875e14.1708076886.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: add mptcp_lib_check_tools helper: Tests
 Results
Message-ID: <59702425-9be5-d82d-b4d9-83d666007f45@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 10:45:20 +0000
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
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7929007344

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/e6d1487a62d3


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
