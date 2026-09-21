Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2048F44F546
	for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988138; cv=none; b=vDkbzntoXlK1NkMj8Gy3bpHRsuDICN6AcVzHUPfD+aROPUKpT/i7L3XjyYqe2IG6fkJIII5tM+ZDNLUouuL3qE2n6xEmcWPPGOASB+jMAT+ztmN6vVAOkD1F6y3XoFTzebWwu0JVPvy6Ui7vuUuE0OLYQc5rJDpqpQuc433qlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988138; c=relaxed/simple;
	bh=XrPZomN3vD7Fr1Ggg3ebRImTTgmVhlSZsvWpNEC5sEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=A06eEq+Xh0cSudsEXM/ngt4zKobxz2V+okmTJX94H7R1i1mdmQIDWQ3Gc+Q/xMLGPYjfanzUIJI6k27gNzgL3JGFBsruHFRNnhVYynO7TlITs1vtzy8SlO8yQtntuvOo+UDlRziXrR0ATMKkJMcp6hMKLN6P0hHdZ+04J5//acU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqcSZplj; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqcSZplj"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so2560200a91.3
        for <mptcp@lists.linux.dev>; Mon, 21 Sep 2026 03:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789988136; x=1790592936; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iXYxvIIqc7aEHTlqwA8usw18KP0YgWR3Oup6w1vwRx4=;
        b=RqcSZplj/z0ktiCrbYH48Hhfn/XqHe0M9hjyJNN2XV0PFLTbHhSZTRyYvRWPS1LRP8
         kmTlSEqPMG0KibMqkKmjDzC7RCrUwEP/hbldz8y432BvX7r8kgWDnqlRMPrP64keoWsj
         F+bIz/xBTZvGkqgrigIseJjeuQtsVtArfK6VYDo65Y6OY13/P43MkgDvGEJUjY53OsMm
         v3tWRtNSn4Dk6Xqnv4r/GjNuc4Ny9my8V5Xqjw2f92ooHsbWybWT7sP9zfvF+JaMyNKY
         QUPhkkH16/rF6OBxWMWXphq5nkdQ9EYz5N1JJesgbG6kyCAcXHvwzl3U6b/oSZGiNq+P
         rNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988136; x=1790592936;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXYxvIIqc7aEHTlqwA8usw18KP0YgWR3Oup6w1vwRx4=;
        b=wavWwK1oit0lT9Ny7G+0uLVQGWOnKFhhjcikLf14JWZhtu07f60qHYtYB1zwXOyGU+
         nh3Lz8nfaxsrIxZ1Ycn258O7grfwuyD6mdYJLy7I0LRH+aLVDwM82Px7ATexLGEtQO95
         Ec8O4qZ4a0ehIMOVbGfeQ2tlDkC88VnZCrDLOO4mUxCQjoV15ReRMdi5HmjP+Hm7LsF7
         2mJlGAWmGp63h22CueO/MQH1se87jj+7qN1KR5QARv/DgBzQEaGnmZ2UUiU1P7jOd0Na
         AHRO9jJMc9lynONSdJX3h5I2D4H1ZfwcUr4ROjj33R1oz8Ip+LQ1Z1NZa1hHGR8VIk30
         Yg/g==
X-Gm-Message-State: AFuF++nBSuM7iKNkVFac6l3CSb/zih/16ly8yLy977qukzlh/RFwLD3B
	Lba52V7vf9G1nawzXhzHSW2pdX4kopUx7GDNrAHHl1LWCeHqONdaTp0BEzDf
X-Gm-Gg: AYBFou3RCmPdNeoUuh57532ROUJ4/8rg+HftCh+uXcFhlbxASZXup6cru+NluhBOwHs
	c8A/gICyMqNXhb9YA2/McDu6/6hUdl+EAQd/zgbYmmx2QX7XcmuHiZ3zh2kCF5GUG9GV6J0cgLV
	ILzclZzzmtdqk8e1NpMiqwCb+HVd1bNkTT7jAX3qazi4eIGWA3RbnTYbYrUFLVmGDFD0f4QpBqN
	KP6wKkh75SAOx/SKsGuKMvkS5phK4FzqS6o0NpdUwrQuW/getJ27azh0AvZSdudgfVWFAHkaqCV
	XH6iQuEPT6BhHIEXopbAGWngI8e6PMRn6lTICub+KBR2YWVZnGm2QhFTvG3vWItWWIIxHnLSO4t
	eyvtJWLV4yGk6k/nyR/lv7dflOukKYTKYHrbXqYIrTqBiGNyvXDkO2zDrNrg3y+r9rSRBV4Bey4
	9vmbj8U5fQN3NeBCpgI3FIcYgW+6WiNBL+iUZytds/Ggf1621zOVUYraps1qfjOiW+zW2ncEk4R
	9zqAnKDrhHLcqwN+gqhARY=
X-Received: by 2002:a17:90a:d4f:b0:39e:6a7f:1dd0 with SMTP id 98e67ed59e1d1-39e6a7f2240mr6395608a91.44.1789988136258;
        Mon, 21 Sep 2026 03:55:36 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.33.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm13655537a91.1.2026.09.21.03.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:55:35 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <97963911be08f2b6f99835217a24d23a99f3ac1f.1789983879.git.tanggeliang@kylinos.cn>
References:
 <97963911be08f2b6f99835217a24d23a99f3ac1f.1789983879.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net v4] mptcp: pm: userspace: fix entry free path
 via RCU callback
Message-ID: <b57614cb-a19c-3003-5ddc-20731133541e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:55:34 +0000
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
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35587560715

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/0f9d109fd7=
a7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1170225


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
