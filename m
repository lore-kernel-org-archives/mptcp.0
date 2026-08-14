Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18C3C2BA2
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719546; cv=none; b=mAgUDJCxwgUH/gWRf5vW2h745v4GuOIzsWfUu8Kvz7MgvXGjgT3ZJnlZYSuAgjk+YNt695jheUKCXCLmyPB0dDCQbCJHYJuRKLd0CR0WwQMhoqya6jGIulV1E1mY9RftdHtBg1uFn50g7rIWyaON8uR9Fzfm3eNzBxNh0Tcw2G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719546; c=relaxed/simple;
	bh=j/Kvvx71E2R2jHFOxWQ7t9dpFfqxInsgEIKXHMDd04A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=flKAzYULcZ3mRlXYI6SMqU2VhgBBHexroSv1Z9qXeebiYP3wvBupagLON21TYRdiNJBbg6FaehUFEzL8qbwwefrFn5GxLQbEyFcYT4pySiY0aCHEMSnwBgvanuTp2llXy4ElpKZTI1KjWKbDfMIcaG2hvsWSEtMY7j3rOba5T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4ievGmF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4ievGmF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cedda2ce6fso8028905ad.1
        for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786719544; x=1787324344; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BtKuLNBM1xJZhPzMGXk5kjsR1RGq5nRcXq/ZaTMwXH0=;
        b=p4ievGmFjpjr5hTtXRttfCZC5exlSySf5WgeB9Ttf3UT4yj8Pp+WcsA9y9FghxeGpt
         6Li0dG0exD+mWxfZa3rSbPMqNqjSNv/dT9dweMWO5nZFBtKGNapPLyLSaEtDjJTzgM2S
         J43bPr1ZELNA18RvmBjKaXnOR50jxVvqlyicI6IzMFqpafUROnrSRIVpxfAKLm7aAyaD
         hI9RfrpjaeRgJxoBJhwLe8f8Z9kk1bawaV069xWidaJim51NUdAO6+bSsNMbXdjYpu1Y
         JIGYdDWgAGOspBxfwCVM9JPDAoMP9W32BWfJqthwhXEvrw9SsRpvI7RsV4DBI3iQQeAV
         TiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719544; x=1787324344;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BtKuLNBM1xJZhPzMGXk5kjsR1RGq5nRcXq/ZaTMwXH0=;
        b=jXFF9e1rRfjuW46NQUu51egJqGjuluvIPbfrmRLpS32vA8u3s1UhYu8T9PBNo8UTHh
         21tgBKsifCAQpnrpoX5u9t94DP7HNgiaKBLBnCXYsTu6PpmjQ0ZcsK89Kg+tdYdr+5Ea
         5Q3ZvPxO3Oeg0PJNZyx071mAMtwiqUMotjVbfE03AQ0Cl1RedlBZ4K0uvuw8Bb3461LT
         j0VdVhrvmywJZHtlPKFFXpKAT/FoGsVsClB2NK+p5MqK/X3+0Ge6q/v4+/mcdl9EwWEC
         gf6vhGCusXAVsTdlfKJM7NXWGRbrANJZwK4M49vS4q/1pyDnztnEG6gtZegjS/ea5ac+
         QzXg==
X-Gm-Message-State: AOJu0Yw4jt3a4omzVbvGbvVlhnd+PDWjTnHGXqnlezCffBP9lfHhhevC
	n5j1AJPn8ZzuqRTDXLRgcoZ4fHjxe5+Zra8Q7DROjzFBM2sGItug0OhzQoe+3L8=
X-Gm-Gg: AR+sD12m3iaQcJnfYydSetw/NvW8OqITSckZ6JQtUE61E7HNdh3MMneRqZ6xb4fQxB/
	fl+lxU68Lslbu07MykNbHVH70jT+iatKvSDCumwppNEUqYr1aKwkets2oevH2p8ozRT5qTyac6+
	m6PTok36IyeQZfQlyhtdwrr5yZ8nL8s0SB1SFcLk9fIOaY60IfSsaBiM8zP+IU0avFWGb+gpfwl
	DorTIyYzF1Z3mYpsJA7iwXaezO6Pp/hRxHKSnQrN4Hcx2myyYjYGylDSL9nIVbedhGi1hOPVL3V
	qShjOtxPwgsZwjkJEWAOk8Acln+qAZ6wG+d7mA0Ju+evLz0N0Q4Kjl+jmxznvlnx0teYu4lgbtV
	MisugImcyLvEIx75jEgBp+h7HPGia/QvasLrcngOk5/tl/LbuXjj3muKP7hkEX4Dr6ty9/armob
	aEQ8tcyjPUV6Mas8l90rKn2KN17ruQJ5TKoCFo5Hv3KUSeE8m3ZggJMcaDXMU9PyrdOErH4GuX
X-Received: by 2002:a17:903:985:b0:2cc:9179:32e with SMTP id d9443c01a7336-2d3b0896781mr80925655ad.10.1786719544229;
        Fri, 14 Aug 2026 07:59:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.162.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb27b89sm10899415ad.50.2026.08.14.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:59:03 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1786713351.git.pabeni@redhat.com>
References: <cover.1786713351.git.pabeni@redhat.com>
Subject: Re: [PATCH resend mptcp-net 0/4] mptcp: a few fixes
Message-ID: <6dc47926-ec2d-b5e3-b448-d5ff5b40dec0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:59:02 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318066=
65824

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e3dde9e93b29
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146084


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
