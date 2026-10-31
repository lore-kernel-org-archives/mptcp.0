Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486694;
	b=DSi6Po9dtSZ0ijy4lQPyEKqPZK0xKyL9De1a/i/28pvT6lk654Ny64xxXlwoTaLaQ5L3
	 Zik6Vj4VT6FcUg+AHVhr8ENMULlRQko6uJTpzQnvnL7GgbCsSZFXUxC0jkeHimfVH6z+w
	 7y331n2lrUg+ATecSyPA4YEQPpOklTD+uRVPLp03FZbPPFymJjuaWlM2F7Ra6T+sZPtMq
	 a+8BMFdPuWjgvbzayEK0lvIMerZxBJURC4PDmtwKjHRqU+vwNot69T5DNBLNT386kRwcI
	 kRsg4LPBaCInfKp5zJPIxhaXiHLcNYds4W+kVyO/kEhER+rFLekQUVbU4HCNMLXNoMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486694;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gkmLSQSFtv4tVo++I83+bIAIRTxcu5sERX3HH9RosCY=;
	b=YIE027s0HVcANeduFKNypGgbKJxkK+sfadbjXQ4x3P6l3BL0a572ouKcfEya4vLWPaim
	 Kwo0A3Ufu/CT4el/ATU2KHTt5KbZgzFeoyc+8bstZfFUlw05ZI/Af5zKre0mzsuYycMp9
	 u7JksgALVfXPXVYOc10B/HrNoCvrmvsCxF+iimAH2XuhrG4xHvA0lnSjMYcooBaZQdaD6
	 hUTtlXbbkNiKFxmMj9SvhxevJ3BZPFoqBbWUcpmFteoUSvlDiu9Qn3H9s0TfLzGcQItc/
	 RfQxirtIOmrYTLQCgI5vMBDTMl9LdJj8+i8Ca/lvn5cRZpAnedmCrbZzjkSG436lvNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPboL+m8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D423606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPboL+m8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD381F00919;
	Sat, 31 Oct 2026 22:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486694;
	bh=gkmLSQSFtv4tVo++I83+bIAIRTxcu5sERX3HH9RosCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RPboL+m86KRM3XUT9I1OvhF+3Eioi5dKi6fN6fNwCztIBsdyTVP5+Lw3+K+0EEtm+
	 48B5eikiuScIoOw0dn5+DINiEp9PJvBfL3FHrOSWewuSmbPeetkRyaPtZxEWv9WwXA
	 Wk1YK9bYLjxV+6+llGC+Bd11z/ptytc92A6YfVhK3gmSsWi3nXp3jg1kr1O46ABpvr
	 iMoBWeH+lDHYCnH1lZLDiU9uywZjjOlT4GHtnqhOKqkVNLWfmYKZ9xdGwr6K0miG+A
	 iZ+dL3u7AHcwhPKwJC9oFZF+ojZl0pT4t3uhUWQ/tsWmn6lhxSgqmqdDEohjOi1NR/
	 JTEQ3R+9mLZzg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 31 Oct 2026 23:44:36 +0100
Subject: [PATCH mptcp-next v2 4/8] mptcp: sched: look for an idle subflow
 on each DATA_ACK
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
Message-Id: <20261031-mptcp-sched-opp-retrans-v2-4-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Abdul Wasey <w453y.me@gmail.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4611; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OsCOHoeDtDtpQmXvJ5g4TdLqv99XsnoE0atEHOeJLV4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKe5ce5rVgm1DPpdKVt54u5C1fphaQ17z2REGaimXnjg
 D6r4eKKjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImolDD8U4p89jJ3QtielvdW
 PWUHeu59V2AKnTf1eoX/Rc3ypnf3djAyTJI7W3JkzYb4pFyuyKeb62tqZqndTdfbfXhyYIzqJP1
 ZzAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Abdul Wasey <w453y.me@gmail.com>

The reinjection added by the previous patch runs in the worker, which
takes the msk socket lock and delays the receive path. Only wake it when
it can do something: when a DATA_ACK leaves nothing new to send, with a
subflow idle.

