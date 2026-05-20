Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410233263B
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256411; cv=none; b=asu38HfLWe2Ijb327RJiJ4H1PLxcWBxtbhGom5lIeBGjuUz3en+0hO4PVi5wb8m7ss4cwxORvmuHXgdTM1VUeojKP5ZUDycIcX43IAg31iKG3Rb+MTbCwDF2s7gIQ7Cl+zvixOH4mxSCzIWVqwCzj8Q0UANQzWrNplpdcvw+EDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256411; c=relaxed/simple;
	bh=iBJwccRWEucEpzAzS8nZX0d6tcMfVy3w7uyqFSpsmqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=H8rK4QA6/mOWbe0UmmcqdFJnGwo8VBLgUjsJBO6QgiVFg7zXF3t0L8y5Cd6XZQMdY+zI84SSZwV0EVJSs/CLcN5AfhLX9RmczC3Ay+rck5ScPMjePx2J8Vlpp6yLZQC7AS4ty70IEZyRcU7WrodHjtkRxtUhLKyDuiCeMj7v41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2UGYBLZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2UGYBLZ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9102e90bcbeso502869885a.1
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779256409; x=1779861209; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nwCdvnSqvzBzybearHqjtCu67f3FLvi+94svBpFoEs=;
        b=D2UGYBLZVw4VljgKR3Vto6DsQHoHCvBFPOuDmeNUzLHYWDkTLYVZnC29053GgpSkGA
         WfG/dKI9OMu0nZLnTgDk9uQcxnYox3rz6fMh0bA76buugrFD1FS+/geJoAxt5flP3/Iv
         WbPZjvWen6FOmHfrAF86TmVjHIvfuEMVYXr55iNr+ep/xIDf34FknoSsvPKr/4mT4vF9
         ldl5+LXJKq76f9JNqnMBh2rpwOUk78CSI85txGEZRst1QNpIRG/Xxeqopc8Swqu1JZjB
         JjKZjOHfUKW+hcpHO51ygQvx3KhTTcOaF1OGFJvfWn9fMhI9Ptjm0jc6CVAviaqNX2X4
         xt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256409; x=1779861209;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nwCdvnSqvzBzybearHqjtCu67f3FLvi+94svBpFoEs=;
        b=heq7epK8xbqLfhsPPfNuKsCGGte4fD8IL+Q6pmY4XvnDep4Wp67H/0c1yp/x4x7j0t
         wShh5TWAoR4GgMGX5UzkCWIBi/WKHfSaRPDzdhvIYN2/NZ2siwtVag503WBwA/xULZQG
         w+dKE6hh3AqpH0oKXHjVxAYA25O5Zkgr5vOkOmWFqBWUgjx4PC8JMX0HmTV97yMnHg6t
         ek3mUECmFZ4etDPgm2Gkgmv7Ey6DiBF+R5P0ax7iIQj9fPXnY7/181Z9vyO0cCOjXc+q
         BE2953cOU5sgfchTOPCeUrndRmeUFV6juHONBoRh1yb6QxaOpzxx6hneffByi41Qr7Kk
         vdbw==
X-Gm-Message-State: AOJu0YwjdCY+cU+c6WnuXuuDDkfZk3D2fapes/eAykvXL4+QaMYkL0Pa
	ny27P0birXO/mAIV2j0ufO/DkQaTH051eGFJ8Ad9UgfIezIZaa8mC4AAhAPhuJw=
X-Gm-Gg: Acq92OFtzxK3FUlmk63cHoi+JcFXnlSkpZ1MvFDdmf7USA3xeIqpm0q0ohmO6nUZ/su
	Hsr8bu2TMerN3fsLZviroADFgjkwVBL8dsO6C9FPNMzbrwA7BwxbSbP23PT4kx8fSzREQSZDCch
	VFRBzpr5QtasFkjYmggKo53HGUgsT4LyWPO6TiOfGcVefYW2ZH4g4RWyA2Dxgry0WtxhcDSxLcT
	zm7TWEPlyXF6YMoChSrX+CIK4pz+vlGmCFf9NiHucHbmPBuKwpn87EUKEv21rtTP9IPu7n16P2d
	zSZXS1BqQRc254gXFu6pEtsA+loYsTW4rsAjXyPIJnJNWE0F8u1KCUV3PEvRggGBtGOKQ3IqAsI
	ELJDRHS98NdHgVBHLKfncM8O7GkngkgtD2YZOTh9xeeVXzKUpS7utkmV6TCNTFlqkfMKm6GXMmP
	7FVonbOBTRJqmWE5V6Va8GfsclBLtAdFXTFXZ6jw==
X-Received: by 2002:a05:620a:3d98:b0:912:671b:d0b0 with SMTP id af79cd13be357-912671bd4b8mr2041821985a.34.1779256408662;
        Tue, 19 May 2026 22:53:28 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.140.232])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910b785935bsm2046817185a.0.2026.05.19.22.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:53:28 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779249906.git.tanggeliang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v15 00/10] NVME over MPTCP
Message-ID: <ddb40e82-6fea-e74d-4035-5f3deb5afc1e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 05:53:27 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/261417=
00754

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/13213bb8aa76
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097717


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
