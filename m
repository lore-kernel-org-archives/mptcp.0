Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794898853;
	b=c/PUO1YDExnik5OK379hP03891yM8ReMMlAdH7BILteYNDuj61CxOEWoVtmZHBlij8EC
	 +ZRx3JJaqzpyNVXzDyuT9Dq6iRkW8aoA+Hlk4GwwHdn4OA+czF9RVwRHxx8z97qJo0Cyu
	 paNaTuPo8tvFhnaX1tJIgpNgs7xCmyu0xIZE1T1NfeCDdiUpy6DbU4DPnwO9xxI5x98UY
	 eBiqyga08HppjFwTvurN0kUieCVLmj6lQIW1PF6jO0uxn0ZG3JjLA2suHXAubztiz9g4p
	 quRd3gYf0y4YGLVlq/BbSpI8FvCkmY6hhOw+TCbtnZSh0W80c7M/iDwVuuCXh7thwQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794898853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ETpo5icWBNGamXJ6RHSax60uI16ugjRFGbWTY5sjlS4=;
	b=YmLNwv5kbMoT2mrglfj0JrHV7eXxCJIF+QY0d7x03LYcO2qGrFmLKtr+NdCU/ui0QMXk
	 l54UdHkG0yCE7+rBMviNLLvVRRvo1P1g7oEK8NhtDQ/9jgMB2YcEmb4/sToa6k9XM21Ou
	 v0cZtnAJ3I6IkS+123PlxIxf15nPJmjjU/I2dXqg+KOwqGJe5UaE51N91pYnFPtM7kjWW
	 kQP5A6TYuaGxO34EuDPD3zlctlT+DX29ZMvTmMf2b57iI7DP7U9mE2XL3vh0aYkAxDuTu
	 qN6h4UF83rzNskFw0yZLZ2rUsV1KOpCcwqiUJcjswXKGVbMpjJDQf94IKgtDWaVz5VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh16foXm;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D2606A323
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 07:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 047D2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xh16foXm
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4b0348a4c79so1049701fac.0
        for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 23:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794898852; x=1795503652; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ETpo5icWBNGamXJ6RHSax60uI16ugjRFGbWTY5sjlS4=;
        b=xh16foXmOAoVvXGHWnX8Bq4UzEg12vhPvzfJFWc/aAxPymR3tB4E5p32UY/oNw0+NN
         MRsXhi8b2AdUKBgom9ubOKTS+AbafKdFleFtlEuTK7ET58LFq5aOwd93u4OZ84zfzCB6
         BCX5H4cf5H7DVF/N/HoXv/umC79UlDJ3G/aBFyg1l8YYown8EutI46hBTghW9YUQuvdF
         9gJfqrI5jw1q64qG1dF9Xb+KJ97F1i4UgrYSteinuPL77tv68vVwzO9FHovpM55Oq4FL
         75/Fpho4tO2I+UC/84HPVI0UshMRiSV2hUqWKPiMKcLkYxaJHexWKv96UIAnnnSHo8Tj
         yCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794898852; x=1795503652;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ETpo5icWBNGamXJ6RHSax60uI16ugjRFGbWTY5sjlS4=;
        b=L83v+ofs9CpJtjdATQQDyv7O1/5gA5VGpBK7/M6Tr6VWmRqDzuNsztxezh1ZjJtMPV
         TMjHfjwZiTRbe9pdfO7Um+JV8E/MNsBeZibJcfn9S27pTy9IifBZmSLOIkd+cQgMV5+v
         kkQTEzVky7COI+quAwUnClEmsHJEG0sOG5ZsC021uGgXijcLte6B3as0A3OccSJZ6JzX
         bb4HvYTupdimGDL5+ZwlsfhpcjBZBygY57MfdWIgHawBv56s10OL4aU3cDCte1qdqdBT
         g+zPJMO/76VQkQt9YNvMz+SPXlXIIaTE5vu4wcirr4CcdAg3TKLD56OJcjI8DkuN5fXc
         T1kA==
X-Gm-Message-State: APuU4Z+MuktbhBXUBeiDXDHHGbGgR8vEKA7bRRidC7g/S7LzNBG5dKrU
	g45ueX32whVJ56ABbMqkc+p9A6YRfpfWqxuD6kswibY3joCiuyKplvc=
X-Gm-Gg: AYBFou2QO4/7IEMy+hLfff+oeHcUm+SFrF0V5dTQD3T/IlG2vyyfNsAte9wGgwsiWjW
	wHvAE5ntqfoYrQoB/imXPg9R0KS8otqGnsW89M+pR4RYLlasI0/yKi17gmcHW5ShXyOv6C6aRV7
	OvzKZlz96tktY89PhI+sKHBZjIw67MsJSb83d+ThFsQOsKsSDpUZaRbvDtvcBgrMccDjFMN9rZ2
	pR+RtEYMtutYs2k3dF4AkgSsQJxYO0KZyx0O7RLDzWAwJhDCqpoNztznDK8ctOQ5oHJt7cJ3FZr
	iJsEQIn+6o3QHAbhKSHlM6uJ7tA7HnVuqJ4tkzpImqqAV9NDLWXQKNjTeGVCA0ao9dpi8jd86v/
	L3CZRVP4t/sjgfGlitlSXt6p79RdtM2Mm9zX+hPQJtSQQLgxFBsePMgeeHIBckHlupXJa9nu2sM
	u1wWfb6alpiPOtBwCMGTsaNmxbI4U9pNPcLM0+ohz46NiUT9xXcZg+EqPj9BpwrqXrElTx0+kKV
	8M8SQ4lcGDcUJqzkwYEQyzIeOtGqQQKivK398RDcmwoCTpYioUPigGauQpjCc9EEqzzSF6rx5dJ
	19/+f1/x66MfBHi1cpfO9sdAq0lHYSw1qPY7vZrQ
X-Received: by 2002:a05:6870:65a1:b0:4a6:f610:87eb with SMTP id 586e51a60fabf-4afdf161f09mr10725304fac.3.1794898851819;
        Mon, 16 Nov 2026 23:00:51 -0800 (PST)
Received: from github.com ([20.221.69.28])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4afe2288f59sm8622673fac.9.2026.11.16.23.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 23:00:50 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261117050804.134954-1-kalpan.jani@mpiricsoftware.com>
References: <20261117050804.134954-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v13] mptcp: hide sequence numbers in Netlink
 diagnostics
Message-ID: <91ad8bb4-6bd1-5eee-8c58-0bff9364ea65@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 07:00:48 +0000
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

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 1 failed test(s): validation:sched-weak-secondary =
=E2=9A=A0=EF=B8=8F=20
- Task: https://github.com/multipath-tcp/mptcp_net-ne=
xt/actions/runs/44024671433

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/bd9eb2c9b4=
cb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1213422


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
