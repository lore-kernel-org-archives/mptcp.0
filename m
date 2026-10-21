Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586191;
	b=IPOJTzO22vdUWGwN3SDtLYFA9F3rIzGPEXWEPZC8y0jlWQjrDL/ddcKFzYEItX222sBC
	 MYsm/ChGvrrXNmWCpVobS71hgwpKne4jEEEucOx3CQcVDkutRe8i1bl28fqSjVm/QRGld
	 HWKkpsrmDNGYi2jZ7sb4LKjxiBBX/McDTqv7rxpVhh/o+EEdaYNKp3NJ+xF3IT3XjtGAA
	 9A3AuTXHzbBeRJmfzdd6P3NWPzprnsyzTscCjHfCu1zdl8uR1gVGx786B1nTEiwqa7s6y
	 xmQvea0vovBvTkE7/qEKnkoo8q9XAVqBQ010X/K027PIOfOBFxksAu7uqD4UzhNCTYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=hRIlfSjDmifisaDuDJwUBhHhN7PdAPJ2VuAB5GUuUG8=;
	b=vaA5dV09sCNzfcAQKgdRbv+gD2R5h+O+kvpHxOqRbpfQZKTDrqdkRvuTuvv0gxlm4llK
	 q5OKbyT9j5hyGCH+7kNP8oUozZtO+5YXykXgubTZter4ABSpixBSdkCynb4VZgKKkJOX0
	 5v1/oBo+Geyx5oJNWcBI27oBvZ7soZUFz5ZdbIU2DDHiZfVRYUPJVqR1snlYSiOvApsVh
	 m+5XN/M3PIQVDziWgWnJ7IstWeO359APZEEJitl5aGpyTPc6/G95hd2R1p9owSIvzXS4N
	 Wf0VkIAazMAmV4OCgfvqkEVxv9Y0o1i+91CP3Tz23QXa9crW165FPepeC0toJs5TggA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eBSM3sBT;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6F560A4ADF
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F6F560A4ADF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eBSM3sBT
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53512cd2f85so7414971cf.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586190; x=1793190990; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hRIlfSjDmifisaDuDJwUBhHhN7PdAPJ2VuAB5GUuUG8=;
        b=eBSM3sBTyfkw45CIu/Cvo4QGprgz6RdVJ+imppOd3/WG9Saq9Yh3JAoUHuNvEFkjYN
         YYr5n/6m2ABOwttv36YMb+MwB8Y1P/mXQGJ0tvSZQIVNWVFXJmha2jZ1ydEqUrtdlm07
         Inr+a4Ns1OEKPNDGQQMSYSa7LsG0LbD0siRK4zCPLQpHY7d91xfSE9UXl0KNN7pq3ApE
         WXcM3YZ8gWrG/pAhhBM0OfWOXFwWgTf58PjBUBc24vM0mMq9QAA9yVmxDN+oL/MBURIw
         WYoRnnRfOOMPh4wCpKssxHyoF2faYePyQbbZToEmORjAgwtQjQ3EgsQ03Vb9I4CEuCRl
         YoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586190; x=1793190990;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRIlfSjDmifisaDuDJwUBhHhN7PdAPJ2VuAB5GUuUG8=;
        b=jXEZxI7hopsOhFZvAKZLoPATDwh1pryG8qKDv9toII8ybQC2prd/8D31ORjSCVMkxU
         wrmccsv8n+/rWhlUP2aL7Pu1uohoc/TmCPQNrLXJfw84XMnrBN3jlU2xys1QH/Obr83y
         8AqrFPVsng35/3PEZD7zsFfsKKL8bNMEchp+vbBiA++L9VSt3aiic0pGGdZerFsDOCWg
         NGc6Xsc5QeEXyBSK/+LIqur+Mnd/oKqKqdvigzBOjm+bN5bQ2tnJQFsdS5q57rbPQdye
         Tx3jIuliUFHft7nNW/PwXKjC0a7H5LPTTAUcguuI96auCv7VGyaO/oooeogkzyNM5++/
         Qzjw==
X-Gm-Message-State: AFq9FYIUH2EFXobarMUrdVhBhOleKeSF3hvtf7cFNWE04wmaGOKIavtn
	UA96XLN+ztStirM4wkESbeRnKp/VZ44NO4aMCMwrEKjpnS1yvUN78e4=
X-Gm-Gg: AYBFou1R9Pj/IhkZEznhEyNY7ITvczqhHzAIaHxYtHnOZxXUupVJlkUa4Jr/h1BUu4n
	RW9lmjyQZHN0pOV2Ac8SMo4hZdBOPE4PhtyzdIvXMHmwS8YkT1cjlS8Rqv52FZq+KPKlytFJH1w
	0o2cAh0/qbZp1Ap8IiZ27GmJeRYxhFX+2bfOqzOsPIQVFuqz7/J0oyctkiOJ46V3ctthHMizr5+
	ze0+QvM9Gu7BlceyIFRiSgb0NTvvwGbZK+I6OAibXwmYLrwSYRaiMZcrDXL1M8/0l3PyFcTJ8Es
	LpDlDaUZd+CizWjNzs+wKyRgKEDK61v8cWSPSz4+coQSIb9Q4KUPUgJwQDPpVg0UKmUrxKfeQkD
	khblNfwIeKE680Nxdkxy3HSXxbKgZFLDB7QN4yhb5BIYMqrNBGoIgsp1RVEab/8is0TmWF6OoRw
	42HhnqTYGkulQRTVlY4jZ+8No3Y6qPjCkunQesfgRcIQiW468ZklKaKvli4XvTg52zfyMDF3PX/
	yAQslFkimfU+sPCTnDCK1WHgA8F87qCetbIbo+mD9ktjn7RNHUfB/HsuF84IUPwOYmFrKi8SwQW
	o/8jDr8muwp0pA==
X-Received: by 2002:a05:622a:580f:b0:533:33c6:e635 with SMTP id d75a77b69052e-5369b50cfc9mr27447791cf.8.1792586190225;
        Wed, 21 Oct 2026 05:36:30 -0700 (PDT)
Received: from github.com ([172.208.23.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53698b8b4b5sm18304151cf.20.2026.10.21.05.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:36:29 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
References: <20261018041748.1655711-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v6 0/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Message-ID: <21f1d845-5342-0e5f-f041-c2ea815a5869@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:36:28 +0000
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

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39579186783

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/5539820b6985
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1188155


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
