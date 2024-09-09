Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2611CA1
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725846944; cv=none; b=hdc+nsemlk4YZ7PSgqwNmyT4PHIjt64u9d+pojwHjdcFlMinQCKF5iSBTtj7mQAkMUWbAElAAPPxuj9oQrhWqsfkhNq0GNEJIuaxmlkhBQtRSpxibgpB0csk0riQq+Bn7LRz190teaIL0ryVaD/EypOrg6aJoDqponGR8phB8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725846944; c=relaxed/simple;
	bh=DdGEIIWht+8UQLVl/O99KOPa1fIqXXo4euO+8dSQqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdwOVNB+xhXlVcDq4BgaDDioUVkA2qqVK0KF6FBK9N9HKHHTnUjlpCnLqYswKl54T6/RQfC1oam2wuPJOjIYYE+vnVfUC5VZbfvGhKErxjtoA8dU11mKa8S99k3ge67rkdwCLXmJnQLv8eHwOqiqXLmh4dft2DHA0GSStPGN/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDY0xmNb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDY0xmNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4FDC4CEC3;
	Mon,  9 Sep 2024 01:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725846944;
	bh=DdGEIIWht+8UQLVl/O99KOPa1fIqXXo4euO+8dSQqbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eDY0xmNbyr9tdX6TShszLHAIA7ibnY/EgGIcDHkHfq5G4rXu+ibJh1hDB0413EWzi
	 Q3L32Ei+rTI8k/BqDCOQwtBefnn8ERVP5HHQcRbVpiYdRgNMnWgeVgA5fPQUrQgNz6
	 lK6YoJSpmzXU/u7WfPlVKyZUz5awMvEvIT+EKm0ibJiRgCl6lU77xyr/3vjghf7YdG
	 C6nsjVwWf972rlJkWrEnMJ81H7bbGY1FkD/c07w7SzVsM5Ze1WqegvXOkDEuuVFqek
	 UN+PUv2XjsMQjY8jHnSuHUONPz0FmEWu33fKsVJh4qwncJ4rjjfa58TWxIBEBphyRD
	 BOt6l4Xb8WNug==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/4] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Mon,  9 Sep 2024 09:55:32 +0800
Message-ID: <33f322e8fd3e1fe158557f70e82706ccca41fff2.1725846806.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725846806.git.tanggeliang@kylinos.cn>
References: <cover.1725846806.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Use nr_active variable just like in mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 3a673291b4dd..eb21119aa8f7 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -74,9 +74,9 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
+	int i, nr_active = 0;
 	__u64 linger_time;
 	struct sock *ssk;
-	int i;
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
@@ -97,6 +97,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (!pace) {
 			/* init pacing rate from socket */
@@ -115,7 +116,7 @@ static int bpf_burst_get_send(struct mptcp_sock *msk,
 	mptcp_set_timeout(sk);
 
 	/* pick the best backup if no other subflow is active */
-	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
+	if (!nr_active)
 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
 
 	subflow = bpf_mptcp_subflow_ctx_by_pos(data, send_info[SSK_MODE_ACTIVE].subflow_id);
-- 
2.43.0

