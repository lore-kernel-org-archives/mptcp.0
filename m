Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D533828B517
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294517; cv=none; b=bdalhfVQuAyB4aPnDrsqnFVDCGgMQsDMerF7v39nNuTIo6aY7GlpTQ0R96p8hAHA2Kj2NZE7dE2vvIDRSVDNf8ZIbxV/dduFDFUQdOs+TdVNL48jatES3zqAWiBCqewWpiEwXaIhikXDAIiprlXd/SpE915xHlt1jaGh8TFw+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294517; c=relaxed/simple;
	bh=evwOVVzP3bV9lky+yEW4hj8wM2hLsbXXNUEDVM1QNJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2+gK9Zjrhr2bL1CwF74Y09LvlVmgLvnuYIaLwJ1FPtCERZPc8XL39DdltVdsWjdUpedpQ7Yi53F7+rV7qjk/rh1+EJckJWD6fA16gQ10qgxgMgyb5tq/KQ8jZUHBJeqbvnTrQaj5Z8zYRU/JPHFDOkHXzYl+gKPRQ90b/+iv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTz9znSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTz9znSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAC1F000FF;
	Sun, 13 Sep 2026 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294516;
	bh=yublTTmzSqfIpACCeNgVITq9sLg/Hk2l5mmY37cJKD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTz9znStvrdN+h2Ys0Ixz807d46s4lC7b9Q2q3Qq6SWLk+VXlFta0JpOlk2H5X16K
	 dwu50rxTh1Y22PBVr+VlsvLWfoNu9FBSWzaUBlNy0ybmlMVGf5saAZdOQz6kXGRrIi
	 BOQCTzpKZE+nhQLQj1dXtsH0Detkna1fHRkE1wABJ1VRJQsAGJ9ouHgzpuGGwqTZdm
	 1BYEF8rM1kjQrHMSoCK50a8xfrcmVxOQCjTpIord1o+vwBZCx6Di5DwrZLDvnlrpaF
	 af+dVlbCecHY6r+cIL7dZrGBbwhp95xbVAdFJnr9Ck6hYxbtsjnYq7tnE4Zjp6CjJz
	 2d+5u+YbXrh2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 05/16] bpf: drop duplicate check_app_limited in tcp_bpf_push
Date: Sun, 13 Sep 2026 18:14:44 +0800
Message-ID: <aff272cebafec60a4d2080ab1626946870d1262b.1789294365.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789294365.git.tanggeliang@kylinos.cn>
References: <cover.1789294365.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When the sendpage->MSG_SPLICE_PAGES migration series replaced
do_tcp_sendpages() with direct tcp_sendmsg_locked() calls, callers
that had used do_tcp_sendpages() kept an explicit
tcp_rate_check_app_limited(sk) that was originally needed to cover
do_tcp_sendpages() (which did not call tcp_rate_check_app_limited()
itself). After the inlining, tcp_sendmsg_locked() always provides
the check, and the outer call became redundant.

The site changed here, tcp_bpf_push(), is a MSG_SPLICE_PAGES loop
that holds the socket lock and only iterates when size > 0;
tcp_sendmsg_locked() is invoked on every iteration with state
identical to what the outer call sees, so dropping the outer call
is safe and behavior-preserving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp_bpf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 2e234d155b5e..d5fcf3ce4861 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -108,7 +108,6 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		off  = sge->offset;
 		page = sg_page(sge);
 
-		tcp_rate_check_app_limited(sk);
 retry:
 		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
-- 
2.53.0

