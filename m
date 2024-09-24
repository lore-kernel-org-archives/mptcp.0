Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C215539D
	for <mptcp@lists.linux.dev>; Tue, 24 Sep 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170133; cv=none; b=UH1Vwa7UeEM67Z4+6RSUNUGbvj6Mq0D+1kg/DS9T9cLn8tR7xSzxJncKBY6y+O+kAGT36jZbT34TqXuNfF1g1/HyWH3cZBtLSnmV9zbcxkwg81Z7ry+GeU/HgpLw5u0DqHC3/oELSl/UBw3fFShzOr/ysp7IHicojdpd/Jac7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170133; c=relaxed/simple;
	bh=e47A1kNeBCP3iDZJFlUGIUyLRRz+/61jcgjFmdiXCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3X+nYAZfAPsQxGa1CsLbzoz+RWNFI0gvp9EYNE5nYURmDjFv+QAyb+1l0U7x3a0v159HsFpFXDYbFV5Jen+Q1rE2syREt43KUpIv3YPUTjj2zfuYPgp5lWzSGjYHVhX/iAhtc3Tcq5Xaf+Q1Z57n6n/x7c/5zTmOE84boOpAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkP0bTGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkP0bTGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A6FC4CEC4;
	Tue, 24 Sep 2024 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727170133;
	bh=e47A1kNeBCP3iDZJFlUGIUyLRRz+/61jcgjFmdiXCmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkP0bTGYaNeUbrDKGUDe96K8AdA9XEb+3MHLDP+Qn3lAVs15z6F6bcoutuMFK/8uL
	 XbD92niUHqBxiJUHqn689wcKYcJlSbbVwf+J+MTMpquH+UDREgHOdWUVO8nNx8RO33
	 NSNthDQuy70JgiL7Jjhb2ML6GEsvep/jBVCTIDVhMThFU37j8LXJUs05vYUB1+L46u
	 RLJM1KYaB8YlDs15FvhZWNxgD8p5XS/Ohwv0ig+6CHfhMfli2KgrNI+Hui7zCeHRY5
	 mJaDUgqmeAd8kNZ5KUNysYzsR+pCKpNRDZ4xBUC7A7XZ7VB9ZlB5dSRX/WuBrSM8fO
	 UMXaHByRn7QLw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 7/8] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Tue, 24 Sep 2024 17:28:35 +0800
Message-ID: <1cfa154b788d27b18285a23e7cdd40d199802623.1727169534.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727169534.git.tanggeliang@kylinos.cn>
References: <cover.1727169534.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use the newly added bpf_for_each() helper to walk the conn_list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 39 +++++++------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index dcab196867fe..3bf0213d01b3 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -66,8 +66,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 {
 }
 
-static int bpf_burst_get_send(struct mptcp_sock *msk,
-			      struct mptcp_sched_data *data)
+static int bpf_burst_get_send(struct mptcp_sock *msk)
 {
 	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -83,14 +82,8 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 		send_info[i].linger_time = -1;
 	}
 
-	for (i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		bool backup;
-
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
-		backup = subflow->backup || subflow->request_bkup;
+	bpf_for_each(mptcp_subflow, subflow, msk) {
+		bool backup = subflow->backup || subflow->request_bkup;
 
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
@@ -108,7 +101,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].subflow_id = i;
+			send_info[backup].subflow_id = subflow->subflow_id;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -118,7 +111,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	if (!nr_active)
 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
 
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
+	subflow = bpf_mptcp_lookup_subflow_by_id(msk, send_info[SSK_MODE_ACTIVE].subflow_id);
 	if (!subflow)
 		return -1;
 	ssk = mptcp_subflow_tcp_sock(subflow);
@@ -140,19 +133,15 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int bpf_burst_get_retrans(struct mptcp_sock *msk,
-				 struct mptcp_sched_data *data)
+static int bpf_burst_get_retrans(struct mptcp_sock *msk)
 {
-	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX, subflow_id;
+	int backup = MPTCP_SUBFLOWS_MAX, pick = MPTCP_SUBFLOWS_MAX;
 	struct mptcp_subflow_context *subflow;
 	int min_stale_count = INT_MAX;
 	struct sock *ssk;
+	int subflow_id;
 
-	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
-		if (!subflow)
-			break;
-
+	bpf_for_each(mptcp_subflow, subflow, msk) {
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
@@ -166,12 +155,12 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 
 		if (subflow->backup || subflow->request_bkup) {
 			if (backup == MPTCP_SUBFLOWS_MAX)
-				backup = i;
+				backup = subflow->subflow_id;
 			continue;
 		}
 
 		if (pick == MPTCP_SUBFLOWS_MAX)
-			pick = i;
+			pick = subflow->subflow_id;
 	}
 
 	if (pick < MPTCP_SUBFLOWS_MAX) {
@@ -181,7 +170,7 @@ static int bpf_burst_get_retrans(struct mptcp_sock *msk,
 	subflow_id = min_stale_count > 1 ? backup : MPTCP_SUBFLOWS_MAX;
 
 out:
-	subflow = bpf_mptcp_subflow_ctx_by_pos(data, subflow_id);
+	subflow = bpf_mptcp_lookup_subflow_by_id(msk, subflow_id);
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
@@ -193,8 +182,8 @@ int BPF_PROG(bpf_burst_get_subflow, struct mptcp_sock *msk,
 	     struct mptcp_sched_data *data)
 {
 	if (data->reinject)
-		return bpf_burst_get_retrans(msk, data);
-	return bpf_burst_get_send(msk, data);
+		return bpf_burst_get_retrans(msk);
+	return bpf_burst_get_send(msk);
 }
 
 SEC(".struct_ops")
-- 
2.43.0

