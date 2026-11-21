Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254168;
	b=wWh+s2jfYPHgq+I40aBqsS8NUAyDg3XnHUs7d1ywhpOK8KvLc4F3ZDqCSdexx2X+T0uB
	 +pQ0DMGhdMqIdZ/cI9f0vAnnxbrG6b+Dy5wstmtNuUwWjH7HtV7OZVIC66AGHxAeAHBz9
	 +2+vvz1GrfCZ+M/oXY5223NqwxFpOqC/LYLp1aKUKMcqSm+GbxpBNbwTimOClUj67nFI6
	 Fn5KtJc8U3j/fYQkU6MeIQzMxKdqivIvNmmumvRrzLzHK/hAuK5yUlWbozvup+3diT8iP
	 +e/zOapnndhgvijm8mTshMEZoZm5U4Degk1Rv0AGg5LBes2jT/PNAgUpbjAPoCm+wSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254168;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xwjNMh6i+YF8TulJrAnkm2qhBUAl92Y56moGun4RQ+8=;
	b=LZw+nUxIKEhBKKeIVaCWeVEC7W5bpm7z2UDf3ZMDniHawRsGJRhZEY2nKmXiT/eDP8eK
	 KM9BpoBv34EmojPF77G1PKuzneqVbnYuFrsZE9de5yTkkTHDk0/MIIDr0UEp0WWXnFXug
	 7JY+qyF9zAHdMNP3YzuCiz6Iwi+gKEQCPTfztgnDt9enV396/7f7x70dB13/dAuHw4Skj
	 dbalAwNdcOqtOG3m5kG0UxyAykLmeCe+5cRWa3XuUn5cj5k9Yp8jHQNgCwVSaDJ/zOqzF
	 qPspt4UJSEa/2bNhklXectFvxfcNN5DWqrd+oMz5Ve2XrZMccUWPHUGx8TtiMNrploA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkMDxj0B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072A606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkMDxj0B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329921F000D1;
	Sat, 21 Nov 2026 09:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254167;
	bh=xwjNMh6i+YF8TulJrAnkm2qhBUAl92Y56moGun4RQ+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KkMDxj0BKcTZ5x3eob8Ud92XBVKJ4ETDoOgeEIwsVWuvvLwOVaG2u8IvpV9mZNfHC
	 kuJOgoA0VPV2++zbB4UoCjBJMC1FkT6BXI7fkqsop0YGqzO2LP8ImGAStQNwgB4ue9
	 /gTRONG6sKKT/QxMOQpCT3lJlc/D7IB3jFlE/X5YoK75pstYwuLWMrS/8HxZrHegPe
	 tEIcwbK4fI6mAJNPOy8ORWgGgPjq8/2JHvFreldj4V9yMhYk/+erGNUwxKQHrD3LIy
	 pjVV4Ljv1XxuyfEQNRtSc0TzpHyHuqjeBDWlpM/raoX4E1rW5VD8uN+IV8lBd4hU+l
	 H6BdX90IbZRgg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:31 +0100
Subject: [PATCH mptcp-net v2 33/62] mptcp: pm: don't let listeners pin
 their netns
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-mptcp-cmason-fixes-v2-33-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4426; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fbn+R/IWHgV7AsM7NBLw8bKORxWwKwmnmJDEYy+lbk8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0xM0Nm+Qeue0KciyX13Gm6n1zB9Hj62FrL1dx+7fe
 P3uwE+tjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInUMjD896wXmr26gtEnjGHN
 KcsLM++/CVY75dpR6Bnxjq9TorXMiOGf0YeK/X8/haYdfN5edSwu+gxj25RnFoFs7bOeHepmFmT
 iAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Josef Bacik <josef@toxicpanda.com>

For a "signal" endpoint with a port, the in-kernel path manager creates a
listening MPTCP socket with sock_create_kern(). This socket is released
when the endpoint is deleted or, failing that, by pm_nl_exit_net() when the
network namespace is dismantled.

The MPTCP socket itself holds no reference on the namespace. But its first
subflow is created by mptcp_subflow_create_socket(), which always calls
sk_net_refcnt_upgrade(). So the namespace cannot be dismantled before
the listener is released, and the listener is not released before the
namespace is dismantled: unless somebody deletes the endpoint, both stay
around for ever once the last process of the namespace is gone.

  unshare -Urn sh -c 'ip link set lo up;
                      ip mptcp endpoint add 127.0.0.1 port 4321 signal'

leaks a namespace, with everything it contains, each time it is run. It
remains charged to the user's max_net_namespaces limit.

Only take the reference if the MPTCP socket has one. A listening TCP
socket has no timer of its own, and request sockets of a dead namespace are
taken care of by inet_twsk_purge().

The sockets cloned from that listener for incoming MP_JOIN requests do
need the reference, for their timers, but inherit sk_net_refcnt == 0. Take
it when they are created, with __sk_net_refcnt_upgrade(), from the
previous commit, as this is done in atomic context, and drop the
connection request if the namespace is already going away.

The TCP listener of such an endpoint is now a plain kernel socket, like
the MPTCP socket it belongs to: it is not counted in "sockets: used" in
/proc/net/sockstat any more, and its destruction is not broadcast to the
listeners of the SKNLGRP_INET*_TCP_DESTROY sock_diag groups.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
the command above, run 1000 times by an unprivileged user. Without this
patch, all the network namespaces were leaked:

  result: 1000 network namespaces made, 0 taken down, 1000 are left

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ Use __sk_net_refcnt_upgrade(), from the previous commit, instead of an
  open-coded copy of sk_net_refcnt_upgrade(), with maybe_get_net() like
  rds_tcp_tune(). Shorter comments, and describe the condition: any
  kernel msk. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f9ed4cfa4b33..8163731a9366 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -849,6 +849,22 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 	WRITE_ONCE(msk->fully_established, true);
 }
 
+/* Children of a kernel listener need a netns ref for their timers */
+static bool subflow_child_get_net(struct sock *child)
+{
+	struct net *net = sock_net(child);
+
+	if (likely(child->sk_net_refcnt))
+		return true;
+
+	if (!maybe_get_net(net))
+		return false;
+
+	__sk_net_refcnt_upgrade(child, GFP_ATOMIC);
+	put_net(net);
+	return true;
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -917,6 +933,11 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 		tcp_rsk(req)->drop_req = false;
 
+		if (!subflow_child_get_net(child)) {
+			subflow_add_reset_reason(skb, MPTCP_RST_EUNSPEC);
+			goto dispose_child;
+		}
+
 		/* we need to fallback on ctx allocation failure and on pre-reqs
 		 * checking above. In the latter scenario we additionally need
 		 * to reset the context to non MPTCP status.
@@ -1868,8 +1889,10 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	/* kernel sockets do not by default acquire net ref, but TCP timer
 	 * needs it.
 	 * Update ns_tracker to current stack trace and refcounted tracker.
+	 * Not for a kernel msk, e.g. a PM listener: it would pin the netns.
 	 */
-	sk_net_refcnt_upgrade(sf->sk);
+	if (sk->sk_net_refcnt)
+		sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;

-- 
2.55.0

