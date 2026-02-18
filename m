Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9230F1E8320
	for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771447797; cv=none; b=Xhf4Yudg0zUlR71W5kYGhe0LOD9iGxiUAWg+RfbwKvc/Fr9BAsZz8cy4De1RtrtFeqw3I8Y/EI1vM2lvOpBPvle0AnFKyk3lNBN6ryVJnxEPhcJ4gSC7HUBk5W5quDdvHL307Wrbx6KaRR9ppPtDppfcEmxMSqW0jET7jZz6j44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771447797; c=relaxed/simple;
	bh=QxD7t/KnEdmt/P9+5BNUBjBbRo4n0kSqTx3oMEHFgys=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=VwDU/RGtZg7i0jfZlc6tdtPwc0J+y8hulG0EliEwJG95VUoXELk3sEwiZ5WfNYo7pgSFBTRwqonOBtQ+ESvPYhPZHBpfX87upmnMvxyiYKi6aYqKLKrBTqUn7sUiwxRTH42UoWIG1UNh1tJDHpjOtO+jT/DvSnq9/LIWOt5faNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J01KHNt0; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J01KHNt0"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8cb4081e82aso28221685a.1
        for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 12:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771447795; x=1772052595; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqHXmk6oyZn54nfJIm6iUnPcKBvvIQWg9jvKIaMtZAI=;
        b=J01KHNt01hd/I7oHJND52NJNux3i3GROJfDTgDxElLLcQV2rocBF5SahljJn2590IJ
         yJHbgvY2QR7Yl0KrGZ7/mVo7DKzv3Q04S6jCm0EaKW2PwL0LT4EV4oo7RPId4U4lunDa
         pqqNIwFC+Qn+Jfn1TvaSlgDXT44URSekHJGZqQyV3kjZHwlF41YzOYvmmAiYufmeq+dx
         UUe/8+lCextC7OIMJiM5eqWikqMAB9vb8aBINazbzhbH33hg9HURtv6m2riQMmn10oX3
         Oatr8Nbbuiim7Xhx+gJzyaVfjrVIB5heJLb6PGIkkz9Q291g4p1PRtkG0DjezJGTglsN
         nBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771447795; x=1772052595;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqHXmk6oyZn54nfJIm6iUnPcKBvvIQWg9jvKIaMtZAI=;
        b=D/SPOzFiKH2Qolj9ldSB5handxTGeyEBN5yWWBgV6Ql60v/of+lfP3e9otC7rJZEnk
         PJJoXrqVmImeM9u/YY2J5qWL8W9T8osDZ/jhRuTlrgQsA5bg/bpuGfbeBbT67yjB1DHn
         lZXq5Xowl+qabgwuGKwXXHl/MRcWWtQFU8iZkMNtOXgr9sYtvf3x0A/ESifk7JNizy9y
         UC77Q6yZkOxCxMO9BsPBC/CFudcFSSYo3UW29liPgZWZv+YxY6rcCM2IF5Lhp2pIv5vp
         ZFIaSFz8D6oAox9RQfoGl74izI7KbLz8rd/rON6aLtWep0FCXB3wJzAjX/zZJ+gcDnEH
         MlFw==
X-Gm-Message-State: AOJu0YxSShSPP0LFp3PGVaX6t8hRTYde1oRk068kh2RryU19CHLneYL9
	VrRqkdmKFvB004mpHmTa0pBPPNM0ZrJ7flmJpON9SZNhb2IZw6qK039osnA9nHI=
X-Gm-Gg: AZuq6aK5idtDj0hgyaj99vk+/GMPTK5WdNfsfgT1buea2hol4j8nAOmzGO5Ckup22LJ
	oifeP8j/aHqF8/Spx5bb9LLB1/75dlV6c/ORkvt+cMMHQW0EVqaMErqSYv8BylRWRvM3Lgf8Str
	wx/JIJVUjch1KoCTPG82L8SUm9IhOme912R7oEGs6J4pG3nAFHm7yLgz/RkTX2er9XMsSgXyyKc
	j2b/Sx8IVADmzzOdLd8JxS4ewQflPeOLG6n94ccjE6RrbYHf5J5KdYLKqGNk9S//HHVVOFei08t
	brduLwFmWNDNd3qOi5j4RgHePG03ejAjpu1VHAvmuX4t/RL911mIkMh1ZBvjRFoDHLm2ikc4cYW
	V1PJjAcu9uSLcZOI8na0Ovps9fq5nNiOhshT/sr/arrjdutnopYIwT3BF7C0xcLkVGMLOyxdEsl
	dKPTrt5BZTGbzhEWSakXAQ0Udr/j7IIXTN6LE=
X-Received: by 2002:a05:620a:400b:b0:8c7:132f:ba95 with SMTP id af79cd13be357-8cb4c018c47mr2054459285a.81.1771447795394;
        Wed, 18 Feb 2026 12:49:55 -0800 (PST)
Received: from [127.0.0.1] ([172.214.47.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0ce73fsm2030833885a.11.2026.02.18.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 12:49:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
References: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
Subject: Re: [PATCH mptcp-net] mptcp: pm: in-kernel: always mark
 signal+subflow endp as used
Message-ID: <8ea69fdd-21c1-4ecd-c723-33a45f7bf905@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Feb 2026 20:49:54 +0000
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
test(s): packetdrill_dss =F0=9F=94=B4
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Notice: Call Traces at boot time, rebooted and continued =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/22155265067

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/efdd4665fff2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1055307


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
