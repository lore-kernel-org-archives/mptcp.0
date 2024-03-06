Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D3DDA5
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693740; cv=none; b=EU+DaLaI3sTp54oq8ToSCPXiEJLMw2iXN8KJzxu0yejPx4gh/hcb9RCc1natfHOgfZlD2HJAcHsTaJZUAsPBu5/EvMfhP92JUFn4FkN8mHXBJsU2M1NYZl3KDm5uSLbpF7hf5+D7De8obDZfnwwx9ToRXGEob9WwX/HTms3DMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693740; c=relaxed/simple;
	bh=erewwXX/wc64vP41reoaW7Z+H31HaYmwJVYqTpwyPUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gZ1w0IqsKSkLXFjBod2iLIlMFmj6VF8OlSB4ggHuaPIO+fhd9slW4yMBJtKe+hNvp1E586jkrKeaA+krwgWWZxS6oOLs6COzRliz+/P7SUtyyqLSI4vRzeRDzChcHm+0SMkNxX33kiPIzovy397iFfK16nvzgmfOcPpA79Kvm+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey4HKAeC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey4HKAeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49685C433F1;
	Wed,  6 Mar 2024 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709693739;
	bh=erewwXX/wc64vP41reoaW7Z+H31HaYmwJVYqTpwyPUc=;
	h=From:To:Cc:Subject:Date:From;
	b=Ey4HKAeCtiIQTj0wn+vjZl/D3F4lZ5u/EfM9q/TWk+gWLKgTTYrX07JWWCQyrZAZI
	 c7+OA2XssaYwFz5z0TbzCFrZlaOpNUAasRvRbOmYOVCwxo8amaYp9fBXxjdDJDHC+f
	 MqjcOFhDzDE/wXZ42sUzUOFJxbcmlqqT0UgyTmz3jgX9SOSbl4O6akVu+lbHrr4TLr
	 lw5YKmVIpRVf7r9k79OzJM7VJXp5QNc6oD8VDu0+5WBwEdNw4A2eSh9pcLdcMga7Vs
	 BxLzpvy7SftWCMda/uwn1fG3awr/jj6aCSa2r4SuPwMe2/0bv/0hsVM4QvAzO2vbJD
	 NEamIJ3CNperQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH RFC] mptcp: react scheduler when subflow events pop up
Date: Wed,  6 Mar 2024 10:55:33 +0800
Message-Id: <433320c3a9db77bea53a34fc9c43a3c7e3320399.1709693691.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The current packet scheduler will not react by queuing more packets if
some subflows only events are emitted, e.g. new TCP ACKs are received
only acking things at TCP-level but not at MPTCP level. The scheduler
should be called when such events happen.

ack_update_msk() is invoked when an ACK is received, so it's the right
place to call the scheduler by invoking __mptcp_check_push().

mptcp_subflow_timeout() is implemented to call the scheduler when a
subflow timeout happens. But I'm not sure where is the right place to
invoke it. I mean where is the right place when a RTO is fired. So I
temporarily do it in mptcp_worker().

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/343
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tcp.h    |  3 +++
 net/ipv4/tcp_timer.c |  6 +++---
 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 23 ++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 5 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6ae35199d3b3..431a23a8ebfa 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -347,6 +347,9 @@ void tcp_release_cb(struct sock *sk);
 void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
+bool retransmits_timed_out(struct sock *sk,
+			   unsigned int boundary,
+			   unsigned int timeout);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
 enum skb_drop_reason tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb);
 void tcp_rcv_established(struct sock *sk, struct sk_buff *skb);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index d1ad20ce1c8c..cfedafc4ca36 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -212,9 +212,9 @@ static unsigned int tcp_model_timeout(struct sock *sk,
  * after "boundary" unsuccessful, exponentially backed-off
  * retransmissions with an initial RTO of TCP_RTO_MIN.
  */
-static bool retransmits_timed_out(struct sock *sk,
-				  unsigned int boundary,
-				  unsigned int timeout)
+bool retransmits_timed_out(struct sock *sk,
+			   unsigned int boundary,
+			   unsigned int timeout)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int start_ts, delta;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5926955625cf..4b091d3bce00 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1069,6 +1069,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_snd_una_update(msk, new_snd_una);
 		__mptcp_data_acked(sk);
 	}
+	__mptcp_check_push(sk, ssk);
 	mptcp_data_unlock(sk);
 
 	trace_ack_update_msk(mp_opt->data_ack,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdf9ec67795e..c935f6a7adb0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -486,6 +486,26 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
+static void __mptcp_subflow_timeout(struct sock *sk, struct sock *ssk, long tout)
+{
+	unsigned int boundary = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_retries1) + 1;
+
+	if (retransmits_timed_out(ssk, boundary, tout))
+		__mptcp_check_push(sk, ssk);
+}
+
+static void mptcp_subflow_timeout(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		long tout = mptcp_timeout_from_subflow(subflow);
+
+		__mptcp_subflow_timeout(sk, ssk, tout);
+	}
+}
+
 void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
@@ -1624,7 +1644,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
+void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -2741,6 +2761,7 @@ static void mptcp_worker(struct work_struct *work)
 	mptcp_check_fastclose(msk);
 
 	mptcp_pm_nl_work(msk);
+	mptcp_subflow_timeout(sk);
 
 	mptcp_check_send_data_fin(sk);
 	mptcp_check_data_fin_ack(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7905783c95e4..f4b75be49690 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -656,6 +656,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
+void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 u64 mptcp_wnd_end(const struct mptcp_sock *msk);
 void mptcp_set_timeout(struct sock *sk);
-- 
2.40.1

