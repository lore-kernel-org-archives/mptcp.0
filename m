Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200112;
	b=EQZQUQ/T7Uy+Oo2jK4mq7GKh865UNAkQh4SWQXFRCd78g8N6EQabeFRddlXZEUWjrg4X
	 xDZJwzrVpsfi+DbB/PIoFeELniNZY0J3pgeXAGwlvumbzjJ32zi/Jn3lbM3jchSh00Xic
	 sIBcbl3Qmq7LqFCSfrkR+Cl5oLc4gQszmH6OtYll83qODn7s6uww4fhj9554AOTcXZH2f
	 vDG0nyGbVg2gCvN9ugPJuBSXWc6ZcqlQ3ljiZMM/UwYRWCWPoZq+m2LCeJvh7gQqWp7OA
	 J001OI3dhq6CtbO/J6YR0hT9VX2IiOx/D1avy5/FjVuzDaoQwr55R76uDUtRpeDz85g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200112;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PnhCgrs7ISkCCdwI2rNtk5stzcwYqIxcVHWJei4HhJ8=;
	b=tJgGLwX1UEwZIrWdjOJdcQktfU4mXZHWklWDyH2uRlEpfo/xY8L9MPrCGQDplcD8vZgQ
	 j37QpPFsyNO+IztKGqgXlDbytU17vanGltHFJv+yF03wzAq3VXtKNc1YYkTT07f+8m5cG
	 NTsMHQ/S6xKHOzK1EV+f6U3PsHFhNFhoIr0GARxJcgNLb9OZRQFgntc+oMRAplmu5VQKK
	 hypZNqAFZ58hP56+TwW68sLMGsbmygg5m2dos08fAPKBXOEWQH5IFg79kGtjj0PJ+EjTq
	 1WPMC7yQF4et/7pNsiFoOT0GkU7tw+Er4ABM50ydxxzRyvR6eQQTI9QeZSyLZYx+wHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdKYiLTh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB2606A33B
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdKYiLTh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB641F000D4;
	Fri, 20 Nov 2026 18:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200111;
	bh=PnhCgrs7ISkCCdwI2rNtk5stzcwYqIxcVHWJei4HhJ8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jdKYiLTh1tfwvXd0vFo2aEBXDIzJQJFBvw13OYTRyrcj46Z2NeRKetPhatzgCqWui
	 91Lb3rA+mlGIf/PmFUFoubvJQ2S2YnfEHSr2YGdeHnA9s9ZI0dog4DFwyhyrQZlmTm
	 QaBDU6a1VBUriXleSCB9EuRTbXOeNI4kUqrFVqzXi8pvLZg+a4kfwgXgGtK5MYUBhv
	 77Tpc2PoxOHIPLSs/F5bTyk1dcpbVHhIi/wWHW8ai6JdZpiBlfU0ZwgE92+RSHlwBL
	 1T3FUaJwGdEACrpIIZY4/Fp49cWuOhjdRgxwhH7D6yeMXM1wSvyX/aNFBVr+5053hv
	 JR9Pwvc8sj+qw==
Subject: Re: [PATCH mptcp-next v29 5/8] mptcp: encapsulate CB DSN field access
 with helpers
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 20 Nov 2026 18:41:51 +0000
Message-ID: <179520011112.3133.14475010950011269195@kernel.org>
In-Reply-To: <93f8727507735aefbf0794b1af5b555993249a5e.1795063943.git.tanggeliang@kylinos.cn>
References: <93f8727507735aefbf0794b1af5b555993249a5e.1795063943.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The From:/Signed-off-by: identities don't match in commit "mptcp:
  encapsulate CB DSN field access with helpers".

--

mptcp: encapsulate CB DSN field access with helpers

This commit adds the mptcp_dsn() and mptcp_end_dsn() helpers. They return
the start and end DSN from the MPTCP skb CB. Direct accesses to
MPTCP_SKB_CB(skb)->map_seq and end_seq in protocol.c and in the
mptcp_rcvbuf_grow tracepoint now go through these helpers, so the CB
layout can change in later commits.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the sign-off address don't
match. The commit author is:

  Author: Geliang Tang <geliang@kernel.org>

The only trailer is:

  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

No Signed-off-by uses the author address. checkpatch.pl reports this as
FROM_SIGN_OFF_MISMATCH. Documentation/process/submitting-patches.rst
expects the author to sign off.

The series isn't consistent about this either. "mptcp: remove CB offset
field" and "mptcp: sync mptcp skb cb layout with tcp one" use
Signed-off-by: Geliang Tang <geliang@kernel.org>. This patch, "mptcp:
clear rcv_data_fin_seq in mptcp_disconnect" and "mptcp: defer read_sock
cleanup to mptcp_worker" sign off only with the kylinos.cn address.

Could a Signed-off-by for the kernel.org address be added, or the From:
header be changed to the kylinos.cn address?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795063943.git.tanggeliang%40kylinos.cn
