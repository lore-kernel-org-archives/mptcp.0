Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F379CA6B
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709782166; cv=none; b=p33iWOJZu4LUKSZ6LaEkJUGAQtMQ5USyNmZJWu1hEHRprRXpE7FVHfPSCmrfbPvTY7tkLLlKg9vXLhZxHrGg6bgp1jOCNGdMBTq4RZar1YkhAMw0YeN03fSBCuL3imjiTqdTA0UtyrR7JUhfNpGvFEzE4kmzXL2BTadOd3LVEIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709782166; c=relaxed/simple;
	bh=Q6mhvZiPBREvp7wdPZGIwAveBN1GPHuy1FMkh4uEx28=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=AqIfHjDY0kwY+C3Vbo4QhbKAHsuuW3dqEDuAeEP7pDWETiPEj/T7Y5BEQU8Vezyjd/vLt+/q8d2+t80p+HingkqoPEm8DN4zxNSTq2aNlcv7Ilj37VetWoGQbPKIUdWCV7SEhOnkBVpf1MunNctBnZ9rcmlIy9XRaO+lNGtz6l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJn3VtiY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJn3VtiY"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so390431a12.1
        for <mptcp@lists.linux.dev>; Wed, 06 Mar 2024 19:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709782164; x=1710386964; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cEw/9glXCzwTUSwX2lLUDEVNNJkU6LKqI9obCXsxmg=;
        b=LJn3VtiYtYBXlnPTmO272N/0fuGkHxq01tkTPY68GSplxUUTNkfcMICfFvTTsm471V
         ndzsgBVAT6Xy6nxOvbpOmDWgzFJWGGWb5yLsg2JPof+ztxHT7ukg13EgWrrT4rf5kuUK
         fO4V8PmwgslgsGieM2XcGWzfhr84/eVRcK8w05EC+Z0lL3Pk7YcQMdxhptjRz3TtFtfq
         dCLp+MWok6VpEAYwuiQ6cOnF2GfFE4JrzJjOqQ1UDW00GLyvAMvbrZ/xz0hJEAinepGO
         y8q2sEXI9qfzfLFWJ0g64m9+Ojvv4B+eacEQjZhdXqfpxJj+jlRyAaGQmXtQCXyyMCN5
         Iprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709782164; x=1710386964;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9cEw/9glXCzwTUSwX2lLUDEVNNJkU6LKqI9obCXsxmg=;
        b=UwdLdlW0ZSqIDgab3ZlSd3HMQCVbSgwkAnQE3SkquP64EF4IXnDXbYVygcZ86w33rW
         nbOlTWpKcbHS0yKT968nlyWIRghCBkpTKztRqWJlm2TjDF6d0C5I0AOa1xAMiVOMvbkb
         3hj70AbcZvKFuih+nO7PVRE8OFzxbq332h4/BdK+VAWtqePhF08RY+jxkjVkVOPdtcY6
         /KvkQL8Ut6JvRfAntNRmYEXpszgQtdFi+tBzIvH88NnZv5cAhr91AB+X1PCVdetVuKE+
         zPEQrwLqG7gzbTTviBVxwD2sQsGyQVN8lH332Bk1RR84KRIrMcC1bNkc9hw5qVv9drOe
         OsfA==
X-Gm-Message-State: AOJu0YxPhm586UxYxLoVky+UvrwChEMYhwwW5ylg6AdoC+85RMyziVnP
	sFdgmhVe++d5GCVjudtMPkqzrOiUeX7G85TcpHkXq6VgNbqwyga7PGW6yQE=
X-Google-Smtp-Source: AGHT+IGxA606EQza56teugbdWWz9Dx2/EMXckbjbNZ4EqxDo5wJF8NmQZxo/b24XNbbXnaaFe+kcdA==
X-Received: by 2002:a05:6a20:938f:b0:1a1:3ac0:f7bf with SMTP id x15-20020a056a20938f00b001a13ac0f7bfmr7156364pzh.40.1709782164276;
        Wed, 06 Mar 2024 19:29:24 -0800 (PST)
Received: from [127.0.0.1] ([138.91.70.191])
        by smtp.gmail.com with ESMTPSA id nh3-20020a17090b364300b0029b7c9319c9sm477833pjb.12.2024.03.06.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 19:29:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <06f55d6d6a1f37da444bbaae9262079d300efe0d.1709773913.git.tanggeliang@kylinos.cn>
References:
 <06f55d6d6a1f37da444bbaae9262079d300efe0d.1709773913.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_connect=3A_use_+=3D_operator_to_append_?=
 =?UTF-8?Q?strings=22=3A_Tests_Results?=
Message-ID: <abe2feb8-ee3c-17e4-8fc1-2bcaed2283ef@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 03:29:22 +0000
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
  - Unstable: 1 failed test(s): packetdrill_mp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/6082312262123520
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6082312262123520/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5519362308702208
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5519362308702208/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a61bf0e8b8fd


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
