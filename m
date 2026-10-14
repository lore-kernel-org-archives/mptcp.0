Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69843F926D
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972402; cv=none; b=hCkFE58CO7jWBz+9Y6hgmcsgPj9OHDRw0NS6FkmphNbpFQACSoU/V0pE5cEitUzKAGAtlFGtnJJFFSd6efkarsLw1LMPtk1kf3AeCbExTD/s8h4FeViouORs/fiQbr5j8D4qp6VoFwOOT4ai491vCWrtUJ/U+cTCVb0w9JFfTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972402; c=relaxed/simple;
	bh=JfIbhTu4vHjU8D3Ff/N7OzoEDjqw4ZvSZ/cMW3hlsjc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=CaYyGbnDGUVGrktIgyq3Zy3WKK3OJBNTTel+j0H5JLQUmjC/IqfaloNnxsZBY1SjkQdiQ2VPUGFXZfIDc3nY2ENFs1Il/y5/us68xBNfa5HQ1+GL5i6X2WWAfhPbNYiKMkpqZze2ZQ6TIZQip0E0z40zyLVEyZ5zVYXQUznOmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4i1AM6b; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4i1AM6b"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917866225aaso56786026d6.1
        for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 03:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791972400; x=1792577200; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7OIj/dVl/ALUGhW+x7g6WGBENbzgoJ0pto0cqiOO5Lg=;
        b=X4i1AM6brpUQ4+K2FT2D8iTopyQcMOadM1LZwO9momyBMwy67JaoaI3scH4hQ0RmRT
         NduN9hWYQH0Col2fFLsLDvebM17sTQcROZxQazxC9aOV4HgE3OdBamguobzCFywWAD0+
         qGl60JAgpXyTaXiE6ve5GbXgO8mBwrwCE0Tltz+Ck6Ru8S6iOFOkY6WH07D3YN9V0f3B
         DWr6rBckIc444zOBKq2JhrRI04I+klqq59KiBjeHQCsmaUOXcgwtvVuZzVk6+xlUpkq+
         EMyIyM6PZtyU5+lEiiJU/IOyMhY2mXMSLON1FJqXCqleWjTlKG+nXbBjc5q3TI8PCCF1
         +Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791972400; x=1792577200;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OIj/dVl/ALUGhW+x7g6WGBENbzgoJ0pto0cqiOO5Lg=;
        b=hZhn2CiccGNf6MPz0Kwz/qoQIEno2BjPo6InZ1Fb+eqH2tWlNbFtk9Ukz5Uifrirmh
         ShlTFxJvthbgbSKoiY7U399vuWKgo72frPZRD6Ad17wUispDg2L3PTMWyArkZrHhqF/W
         lFmH/DwbWAFFgN/oi1d8WB518e3mDG8Mn8Ecpc8TGijJgz49gwacT5FeAMSlISc5VZxu
         PIQBrkYcdXwfPb40Cepgd8byJj99pc4XhF+AkJUHxrtk/orSJ1InP/tXwX9ay6lu60En
         YKFDm3rBr/1SGFteYv7YwkKkshCzFKZq1DNIwrzPK74rbiKwlTkoKLox+GaG+hywY2Bd
         mXCQ==
X-Gm-Message-State: AFq9FYKX1Fy0wbeup14cjjKY7djLZ0U6ErKsMC2sDDzvBFrdLxMm7vMR
	DkvSSrgMzWsWY7LIH79YBVV20lKmRX4K6o8jVpnwgEJdIcdCSngEjEX/Py25
X-Gm-Gg: AYBFou3onqleXi0Y6O06MnWfbC6LEBB4U9DcOc29OeCFhMZmJfFBTBJZXkhgSiql9TO
	3nIORaA1VpmgKIgyMqr3x8HJDDo6LWabqKzZyqru0ZXavS5Y8ph9fngfOL0MzMVhcm1eTiV3ZnU
	/60fOeGBrxDzbPWiXRteo3x1qC08MLKDm8pxb1jMZeQGJVylv0C9J7vzEeo2pYJoRkhawfMt8x+
	iEsP3WeJhhWP3L5G3PQrrgGOmFpZPiDjd0/5hAuUzJKzseDsl0Rr3F9o9nDOdj/j8e9IQ3dEElG
	UX7pcDqQvY2ecR2UBxy6Yx8EUtBcZkduyefYZ7hMxKy5xjPeiZrcDdOXCSzQDo84nm4YfpERgyq
	bw6aebFQDBWQyifpgigMXVR4T3jK0AH5CdoJlxg8vP3KSZ+GajYJt/GGQha8e1IWbbk3Rgkb+c2
	hwPaSrtL6mO4Dz1cQi/xKquqecpTtv1fvbGzMPEl/qZgkQIJMBmR3m3MoWl72jtmhdPzP24ScmJ
	gQNZOGMrkKe
X-Received: by 2002:a05:6214:2524:b0:917:97f0:1bb7 with SMTP id 6a1803df08f44-91b55335385mr249947276d6.5.1791972399670;
        Wed, 14 Oct 2026 03:06:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.99.11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b622bfsm48781026d6.24.2026.10.14.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 03:06:39 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1791967771.git.tanggeliang@kylinos.cn>
References: <cover.1791967771.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/2] TLS disconnect support
Message-ID: <c5bd4dbf-05a8-3819-afd0-29fd39fce43e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 10:06:38 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38541308008

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/cab552cd4a=
4d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1185404


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
