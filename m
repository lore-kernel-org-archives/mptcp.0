Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564440;
	b=YUt/ddlwDzJY3sdPe+VAEaO721uIP4fKWHtBOxBh1iH/kbKZO49NajzbTclcjGandDQy
	 wAPUtQE382n1DFa+bKiZB3pRPUdBB/bE4emktdNnARO23LQHhNjsFOA9szGT+lptomhX1
	 Gwq9YhX518HXHqMQwf5GCnudMrXhm4yfrtASNVUgBZaaTiidK+f+RVx3XquZhPzAejtKT
	 CtOD7mwB+XZB+UP1oIbE+SwFbKWacAvZj9FbGxoOXoGe4n4BBnQRehpLuYo07w6tthRcZ
	 o1NFISBq4/PVfa2N+uQyIFHLuZ8Emn/r6lVg7J0iM2LLbpRASQfr8+J4kdb1Yqp8FbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=m6ykW9CudW7ISPRUI3pPHRor40A1crTX5lC7Z7O7Do8=;
	b=NnasEAHcUv8ee0jyCjkwd7m9IxewhJ8kW/MhUc/4TaiB+kWSG+EP7sMwpM4xZdcxsVfs
	 ofBY5YgOZWCwlkJZO6I5RFMwtBnt5806K7cWxiv9EmR3LJ98Byoynay6NdQ3bnYiKNGMa
	 RQiMWArUUir6z0wtQ20PbXlvuN9g3S7eUyjKHaOI3LGN0Ho+yGXIWO8maUUTz1zAKA5lu
	 Oky9ZzyP+1oemcXlIIpKzIbMnE54H8TrlvPeVNqZz0IrQTRfAUiHO/UtcHD7+dTDiLEnF
	 1CMe82i4qagM+8F5c3sP7l8S1kcen99y52lahgSPO0mj81jHS+94s9lwW7k5ODn2IQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1MO7mPj;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17909606A324
	for <mptcp@lists.linux.dev>; Sun,  1 Nov 2026 20:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17909606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S1MO7mPj
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-823e4047037so1803671a34.2
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 12:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793564439; x=1794169239; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m6ykW9CudW7ISPRUI3pPHRor40A1crTX5lC7Z7O7Do8=;
        b=S1MO7mPj8CLNF5m1+81ziXmGy3rSlsRLyhwR5mbB0vl4+FaTDV6FxvNkT68TdfN0HB
         fWwBGvpQfMVgT8tSQn6hu8i8UIIwBIAW66mFn/zNHy1aQtVbquHwngtrUySBsY5T3VKI
         FFnckoYLod6gnpgxi8RRO51MR6bQ80xYnEwkf8Cr3K62VWaDetTilyc93A7mkey+qMx/
         6AvLazbsI/Z8PVM32yZW7lhmXRgHyYSWXeme+hm5iCbTBwevo/An03ryXy9X7DEtEFYN
         6iFpFsQgBp0j9QttARMb6LwlfbpUWSvYfqhUhpX9FElK0NPJKTAfZEWwltN60XTPdCBW
         w+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793564439; x=1794169239;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m6ykW9CudW7ISPRUI3pPHRor40A1crTX5lC7Z7O7Do8=;
        b=VEvZm+e/DSn3Ep52MTnndmtjSdy+L6AL1/LqemVOO2zVF03jLc1UuRQ1pnwTjfanlK
         eo3vchp1QaV20taEWBMPyQ1VviMPJfdnsPdMYclDTZtVwgNlONxrPYZ5T8rLfzWDT2kZ
         J+G/8NQxAXSL/cqfu9JnVI0R9dqazLLORPVTZ8Ite7y4P8dBIDSjModWxhFsZUR3S6Ho
         E7JbTll14D1aEhV5KH+X0gKOeiADTxe7RijWknsA+Y5+Hl1PJebGFW8JY97+SERfF5ug
         C3wDCbXiG176LWx906IwspeUIAJELcojKD6yKCZbAkWLpNPEk23/tD2LHXZpMG6WrGtN
         9vtg==
X-Gm-Message-State: AFq9FYLcNDKy4O0k7PFqBsh+3hTcvLeJPmZHISvneCdA/tmOkxSbHNTx
	FhosM1Itjc+W5WBa+Juce+P3OcKlU0AQmwnLl7tvJpdZ8l2EdEwGsGRSd13d
X-Gm-Gg: AYBFou0ABEKhtSYEwx10WcMYQfkPM+hbefvyfBywGsKorrV1CeS4jw4QL3Vd4f/WgZq
	BH5uReKDTT6u3S7d8lBnaw2PL1sPltyqQT9UseM06233jR1WYzSd0WFLrvd05TjS8s3dmoU1abz
	CIBS7wDk4LHV1Ud0U9nnTrPtx9ckQIGaPvJQInBIrwPDriVzY1trxz0QDms/nLFnc38f5dIvr1j
	OBtRUY93+PpUxk8eK6zyooPXU1kM6kdNYGzwgfsn7xc1wIMg2EmKuY7N6xbSlKG7F0fOEJ/d1Tp
	J2bplTFrnfzgZ8gMuh+ECaBSrCys+FibwgrGgaz5wdfWN9x339pZztpfAMB1E8wQJLUvpGZXgmB
	Dg0ENT1oelNS9wGdSGd/CdC7TObCF/OfQHwxEpOOu+Wexr2geMx3TO5Obrjug0x1rC3NY/nSUEp
	gN7s8dIklNMgkiFYdhoboLgZmkM7WZZyBnKaJ9kcZuQLxIIsGpZnq3IYzRWtZRVcIX8SZGMM4HJ
	T4MQCmtxOTcBALayzPyXbVx7Bw/gv6hWV8f0EF2BmL/pwNMCin762+fjvCMd+ioM/r1F1D8Vd8P
	gdCQoZcWjSoqNUNtRtKKYgoz11tyHoF3/b9WX5wmlA==
X-Received: by 2002:a05:6830:71a1:b0:845:8d86:9f88 with SMTP id 46e09a7af769-85d363e9c41mr5828720a34.15.1793564438963;
        Sun, 01 Nov 2026 12:20:38 -0800 (PST)
Received: from github.com ([64.236.153.82])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354d05e0sm7174451a34.15.2026.11.01.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:20:37 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261101182736.430733-1-zhiyuzhang999@gmail.com>
References: <20261101182736.430733-1-zhiyuzhang999@gmail.com>
Subject: Re: [PATCH net v2] tcp: restore IPv6 af_ops on disconnect of a
 v4-mapped socket
Message-ID: <c07c8016-4fab-8924-bb0a-b8f186ef629d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 20:20:36 +0000
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

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Unstable: 3 failed =
test(s): bpftest_test_progs-cpuv4_mptcp bpftest_test_progs-no_alu32_mptcp =
bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- KVM Validation: btf-debug =
(only bpftest_all): Unstable: 3 failed test(s): bpftest_test_progs-cpuv4_mp=
tcp bpftest_test_progs-no_alu32_mptcp bpftest_test_progs_mptcp =
=E2=9A=A0=EF=B8=8F=20
- Perf: Unstable: 1 failed test(s): =
validation:sched-weak-secondary =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/413387=
57537

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f81decb25049
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1198226


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
