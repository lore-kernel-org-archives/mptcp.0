Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248A23EAB2
	for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325471; cv=none; b=eRcoMPa27fmAFhmg8XIge1DZ/unbXy0vMw/bCHYBB9HkKCyQ6UNiEBCHO3E9BTdjAd1wNe9Po52fZ/jDhZloTbgwipO7kbt8StoEAvLYl8jXBwWxGxVpyl5nHF+kCvt2+Ky177FK/pTrwIMkTy7ISEQi1Ig60lq8RrTTk3oHpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325471; c=relaxed/simple;
	bh=ZbsVw0X/31cVRCZ5a0eatNPoLURQfiopq1erXM2OAtg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ttdAp1O7x/XNUPOxyc6Wg+qD4buGTBOLe79wiu2Rsux5pgy98/u/2L4Ndwpa+3uHGZttiMgSjYGnH11yIH40P+p4C/fyui9NiS7n0xaeXK97hDK8pGyacayKJ/iJU6Zz2aAr4Bz4cTzLxMiX876v2lmRo0mc8U2IOG0RjuwRi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIhGfMb1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIhGfMb1"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb3bae8d3eso952415085a.1
        for <mptcp@lists.linux.dev>; Mon, 27 Apr 2026 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325469; x=1777930269; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=On6OfFpFQVSd4kvK/YJFVmZvLPp5vzBPY1Nq6v0tWHE=;
        b=YIhGfMb1RNsWJBqZCEwJyJuc2XKajQaiZHnORZLXmYq2eC2FKvYRDeXT4UFDHooC4F
         LiDuVqP9wma7a+LtQS6qUq38SLNEo1AlLWNb4FOPVTOa7Cp75qLP5kZ/n5rChas4dzm9
         neiflrojtSFN3Sfooqo7Mq+9bqn7pb7ksgmGh7YyP9Q0hGRfzSW23lbBWOizTwNMZrE+
         22D99gZGQ++vpUohzUSQ+Sf9hs4YCNSqzPTOW2Bvx0oMG2AT6xwqGuTvoMKqdWCFzu+2
         SnDX+5aiBVXqGbWFTh6Eue7A3S3Kvf7DA0oSnG8Hw96vMRt5qSu/1OgQg3cEPvhHT2xP
         RQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325469; x=1777930269;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=On6OfFpFQVSd4kvK/YJFVmZvLPp5vzBPY1Nq6v0tWHE=;
        b=o9MGoRLDYUwYJpYZl3IgnI6NMHIdDoP4ej+D+A8zwLYUtvZDr6zwcJcqfp3+PZejsS
         qx1qdugOsl11NukIXu34ixwikB6yQ2tEBVUqVxlX97NXMI0j/GH0+J8hBHdltRYuc7/R
         /12VkxjZ9TtYtlIfxFfefMx21tTxAg8tgap2ojAwJyuXYFGWvZaIO7ciRMGtT3kx1+JC
         bU8ygpNzIxCpSRbenXAWY27cRrQb9dSh1AofQGhzMluJCQnNdLSHPecXsSKd5dUkSf22
         534PVlB+B1vg9+U0wrdWeUVFrbpt5+8E+cLKlLKMxWtjpKTYwp0k2oznKfWi208OS2CW
         Rbpg==
X-Gm-Message-State: AOJu0Yxx+XBSEkFdMbnUQ7od2kLttPIVAnRvfH7X05PsxEw3gW1Gtgcz
	eOocYkMisX7po66YVl4OkxTB/YtMiIZsHayXL/dpuXuCpc/2Hl7w61jr6pMc
X-Gm-Gg: AeBDievYAY8IBd7e+g3ZMiDHjINgk6iGfhFDAtcyk9bQyCLOQTDZ3m7G1F0g4JVn3pL
	8pUmnAAMt9zyOhJD/XstAUsqdCDgVoxCKZy8gWU49pB2bCuPISp+5yxP908j73xYeT9by9vdovV
	lA2kcl2w3Yy03Bmk36j4Sh4mxXg98ca95r9X7zyifqITX+Lu1XLra7wh6cWfCP2qCGx0YDc9QfH
	qifTRfKirO3opEzC4Bx++U9f/kOITNY6TBpbGWHQ+jN52lidkvOlnSifgK97B0c0zNdHE6k0giZ
	68K/r/WZQYNSLiuLbqBKjrMThm4+C6NcUuT0iBYkMT6DieJDiM/U1CfFIGF59s1bdtMTYwL1BGO
	QBVjpFPfq7Nn/HL+kkWj/RT/ZBH1sc0/JB7/z9B3c7lf6yy6mKKRhy7WZdUjLv6SQWF7ICtG7NH
	W05VJFURf6oO8SkBgSeCm7PBkuWyO6QDIZwHKjjeIi92jOYnQ=
X-Received: by 2002:a05:620a:29d2:b0:8f0:6b91:a93d with SMTP id af79cd13be357-8f7d9702bebmr47237685a.42.1777325468625;
        Mon, 27 Apr 2026 14:31:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.237.143.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c80cd39bsm33287085a.32.2026.04.27.14.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:31:08 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
References: <cover.1777318959.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: address stall under memory
 pressure
Message-ID: <bbf8ef2d-a0a9-8051-763c-7e1a6a54890a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 21:31:07 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss selftest_mptcp_connect_checksum =
=E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/25017102382

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/423dbedaff6a
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1086404


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
