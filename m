Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED78FC1D
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084219; cv=none; b=GhmgiUq/hCabgd4N77ecFfv2TQLLbJzYSC1lR9hcnLS7Ez1pFZgflhd5PUyQoaiNNyseSHmW2XxFvkKjqqJtdHnE0s6KlnKp5P28l4Dm6Ie71IVx4uVWBVKz/+IZsRaEhhzkGG5VgN0ps2K4kwhqNMt6jR3kjO9UgET0G+tn0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084219; c=relaxed/simple;
	bh=BtGlbtnBu2IYl3/2XhRUWUdmnTvAl3I8Rmadj8RHOLU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eEbggd2ZNv24jAMKIj6R1j5X4v+A2JXflxRtxLCTGvFLgTwFm8V3KOBKat4o11bdmeQVxLk4BXeqO1hIJ9Qp9dpvovMQDg2CwaAuoxlezrH1FhgqxUtG98kLU7oZAB/2IUj3WTrr6RMLgTupWGNFVDSgBVXR0NAmPxgbCso9JmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGpgA+sZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGpgA+sZ"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747e41d5469so194817b3a.3
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752084216; x=1752689016; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sg32kC1jvvfq2fJpwfC+kA+y9JbwnFt2f/7F+cMQug=;
        b=OGpgA+sZqO3OIYWHTIn6W/jahFDGIYjHdCG6DsHg6xi8q2/L4tfnxP/PbZf4NlRGft
         fiqkkNrjE5ivBE1vErWrgHFgiq1nZcj9XMBkeRL968uCI3UBgWAxhqSDZdfUk22Vp3e8
         PZpxRSbKDiaTs+TZpmZkRrVq5ZUK02hlPG+Fbqme4jkLpPft7iHswquQO6RRFM12JvyQ
         sAkNwmAtqB+Tz+Yi7/j+AR43JHbdC+k6SJ6DdDjikGP/VODQw6tdiEhfe7rHeOsmyFgu
         9wH/keSze4wbYO4CXNE2mgZh14apEzbfT7SLgUkewHb//5jx/Y9HYpOZbBYcCYeEwR0N
         IPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752084216; x=1752689016;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4sg32kC1jvvfq2fJpwfC+kA+y9JbwnFt2f/7F+cMQug=;
        b=sKudAOZLuCWnd4TLLFBOT6u+79uRyv+AKZauw6W8IofcLHZGec6Rcbu4NzGMopaXKE
         l71OIVYiYAPcHZCxtAHp5oDkQ0b7qvqabxObZ3ORwx6EVaLP2FawQc1zu0/ZDJHcR2FM
         48I2bZ2xPJ1vSaIRLnLlFM0Eh3xPJRLWfz2z1AivQ08vyRg7Ot/5K81eDPyAPCRFpBHm
         tIdXrEuT+R4T1xJASj6A34CZswR6S+TiZMCyPNqGAIViJ7IXUc7cvikGmaB5YN8nSx18
         D53zZpASFvhgJ5oZ1KDD9v64bZpbIJaStN+A8MxXUBbZ8Ttn8khsB8SHUlZo/K+kofdk
         ivxQ==
X-Gm-Message-State: AOJu0YwFfhL4sFt6xcbXpc8iAKOsz0rScIsk1C1ehUCURautKItvDhU0
	LPP/6gVWNeFz0nd977nx9bOGWXBauAQirEwcZUn+NybqbTFEJwqFXNDFVTPU
X-Gm-Gg: ASbGncv4t1zAa2zAuw9JUcRhCnkqvPfqngh2y4cx4gOqfwjqLOp6ytBruMNjemII7Lb
	0ovBnXaa1MWlIdI8IQ36I6EsmRSFYTcTp8zcZnsjKK3OCzw9NargwFZNEqExyo4z4zJx0kFfAnY
	Ic8wB1EyxTWxFAcyltv2AN44ym4/c34YQTeKiiaGtEdpJ4TxUjGz3LWmcAjfbUUwLnT9WwYaGW8
	CMAb+IEPtPZQfUKrIOf9sE2djbkh4exfedvLyp1g1oKm5ixhDRh3mx8UB9513yvne934XT9stjX
	Bp/Xbv9WZV50I0N/nHAJMxQ0La54U4yCJCjcHq5k71h6VREoQwAf0RB6eMm9nbmsK8//+pPKvPo
	C
X-Google-Smtp-Source: AGHT+IHtThsNl0fbk+s01AEKRfdjdSFHyjLKeuK6+64dIccNeVS5i2oue9+Of8/pT+la2WLmTURdPw==
X-Received: by 2002:a05:6a00:3d4d:b0:748:f750:14c6 with SMTP id d2e1a72fcca58-74ea6649684mr4455198b3a.14.1752084215697;
        Wed, 09 Jul 2025 11:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([20.171.253.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359d315sm15230031b3a.23.2025.07.09.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:03:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752073685.git.pabeni@redhat.com>
References: <cover.1752073685.git.pabeni@redhat.com>
Subject: Re: [PATCH v3 mptcp-net 0/5] mptcp: fix fallback-related races
Message-ID: <24c6c63d-e719-ac2c-3223-818f121ec4f2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Jul 2025 18:03:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/16175222973

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2b0c77e07efb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D980585


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
