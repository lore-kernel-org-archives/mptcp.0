Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3671A22339
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119700; cv=none; b=omTOgv3vz8i7rBFyApsRfqndjEo2FH+UOCV2JSjUu+AzVbfV5a18NWxjqXdM5yrgsUvXdYUwPRPzIWa2ZCsKJhrWytxOcIUap/X7kL4TbPN1oquSE7vIStgYogAvy40ir5UeanknBT4tiYaanbit8hta5xvVrJWakD5sPV7v0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119700; c=relaxed/simple;
	bh=1ZWzqYL42En2VoGEAHnk7cp/mJMeMEeCtTiuGfUEGU8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=FEOr3AuM2+XsSOcqn9y7QLl6vLMOnSn2RCsq8gU+XA6PWtZA0o+cLTXEgWEexAkssWvj5yok+TEJyPw+ymWubK7HqSjs+Pw22Q/XszdeNtCvMNghol7Rzp69Dgjmqsa1nHAFm54SnDi+rgv58Oy6erXDrIKa7Ah84Eez0ejVC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY3Ym0My; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY3Ym0My"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-45c70afbeebso3673919b6e.0
        for <mptcp@lists.linux.dev>; Tue, 03 Feb 2026 03:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770119698; x=1770724498; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4zm3ujhQzmPp4n/jiQ8KwJYIF9aaT0KTBy3FZGCdn4=;
        b=mY3Ym0My7ZFqL7Mm6x1bH/jFZLCFRv8UusRtsoqj/cuyp/HQCnXEIlrHkThtBS/EyL
         8q+1sPycb8U6m4wxWB0wzod/522ORD3GO01HLVxaZuJOb/q5/JhhlwyLM8Gtfof6EL0n
         wXe8jOYIIawRb+dH4++3iJk3pZFdxAkpVFVndnttNEJgfIMFVA8uyYZ0RE3QC7VVmo3H
         uDPrn43llBqerqL7r3s/pPdv46bqfue6zPBfGMwjMsY1mT9Ytslk1iEZUaJi+NcKEWNJ
         NPszoSnzcqgkCkmkLzWltjZZir+t7bOFvtGLwL+hyRPjgO0VHdEua7ffFFVKjt//2Sao
         5oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119698; x=1770724498;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4zm3ujhQzmPp4n/jiQ8KwJYIF9aaT0KTBy3FZGCdn4=;
        b=VxZ+nOJqJCYE4GytrBXEvH9jqvbFB5GvwZvjOLGUDp4T5/xK6/mdV7tw3OjPLudwG2
         aATJ/6byhYEdT27ZUKWwMA0N3GROUw4kj0Od1zEZbuzoA/+LlL8owZeq24DOiyOxbzLn
         qJwyJrZk6+FFwHXBpYM+WsITWKahOdFobLJBURRHYk4d0q9khSiBjgHymIpkLWfm+PwS
         wdpaH/6SJInSoPk2GvS/OAeCEAk/ka/rjgS/MMSMg1mF7J2GE/WcqxIztJAyUo/2DXF9
         /JvV4QYDV6A/x02w3GsZt9H1k+MBp2qCrUWd47YstTwa7Q9p9hccEbRvAtsu+wWXxnTF
         ROkg==
X-Gm-Message-State: AOJu0YzFC5cStvbVMifZJJHfIXhHc0wJqFyCduUocV8+pzanRdSAlxGX
	yJLLVg/5Zl8sM2KSH3ynsgZvZ2rTvzIawmgwa7FoZuicNxDIC4rzZ78DaWMxZaw=
X-Gm-Gg: AZuq6aIIHtKs6qOWpAuX2whXahOKiHOLenMKprB4T5cNDExKP8MiXBPG1/b419H84be
	BjKs+3ZeY4k74WCvV7wUMBWdea2CrfIna3JYIS0D0yF8E6Dp+keq5MtP+8kdxxcaz9y/BFhuJ9S
	X7GHDof/wXmElJe9Plc0khdrZLsvcH6HSw+dHYWguCVAeOE2/TO/BGNhAh6BWkZCZJk4f7TR4l9
	2PbKVMpcA8+d3GGie31UgHrpk6nUfewvMW3Ng3NnNVHlp42lob75zcU6K3L3SlWVzr4Hgw3ZxUH
	otRKgPCfBBizMqmyNPTDqcnkuyZzANPQggwb12FhY+KHRPqPWLYEtMeNBL1FVxDW4/y4PF6yx9x
	Xj4DVnujH/UXD2G+3KqNuFy45hjc+bOv2JNnpifH6Iq0i/60etP0x3OfYvuEQgqeXcPC9CEFHIQ
	BhIzfMjC6bI3Z05lxIPLpxifDb
X-Received: by 2002:a05:6808:309d:b0:45c:881c:e0c0 with SMTP id 5614622812f47-45f34cff8c6mr7993147b6e.47.1770119697975;
        Tue, 03 Feb 2026 03:54:57 -0800 (PST)
Received: from [127.0.0.1] ([52.176.138.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20ddbsm10751406b6e.14.2026.02.03.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 03:54:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1770113743.git.tanggeliang@kylinos.cn>
References: <cover.1770113743.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/3] implement .splice_eof
Message-ID: <dd77c2f7-90f2-a6a1-8d8f-58b41c0ae70d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Feb 2026 11:54:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21626946431

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/7342aaed0c88
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1050219


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
