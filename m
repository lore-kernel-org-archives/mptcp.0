Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267821946CD
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067729; cv=none; b=RZnio3h0D4jeD7H0ki3RqUVKWDS/Luu8piGhivzDR44VqO4+Vl7OsJdFoRJ0rQBtwoEburGCURUXTe1+/JR5tXHuKQ9HbP9+pR7iaU+IVAGuziFBBLaSK+gAtMPs2MmfJKjMtKJlb4s9FdWQB3bT77NqxPzLIbGUw8pM+tOEcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067729; c=relaxed/simple;
	bh=syf5iLNI1mFHy3deAwwTxqJim0WnsoLuBvnXgIGbU4c=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=IsLtFa68guraaqoZ9CTBAEj86h1io0B+7kfSo8TuSM9glroSxBG8LqJvUmojGTvRVqOZYOA5J9BncqFsU68wHg2GFJTFmiPXPUHI8pfWmUnE/oDoBTeovV5SPs1xzYcqUxGttymp9lAqVkN/SfVRTmyebZJChGTkLZ4FNV307Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eml4bk+R; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eml4bk+R"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1719654b3a.3
        for <mptcp@lists.linux.dev>; Fri, 08 Nov 2024 04:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731067727; x=1731672527; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8JuFsPuZEoIOmz8gJOBuD92R22TW9+HZz2Gufs+vvo=;
        b=eml4bk+RrOGRnzs12jEyN49P9RmtYb+E/8N642j9AMkPsaxqiLNynA2WW9IRZc5lnH
         pJBqdqp4Wam5Fi5ax4hbQCh8SfIDcQgSv4qsw2ULGMwA6EfCiywFEzUwqOUnrU/GUZVr
         P+NnVm2KLP8SZiIcbGZv+0ms5EySCBauFuddgOhlFPIHjHcbUgGWhGUx1f2tIBAV+hR2
         36VXse+EAoODTUcpAtPq6GgN5MGj04o69xcboCrnJCznh4scqCRgUjuw9cjMuu7KKyH5
         IBJ23xlylNb1mDWpXZGzr9+/5vLbCarmswXvV5SDDSFBrva0cz7pSSmWc45OZFW5JdOl
         t5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731067727; x=1731672527;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8JuFsPuZEoIOmz8gJOBuD92R22TW9+HZz2Gufs+vvo=;
        b=SKq+1p1ywJmPC0E/1WvxrNT6dS2yuTjsMwY4vVjxgm2iAWjXy24MAHFV6QoX4fslwc
         Z+Utnq2dMq7tRep1lXYu6B0l/kPnUp7FZHpGgOoBFI4ktGpzNiQ3CCU2um5I0IU0tj7J
         VwEFBzzCPCAv/YFWOFJ0UEjwXLIly4pK/nKtWW5TYFZu7m0rKpdq5hgAPQ1bRtWN/l0w
         NjchtY2pJl1vGIFxawdqcByljgHB6eZwL8Epx8CLsVxTcGo6HYny6jTsQKKY70WhgFfi
         9/kD6U2WpzkwWuor80wSm3lGIGBGIKdwsPWi59qA7O5dZ1PWTiUgZmyAaXWQ9qc6/TEr
         xjtg==
X-Gm-Message-State: AOJu0Yzo/eQzxVFPxzeVFPjM0XfZD664oXHP/zRM3k/rNflJybhuPfvT
	V1FuH+zQN8ssZTtRx5NPsgTtCtce7YXx40/L9ZgtROJT4vnbjq4=
X-Google-Smtp-Source: AGHT+IEKe+ltUroBZHBfyDegBVZn332w+0AesE3Ep376GrHubxCLr04pUrHRL7p5c3tHUFh7hQ/8+Q==
X-Received: by 2002:a05:6a00:14d2:b0:71e:4dc5:259e with SMTP id d2e1a72fcca58-72413360343mr3383695b3a.17.1731067727227;
        Fri, 08 Nov 2024 04:08:47 -0800 (PST)
Received: from [127.0.0.1] ([52.238.25.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aaa01sm3582215b3a.100.2024.11.08.04.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 04:08:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1731060874.git.pabeni@redhat.com>
References: <cover.1731060874.git.pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] mptcp: fix a couple of races
Message-ID: <1797d161-b526-d42e-0a7a-1f572494af8f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Nov 2024 12:08:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

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
uns/11741082429

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ea7fd41efff4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D907752


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
