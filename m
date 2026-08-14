Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678D322A1C
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732326; cv=none; b=ZCRFNX9Go8bODqQEQhkVWukaTZLoLjccRbbt3TqMrnrgfeLRPLCrp6xSZaIA3X07eVt37jCANmwhk5dMqXWVCyXYeI2O69fK1XXZ4WBXy/PUHBkDD1s1Isyhu80JvbArIo/66Os3titlMnNvU7lA6ZG9/Gsf4oZ9vuCC9VLvZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732326; c=relaxed/simple;
	bh=eHcdiAXGs9+1o7XW3khcWqfhRDapV7fuNK26S1uZjss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSTvanSiSqE3Buk6I2ZYpP/wYD5LsIXbR+AcR5HSs6DbcwvXDBEXJDKlkSv3olvO5uruit1UKZNryK2zd9xsDVaaeH9wc1Cb+UsMVItigGKdJNgaCTStkl/X9A3sGADdZ18uLqW59W8TnCKWjvP4gAFIm4BfU+nnRgxq1pD8v1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3gwrgTL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3gwrgTL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF251F000E9;
	Fri, 14 Aug 2026 18:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732324;
	bh=zznhxtApLS9zY8SG1MtkvBJbvevCR7lgqnjCaE5NgIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I3gwrgTL/XerSJpLE56QbmvxfiYPt5vHmK+vCyDytPexW1L9up7w6zF34tKGxQKT0
	 Z4zGx2CcPipJGtFuOdOMXG3rkPCyky3ok0+2VKXxCZ9Cmcqgr1zaHQ7repCPDgYKc3
	 fyS7dLLAOwMETvX0zs4fgw0g6xJuQYT9VorQDBNrJYrpfOO270s7V+K4SqR/kxIqPv
	 AOe3DGca9LXdVUJbiohtiqsGb8DL1WGFRj2aBj7+lOF+C72dvzNeDvHP78qBtUWCXJ
	 F4VOecIz7aG60TxTztzHawvWruufK/zTuzmWKl7ZynCvgKZtZ2TS3TwF7BTj9UjNRg
	 dDAsKvhucKAUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Aug 2026 20:31:55 +0200
Subject: [PATCH mptcp-next RFC 2/3] mptcp: reject MP_JOIN earlier
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-mptcp-reset-mpj-early-v1-2-3ca3260f9474@kernel.org>
References: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
In-Reply-To: <20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, gang.yan@linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6813; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eHcdiAXGs9+1o7XW3khcWqfhRDapV7fuNK26S1uZjss=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLq4+XVX9w933n0nuO7/8t4XK9EStis8frzY47YFJ2Jx
 zPiZCPyO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYiHcbI8Mmtd61GTUPOBPnj
 iz1XpFxZ116+tkI0KrVHWFP6O/vhw4wMk2zzJCv/v0gSeLSTJ2GRbHjl4Y/8rCF5v+vYLnBMMcl
 jAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a SYN + MP_JOIN is received, it is good to check directly if the
MP_JOIN is allowed, then checking that later at the establishment of the
new subflow.

This avoids situations where the 3WHS is done, then the joined subflow
is rejected.

This changes the behaviour, and the new behaviour is tracked with the
MPJoinDisallow MIB counter.

TODO: adapt the selftests to be able to run on older kernels: if the new
counter is not available, increment syn_ack and syn_rej instead.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c                                 |  1 +
 net/mptcp/mib.h                                 |  1 +
 net/mptcp/subflow.c                             | 19 ++++++++++++++++---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++++++--------
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..988755b41a5a 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -34,6 +34,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
 	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
 	SNMP_MIB_ITEM("MPJoinNotEstablished", MPTCP_MIB_MPJOINNOTESTABLISHED),
+	SNMP_MIB_ITEM("MPJoinDisallow", MPTCP_MIB_MPJOINDISALLOWED),
 	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
 	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
 	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1ebdb55e9534..e97ee2d952a7 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -29,6 +29,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPJOINACKNOCTX,	/* MP_RST: no subflow context on ACK */
 	MPTCP_MIB_JOINREJECTED,		/* The PM rejected the JOIN request */
 	MPTCP_MIB_MPJOINNOTESTABLISHED,	/* MP_RST: JOIN on not-fully-established msk */
