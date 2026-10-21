Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586683;
	b=4TCoBxvTIGp7YtL04Ysmuq6lkA3c6C53sG9P5R3qXbxGPb5ItK3B8sKduIVm2sqTEJO1
	 3ETTf12CsGrfrwwrySWxZ8MupWxVnBWIqc389PsWfTsgKEHGjOKj9/51ULRnxGKzAAb6W
	 d90e3jFT1dC8VRCvLd2YbGjpDXoEThUfJmNYfjZZaOe+YdRAWdI0Vx/96onUm9Mke7Jin
	 Sux7c/tSI6I/h9aXsh6bTvZnIE9GuT6lAq2cUNnpgVzazZRyUfklfGF6FzWiPTIPlZo7/
	 4euI1EW9uI5jl+LdviHr9owKjQSjf+rHwGUdWL8SkXDgDpfD7PZevjFDQ7UGR2DZVNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=4uCy+WZwGU/yC8lOiROPg7mkV0RdfKtdBGW/4Dx/Dfs=;
	b=zX2ml1knTzsweBfijSYpkuLfk4jx66/H5RKS7hEecWinXPEKnk5UsrV+nnTKa7dm4a5o
	 T6NIQKqm+poFIlJct62gDOdvrMa/sbE3C6icfDZ8NEKla2uS8GxEzjLcSgATHcIYKjxz7
	 CBE0gmHsamjmfJ4DbscxbLZOIUkRBW56HOn6WIxC5HnbjEaZo9h3COiGxQGUp+yyzrL1I
	 TNbFyQvymeAO8mKATwAc9jO8LXqYzkCdNZYOG0AGTEReAuFSpBN/ViNR0L3csIruNEctL
	 3lFgPxg03P3m0raHNUGG8ftHIwjnF0v+zglm2Bv5s3uuz0GZ7PQP9bWhxttmV1z4Smg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LHBCs7qw;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37126606A331
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 12:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37126606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LHBCs7qw
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso575983a91.1
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586682; x=1793191482; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4uCy+WZwGU/yC8lOiROPg7mkV0RdfKtdBGW/4Dx/Dfs=;
        b=LHBCs7qwxqL0FV5xMm/uNrFPbvQ4nyZ2eQaaiKH0bG7cOY6xLm3fl71SqdZNi0Cd4G
         873+S4PkypC0LmkXFYiSL0QYA36vf6rJJWE4t6/dOK22SzS1S06HqXF9BLiwIJo818D/
         FTj54sDOOt1pOWPcnWhVdLqlTPQko+/JTNamngdWthBf9ATIYKSsODNAJDzQ3laEjLgq
         V3pjC/76iNX/uuGtPNANd2PYGY/xS9itPcZA4DGh4boqV2a7A+dmvHDfggyQ/NhFkrwi
         b84ABpAgq03ay7TmSglb8WyQkAlfBs6/O2wiMqfMx7NHi5ZRvMtDSdZtxYcRnUhn/p3n
         wnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586682; x=1793191482;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4uCy+WZwGU/yC8lOiROPg7mkV0RdfKtdBGW/4Dx/Dfs=;
        b=RyfonqkIkCi5Zo532C+n1I+TJqpI/4lQGu0BfFAsujl/Hv4HzxhLXGp+05aPTUnWan
         ER7VL9/Tim6nWjc4A9khNyqjhH2XAlw8pCUdquqRTN5UB1g6PLOjEE1sHevUSF3vgAPT
         m0OinVU1DCh9KOE+4uuHbF07obE/jVhmAD8SCzUeAstIm+ZlMCOPUx2rSi5Z/wZ/CfSh
         IOEkmFDw1KlL/zswypEcq2M7fTb5GggXTo3MbHY0u7LWzWtukYccE2RZtl58hQKGi+L5
         5IhX5y2UUmJ6ZBmCvF+xsi0+B+9HdB5TJq4ZRaEZor5pI0IckhAUaP4QpwYKcyHINLFk
         R5QQ==
X-Gm-Message-State: AFq9FYJ6JwWE2vntSQ+S98bu0zlkuCP4gZmDoz1KwNUMDNEJL8csu1RR
	iUVw6vjlKv2Fv40UwpRtUnxeC+QKzMpmGuB2+ySyISe6+Y4zteVLWSU=
X-Gm-Gg: AYBFou2T2IEux78A1nRY2UopODa8HyboewXfSkxIuL/UypeUkfzC1wG0rBt7Yq/vmUD
	12mlIVu10mON215NbwUBzHMCh0dd4hgaE4AnKFy2IVHXfHuPlVxLwdYhVtZurdPIYof669rXIRD
	X+mJSqaiDqfpos8eKHGl9rOTmacL+QUnOqXU3qW18V+PuR07jjYpBoynM5n9aAySJwz15eG0Z7K
	Jnj8Ez3qXfNO71Lzl0zToFxD1x/5Y0ReMdv020psFdyMweBePdj2lej17Eisa/gdxAA7wBCP8Bb
	QpzyxayVd6Ab9uma1PXTc95oAaFmtlgRsG427rHQlnaAyvjE50rICN86DppFTViXUpDKMSt9Oex
	rQYKYzfQTXO/7n9Qu/H620w++0kRsm0pPjrdFz3gqu1/3eKjOTXZ+7vFVg6i0Pr1z1C+epcl9Tx
	6aMgi78EivqIudruYS/oRMFs9bqUVafEzqLQgDrmYhcCvKDyH3mtj7ptVhWieIFAkeNw/gEpfbP
	d7WAbMuvY23NkkhtfAzrZLBCncs+Z/6IIsqCbWG3vTtDs0njvb5i0YIQCRUtoeulyI=
X-Received: by 2002:a17:90b:3846:b0:3ac:85be:cd52 with SMTP id 98e67ed59e1d1-3ad86f7388cmr1942141a91.59.1792586682622;
        Wed, 21 Oct 2026 05:44:42 -0700 (PDT)
Received: from github.com ([128.85.45.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad7ffb84a8sm4538397a91.2.2026.10.21.05.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:44:42 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Anil Kaushik <anilkaushikwireless@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
References: <20261020031711.1896660-1-anilkaushikwireless@gmail.com>
Subject: Re: [PATCH mptcp-next v7 0/6] mptcp: pm: in-kernel: retry subflows
 closed after an error
Message-ID: <cba9f356-e19d-4b6a-4c70-ed1c505dcab7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:44:41 +0000
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

Hi Anil,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Critical: No conclusion =E2=9D=93
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/39580316985

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9e25d469f602
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1189399


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
