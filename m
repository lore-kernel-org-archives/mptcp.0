Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC03399F
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389849; cv=none; b=UIgRda2MZ7U2ULO35YJiHfI/br/xKHQvIIFhkQhejB5rQV1NDFZ3YZHXWuCUa21G3SrV4REic72ANjjIGP9xW9gVETNfY6IsWxrmt3ps+GVAYukmIwXluLq7xJ8BUWZIxhlDjBpkluItmk3Q2TctTe78JBuiztbSW9X8w/GGOT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389849; c=relaxed/simple;
	bh=JaALXKSREgoIBbMTyXhaCSVTHZJe0RlFRnVHQxsUZCE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gdzNOxqJGYED2yaHk84ZpSh8o/HkyGOf4Gp081rZaFSGIf3kj4jwyfS5/FspunKEiTnwObG8eLwE6Tjhq5/74jMNYJkeDboHA5dmLY/LP+2qCvqXLiR5AOqhQBZCT5znehTelsr7kDMR84Qrbs8mjsSdKG5BQ/JDG6LPMrvUzf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUcAvfDx; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUcAvfDx"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3be6ff4f660so992337b6e.3
        for <mptcp@lists.linux.dev>; Thu, 08 Feb 2024 02:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707389847; x=1707994647; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6Xl5PgUZl6ntSk2qBEhx+drDbmdqsK2eF4qEZqDQEE=;
        b=bUcAvfDxbZqlglUKDsI+mztyGqEky1hXTrhX7/5sSg4jvmtkKVMeZ3LiNDUq7CBX1/
         xPHE03Y3VLvlC690Rt7JaPnH+D0qd0mgue0WTrnC3wIHUrwdsjkviv53SNFIdXK8ra2I
         JB9xIhr25PdHHDUYejW181Q9A4BhT9glpnGK7aONhKB+pQhjQ0uHqofajRbPN6xaCg1q
         o3HnmMy2S+NnFpIcIqa8vi9MXwD1e6hDP/uW9XHzSpOv7QdChlcLOt4asXRZIrqCfLli
         4d85y5tLJkGVQ8lfQOX0dswQzm/dyatTnJSk4Pm37ks+Gw04IIsZ1dCGePNrs9r6ISxb
         e8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389847; x=1707994647;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d6Xl5PgUZl6ntSk2qBEhx+drDbmdqsK2eF4qEZqDQEE=;
        b=pPVfYtN/UGcT9TQbaKycq2LlockW1zeCwfGYBgU1SyUD+vnaaQ6EMCMkOmf1sEpSMv
         G0NiPBvMb/YCvMZg8JVcicfOM9vQV0h3v52w2TA1oFSPJrh33PtGlPpuMIGAsTsbVKXT
         NbUsZNjCJSehO0gn/pIIiXtExnx6qaX68ubs9w+uUNZVZWa0khk0WSIUksI5GquRJksp
         xrHFkFFaYnyHGS+btl1/J47ZOzGOOxq+qwm/T3LqX0PNUrmfyVKH6vjDd8kFO2bA/7LX
         pqX1ExVx+v8Bg1/X+Xau9iap6gfcGToJODWkQ54ALPi1ZLGCMOes3RwJPAJDt63ewyTj
         dIDw==
X-Gm-Message-State: AOJu0YzTS6nMQjrPGmug5+4FMx5xnTW38JPmkycvqB7RWiqgvvH/tOL/
	VaIL6AlRrAUva+J0rH7mmzViZUPGQ1lIEPnCk23PIYhTEQLOWiuB4fehhPE=
X-Google-Smtp-Source: AGHT+IFLXiLEz6TM3G3VJw9FaSfINX4RBb5dyvu8RefY+whBUg58y+FemV0Z4QVZFLBIoCfbseeQ0A==
X-Received: by 2002:a05:6808:1289:b0:3bf:cc6a:d00 with SMTP id a9-20020a056808128900b003bfcc6a0d00mr10885393oiw.8.1707389846851;
        Thu, 08 Feb 2024 02:57:26 -0800 (PST)
Received: from [127.0.0.1] ([13.83.1.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a056a000c9100b006e02ce964b7sm3360618pfv.184.2024.02.08.02.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:57:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
References:
 <69082b9835463fe36f9e354bddf2d0a97df39c2b.1707373307.git.tanggeliang@kylinos.cn>
Subject: Re: bpf, btf: Check btf for register_bpf_struct_ops: Tests Results
Message-ID: <60ccca73-36d3-cc69-0ac1-bb564155d63e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2024 10:57:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7828113236

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/95e0e3a258c6


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
