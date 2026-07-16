Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29102DAFA9
	for <mptcp@lists.linux.dev>; Thu, 16 Jul 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188290; cv=none; b=grLGn64dXluZ6ggCw98iwcDYS+DiP3Ah+3BAIs0a7cOc5Jsh+k9oUCJu62cZgrf40dxJQo6gyuYdLkMDiXDLzTpDVIpzrHiDdZh0//d0MiMKZe1HxRAP14iDNweBMBMkqAxt/1DDHogbVN8UEZH34OoweJFq46M5wvOp8h9/nlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188290; c=relaxed/simple;
	bh=jME7UwAhFGdpy0DC+LD1XLRwwMwYlVOX++7xseGcuGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8qv0EGbkW8oNuJDdXVgoidF/t6gay2nnsCoi0vSFHsyScOzVvmUT9MJsb8DTahtC1G/OEUQbTIx5lPnaQeYtZgFB/2AmTDrpU/GjSA88mSRiCOhPu+Tuy4Y6GS27xTKQV3306fBBSRyrIjPg0AgeOoDVM/C8IFIKy0TnIpLdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6zFIZUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6zFIZUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95461F00A3D;
	Thu, 16 Jul 2026 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784188288;
	bh=EYeyAMGYwgrEvRqPliDbY8/sG7cAJUpla97WO7oBIDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6zFIZUhJzolP0YruYg7I6UbTO9VfTl1xNNaOgP/5FeDN1LmlzXJwnUO6SN/TVccg
	 3WSNLJfgQ8gGRjODzphS83mQC2rPpXt/kopBVZrN01prKwyz+mz4JPTByF7bSd1ev7
	 WyXsortBCIiy/cgPVDzJpRxwwqr9Pv+U2OaXIqX6FuL6sNecOIntOU5TZZQUUWqxkQ
	 bY9KD8DJ+7SkSjk7y6qamergGiZpyZdnxms5H73CEWOzVv7zpo9GlRtoh697UxUhx6
	 0XW54H2ao50QbUVyoMCEagijqYEkk9MSNGEFLPqMnF1dwC6TYPZNY/nqxVKxUuzdMR
	 qDdoghKxNFQ8g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 02/10] mptcp: use local variable tp in sendmsg_frag
Date: Thu, 16 Jul 2026 15:50:41 +0800
Message-ID: <0ce0387fd4af494a5edd63730f8f1323da560ee9.1784188064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1784188064.git.tanggeliang@kylinos.cn>
References: <cover.1784188064.git.tanggeliang@kylinos.cn>
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

