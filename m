Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2922537A845
	for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 07:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050078; cv=none; b=dcyWjKmL+AxM8os/nCObETOyNXOxiOJX8XH1enGRnXAlhNJLZ4vepF2tDCeyio60IjdI2+mwXtuNbxinqAEUAPz5K1x4BN7pmju7U1WUtMI4cUFYKjnICKYfveBcy7TIfGSUkaktXGWBAfbUv+dN/SpP9Vvc4jYSBC+TFZXXI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050078; c=relaxed/simple;
	bh=8D8dYfjDBknIN4mK6I0DK9EGmlI77XudE3R0O/5qG/w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=YBAPJHJLZcgcHmVMDHcDre5/EIv/ABNBSiDGnKKI/G/U5mHyUSksuHRVEr4dQVQH+IL4EOdgoDxiVk/ps+8NlxJ243uZZa2O6WgL0l+XBXRcRCkx1fafxB2mrXFx99N8vH3oZDC9hiEBsx1mgbIjxEzd/J+SqncMsj+GLsCmN1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4GxvOYd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4GxvOYd"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-517dc520840so14343261cf.3
        for <mptcp@lists.linux.dev>; Sun, 26 Jul 2026 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050076; x=1785654876; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ffk4zjFs640x/dZLTNxnnMC9edJ5uw6O9Q3T2ol0kSw=;
        b=F4GxvOYdDAKmAa8vtsX30pzHnqsN64XSXx6zSZbgJLxUALwDPMd17zCcsTxVWsbz3j
         5RQ6WbqBya2AisHddl6/7VswfXulOLberXvf7R3bns4EuGP90YdEmxd4296C0yWyOQr5
         J6fV/EkGdxLbM6bV4tU8GNmdyZKhX+d92T7vROW9KJs/kJd1YfSYTK7pyY/6fuYGHDXj
         5e4anQGfhxnwSoDhPtzdDks3AZc7D/RE6n5BFszc5irUr6Pk/xWj6GoGN2zm1mQrx+ut
         pFlr0QjvXTi6cEe2/Bbj7q7OOXRMnF3VhBP5knET9jMgpjPbW3et+9Wk0maM2rv3kI8x
         05jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050076; x=1785654876;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ffk4zjFs640x/dZLTNxnnMC9edJ5uw6O9Q3T2ol0kSw=;
        b=QCY6bMGUXW9jANQDXqQNjtuR0/DgMXNVU/vwYT3iYbXgHAuDW5broaQe1hrqqRbSv2
         CVMQQz9o4vM5omDZe1XVxNVRHjuxrtggh7U4yQRM3qPvpYEg4J1s7IqeJyz6+p7zCsoQ
         1ekTTXNHYfPe0JjLo3k403zEjbWzG2gCu1o7eEgE1rBZgXqfqkzrNi+DwSs1xXeDdiBQ
         yuidcDoaANGVY7ld0fnFx7USdBt38Ahr36v+k0w5bn55zD39hHXtly4Ug0Iqt97VQ2dN
         xrHuCcCGcPFm6lTcad8N3p1FUOW66/5hUrmM8lSK7YuCPdwEphA2D4xk3qDegYpSuhQK
         OIgw==
X-Gm-Message-State: AOJu0Ywes8mInvmCDBLv8lxbVzxtPguDZuDVCEVts2Rn7IgkObG5yAkE
	9UUL9WqLi5RrGHdHOE+4s3TJrE9AXdbv2NwNBKxMSGdzpV6DdCnC8KM=
X-Gm-Gg: AR+sD137af9rX7Og/HeSge83Z73bs3Oh5tqhzvWv6IY/6OKaHSzdnVic+w4miIS27wh
	FwRb7GemrAuFwpDGXA43AiV820f4phMzWBL3yIk1Xzi0XXLV9jw+cyTHtkiicKNCd+TjAJ/OYDR
	qpv4WomMCCs0oAlsRY+iKP+kAmgny8mJDUzhP9DwNPbw6ZLrL8LCuHRQR/v0i4/IxE8BeyVGBpW
	Ku8jabq8LCbzZ0SbQyJAVm6Rk95mB0zFuLRZmTBFkUormcGmuHq+piaq7NdkD1QxapVSpYYNjg7
	z1qVr/jSJ/cKMDM9XEN/Onezc3t0u56NcLBOD4PubgGuLKhi49rAr72BWkUFyJwM8fXD7/JuFV8
	CHr+Gie1uO7rcOFU6Srr1wWRDbysBfTO/nHy1BTYgFryUsvGcmzJVbhUYA9L7Rq8JBwzmYOxcTb
	u+ieMrjPsv5/dlNQ==
X-Received: by 2002:a05:622a:3d4:b0:528:3d62:16c0 with SMTP id d75a77b69052e-529a86b1bd0mr47060651cf.51.1785050075806;
        Sun, 26 Jul 2026 00:14:35 -0700 (PDT)
Received: from [127.0.0.1] ([40.79.247.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907e8693f90sm36366376d6.27.2026.07.26.00.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:14:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
References:
 <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next 0/3] mptcp: sched: penalise a slow subflow
 (#345, first cut for your lab)
Message-ID: <0b1384e5-483a-bbce-d772-c9b825f1a58b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 07:14:34 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/301907=
51415

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ccb68814458b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1134545


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
