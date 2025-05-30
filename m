Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AE28E7
	for <mptcp@lists.linux.dev>; Fri, 30 May 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597290; cv=none; b=Kci12U5rg4quMV+AuVXOnnwgQugGzfYfi+EvLOY8O5TN9r17SCrKCuQPqS+kWII2RxhxIeEJze/FZKJlejcZevk6MMNNjF6Z3VvOrz3uf1IFGGFWaVymEWF0W67hhQpbiNxdYLlfZQW5kEgLcodnrcS65POxo1+dZrkRUbNzDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597290; c=relaxed/simple;
	bh=MsG/ntAzuOgWhO85Ha/R3ASl4NKl/iGTig+elKZ9BbA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Ob8rseDKGH/OVkwwmXdVDnu4JuQb0A3kf/JAGzGAv0cjJ30AuWSoaUhaERxI82yjDY58LRnFeLr8u/UPKGmtLSENlxvKVRaZNjuH5kS02Fb3ZDYA9lJ9Kxe6I+0WPJS5xLgN+ocaYG5zxZ0GaTL2U6vE/GuohHzzHKXUnhlWk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Dud7LK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Dud7LK"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7cadd46eb07so185521285a.3
        for <mptcp@lists.linux.dev>; Fri, 30 May 2025 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748597287; x=1749202087; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnakPi81xsHsh3MZKdDem65imSy2TFrFypw+WQd8aa0=;
        b=T9Dud7LK+L6jlN4O5y0UY3mllAFa1TzAsd9fex4dC/cG61Yk/aIYkwEIHD/tK0U+50
         Y8Zw0kQiW+iWtwGhhmK4a0AzgD2yPf0fTNYx9MKzNIGsKG4enJcSGxLfbwArHBUwsiyF
         TPYMPn4OVkkdbxVGt4/3QO304nUcVqwE893rDaCmlnP4MPNbe/QEk2Em1Ioan84NafjZ
         fRXS2+/lmlOL2l/HGsBs/I/ozZNHSIfUPY/+aKbh6Nq1O/RvtMw3/lc/2eLUKuqy0+of
         +ye6jpDB7MWT9QEr2PWwQ5VQnGTnIiNLkO6KRcFsyJrkjpX6JHogvjtjUhfk5NqTiZxQ
         xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597287; x=1749202087;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wnakPi81xsHsh3MZKdDem65imSy2TFrFypw+WQd8aa0=;
        b=e68DNBf4McBMNnuVPkcEcY7/s5WeoffrnafIvBdXXdR8uTEg48kstGaDwsWXiHeLzp
         5u+iN62FNlSQb824KPhga+ryqrooyNpbHTcJoufXmUpeLdwqGiiVyCdr6VKCRzv15QRJ
         3thpevW8aFdx0h3LfVpmejRBpyxJYCnUh7ASBIHvbGGNLfMG5/WMP5b8/kXVV1lFBqHG
         y+Eoiqnx7caNTRaDUKWFnCP+hR6zWFSsywA665TpsbvMjWfTBsWsJJGGN1ZE9P1XI+or
         dxcwrzOdXYF2EivNOiv91J+Gfxpzg9fmbtUDF28g1Iy/XdOnmyA4DmR7wqDqe0Wazc4U
         wgUA==
X-Gm-Message-State: AOJu0Ywwt4NnHwt76wuBQRQYXOcl/RI5Rh937jh/xZGIWI/cmVYol1B5
	0SkVfooVqgOrwQkwofM4NZW4Yx7dDvOIzfEsXD7Xu7tlz1YccW9ZK6mlFgr/
X-Gm-Gg: ASbGncsaHf6iU4e6FM+Dup4blJ9QgXwgMSDE7lcNE1g3ZHJHoCLNP6yUz9dybu7ebz5
	Jp0ChdMm7E/3xKXFNN0RlYh+2cY7U3qcvI/llKdij9kt43mEC/eCtT42eq6UP17K4ZKPZIVzT+x
	ScIvkCQz+YPfTIBsJ4eAaYhLpSWQuGlj2cmweFkKzXE0RcT5Hcx2I85DwTHXIr2kSKcV9cbmCEr
	SjAc5M8kdkrRhaHcgUJaod7c1Js/F/G6U88hfYehR+AYHn7Ij1Qy9FNEV9hoTCBl0GbbHb73WEv
	Qr0HlgIHsDSPKGhahjuWJY8Snb7Vy24BJUQ0CM+QHWKksdu2jBGWKQ9BFZKQULDyHA==
X-Google-Smtp-Source: AGHT+IEKKXx46qqLBLVgzJl3rE02d+VvYe1lj8wOrK5b18mrzbaeK6Ih6SI4fHnaIiA4x9tkh1IOWg==
X-Received: by 2002:a05:620a:31a3:b0:7c5:562d:cd02 with SMTP id af79cd13be357-7d0a201de9fmr405331785a.41.1748597287331;
        Fri, 30 May 2025 02:28:07 -0700 (PDT)
Received: from [127.0.0.1] ([172.177.220.45])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d09a0f8ce6sm199618385a.37.2025.05.30.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 02:28:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1748592117.git.tanggeliang@kylinos.cn>
References: <cover.1748592117.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_v3_0/3=5D_Squa?=
 =?UTF-8?Q?sh_to_=22BPF_packet_scheduler=22?=
Message-ID: <139da815-e841-5ea0-a902-1d72c581102f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 May 2025 09:28:06 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15342501617

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/abd8fe632270
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D967524


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
