Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682D378D8C
	for <mptcp@lists.linux.dev>; Wed, 15 Jul 2026 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087564; cv=none; b=GOX6dfqS2NrZC30zt7qmkY42IRWnLm1KWHXFt8grKKvzV+ycRa4kdQ64D4wHU8/WU1+TUGSjaDbQNh7F3quUMUXdbXT0DAYUMwvhzd9UQlHdlg8cHIwXmSBVnLIYdfWF69I/BiaUQPHgjKHnzezCKQZDmjOTv6/jKvBsRp7wwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087564; c=relaxed/simple;
	bh=RQLdhDe9OPriqJAC4IJXIJFkHcuacITUQv1sH50abyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=EC6gJdGD3lIsNSd4oRbQYo5ezUVffd/Y5NChcyXF0qdadqhKE/w3gSOqB6YX41U2p849DihfiUmJVRinZgTQ9ewJIiTKrfcFBzN63mqOj/Q5PpXQj5uMrgnGq+GTvI6weeGJjfbiZG4m34a3EUSPQExyQBvTcHXIDE8nkh7Mfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX2bvk6v; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX2bvk6v"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ee6912d86dso13457506d6.1
        for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 20:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784087562; x=1784692362; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jvlwyJzzWae5wDazopaFAaXhJw7q7ZgTTScMHkBoDp0=;
        b=TX2bvk6vQxcv3eOJaI5DW4ixFY6PO9oSjLqEEbsPIA96VlXMYmO4sS9xD95HPK0udC
         0B5TtZ/JcWSe/xwLaJEYEE1RH4u/6LPREfTRNBGsypjdv3x1CORz95dhQNGkxFs/kH3k
         azUVVE9GfZepI98cbIYHkoVt6O7jvRHNMCTrdJq1v/y3/q3gfmodsM2rUU+N0iVWrzeV
         d5qNUJY87mlQBLv/ReK7d/FOyqsYKIq9V6z2Oj1xQA+4+3T993Vs0LbRU6aA2W6H8ooN
         lIWlrE//IK6rbPtsbj/9xxZiJSfiNGYnkDRRmZuGu74M4uzq4Un+CNAfmd3aezKc81ot
         pvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784087562; x=1784692362;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jvlwyJzzWae5wDazopaFAaXhJw7q7ZgTTScMHkBoDp0=;
        b=W2QxmehzUYIkfQpEE7N3PdhYF8fj1RsC+KpqVqnha4ZaxcY9Nx7eA/Hzo0mGYKXJ9P
         5poSmgCHh733u5y2BgecI1RNCXUTArVmxwUeKVby5LZm+plrGSrX+SaG3PUKiYjS33TC
         jES1bPF6O/u8bE5fSC6hv2ySItpkeEcdRpvSH7ZcUW/IkfOsJ5shJOdGcYszX9voYFII
         ZVt5k8yDxj48lqqG7+4LcXklFqWsq1etvw9lC8aLWYuU0H8U6aiCE0gchLLFRY8LlWGq
         8g2tnXhgFS7M0IzoP4t6o1V5pYtlJJYf4e6S60NdjZvOa1RbpREGRZ3KrbqC99+R/15j
         N78A==
X-Gm-Message-State: AOJu0YxpsANKkOoQq84+LDaydPYaAX9ja0Ldgd/7oxrGM6b6kw+RXvdF
	6gO6bxdduPWVvswQMipIX3JTDCAaY0yWoyFOLX0jHlZrJ89e2XMJ8OvzeDWj7EM=
X-Gm-Gg: AfdE7cmKo6K2mv4AFVe+zw85yri+02KG+Ka9jSuCZSIXC21WeEWaTl/mFwHTasm7ipt
	2sR8sRQTPw/YFVU2LxPFACR+1u+mZc4c6ImPLNcEUVC2GOkMvfHG92vnPh/Q+qxvg8DtRc6Egiz
	KVnIRgLRKBZZ8ZAjRX/jCqFXyz2eSBBVxZMeKxjerhDXSNMqlPZhVweoeiSWSwO6sNu1s0sOL0K
	Z3soyu62Rskh1Ke4UfVieyZz7UB/R4GneVUBlzT2pa095DfY3VQn4kqrKB+fgYXhQp4QxfstOl2
	fWHzm/TaobxY0yVv48RWCO37M7hgzAa+Qg2BhRujkycgSvNsaBhEVXIjC3EbVORfweiqhVZdsPW
	SHNv93/HzQH1844NkucUDdkWVfI1uyREmHNS71jdIiPkR3BcFyehEyNdHWHcHXPHqx2sOpMw5tl
	Dhx3XCMd6ogtAF66DUAdMgHgIR
X-Received: by 2002:a05:620a:a199:10b0:930:91f1:44d with SMTP id af79cd13be357-93091f1072bmr227127785a.44.1784087562244;
        Tue, 14 Jul 2026 20:52:42 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.103.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88e40sm1592685585a.14.2026.07.14.20.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:52:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1784082850.git.tanggeliang@kylinos.cn>
References: <cover.1784082850.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 00/11] selftests: consolidate TCP_INQ
 testing into sockopt
Message-ID: <78df61a0-8652-e8ee-e4aa-8a0be5bdb81d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 03:52:41 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/293856=
76727

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ecf3e45a76bb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1127842


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
