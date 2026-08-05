Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC83EA962
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918615; cv=none; b=E4gOSnpoFuNCDFGeyI4sQbQ5u0G+CgOKMlpSLTyuZMIeJZBD2U8jOYNC0DjWILIC1FUbto0qYDu9V8NAilLRSys27er+QoFvTB3b9Wp2rOS1Mpeed0WsdaCNT8T6RwrkL6y5jB6yjRFxhQZAo6ct33WF/qSJJBDOeuvFywjxyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918615; c=relaxed/simple;
	bh=Cf34br/0EckHIBWCjq4In+rkhOSY3PjyEypYrvc9cgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=O7LdxYuGw/1QLmUhQuO1dFvqbvBvpCEjv5soQW9n5bR9ZIzJDDlWRcssb1gSS4oBSXUNEmUkIc7QerA8+miWsQ/K4MPS/a2bCSrgm4sLwlWppcqeCqt4xvPeFXeGoT0RgPR2gLsm8l0yKxgFk2Bz927HJ0k7Hc2YwUfwYMu12YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbSUNpGG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbSUNpGG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d01663d816so6587735ad.1
        for <mptcp@lists.linux.dev>; Wed, 05 Aug 2026 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785918613; x=1786523413; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OLH1/FyACiXxZ6ELFTgIaAZmS63GfNE32KKBF7BkBIY=;
        b=NbSUNpGGfwYoGwrO70IRU3VVacmQ3d+ECbgR61E+U9DC2L8OMDivw8fBU3nteePgFw
         mpPvY+NAnZ7eA6ES/adrFaQxZmF0QPHTBrMFNp3YCUWLjIDLXjwus52By8q6NAE7jMB4
         3jGRqqzm9jb7mZGSJn9+5A+q+6T/+wuU0tOM3YTP/cv67ohBbU4sK/cKur+wi+yw6q2Z
         S2/imv+SnCEF/iinECjGEKrFzXfHDhfgPIeVRJnL96hh9KNh59asKcaDFCsDc7S9lkov
         syaffYVinmufCOHoNbzWeIZiTaMdggTpwnxxsjlB/kGXSk9Zz7kXlCNq6Or5TV2nLwNQ
         g5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785918613; x=1786523413;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLH1/FyACiXxZ6ELFTgIaAZmS63GfNE32KKBF7BkBIY=;
        b=ZJWszxIFwuuH2hnDRB+Dzb+wiDirYcmYrNZk6guSg1soqMwDafpAY3Lnai3WPdH9a+
         GrMSFkYqpaT+Q/sdMhDX+LnevDkFw/hqUSSM9rgpdnE/Fn3NeYCCLNT+O4s25y/hzW3r
         VGP5S+WM8wjKR4B9Mhh4vc1Cp29W7/OX22qSZh43nNA5Yp+G5p10UGvRj6Efiw3wdsC4
         VmVv/yW6kGoJJtZmkzs1DIxPLDPnGqwg4p6cKZDkrlPy/SMnT5wjOHYlgyp6datt5tt+
         FPEgtoYoAkoawtYYq9td0UnkwPUtpPo/ArbtCjNBlzv63WjHBlmYFzxO6MxW+206X7CT
         wgZw==
X-Gm-Message-State: AOJu0YyiMX0I+c5tv4LiNpBpB7YaI3LOr/FiVKM5kjDSao4N/0Iu/Raz
	E2HFLniS5f1QFzzdpOD34aeWaVEsAM8GPhJCpcA4rKVJ0wXy53xN4lLBnDjE
X-Gm-Gg: AR+sD12xHeOhJzGazFNIrTXb4rw0T7Kk1sn1ELLZbli6+mGZG6/fc07zzTkRrbAUMyx
	bS/kB3JmMFrkCMrJTxbCN2NCjLzjaaY2foimHxz0EcVjQO8a86SrVoDBSZlTvddc7Y7HH8Cp+WE
	N2HXEGOJvSYUf3ykgN/o2FGRP3HYnhO0V/QTtQ3ECQDHPoitYvw6VL5Nesme6arC/sTm7T7AU90
	AcRz44Ysl0JHOZtstPxn1YFH5QJaOQ86zmasuy1K0xJ13wxiS7raRq+BlHy/EXX3/Y9mVMWPWvJ
	/BP2rBx448z5gGnNxD+6DDYfjgdK5lUDPKHaHQbL7nJUXlcqkCOOy+EFcM5S09Mjggisc3uFdJ9
	Odutq1KfBxngydyA5cLnIQJfFW+bxFGPXEW7zfCEPNm3WFbq7ZrQt1wwJDbIE33q0B9rgplku6R
	fhJyxEGdkHFGdV7dKMXlBi/IlzO++PKebTIMkyFNYxclpd0PiLtvaiWFn7Y3XxGSaZGxaUVUBas
	OmS
X-Received: by 2002:a17:903:41ca:b0:2c9:c083:cd50 with SMTP id d9443c01a7336-2d0ca981ba4mr42650615ad.17.1785918613007;
        Wed, 05 Aug 2026 01:30:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.172.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4ec8c7sm14689225ad.80.2026.08.05.01.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:30:12 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Qing Luo <luoqing@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260805070926.716768-1-l1138897701@163.com>
References: <20260805070926.716768-1-l1138897701@163.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: pm: fix userspace PM address ID
 overflow when all IDs are exhausted
Message-ID: <ab4ff306-d5bd-bbee-49f8-058ee1b7ae9a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:30:11 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Qing,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/309854=
48641

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/04610d1b68b9
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1140580


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
