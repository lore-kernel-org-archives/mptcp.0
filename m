Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3971D1C05
	for <mptcp@lists.linux.dev>; Wed, 17 Jan 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460262; cv=none; b=ntA5MKcqyvDtkHOM/Wu/5GvU+azhXk2daHySuSA/kQCmQNERpl0iTxmwCjT28+DGgxSspCIyMjFJ7SuimBogQz4NS4VmF8KgiC7Zt+94yj1bZ+ymVmfxeOODH8abW8xdgLSldtCD17ymXZVm/VXNSLWcp3fmJJ6lN4ZeFhCTLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460262; c=relaxed/simple;
	bh=EQeIsmJisLT2E+mmKpnzi8tVkyvz54cZR4nZ05Z4wBk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Content-Type:From:To:Cc:Reply-To:In-Reply-To:References:Subject:
	 Message-ID:Content-Transfer-Encoding:Date:MIME-Version; b=O5Ln2o0/Crd7BicE9M+XquKV5MBd5qi+neM1NVuzUN2v9n+nfGmPTW4mUDZTfWKgzglC1ATPWgnTZknQyj/BdrODpewaskyl8bGy1FDFnRtQAYCHGRgappy+PP+UO0JLmsZ+2SXzSxrUleTb/Wzl7yHDqx8arwEGwFOfpEhNDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URzaAbp3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URzaAbp3"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78333ad3a17so848127385a.3
        for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705460260; x=1706065060; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omt3LfHLj23etc2N+NisXUXI4/8g39jf6U+qmC3FlwU=;
        b=URzaAbp3LW470cWXsUjEFmoTakihv7pgXH6ajZVvy9YvvJLiKc5ZfS+omvyoeI1Lyh
         YytQDE7ycv+1oacJpY5PPe9WdUiNBcUz2LWpPySEUX/elvDS/lZ1jC4UXytFDEFNqi+4
         LKS4bAigVCrl3ATqEE3P7DXZSmCN/Hqtl2z32DlR6D/f+FLHEGB9OQdkPsv8khP6yKH+
         no0RvgLiNuM86Seo77LJMka6uFtZBC00LuTk+gfc21SDV8daw9Nd/KBG8+lWc5nkqkzq
         25o4lyIWYY0TmzYx1aWZ3UURhzCqaPUmN8+8mR6DkNm8vU3GA4PWiaoUBxgcYueEROYP
         WN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705460260; x=1706065060;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=omt3LfHLj23etc2N+NisXUXI4/8g39jf6U+qmC3FlwU=;
        b=NWG5XKQQ6CtpdQgDYwHfuQRtaZH6C9VPwpAKRmuUrmVdKYwyL17zUfUp3u3Rsha6VO
         5toV6NQLUBC8QNcdC3DAq4x5PEdfJ2zMV8eyzu/0P0pgsvkpc4Q73ER5hnXgKjbTD6dS
         KFGpFtebC4QKgR3ApOB/3XE7Lr7EA/zeWbUCzVtfXMgaujZ2EiznEaI3GluxDlcaPiHP
         MyllGAUAGfqAirX5q1SE4jD0FEWQX7lyrEiDx5abx7F6+YrleX6SlY7Z0iaqYVKRiCDq
         HwT9a7NlZFiANfclkJKQcGKzLU9n+36wZzNruaaNG6aWlYppP6kMK5rpmpyaHm3zHq7O
         4F+A==
X-Gm-Message-State: AOJu0YzdF6hziedXkOWcC3Tzo8l3uR9lH1CdiRVlUpZKMZ0w+WeNZ458
	OlVePRhKS7Y/WPbA4NbIOg==
X-Google-Smtp-Source: AGHT+IGk0JUX80iTcB/CS3kk3+t56EClKtQISZKs5rVv6t6YMM6TUXrlB7oDxIYBR8IsvzleZMEwbg==
X-Received: by 2002:a05:620a:1655:b0:783:325a:8cd0 with SMTP id c21-20020a05620a165500b00783325a8cd0mr9437072qko.86.1705460259990;
        Tue, 16 Jan 2024 18:57:39 -0800 (PST)
Received: from [127.0.0.1] ([20.109.36.208])
        by smtp.gmail.com with ESMTPSA id bi23-20020a05620a319700b007833f101522sm4171928qkb.60.2024.01.16.18.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:57:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
References:
 <56241fbd64982b15aed04269c8b963206661acea.1705331716.git.pabeni@redhat.com>
Subject: Re: mptcp: corner case locking for rx path fields initialization:
 Tests Results
Message-ID: <2e142d85-8e41-3f91-8426-0e00de9daf50@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jan 2024 02:57:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Critical: 1 Call Trace(s) - Critical: =
Unexpected stop of the VM =E2=9D=8C:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7550415246

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1fd81af266b7


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
