Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028763A545E
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124142; cv=none; b=nr6KBOnZ35rUC1n/MSRLAgIcFIxScqKp0LQTJGD78/jIbGMwnV56791HB05RVysVgQrVuY3TL3y3v6wr3KuXpJEXD5vdsq3du/Jz/+zuByGnC+6ODWM/97BrbCNDxvH4WHCq/WiT9Rz1qK8J+s61V5MWT7rRWJXCnNhNUEhGm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124142; c=relaxed/simple;
	bh=mDWwUjlUZNJRoDxdBA9tmu0WcRa/3dFC5NXobvxTTPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GAgqY99i+AkM7qj3LNK35tfIkqnO3aWFons5pgAB6xBpnsxjIV88v5UoiZs0jAKUjPncZn3XoNtzxdSL8s6f4S7OLrNQddpDqnoOJFzOkzS5pGxYxrA1YkUDZS+ns465Iam+HdKpaP9bhfA4jUe/SeCsBLqq6ZqsRRFm9Y2AiKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwIT4BdG; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwIT4BdG"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8df26121c88so20615566d6.0
        for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 03:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782124139; x=1782728939; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqXvplEn4x40o0jYZQFdqM1g4svhVlLI3jMkHtzOkos=;
        b=KwIT4BdG9MTN5s7tolnrSzDbI+YOksJuVW31eQp7SfTwMY0su8mlw+3/L3gyEpxz4e
         0p0NIrd7RHFdK3ve0XKoOZsADKEtc8oD3BJK9z/117b/oU+xhkNjiZoNFZBYxF8gUj8C
         Dt3pn/SHLP60o4DzDa/FRvFp0bNfn8pRt3xGz7tM/Q07Zz1C34Vx4sgH+e58LPq7aV9S
         dBv6UiqfvVgtAUwwxTXky9GRmblf18h4Utqb28qT1ejUMaEFPc2ATUouxSLXsj3NMLHd
         x5Cbds+7jStFCb6Kef/3RFnznvjHAXj2nJ9yRFuOb4WyToxyJPuU6wxbMhXQyBEgsb+Z
         nIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124139; x=1782728939;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BqXvplEn4x40o0jYZQFdqM1g4svhVlLI3jMkHtzOkos=;
        b=EEjW2DXSaSGXDdEiud+dzOLIa+KGfmiOs3n0ztAM2lG0gJw2S++mNGddif1scSpGAh
         A5MYp162A3jcCKqQ+mE4h8Z3YFp+cH/I5LEpV880PJYpBvIMAyLHlDRd+3m9QMuneWh6
         wRz0kM0m2zzTDXSQwAghkHGhTEb1NVOsOA0/gtuoCZiHMmt0ZuSVv22kRG10phZnyUj6
         wLH+WThCFRfCG/7L5qiSfBnr8VRf1QSUWjUOhY0SqMM0JuyE/DTFzJqJKq3Kpxp/Hub+
         hyzfRmH5lXZAocsC10cvcwaZIcJfqGdzdCSjYq868g+kA1MlkAMWlasdxypnI5fp+Jyf
         7f2A==
X-Gm-Message-State: AOJu0YyUg+rUoHTD1U2IaBqBgQ6eN7NtUKzW6WBEDoKhF5UoLCVVRL9Q
	rn4JZ8ALAzalOcrXPj6v+PPqEM1g29GdmYjquFYgzAJ1yviRdggfFhHhmM6M
X-Gm-Gg: AfdE7ckHMaAjBBCCmnDiV1Pnq5oqF76tfpxtdIXYlv0ifvPWQnJu6yOwLC6dYFsPhUJ
	b/ikkrQKGCZzP/o18oIoO1odv+4nVgR6TQqKkSDqih7o+JFgZojJldmZbxsCY2VS5HX3ZLDMjiN
	3cuIQoqCMP5RELNVmvPJRQtA9vBDH6ZYf3M+Lbb+DruMitjb3UWzc4h6X7lXriP8mXP1HDnaUjG
	fg3ObgEQobk+qK0J27JhyXqcK1HAvXPsMs3sDCpI55wjw/9CPeJVUMSNtYaYZc30zcR/aU8CgAV
	2bOP+bZbujEPSI3ptfZAsaFXFzHiBDzjsLZybmC3BBLdvtgS12wkvPOoLoVMYXQp4NTPKJqIKY1
	goksUbojUMPtkemuvkgHA5J79IEtLn8dmja/FokNrtoFZfEqXliax7aZ1wgky/yz0mMVMUJzRj5
	wkw4P9vQJMnsiv1M69F397fa7++pMV
X-Received: by 2002:a05:6214:4599:b0:8db:9981:662b with SMTP id 6a1803df08f44-8de3b43f9cbmr225501206d6.3.1782124138845;
        Mon, 22 Jun 2026 03:28:58 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde9ecsm92662956d6.24.2026.06.22.03.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 03:28:58 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1782120674.git.tanggeliang@kylinos.cn>
References: <cover.1782120674.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/6] bpf sched updates
Message-ID: <a82ba82e-3b34-08b1-39ae-4612830314ad@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 10:28:57 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Notice: Call Traces =
at boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Notice: Call Traces at boot=
 time, rebooted and continued =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/279442=
47890

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/526ff6453267
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1114644


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