+	MPTCP_MIB_MPJOINDISALLOWED,	/* RST JOIN early if disallowed: fallback/PM */
 	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..7552abf4c333 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -82,7 +82,8 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 	subflow_req->thmac = get_unaligned_be64(hmac);
 }
 
-static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
+static struct mptcp_sock *subflow_token_join_request(struct request_sock *req,
+						     u8 *reason)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct mptcp_sock *msk;
@@ -91,12 +92,22 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
 	if (!msk) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
+		*reason = MPTCP_RST_EMPTCP;
+		return NULL;
+	}
+
+	/* Stop it early if the subflow cannot be accepted */
+	if (!mptcp_can_accept_new_subflow(msk)) {
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINDISALLOWED);
+		*reason = MPTCP_RST_EPROHIBIT;
+		sock_put((struct sock *)msk);
 		return NULL;
 	}
 
 	local_id = mptcp_pm_get_local_id(msk, (struct sock_common *)req);
 	if (local_id < 0) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPJOINNOIDFOUND);
+		*reason = MPTCP_RST_EMPTCP;
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -217,17 +228,19 @@ static int subflow_check_req(struct request_sock *req,
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
 
 	} else if (opt_mp_join && listener->request_mptcp) {
+		u8 reason;
+
 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq;
 		subflow_req->mp_join = 1;
 		subflow_req->backup = mp_opt.backup;
 		subflow_req->remote_id = mp_opt.join_id;
 		subflow_req->token = mp_opt.token;
 		subflow_req->remote_nonce = mp_opt.nonce;
-		subflow_req->msk = subflow_token_join_request(req);
+		subflow_req->msk = subflow_token_join_request(req, &reason);
 
 		/* Can't fall back to TCP in this case. */
 		if (!subflow_req->msk) {
-			subflow_add_reset_reason(skb, MPTCP_RST_EMPTCP);
+			subflow_add_reset_reason(skb, reason);
 			return -EPERM;
 		}
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18ce7136a2b0..1924ff488c8d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -80,6 +80,7 @@ unset join_ack_no_mpjoin
 unset join_ack_no_ctx
 unset join_not_established
 unset join_no_id_found
+unset join_disallowed
 
 unset rst_md5sig
 unset rst_dss
@@ -1617,6 +1618,7 @@ chk_join_nr()
 	local ack_no_ctx=${join_ack_no_ctx:-0}
 	local not_established=${join_not_established:-0}
 	local no_id_found=${join_no_id_found:-0}
+	local disallowed=${join_disallowed:-0}
 	local rc=${KSFT_PASS}
 	local count
 	local with_cookie
@@ -1723,6 +1725,13 @@ chk_join_nr()
 		fail_test "got $count JOIN[s] no id found expected $no_id_found"
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed")
+	if [ -n "$count" ] && [ "$count" != "$disallowed" ]; then
+		rc=${KSFT_FAIL}
+		print_check "join disallowed"
+		fail_test "got $count JOIN[s] disallowed expected $disallowed"
+	fi
+
 	print_results "join Rx" ${rc}
 
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
@@ -2202,8 +2211,8 @@ subflows_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 1 1 0
+		join_disallowed=1 \
+			chk_join_nr 1 0 0
 	fi
 
 	# subflow
@@ -2232,8 +2241,8 @@ subflows_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 2 2 1
+		join_disallowed=1 \
+			chk_join_nr 2 1 1
 	fi
 
 	# single subflow, dev
@@ -4114,8 +4123,8 @@ userspace_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 1 1 0
+		join_disallowed=1 \
+			chk_join_nr 1 0 0
 	fi
 
 	# userspace pm type does not send join
@@ -4138,8 +4147,8 @@ userspace_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 1 1 0
+		join_disallowed=1 \
+			chk_join_nr 1 0 0
 		chk_prio_nr 0 0 0 0
 	fi
 

-- 
2.53.0

