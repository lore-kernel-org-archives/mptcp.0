Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00921A254E
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754540798; cv=none; b=smuwosdUx4ga+EXPsrmprYygIBAW4cSOBEuQTA13oHsufaROOk/KRA2ccqtBSTFCNeo3mkS0359udPJOn+cJTJ7SvtmhkfRD4ImC0sBsC7s5VqIr9nOzrPzd3krn7/ytJkywhgsg7SZdMbWlFeModKh9SGxoyKIznidHmI77IK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754540798; c=relaxed/simple;
	bh=TDG10OSN9JT8krJcoPXTj1p1vlH/cmLtqIE8/AYJAug=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=GvDZ9lLCiwuj0oKrhtTG64WtU0beYZ17/hZfgkDCOihjSqsfSmcIHWwYo3TcJefq41rnNI39pO11+GPJW1NWLxAvusLDZl9xDVnxCDAU0kvi2w3HXJU0Rt6aLcYAIoNXIHlvkVD5Xs2Gu/YzDyM3UTuFSFO43k/p7DaM6lPbv2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATMiuWQU; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATMiuWQU"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-879c737bcebso51174439f.0
        for <mptcp@lists.linux.dev>; Wed, 06 Aug 2025 21:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754540796; x=1755145596; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzOZQRyYLi29xWbbAfUVSCVyA3MH8n4uSPXz+0NPbDA=;
        b=ATMiuWQUXa0xxdu0LUQUaYwOOarHke7nInKH9pc+s4oc5SzP/y/efchTCyuMxOzdDc
         NqWpe3WdUzbOxycyTKjAWxAquVfxBaMdsK8WYpe2EVAl12yYwhNxdxrMFjzSx622LwgN
         01rqFyxSE6fTE+cOeV3WQK7TQ4w9wtVaI5SUTIg4keBJEg3Bks3LpOIVEaBM/gHa1WOY
         lEJRFpksP7PORqrLsYty3gw4SNmFB76uhGFejjaFb06UtULR+bs1AWhIVKjupLzblNgy
         jUf12ud5zGBQzioLTxJjmEDla0+sUrPC5xI01OJPsW5vrHOsEmzKRIQ1vg457PwctPax
         bCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754540796; x=1755145596;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZzOZQRyYLi29xWbbAfUVSCVyA3MH8n4uSPXz+0NPbDA=;
        b=pEWHwKvbZk1wU6fH3JjlEAwpRPsUcRaHEwFVgci+6z0+Cqgw+pdjCG/HhiIApDK4ZV
         HexHfHpzP6BudEKYUTzpz0MngT0xIAWmcOHEGziGvK3wotABSpdvGrUxzzVCKE1HkUet
         7JuGLAo5SVjkcP03Lyn5hfJh57VpZ5SLWnbzxfbFHcW4Uv6MoVdKSB6GX8GCB4rn/arC
         Xi6Z26618ey/k2w7CW68cIkSN+n8hHx4E6G91VXWuyTVRbYJhE7aP4nlMS/f+73bJX9B
         Ik+H+AlsXDsuHByNFwVPar2mgNPhmJBK2q/jagfD4IxU56oo3+WapAQ6NUYRAij0tci/
         /x/w==
X-Gm-Message-State: AOJu0YwBaJ6WWBxf6kmdThQ+MWkCpW47QrOlfUuFiZgM2Mtr0dvlAweQ
	SGQNzd4ovueYUDmmbg0QD7RrliAzuqufQ444aMtlVtcOvV2ih9392f3L/yl79BA=
X-Gm-Gg: ASbGncvnjgTIoNKJgXThNweXmSG81t6aev/DA+2J2etETUFDihUsPGTlX4HMe/l5aSE
	2c1FHzYv/hkuDvBwObzpRW6Io0senrVtC5AdXzPWxAL7cvB2eU9MXTaoZ0EGiOj9VfbNp5bTbz7
	gtbRncrL/Lv50Ax639KKe0BQ9lMMpI0zsHW4L4MdFlqSzl/LETeRy226OYpPVS1C89Eoc0YHMGr
	T/+ZhwXgLu/ip2nTWe57DFD7/AklZ1Wor2HHig5gdL0uOvqxpWQOf/Xs18uGIfaCa6s25E7U3aW
	Rv03lAhIePsuR8zt6P2iblmZAoQ46AmfQ/BPI6LmeI+4+wrJnehWoaM31pXQy7LYAsCGTx4c0hN
	CmETtA7fnrXdhhVG8yFUdwr8BGARnfkejnbd1
X-Google-Smtp-Source: AGHT+IGMOZWhnTfoh9A7j3rQSAf2HlkjVpa++TaDtUkD+GCP+NTcPAa8VrzO0ZErC76ol2AWdlx9Cw==
X-Received: by 2002:a5e:890c:0:b0:858:7b72:ec89 with SMTP id ca18e2360f4ac-883e4b36412mr292601139f.5.1754540795767;
        Wed, 06 Aug 2025 21:26:35 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.82.128])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a9acabf86sm3175949173.43.2025.08.06.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 21:26:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1754534416.git.tanggeliang@kylinos.cn>
References: <cover.1754534416.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v2 0/3] mptcp: disable add_addr retrans
Message-ID: <3811e1b0-5770-82dc-8987-594a944ddabd@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Aug 2025 04:26:33 +0000
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
uns/16794019654

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/399555cff786
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D988945


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
