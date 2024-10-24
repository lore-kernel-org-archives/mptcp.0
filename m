Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85934BA4B
	for <mptcp@lists.linux.dev>; Thu, 24 Oct 2024 04:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744397; cv=none; b=syjH6kfxdnmP1Aa41/8CxnlLWG6lfZCXmFrCP+my6e3AMesbMLZuuLiYEl4QO8YevIAiabO0SQp0PnMY4FAp6WXKVmoX2WvA+8I4+K/+6TvKo0KoWT44RyoYe/YmQKaqzXWWd2uuhKADNxNmxkiCHN6jYSBYd5lZnc/3kxWx+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744397; c=relaxed/simple;
	bh=ZX1XympQb5MlOgQzmQl9ynKvrwXgGMezRGilQuQrXVc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=dttwmJC27pYXndITCgHrf51PFgVWWejQrIZUvisUue5qOLQ8FSkouW8uBumfyWwUyPxs3HT5kKYG87uMJG0KXE1+1+WIi4yaL8oUJaO+FzqCodEGWYA99btmlvJVsc16CqAAeIFZ2QBKcNVOuzz/HVX6CmfzwC4D07eOm03RC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYlToQ0G; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYlToQ0G"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso3298136d6.0
        for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 21:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729744394; x=1730349194; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOm9ZcSGGBm+jM+2Xfyz2dG/Scx54kVx7GhL8hWYB1U=;
        b=SYlToQ0GMGyyPDdgePwslmXsK1z9K40EE/KS9a9+05kmyPiwX/uCpZPhnBCVkerX8J
         L+QfNk1mJ9zezCO2RMPZjxsfyKTKVqNmsaHqbgLVxfgLnNcQwKmFuwY5BBy5815i7V+U
         xHeKHaZACPs5WZlce2EzZDYOF76m3bcemwHPzrNqxK+vM++KuATN0UyCnr+/QIWE7dJs
         irYyLhJfs+IxuA2cCbnfzxZnW5xFvDaXzxDYo/Q0Eds0k9UczYvmLdvChdTbxPr5EKnZ
         f1TKoRYlu/2cCPMyac55JJyCleZSQj5jvBWfAQjyi0LVqrFLQiTcJGzfHO+DCuketT+V
         4aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729744394; x=1730349194;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOm9ZcSGGBm+jM+2Xfyz2dG/Scx54kVx7GhL8hWYB1U=;
        b=CvrhDcUDdxmvvKXmJ0tmlJdGGEvUQeIDGoUAnJsxcvQxr3eixy5+hT1tjyKaSDH+r9
         AfoUMPZ9LvtzYxAqUlKHWcOAWznygcNQgb2cKVMg7+U4s6J+mENXDCbEnGdyAwsedEDL
         YzHYP8FpMbBFqvKtuHc/giRVzkwCn+7+7bvS0VEGVq6/+1o45rAJeVEhLaQ+AGiiLRdJ
         KHDvikxL24wk+1IxQb9UykxRjzZnFQnEjClazKNNXPWwG5gxYpqgWlVQToItGzTxBjSr
         kyI40XtuIwA0sz3Aurb3tgs4BI8EWs2p8P/mCBzwB2oBqnReNTZ0NP0xa+rvkZT21/1k
         Ik7w==
X-Gm-Message-State: AOJu0Yz2g50B5a2t7Huj4RsWvdZBZYBBDCLwJYPaLdXXDA0mZGYUrh9V
	W7h110csTu5ZqAoaYMRjVwsHrJLd65VeC1qatILpjtaozk4XjE/DBfo+
X-Google-Smtp-Source: AGHT+IHRo7hJiHItOHaJwlM/yxcnNC04lRafRAxYumJI9pKHtZp127Ga0atrjSTAu5KF8z3vc+kxew==
X-Received: by 2002:a05:6214:4807:b0:6cb:e6b2:4a84 with SMTP id 6a1803df08f44-6ce34175fa5mr63165186d6.14.1729744392926;
        Wed, 23 Oct 2024 21:33:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.46.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091ab02sm45440346d6.64.2024.10.23.21.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 21:33:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729738008.git.tanggeliang@kylinos.cn>
References: <cover.1729738008.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_Fixes_f?=
 =?UTF-8?Q?or_=22use_bpf=5Fiter_in_bpf_schedulers?= =?UTF-8?Q?=22_v8?=
Message-ID: <78371f07-3f7d-a66e-8f83-80b3cf01ec45@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Oct 2024 04:33:11 +0000
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
Critical: 2 Call Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/114918=
98749

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d6804cd6fae2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D902508


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
