Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEC2153F1
	for <mptcp@lists.linux.dev>; Thu, 24 Jul 2025 08:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344421; cv=none; b=Na+rmC+6UFgD+cULuxXxKmHu9rX8DZtsoa4UvQ7w3V3U+gtE7TQ5KeKHwfWkWMOkqzYpt9tG+Gxf7j4TUfnm+SVd70X+GR9K0Bdu65T1lXzW/oN5SZAaZM2bs9GoYHkXPiAyxwbkcLMMoawhsv9g3rFhFFHr9IuLet4E3tOqrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344421; c=relaxed/simple;
	bh=OZFOKNK5YtJkVgXQfgqv+EfqKToXvIfMA/KUsVdX8TE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=rnm0Baklp220I2qnX7gVnJv+chx8mtjLSjJnNzBLb/+Dn8sAdwj/sI5ozEXvIUjqeFPlO6NGlrNYsrRTRKXGLAzqE+ZC3VeKDpCDoK3aDds1Kgkxmfo5qEVNAgEOIsnOonCbc02t468sqMtMk4T+sKsac4yZw0PCWEYPXGRS04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndKEkX4B; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndKEkX4B"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso9968386d6.1
        for <mptcp@lists.linux.dev>; Thu, 24 Jul 2025 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344419; x=1753949219; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anpcGybAk4WLMFmK+WJAtf8jeWA+fWpfnkS/jWbgQWw=;
        b=ndKEkX4BA4RH90F6Y5JGWAw9f7tdEPkk4yU7rcv6wIIQUdVHPtFu4BVOFbz7UDcbGL
         SMS156uTlBRwyTb1kdbT6INkfpMjn7ZHdwiC1SbjB/ai8T8zSch1tSCn68zYk96Zx8jJ
         ooBojpnkQ9ptF/6p3SHb8LDrgdR2Qwkrxh5tniTYTpnADqr9W1UlX4/tOGJUQ7qeP+6t
         u0VBtRfSRLXuPkJYnkGP09XodvhvBfzJgZIn9SUZ8w0LpKIvCChSa0lhOR2+aeNnh1/x
         pF0mwzvGQrbWl0C98w6Fl3SVI8T5VgY0n7j3BC5bYeMrQi9xFZBFXE0DHY6cjuTnwZQE
         +GPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344419; x=1753949219;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anpcGybAk4WLMFmK+WJAtf8jeWA+fWpfnkS/jWbgQWw=;
        b=fz8w8637NVUYby6crm66Hj5OYNbagiQ/VUmgkFdvdgHxwKF3LY6lJ5DWSdoYtiT6Li
         g6rd03srZCcjAG+drRU6QTV0osr3u7zJImUyFh31urqQ0tNvyXSt9gsfgl8wpOijQyHS
         S7xlaHpXYokvDhzs46/UMLRc0T8OMKdE8peUKYpMWsIDQ/ND7xRGuIB9C/mdUqZ3eJlj
         FNQ3TYjLgQL8X6lZJvTvHdlQhKgc2c1GQZhxu6xN8wjzlver3U3eBpSM7xo9VQ1z7Eu1
         hlDfDNgqZiemXMpNARaPXNSjpL0s9O+ilvIoJwdRGOiR5W69KTge22gVZ4n1kLNQq8dV
         Gp2A==
X-Gm-Message-State: AOJu0YxM2IEips8sKsH//3hn+UDLI8PLNumSvihGjvIypXZp5PQ0clQl
	yA+yMRmesFUeztaLpmtJG5QsIfNZTsxycaB09pLdZKV6bNfyM+rquH2RgtQG
X-Gm-Gg: ASbGncsRdpTBfvRlqCW7z5+H4EeE/AOka+kwWu1N8sEA6vQdY7pOA9tyavbk3Xo/B05
	CVBYt5nwY+J57OJby2TZP+C0XZsn/jGIAPTNLkh45QrRQdvyT2YoDgewYntEnQW2D9eeg0loNwT
	8wnR4y/z7vplQhb7iPEU3vsHyTYdnrvM9Gkf46a+alsAVkveX9Etv4H50BAUZT+I65nPOTzq+1X
	zyS/c6xN9emItDktSEKWxPHjJdqCBUtzv6Qfi1eLEk9ULphRh45P0m1mnLfvR8YYxQkFXKV/yLZ
	4XyEn5/BdUdokfWX1RwM0+HDmoHbxG39qr6hGem7M+iLSyqKohzj4Me7vWJriXHTL/pRMOiiOVB
	37dptV4mySnuW4HWNhVMqqr1bKUl44wVSs9o=
X-Google-Smtp-Source: AGHT+IHAFBiOiiA68hL/2/wpz4tbr37IgKhZa5Kv9695HTVLeTbOCpEAbSu8IIIkSoZIVbT9MzHdrw==
X-Received: by 2002:a05:6214:f22:b0:707:102d:9b5b with SMTP id 6a1803df08f44-70713dd7128mr10521706d6.23.1753344418815;
        Thu, 24 Jul 2025 01:06:58 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.159.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070fcf227csm10103236d6.100.2025.07.24.01.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:06:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn>
References:
 <9c663fc37767d9036379afdbc83cd8874a7b2fc9.1753337130.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: remove redundant orig_offset in
 carve_data_frag
Message-ID: <596ced53-6bd3-437c-739e-4d38530c68ed@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Jul 2025 08:06:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 1 failed test(s): =
selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: debug: Unstable: 1 =
failed test(s): selftest_mptcp_connect =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs-no_alu32_mptcp =F0=9F=94=B4
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/16489452196

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/981465434acb
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D985365


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
