Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39C32ED25
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354470; cv=none; b=XpNz/7aG51JgdcaKjIAnC1iCnAjXE+wbj9nZAn2YORQmMH/s/ylXNplxfhi58yHEqCOEdbBL6Y2itQB5ykF6ItfKxE44tQP2pd4I1WOw7RZfVihwd1nSqyTbCJoaZQfl+pNKoprddE87SC2v/WSqL59K3F+U/hL4zfRboSp5Dik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354470; c=relaxed/simple;
	bh=aCUm6VqVUC62lk8pNgkytmmTZ0tTkG/+Nz/sqRoIaMg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=u9bzYm4+/YKV+WAYrja/rkvO0BPMtNLV60c08l1F+j124AGNI1sLmk2H+cuhowFsvl9IqYti56d/abHKaPrkOMHFNcG+j1SKmrmnt/xTS3tt34Qf5JOvUjpfjdlqhnoXveRIHD8Dy5Wv1TcC4M8aRIUQrJPIi0ysf1ljMmkT31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbnMx/19; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbnMx/19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762354467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYR5n8lkUKogYgHCMBt8QG/B9JRTJKJtFQu0H6TxQg0=;
	b=TbnMx/19+O9rlOmNrRpXeh6gv1MVNlxZqetbjbQCwtJeTFeblgabc2RfS+zAQi1+k6/DO1
	q90pMs0MGTUE8RMs9T3T71xvS4/evny7Au549HoSQC3zJj2bJQQssCfLsrD2/ckrV0XnQj
	NP9rsrlXpVt8/dxUVWzwAazeSwhjkoY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-CmIkfuBvMqO9rBoXNvM8oQ-1; Wed,
 05 Nov 2025 09:54:25 -0500
X-MC-Unique: CmIkfuBvMqO9rBoXNvM8oQ-1
X-Mimecast-MFC-AGG-ID: CmIkfuBvMqO9rBoXNvM8oQ_1762354464
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F89F1956071
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:54:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.34.105])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E72E3000198
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 14:54:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 2/2] mptcp: fix duplicate reset on fastclose
Date: Wed,  5 Nov 2025 15:54:12 +0100
Message-ID: <0395b95bc89964254ad9a10a9e6da9fd58b6f7a7.1762354419.git.pabeni@redhat.com>
In-Reply-To: <962efc0fd760155328967f4023a899e520e6f9a7.1762354419.git.pabeni@redhat.com>
References: <962efc0fd760155328967f4023a899e520e6f9a7.1762354419.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMPDB1CYeZZJNzh2U8rydwvAta3L5cE1UaBmb9ZIaxI_1762354464
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The CI reports sporadic failures of the fastclose self-tests. The root
cause is a duplicate reset, not carrying the relevant MPTCP option.
In the failing scenario the bad reset is received by the peer before
the fastclose one, preventing the reception of the latter.

Indeed there is window of opportunity at fastclose time for the following
race:

mptcp_do_fastclose
  __mptcp_close_ssk
    __tcp_close()
      tcp_set_state() [1]
      tcp_send_active_reset() [2]

After [1] the stack will send reset to in-flight data reaching the now
closed port. Such reset may race with [2].

Address the issue explicitly sending a single reset on fastclose before
explicitly moving the subflow to close status.

Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios");
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/596
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c                          | 34 ++++++++++++-------
 .../testing/selftests/net/mptcp/mptcp_join.sh |  2 --
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7c66300c9fe1..200d8040cf12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2451,20 +2451,13 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 
-	if ((flags & MPTCP_CF_FASTCLOSE) && !__mptcp_check_fallback(msk)) {
-		/* be sure to force the tcp_close path
-		 * to generate the egress reset
-		 */
-		ssk->sk_lingertime = 0;
-		sock_set_flag(ssk, SOCK_LINGER);
-		subflow->send_fastclose = 1;
-	}
+	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
+		tcp_set_state(ssk, TCP_CLOSE);
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, flags);
 		release_sock(ssk);
-
 		goto out;
 	}
 
@@ -2762,9 +2755,26 @@ static void mptcp_do_fastclose(struct sock *sk)
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
 	mptcp_set_state(sk, TCP_CLOSE);
-	mptcp_for_each_subflow_safe(msk, subflow, tmp)
-		__mptcp_close_ssk(sk, mptcp_subflow_tcp_sock(subflow),
-				  subflow, MPTCP_CF_FASTCLOSE);
+
+	/* Explicitly send the fastclose reset as need */
+	if (__mptcp_check_fallback(msk))
+		return;
+
+	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(ssk);
+
+		/* Some subflow socket states don't allow/need a reset.*/
+		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE))
+			goto unlock;
+
+		subflow->send_fastclose = 1;
+		tcp_send_active_reset(ssk, ssk->sk_allocation,
+				      SK_RST_REASON_TCP_ABORT_ON_CLOSE);
+unlock:
+		release_sock(ssk);
+	}
 }
 
 static void mptcp_worker(struct work_struct *work)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4faf58fecc94..663ea9ece31d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3646,7 +3646,6 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3655,7 +3654,6 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		join_rst_nr=1 \
-- 
2.51.0

