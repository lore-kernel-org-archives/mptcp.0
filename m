Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015513;
	b=q5UnAtoz945mLjaV/q+cXkhmdY2CrXTiHhZ48CIaS5eAraLwiKfOYZoxSkuSwby5wrnV
	 1ILBCp8XIMVJg4MXDV9jR1lv40sTFiGvlk6i3el/hHySLZ9SpIqa6M8o9zjDRWGPJAUcT
	 SUAFEsOlRL7oHt4QJh63+rIRCLboNlzGf8Xhm63g9oywY82nClEY0Hp/MoYgHIK1QPVI1
	 L8Wa/De2UcAN5QIhdzAJwZMrcvClerpCs/iJV+F4sYhnvczkJFHxHzG9+QFcwASvGgJb5
	 7ML5Ftm4PQLgvwkGQY2MW9aIVMIXJ4dA7xKeK4BChJg/HaWewjQweg+vaFV2Db9/oDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=1H/Vc3ECaKZp7mIVfkW1OwXHrAf2HyhZS6YkTf0ivCA=;
	b=btAKNig9EejXFk1nsr6hvfZn7toLPgGsoOy10I0C68TxF21pKLJlBGS1vdhsh2Yed0LV
	 23AWbRV8Zkr9k6cSxciPQbOT3uTKszctB9X+1IdMXNAYdfsUgBO/1lfTLUz42o4ZLDnzb
	 KYBwNfJI28DiQQzbfgkDONjviNOwmteMj3qUAy5XFPZX6AJe70yKXCrtvv24kY4RmdkIQ
	 25fy+Y4tGwzYvRGIJQ/DSwxjTBJD3KjMTTNsyKUcpEMuzxLQUwcNf42ozdAiWhemx8jpV
	 9eZKtkbfsrb3uB32AzFuB30VJE8PKrhIfLzCwL2DF5PtOcWVLZ2ScDO3QIfbCLscO/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U9lE4kjY;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492E60A2619
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 11:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9492E60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U9lE4kjY
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-53dbe9b8d6eso2157525b6e.1
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015511; x=1793620311; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1H/Vc3ECaKZp7mIVfkW1OwXHrAf2HyhZS6YkTf0ivCA=;
        b=U9lE4kjYvLY21kfIl3EcdAvPDuKTDJ1SLYudJcPARO0i9K7ll3ZB97A9BdfhphvSrq
         rNd6ya8+8mvQa8EY+vzsvddOAlEzLBGZb9Zaev+bkVXogrLIi/ABwM0lQny6W9/H4L5Q
         L+cv54hlUx12+38NfKw+7lRLxkIYi4kagAXImuImvULgFz7ztZ8SnaFK2rWKujufYubM
         XVVihuv/lPD0ELcDZmdcDZDh+90KZV+kJjAaxyI92jV4eTcPAbYWDMsRnGqbCxINL0pb
         hr/6ZRD4G+kPW8UuESL0Q6YdAZL3fRzjxrPdkLPbqmO3VqjtOvt8QCD/DC0LBtVug1ML
         8bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015511; x=1793620311;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1H/Vc3ECaKZp7mIVfkW1OwXHrAf2HyhZS6YkTf0ivCA=;
        b=d0ocy4KroKffxaRcYSP7g0hbX6L7lshCZIJJDwPcI9F303BpPob8BglPwd0DjxEiex
         USgwxjjMpg0MGiJCMLK64lDMw+MDuiJFO8fvmTBGZjYkUgO1aZ6kZo6fZgahtrrgM0yF
         3rzwDlQRJwUINvWkbSVVBV2lJAwAN1Ss+mwVVacPBnIUvZ25f5kiCgH9wICgq4L7U6KA
         xi6W0M9alc69nSRWlyufDAUeCdTv/MMvvcf3G7SWYRhOeFedThLcM7P5zeMG//Ph1XD8
         XzOlTF4aNqaB9OhD7K3fzIr8VjeaZ9Rm2gnBjv7bt4ytMT2PTG/432bqAUsxC21iOqc5
         +hEg==
X-Gm-Message-State: AFq9FYKgI1KYtku8iDJ2I8c+HMegc1FVUogb9R/I9+HEJFMsinfhFJmq
	jvv7Zp8aD54MZapLZuTHwJwLvHpgGJwYP9C6Asyoyl6KRcnxO8wqoFE=
X-Gm-Gg: AYBFou2HwejmHUCZsJca7UiHmVA6x2+IRsv/uqa9t80PKdriWcVww5Dopcb7nl5S4dH
	iouyhcVNmVSALS0nlNlSsquktlBF2YGrm/MZmxEN3+G0FGteZnvkGvSCer6TXFBiGJADCmOpOMM
	w75IHzutO4Pfw50DzBg64Q2OEkDRgFEaumGdksf1FqaSN/UOBOJ6idIBosEHy5hRKA7ryVi94vR
	NiHOgxTisVRNBdL8DrGX+k+OTihh94MnZ7OM61lq4Q7WVMR/Fh9Rjbo4zc06MEhWJOKD4kMQa9b
	aew5WrA+WGMHC9P5JxF3IzrMAG5WCXjhTUSyO4EbtB2qoZsLnajM+q84K2ho/Zk2bQCfD9RiQMq
	sDp2qH5Vie+wHGsxRGGxiVUrYu8o863t1eaQHyMx3/EQ0pYpstG3Dr6qI5zRrmwDqTnxljXTB6l
	quVtwD3Oq8UMLxgp1n48MgKr+hwUTv3Ho8YHO5RC2Clc0JYUFgihF868m3d3ReFEzEQxPe9nqzO
	8wEVSQgkhGxxKffdj8hrapTHrK6Nz44HIGBBPRVrTPt7e8ZmS4J8K1iTowuqcaXFhAUzHRvRR+v
	x1iY5EISm2qelJ8=
X-Received: by 2002:a05:6808:66d8:b0:4a4:c95a:38d1 with SMTP id 5614622812f47-55c006d23a4mr2294216b6e.4.1793015511383;
        Mon, 26 Oct 2026 04:51:51 -0700 (PDT)
Received: from github.com ([132.196.54.225])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c04311a8asm4949291b6e.16.2026.10.26.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:51:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261026-fix-mptcp-issue-639-v3-1-165485982827@proton.me>
References: <20261026-fix-mptcp-issue-639-v3-1-165485982827@proton.me>
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: sockopt: echo until
 EOF on partial reads
Message-ID: <a0793521-7d4d-2961-c06e-d4b6768df0dc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:51:48 +0000
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

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/40311317868

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/de81d26e21=
ff
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193611


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
