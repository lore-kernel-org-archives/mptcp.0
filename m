Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51EB145356
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 11:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251273; cv=none; b=eKk65M81wa3D/qPUWDL5qupBLSCJzsDwol7YCkldJ8LAx/qYIEVQp14dSSEH9vjKEIvOEqI4/qyDX2t2C5CnWuhr5MuyGd90JG+olwZLExEtE7LoVZpCJQ8Qrjn0tlWyt2EPQSgjL/IIenne+VGQ6MpV29OKAhk1g0rzzW6v6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251273; c=relaxed/simple;
	bh=zXiixvipTgY3QuXP0fiW3CM72OZ8FTfD/oxoBXtX6Dw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Iz2v3GVkmNuEhMrN6qj0/qurDwvCHmZSFxgkoW0WytRlr62iWpa6j5s9csu01WXnGZn4P4ptckRtrNacgjZMnbl87mI0S58bIPc+FEn5WPqSYiXaEKUXiPZX0ANISXB314ijKWLjTsWOX4vcAQXUArhb60QsShJZlX3axe50vNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVPW9ZB1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVPW9ZB1"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d42da3baso232853985a.1
        for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722251271; x=1722856071; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fN1q+GAhpvkBtYciGXZ36E0A5kwqhtyQc08mdMGcAk=;
        b=kVPW9ZB1ndgXQz749EXq8LXy0cDICGzynTE/9ViIGgNd20vRGhQy5Qbnsks0O3d2Zx
         w4aSQ8afDhyU0pquVdGVzirKot28YYBk+QiqXCF5OE5tGirvuOlJgTibFGvgW2XNDOl3
         jxD0h+7W0qdvvCpogdFE5bTFxDiCiudhpE3Q27jVHCYXapVD5105mdTzALjDqmCOabGp
         N7SQxmX1WSwsiCJ/8HPkS5DGUTgNsWXQrKfSHIqlI+Z0LkQtbksbWkcoXA0ySQwuGMie
         g3hSbeVXxH5QyV+XhxRYyWu6KF0laC1+Yd13Npo+v+WnMFCXu+PdkI2R9+SR6uhFBpnM
         JoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251271; x=1722856071;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2fN1q+GAhpvkBtYciGXZ36E0A5kwqhtyQc08mdMGcAk=;
        b=fBKcVdVIKXjX4tHD+OR6HWbSoeKx7jhtASgVmi0EMH2ZVV3fIUSNYIHE7FPHwX03b7
         EfGc2PwjVRnpk7myE5qT33u4alJKFFi5ZK2qMOZmBlsuYC9CMZpVGAqNyOXRAMQSvRMw
         UD1ci8YawdrpD9SnZZX/4JaraBnwZ1+M/+4e3wqBvaZ5JipY2WlJA95eMQCUxIo54OiI
         ioen8KwC3qTL2+E8IPyvWCrptACX7Y7zDX8RSikkFADnBzILDUnt5LCRJQJ2ec+XhbGE
         YBGVhvqVLeVE8khYOTAJmgZMDDQDXf877kJ5pPQ+2lppl2rryfeKzCtknL/UOSLWEzMK
         ChCQ==
X-Gm-Message-State: AOJu0YynFhrGEYvA4wquuhJYiXh8V+2digoWjmy5J+xf4jin/MNPqSqu
	5fMkQrPUdv7d2inb3YkO+fREQj/gjOvZnCxsk7J/mdx5jwqErZI=
X-Google-Smtp-Source: AGHT+IFqGawzFrUccx00wfnn8CDZ9kXGmrzhbMc3Z3q6yBbhGaTSCQ+p1oM1PsJbowHXtfPZSiZPww==
X-Received: by 2002:a05:620a:4083:b0:7a1:dcc5:9aeb with SMTP id af79cd13be357-7a1e524c611mr1016895485a.20.1722251270727;
        Mon, 29 Jul 2024 04:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.186.67.174])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1ef152fb7sm169566185a.91.2024.07.29.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:07:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/2] mptcp: MIB counters for sent MP_JOIN
Message-ID: <2946dc32-71b5-71a9-5e9c-420fcd7710c3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jul 2024 11:07:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10142618180

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9a0132449be1
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D874506


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
