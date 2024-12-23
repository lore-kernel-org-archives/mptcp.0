Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43246198E90
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952663; cv=none; b=RUBJM8dLA6W3EQWmGJnl6yfdRMUbFadoO+GLGCVLmoOUr4xMH10EbM+wreqmFl7Fz4MxxiHl8o+SYoLrLbGnv4wCa2efeHsFc4nilvu47pBz1SGmeKoVRGmOop5sSa09J40AASTXgCFwG6npucKc4wg36AWgVfw8KNUMyBqDyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952663; c=relaxed/simple;
	bh=iXCjo0tsxwPyahzsGqojB4t4Uhv1ClzEE/kIOrPaiEI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DGpOZjX6TJVcl7aYoX6TA1PEt85R2m1eP/yqsmt2dFIdCvNPcJW1lZoG9G5VaipJDuPgoMA7li0h5/Aw3STqEJfInL+48IYoj6XxDXF/ftkfK4LbUyAIftg2DiQ3xAtwa+5QEnwkr854qMNFjUPCjJWsTnIKE4fg6XrJE+H5hxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lme09bv9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lme09bv9"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6e4d38185so329528585a.0
        for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734952661; x=1735557461; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qurUnaiVhxBRFKQWVGqGWQeSrVuguRRensao+dV/+08=;
        b=Lme09bv9ZKBygUuJgjv5DAAuXR0cW/1FApTOnIU1NK2MHCbGKdtpv8mlnN8v4ErO8i
         LE8pIhmcP4mhUHAHMeIb4zmRtI8jHrkMSjv2JEuNOkGCtZHyaNGgeaEpnoCEwl0pyIM/
         eJayE3aHC2uKlap65Qirh+A8FUlMsX4tYCBjq0GuAOiokrg39xiH5llJ7KMcaoPfNkQn
         dM/UsPBgd2Gdk+HUHRXsSBImVsj6NqiT7h1XOUfSFapU/XpbFoSyl6Ybf77jOu0FRqYy
         nPA30hA0NQ7qoydNYf4zZXZNMF7KWFeeBnGq1K9kXAGM06CLG/dtdda97jnVrUJ3NDLw
         iRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734952661; x=1735557461;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qurUnaiVhxBRFKQWVGqGWQeSrVuguRRensao+dV/+08=;
        b=H9pyed3c98Mm4a9CuXEmbCuOaCK8GWrhUD96AztcFKNfmts2TM7nz2QEPkN40NDFd+
         HmQfz33AW0JqwzoQsb2+NG+aZ7gHjnMdIVeZ63761oXKedhv6FaGabtlU+JsOhQcXjLq
         v4VlOGKXFNHp/oek4EjgGOnoHHcLA0OAh+qe30HeqfUohO7U3YxA+kGGGYjYqQHyqbYN
         EohXQFQ/rZUWrKLp5oBOccqP0kAURtdQTrFhKoOm8Qsz8G/NLuDQn2TI+rS0LCbKHz3W
         Bq6Vy681iinOGS+8/r2kSJBpkohJa9nTuJF3Iz5ugub7Gt2v+O4LTxf4FBqa+etAVsyz
         W/3Q==
X-Gm-Message-State: AOJu0YxvBKFTafU4yDkJ81rlzpm01PGVPk83ybvmjJ5ilLqozn5ZaFVj
	dd1yVPaIlwf4QsEUpIDEzL/3go+OWg+CJAIjceTjZ9HOuz/eRVFWiBSY
X-Gm-Gg: ASbGnctjVnF7gB1MzjT0qd4nNbVDvg34z/dVslvYvkxxY937T87szmXNOlhgHGa/Vvv
	EKTWukYrSim/u5CwujFv0cq1p4rBBDVACjG/SIj1bfplg01BYgFzXF0clQbqgKyaaGWk3GIa03H
	ZLHXbqLwz5WBAhj3PhOsfR9fVotMAZ4zSLdrQbFFX7ibgEzBxphwUXdDsGqllkWZzBMFkhBd1oK
	7/N/YiG2rxVwrnSvZEv67lqswWOIoOMwTUWOLLTxRwCEzGpznCA/FtlT5OBwwrtdBfUIg==
X-Google-Smtp-Source: AGHT+IFen4aTeI7HFPw0gCsPERYzZU+lqlvesz5j/lK10b09u+nQcC0wsuq34gNH/Hub8vQsKPUqIg==
X-Received: by 2002:a05:620a:4089:b0:7b7:142d:53c4 with SMTP id af79cd13be357-7b9ba81273bmr1754854885a.54.1734952661038;
        Mon, 23 Dec 2024 03:17:41 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.104])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac4ef0f6sm375976685a.123.2024.12.23.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 03:17:40 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v12 00/10] use bpf_iter in bpf schedulers
Message-ID: <7d535ce6-e8bd-645c-9ce5-c7209dff9173@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2024 11:17:39 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/12465256755

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/dcde3004d226
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D920379


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
