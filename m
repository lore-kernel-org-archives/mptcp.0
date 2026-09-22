Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7BB5221DA;
	Tue, 22 Sep 2026 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075196; cv=none; b=N3BRl6GUZfgq61NuwIVwHjG3Rlk+Xw4KiWl7OOzlCyu8IKKPXqtpiytCcb+A2QcDfDSZHmmo2RTmrOcVZTyue1BG331S6qsZk+qpCG9bTNzKEcaKVUSE/j6sZ+QCAs9OeyWhire4r5yQ3Uh/LXnGMQqAiK+IFWL8GTkyLzqoC9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075196; c=relaxed/simple;
	bh=mFq9B9jNA0PF5Vpyq6VzszTB8rccKdh5MWY8w0hJegE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCDUNNbnTkoKM1SyFlNSNZr00nAtMzQoNkIxSPfWqAJav1kz01b10jPULNwwmKqDR6rp6O6BWeGg3ZiPjWglcrHFQ5h+GEUJ3lOQPSAhRYhqwiLAqOaKqNGIORpb9QC+rsZWOFqZki0cadksl323HudBQ0Nd4++iiJUJHsSW98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/DElyzs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/DElyzs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8841F000FF;
	Tue, 22 Sep 2026 11:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790075195;
	bh=PvJbh3y/hzsmVNUvciwaE1LLC38Hf3Akyor8dkn4JBQ=;
	h=From:To:Cc:Subject:Date;
	b=l/DElyzstPSzPUiwaYhT6V4EqwvD7M2FdjAVeeS047+aK7NOhLtp6KX8nzt0afLQA
	 9dGJy3cfSBcRZk9D3SIml66N5o0yjIx9nWUDIg9jb6Hcg8+Sk18hYvwx1VXcyT9Yrd
	 yMpaarX4ALMEepGw0fTSraBRX8Ay6o/7vssze3ZSElVmND2CEMm4aI4olI6IbLg5iv
	 XeuUYcgjo3X+fwq2mifwCAP67V2bc4YIcmm6Mr8kX+LurOA7cAy368JM00foTkIScz
	 Hzx4wfHhJect7OtQriF1Hg6sJkrCEGAtnH0IzOrwg3j7oWvNLMJzPRJkRQSo/3hnau
	 r5s9x0+bPdbDg==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH bpf-next v4] bpf: drop duplicate check_app_limited in tcp_bpf_push
Date: Tue, 22 Sep 2026 19:06:18 +0800
Message-ID: <1f7dc605b16fc0590f7cbf5a27d57271926c01ce.1790074764.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Commit c5c37af6ecad9 ("tcp: Convert do_tcp_sendpages() to use
MSG_SPLICE_PAGES") moved tcp_rate_check_app_limited() inside
do_tcp_sendpages(), turning it into a wrapper around tcp_sendmsg_locked().
Later, commit ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now
a wrapper around tcp_sendmsg") inlined the wrapper in tcp_bpf_push() with
direct tcp_sendmsg_locked() calls, which perform the check on every path
that queues data, but kept the outer tcp_rate_check_app_limited() that
was previously needed to cover do_tcp_sendpages(). The outer call is now
redundant.

The site changed here, tcp_bpf_push(), holds the socket lock and invokes
tcp_sendmsg_locked() on every iteration. The early-return paths in
tcp_sendmsg_locked() that skip tcp_rate_check_app_limited() - the
MSG_ZEROCOPY allocation failure and MSG_FASTOPEN branches - return without
queueing any MSG_SPLICE_PAGES data, so there is no functional consequence
from omitting the outer check.

A potential benefit of this change is that it facilitates future reuse of
tcp_bpf_push() for sockmap support in protocols beyond TCP, such as MPTCP.
Since tcp_rate_check_app_limited() is TCP-specific while sendmsg_locked()
is a generic interface in struct proto_ops, this change allows us to switch
to different protocols via sk->sk_socket->ops->sendmsg_locked() without
carrying protocol-specific assumptions.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
Note:

This patch was originally part of my ongoing "MPTCP sockmap support"
series [1] (patch 5). Matthieu suggested converting it to a fix and sending
it directly to netdev. Removing the redundant tcp_rate_check_app_limited()
call benefits my subsequent MPTCP work: in patch 3 of that series, I
implement an MPTCP-specific mptcp_rate_check_app_limited() function and 
call it in mptcp_sendmsg_locked(). This allows me to reuse tcp_bpf_push()
by simply replacing tcp_sendmsg_locked() with

                sk->sk_socket->ops->sendmsg_locked(),

without carrying protocol-specific assumptions.

v4:
 - update the commit log as bot+bpf-ci suggested, cite ebf2e8860eea to
   clarify the inline history.

v3:
 - send this patch separately to bpf as Jakub suggested.
 - update the commit log as bot+bpf-ci suggested.
 - https://patchwork.kernel.org/project/netdevbpf/patch/85d9a0f138fa024354edde023a05f9d07b6ac87a.1789633546.git.tanggeliang@kylinos.cn/

v2:
 - drop the "Fixes" tags and update the prefixes and commit logs as Jiayuan
   suggested.
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789469930.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/netdevbpf/cover/cover.1789368148.git.tanggeliang@kylinos.cn/

[1]
MPTCP sockmap support
https://lore.kernel.org/mptcp/b5f9e8d7-b738-1df6-3b5e-1d54cbbc663c@gmail.com/T/#t
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

