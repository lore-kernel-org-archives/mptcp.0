Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871C59160
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081727; cv=none; b=Ze5VQJpcWLw+Ri0s/DmvUEPDUSoXertqAFy30EWh0SQAvR/uU5brCFyXyoCOZ+zU7UEE0y7R7OP18sfMfZezqeXRsZIDoQYfx86exEn7hGCbxv+3dHZemVCt20gsTN6kZg1k9Xx7ACOxTr1z8eRAySjNEJP1eo+a2C0SIgonpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081727; c=relaxed/simple;
	bh=Nz8knuZK3xKFOS99/ocjerD/MJTqS/Gz3APPLk8k0Tw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PwNraL3eHnuHvv3U+bR2fWTvc+KVuFSY1haSzpHRu2tqR8AvVXfcMBGdn2zYx6eSxJTYx2GUKZP3WS4wJ6o2J/G0VacSW3gy/pt5bbW7GSVlC63Jj4+XdzyqVOftBToSWZ7GJz1hPhQC9BiwFXVK8cakOpGU/rkXpnTWB5g4WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O57Up+xz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O57Up+xz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6861538916cso10715896d6.3
        for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 03:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708081724; x=1708686524; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izlBsjPbctuV4EBn1uNpVyzZm1gfima6DG1Y2WWwZis=;
        b=O57Up+xz/YfMzLo38++tAR8RYsMZL14GwVjMoBfgyql1mItsJ739ANBJBWa4Mv9Rey
         SgEepskSXHnODm3iRbDZHWIa5nLXAgvjDFr11lq2ZQM6JFE/DPYNl2DmrWZWKdtlES5O
         iC0mT8+8cfgPe6KEPn5ILKKV4PWNfiC7J1JR+aBQqKWb+r+Pp6LJ0jB0Vd8pOwvNdpD/
         8csYNipXcm+xz/5S39IPxNvuPfPI8uhT8eAPhMRDmHQQKf5JD/8f12Xtp1p5WUNJd3qd
         sDKh6eJDbZdKI0Ye9pwJUoSYz4+Pq97httbrAwcNzknKtpPfgg1CVrbW3fnma6Nh0DSp
         OURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081724; x=1708686524;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=izlBsjPbctuV4EBn1uNpVyzZm1gfima6DG1Y2WWwZis=;
        b=cMAfF1/OVm07HJce2/HzntNTIqo7ROSTQ+IBw/FuxV/cGhDAow3QAxMbGnoXZ4mOpG
         CjX5ISUMUk7w87tlV8xaB1zQLEjagFG+BUbH9HHBFvTpNNLYFcL5WQEdlrh/oGiK8N1N
         a0avnjanVNUI0gcJuEHj/bh56h6DiL2WaoiWXX1grPVwIGLSpcKajnnOu1Nqt9fXFRLi
         yvcwodo16cZo42erw6BCJ9cQX5naoCE4bHV6wOIm+KyvTfLAa5ZDZ4THeoq2jAA5CzsA
         hsxDyrfOKuLrzou7+XloqkyRNsDU5f8Ey4W7ct++LoMD13u2PbZjlbV6ctZkbQLJ7XBY
         qUhA==
X-Gm-Message-State: AOJu0YzAwmRpufSXy0jXTJ6ZGxjG8YSXaI42g2OhnEnfun3JKorbunBT
	DR72qpsKSknivWT/RsFQoVHxNdDr/njVr3SW8cdzugicLV/L6qztwRgUPjA=
X-Google-Smtp-Source: AGHT+IEH8zleE92J2jlqikXsQ1wUQmjZaE946Qy4SSZqryhNVNdFrnwT3oOuDjvh3Eips3z0bwfDow==
X-Received: by 2002:a0c:df82:0:b0:68c:a491:2ed with SMTP id w2-20020a0cdf82000000b0068ca49102edmr4348831qvl.6.1708081724038;
        Fri, 16 Feb 2024 03:08:44 -0800 (PST)
Received: from [127.0.0.1] ([20.55.222.107])
        by smtp.gmail.com with ESMTPSA id qn15-20020a056214570f00b0068cea7fd1a1sm1638362qvb.27.2024.02.16.03.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:08:43 -0800 (PST)
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
Message-ID: <5b7f1d2c-2b3c-6d91-3233-139f8290c653@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 11:08:43 +0000
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
com/multipath-tcp/mptcp_net-next/actions/runs/7929308311

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/c454c04a88cd


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
