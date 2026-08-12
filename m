Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35263FD96E
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533426; cv=none; b=oBWKmmMPdQyG936wsXTF7gGTLXxumgmjcnd5ybNZznQB3Hh8+z4sHgFdEoodwKbRr+HutIojNyloST9LL4/cmMOD3q3StIfBix3u5j9jiH2uPAVsqOnlsoSy21fRqNuJblZe/O3TIRx8n0qSqz3Ie3Xi1nGxYG8avUzZGo82/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533426; c=relaxed/simple;
	bh=tHtZ+k5MVOcbRufH9mfnvDXk3u1ZWPOAPhxYO5241EQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kgf1DOyh+EfYmCXUgww2idRvLDwLala6Srrx4kPo6ty9x2NKj+rrbPW9BN1QK+13SYCSx7EqXo5qBC+wYfFJKfVQd2A9dQfDoA2OQ+hVGZTaIjKu7qWKKoew+60L4ZEOnETjqw1KRcNgflGXJ+C5ZX1RfzVplDNDN7BrzSMDkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg9IdmcD; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg9IdmcD"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b21f09ec76so6170b6e.0
        for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 04:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533423; x=1787138223; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qs4AJ3/cFPSoXMKmUhJpZlv4OaCzaC4VL6vleF41duc=;
        b=bg9IdmcDxrpW2OAn4oRWZArO0QKELHn8Cb6SbPDh+y9LJwU74tqZtnQj1PGSKeZkSr
         SKPdw59/zY9J98kKhK5wgq08E0GZQDgaK5Tte1/+5POuyn2On1BETeOf0sh8CeeVEjf3
         mpZw/Yj7szM87K75Lnca5l4xzlOjARkp9g4BUSuzQNxJmdbZJt7VhlS3ITpP8sW3nqa3
         8HEmyueI5cE4RU3F/kewrH7bnoR/n1xfVXGObmlX2Tfj3CwINMxQ/IIvVEg77zlgz/OC
         3bNhpn3b60vkkYHRN8+TVMaBMovbzZMeS2snrHqvGeqmHXYjGv+zaicr5i/APYAOcBvz
         UQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533423; x=1787138223;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qs4AJ3/cFPSoXMKmUhJpZlv4OaCzaC4VL6vleF41duc=;
        b=AN2NugnxWIBCO2eC39ootc7E7mUN01dRxZ0dy0lbfKj+WJf6Z5AgNHmmari00ddCG+
         Bc1pFE5hRJOWAvqDcpHHf8JI0JXSl+CbmDq2YmMa2+2Z2tmIXaE3HghrXkApgaYP5Bzu
         9uh+9K6Fa7JarbANvYh7Qntlelb3HJF99OkuDwDQ9Ht4EzSBDcud0UcRn5l6LGStITPw
         vR/YbLC4vI+WVDAVXM/M1c7JaxCQfx+0ZkP5VjJqmSCPUuSg92ok4Kk0Cxw6mubg9+kE
         xUrKo1cTIDkN2vBcTB7412Txb5qBUuY3RJyVQi47T92bW8nx6LwmmfDmnq79NRQxtuaf
         Dtiw==
X-Gm-Message-State: AOJu0YxZvDUllIl/CZMsqctTmWa27WAmb4rP97hwujD9DAtRriVSV3hR
	0UniQ7shcCATg/CNDmo/bCpdu/PI4Mc0tB10kg57gDsPxcx8CyLfPWjWrRNr
X-Gm-Gg: AR+sD10/UAZfkeqwYogP3e4buouo3PUq4OLdW/YOhRsUppTmF1vNL6kCwoRdqEwDhli
	z64ULF8Ybtltg7fQs8IiGd1LeseO0IEiIDIqzL+hCxbAX8ipbKtoL6svRr3yntzURkVGz4ehCwz
	5qCre8pZ770ZOuExuE9jbEQ1NzDtM1/NXhBsSxuIchLPfDykZOLcltWi0LfxJzK52iDyBLJPy7v
	4MW6xbIQdoJ9h555cIXWI9Su9eqB6edZYCi7FhtLTwjYPPng2B4qeixi2/MwxhYxPp4QTEfHvIW
	b9F3xBPfggRUeIPzIXAuqy0+otmD+Vecg/Xloy8Fq6FoLIfamOO2NsJq4rXwoZeqmGvWZLakk+x
	c8ix7tmZnlaT/YdEt+r6K38Milmtkq5FL1Cjt6GxbGI9dc3t3XBPvY/CHgvHvs946wbfwf52Ef4
	CsZaUwiF5DnDsF+4gtsQd7UKxIwSE+Q+UqTe46sQfRzGLElaIyZW4btqLhcNBDwUqB4d/uKEl0K
	ZU=
X-Received: by 2002:a05:6808:1448:b0:497:d3d6:6a56 with SMTP id 5614622812f47-4b2105ada34mr2783770b6e.0.1786533423342;
        Wed, 12 Aug 2026 04:17:03 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.232.69])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b1fff4896fsm3006608b6e.5.2026.08.12.04.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:17:02 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260812100550.148670-1-gang.yan@linux.dev>
References: <20260812100550.148670-1-gang.yan@linux.dev>
Subject: Re: [PATCH mptcp-next 0/2] mptcp: MIB counter for invalid option
Message-ID: <98767c99-a129-5ea3-b39f-dd155e51ce3e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 11:17:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/315878=
59371

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/cb85dffafd7b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1144623


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
