Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70511170B
	for <mptcp@lists.linux.dev>; Thu, 21 Mar 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995425; cv=none; b=nXPLgqv4ewFnX+yWH2wjjZEb/2HLZwtktSc0XpzZQqW16Vv0mWAwJ4NxCvzHYlkZ1uWt7GL3r6iW3IW4GXG22A7BtoMBbBBYuTotkQX9ouOjylPJCtJsA5HndOQjBJle22TsYXmRL4eWmA+xylpsGRfK4IgmH8/4gaMzSOrbvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995425; c=relaxed/simple;
	bh=9sp/T6E842V20J328M+86rzqEvsE7Rd3uBNklrVVhK4=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=pKsXYZYUkuuvdqy8G1bt3K/GrFeW2orl17iSykhBRYbz+HIeqfVEu1CP1tNgOTuc5coK1fdjzS6SukeMtJP1Elnroulg6ebSI6AiYUm3DMyBklXe7XpY4uSfUjw7zJLCHBiM96TpQ2QUj59Sg5jDht1/akPstYnvUAEB8oHlETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXvd4kS6; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXvd4kS6"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609f24f447cso5329597b3.2
        for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710995423; x=1711600223; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjY6um0H2coZuUFXUWZjH3IAPmukwSMpI/kpmxyWZNI=;
        b=cXvd4kS6XHhiGzhETH/dzFAK9FrQC3IhxWta0jAp5Ieg4QLuKjMFi1aWt2Y/FTZUSo
         jkdwyBIKyf784klkWoBMkII2StlxNrCPA6NrsokB4xClRa0u7UvzVPkOU1TUgebgC/gV
         IrtA1NDEs3l6KfI0H7GUT6efsldyDVn8cIIQJjcYLz/tqUll2v/TVgtVc4TcRKM0vVb7
         REMCclyGXcP+FRnvxPEVrD8v7LQ+XPQ4ts1vICMp6GOsMe8yKEiSAo9jnppFb6hav4at
         8pus2JfKfsNK4ocbloH1u+GbZYpDJSVNLtgJbBGa8brCxJhqfoDC6QT13+LYx8K4T525
         R3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710995423; x=1711600223;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjY6um0H2coZuUFXUWZjH3IAPmukwSMpI/kpmxyWZNI=;
        b=ZACbD88n6ewM5UhwfCar3072FSdF2On1+yKJyt1T7xoG3SnYYT4GUeQQsyUTrtd9wP
         XvX7jOxtU20GlyNoTkoS14+r/kMk4dg2i8Y0AOlv6f3zfJweEWjmoz4kbmYtKkSoxBFX
         oywO+z6HEc/QJ030goFsm4JqS+J00irOpdkslsepTpq3OETIwpxvDAYrhITcWVjM25I/
         lT1ZY0e0fsj10ZGXScXCDGZz6dv4dqXW2v6AV4Xt6eDTfSr5w7liaE24L7cHokA2cYDv
         98hDCQPkryq6zyzT6hZSFgoB+tRgJADfjVAnOsanjp/Cf0wfMY9GkEjK85xg7nAWQtJ3
         gXyA==
X-Gm-Message-State: AOJu0YxCGuE/QZjPkO6QazhqKy9VaJzOzxIOwoTAwoJht0L30uKLuPV8
	TqlamSWZgS/XUMKP+JLcTiQRAaLOIKw8Cy7nMBUJa72E+/rE3bUENPIRJAs=
X-Google-Smtp-Source: AGHT+IHdJn1em4eKfBtNfklcTvhXfnm7mhhkM3JT+Qtomvu2BTMb0QNu/Fb5Q2b3xIJltByvxKZJlQ==
X-Received: by 2002:a81:4310:0:b0:611:bff:87eb with SMTP id q16-20020a814310000000b006110bff87ebmr270446ywa.14.1710995422730;
        Wed, 20 Mar 2024 21:30:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.172.43.101])
        by smtp.gmail.com with ESMTPSA id r16-20020a17090ad41000b0029c68206e2bsm2543498pju.0.2024.03.20.21.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 21:30:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1710992399.git.tanggeliang@kylinos.cn>
References: <cover.1710992399.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/4] setsockopt per subflow: BPF
Message-ID: <35742d34-d8f1-bb98-c0f0-d91cba0419f1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Mar 2024 04:30:21 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8369436657

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6416b9452c7c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D836914


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
