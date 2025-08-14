Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77891F5851
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 05:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755148194; cv=none; b=jVFkjC9o6tWG76Jjr4/Km3DcWeZnlQKW7KambQDe0J6nItYxmlYbJ2UGF3BVlwxXTfiL52rUblFU9IgMu7jF30n/r82lH6j+tV0kpomHSIcAGWYLoknw7MWxvLObWxLJ+DSY1eeXjl/w9tOoO+1Z/U1kpE/SeJREvPMxLGfWuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755148194; c=relaxed/simple;
	bh=r5pipBq7Pu1wHWul7SzK9JmnKIFWtn4VwJkvJ6lyfBo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=T1Y3sqs35DoaDQ8mnUpjgO5luGua1/iYzP5QHo25MZw9v5ICGizuFMhHGh3JT7GA4EbOefXZXhww0D0r1PZ4V9/Cz2/PPeGKkOvz5dBH9zgc6m0T2l1AgckR5s/Zng9Su/sNegIWy5SV9/qGkCYxX+9DDt8Z5jRcMwvbaRvmcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJui31Ep; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJui31Ep"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so1065613a91.1
        for <mptcp@lists.linux.dev>; Wed, 13 Aug 2025 22:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755148192; x=1755752992; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IplEWjVQnSt0cEtaCHnQSzhivCtglhgr3c0cri2YH0=;
        b=TJui31Ep6g6Wyu1vcm9xSUXZ3Omkt/NIbeK4JnGCUwxj23dXoQJrxAlZlMC5c6tmJY
         XeMqq8k3oFQoklxMjX11uLei+xoWnKGfVxkHxOEIlDDNq+xe5BoooOrXeSUROotvM/Ld
         w70rve7DCVqvVfDdMmWHCzgwOquWY8pfmRge9qyryNKMZW2b5zESl9eeDvxjmRWIG67j
         A7aE90yxGrW8GiWTpJ4GOXvZL1WGmwkJqFgkPWesKCBTX7CBdW+0tq79WOrJUmkbI+5g
         I7jVkUQ3UbbUNGk/Lq/lRlQDOopwUXPX8gwKM4JACwCeltrywfpyCM2MfE+OrQ6iKqCF
         5CoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755148192; x=1755752992;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IplEWjVQnSt0cEtaCHnQSzhivCtglhgr3c0cri2YH0=;
        b=KQtM//I/eNoQCU5j2K90GIMJuRQ7r4zRoxV0y4LVVQbQH3f1CMwjqZ1n9n/cMOPWkg
         i1KGybjE5Q1O7xmWBH3iWDfNuggVcSRHnUSjV8DE2yvjVM2YKBq0zpufpqybIFp53Ltl
         1QO5bydyCgZRkLmJDCEZiEXlMV/ZfYZpS3YHzo1LycaxwlvPGIWF4TkZMEhOoGikiNSV
         fbdKcuaSEi/fZ0Xd3PuOYJJMkpAbDPrKyDTWZwt7SO3FE7GIwbsn75VxCDZnhGZzzoOe
         irQbr5nYadArqYTWzr3YbUfgkcUAYDOWJ02z7RJN5SJKawLHZgTpQevvV+iqzKLGpFrm
         b+wg==
X-Gm-Message-State: AOJu0YxY5FUAdcjC5TcUAAeaO3aI/KDR1Cv9iII0xp365ASOZBiHmTWT
	wjtBZ1dy1nO+JwvZAAGCwSZnl92d947OfF1H1mXbAUhj+Fm+4d7YW+rNOtur
X-Gm-Gg: ASbGnctLnYoSM37B9VNsVN+0owymzBCHWxJcTi8d41R6lNCjZqNTjuFX1eT8UbCbD2p
	g+96jvLHv13mj+fGuUwTdTaWq9im+Rv7G/4rUAMYkxQsX5FyZi1ejggZ6GI3o0K10NsL0sNDjwI
	JX9Jr6U6AdcNXfLkq3Z7DFQoOmjkqNpmwUQ/NAv8yXM5SMjgka0NgYkNBYf28uA4SNDIV7jdQhC
	wBMQ0SarWOhJmrDBqE3GLYp5tFC2FjPTOgiX+R1Yg7E4unh+JQY6gCEP/49yU/bUxb8ZssGbeOY
	XkWN6K7GXxUjAvT9sdSpgfUhZeB8wdrvZg+mKoEuof+/5je3gZz7j43rm/grEM60D9HVF6O48o2
	D85MwS2qE/vZ0o8NsP+Bws2pKhfO2RT03frJouzQUMRyQnIJ4
X-Google-Smtp-Source: AGHT+IFuYmypeJfgNO96HROG36JjpsDO7bcQZdyG7jdalWw3bsfUKKR/hgYCe3BSp2KnQwzkwm9mlw==
X-Received: by 2002:a17:903:19e4:b0:235:ed01:18cd with SMTP id d9443c01a7336-244586db076mr22452045ad.44.1755148191624;
        Wed, 13 Aug 2025 22:09:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.224.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330fc986asm510731a91.14.2025.08.13.22.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 22:09:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1755139312.git.yangang@kylinos.cn>
References: <cover.1755139312.git.yangang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: check fallback mib
 counter
Message-ID: <db7ea030-0484-e0e6-62fe-2e713f2c7be2@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Aug 2025 05:09:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_syscalls =F0=9F=94=B4
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/169551=
81183

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/464ef2c0d83c
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D991281


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
