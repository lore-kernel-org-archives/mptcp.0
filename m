Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C431D51E44D;
	Fri, 18 Sep 2026 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756731; cv=none; b=NJCj11vcF1DE1QX6ri7LL2pJQ9QJXpSIU0gKb1jE35MwLbPTweuAo1lhiojIOuQAv6TG7gg+J5axBJZCtTGUAzKZlbMJsWu5ne08EP90Kd3DV+I7OLgL227GIlFEQ52/U+N6okgCmYNcYDg+CEbI6XoCxgb2i37ajI/r10zvbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756731; c=relaxed/simple;
	bh=9fFB322ofigbhZ4AsHIL6Rjd777i8DmaY1KKlXdI0h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFNXh88NWp9okJ3uB5J+4pzyeYjPkEsHZqEgi0KdVy1ZUrf2cAH9OPH3ZYL9e5NTog9/jrvkVvvhhRt7qaIdjLminE3hW3LF76IDtW83q/bmUb0Rans7kteDe7DXeBy/cx3WiyBqMBzGjiV0MqPZsAkE41xGc78lVunyev/S2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhZxrER2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhZxrER2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F5D1F00898;
	Fri, 18 Sep 2026 18:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756720;
	bh=HYDkWofAVJqwkkU1bY6hCgIZKtFJ2cyzVvCbMtn/XgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WhZxrER2DvffppFwB5uP833/hiFEOC+Q5+20QlkGqkWNREoFWA7WQnmXVd+JoUBjh
	 QOdENaTZ9rwlIYUYf2gJlD95VGPnQSzCWnT5ogqV6NrVKi/EjakXj/dj/QgumOQLEY
	 K3+vdnYhQ6zKjKWU/d6scEkjKHunCEj05QZIhaCTOKK6Ts0Zfsar3TAKflppNJFGVg
	 sbaQjZqSpsfFxrNLlbQ0FTI9v5nohoj34I03RIl2hUclqp9FLv3t1PcQ3VEQgFYIzN
	 QC594049JRt3Wo2cYs7goSW+0hkK1CT5m0gwjM9hJvxk92rgithw1KFtmubBb64ZWE
	 nPM2tNXd1pUxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Sep 2026 20:38:25 +0200
Subject: [PATCH net-next 1/4] mptcp: support MSG_ERRQUEUE on the parent
 socket
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-net-next-mptcp-msg_errqueue-v1-1-dd77e1738248@kernel.org>
References: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
In-Reply-To: <20260918-net-next-mptcp-msg_errqueue-v1-0-dd77e1738248@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 David Carlier <devnexen@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6DCezqlDoG5LBUOfMLMJZ1aRCH4iRGtce+o1bVRCW28=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLWtmowMl+5LNmx4/HegP+5gUV/FC/Jz/GbviFfljfVj
 GOLdVV7RykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERyQxn+O7xSs0yYInWTtzVL
 Nv+J7/e0lAsnQnlWnmn/+OLQatl3OxgZJlR4TRZnPdyZd+aUFXfertA5lQlHmRd42U/VLmzffXg
 jPwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: David Carlier <devnexen@gmail.com>

Splice pending err skbs from each subflow's error queue onto the parent
msk's error queue at error-report time, so poll() and recvmsg(MSG_ERRQUEUE)
on the parent socket observe TX timestamps through the standard inet ABI.

The splice filters by SO_EE_ORIGIN: TIMESTAMPING events forward to the
parent because they are tied to user-handed data, not to a specific
path; subflow-level ICMP errors are dropped because the legacy RECVERR
ABI cannot meaningfully convey their per-subflow peer identity to
single-path-aware userspace. Such events will be carried by a future
MPTCP_RECERR channel.

Forwarded events all go through sock_queue_err_skb(), which re-homes
skb->sk onto the parent and charges sk_rmem_alloc, so the parent's error
queue stays bounded by sk_rcvbuf and is dropped under rmem pressure
(sk_rmem_alloc + truesize >= sk_rcvbuf), matching tcp's sk_rcvbuf-gated
tx-timestamp path and ip_icmp_error() / ipv6_icmp_error(). The
MSG_ERRQUEUE branch of mptcp_recvmsg() forwards to inet_recv_error()
directly, and poll() advertises EPOLLERR purely on the parent's sk_err /
sk_error_queue, matching tcp_poll().

Signed-off-by: David Carlier <devnexen@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 55 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e89a69ab927c..15ae270ee6fd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <linux/errqueue.h>
 #include <net/aligned_data.h>
 #include <net/rps.h>
 #include <net/sock.h>
@@ -919,21 +920,52 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+static bool mptcp_errqueue_skb_forwardable(const struct sk_buff *skb)
+{
+	/* Subflow-level ICMP errors are dropped: the legacy RECVERR ABI
+	 * cannot convey their per-subflow peer identity.
+	 */
+	return SKB_EXT_ERR(skb)->ee.ee_origin == SO_EE_ORIGIN_TIMESTAMPING;
+}
+
+static bool __mptcp_subflow_splice_errqueue(struct sock *sk, struct sock *ssk)
+{
+	struct sk_buff *skb;
+	bool moved = false;
+
+	while ((skb = skb_dequeue(&ssk->sk_error_queue))) {
+		/* sock_queue_err_skb() re-homes skb->sk onto the parent and
+		 * charges sk_rmem_alloc, bounding the queue by sk_rcvbuf.
+		 */
+		if (!mptcp_errqueue_skb_forwardable(skb) ||
+		    sock_queue_err_skb(sk, skb)) {
+			kfree_skb(skb);
+			continue;
+		}
+		moved = true;
+	}
+
+	return moved;
+}
+
 static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 {
+	bool propagated = false;
 	int ssk_state;
+	bool report;
 	int err;
 
+	report = __mptcp_subflow_splice_errqueue(sk, ssk);
+
 	/* only propagate errors on fallen-back sockets or
 	 * on MPC connect
 	 */
 	if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(mptcp_sk(sk)))
-		return false;
+		goto out;
 
 	err = sock_error(ssk);
 	if (!err)
-		return false;
-
+		goto out;
 	/* We need to propagate only transition to CLOSE state.
 	 * Orphaned socket will see such state change via
 	 * subflow_sched_work_if_closed() and that path will properly
@@ -943,11 +975,16 @@ static bool __mptcp_subflow_error_report(struct sock *sk, struct sock *ssk)
 	if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
 		mptcp_set_state(sk, ssk_state);
 	WRITE_ONCE(sk->sk_err, -err);
+	report = true;
+	propagated = true;
 
-	/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-	smp_wmb();
-	sk_error_report(sk);
-	return true;
+out:
+	if (report) {
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+	}
+	return propagated;
 }
 
 void __mptcp_error_report(struct sock *sk)
@@ -2385,7 +2422,6 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	int target;
 	long timeo;
 
-	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
 
@@ -4523,7 +4559,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	/* This barrier is coupled with smp_wmb() in __mptcp_error_report() */
 	smp_rmb();
-	if (READ_ONCE(sk->sk_err))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;

-- 
2.55.0

