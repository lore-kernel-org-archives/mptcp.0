Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7E360EC3
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778586474; cv=none; b=LJcdnWmL5y3cwPpmXp0Iqx+KWNbYEm05jWeD6/3mUPnJ3/QDi/N3LV5QTgKKK6A8vp0J2ZWeesjdTCk+SP/ivfdlF2o2BSb9+Om9RJkBqAlHc121GN0mWVlowRsSC+f1Y5eRYhh3i4HCWAcogP8OszcXsbzkNYkYJyV/QH3wnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778586474; c=relaxed/simple;
	bh=4j3djAJ+01KrkJcqzvJDy/GFtL2zJZVs4SRttsLZaww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=n4fxm1bBsOPF5kVVwcHdoiT6IqReM686HYW4s6E0/r+glojy9yZZ5nSSaEtakuMaM4yayU9/4umyRShUKwK1xOGHzdoL3vheWV2Kfnpa6V52muzA8d/Uyplvm92H9zFMkCP7DF1HW4c3LakK+XM93sjxa5P7tU1agGloA/MQCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2TBqa3o; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2TBqa3o"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so4160853fac.2
        for <mptcp@lists.linux.dev>; Tue, 12 May 2026 04:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778586472; x=1779191272; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRsxnfHy4whEkyqn6hElDfR5Lq+Ct+L1gu1AkDxQ+SU=;
        b=I2TBqa3o3quNx+16O7yAV2XIXfmUWBlkbB/mVLEQrQAwxb+WC/x8K5EFxgkLXBGjAM
         e2h2Q6GzzUzhr/gVQ00Ib4JKKfyCrpISqjbfKiwuh4EnIV/2cm+mRvFrdD2QUCuNfGaj
         5ZMxFpMkwzFFMD/+m3rKdGlErJKu6hn6BBKVpHRhXvrYdLhvo0z48HYSQKmteloJkWKs
         wUBgY7qx5vo+dlkkKeLLiNNa+0gM60SjpSNjJds6MVXYjCN7OgfZoKhHt6AITICIisxo
         2g35CC+UVwABpOWYuix2n7dpXuFCZNWIENoLH3+iQ8eKHPNdZxYtl9VD1O1Xji8kg4qI
         dr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778586472; x=1779191272;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRsxnfHy4whEkyqn6hElDfR5Lq+Ct+L1gu1AkDxQ+SU=;
        b=aa924zVbJ+ZFKA9qUmjWEFxZ6KRcOXv3IZ+rYGkt+H6FhpuAF4Ui8w7E88tvVA/g2V
         4F2zaaP27O3JmwiL5lDCym4qR9fdXZPOcWdjg78behKp0DiqM+KEYG1lH0sZKHlvCiTf
         ZHafFjqUrfejYOP+KDI4PnBbgWJgJqdTDyD3yfc2CqfFUsasUjUpIZu40XMwUUEpBxpL
         AHcEQgUj/8xw2F/7Po6R+yW+y5rXku0Npd5FzNc9NDmJeg9Mqm/+A8fHEa/JKKYGem0B
         7bBEpp8Az/Hykv0rcg67yy9RGYXaYZPmApppOeRgsYgHQ7uG6SYdjtAgsDlhoqkv/n8z
         W4Ug==
X-Gm-Message-State: AOJu0YzHEHd4MKqsQUbPSl2v+TIShdSqZdUmfvJl1QJCv/gKMPfgIKkC
	T9YAOrMAGIu+N2O9+1cCkhY7pJgrYgyLJQ0lakM2sgEy62mZHgIh/oE=
X-Gm-Gg: Acq92OEaqsVf5tPYszF1Inh83iOutU98v1kmjo80StyjdqcvVfxh6VleVMwy5sXYhbS
	zErbROCG6cdGpuo3p/dB8NXvvCxKSy43GCq+Cr3h0uWbUGvdDbWdCJLyuOb7KRnoDUAFsZind9+
	H3RY1GjgbXxO/XD2MgomhGE0miyXmz6JVcip6qMaMp8Lq9tDJmMU5H+dShZ34BlLF0m/1A55yzF
	EE8J7aKgbkLKTQmicCRAlSUs2AJi+/V7NigJgXuwZAnJQ5Kho9cNkaGrteyiNz4Q2owYBmB/Ce0
	kFN6bXVB58y/MmlxxGKaOWOmjm/7dRH2TEFTwBuNrZ0a6YFYwIMDM7uGnu61nQC+0Vi71LdgVf8
	d5zaeW0qUDTG+EcM/wVwAxEHk3snO9ZWPnmXHZbjcT9i1ds7qbG6NextbP1uUmLK5GJjtGGTYAh
	c6gP9hmgFVdpauCG3QWFSrN/msBa6WX+qVuuI20fM=
X-Received: by 2002:a05:6820:215:b0:69b:6d87:ad27 with SMTP id 006d021491bc7-69b6d87aecfmr939750eaf.25.1778586471736;
        Tue, 12 May 2026 04:47:51 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.237.134])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c76cc4sm7574403eaf.6.2026.05.12.04.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:47:51 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Shardul Bankar <shardulsb08@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
References: <20260512103331.1934343-1-shardul.b@mpiricsoftware.com>
Subject: Re: [PATCH v3 0/2] mptcp: per-event MIB counters for
 MPTCP_RST_EMPTCP
Message-ID: <a5b36431-80c7-95f3-c12a-9f9707f3cf6c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 11:47:49 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Unstable: 1 failed test(s):=
 bpftest_test_progs_mptcp =E2=9A=A0=EF=B8=8F=20
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/25729977608

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/4634f0a9b732
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1093458


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
