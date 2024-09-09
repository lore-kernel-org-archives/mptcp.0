Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5D63A9
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844866; cv=none; b=FovryDGxmp9FgNMpYEfFbEe3WWy4QNLXMlhWn5EZ9i4B42LFkabAJXQy+wrGSe6hYu2LzUeJ6nXbKGVYzpjj/WPM42sOUG4gFhmgHpqnOkQdqysOZ32BGCCdyvqFiXz5xsi+tEr++SF6zg3nM6dB0KFYJ4RCo+hvJXvnGTgAFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844866; c=relaxed/simple;
	bh=JHk2t4eFamDeaSdHUAGNMD5kRpH1LVYc36JlEXnDWUg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=Ce8mrn5lpWuzal6Ka/R33zAVtyE9q0xTrzJt1oBoNit+RXl851thI0HyRmtVXJ0OlBFgDDtI2dNQlkwRWFI/OdE2fTW0f+LOt2SlayRW3Vk4boOmauGQkMYhY1Ld4Yi2u8mlZjria92Zz88Pzoo95TDOGjEeKD+G9g97ZqfXlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MIIOekGT; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MIIOekGT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725844860;
	bh=mpeUnVEz7Deg5NM/ra1f075Fr0f6gYh7z75ZJuvSwtQ=;
	h=From:To:Cc:Subject:Date;
	b=MIIOekGThVrm1A3jI3lwnR4EpoYv7nQ74AGh6/2TvnfNRFC6iY5n1rV+hOPKjvCur
	 prjpkeplflZPhGgMVb7PDrQVAEF9ORVPTeIaNL6GEutShBhc1rfwiClIcljHWGHFpk
	 WisD/VSSfc26Jfm7xIC62/gYvzz/VVEiQdzK0fOc=
Received: from yangang-TM1701.. ([39.156.73.13])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 3B909A35; Mon, 09 Sep 2024 09:14:57 +0800
X-QQ-mid: xmsmtpt1725844497tf0hmzms0
Message-ID: <tencent_604F30643CD92D084CEB0AA3BE951B30C009@qq.com>
X-QQ-XMAILINFO: NoLc/2Jxb1KSFsUAM+yorQF573ak5fuCiDPzwEGfNNPcrjpPtwICKKA6lrVNbV
	 jRlRPgbBJ3Vhymzcq7Tjl+7yVW1Pe0LHJ1J2ZL3zk/JRr+34FmCGd+q74Nhizugi1gO3F/SBQqgk
	 wM7yanZpw41sLD8E75FEWrlOW+SiQPI+x8ZY3GgW1CExgizDtI5psc4uCOp0jWUQIje6U8J8H0Cj
	 1j6SY/5kuSfXains0l45VMfT+fzLsbaEubR8Xa9Wz+7zgVX0KAojKGv3aLZldReIQ1op+28MtaPE
	 lq+tDR8aFLvmfaCKLq405fA8olaOXPiXC3c4+aJk/xoqp4lSn4JTQKaBYlqostF0e/QTYIdooCHL
	 MLu+HIRdHTXT4qskl4UAfCAPVHnqB9vx8FjAmD/BM3H+hQrEJoajIH/Zb9yAAhdJCsIxunDpRnmO
	 C0gEpZOCPGBEMbCqAPWbR1efP3AaMKXqJzCEgNtgIogDqnr0QONhj/cLlwCQ6BgnEHakQyFDokg9
	 su81t0/CfHQbGOLTBAhgd+wHcIhyLGTlRzYq2W8KsJ6dk4B7zPwBgFQ/Si1xMddb2Dq0bpGqOS68
	 8sv0bOsRyLWdGhR/+5DJKsH0WM+oDj2KoNix8Cb5y6S2fC3l1r9AIerRDOwaM0W7Zes+JWe+ACAE
	 LewMVJd0UBhJ5Y0ta0CQBkyDv+bjkurJIocqrCBr/a5OG31IKhfl/khEhEIsleFy+Ar6zeBTlhuN
	 WV/RalTkezhvrGYibeR0O2COf48YuwYHdJp0jB+Zm+sEuufRCgCkwJmaDrFybpXahowr5PkSdFOn
	 l6q6BpzB5NeB6tRcEUJUH7EpMZ+L+nksK0kpeov4an/0RoaNb9BNbIdNmEMhi0LodNLqWDy7nOm1
	 df1eKpt24itAkBEgDe+yY45z+JRwLEXUtURNTM+aCoOF0gMUlt+LAxW6VY4CNeDYxip19C0ml5ru
	 QaPNBpCsp7WwG9IGAMe/8CGapYw26A7IwpZPo/T6EF9y/VXABdPPUjp/mKFNLAEYJjiF8QL7zlHH
	 Mp1kt6jbgWwhr24atUG6C/yJv6niCgoqLossU6KQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: gang_yan@foxmail.com
To: mptcp@lists.linux.dev
Cc: YANGANG <yangang@kylinos.cn>
Subject: [mptcp-next] mptcp: Add data race when accessing the fully_established of subflow
Date: Mon,  9 Sep 2024 09:14:47 +0800
X-OQ-MSGID: <20240909011447.14932-1-gang_yan@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: YANGANG <yangang@kylinos.cn>

We introduce the same handling for potential data races with the
'fully_established' flag in subflow as previously done for
msk->fully_established.

Additionally, we make a crucial change:  convert the subflow's
'fully_established' from 'bit_field' to 'bool' type. This is
necessary because methods for avoiding data races don't work well
with 'bit_field'. Specifically, the 'READ_ONCE' needs to know
the size of the variable being accessed, which is not supported in
'bit_field'. Also, 'test_bit' expect the address of 'bit_field'.
 This change was prompted by compilation errors we encountered,
