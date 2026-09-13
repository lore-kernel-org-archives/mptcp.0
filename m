Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06325232395
	for <mptcp@lists.linux.dev>; Sun, 13 Sep 2026 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789294524; cv=none; b=KECvIBcrQhPXUDVMTuP3BgKY+Ziy0vGNXt139Vb5b2awrc/RymDQ3/2ELtutQM55BlejoFV81xdb9ydtjjhz4yjMBg9M5NUuXD8uwueHzOvL9JJoy0TxwuMSZnA/551F5XOUFFjQhJGy0TRCmhP8l8vtXiMvfOFqoJQiq8SvWbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789294524; c=relaxed/simple;
	bh=lW/QuE9Zs69ZCHUMesZ2lOArc8dS09q/gw0hvX60Ry0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9TwqQG7Qp12GaXmu7Y0S7cIu4X/HPeey1eZGws87B8jcMtZLiiNFO/lrcOna9fPnob6sDROZ+BjSnlJhXSCuAMRY7ol1pzGYtrAlapemPesg2D352tqUDyRzSSzizxVMOvmxDMLqwfamCH7sc90sp7UKmejUloDa+yywWU5JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSIJQklb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSIJQklb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623941F000FF;
	Sun, 13 Sep 2026 10:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789294522;
	bh=gajEtr8iM0vx7FN0XlO4gi98FWlievrAivweiTNXO7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lSIJQklbGwEoqIQw5BaXQJb/5rCAI79oVC/pG89lgKxSda+YcQlO0ApqDYZ/or2q8
	 wE/UMzVlypgs5UKcalmECv8CjvIrgK1eZIv+ocOBeEhvy+4Qq3hbkWpsO4qxM+g3jn
	 yqz4XV6u8mfFi1TAw7wqXNO62I/WsjmnNblheAwqXhB2SoebgEChAn+y4TaccZFPiU
	 MZr0o9rGuMYwZLs4HzYJu3vrWSDoswAOFrRXUwaLMAntjU0EzHHgCJ0IOv+MHar5f0
	 2BXewgYgcLhCwcJGEFDoMkiG/2wPoyx1f9LRC88wtKWqZdSxx6nfx8KaibFb7br5jk
	 M0kqMUiAZ82Cg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 09/16] mptcp: implement read_skb for sockmap stream verdict
Date: Sun, 13 Sep 2026 18:14:48 +0800
Message-ID: <08dd128a702b7b1d7023d64aea1b94907a981ed9.1789294365.git.tanggeliang@kylinos.cn>
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

BPF sockmap's stream verdict path (sk_psock_verdict_data_ready) calls
ops->read_skb() to dequeue skbs from the socket and pass them to the
verdict BPF program. MPTCP's proto_ops (mptcp_stream_ops and
mptcp_v6_stream_ops) did not define .read_skb, causing
sk_psock_verdict_data_ready() to return early without processing any
data. This made the stream verdict redirect completely non-functional
for MPTCP sockets.

Add mptcp_read_skb() as the skb_read_actor_t callback. It peeks skbs
from the socket receive queue, unlinks each one, and passes it to the
recv_actor. Processing continues until the queue is drained or the actor
returns a negative value.

This follows the same pattern as tcp_read_skb() in net/ipv4/tcp.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3d3c5af7c266..c5be29767cb1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4801,6 +4801,31 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
+{
+	struct sk_buff *skb;
+	int copied = 0;
+
+	if (sk->sk_state == TCP_LISTEN)
+		return -ENOTCONN;
+
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
+		int used;
+
+		__skb_unlink(skb, &sk->sk_receive_queue);
+		WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
+		used = recv_actor(sk, skb);
+		if (used < 0) {
+			if (!copied)
+				copied = used;
+			break;
+		}
+		copied += used;
+	}
+
+	return copied;
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4824,6 +4849,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.sendmsg_locked	   = mptcp_sendmsg_locked,
+	.read_skb	   = mptcp_read_skb,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4937,6 +4963,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
 	.sendmsg_locked	   = mptcp_sendmsg_locked,
+	.read_skb	   = mptcp_read_skb,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

