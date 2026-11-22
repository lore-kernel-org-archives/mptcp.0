Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795326896;
	b=NlogKSL1IlUNieiG63872lt7AYH73TADs52wnnpx09bsR7UvPZqjnp7UZTYaDNoZp8Pm
	 XGADoPsh/oq4E04fIYT6AQD1e6suYsC7F+ADcx64iMkCVh8wjVYJRfVKqKPZr/XBbs2H4
	 P7Y4Dom64FlzD3mxFYArroFqzl6pmX7qWfN8iErtH0zVIC3ZgwUHSOuT9V465Z/DSftoc
	 +YcUHx42kH7QMRMCij6HEQgjhZQ6Vvb00/buTWYhP72PTk55oLaPEFGejWeh+QeLa55GQ
	 8hIvDiBk6X183wP+m4T4JPt71vdqNWY+lBEVa12kvect60lS1scRqpmpR76VGQ//jgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795326896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=/PwHLqchxmUyNdbcuDch+RzjrO6tEnvM8JHJnK164Ac=;
	b=2BP6f9WidJhC6SHFWx6GmRu3MgK/oSKCHNb0Oyr75DM8BOTjk8He+7fnKpjGKrd0idae
	 oX6dIgKB8d1U0dqle/0xIlpeEiPuMPyDU3Ea5yymdrRfhf26mhLkg91aXQmhMAM1KG5j0
	 sqjy8GmV2dQkw2UDlfL6CMnjvYkshbevRPLz8QSMcwlTpkH9t6UELUSzKlkGVcBwIco/L
	 Xk9TRte0i9gdflrkLTMyE34cKrPz/Z4KXj57EdB7RLsm/lmi949+07Qc1jWbhixFYtI8M
	 XGp9e7ipcNhN3FEC/ThNBs4bRf+/iiI839UAXpSBw9J2Ya9u3RD06WzK3BDifhwNvQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PXEtnHFK;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD246606A320
	for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 05:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD246606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PXEtnHFK
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-55b8cd4e2abso26665621cf.1
        for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 21:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795326895; x=1795931695; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/PwHLqchxmUyNdbcuDch+RzjrO6tEnvM8JHJnK164Ac=;
        b=PXEtnHFKsgul+9EfwoZ3mI6s/I6HejzYNu6Jo1vt/EL+n+pkNNcofOHk6Q4kE4leOr
         jU1yX6NDWajpj0gi+bCiyiFrtXZmPXH8/qWOEGnDwjQ7/KdGf4xEnTZhPVQW8yDRSFdk
         MpOMVSvznh30zhq0gIxWDSV3o7GjuzwTvt+rlpuPIye1iVme6G5gof1cIdV0joqvASWY
         6i9rBLCEMKyeV76YkBSX/37pCrW567ILnwi7WJvTBGDsZzDT3zdyoJHULHwWQYZI+MQG
         /d4HGoTw/wrCNUzTC2nHKqoyiBaVCe9qIIsHvZf81VGG/yix2Cx3jKf5HkunSZP8x1vh
         xCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795326895; x=1795931695;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PwHLqchxmUyNdbcuDch+RzjrO6tEnvM8JHJnK164Ac=;
        b=X2LIGyWdQcZAHsL9dO37GTFi15EW75zuOf6UrRUgF5HdecPyPzzmEfOsIMXcctoAFJ
         pAbdx5pfIYDjdXq0+7wkD2NkltCPkEunsUt0KNx50Wj8kwR0HgMUEk++9Q7OMoPkZlXU
         D24y7XYYqMudppnOu1wMilw55Gh6kXrLaCDjgzfrfQ3KihK+BfaASetOvJYv2yKF0xGw
         BtEYSYJ7kX56olSzOr3P8BFEZS76QKLR49xZgphFAMCy81x5vU9e8Wog29yhEfp0gx2D
         GzEYrg3rSX5/vyzZZW7syJUH3rDyy4RYURKa4FfFwHxEy513ezuWVt3dPts4VvqfjFcZ
         F8Wg==
X-Gm-Message-State: APuU4Z+PztdHj19rRasTdKgdC5lpwfANvwua/8LNkEmGx89F40cJc2YY
	3G+CMVn6V+mdB3EICg/inJBEHn9xz/dtydK8i0hD8ILdbQwg0hh3kvJoVlAn
X-Gm-Gg: AZFdTZfW5WC7Tbrxo4PCwj9bAiplDkuMX2oO41q2IRywF6SzlbTevO+CjoYV6ZskCIa
	YGyUrMRALkVq70UAtpXwpkvk1DAs6m6ZPLAJX/mpoJNyGpddTaYbMnWCX4XMAUGFKU5UHrm7mvw
	JZi8gAeQQmIa31D18x2j0zUANgERPOx//OdVXfs55J5aiTNmJQJHwltdzmdE3OHhw1Ijs4VxKGP
	D24CYHf5WaAThqN07cFlN2WcILOGrf7pTCAkAjH7rtX5N2vEX8/A2N9drXssWwDvA1TsduNBy1Y
	VLJ7KNABE5xdHXLtyiZiX5iFR8QzecVQ8LQqRsaEmmZeDrwy53n+cFsuSLUSFKK4eZZDPEQ9rqp
	g6h3PYmWOW/V1gwy+p/nxXCSFlgrnqyvWI1ZMIdviorkqzgIW1+xqZYu+CYTiCZq4CQkTMCFUUB
	brLlez1VWAojCna5P4w0HY5HB2A3UFv5d3rjJMWel/gc0rw3oBBr1Nbzdie5F4ddx6/AKJsFJ4+
	YYPG3epD0Nnt+9yZ7q26r24VRmXFJldsNHGfqJfh0TPvJBEchLSKCb1Wqib51X9e+BMzERKSq4s
	HKkausY8B/Pbc/R77LMbzuqp9GmryYSX5i2V83VbOXDpMjFBsMCaYuQBuvMVklXt/Mow/XWz+Ql
	PjlengXQ=
X-Received: by 2002:a05:622a:17c9:b0:55d:6e81:2034 with SMTP id d75a77b69052e-55d76ae21f0mr142633681cf.44.1795326894643;
        Sat, 21 Nov 2026 21:54:54 -0800 (PST)
Received: from github.com (ec2-3-41-210-68.compute-1.amazonaws.com. [3.41.210.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a1d948sm70610856d6.40.2026.11.21.21.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 21:54:54 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795318567.git.tanggeliang@kylinos.cn>
References: <cover.1795318567.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 0/4] mptcp: fixes for SIOCINQ
Message-ID: <05cf2f5c-e231-aff9-a50b-62a8048374cd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 05:54:53 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 5 failed test(s): regression:sched-bbr(36) =
regression:sched-mem-pressure regression:sched-rmem(3) =
regression:sched-serverlim(7) validation:sched-loss =E2=9A=A0=EF=B8=8F  (7 =
improvements, 105 new outliers to review)
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/44983059580

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ea481c424b80
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1218409


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
