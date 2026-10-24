Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821899;
	b=SibKsYwudNh+YTRf0l7UfwchRjCaX8pjHAtJo163Ws7PHhldFxH7Y3ljtRLxofD1CnuL
	 LBQYscZS+JQpWvy0h9qWlCMpl2Dp+p05qVukA89mlAFB0JC6FPZ02QOWW/pgR7xhRdlPJ
	 +n3qOdsoEegF33GMV/tYpISrhwYXaXqLBuWkVPFCFT8+Vplj8kH13weT52w3upczFbeim
	 2wUyax7MEFvJf+ckqoKQSke7OvOt4fVh6EOqGee3ufaDoFIhmuaYX0VetFtrze+9tjlsk
	 /1EMiiUyWLgfzv7KUDOfbT3LT3YTo9Z8I3PDM4NGJ5RFcZMUwGeOz6mAy/FIBRniKXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=q4olno8II5dwNhcjboptZN9dtmLgk5iBrVQuq6cgPS4=;
	b=C4ZTO9fKntm0BH8EL+FZ/RGENbB0B3hUn5b5T5GNTmX8ltHLbRWk73sGKoYp5zIdpr3t
	 mTKIY6jPCtbXmt0kiTC5ScWj6bdq69F9GwrRZdSITTJtiXdLqvIrudITmbRusokIng8d9
	 KyaGIZEcTSbA21ctAT1vyROkIvEDe8jshipBCs7+eox/r4ilmDPz1EyGghQeNe6gY76S9
	 KfPLkEiOkMSD+YutcBnwizG00Fiah2rgyROZJcH3REfzzq+7M63G2YpuVWAE0NnJwtTag
	 rcfJ/AdQTPtE9JIeUySYQjZe4PAOet8iRgPCMp6X/XravA1yV4E6j76n5aNX1ak2oDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMrCT47L;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34804606A31A
	for <mptcp@lists.linux.dev>; Sat, 24 Oct 2026 06:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34804606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NMrCT47L
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f2ed2541aso118922785a.0
        for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792821898; x=1793426698; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q4olno8II5dwNhcjboptZN9dtmLgk5iBrVQuq6cgPS4=;
        b=NMrCT47LNXzjWkS5og1St4j9FvQjQAUa/InI2tTbXJiDZeJwF1ERrSPy6f/4KImsuv
         P1Y2gZyhji9feBbCYLTvZBfgV1KaCcuU+ai7jtUa+NN2Vro/RtO2EwJR/0BPd1K5U4Jx
         kphdS+EvOcutQ4/0Ef+3YIzIPOOB15P4hRk9CLxYps7h/HXaXUQEJMmjwbT4E4ccHVbL
         FBGHYjxPupIljqM5x5cj02EEdHoH/hAc3FYWgwrB48LW6GDUpfquuF95J8mI+QPIcVSW
         sqvPPbmpmkC7vtVsjVTh5OqMMsMB3qxEOXaoUWxRt6TBo+rdVYxkBvvilxsoGG4gUiIm
         c1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792821898; x=1793426698;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4olno8II5dwNhcjboptZN9dtmLgk5iBrVQuq6cgPS4=;
        b=uEJcp8Eea952JQC09L6mpThf+PGXBjpBn6rVZogIG9VRCPSSQwE1pPUo9e9L6DwxZx
         vVzVmJHL5gTKRBP2UC3L0qouhiwIICV310bQ0J/Jil5CqBlt7o+h/x+EBJsw6poXNiOM
         H9aFsOe5mU2+0Zn2ea9My+k42EfciZNKlIxEygPS4C1N1lkOvEQVhckgMJvW0MVYWP6j
         WNOjDFtWHFLAygpKFC41TADLdg8WcO/bTfF/Pfky+RX3kmqu49KiygGB/Mk5nPt1bd30
         kOllV1dsY/Ps+W/UGNjEhc74bGtjl8OkJ4XJgGLvsXZs963Olo/HCUMDD2bpVcRAlIlZ
         iZpQ==
X-Gm-Message-State: AFq9FYKY/LcVylFXr/0bj7O3e25R+0AkM5bcMDz7MljCl9qGArbAy5fT
	faQOV6EJ2P061LK2HlZol8nT3be2qtHaY75PTovdga4datJ4KP0dIzafBgDG
X-Gm-Gg: AYBFou3W/YGjFNl46GHmEuY97PeXA/+ZBi1tT3Q1wFAXm79q4qcs8CyOzomgLbiYOiB
	3ucDMA1se1T6osPbxYWxUt0fzrjkBnzk/1YGcJr4md1DslzgQTCzm6jYtFaOj/NEYq/L72tDKbI
	j9HZm9Zi8z9mI7Yv/Gd/t8V8TK300nqxKygWt2rtv4fWtxygA955CZ+drIh5DHMCCOk746Y3uph
	LRALdZ/vaMpM+4bCO6HTnhXDusD89AmqBWJ+VDoBQIwQXvNNRpMytSr4L91g/rdWgrexjeFMJ5D
	6Ax+OTaenIRS2OgcrctQXgtk+N7mHnvq2KY4GVyk0nEcBHWIlbtlSmBTRXHH+CHl7aeAQnZKvhC
	RwC8pVBiAsM0JPZwbJQW7e4IvL94lqBe7QtU0dpZg4omEPgLpwwWSb0V5qIjA1DCplXK8WePeNI
	SfRCq+18SMaVvchg6cV18bwDP4H+856hOt+NZQrZOVRZ0fR1UYpOzGdTo6j7EzbDZxHTI75X/kK
	fOb4AvBV715P4C6bfQaZpeHYbUlo+yCMF6WoIZMYfWK8PUEBH/SBLbU/He2P8VJ4fMD5A==
X-Received: by 2002:a05:620a:4146:b0:93c:891b:90f1 with SMTP id af79cd13be357-940ef987567mr156205485a.26.1792821898017;
        Fri, 23 Oct 2026 23:04:58 -0700 (PDT)
Received: from github.com ([20.124.87.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f066a5bcsm104843285a.13.2026.10.23.23.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:04:57 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792746800.git.tanggeliang@kylinos.cn>
References: <cover.1792746800.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] Add MPTCP support for NBD
Message-ID: <32ef3240-9e62-abcc-9a85-78aec545d2d7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:04:56 +0000
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/39933748069

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/04bb6f5fad=
a2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1191964


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
