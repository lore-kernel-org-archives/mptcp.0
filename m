Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81536F419
	for <mptcp@lists.linux.dev>; Wed,  2 Sep 2026 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336871; cv=none; b=Bh/jb+gwCNuonBzjmP7rQ9eh9ZWdTko20otFo9vHEuc1O2fSSX4wLg3O0bvmLtiJU4wH1W3u343k9Wd4fL1aIhR2u3EeiYT4T4v9zhUD8jjcrjLH5EDYr45RFWCAexrTIOH2pkxOTHyWnHz+hMRFrUFR/FRel8O8HcufGOSeMuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336871; c=relaxed/simple;
	bh=mDN9jYstaAmunHvQhA1gc+udcqlmtPTRT23CxJaO0F4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=CXs0LgPhxQHBfsxOJUvDSZsn6eDV2WL41p2KpOq0OWNHu8VnDUiT5H8pEj4Z1EjNkkFlYjqFqJPyss5jvIyKAcmXNfN7w8xO2KpDcs+8F8QqalFk+YvfY1U+LTlhGRhJH+a1l0/bY617ZEl4rshj1FGnvi+iHICZAzo1vaG3gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LszzrBhT; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LszzrBhT"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso379210a34.1
        for <mptcp@lists.linux.dev>; Wed, 02 Sep 2026 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788336869; x=1788941669; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H59EQRBBIRNr0PnHIHMjb/J7xexz+96hzMf3QOwqi3o=;
        b=LszzrBhTa0/skCEuxLodYOCaNzcqHHY73Xi47uyzsM5t9NTsCfIFLFGnTayOB7dp6j
         mPNapxJR8YZBRjLi7adI+IiT5Qb8cU3+P5OFu4Mmu3f6pOyXSka211Z8k9w2zW7TXQbX
         RUa84MlWEzX3JNUtNRW+Gb9HVbI8ZH2ZJ+eRYXBH1ZW9MmkulzQln6FzrJHB/YjZbk5i
         giLImiX+uZBtnJWhGkUdNiV9ubtCAp3qlHrwaXlX4yh2+STRBQyYWQiHCbaRDKXAc/xa
         zPsoeTOWxEv2CWZdQcCz4hgjqke33fGfVMcmR5q/WvdOCe1GktFMKAmGnKzaVwRaSbUw
         xNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788336869; x=1788941669;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H59EQRBBIRNr0PnHIHMjb/J7xexz+96hzMf3QOwqi3o=;
        b=SpzC2W7NG1vd4SDaB3Xi5ZVdXJuHtEKdY0KywOgjWhPPML4bchpY69KQd6dlPX6YH7
         XjNhR674gTuE++gNIj3vQANGNmpCb3Zw8pxHyeJKu7ct6YvqATI6yP0MdS0GOccST1EI
         CkfXQkNEWLgW1mrePFy6JEEY1BLg/N9oj+BiB4deahLdqA4T+3Eb9UaVEEGIBsv8t+OU
         bWF6bNLzr87zK88DqNJeCqYEkrmp83w78n3mXMzgsx8DbqiZZzhnjORXqqUKdsrTHwXe
         5s28LMEjBQ8YrKigY3HChxCiVHQetre7qC4TEZJOfIg7rEwTj5Fm6znHVmvZ1WA7ekQr
         zWEw==
X-Gm-Message-State: AFuF++muWYTq6s3kNcxXiy5VGAWZihPErNw1gn15D6gs11EmKdxJyVbx
	Ip9FQinaEDR1HQnWK84vXGR7mKwqJknXbcaLkIF8Ajyb5FgmEzd+zmUvAs+G
X-Gm-Gg: AR+sD11DeLDQ4tYZBsbatruTLqMQVvOrFTCuI0OlyBKusyGb+dZY19IV6cz3+Md8dNg
	2okOEQxtVdjy3IPNkuX3MqAkkOuf4txIi4sZN1F7kjgzOwOmL02yhBW1E1bG2j51H8VTzWtsvKo
	z60sDnpt/OrBzBal0aWMnVtyfP65FCSQ1R+bvDLQ8495VQAeO6nhtjLGLxrBYgrZm6Rbasc2WvH
	6C/MfQ3fgkDcSgICQb2Uk5+vQRHg79eaOIAsrNhu1/uQmzzVNPmbchig3+r+Cl+ykNX+9ooB5yI
	1vwkdsi86dABsBqINQmzSzAth662JI+ICoaSeIeYb+f4pSJIFZ892tZB0GOkytjilCAXURXohz5
	VWig7LE6//HJJ7yjYIPLNTSTt0rrEpnpEBb9Lq8SlHS5064s57aIGq9OzGatT0aXWuq7zv7Fr+r
	uyslOOkYgGbvSfZzE5SZsjqF9kEbZleQVHInb/ZAGpvxQk+KxZ6tEPR7U1itdBZKy/QaJ6Y657C
	uo=
X-Received: by 2002:a05:6830:81f1:b0:7f6:705b:fff6 with SMTP id 46e09a7af769-7f77f0cba5amr3671046a34.3.1788336868684;
        Wed, 02 Sep 2026 01:14:28 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.160.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f74fdf3709sm1788800a34.26.2026.09.02.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:14:27 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: convert iptables to
 nftables
Message-ID: <4725843e-7d9b-ba4b-0e93-3619bcfc669f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 08:14:26 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_mptcp_connect_checksum =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33602897833

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/72e85b05cb7b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155871


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
