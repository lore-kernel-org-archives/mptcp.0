Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C44C8F6B
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254136; cv=none; b=CKcOjQMFOt+ptbsGjTMmDzoezKusCJF1JLVg2e1wXkIKe+4nIOlQN8BGUUC5OvsTwW8/PUQhAG4JtCcgYwAYBAPviJM/AZpcHVqR1qFCx9d7hcxRfzx2pfLSzAuLZM/jZYgZFS2TyM8g3+X6k9gnur/O0c8TWx0s2FxW8jirAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254136; c=relaxed/simple;
	bh=gZOpEL5zfHAawz7pbnik5TVoZuPSjcCGogaGsTb0CHY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=M/BXNOP2Qv0kzfiMjhZiyMQQOWWxYpPHTpiY4XhY+p9OMsStqSWfUhC8IU1GVPqTLqE6GW36RJhwd+2+k+OUpt0DfnZ4SKvJkag/Ita+7l1yMQT/xU9HGIuCyc7oStVylfNVkHSr4Upt3Sc5JsFXsqf+8aLV9j2d0oLXqgH0KkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsJjJKh/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsJjJKh/"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460ab1bc2aeso7738071cf.3
        for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729254134; x=1729858934; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hONAf67jmYb3IkHcQomNh2hhPVXJGJ71dvhjl2IaADY=;
        b=GsJjJKh/L/OSH3ArkBgefSkogwApxk7EyNJ4Mx4n7fWYrud5ycITvFoJQAHXBRByMC
         nDJ4wfewHSAsxmcG0uSx4GwA78KDWxzerL/hwk1jkOhLlbgv4EYm8tbZz2c0tGfE+5/+
         YoUBIAcAXTZcf1lSWK3WU02tWX4Y9ttjoOAOfS2kreV8tnb/6bgqEajIpvQtll40a3fb
         koAE7v4ksMmou1Nt6ESZQUuAfPcElYDocAgaS288sjRrRVF1C6dTAwh86peJyPa5hycD
         HNsufQUaTkrQXlvXZZlb03yvCgBhrAD0vwLKFUVJN1si7K8e1gUOrZx3Y0L85YGS5FJc
         /Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729254134; x=1729858934;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hONAf67jmYb3IkHcQomNh2hhPVXJGJ71dvhjl2IaADY=;
        b=imNdCrV9EdjadEqsuPgT+X9BFGzIYaSOd5Q/PDMogqbjEw4hPNljGjzgN/5jWdix4M
         RPZ4vU6E5gf3KWEQDXI2pvCkTkb+gIjKZgKK3l7b/3WcQGr4M/M7lNA/E1KU3e3adM5n
         1xbWCeadFx/fHNTmhgJmyzXHfEo+OhlSVcGypMVbVpA+R4mTkt6HNJUgw54uVnv/IVr4
         2dF33Gvn1Ekk6WJwIe2+c+jEKeA2anz1wizl7nCUBudIyOkGlUbTGkMcKTO8UQZvR/Cu
         v+UCXRktbm3zeixx2Eo9kuEM3yCYhnGxca/OPjt0rim+gG3lOx8Is87tu7OnQ47Snw3g
         5FHA==
X-Gm-Message-State: AOJu0YwwpBifYOgX+yayS+p51lpfbXJ3uxv5wF3dWw7k1KgDYDACqqc6
	xtQ4l5AM01e+c5296GdI5BKEF8thiwi5Xw95atXvz2Ccz3XaDPEFc4xb
X-Google-Smtp-Source: AGHT+IHXYgQcbJ+Qn8em9sQPiZdYrzkMnPgcFoRdtuUcvmFNDqtFk1hFq9yXNe1UU6pTof00nAClmw==
X-Received: by 2002:ac8:5754:0:b0:45d:631f:651 with SMTP id d75a77b69052e-460aee0b9bamr29617941cf.54.1729254134189;
        Fri, 18 Oct 2024 05:22:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.127.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460aea5ff7fsm6631251cf.88.2024.10.18.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:22:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/6] add mptcp_address bpf_iter
Message-ID: <1c2c24b3-dd81-464b-33c6-7b1d736d6664@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Oct 2024 12:22:12 +0000
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
- KVM Validation: btf-debug (only bpftest_all): Critical: 2 =
Call Trace(s) - Critical: Global Timeout =E2=9D=8C
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/11402403717

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/2e487a9e3d12
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D900658


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

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
