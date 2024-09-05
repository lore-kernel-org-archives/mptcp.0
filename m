Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C555286A3
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546545; cv=none; b=QOVKSBgb6I6w/PdwFGg25pG1Bo09T/BWw84WPt6zcJ/dks4jUO+ENCvIxstcGMJoe7BwFnDimH/f8fhWn4ydKz8VeHZmTJ9daktzedsUN93JDNsVdElfUJcG/nRzzFPYwKQ0e8QiD2dFYDzVcZHJHMPZQo8CJccWXF3SNVLpi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546545; c=relaxed/simple;
	bh=DdGEIIWht+8UQLVl/O99KOPa1fIqXXo4euO+8dSQqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBLRvhNnyfqsn/zsSe0nbOku7vWcpYDcNGwaPHJczq0I9xK9yeSswLRFA+s/f2NYKPz7txRyq1siY9Rgz+wbw3iz9GN2JbhJXaIAhRI00PWC83s1ygb6oKCgxIadLu5MDh1tXGxAhLoBZKxvPM8w8TWmA3aysdCK4uezYVhr3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALhE9HRZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALhE9HRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839FBC4CEC5;
	Thu,  5 Sep 2024 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546544;
	bh=DdGEIIWht+8UQLVl/O99KOPa1fIqXXo4euO+8dSQqbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALhE9HRZt/8ZxzQUrsH2NM4nrSC4xDT7cCfxvOcHeUYfPvveHrk+3QA+XgZIhEZj3
	 RyZ+7p1QI99pgS9tNaGpEsU5JtyAVZbjNXFmqf/PQvBsx29hSEWhHNey4rQ2e9colY
	 fWa3R63kfSQ96L2zjtR1JpbkMTAy+a9TnmvmRD8DAzv4OKL7gdWoPcZQYnt95nA0hR
	 G99FwLUmuHMNUwR8IG7p30yCwh7yajU3/NBgEr9LeC2v+CcdJd0cJAJazHKJXNYfuP
	 kIo+dp4oOWXSRwNahpUNIb+OdGPO5uTUYJus1qDQ5Ue7fqAR9wTKCk+fUwJj1kCrAw
	 NXogV/RYEJAMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 2/2] Squash to "selftests/bpf: Add bpf_burst scheduler & test"
Date: Thu,  5 Sep 2024 22:28:51 +0800
Message-ID: <a1d8abd098a6b68a5c619b8cd7558f963f7d342a.1725546472.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1725546472.git.tanggeliang@kylinos.cn>
References: <cover.1725546472.git.tanggeliang@kylinos.cn>
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

