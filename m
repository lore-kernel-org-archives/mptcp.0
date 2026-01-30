Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD021199FBA
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771726; cv=none; b=KQNjtbm64BeiVJs8jpd1I7Wzjld6C+CO0l5P23Xfr/FFxhEIsV4KgDH/zAemqSPhOZAscdAR/gSBRbb7otDh+wu/vyrnGwI/q7Gpbit8KbZPeHdkXG8KaT/z03JkEbZRNd5fXmjihc/c1zd2c7cmQdkcDTOTYHn3ZYiynvylXls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771726; c=relaxed/simple;
	bh=X29eOoG+jUUWt2eKcoikWCaQt4HzPwaAlnIctwGJ0/Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=lzpUPAJB0Sqd1FqooIGA/9loVxou6MrGikQoePVJs+DxJp2kY8zLft+mzVEDyAUQHhkAf45NnOp/VAi6xcYzXfssK2Fy/FYNy2k5qeDjucUw79HXxD9rYFiVMzVAHecB4A5ZesDq51GR0CI4hHwxABs7Gj7OfsQgT961PpINZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdpIYnBC; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdpIYnBC"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-124a95e592fso2641668c88.0
        for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 03:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771724; x=1770376524; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7sQpUKSFOp7IR8uZP999gPHbJUsqrH/mEjLpcSBs0M=;
        b=MdpIYnBCmDcMktrz3m9iPVXpbcIb83d19lw2rlXReimsu7d+9VRJc0i1zeGR5j9AuI
         nLsfaJcXY0VHLkFaJlbfC2FcpM2bVMOgMh8lK+VFSC6qrzn9Z9HhR5FXgREn7onYfTyD
         OBOlnH6wRdddV5eexa3fofqbA80jR1OMcQmUy0f1p3NraJgmOx9/cbh/ww0PYPiXBie8
         2lNux5HQqqXv642RUhcAlF3EbURknLKucUvLy9CIwhekXf+U7MsK2H4q5nr0yipswwQJ
         4BWNLuPCcAOTL29UtCSrqRKKq8IeKh7Cfo986xTANkot9YBlTX58cEjlCYb5HITNElnU
         NYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771724; x=1770376524;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7sQpUKSFOp7IR8uZP999gPHbJUsqrH/mEjLpcSBs0M=;
        b=LcSqQoL9v8V1fRvLMygI2dBbOgZc7d022fI+QFbfLndSMwL45tMx7zU/eWsSDL1iNh
         LY86FLcFw/2fj5v6Dkwb2cMBHLy2PKCu9Kk1REVAl90Q5/pGm+QOP11KirtFap3jE97U
         caLXpo43Z+y2k9qkpMjxy7qtUrl5hnKlX1x61p1qdqQmJITTUIQTvbyM9YeEKVjbAqlT
         iQRwcZ248wAxrsCl5tG/mKNZHU1ALKvj4H2ZmRu2VteplPROIIRmOh/IyH3vSdeX+8mb
         ZHtNZzW5Ct0JyMkryhZ7TdSilQqXF8RmfOeYdTI8LIkYN64hLJYkchgfscX1Zub0IZ9k
         jbdg==
X-Gm-Message-State: AOJu0Yz6dLIeGEPiRB6YJlzEIyEahuSxFenN07eBVTPvqwyoM/jF48Wc
	2DQ8ufS2eyvZ+auqdb1JhFDxksRdUoNlu4uhh+wafuMkDREMqmwkgCZRp6hvoZc=
X-Gm-Gg: AZuq6aI2eGre2dyDiJMdRGIliBpKhLfjoolZdf24MQEMOAEIthOSzM/M2AG+d55QxhK
	QH8vjUkl29EAxiaqxJwx5UX9FKtuaeIhUrXQpU0sJ/aMqNxuEbAjCOPmTLcSvLgAfMMheh572iI
	L7cExTMm2X3Wx7+Cymjjmoyb5askJtiuB7gWvTziPKXWsNx9znK5wyvRbXvWqd0lD0HggIBzrst
	jlhUcg3QExkuDaJ22/DWXhhY9OHWCywV/VhNsGcfshvfkO6RvZmM61PaTekPfcZtaZqDav3Q5o1
	SrQ432e3jcnOWcyBQluH+0sWJsAeUgit4lAQuITzTNowPf0ZSbPJ89ryztJsphH/YdUjvwwWePI
	qfruU1E9nCYmXx19d3aIx/oQXaXoEGHlr5y6JgaGl462bcuqAugcPOl4IQxshioO/zPF7o9Xv5h
	vFrELD2YajfoblWnTVF8JmmVCa
X-Received: by 2002:a05:7022:628c:b0:119:e569:fba6 with SMTP id a92af1059eb24-125c0fb0182mr1567745c88.21.1769771723719;
        Fri, 30 Jan 2026 03:15:23 -0800 (PST)
Received: from [127.0.0.1] ([172.182.196.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7bb9ca10csm5345748eec.30.2026.01.30.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:15:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260130-mptcp-sft-no-ignore-splice-err-v1-1-af0a458b6ec8@kernel.org>
References:
 <20260130-mptcp-sft-no-ignore-splice-err-v1-1-af0a458b6ec8@kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_add_splice_io_m?= =?UTF-8?Q?ode=22?=
Message-ID: <beb0d226-de2b-abe2-4f9d-05a43d3e7657@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 11:15:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_sockopts =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21512533499

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6384e7649754
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D1048919


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
