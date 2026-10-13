Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13A31618B
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885428; cv=none; b=p421bECREL6Mguz8G9YB31zXJzuD3YkdZn2eCSLharsaNfgE2jhwd7CYaFr//mRuNE9/LFk1q6e1s6RtsEYaCONvlarud44EyFRz2/sFm5smM3xW8G4W6YZ3zQpcfKv7VvKQRCD/WxdiYtIGdaBycIFIxgYHxytJC8KlLbyP7wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885428; c=relaxed/simple;
	bh=9wJ8jZ/OUrctPOVdcLBs4Mk2otVTL6937RliX80qf7w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=s0PmtpGxAoBdix8/En5nfyLdQb/+6iUbay+ee28aEPDWKSKcxYtB/hNV7MwVUD2ZFFdDmbqoQteAfQaYvZla2HE7y+svb5RrLNX2zlHISgo8TTjuiExL04bT9gXAzAo4R01wxK/SwQTujysWzr4G+3iyvjnFDcPRPvmxf307xf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZtKzloA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZtKzloA"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1757620a91.3
        for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791885427; x=1792490227; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ImVH49mGpsyGrFYhCM0XYrDEaC3uAQjsN3k21LfbSg=;
        b=fZtKzloAHT4jHf67JOARQ9Yh/YWcbKVQCklcxeb/jLe/yQpHAXppRuErUI9PvkNV4L
         kIOGMCPh4N7zd1D6bqCsrwRt6B8u7399XlwPAWFiLZa7SDxoV6WGwTTKJAK+vJUTfLvO
         tC++64jay6cEY6Veg1IjrbM1G4AelCNTcvtuU59YX67kzPAzoVm0loBI9w6kwWDK+hA5
         mMUg83/DUv6ODBya5kMrwns3R0CNymgEmDuxzsqkA0JFY48Il2xtdh2zum5QQhwEGyth
         OkZzg6agT1Rz68wCDwgiYf9i9LuiDhGdGoHF1bjNaU2VDMO0liVJL97UPsI8OsCpkc2c
         Oarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885427; x=1792490227;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ImVH49mGpsyGrFYhCM0XYrDEaC3uAQjsN3k21LfbSg=;
        b=BTzXvjnM6QCtOPxiIM0t2qdKCCpmhRq9KMGmVBXJad4fe9L+4OOSHfwy5lt2PRMQLX
         6W3CDXjKdbaDmAeZBLCdn4aT9qDFSUKuN9F8lHBAasbzaD/QO03ApVtQaN+zLWoOzFXM
         L0eXWrwr6j4kDOprVIO3CYW7Ytpm/xd1PacRWA9jgWq7Gh6t5y4JWb0VWU4NojNKxobN
         fMwBy7AEbxuO2wuYMetbzQYLqC2nSZ2voRcJ7UYV+OGSRy0AUoRfQ3Rj1AaIBNgxwyTl
         yGTk9b9XBaTisNxTZw/r8VJdg1paA/b3cGWMLTvF/OXu3LhHadSy5DP8eRdPX+qcwVZ7
         OYiA==
X-Gm-Message-State: AFq9FYK1vXl1dEXAXT2eMGZ4kfqUmZxDOV+fh7IrO+X5ifbRiJcupVZQ
	8YhleyCq8su/IYaqEtL6ZqG/zmNs39KEdGXjezBFY2vnimPypX+teyM=
X-Gm-Gg: AYBFou2NwmnYXZ1BmX3LuHv17FLwi8VQCAOS16T8lK0+O08qBVMVnOuDLhgDxAoc6nB
	wordGOibqbmTwmOkpkvJ578tupju0W4mq8WI1AaiYtvCg90dPtt5Sib7bARkShZValDw5iHhGxE
	M0sNSmYvrA6S2n0Qj3L7KwdRkO/ECwrptwH9Tdjrspu95KivBLzV7+jecSlF90pX35NLollXGRz
	4/W6Q/T6ZpU6C1LEmpRmi5AezR5pr6xs3WD+eWJK8wf7SnYjNkmEVF+h5f+cU1N1CgSFnL6qtOb
	UwyujLAngvKrZUL7vSyuDt9lM0Th3IwQtTBJQ9aOpsomOjK99dQRhjXcGcKLJZ4OYldRBqgmwZG
	9U7MFs64cQwgpYm3KBUBM6TkGkCJjs1fFTh7BUmou69hlJzw6GOv90VKRc/y98PYtFkFpPkEOwU
	9FWW9qZBcv3kGGhTz5lplnpJVqzBEzzEj9myd82Ptk1x3AE91Z2i4dA1LmDxXuKry9C51QiCg5x
	b8okuuLbHU=
X-Received: by 2002:a17:90b:1c08:b0:3a4:f75d:d1a3 with SMTP id 98e67ed59e1d1-3ab3ab29dcbmr10638688a91.32.1791885426982;
        Tue, 13 Oct 2026 02:57:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.75.131.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab338676besm11493802a91.1.2026.10.13.02.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:57:06 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261013085604.115478-1-rameshkumar.t@phytecembedded.in>
References: <20261013085604.115478-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH mptcp-next] mptcp: add MPTCP_MIB_RCVINVALIDOPT counter
 for invalid options
Message-ID: <8d149bd3-7dbe-c337-13da-b0facc875405@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:57:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

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
et-next/actions/runs/38375270540

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/248a54272f=
d4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1184533


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
