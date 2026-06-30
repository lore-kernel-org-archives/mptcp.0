Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC934A3DB
	for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818575; cv=none; b=meMBJa0Duh4B7OWeHKBhslLVrZHvVvkFGM/THk9bKIRlDCoR8KIZPvKsmNfY9hw2/Ckm09a+LZ66gJLqjwv3pRrP15kMZFiNfM5fEfDC68rNISGC9lC/WXEI8HPBC1SSYZnLsxrUK2trBAIsQ3hhiMtripCg3VG58WELMOg5XfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818575; c=relaxed/simple;
	bh=vkg1qY4OAWQMAuOjBKLq7fesyGAvd+y/cQSDRcQO7/0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=NkrOAG696ud5CfRI67gs+oe6O91/JWjg4EnU+61mgkSyV7M4ZVryZa8c4/uMUXTkKQlcaN+xAQnWGeJcJIR5iUbzSSn+mAqug19usqxBvDmTvwyo1Bybcy8LH3k7KGrB6Bao7o/zefWmslYR3NwKTnRYLPY4/G98vo9vvk4M4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh6WUbuG; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh6WUbuG"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0006ea8eso15611071cf.1
        for <mptcp@lists.linux.dev>; Tue, 30 Jun 2026 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782818573; x=1783423373; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcjCsU631rfE3u6Vr2KE+JxZeBWqdh9jm2q/2K3JH8M=;
        b=Yh6WUbuG9vRdPmi3EdZduUWCd0Xod7u9SS2ffmXRvdHqw1M4FqIePHzkIpTtnqm2Q0
         5qdKqdD3gZRUTU/VA1x+Tdk/DpZWnCszpOR/QBksbLfDt9vE3+bESdg+RJb84+9Qduj4
         RMqIY7CDaIzNKVbCLF57eNtEaMBN9xVHXQ86eIzhj23RE4Coqf+diieYV4Wj7ase182Y
         4wi5nsup2h5W/ENxv2kVUhKueemHsTwkHAqao3SxmzXO8BJnBn/EUS1/YFGInE58puyq
         WO56JMygY9hnDuPQsKya+lXEW6N4gmPaioCOmqjIWiUznxeP8GA0LwdEwyn/D/LrJiJu
         YpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782818573; x=1783423373;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcjCsU631rfE3u6Vr2KE+JxZeBWqdh9jm2q/2K3JH8M=;
        b=P9Y1Rp6DQxAspvc8A7tFbJ315Kc5Nn7nKpC5U/SkZQ/rCMCZot2fXsGVoSYFeV5Q2N
         bvqDwaZU9YfnRXTG9B9+MRDLRqukxQNBUSfPPPIXw+uo8GSiMyFs0GCD3PMTASMBLkCE
         /YCslahTCWnbhgR+Van+cOxnIFy/39nQAb9RivYsjv/0qqIfjNmj5Lsa7+zHsuC1Q2T+
         ayMXoNFBZdlxB4EdnDi+x1gaJVXH+ddS8srqsOjQM7Oqzv4+ph4rSUx9zmVtUwi0Jkw3
         NZBWDJvbD6wKg3ebEav8gUpWv0qBKZevkA4B64L50TM533+cqZmSH6RMxASbV2gTbgq0
         vluQ==
X-Gm-Message-State: AOJu0YxcRcVVp87Q0YZXC+23B658TMAHttFn/gBYM2uGBMCvNc5wXK9B
	w0FgPPUToIO4vFOfUj/4wuOECagAQ5EopYLn3JWZRkllUdwQjQM03ngCBkC0ox0=
X-Gm-Gg: AfdE7cnInNZiW92Jvf4kKLZgCFCos3pO+scsoeFz5eub8Ia4KCYth5WBnvzq73cOoAM
	0tIcMxA2w8arjCfhdSVSyZwNVswWwo1D7SsCQHgrnjmn7TddXIAyV/AqTDGyMabXFXv407tGhrk
	N5SxUYrTrjh1V9W2YqzECrvULYjxUZxMa91w8QDEuOz37JD5CPFdSrc0yAXJZB+PrPSwecgRczi
	cfBibRE+0dMCd8+mL6Ii8Of5DknadtxmLHWcBQ2BfjUYPKl4pdbq9BoltQh/IjnZg2TVN2IcaS/
	zmY2VMHZFd9QuZiF4WZWhmvcdrEVc4iaKS3ddCfTPN+XUlP/+04Zsv7WOmnHTu7YR5+rPCwu6IF
	eHe4KTBSX8itr//9GgiqRbAWTf7xfEh1bOy560B5vri8SOdBFClHowK4/JrPwT0YdkVC0Yu4nqE
	+GKr3/ECgpLcGvVLUoNduPZvgytA==
X-Received: by 2002:a05:622a:4d:b0:51a:8c86:bd42 with SMTP id d75a77b69052e-51c1ca696c3mr2136931cf.63.1782818569556;
        Tue, 30 Jun 2026 04:22:49 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.158.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c1080d50bsm16855331cf.3.2026.06.30.04.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:22:49 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
References: <20260630095432.1340629-1-chenguang.zhao@linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: fix extra_subflows leak on failed
 passive join
Message-ID: <bc8e29db-1fa6-5122-7d42-3bb373158969@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:22:48 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/284381=
79349

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/654ae3cf6532
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1118853


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
