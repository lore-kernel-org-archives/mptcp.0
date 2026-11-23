Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795404900;
	b=Ejjp03T1gwrkxrw3SpHgEOfxT9NMh+k+qNPpB7OdpZje/ldo0DSP522RiBO0pj7U75Nb
	 30ol9UZ14uemlDsd0mOU06AU5PY2jy8llT8346gwOrDNtf6rqkUBxeqb9MhUs/+JXkvWX
	 VACLoQB9vOSkL8rp0xCoDLkyFktyWuaAdpQAaHLi1fk2tAlSqj0zN+YmYuxJ0eVP/LRbm
	 8WwypwX3s5sgz7HO9vxzd9ETZrJiNvze+s+ill9V8ujFvOVh3HY60vMWabsikLIyKKAzk
	 AE4kU4OdMoLONnJgXPwe7X8MrDHQXhnmZ5ia6w4d4BgkIRfpx0trTuWFVhf23VXof4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795404900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=QI5abgHHh0g8mucm2g5ISMHkeCwF6mBOYFAR5RR2nDc=;
	b=MMp8IftFyWU4ccaIjKHEqsh8rgpN9NgCA0TMXsvf4Cc0+tjllzngw4qJYehACnNGstK7
	 HhoyP/JY/vXHRF7KzsCEa2labnf8JP5oWxmaBqIDT9Ux5MQFRvzOgzU7eEsHNx6e7KUCt
	 Tfo8IeMujocIKPBnHfG3Cqy+2TgOd5ODZS/zn8Dpo9YZ1vSEp7EvIChwCgr8DXUE9NEnD
	 NLWEJ035zns6CkTWHsr5tdyqWaeMEf3e4T6Ls9G5SapPYbytKwny1SjnUwSLLn4BGPSmU
	 TmL6Lg+jC5dSHkUH3YmNfZgdkqkcWmj8oacG9ZhmsAcn3bXnEzI9wg4yEiPp4ZQwd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jZevk66q;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214AB606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 03:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 214AB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jZevk66q
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67da564d9f2so3732269d50.1
        for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 19:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795404899; x=1796009699; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QI5abgHHh0g8mucm2g5ISMHkeCwF6mBOYFAR5RR2nDc=;
        b=jZevk66qbUVASjjw5Lu9p7Gxijj5oQRRFpSOdRoH2rTNl/7CQaeT0CNiBmY/zAuuFk
         tEjrIibUbqenWD/4M7wtKgSmlmTPIqWpmpQltLHOpaKv7B2cltN1pgwSvkAbEFXZhqhZ
         ta/Gb//3hB71qd91FIarNzBvK0VRk22Xi+3jPTBsilgIGF8RYCi/Nb59idC8F03ABPQL
         x8LFiL7CyHwqY5cC2zPjdA9XFp5kyYOUACIYjQlqoPQkSfMFWL+DwuEjv00APvJn5y4Y
         L5BkwL42T4H45Ok0tKC0oca82otCCRbWA3d5ue3YiePGOz1NxpB+LC3+mdttS3Eq0z/z
         2c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795404899; x=1796009699;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QI5abgHHh0g8mucm2g5ISMHkeCwF6mBOYFAR5RR2nDc=;
        b=Xz6i0wBOEddMjrzyoxxwHT0ePedQ+ffv6/3efZSNilRR62ingqp4zK6eY+TrR57kQ9
         PCEyfpq7F3cEXMCEfmNaJmTdrYnfbfgjpdbWAxuR4GfjTcFhHUSi1C4yYSe8KKTfi8+8
         Hykg49OtFdkrU5MO20wG1D6+cXefbevkBrEv8Q8Y7CWGq8bZU+lzmTQCF+mNNjFnMMiI
         vH26hsPeHn7XTDtSZrHasRYaFHrcM6DHh/xvjCSyLUNFDc/6C994nHCo+qns2M3S5I4D
         E+wH3wcKW+PPLMLV3Z76RnioBtYj/5X+LBkiYqY6rShkYVo3i2mvhGJXe/wC2zbVjitK
         HuHg==
X-Gm-Message-State: APuU4Z9TqMiAcIUZhpVANtrnIcXZCr5bMdbry6lypm6OBycj/0Cmfies
	TsNN90z9t3cLHOjD+QzgGstsoLsOS9IWE9iVGY3CGjiX6d+HCrsPT6Y+mtn3
X-Gm-Gg: AZFdTZfNnZqfQreA/TNZAo6ddWBuDoC+KGcDdgDwaQVeANizByODvkSwLrRYvlgJnQk
	TxHrZb2yXCl8pizco6czBxl/3DA5mhBK3pGKaqlloPMPLJ5pp/eASaxTVFGQTwlBv5SLSZCDL+I
	p0U4cyevaQark59j8SgNbJMks6F98Vtt7YrSB1a20dyiplRDk7GH3JBB3nBfLGYsCHY6Btz+g+A
	NgJKZHSAJDhIQ6J4FykFcQuOKahzwelfW4+9tNPlrF1eBh8gOE5S+WCl/AVFxkIRznVeUvWGqQW
	1/MLaUdA+58cpTQkhma+CvhhYOTkA2mU4mQcrjder2YHVgOc/mLRdKpIXYC6qJq0qrG6bcLGN8x
	vlx8Cl1WqiUfTSzJc6s5l9E8y0mkQEA5w43IvWsfcoSE0z5tzcOal1kc98XDR0aJLCrTVzrFwoa
	aR3qs9sIrX3Sxr/Hn+gr9Xe2zcQ4X2sGE0MfAYAOBf8xY9Zc2Cb3gEFyDQ+IB81iLBhz0ylqnGb
	XOCFGMdCvGFEQnj+WAHLEcI79Z6ic+Y3gd4wERdqwCNTcwbsc+eJk+C90u6BJOwVNHoZBXgvvX9
	brd6RpsElxRPhKd5Fwl99NY6t/0Edmb6+AiNwnKFS9mkAYj4skF6/4CmTvhMP7A=
X-Received: by 2002:a05:690e:12c3:b0:67c:17fb:ecaf with SMTP id 956f58d0204a3-67df43d08e3mr5463257d50.26.1795404898936;
        Sun, 22 Nov 2026 19:34:58 -0800 (PST)
Received: from github.com ([134.138.33.87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33105fesm4886237d50.7.2026.11.22.19.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 19:34:57 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795396910.git.tanggeliang@kylinos.cn>
References: <cover.1795396910.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3 0/4] mptcp: fixes for SIOCINQ
Message-ID: <4b1d6e4e-dc10-1913-ae9a-5e7efef1113a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 03:34:56 +0000
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
- KVM Validation: debug (only selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_join =E2=9A=A0=EF=B8=8F=20
- KVM Validation: =
btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: =
btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 2 failed=
 test(s): regression:sched-rmem validation:sched-loss(2) =E2=9A=A0=EF=B8=8F=
  (105 new outliers to review)
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/45096063097

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/fe4d1aa6c043
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1219076


If there are some issues, you =
can reproduce them using the same environment as
the one used by the CI =
thanks to a docker image, e.g.:

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
