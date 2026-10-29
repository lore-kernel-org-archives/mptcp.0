Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793316130;
	b=b9XbvXDGCQ+vFk2JOaztWIkRiMi6RkQhhq9kDcjVYaGEQX5scUo28tPNXqRrQv2c1NWj
	 0PMIKTUqI+XZAbNOxcL7NFQeGTrL8NmXmaNoB9UmI9yNQLDlSowmMmq4xCvOIaYLiddQs
	 Tu9CuTqPQsGxYk9qVXe90dG1uu+ElOe6046gM2s9ITT0y4Jf63JsPlcrWaOwebIKITz9l
	 xY2S//kxmPfcyh8dV+aQACbJrFP8w3V843gM0h64CCGjreNeQyCLju/0ReA850f4I4N4k
	 BIKQ4kB0MI/67FDDnTEXpElGEDZXDE3NcJFehnZzs7T2C5VNO6mJKmte92c4g2y+XzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793316130;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Z4ZV+NSCCSurkRLvonHiaYmaxd1TesYLdbcgrrI6v7Y=;
	b=pqC73YG03XPz2QJUzCycFW7pGWFlSvTAaML97DGDvlAqAojTFTVE8HiN/hGycZ4Npyo4
	 GTI/Ex8b/JE+AA4G4+mfzhobnQUicMi7Ve+eivLaHoXj8dnqIFO3FTeEhobtxveYEBJrG
	 leRBhymm3CpHoNLP7QD2GwBbM0dUskvUVyEJSNrL6W41skEQ8fgkYPnMmsmAmfFFyAavt
	 18yAfjLVUQv6mr646Yg21A4aXZjwqSJzQmqDZDTdrhnWFYNY3lyA/bmlKAkSM6uh19y1m
	 L5OrerB6gRvKr2NbwBqtLHF89/4xP/aqzFobHyqiL/kc5e+LqMmaGCzXyOEoW7Mw8bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jysUHtfg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB4D606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jysUHtfg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E791F01825;
	Thu, 29 Oct 2026 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793316129;
	bh=Z4ZV+NSCCSurkRLvonHiaYmaxd1TesYLdbcgrrI6v7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jysUHtfgxhuuUz7fkiP5s9/0e6v/ksnLVLftdD1+uYSV7TPJR5kw7N4vNRMf7Wcil
	 Y+Htrup/WD7/iOZRguTqV55VYl7y9b0ZxKtEzoP+9rXojbbQUL3tqvilgc9Xpr2VOw
	 fB8SjqMvWa91LmbzTvLhkN8RPh89fNGuxHZ5dgAZGGMiRWcKknZ4Naf2HzIYMjQLR6
	 IvzwWhWMcc9QFiDT1SKbtMRszo8cqYxAT0zlhlLwEg12Jgn8lKrqVR4uMT2XkajWgG
	 iRc1dC2dMjT4oh7e88q53vXqym1GSakfftiqMOK6jpwyBY6aI8jxMdu8vsIzZ571pB
	 nnrTdYEBpJ6QA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Oct 2026 00:21:40 +0100
Subject: [PATCH mptcp-next v2 2/5] mptcp: reject MP_JOIN earlier
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
Message-Id: <20261030-mptcp-reset-mpj-early-v2-2-90f119392263@kernel.org>
References: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
In-Reply-To: <20261030-mptcp-reset-mpj-early-v2-0-90f119392263@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Chenguang Zhao <chenguang.zhao@linux.dev>, Gang Yan <gang.yan@linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10134; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e5vjraxC74KG/sIahmmHMOXnEDBqdOyA3YFgg2ZwNfE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIeX5V07db+6fidV6roWrPn/xXX//lcSuk+t36PbfAs6
 0PNXDXnO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSx8vI8Gp74995WdOPx8zS
 V2pUF3iw+NWBZdkz9p5PSWZ8XnLb/yEjw5mO4IZC1T3L9t3N4s7U4T29LDS/Zv5HFYlFASxTgn/
 KMQMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a SYN + MP_JOIN is received, it is good to check directly if the
MP_JOIN is allowed, then checking that later at the establishment of the
new subflow.

This avoids situations where the 3WHS is done, then the joined subflow
is rejected.

This changes the behaviour, and the new behaviour is tracked with the
MPJoinDisallowed MIB counter.

Note that in the selftests, we need to support older kernels not
following this new behaviour. For that, we can check if the new counter
is present: if it is, the join rejected counter should be used instead,
and we should see more SYN+ACK. One exception for the SYN cookies case
were the reject was already done early but MPJoinRejected was used
instead.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - Explain that mptcp_can_accept_new_subflow() is racy, but OK. (Paolo)
 - support older kernels with the previous behaviour.
 - no more special case for syncookie, switch to new counter.
 - s/MPJoinDisallow/MPJoinDisallowed/ (+ ed). (Sashiko)
---
 net/mptcp/mib.c                                 |  1 +
 net/mptcp/mib.h                                 |  1 +
 net/mptcp/subflow.c                             | 31 +++++++++-----
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 55 +++++++++++++++++++------
 4 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 608cb568897c..b1710082bbca 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -34,6 +34,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinAckNoCtx", MPTCP_MIB_MPJOINACKNOCTX),
 	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
 	SNMP_MIB_ITEM("MPJoinNotEstablished", MPTCP_MIB_MPJOINNOTESTABLISHED),
