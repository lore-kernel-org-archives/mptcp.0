Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF563438B3
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232579; cv=none; b=E56DzJFhRLzdXwk1b2guo+7AZk2fQISMYp25CWDH7JpOppW7HQE0bM5qlc0gjrAIfeZXjRe7paLOIv4oGnIALJZOd76z9ObBVJGNBRLxNSK0yrG6EPepkmWtFDM6B+0IjrQu9bYPuHg5MODisSRoCaXJGYW81mxbFXAi5r7ZH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232579; c=relaxed/simple;
	bh=XF9SO0CDScRKdAyJBLHeCRWFnCLU2a2UfF1B+gTKfXQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kT2qIT3VXp8oT8ay2hY/+8ftdgvKVic4txDVQUx8hMzcfYxxiyarsJVlZxKaGOnCe44z8I1oq+FgQgHAutecpPKcO9CdONecQdaPV7NGi4vxK5Pzr9e4H0MgOWR7b3XALOQFobQH63hyeBBg5FiF3lhFInscZQDnvxsE3/KGMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbYV5CIa; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbYV5CIa"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b6dd874471so66354616d6.0
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232577; x=1779837377; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayHoq3WZfsTeaI9PSHm2CNEHEw8LC9nMbvIbgfeRnhE=;
        b=LbYV5CIaoJpnI6GRzNEeq1Gnm07Me7P0ANfsNC1kuBxflKOyPAS/pdsNVhdPsECiBt
         DPftn5ne0jBxYSZYvEcA5awdRg1eSHwv4PIlMRDEMtYug/ZeSQ9QbQ2+AFy06SUXOtV+
         Ni/kXWzOvHUgmwFmQxNmVObfrmssG2LlB7HKHWxdQiYjzUktxp6gPGiuVTvQNGdeyPiu
         4TzBrWtrDggcGRWfzmMvx43q4O8e70ryOMOD3+q8qrH0WPEIDeThTL4NJNRp24QRO8p7
         M5StAkRismlsrP6B5EeaphG6DdH6c1YbmYcS+3HAdvtGphs8rW7R1k+Qkb+I/HTMf7xa
         g/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232577; x=1779837377;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayHoq3WZfsTeaI9PSHm2CNEHEw8LC9nMbvIbgfeRnhE=;
        b=SfKKPHcEwkeUeAKS07wuhXDKHwbSlbeiZNs2982meuWvx6FaH4y2If1mpO5/pzD5mA
         QJjT0WqafnTc6B29DNPNtVqpHjEhxwaXjDPWljsRU5VeS1epbSYPZw9fzkUrRjA6DPlH
         gQBUD+VE0wm/4mBGC46eEG4yUWSw1d8xsvPPnPwDTfHCAk0/5lLnTDw0ve4Lv8PtVN7d
         SvuPF9YOxd73gWXgAkE8yGCBIie9XAuJ5+kUsT4xAxYcDT7+a5Wrv2prdcMpHUL00vPL
         P/8K0zpg1wAp3/JAUfetljuTDvzQmFfSYVaSNxA3/FIv7+PP88TD0RdxpUGSfMJjZBDz
         HrPA==
X-Gm-Message-State: AOJu0YygqcrRu6MmMEIIf7La2zdwc+sm7cqIS21ASBCRqyn3XKhpaMQe
	ClwgNbkz73rnhDSEIOe7hIkrjBmqWyI5zy2iniWckm9jji4n6yLEqhmdp/Kg
X-Gm-Gg: Acq92OEdLHgta7p//EL7q9isyi6c+vB4OT4TesL9LIfLobdwC51iElOJoRcAqFMzXRu
	BG1qdnI5ItC6NE/NUaeCCv/gvpVmgEH4B2J5+9pYfvQiiPZWGET75yuOHulB1IpCrWJAsEvoVKb
	qFwlj3e1MqDvPhFE3CwTcEFJtPzrbPLXoDUr8DJcesmHgwXdZHf4Mj9XA/ZUKr0VhC84OEFXfM1
	wWl3wLmwtnWAQz2QXqlT9qtVC7A6Sex2cJgRCYJBnhljU1a+Kr6Jgkp3k7xtuIFKUBe/fbQ5tMc
	jXZgv1d+u0TYqdfKSaSEA48eDjxr1WZRmq8oEaM9i4IiABpjD7z0fGHhpPiui+DrZeiwT6NMG5d
	e7f+5J/c4Y/EpYh+8Yj2ZeZWoTFdYEF9xeSnizlmiqsdRdQ58MiBWKOvNQYgtKqAxbuwNMeE+ic
	s+ep/ae6omAnjPhAh0y/H3M2vKtHz0y7xokVYm
X-Received: by 2002:a05:6214:5b89:b0:8ca:10b2:d0ee with SMTP id 6a1803df08f44-8ca10b2d52fmr276810026d6.17.1779232577492;
        Tue, 19 May 2026 16:16:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.239.102])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360979c2sm106156756d6.18.2026.05.19.16.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:16:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
References: <20260520-mptcp-add-addr6-port-ts-v3-0-bffa658a7678@kernel.org>
Subject: Re: [PATCH mptcp-net mptcp-next v3 00/16] mptcp: pm: drop TCP TS
 with ADD_ADDRv6 + port
Message-ID: <f2197a42-d3ef-b4b2-6e9c-7410fea2b391@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 23:16:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_add_addr =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_add_addr packetdrill_dss packetdrill_mp_capable =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/26127754617

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/5468c1adc049
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097625


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
