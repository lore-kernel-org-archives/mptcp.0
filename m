Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB92332EBD
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873814; cv=none; b=am+SUCZGOxYRv0llvFyGWOT7tkWQu8Sm8aFSnfe5oacGMexucFabKr8/czJIQVLIZQaVaJRVdOOYIge1iLOdxGfLkOM1U1LuDWVOU/1ib+NvLPozGjq9MYwrwjdWUiwiok15YilHcgWzMAFAjg80S/XmUgCArAJ2tmRiwlEk+H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873814; c=relaxed/simple;
	bh=sgJJ9E+ndytfJUmQytG81w5lCIAnQTflddl7x02Qa3U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RcW/z7QWwyjAT3qkNIsY1QozEkAO5ksrqMv53CfvXBvQ7BHcKeXNAN3L14q5riFjxdCuDFZgezH6DsEy68rs9nSC1yJv0vV05bmLOQ26QFD1KbRvIDuo+8kZ+Rl18e1tLkFCRTa4BhmqQJgscmtdoG/hCcP/FwKbQLo6P+4oyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBSgaLdi; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBSgaLdi"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2dee127b3c5so7290727eec.1
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873812; x=1777478612; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHlbKjw4HQELtZFrSUBET2SfkaG5iA6WjbklZVrJXg0=;
        b=IBSgaLdibhyNthAKSd2bEfP6P4I4HorAsJSMqZnXDqdY1FTa3unNp9lNG1MmDUjfPr
         fP8+d8P8tnzZAT+zpIxCwcdDA4nxcmdOPXCN9Z1mXd6rAaPuu1BQ1zAtlhkyEKFGAMUv
         QRPyYsIwlBFthHjqSULxWRQEgyeGsNwTN0wPh0KU6N1e7y8IC8yoapa0XMAuQnKRovWk
         zVpu4dYdjVMTtnttSJubXcSfmq82MfxemooPpG6dQz98dUL9WRZs1PGy0dmCdfLeuRiJ
         880uODh0zgwC87d2Ain42lwdApAkuWpI/T4Min5ur61H1VCclPCnqqDlkmfny8OIMNnE
         7XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873812; x=1777478612;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHlbKjw4HQELtZFrSUBET2SfkaG5iA6WjbklZVrJXg0=;
        b=csUZIlM6qvhV3K08/PeEWfJ5R+2HYStyWcFr4HP/48pLLlYnZax/oOL0yx04ho2+D4
         CfmkTS0xW+zrWtwiz3aMWf9VOZkz9RLrcgW2y59l9B5i3Y8tGQXVkQ8ppykDy8Oo3rWh
         GaRaWuRH/Ts7dtEiHF5WCxkFfsKePd25HomOZ2BkgaGZ2k3qY5zVGgLGL/TOCDVX12ud
         fxEXMSXJFFmCwsJ6dBMwxxKWm0FVFwwH64AGooTW/CVLzI520tLBl0xWVaQ/RUYFHbQW
         HTDnz+I/jQzINOdfF7RZZi/xzQKwbIkQG1urPLLPlwXqIyeLdItaocQSKl6fMmT2BdcL
         rMTw==
X-Gm-Message-State: AOJu0YwMlBhUk8syILz6TPPOCwWQCEPSNeExyiw4r+E3rv2f+5HdAYfi
	AozGDaCoIOaITQ6SQyhFO0tk7OrUaYxwKbBUxuJnuHnz+MTegDOCNQU=
X-Gm-Gg: AeBDieuy9ndtj/C768Qhj0+2IoWYS7vceeqLW1EHHoEtdJtafzQE32dU2RYBWmyYL33
	akgpavluByERzdn8cUxyfv6omzLdncUpe3YvPXvFxC58OshD50uIHZixkmtjT8KAglrSjdhe1ZH
	T2WKo2c2/RfRox6OkIpTQgvzKVuSFRueAf585tu9Sc2qz0LJGXYswFiVzPvhpNtpTK4xSV9OCC6
	Fr4S8HaY1JVuRv0LzgK0xKYWP4qWEvwcg4k/4rcdfYt9BNeAWakYDW6zTe1XJmkQt7GZxRVSnC7
	P+0S8cYl0u/WX6GMxdj6uCG3aVITkSwnvYUU1UzJTH60IH+8uabPrz15S/Dsa2uFOFF239XE8nf
	KD0P0qWDFMGM0EhPFoS23+6sJXEwRu17RA7+dS3bh+heGckjcpHGBn9UfKNIMR/EkBXT5y5j4tg
	LFj8Arrr39n6Z1+8LB/8PrOf3yE7Kb5o1Nc32D8vxVeUVqfVs=
X-Received: by 2002:a05:7301:4185:b0:2c5:60d0:701e with SMTP id 5a478bee46e88-2e464ea8930mr12747479eec.3.1776873811663;
        Wed, 22 Apr 2026 09:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.40.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53a4a8018sm29920928eec.8.2026.04.22.09.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:03:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
References: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH v2] mptcp: do not drop partial packets
Message-ID: <acb99e61-e65c-0bf4-49cf-065f1dc99196@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 16:03:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Shardul,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 3 failed =
test(s): packetdrill_dss packetdrill_mp_capable selftest_mptcp_connect_send=
file =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/24785370107

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/8d6488282da0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1084324


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
