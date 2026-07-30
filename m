Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D75236212D
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385361; cv=none; b=AlHgjfz2g/8oPs30LhBeMTVzskdRd0rvXCLWab34eQX33/G7CIkdCohcFm2ekRKk1gfeHkyrpBuoRRKqnnm/3ydyq8LnMYbjcneCR7Ev3muN9nLZZiqcxrdpeLlXK6qF9i1Sbeg+qqZiB2D7hiQ6zrajv6cwC6Z4eDtfAP6GMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385361; c=relaxed/simple;
	bh=cTkK/gnEHJWvaukS3uhR8p671zlwQYzc/E3uXckeLqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=hvPnYfLkY3cpR/dv1YiUrD3taPsrBB51U06Li/rWHExaD/e+q7vvq5Y+VSGO2cfRFvn0No9mDHa67hMaaojIB1hqzElYSscSbp/TPibVC10f/VWN7UM6wQgtf8Y7n8Zho/8pjy2MUHo/GbEJYVvxJAT8NUq7CbM/va9xWJRL0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOgL7l9d; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOgL7l9d"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e602d2c0fso25217285a.0
        for <mptcp@lists.linux.dev>; Wed, 29 Jul 2026 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785385359; x=1785990159; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Efd+WxfgWzmkmQuNNiRNc9z+IZsFPVeqBIrKKrxPAW8=;
        b=jOgL7l9drC7O5UaFMywFXAVMV4UM7Ob4uUCP/zp7T/pw0Kcj5qNuNkY04o3mvkz8Bg
         p3PcTUX+RyjY5Md977uxuPtyZ8os3PKu4VQILIHyGaddtFBiILV68DSH4+I662zzyxH0
         HmC9AlHxTo/s27A4AN9YqgErgj/b0Wk/LYfV7+xe8aGFpqJ1YQc9fzUgUCGa2waHNM7J
         Z7yTXvw31XKVTdfl3kvqWW7W9vIbhI/Egu+cdq+Cd+tyooS69qOXZ1G1f9gr1ll2Ed9C
         h/pXpS9tT0yNHPhxjOxj5y3rfL/cyegTGB2NLbkyVnUKeQa5VSb7UM6XeUhB5sasGiCF
         zo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785385359; x=1785990159;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Efd+WxfgWzmkmQuNNiRNc9z+IZsFPVeqBIrKKrxPAW8=;
        b=e/FdHQIhNwOXhJ/IZjQ/m8mOQO9N7QCD7uiLcm3EaIBeFbqK7Q6YXx7ZYY2m1VuN6j
         HOLfH/rgiTIqMmmPwhBd28VTR1fBItfiBJIay7n3K+r6zSyqS1ICvrA5+ddmpZ5CyYZH
         6/EdOtzwTNEp40KP+87r3EGYISOr8U/QKQjEvDXVrjrpr+dENu40QhwX+VkjbkprhMBX
         83BRwZv9JIP8kxgAwbo1wpwIwbMfKAunRSHWktStn79FuJGgWVnC0RbQmIzKnLu0RDR3
         B+hr+x/W7X/YtuaHosuii+VNkrWrJ00gU9+ezj1HZ6dvFxQ6/jL/Ij5CDR7x0OuOdUIx
         vOeQ==
X-Gm-Message-State: AOJu0Yxq70jU1PgB6gXbhVGvhObz3x2u5JFzeS7ONhVlGHF2yapRKotk
	QSlHdMtjQAjNUGmucjWUjv5GXiusM3heKNMkUdyPiC6QQbZyjFDH9RUpAbXE
X-Gm-Gg: AR+sD102FvsB/h50ULEXYBmIX54xX7XfWOtWFCif1CHDbtbb9p0NlPXbTrUEXlV3rkB
	mVbNBCQYvKBPaU7kAi8I2Dn8jro9fW/s3uoF+e7fAC/MoaQeZxka4bPOeqsgNPzHt1+jgOiqH+t
	/VoZTD+kcALhmaGEqfTrd8DIyhl8aW0m5cTG9+Zu0Myr/am9yaH1SROO4hLGxU+N3D4uPyaWg5D
	xanm7w+bW1UDj4chkE4yhQOXq61UubzLswoc5LxZ6ZUONI2zxqwyRG74Vw1ROCPVODb3ODd73VF
	GrlbBBJCT//0KCXMZVE88mbSXpwoTSdRv8aTkkV57WGoSCtCRColpbPYR6j9B+AvCQihQ0ZvIbv
	inhZikOu47cWEJUmS+pRcJ21k/0GvFL9g9+HAGk0mLhO6jAY0f2WccOZ/RaflTVRydWKYgDHU6+
	y57Eer3lJ/TvqHmnr9XfdU+Afz3CF5gFREMijXcoMBDcBisGSdsJVyrKxWWJZUd/nVP/FsMnLv
X-Received: by 2002:a05:6214:509d:b0:907:785e:61a6 with SMTP id 6a1803df08f44-90834fe6f98mr7856976d6.16.1785385359323;
        Wed, 29 Jul 2026 21:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90832219d0dsm8511666d6.0.2026.07.29.21.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 21:22:38 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1785380422.git.tanggeliang@kylinos.cn>
References: <cover.1785380422.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v14 00/12] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <d9faaf77-47f5-6e02-4739-8d58472eba15@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:22:37 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/305115=
31933

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2c5e79970359
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1137065


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
