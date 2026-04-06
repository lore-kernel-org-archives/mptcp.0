Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46433263B
	for <mptcp@lists.linux.dev>; Mon,  6 Apr 2026 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775478915; cv=none; b=ifWzBKTR+ZffiBuok39Qwqw3iplZa4+y6zrDz8eH5kjpqS0MOmUO1nhwEbFNT3KOIzLZl0S8vTto4fEY4fP5ECFwR4STEp9TbhT3U45c4p+sWM9SyFH4wJrts/EtQ2DfKB9Stzmj24OmCJOHHE7hbRdegPnTC1QPk1zwe4RAkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775478915; c=relaxed/simple;
	bh=qhQV2A/ECzNJnJ3a3dCPr2KyPp5gwDc1g5iYb2WnnKM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=ous8TXmJ6eK39Gu6O0zkaeNH7eFjWXgd3h8/kwe0VVDMieFZeJYpLubJIxihTymNPEPx03qo00trGFONG9nQGp3+u7GSqucZ5SO9LBcoVk4WGFTCrqpat/3d+8K4RCjH2StHDatbYsSKyrlHdOBBd91565iJY02UYR86F3DMCvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0zle++F; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0zle++F"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899a5db525cso34028216d6.3
        for <mptcp@lists.linux.dev>; Mon, 06 Apr 2026 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775478913; x=1776083713; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7RWpag5vaV35UjjEfgo+f8VxE92VIYJvhneCv+J7ns=;
        b=Y0zle++FAPy9BHiCXh5/uFnUi7/W54A3MGLRxaJpRzGcw6ET92TWk5AcX4Eyy3dIfb
         B/GuW1Hh3mhHeXuz0F/hWakYu7ymS1SFNrxJ8wS0BUtfCEz2u9wWyUk5Np8tOwqs+kic
         hR2DF3xHe8i+4Y3+EGiOLv6bencWK9AGOKKEQ9MElywi+9hf8woqTEC3FZtuMm494zuB
         hAJHMnfKVqVbzzT6npkwKHyZktFIWsg5p0F5Wwyb1PgfxAb22eKVBJGC48fqycPrvdpw
         z4FvbT+x/zPZnJ9BeGwue2MFAWTtronUM8sfJjgP1QfV29S4m+/jfOuZks8wQ56c3SoS
         UIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775478913; x=1776083713;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7RWpag5vaV35UjjEfgo+f8VxE92VIYJvhneCv+J7ns=;
        b=V2DlhQ3TzrpwO3CYqQjEHCTB13ejvwZJfBISOeR52hl8g/wBEcMOfd2KqhkfvfRmf4
         +vTnUYqZYqoFauaSFrEN9gp3ZGUOGOlJtw99tG4tnFSkHL5/2EzZbO2qBtOBhrnvwH22
         bvkDO8jXkzQ3sX4HuEYW2flBMU006JnK/kfYoSbCKUKrRObUUjE8VD9JMc1ljpT0leot
         AWennWCTB3lPrwanNuoPuZfRmXC6jZ0h4TCW24VbKh2iLo/xx3DH6SR0SM5NzBaXK4/n
         2HOjU/4nd8cBG7czTHJNP/viLkIeZZtxqyNaR5IyVNoiWim+cGshJ2DafQ4kF4nVSJ3T
         2G/Q==
X-Gm-Message-State: AOJu0YxPKhzTtCC9oBb5spx3JVVcLH/BZ+gEf2vr/NLhs4phHEBMwdCx
	2AoPbEiOc4NmOWRYshz2Tstc7MN7DRLjokTF61YwHj+uQPW1Hwyqkg4tmz99
X-Gm-Gg: AeBDieu7DqYT/ujvhin6eXgDLaZjvanBSVcd/RxkSVzPZfru1qCHmdFljI09TC3k072
	Xu4Xnz9Rmtm7SOiiju8522YgwnbFC+MoL2MshATAuBlXphT5nh3uEldM5q0+3ANg1Thw9zKxx4g
	ztvRIrfGOHbpq/n0o3Arcli/TM9b3ennWYJXNy9pGtuhTVSSnEbIzbMImp/n+XX/CHVz6wdj+tL
	HKBG0MtUjButCTsEDKoBRqSsVh8+ux0d9AxdCeicBEigTPkxzVQDJrdVbXTPZyyPrSCtFlQRCrb
	OxmbPWRdaBUbSW4RiPBEI0vQ9wj4Vzm732R+sG40BntX0Djw3te1UE5PrPNKTk98NhwczViQbVv
	/W/muCRmM02kIIV8jZF3Pgxxn3D/04BIrkutxohPNdUs7lhFvfEQ2F4+Viaa4CZMQFqAvA+HELf
	XxxVkQPrmBJqs0BESKDMq64nXkp4ZvF1AJGTys
X-Received: by 2002:a05:6214:29c4:b0:899:efbf:9287 with SMTP id 6a1803df08f44-8a7049c75dbmr203005906d6.31.1775478913009;
        Mon, 06 Apr 2026 05:35:13 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a596e03dc6sm140621626d6.34.2026.04.06.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 05:35:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260406031512.189159-1-jiayuan.chen@linux.dev>
References: <20260406031512.189159-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH net v2] mptcp: fix slab-use-after-free in
 __inet_lookup_established
Message-ID: <157dc22c-113d-bc53-210e-fd60e98ad216@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Apr 2026 12:35:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Jiayuan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/240292=
52526

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/269f5127d03d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1077546


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
