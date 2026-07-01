Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32E371CF1
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879484; cv=none; b=Bd4VhlFKrh+Z+3HQUou3Pzef9jo9j79hi1L1KxU7yygs7e2NazcTEeLEKIEGT4H0tiWSc0/000qpOYasJDbvJJhwf2bxnM2xsAmCg59J6b2Rvfiq+qlI4w0F4yqeVGxSbK7dhjb7ItfQ0UHc7VNOlAgbgDx2N3GvavOyzn00nlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879484; c=relaxed/simple;
	bh=vCqeXxfhQ3oUwg5I0P9ztCuNeoSkKbqjFnzPgphxwWs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=N2hhkfmCLt54Lz1Q8Ml3BLXxYqkaNPRqw17aQBAPK4QE5zJzP3u6KUM2zcxI9fk0BDYNr2EWyazo7xcCvrWlvk2k7fexW0Kx3fuGDu+gaROo7fCrZAzYw8KQ/HQ99tNIh6XUbEth4LdVQn7xzBe1TqJGZz4njgSTKkaZe5wLQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWi/FJ2d; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWi/FJ2d"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f18d92172aso3959056d6.2
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782879478; x=1783484278; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2LW9ZHIFCLDO7pUBFdTbSX+n8LFJ1mnAd+n+L781zyY=;
        b=IWi/FJ2dlFOIBX6jlQfm6vkKQ1NfRmGIATHkRse+i+e5ZpCXsfsF/G7A+7MPq/mM9z
         8G0wJe0wXNXrLZdfjVxQ+sqv9xj25KmO+aHf27BmjfRPdMpS6g6AekwTSNucb1brxqgP
         UQHhKK0t6gbvpfQeF2oDpoPkRD16Wir7tLSY2s1qxIjWyHeXsVauXUPY9N+zjk11CrMi
         kSXhNNDmwQwKvWa/AynJJZP+HJz8VGAXRXXXFfKiCNeoRJjAH3XiFSgORpwwNLiSDPAt
         lhGztTB7CPtsDAOZqoonflrKAKKvPXT3W2ljj/USqcaIfl54GzDKtu91JxwP9tIeVGVs
         Y+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879478; x=1783484278;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2LW9ZHIFCLDO7pUBFdTbSX+n8LFJ1mnAd+n+L781zyY=;
        b=BxEhOteoFX7EvknzVzvxCvKF0PafTxyp05w6d4P6SN0Z8Y8TWxOrludBI3pbo5Orb4
         D9Se9eiY66xWqaWJkGYLnk3yn0d5Yoig8MMZxtZFOSPuUKu8hbwTYtCFqy43uKpzrpok
         E8rGl+hyU6BKfemcayeCi9tSADGkiO6j8cU8iXx8io9tpDFafFO4Cyvq1M23k+NDJvPy
         U1oGNtx8RRj64bZfnTMbbdU4a6QyPmgEl5G/eqyendTkUBU4pk+dliel9hhdjHGxVNES
         ZtwA3pZpnR6TjvsHgwYabq7g3bs5428enzzttZ+BGDaCBS3eeFsX0KDgrWKRlpQ9+d+v
         g+kg==
X-Gm-Message-State: AOJu0YzdhC1J4AHot+QAKUwQFVUeYBHaEImJC4K2qz80i3V2DKA/7PIQ
	460jn+i0s4CaZ52I5BFlPgdo1YSE6iPIr7Y76ml0HsuGa5wmBsFi/z7323Rl
X-Gm-Gg: AfdE7cmE9xLpnEeNIOc168+wy/NgSJZqpCBgV4VvS89l8u1wY7dYiMtoH4uPYHQUQU6
	1G8XMp8FUFzhdSaA0OKFW7kKoPCwbqZkynf4MMvb1nPNIWOBJokRrBQwGYBXNptmbdx2rmA5FgJ
	IyLeTbhs0fi9PedALzU2+oGl9a60l9v7NyPJRUSwSMjfop/EWB7vMQiVKNEIJsJ65hpT2IeoIoD
	KrRTdizLnCQwW2nCL14QQ+U58BdODQoFsnQYANqStTXxrgQC6iCFykES/uOljzEp++1W6KHi6lo
	btzpmpL+Ds1M5TH5wP3viftE2Vqf1EMXzZ/cPFnQWcenzg0c94SoRq/MKtABRQSUCobuFRzTJ+F
	/mrBaOp+25tNGWP8E/MIvGqUnQ4T/cNY1iaw0CpPJaYZBtqJ1t/IbL7bIpPfnqArDGyppeC5yCB
	JKsAMeCN2pwaD25QfMBi++9U0eLQ==
X-Received: by 2002:a05:6214:4e08:b0:8ce:ca7d:b099 with SMTP id 6a1803df08f44-8f3c66ccd06mr427746d6.18.1782879478013;
        Tue, 30 Jun 2026 21:17:58 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.211.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f3619b6c97sm10276116d6.38.2026.06.30.21.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 21:17:57 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260701032011.358940-1-chenguang.zhao@linux.dev>
References: <20260701032011.358940-1-chenguang.zhao@linux.dev>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix extra_subflows leak on failed
 passive join
Message-ID: <151c9479-a89b-9656-f546-92732396b987@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 04:17:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Chenguang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/284916=
54012

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4d3b1813957d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1119370


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