+	SNMP_MIB_ITEM("MPJoinDisallowed", MPTCP_MIB_MPJOINDISALLOWED),
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
index 78e886b20258..f9785e20e209 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -117,7 +117,8 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 	subflow_req->thmac = get_unaligned_be64(hmac);
 }
 
-static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
+static struct mptcp_sock *subflow_token_join_request(struct request_sock *req,
+						     u8 *reason)
 {
 	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
 	struct mptcp_sock *msk;
@@ -126,12 +127,25 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 	msk = mptcp_token_get_sock(sock_net(req_to_sk(req)), subflow_req->token);
 	if (!msk) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINNOTOKEN);
+		*reason = MPTCP_RST_EMPTCP;
+		return NULL;
+	}
+
+	/* Stop it early if the subflow cannot be accepted.
+	 * This check is inherently racy, the consistency safeguard is given by
+	 * the fallback check at finish_join time.
+	 */
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
@@ -252,17 +266,19 @@ static int subflow_check_req(struct request_sock *req,
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
 
@@ -280,15 +296,8 @@ static int subflow_check_req(struct request_sock *req,
 
 		subflow_req_create_thmac(subflow_req);
 
-		if (unlikely(req->syncookie)) {
-			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
-				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINREJECTED);
-				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
-				return -EPERM;
-			}
-
+		if (unlikely(req->syncookie))
 			subflow_init_req_cookie_join_save(subflow_req, skb);
-		}
 
 		pr_debug("token=%u, remote_nonce=%u msk=%p\n", subflow_req->token,
 			 subflow_req->remote_nonce, subflow_req->msk);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..308fad861afc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -78,6 +78,7 @@ unset join_ack_no_mpjoin
 unset join_ack_no_ctx
 unset join_not_established
 unset join_no_id_found
+unset join_disallowed
 
 unset rst_md5sig
 unset rst_dss
@@ -1595,6 +1596,7 @@ chk_join_nr()
 	local ack_no_ctx=${join_ack_no_ctx:-0}
 	local not_established=${join_not_established:-0}
 	local no_id_found=${join_no_id_found:-0}
+	local disallowed=${join_disallowed:-0}
 	local rc=${KSFT_PASS}
 	local count
 	local with_cookie
@@ -1617,10 +1619,21 @@ chk_join_nr()
 	if [ -z "$count" ]; then
 		rc=${KSFT_SKIP}
 	elif [ "$count" != "$syn_ack_nr" ]; then
+		# support old kernels without MPTcpExtMPJoinDisallowed counter:
+		# => connections are rejected later on (MPTcpExtMPJoinRejected)
+		if [ "${disallowed}" -gt 0 ] &&
+		   ! mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed" >/dev/null; then
+			syn_rej=$((syn_rej + disallowed))
+			syn_ack_nr=$((syn_ack_nr + disallowed))
+		fi
+
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
-		if [ "$with_cookie" != 2 ] || [ "$count" -le "$syn_ack_nr" ] || [ "$count" -gt "$syn_nr" ]; then
+		if [ "$count" != "$syn_ack_nr" ] && {
+		     [ "$with_cookie" != 2 ] ||
+		     [ "$count" -le "$syn_ack_nr" ] ||
+		     [ "$count" -gt "$syn_nr" ]; }; then
 			rc=${KSFT_FAIL}
 			print_check "synack rx"
 			fail_test "got $count JOIN[s] synack rx expected $syn_ack_nr"
@@ -1658,9 +1671,18 @@ chk_join_nr()
 	if [ -z "$count" ]; then
 		: # ignore skip
 	elif [ "$count" != "$syn_rej" ]; then
-		rc=${KSFT_FAIL}
-		print_check "syn rejected"
-		fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
+		# support old kernels without MPTcpExtMPJoinDisallowed counter:
+		# => with syncookies, the MPJoinRejected was incremented instead
+		if [ "$with_cookie" = 2 ] && [ "${disallowed}" -gt 0 ] &&
+		   ! mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinDisallowed" >/dev/null; then
+			syn_rej=$((syn_rej + disallowed))
+		fi
+
+		if [ "$count" != "$syn_rej" ]; then
+			rc=${KSFT_FAIL}
+			print_check "syn rejected"
+			fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
+		fi
 	fi
 
 	# Per-event MPTCP_RST_EMPTCP JOIN counters; default 0, gated on
@@ -1701,6 +1723,13 @@ chk_join_nr()
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
@@ -2180,8 +2209,8 @@ subflows_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 1 1 0
+		join_disallowed=1 \
+			chk_join_nr 1 0 0
 	fi
 
 	# subflow
@@ -2210,8 +2239,8 @@ subflows_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 2 2 1
+		join_disallowed=1 \
+			chk_join_nr 2 1 1
 	fi
 
 	# single subflow, dev
@@ -3546,7 +3575,7 @@ syncookies_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
+		join_disallowed=1 \
 			chk_join_nr 2 1 1
 	fi
 
@@ -4092,8 +4121,8 @@ userspace_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		join_syn_rej=1 \
-			chk_join_nr 1 1 0
+		join_disallowed=1 \
+			chk_join_nr 1 0 0
 	fi
 
 	# userspace pm type does not send join
@@ -4116,8 +4145,8 @@ userspace_tests()
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
2.55.0

