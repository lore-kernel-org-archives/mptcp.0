Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AE72602
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765515165; cv=none; b=mkoyx9YR+HcGEpUKUjz7Uv35buAxcsh0VJTDs2GQB2cCu15zzekW/nJTTYLqY9LOVENtOuIxAW692Fxl7kNEikR5efI29wTdJRFPu9nms5jsKDkaSpP6K9a5MCCJ6FGcJn9Nx9iZad9TBN9i+u/AwOt/c0yFywzvQbPVlj8lIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765515165; c=relaxed/simple;
	bh=6P9WihWQxnRHnGME7wyqG6nvwEjU+UGkBgBRC4/fllE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=STrTmow+Eh7cejbJic/dw7asci6tjmcxFAffl2ovqgXQHVkgC+d6PDYV/txJ4wmzXDYjxItdEQvy+7Z8EW5F68iehEMBDHIpuDrIgQtS/dFAXzgS6N3MLBzZk3nX9qfVVIH98JFv6vRpcjh1lX2ymGLUDRxNYb3ZEwEhjDcv/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CThWIwPA; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CThWIwPA"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7c6e9538945so528706a34.1
        for <mptcp@lists.linux.dev>; Thu, 11 Dec 2025 20:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765515163; x=1766119963; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRq39DNeuvmYFXd+r3QW7Q/DGamJO5w+zj/HyWP4bEY=;
        b=CThWIwPALkOg2xvxLlJsU2LJjG5OJ70y8PZCGV72s6dLrTfNwxZtvNpIPt3xEe40JE
         K+4ChhiLYu6HIIVQB4Mer6b6jfPDwGU4xNVTjyVa+if42AsK4qT73TO4R0Uo9w3W4K8I
         NwA/a29p+136pWHpu2UxNi99BbT+ExcFaZvQZNUsO57Tk9NWGTrSfDokBUtG368n87x2
         WtGQZgY+UhcSB48qdApRa3wzjkEA0NNVOz7j6bj8/l9fWu2BDFQEPI6b97dl3PDgHJBN
         y11MilKeGPJLsH0zuXn83o6XvX3cs8pcSOodmvB7cDB25+zl51nVy06qMpxzqwFalcmd
         I11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765515163; x=1766119963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRq39DNeuvmYFXd+r3QW7Q/DGamJO5w+zj/HyWP4bEY=;
        b=wBBuJyYv3vbbOFn4xWE9GZI5esz52noVCs5Ymf57AtowISpWRTTDVqE87A5ZSxAi7K
         fp1iRW7+dvEU8iHUN2Q+a95lqD8qUINmlLXnDlfPpVDu64t4RhBiowniP5hD40PSnNYN
         eGMW5rqu5KyOof530F89hyOZ+M1UjCJpRvOEMqHFRs+nbS8FIUvKLj3tV/QK5v+QiP+R
         A/vHGemnEAKYrR+3GQmX5NlZ1MYEtdwV9mIWB7dL/vwK3JMm8pK3Kw3eYgYbqYHbCxYW
         reJhuodP2ABHl4oajlwHY6og0VhDn0FVmD8tWCSxq7xEYgYdFwtyX/3zIZ5hEwRLfYVN
         q1Bg==
X-Gm-Message-State: AOJu0YxqZ/p+x4B4b/RokL+phZEhJll6WSb92vQ2+pt5dWCmoTyIzS1r
	GG2U+hfcQMkEOVdd7fjkjdaJn1kNpnWskcHrXC/Jk7tS4MJ7qJNnVseNGq6hN64=
X-Gm-Gg: AY/fxX49HILao238HnWfsEOOY6Ej+7HyHNtKv/TcSTylNHXB+q2OVI0Wu3gSDOyf3oD
	nJ2HOXbFjRfvUP1yGHBrFr60pjPOqtfLX/+UUCx2D/hBBXP051R7xUe5reESrLDiKsExHyCH+Sv
	+jaEbOLL6eBAf47uHfsWQGLW8o9hq2VWCugB+n2/oWNzBLPxYuNc/EG+goPIRwtn9COSxGw7gDE
	LDQcX7bJioomAL2Dbq7A6zRYQ43W9XurUi0EqHFUcv1txK20lR46D/jyR9ryOOiepkuMagL4RU5
	pStHe8vLNX21v6GsKO0vGsUdYoFWKSHrhqqgGM+MbFLR4fZpeFrXfLcSfiC6TnouMecTbsiE25U
	5UnTtKo6T5pJDTJ4PNMVQrR4QxX2Q0sl9JAB23vvH903p+Wqpa7oNP7KqNLr21yeYYxFZo4rwa9
	tngPLJ7r76ZfOY7OZH6NBLrxH3geWzLy/6wDM=
X-Google-Smtp-Source: AGHT+IGoW67MaeeOvgLMBbQyI9CAtAdc73UqgPEGU9yZ1ZuR52Dtkryb46RPOip1M5DzSvBz2I317Q==
X-Received: by 2002:a05:6820:828:b0:65b:3312:6472 with SMTP id 006d021491bc7-65b45186f47mr359555eaf.13.1765515162993;
        Thu, 11 Dec 2025 20:52:42 -0800 (PST)
Received: from [127.0.0.1] ([52.173.178.209])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f5fe4e4169sm267741fac.12.2025.12.11.20.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 20:52:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v4 00/10] MPTCP KTLS support
Message-ID: <7c2fe20c-1fb1-e735-28a3-09f85ab5c849@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Dec 2025 04:52:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Unstable: 1 failed test(s): packetdrill_add_addr =
=F0=9F=94=B4
- KVM Validation: debug (only selftest_mptcp_join): Critical: =
2 Call Trace(s) - Critical: Unexpected stop of the VM =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/201545=
32531

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/397a7ac03cb4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1032489


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