as detailed below.

'''
READ_ONCE:

  477 |         (sizeof(t) == sizeof(char) || \
      |		       ^
		 			sizeof(t) == sizeof(short)|| \
././include/linux/compiler_types.h:490:23:
				note: in definition of macro ‘__compiletime_assert’
  490 |                 if (!(condition))\
      |                       ^~~~~~~~~
././include/linux/compiler_types.h:510:9:
				note: in expansion of macro ‘_compiletime_assert’
  510 |         _compiletime_assert(condition, msg, \
				__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:9:
				note: in expansion of macro ‘compiletime_assert’
   36 |         compiletime_assert(__native_word(t) ||  \
				    sizeof(t) == sizeof(long long),  \
      |         ^~~~~~~~~~~~~~~~~~
./include/asm-generic/rwonce.h:36:28:
				note: in expansion of macro ‘__native_word’
   36 |         compiletime_assert(__native_word(t) || \
      |				       ^~~~~~~~~~~~~
					 sizeof(t) == sizeof(long long),  \
./include/asm-generic/rwonce.h:49:9:
				note: in expansion of macro ‘compiletime_assert_rwonce_type’
   49 |         compiletime_assert_rwonce_type(x); \
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/mptcp/protocol.h:781:39:
				note: in expansion of macro ‘READ_ONCE’
  781 |         if (subflow->request_join && \
      |					   !READ_ONCE(subflow->fully_established))
      |                                       ^~~~~~~~~

test_bit:
 error: cannot take address of bit-field 'fully_established'
   50 |         if (test_bit(1, &sf->fully_established))
      |
'''
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/516
Signed-off-by: YANGANG <yangang@kylinos.cn>
---
 net/mptcp/diag.c     | 2 +-
 net/mptcp/options.c  | 4 ++--
 net/mptcp/protocol.c | 2 +-
 net/mptcp/protocol.h | 6 +++---
 net/mptcp/subflow.c  | 6 +++---
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 2d3efb405437..02205f7994d7 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -47,7 +47,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_REM;
 	if (sf->request_bkup)
 		flags |= MPTCP_SUBFLOW_FLAG_BKUP_LOC;
-	if (sf->fully_established)
+	if (READ_ONCE(sf->fully_established))
 		flags |= MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED;
 	if (sf->conn_finished)
 		flags |= MPTCP_SUBFLOW_FLAG_CONNECTED;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 66eab2cdb702..ad22622843a2 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -461,7 +461,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
 		return false;
 
 	/* MPC/MPJ needed only on 3rd ack packet, DATA_FIN and TCP shutdown take precedence */
-	if (subflow->fully_established || snd_data_fin_enable ||
+	if (READ_ONCE(subflow->fully_established) || snd_data_fin_enable ||
 	    subflow->snd_isn != TCP_SKB_CB(skb)->seq ||
 	    sk->sk_state != TCP_ESTABLISHED)
 		return false;
@@ -930,7 +930,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	/* here we can process OoO, in-window pkts, only in-sequence 4th ack
 	 * will make the subflow fully established
 	 */
-	if (likely(subflow->fully_established)) {
+	if (likely(READ_ONCE(subflow->fully_established))) {
 		/* on passive sockets, check for 3rd ack retransmission
 		 * note that msk is always set by subflow_syn_recv_sock()
 		 * for mp_join subflows
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ef59e17d03a..1854049f4e6a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3493,7 +3493,7 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	struct tcp_sock *tp = tcp_sk(ssk);
 	unsigned long timeout;
 
-	if (mptcp_subflow_ctx(ssk)->fully_established)
+	if (READ_ONCE(mptcp_subflow_ctx(ssk)->fully_established))
 		return;
 
 	/* reschedule with a timeout above RTT, as we must look only for drop */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d25d2dac88a5..99642d343e66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -513,7 +513,6 @@ struct mptcp_subflow_context {
 		request_bkup : 1,
 		mp_capable : 1,	    /* remote is MPTCP capable */
 		mp_join : 1,	    /* remote is JOINing */
-		fully_established : 1,	    /* path validated */
 		pm_notified : 1,    /* PM hook called for established status */
 		conn_finished : 1,
 		map_valid : 1,
@@ -531,9 +530,10 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
 		close_event_done : 1,       /* has done the post-closed part */
-		__unused : 9;
+		__unused : 10;
 	bool	data_avail;
 	bool	scheduled;
+	bool    fully_established;	/* path validated */
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
@@ -778,7 +778,7 @@ static inline bool __tcp_can_send(const struct sock *ssk)
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
 {
 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
-	if (subflow->request_join && !subflow->fully_established)
+	if (subflow->request_join && !READ_ONCE(subflow->fully_established))
 		return false;
 
 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b9b14e75e8c2..dcaf807013f6 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -785,7 +785,7 @@ void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
 				       const struct mptcp_options_received *mp_opt)
 {
 	subflow_set_remote_key(msk, subflow, mp_opt);
-	subflow->fully_established = 1;
+	WRITE_ONCE(subflow->fully_established, true);
 	WRITE_ONCE(msk->fully_established, true);
 
 	if (subflow->is_mptfo)
@@ -1276,7 +1276,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !subflow->fully_established;
+		return !READ_ONCE(subflow->fully_established);
 }
 
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
@@ -2045,7 +2045,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
-		new_ctx->fully_established = 1;
+		WRITE_ONCE(new_ctx->fully_established, true);
 		new_ctx->remote_key_valid = 1;
 		new_ctx->backup = subflow_req->backup;
 		new_ctx->request_bkup = subflow_req->request_bkup;
-- 
2.43.0

