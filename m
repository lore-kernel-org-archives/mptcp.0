Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016275;
	b=Tl3FLwd/vzcHW84ds2cpQ9VO+OemB+DUws0KN44gQEwSi+yOXNm6vjvKVJ3jvVrFXamr
	 csPOND9w5GXsY146I4bjUC5aSoUhTEEm2h+nI7maZyHdMq4xLumNhA27LdlIvCI7ijLOk
	 QolW08sv18MkNENoXX0JVfSMuuIXtAwURKG7GEU/fJVhyVZCtMuS+SCmQkVCWRtUDRMy7
	 BCA9hTn0RkaHhMnKjAsQMqhkjfZUZ1Zn0nSDhRL9o2rnoXLwB0B3mqug1aKFfyvxEakVv
	 uUGExsRwNQfqTrw86PEwb6p4WeFEIr0nM7OmdwSo9N1qCL2trJysctCmRMD6lErNdTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=1WFAH/A6clUN3HJYTBTONhSTZ5aLbu2TJkz3jHZKjUo=;
	b=knijh4EhSNwei4t1qYed3sY0OJ7EAx5h6Hex1dSt4MfozxUMNqUBAi3F25pn83oxHk9i
	 XT+OC+xdb8gLnfg4I2QcvAWS8x8ScNTRKMyxXUqH4uruCbRmZA8/iDEXv+VeRV2/Ezw1o
	 XOfPdBWhm33vFLy8ml/7fXmjU7P3EZZosQ9aPZvh/w+F0w1tHw8FW3AiKAuUrs5LI8JQS
	 ZeYqGdvnzjN3n9mDZiZ5ggCdTg7vgtAGmTN0bloxH22fGE7Gz2qTxWm7EU2TajkxPZx3r
	 nkof9MwkkOKQCCO67sD2SVbXbl6bNGnAhPNaAQoXCgzSe+zOBlIzTtPui61FBQWAmTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nI7OAQC2;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0652D60A3809
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 12:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0652D60A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nI7OAQC2
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d1114320so21736425ad.3
        for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016274; x=1793621074; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1WFAH/A6clUN3HJYTBTONhSTZ5aLbu2TJkz3jHZKjUo=;
        b=nI7OAQC2aNukuM+9oon5zL/qCr5LjAptd+TBY7fdNajqlSm7gLZpe82/zyoW97zUTb
         SefjTHrEQSCxkqnaUoCy9fS3DjVY0i/uI8sk9tjnMhEiERXZmsFhQ5Dv9kKnXmqhEDjs
         0IJayrKr+5hYhgIRvPt62ijCvc2yaNOsl+MIMniCNWPYb0pkK+uH3naTJl4Az5bQRBy4
         UcDo0Ap2jdXCm5L6vvtYgK8UnWhFu4KsVE0c60ps29kXQ7F0Tvl3d6bwLPlnVbTrCpxD
         XzhE0skf5vNM67oHdS7ORtjyezuNlNZsehxJn8PNuLuDn6BWcmNEsQVC1Czrk7Hm4D7u
         TFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016274; x=1793621074;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1WFAH/A6clUN3HJYTBTONhSTZ5aLbu2TJkz3jHZKjUo=;
        b=zLNxWxLF/FAwP0jCUqBV1yvJI/yZMGm6mKOP9PO+wAwq7IPd02JB8Waq497K1dF8w4
         wueHUINmEGEpoVSos2/d9r0UTxt8ApbmQh8rvwZpSjDdtxgJfz0FElLBslVLaf3b7VYV
         6NDTemX0j8lkqjnpMhwrlnhiJBDrtvkWLFir3/OOPLhnnEBuUC2aTLx2Ept4+ov6LE8R
         f2eOBXXZBT3S9ZTD642osRa2ZYfVMURHux9I4z2ecf0m3FN1e5YcOKAMPFR2QzIG1W3j
         dsDarQ4/EppaK46DyI7PzGtQVPqrPlm8qgMwozkptUCI3MtJt+pU2TEXm5ENk4jVFAfE
         JNBA==
X-Gm-Message-State: AFq9FYKzNEPbrrAUtvpQYPkVDdMV5L1oajl8apbnriZMgmZFYxcMol78
	jrnz/CAw6Urq32vIGwFYHsfl2BanjesSyzp+NnMeLTosaRXNVVgOwK1SB4Nt
X-Gm-Gg: AYBFou0x+VzthFRxaTZzbnVQ4otRJsuEYSSUp5Cf43E0nvBR1RvQjxezNmGX3EcFEyO
	/guFoAR/TMIwl4M0XnUbauvaeRaMV006DhEWGxNb1r5E+qR7slpOFc6oSBmYdBkqVjBi+nEweDv
	QYiMaNPVCGcH88vfnTDnj0Xc7lqcaCoG2wETZVX1VtCdLDkvFuqfL0UuQyantDmCXGHi2GFEEna
	fY/hDqy7/9OxhQfLgeQmG56tK1CQSnuPxxlU+AYfs43PLiw1fKmUgXPvmqLlB7RCodekowK3av6
	ZebCN11+28O6zMFlOLPFUzR3YQdJBmWQVprul7sFxblLaybFkIJSPBK1KiCgjMuoqe8apaevtYE
	60pE7oX8+NU7QnJzEGs33s/HvbLzaZnl31IE9ZKee3/bQmNKGyXrnzo1GE5YJ81KI2RJ/AylDnj
	CyeQqIN+OyPyP64sgziAyYLtR+RrM+BwkWhPaUptbXmHpCxbkZw+48nrMF4sqg/kKkOeHiao3qV
	m53Tlg9Qq7Fm6sFm15YNg2VKGPr1YxVuPsAIxT9J7QnWxVqnkZayVnoerUfdL75
X-Received: by 2002:a17:903:37cf:b0:2e5:41dc:9ac2 with SMTP id d9443c01a7336-2ea9c61a1e0mr55329775ad.9.1793016274061;
        Mon, 26 Oct 2026 05:04:34 -0700 (PDT)
Received: from github.com ([57.154.6.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a1c00sm16033135ad.45.2026.10.26.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:04:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1793010744.git.tanggeliang@kylinos.cn>
References: <cover.1793010744.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/4] Add MPTCP support for NBD
Message-ID: <58b67369-5895-3e44-95a8-3d74a0085217@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:04:33 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
et-next/actions/runs/40311189299

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a787dfbbb9=
da
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1193610


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
