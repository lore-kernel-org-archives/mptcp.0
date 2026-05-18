Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E81C5D59
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113316; cv=none; b=R3TsRAnU5Ehz16z0t8e+RMTlNFAxiRRGm6uVuU3pUUYbSD7Zdip8vCpgqgaWF4lfHNc6X3jYm4+58tUhVicLSpDhGPp3W1kce5vy/jit1oFdQkQvhr7Zd6osjVisiyn33z4LCeks0POuLHF7PsPJkhxTyd4ya0301/MLggVP0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113316; c=relaxed/simple;
	bh=qOebTyGr50sPrpp8zkDlG7u6+mlhowna7urn7JbpIGg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=A57IUxgG8qEJbDW8FSvWxJD/UHR8t1WlyU81mvtvDGp5uI1JBNO48lL/rly1bDzviaMfAcFwBjx0ZcAS6BveYiAl1Y5PMkATpr0jukJXFUEgz8BIgj/CUYtzz2zjs35s27IpjmkEkhutMWY3hugOFDgXsvKABt3MrwMfuSSbY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYWouOML; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYWouOML"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f7020a928eso3173210eec.1
        for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779113315; x=1779718115; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+iWlS95YMEXpc3Rp3YM8Uceyy8AhZLo33FdFfFTaC4=;
        b=aYWouOMLsPEAZ/lFcs4HdNYANFlweO2y5iS4e6WuJ95S+Ly+WHkDRqoq7qtwM5DrSr
         KqELa3lUpdFf902Pf6xp+b9LiCyai+pPWU39A8zD89OkRzFXF2eut5XFLnzULNoT0CYK
         byvT3WLbhemdqihXRrdAzY+YMMJzFqAxvJAGRGj53XYGO31DH4mpThL/JCT5wV+e8crI
         +J+gBNQOBcdUJZZ4QOl5ZagGqJHUX3uH+3y4PrMFPT6KbzZXDATo2t/a2xoE9fSKTsL2
         w86XXVWo6Iza6qOs/pyxLzwkpxZDAidJnEGRFrvNk9mdJ8pBFdBa2YMLZAscgoKX6N6u
         YvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113315; x=1779718115;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+iWlS95YMEXpc3Rp3YM8Uceyy8AhZLo33FdFfFTaC4=;
        b=TaGUGAZ6r+apDabnmitehrok+hkd4VnH5987RJ9o58F8TNVQtEoQ6Eer8VFlDgsBBu
         HnyYA6MwYrqWIBCsdOnA8vh6TCXdIgFkMsuMZ0YwbKRGT90P+unTAfAN/5ThN1M0yeMN
         AWecaU/B3TyRR9HL/UxzETcWhHomF0mGyYkcs23Fbiv96/zdWJvShWeisU5aXzVND9bu
         awMsrpwa/LCaqka63IyjdK2sBVTDdm+J5Jw7Z5FZ+VKorqNeIg/agCZ4HmxLkXGy+8qA
         3taYItFv4NfLZ7wYiAaiZvsNDSUafu5cgm2xvkNfNNlLyNx/4Rvtiv4yDWwQGYb66AFi
         sGTg==
X-Gm-Message-State: AOJu0YztYsVjrO64mkMgpVrDxt/+Dx8GpxvIbb5jFYi+0Q4/AhntiV6g
	5+Afyf5L2unQfn2NmIy6te7uRSTPQXCrTbqf6axf3mTylTvcaj1EmUe8RDkJvjU=
X-Gm-Gg: Acq92OF8bA7YxVG+05D6gxqIr/VfgKbw5wRtW4vdO9YxGPlRAQ5HLo5RjXWeVjvPe3l
	SA/rVKMulph9ZKjsq9bVUpobyIv5JlHXZFO4GKkSpu/MlfslwNmBj8EQih4sFeKJdTDLk5b+7ZC
	r/X8WSw7oKtidv+5cMM0nnt3Iow8CUTmXd82sB2n9WdBb+dnBb/AB2uZwzdIKLAe6447s/PYJrc
	kySMQo6uw1S3W7xVuNUDYLfP3roIiW3OKKow1PdpE5qWrDTJmkK2zXCouUopQmnw+MVLhuOeQ6t
	BJHsZzR/wsKmDtkQd5Z4fB/0j1X9MjQZgdl8FNaWBtt4sCc2VTvY6o5phZY0EZY82E0cK7++275
	hEzjjmg5cSYz3wq+MEz7QBEKkDIHvZzs2F+bd4ckElpvkamZFml8Xl/wXVyp5CD+qg7mqq5QMoZ
	v7N2EDCUDoa06AavKAnCZ9oH+sE5VThbp4AYsq
X-Received: by 2002:a05:7300:a505:b0:2e2:4979:eb5 with SMTP id 5a478bee46e88-303982b2f85mr6224784eec.10.1779113314623;
        Mon, 18 May 2026 07:08:34 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e69esm17077355eec.1.2026.05.18.07.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:08:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
Subject: Re: [PATCH mptcp-next 00/12] mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port
Message-ID: <93f0e257-e8ea-9ffc-801f-ab1ef6995fa8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 14:08:32 +0000
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
- KVM Validation: normal (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug =
(except selftest_mptcp_join): Unstable: 3 failed test(s): =
packetdrill_add_addr packetdrill_dss packetdrill_fastopen =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Unstable: 1 failed test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/260357=
64291

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/8c6b19eac4b4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1096601


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
