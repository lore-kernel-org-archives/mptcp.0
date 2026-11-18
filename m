Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794986137;
	b=aSkMd78/AuE+2WpllpsBMXz1lRaHA3HL9tGq9itGzwxeyKkMkwKHnQ0vOt8hPvTqhKHj
	 XZsszLtEZXXRq4NWMWmZcKC+qy4qLe6PEXpl7NUtlxSl7V2eMk3KpK5zE9Zjc6kiNLGk4
	 SvdP8xkmsg/7vjiGQWzerMbf59ApZE9OsqT51ptxr5WWeOoY0Ptf6OV+KCqMDaUd7Rm13
	 /LLtsPT5mQjJuMZl/naw9Xhox+hf1SAH7i2lbZA6AOK6r5fFisIfOii/QYV4KtQyHYaQP
	 jPl6VNMZvVZSRVCa9JjyLvVCq1rZ/C/FupsOkqBC3ISV4NU6DMW0FycbvKHqgYEWePw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794986137;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=bIwDVQLGpXM37783Yi3l5VL/QAI3T1rPrDQdAHIQu00=;
	b=t8tgCKfo2vDgqcyibzI9wyjf1TJ94kfUlDm1MweY/TBUd81nVxbj4JuzCky+4K3ql9yH
	 el9rZObRYrzQNyrl5JlCauy5cq1K5faI8S0l/E876qLybA7NmaUaXr5omCxLLkqBcL+7n
	 IJSPNu4Lb4njf9e09lJnAs6YSvqTtJaED1G/kAMtRds7KmNyBQFltfEixeMbsOeHIuhLe
	 zKLsUGbffdlweOPVcYVs9/Bp5S4qgSUw9Ghzl4mnn0SRBUqUwz5LFZiiaYp/936Y5fi6u
	 2oqHWygd7asvGyrLUd4R0WsJJcVP+0GKGpubKP70SX+SbnfrY+w3EqH8wMLLtdHD3Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JROFKR7J;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8966606A325
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 07:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8966606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JROFKR7J
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91f23ddf32fso4172896d6.0
        for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 23:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794986136; x=1795590936; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bIwDVQLGpXM37783Yi3l5VL/QAI3T1rPrDQdAHIQu00=;
        b=JROFKR7JEIZBP8Wpj3VpszaN7BKbmujy7BcKcDtt59yOtvyGhJj2TBLqXwj1xH9ny6
         f4oANx/fxHObdWAAq+iIiLh7XRTjc89zdzn1hyE2Izem+jgbpGcDgAkxINTd6jkYrBpS
         tqGdvlhNPjeL2u9OHsw9r4CtxSZG0Hv0FlNibAVZSDHalP+M4sG13/kHJ1HrdPAt6XIJ
         30reD7CS62K4OwVBeAoj5C5Rd0iRUB9RVDoxFQHzTys4J72HPAd1RrjW1804hJoKkHPW
         51PCgnpAE/TcuL8+WL6o3mk4F9EuE1QWkcV3Flkl7E4RypjWthwIglOSfcV+BQuG4k1m
         axKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794986136; x=1795590936;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIwDVQLGpXM37783Yi3l5VL/QAI3T1rPrDQdAHIQu00=;
        b=2OJYmScz77U70A9rLafzikeA0/a4RJHKpDTvAYKT9xMAJYVSlH7LhXsvXpBO2uvFAy
         i3zXniW9xotYmViK3mdAIbMG+ORkPOWalDE1Zg3IO+0qTMkKChmP3j+b+Xbf1wimxanM
         IPRtd5UAQEov9xTkjSpFb/qfYxxkp6LpKdRZg+HCGImS/nAbaPQ77ROMElXu2DMWzkVt
         EmgOTVrCQMjD3/TTR/BDMn09jR4cC2D08PjB0+Kx9R540glWd7igtPywC5uLPqddGK1s
         lP8XrbgwcnRT+DTQr9Czz6czb0gTVZSdaBi4QofANhrO7qbvVk/9yBO2IFSL5dK7g+0s
         bcjQ==
X-Gm-Message-State: APuU4Z+TN0XPb30QY/yHQ96g/EcFJAiYrhgLas3dxXnKfebVLyTEevrb
	KIX0XBsVubuAz4hocETA2+t9IouHPxRu0LhjOvB0jb8K+zgQBtBOz5HIcSUb
X-Gm-Gg: AZFdTZcNpkmJBQxB8lLwh6723eY14A6GaeR7ugEpZw6aD66A1IXXfffcMi8lTPyDyw7
	aMwdCzG/eKCso9Cqwc3pqRzzyi3s1+HBAOxFbTtVtG/R7BdpB1MuoembzHmVlloLmW9emq5jEVW
	EvNqxeB/tfXsFvrcDOyTNgGRFeItdpCM7sw6NoMLQNI/RaO0aTdbHaiPh8Ax98WzzcTjVU8S8uq
	8bWa9zoBShdzqLPTqHfb4RNHAzaeuorhvMxuKBcEqlfPREz/hNxfxW221S+KFD/TxplRLL6rd4+
	8ocK4JMnYXvKcYE0kcrqZo8XwJOQv0Af6acgwxHr5b33X4k6HqLXBaPZAkO94em+LRJ2d5r+HEm
	jAqaR/5ZLGb45yp/RcHqPYqBAEXk7z/do2ayYxkcjuOPXRQwAivo2WaRJ484kF1V3HvLxi6q/k3
	hs9Dwba0cxACbA/KBSECHbxFomR5PSb2au81+7pg7Z1yOp20sVuMFF5uIfcAzZAt3yNtTYCw+K7
	QpLYa/Y+vJoc4DbaE6JY+j8PkVF1pzxAZfKmUVOP1TvqGz91/uuRrlTIpOH0t801uHV3XwQBZoQ
	wHh60vDjrbTrFGM+NxBbvtku7Z+Jc9oMj18EOeEPhtw=
X-Received: by 2002:ad4:5ce3:0:b0:91e:a3b4:9f1 with SMTP id 6a1803df08f44-92114a97102mr27730606d6.0.1794986135418;
        Tue, 17 Nov 2026 23:15:35 -0800 (PST)
Received: from github.com ([172.190.119.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92114d0d879sm14676246d6.12.2026.11.17.23.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 23:15:34 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261118045137.174026-1-jiayuan.chen@linux.dev>
References: <20261118045137.174026-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net-next v2 0/5] net: annotate data-races around sysctl
 knobs
Message-ID: <b739e40a-f8df-843c-c125-3100dfac50a6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:15:34 +0000
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

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 2 failed test(s): error:sched-mem-pressure =
validation:sched-weak-secondary =E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/442427=
79577

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c03ca5be7367
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1214545


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
