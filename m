Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599679;
	b=s8i3c3tnHq9K5PZNBBuQpuBB6l3KHVYzpGbxSlRI27lTJyvqSYTdcEhvUmHb24F6qdtj
	 CPIwDwMfM5aiQ3VFZhFBm9vGGECY4Pk8v4Hp0vHZdzHuQd4ZAAo0kkEJ9m1zrfvstNwg7
	 YMa0Trf/BPdDCe2MLyh4SzgcYXfE6KRUuuIrdg//85QrckuUGNxtqIEzP6Voi0uc2SfUu
	 VlKhpjhuVGHi2F89RsXuJEh5M2dnYJuiyAhgWu+JmNmEK5X9UA42G6oslqfuF43i8D76H
	 wjpvxw7kgXFcwsSlMRHrH6BYm90MXl5I2M0YId9LRyikDpSreGJwS1XJXqoc3L+TG4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599679;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nFe1PGT6ukee0cBJfsvGhcbVJsJj6oLkbRhi/oNKO4s=;
	b=XJoJKEwqiuSrqO2c7HnaAmwUTHL8mrUYWg4sAa0HyBE5xyaN2H6HwAl5BYI0zCzni+bs
	 thj/EIvRJ3m0znPlmW9yGuXsNKmWrPvFaAymyfpX01eE4gh5COx4V8ZtOMXBnn/+K+MEP
	 ayS78By5jDf9d/wX3H2EHY1H8OitRXXcLTyWZ9+M1Hqn82MZJ1IkR4Di5gffaDabk/bwN
	 VWkmUmwHfR4bikvkHMQ/RYpjPlzP2g8dTYSpDcXOSlJZvSGJFkL9QVbdB87WxvJDmR+bG
	 xL1rKWz9UOi+2oYMUVXa711qx/hws/4B00mSgHEQZCZxPDdViQNAuq0z8XttcUNhavA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdmiajsA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59360A2637
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdmiajsA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F7D1F000C5;
	Fri, 13 Nov 2026 19:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599679;
	bh=nFe1PGT6ukee0cBJfsvGhcbVJsJj6oLkbRhi/oNKO4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VdmiajsAnL4jegSePo6folfVlmJuhgVQ9CVER+cirNvo9wfrkarJyTgbOAwJmHSfE
	 w6gvg9kNa1Uyv/cU0wAN2cIcjvOn3r2XXp91gAGAJ35m9Lmt/6/kj++KXBT8xaMD9A
	 5MHQk4SKZCCelTyzJgWF4w9gtXnr/Foa26GXu3T6bKPK83kDJnvNLJWm+jghyF2EJa
	 Kd/mh6jQQwQDtR+urB7ZzRAC5Gs38qIUrOOQOhqkjVfOENCSXaoy0W+LHS0WNJmHLA
	 1JsYZp+nuyMVFuDLlbSbrh1J1gv/LMrtLQ46LCK9/1Tzv1QdTapAzR16WxXJiGaD46
	 /0Y9tbLS02q5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:52 +0100
Subject: [PATCH mptcp-net 14/34] mptcp: pm: don't let listeners pin their
 netns
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-14-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4426; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oyysGJijFxAIXfPqLYBBeCBP27Lj2NpPOu7LdS8gkk0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z91eec/rTJeq7MmPS53nSvI0Frlt0A14PPWf8+Ioy
 yu3wmwed5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykKJ/hf6SV+8arnOUHbe88
 ZZFbc3KWZZfl2YoZd6Ntnwp7TO+c/Y2R4a78g8OzYi1eK5xK4Zr0+JeAfKZR5IMgbrNTidMc3ov
 68gIA
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
index 14e4557c3a9c..d23da4ac1968 100644
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
@@ -1865,8 +1886,10 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
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

