Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AF355F48
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741501; cv=none; b=XQRe/ETRUMMVLM7DtpZFjDOof86b76/hAYVpS5MwmUIKIjw5S9r39QM0cwu+Q2gv0SifNqwyNnLzrUAhtX83zny5c0MgErhz3hNNzEFkWDNF5h8+kpbhfhkkvRA6teEa5CIpwXCQgmd04x4RLop1r4XHVe+6W+av2OK2Lo2sgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741501; c=relaxed/simple;
	bh=oh/BHobeMZo+uN+1qjzLoZmg70aY3DCkrN7vQecqk5w=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ri8r6OOR5njSi5QyK68fPA6bOFOEcfIIjTmHGYZpWuIQD/c3S7mC2bFUwpC2Z8jpfg4eKDhBd1cZ1i6gj9SGGp3NOblabohxmrGidkyVOS3/ZmZgo6RfXkXx/HDm7GAhTWbBsO1EVlLO/9nU4v68HCBJJxV6ynyQMfo+bw1zxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjdCFfsa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjdCFfsa"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-509149ab7d7so46229811cf.2
        for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 02:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773741499; x=1774346299; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a94Mj6F+OWqETDCcObBbX+tFrh3fjqli1iRAoq83qo8=;
        b=JjdCFfsakB+OHW00mJR7+06UejEqz1V0SVr6ohTwRO5vBbWHGRf+n753n/lzB4klgc
         QwHpRKaifxdX9HNje8vujTHbCXEbiB8cbT09Jii2fufhG+oMqiorjCbuT2+q4j0qPvU8
         VRyROf8gVlf+zCbA4W4xh0KYOOaMh+ZI9acYIHpggXyU+YRXuaoCAIOgMrpA2WCRGHnB
         Sf5uVzSwJvSMHlM2TzdXp2E84Er6s2gq4IBfx5uY8vfuKiN49pjK02U/+7cxoqiIjWuh
         z2DnPWumUHi+5kezvDnZ386luO0jGdpbc9bWHDg74wRN2Gc6nlFotpkz2yiCPiTI2UQX
         od1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773741499; x=1774346299;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a94Mj6F+OWqETDCcObBbX+tFrh3fjqli1iRAoq83qo8=;
        b=E2AmHj8B0v0TyWsUzHyRPfOsGhtfIroV230RDwxXPgr9p92G4OZu5HVkUc/OdXV05Y
         gMD/vssYcQqDtu/F1qWCdjBXcK2vnxJYEjC8K8CgTA++L784Dp4ZKYzbK+PrNHfZGpUv
         us3j/I3+qb2egAPRjzmfgNvpx6wHNNJ4FM6UhoDEEYyQZ4B5Dgt9worTfUhrSrxcqjur
         JH0wKne1Ii4/YWE9ipCZdAMp3ka9y5bOjryMEgPop3cT3IYv2uvY2f4umyfk2M46AEbs
         JYQ9oyz5creiGLjgXPRFLVOQ16fKG+AWSBOcPPSAtCYMy55pyL9sDCzJh771vCqFNCJG
         8h7A==
X-Gm-Message-State: AOJu0Ywms4JrRnzxdrax69tTZnA+RF5rZQre9v5Yi3qE0/qe/ZJA+8fi
	bDNaBfnxtMY0LQdct7e+QH3/wa1tVbo9iqXgOO40oTppQj/SgJtE076w3pZA
X-Gm-Gg: ATEYQzwr6XjEsyOubolD19QiYCf3YITJkDAFk9kjiFEaXs3nOizZEn138/y/J8lygLo
	iXlDNou4ifICzlpfcDqcw3NDPP6QUq94lwML3scoot+Y8Gb33p+Kkbd5Klz4Rd0CCmpvSxxWEwx
	6EUfQ8Q6IKeo1YArJQTitBnV9kbAEH4mwaKdx1GqlDc+5bo4NP/aCccJmfQAxY2JFNwPOibbx23
	x8t66ewv5enQr/qsB5bjVNffoyZBw1+pChNbTZPuMZZFKavue+vPBBtmvzp9YYK3/alFX8pOxAr
	Dv2laR582dgTQoJAIVB5AhTlE/Z3lrhbqyv44pgkDDid57sEqxZa6zIVOSY3iIzMqIk0Cl9Xkbu
	WvJp7QH4Cqo7HoY/j4bwCUZioi1aGHwEHEbDy6kjoBGPX+JDPN9h3X+svYE91LkXhzbMg4L9zq+
	9dVtO5fD9jA0TwWg1vkn3uRTf2uUPq96DCDtlMKphm26g=
X-Received: by 2002:ac8:5714:0:b0:4ff:b1eb:2d03 with SMTP id d75a77b69052e-50957e67f9emr193604111cf.72.1773741499455;
        Tue, 17 Mar 2026 02:58:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a0f3ae0sm135087721cf.20.2026.03.17.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:58:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1773735950.git.yangang@kylinos.cn>
References: <cover.1773735950.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v3 0/3] mptcp: fix stall because of
 data_ready
Message-ID: <59a251ca-246e-bd6c-3459-c57c8117fb5e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 09:58:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/23186215138

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/68246fd6f6f3
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1067816


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
