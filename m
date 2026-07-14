Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357E5360EE8
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993281; cv=none; b=pgc+SPJdqp9w4OmE/wNofKr3HUDhdSpDgtKhOpe9LEWkAKbtIIcqqEc275SG4MzXfiXuhWkXCiFKSZL3NSa6YdPD/tnrB+lhdbXNQS57IZf85eOxHsXuhueQlvfMEhcH0QY1LtOY/pDDvO3eUywYik7UtQPu85VHWPRCHejT0Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993281; c=relaxed/simple;
	bh=jME7UwAhFGdpy0DC+LD1XLRwwMwYlVOX++7xseGcuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTQHE82lN5WDGoSnWLEqW5bmuA27nTJK7rgU4hxnBRGhN+FUQCZCV1+kUCq7OK9l56GA5gT0NVrXQ3d2cuRdm+FSPbLF7XCJEli4IuyR7X8A2zUSfT5hZy6biA6gO1/bfo9y4N2wozv9VfM4/naGvmTt7UhiyHSMW9RLNrlh42g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CsutLHcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CsutLHcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EACF1F00A3A;
	Tue, 14 Jul 2026 01:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993280;
	bh=EYeyAMGYwgrEvRqPliDbY8/sG7cAJUpla97WO7oBIDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsutLHcCRzlKNKj2DViWlid+pKZ5GBDxj6MKQlnzbJ/67UmuChIsHNZ4fC9Ia140L
	 /vOZE4HbnKAVRAOfOK3265WJCwPy/MOT2Dxaem4aLRbL+FJLmBcKInrBp0QN8Uph0K
	 xfRSOv4B11wLQ3ya2ZCAsK6+uPBzwY/BLd82cxd4Nm1Zig8/ntSz4TiQnvK0cyLHn8
	 Va6BOSpCvenuCs1FkRXlUnhjKzNXtFoE59BNoXJMgOiI3ccbL/YwK9/nUj0zTWYGcV
	 L7HSZ4tABatpI0wX5okpWwqrLUWpegBO7KlD0G1jG/habGNLS0Zf2NYjZZHvxZSnPs
	 pxFvYKpGieBzw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v4 1/7] mptcp: use local variable tp in sendmsg_frag
Date: Tue, 14 Jul 2026 09:40:56 +0800
Message-ID: <e7f83ae2dfea26db0766ec66648fe33517d89459.1783992745.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783992745.git.tanggeliang@kylinos.cn>
References: <cover.1783992745.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_sendmsg_frag(), tcp_sk(ssk) is called multiple times.
Introduce a local variable 'tp' to hold the tcp_sock pointer and
use it throughout the function. This avoids repeated dereferencing
and improves code readability, with no functional change.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ffcf5a1788f6..1cab07b1b9b1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1375,6 +1375,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	u64 data_seq = dfrag->data_seq + info->sent;
 	int offset = dfrag->offset + info->sent;
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(ssk);
 	bool zero_window_probe = false;
 	struct mptcp_ext *mpext = NULL;
 	bool can_coalesce = false;
@@ -1410,14 +1411,14 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 		mpext = mptcp_get_ext(skb);
 		if (!mptcp_skb_can_collapse_to(data_seq, skb, mpext)) {
 			TCP_SKB_CB(skb)->eor = 1;
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
 		i = skb_shinfo(skb)->nr_frags;
 		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
 		if (!can_coalesce && i >= READ_ONCE(net_hotdata.sysctl_max_skb_frags)) {
-			tcp_mark_push(tcp_sk(ssk), skb);
+			tcp_mark_push(tp, skb);
 			goto alloc_skb;
 		}
 
@@ -1471,7 +1472,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	skb->truesize += copy;
 	sk_wmem_queued_add(ssk, copy);
 	sk_mem_charge(ssk, copy);
-	WRITE_ONCE(tcp_sk(ssk)->write_seq, tcp_sk(ssk)->write_seq + copy);
+	WRITE_ONCE(tp->write_seq, tp->write_seq + copy);
 	TCP_SKB_CB(skb)->end_seq += copy;
 	tcp_skb_pcount_set(skb, 0);
 
-- 
2.53.0

