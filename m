Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878712;
	b=drSheAjPPzQjuxaHcKGXkgZLU7kxE4dwNoG+4MPhnaoQEXCXxoNvhYsLyW50jgWqYMlO
	 s/ZQZT05dV6cmo5tGIcjwRhFvuNVs+tO4sIq1IyXzw/0YVCEabtW4dk0AjBp1ygI85sY1
	 X98TacibfJDvM28YgOdCRNbS1FyCplxo9eafVA0Uzs6E1yjHAOyMs5+N5O+Ixwcg+c9RQ
	 Cn2DLUfRadjhtvrwoteuynUGkhLnFvnqStvhK9JzM4DdYh84/4YJJQsr0j+5f6x1AqdDi
	 /+innjMlyUB+xnSHAmLHYe1Tlvw9o6BvZAcUGZry5Zx+mAo6WNknb06AUjM+Wzu/GxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=GzJLIWgxeRtbzBEIBuMpuSG3lMfHLrKZ+StzMJvZhAs=;
	b=Q7Xg6sY+WqF1mQXtHff8obU+E9a+nIveTMDtdrSicJV/BDu9PC6hCgGVJb8TO8BODSbr
	 FJHiVi3z59l/1JAXlcs2XOdil0sU7rTSADnoV3HGAYjapKOLeU4tvXLubHtwUsdioSk/Q
	 hUS84HfU5AGscG0PGPeBQX8XbALH1tLsxoJctOkZxjtiHgBSCyfGlJC7fBjc2ttdL9y/4
	 /4ugctlzGlZVi7PCmkUC5JK2BVLd2xkqA7eTt7ac+4QzRazcUYjPv86/aC+21vIgvoLPc
	 yTfzsgdrvXCCEKUZWK8jY9exLBpz58hS04rXnX2ok2bMWlNChKioOBDPXTVs1AGDnVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8exC1Xk;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07251606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 11:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07251606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o8exC1Xk
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso830729a91.2
        for <mptcp@lists.linux.dev>; Thu, 05 Nov 2026 03:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878711; x=1794483511; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GzJLIWgxeRtbzBEIBuMpuSG3lMfHLrKZ+StzMJvZhAs=;
        b=o8exC1XkjGP0boai0jNeuniEEtKutcJtrQHLf0kvjga7VUivQi7scDo+MGD+KZBjQl
         8+j7w1cOxu7+e4tiRvkEpjFdGDAgkSlNDtlw+AOHXx/10y2brrertkOmYt5q9DRZLnny
         Hc5s78+Qx5mgIs9IgIQDjlnea2H6+2DhwhjyJ6MjHhE69TIOpCzF6VkOFOyB4HPs0Ii9
         HuLtrwWo5cvq1zEUBuKKXzPOOSAco+pRJygpss6tA3jJBS09jXGEAfwmY0Ep2gAi9CRK
         zvR5OEJY4wA81r44Qkxjtu9F3Jh+dBJ7mqJ2ZfQtqoiRl94kiNhRDIiiOytfEcGUJJ6R
         Ok4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878711; x=1794483511;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GzJLIWgxeRtbzBEIBuMpuSG3lMfHLrKZ+StzMJvZhAs=;
        b=BDeqcy9YghndJZBeT/PVqHczLTB7dFQmWGQdheeZTiaTuCfxVduNWdmKUKfd2EokKB
         pydwcJLmVUXT6yse3rV9vkz6kR2Payofpi2mLooWlDgVWiQ4a8bAE5/C2kA8AbG154VK
         c9kN+ndciSm2HGu5aCsoB4MItBD5TxCadYGo4dAwED+4pxjBSbmfcLfHNc7Hb8oMwWx2
         pYq7uxKj20QpLUFoW0lDxIF7Nu5dFIS9wfO+28jrKdcK6falwKR8jnjS2E+r3UdiXjPy
         BIrR0K40YclNmcbdBT3BCWutWKWK9N8FR6IP+COSKxsCViYZLEm3vUcgyZ9SJYtz07Rm
         Z9gg==
X-Gm-Message-State: APuU4Z+Ae9CqH8hzn4HPyjxUtAnUuVLto4uG/avlJ422fJI+CNY15ZeI
	8liy9rTjUBuDaOKssRJ+aXQnr8NcnAHm434YNXXVyh0GcxBdoNWsoWpDSOgr
X-Gm-Gg: AYBFou0nchIkjq1LAHT0TLeA1eJKknzWOylQCAKGH5hpLlp83s/2qllWhMaID1OOWwf
	pafrJkkmX4BawnSSrD5ms+VAguHWdyBZapeSKPGeQTobgqicK+VS26da/xomnBeTGoic2w0GXBW
	RAQ49Quc/32zdcbYVMkleCOI6NobvoftdqXJskzgNCP90hEm6POIGWlLzVvkfX/7s/DoMpgF9y+
	Qq1wlYefIRJQDgDxLDDGmhGtmcfAXcUgbvQ+DU4HZY+niPYXtWGtugb44+xaWbIu3WorlSf3qIO
	nJhKIoOxeX1oOIwRZmJCI5BKde/A/Gdt/wrkeIJ2rg8ORgLhMweoho6mcd6fhn7JvFWMwM6/7at
	pPS5AMzlDe3euUqa4U637bkYNr0phdGlQ607G0UtA2GYAV3ABUGOiCkun0CJ7gQk43qipLmi0Be
	WLt0gvpRO3ISFEst17+gPZymqmjIW6XCgIYlirquz3Ao8aftnQ/A0qwUnD03untGhCvFCgXMFzR
	MKaNOkOC/zT50rYN1zrs9uAyUxmGJ8aDIzy3bBKod4u27kNqmhzZgB5DsVP286BSe8+b7DAwkD6
	v/V1VPDdMdHBFNEGh3O9LmOM1cpF6TVbDDt81CfHag==
X-Received: by 2002:a17:90b:3b85:b0:3ac:a11a:7c84 with SMTP id 98e67ed59e1d1-3ae897d6a13mr16260132a91.65.1793878711190;
        Thu, 05 Nov 2026 03:38:31 -0800 (PST)
Received: from github.com ([52.159.140.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm4569609a91.0.2026.11.05.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:38:30 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793870710.git.tanggeliang@kylinos.cn>
References: <cover.1793870710.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v21 0/9] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <a451aa6b-e852-caa8-1aa2-936b3474014c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:38:29 +0000
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
et-next/actions/runs/42007402371

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4322f40aa9=
a0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1202893


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
