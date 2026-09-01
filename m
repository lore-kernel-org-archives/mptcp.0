Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD34471CFA
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788259236; cv=none; b=rF2/AANX6tDWW7dRitSKmyHhzya8C8UyyFaJde3o0scSLkzfKFdehpcF8PCqWRq+kC8LQYYyazjFGzFUCqr+OrJKyZppf/7dKYXR7Tu88SZ3Uw0fQ7ziYaQ8lBW22t8zxEVBqQqtmUmAqBOvFEro1mM6zGiVgDku06JQkG4k0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788259236; c=relaxed/simple;
	bh=grlSkWZvbRXewWO9La/4qojB0fMyr07xYdn8F5cGQK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=GU8kJxYwQ6AIyKrg8w9EcDnKS7oHs4GusKX8ns5yaV5ioW2slBWxETv2whOmBTG6ps8J7ZtBRemgskDM/udFMxOlQYsHoY/D1bBdkzPwGRxWCwgcAzCdPnKsQq9wfwqbAt69SupgHVAfteumu+ypK89DyQf3bhRR1nBhtxC0yQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J319UNFY; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J319UNFY"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7f4e596e393so596487a34.1
        for <mptcp@lists.linux.dev>; Tue, 01 Sep 2026 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788259234; x=1788864034; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=20sH2gjSCCyLenP9c3rNSmvhTf0LjX5bNrVi3VjWmX0=;
        b=J319UNFYe4BVl0mb5qUHpZ2/+wNZrP2zJuMnoi+Nd5ioyGCJHYyl9805sWfRv2v74E
         Q4NKylzP0z+/rv9In816lMQUkQwpHyNmlTEPsRy5TCbe3qszj+wf+b2T93jugjsBEVhb
         VdbMHhvmLEn6gVGgVdua4vE6uuymgpcgO/KEoWtE7qrcQtHe0zQT16rg0noOMdx+niPK
         bDWuMSt9+W7sJOhF8F8l/E5zx9QFnoGSVjQNdFkYf9bR3F4tnnZ6gC0teacUQOedugeH
         PlgxH4DiAqdje2aIEz1hQuZO7BCtpnD/8jKxZaV2fkANLWa8V8VntXfy12qdJrC6ch48
         5RHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788259234; x=1788864034;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=20sH2gjSCCyLenP9c3rNSmvhTf0LjX5bNrVi3VjWmX0=;
        b=DDknklmylUcqOQPKNm7CZ10EHndUIw35QWi+rKRup9Lzmt+c6Lu5v1pAUHHBrZHPnn
         XOvik51ly/8TbdzzeyUWTD8l7GWg7PBSdzSYWJGAPiF8Z/lT1IOkj2yNq7rkQADaXelR
         UdpyqpR4nODH4dRiQiDuZa3vcaZxuoIXNLkulGoiIsjqYBYI/kyvhv6XKTVtc9a7w3yh
         0xcFpMoKgen/7C+VOBnFs6uGeq+zrIE0IF+7SNtBketsrMLI/qICiU7fWBs4Rgsbba3V
         H+hbhkJ9Ac2hVB8t3jdnpDS8h82up+62P1jV8+c3jKuXT1Qr78MF8geVEfwUgVFCRt/8
         KCkA==
X-Gm-Message-State: AFuF++kbgjgpcoHwnB3JcSvTa0nh1U/J7wAb2sViahRq2PdH/cPxdJU2
	VgOCAzSliqeLpSiO7qF/jrP+oXg3QLWWGk/iZp5JIR9mdAHesk5xitMc1np4
X-Gm-Gg: AR+sD10T5BN0dsFo0N8s8+RsuGHMoYjeU4tMwQVmlusAtGxieC8l8Hr+5mFzRwFOuFs
	8lfUHsRscHYRpwdfFiLHWIuClBSntohl/FpybNOnD5+dUOtapHqDB6Xy1nmvszjzTDuq3+YQ+rt
	Hqr7yJCsik8Chyq5WImlF+SGnAtVgAeV8j2THWdbl4S7RapKVjoaI8JVVqhz4n74+eN6C1Nhu0R
	q0CVB1Zk/y3A54YDHoOCtGSSQuxAKM3CJ9ht4e+yKGUTqLRENPNzeT4Zk9w9FvYTOkb4D6KYFZ/
	CNp9PXfw+eJWdRz3uIOkNTpzX3vstgCXAz25R+/nUJyKreS1nPEake6BzDGpk/h84SNZEfmAm5B
	eEX9TI0s51VhmVHOvqgaNYmaENb1AdFpg7zKH/pjsLZ4QECP/ctqVicHTulrXy5p1cKHn0Mlqzx
	mXhicQgt4wIwiThU72dSzPkozw/+ezLOML2MDYkAxevBPHMTHuDXOJ3n6IOAvIBIgTgP5GlZPQW
	Q==
X-Received: by 2002:a05:6820:f185:b0:6b1:b771:bc43 with SMTP id 006d021491bc7-6b1c66ba94fmr26675197eaf.23.1788259233952;
        Tue, 01 Sep 2026 03:40:33 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.38.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a35303e2sm11982139fac.6.2026.09.01.03.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 03:40:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn>
References:
 <b67dec47d321886d45fdd2bca1c303314fcdb229.1788252583.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix skb_ext leak in fallback mode
Message-ID: <48c5a0a7-fd08-7664-7d91-ee28bdaab98c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 10:40:32 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/334916=
20240

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3100cd00b910
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1155169


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