Checking the subflows on a DATA_ACK needs a stable subflow list, so only
while no process owns the msk. Otherwise, defer the check to the release
of the msk socket lock, as MPTCP_CLEAN_UNA does. Waking the worker
instead would do it for most DATA_ACKs, even with only one subflow, and
often before a subflow is idle.

Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  1 +
 net/mptcp/protocol.c | 11 +++++++++++
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 17 +++++++++++++++++
 4 files changed, 32 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b0e8b1200cfe..626a1e2fc4de 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1161,6 +1161,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
 		__mptcp_data_acked(sk);
 	}
 	msk->last_ack_recv = tcp_jiffies32;
+	__mptcp_check_oppr(sk);
 	mptcp_data_unlock(sk);
 
 	trace_ack_update_msk(mp_opt->data_ack,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7117786e5251..800c2a4ae3a0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4057,6 +4057,15 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 }
 
+/* the subflow list is only stable while no process owns the msk */
+void __mptcp_check_oppr(struct sock *sk)
+{
+	if (!sock_owned_by_user(sk))
+		mptcp_sched_oppr_check(sk);
+	else
+		__set_bit(MPTCP_OPPR_CHECK, &mptcp_sk(sk)->cb_flags);
+}
+
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
 				      BIT(MPTCP_RETRANSMIT) | \
 				      BIT(MPTCP_FLUSH_JOIN_LIST))
@@ -4121,6 +4130,8 @@ static void mptcp_release_cb(struct sock *sk)
 			__mptcp_error_report(sk);
 		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
 			__mptcp_sync_sndbuf(sk);
+		if (__test_and_clear_bit(MPTCP_OPPR_CHECK, &msk->cb_flags))
+			mptcp_sched_oppr_check(sk);
 	}
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 39dd56d882ce..32985f74ce35 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -127,6 +127,7 @@
 #define MPTCP_FLUSH_JOIN_LIST	5
 #define MPTCP_SYNC_STATE	6
 #define MPTCP_SYNC_SNDBUF	7
+#define MPTCP_OPPR_CHECK	8
 
 struct mptcp_skb_cb {
 	u64 map_seq;
@@ -930,6 +931,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
+void mptcp_sched_oppr_check(struct sock *sk);
 bool mptcp_sched_oppr_get(struct mptcp_sock *msk,
 			  struct mptcp_sched_oppr *oppr);
 
@@ -1053,6 +1055,7 @@ static inline u64 mptcp_expand_seq(u64 old_seq, u64 cur_seq, bool use_64bit)
 }
 void __mptcp_check_push(struct sock *sk, struct sock *ssk);
 void __mptcp_data_acked(struct sock *sk);
+void __mptcp_check_oppr(struct sock *sk);
 void __mptcp_error_report(struct sock *sk);
 bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq, bool use_64bit);
 static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index da5fa8c0fb12..087b36381e7a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -341,6 +341,23 @@ static u8 mptcp_sched_oppr_reason(struct sock *sk)
 	return MPTCP_SCHED_RETRANS_IDLE_APP;
 }
 
+/* called on each DATA_ACK, or when the msk socket lock is released if a process
+ * owned it: see __mptcp_check_oppr(). Under the msk data lock, with a stable
+ * subflow list. The worker takes the msk socket lock, which delays the receive
+ * path, so wake it only when the scheduler may reinject: if a subflow is idle.
+ */
+void mptcp_sched_oppr_check(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	if (!mptcp_sched_has_reinject(msk) || !mptcp_sched_oppr_reason(sk) ||
+	    !mptcp_sched_oppr_idle_ssk(msk))
+		return;
+
+	if (!test_and_set_bit(MPTCP_WORK_OPPR, &msk->flags))
+		mptcp_schedule_work(sk);
+}
+
 /* Add what @skb holds to @r, sorted by start. When @r is full, keep the lowest
  * ones: the data at snd_una is the one the peer is waiting for.
  */

-- 
2.55.0

