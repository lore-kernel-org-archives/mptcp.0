Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C852153D5
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347425; cv=none; b=ipJCymhFTtak2I0R+ARvGo1BcC3+ENNUsReb388BEq401vO00hWLIDdSZpHWvIpBvlQRNSAzFoaSymtti23HGiO5cevAEvt+IYwyEWNLzIU1oMEsNSfzpx1RUc5OR7JNPJvIXX8srQOJTPO0E35SeyeWFB2LlvsEySSWD0osXdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347425; c=relaxed/simple;
	bh=a0YkX2PS2JCc49Jh6btHmApqKwX4jkIiDpRgiEVF5AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUPqcBryMjrd2uVy6Ve3dCi5+LvMs4jj/Rw4E4z878tFX4LNG15qNZqu+HNrM3/rZJLPMnZqL9h1ljw5uG8h7s7YpI/nBGF0DY9UAenkZUmVm2XABMmFjqPUIV1s9cePg4lm+wVGJhYytfh6MtOjFfF435A2IA4QgpBrKuqnICA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0tFFalc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0tFFalc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AE3C4CEE5;
	Fri,  7 Mar 2025 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347425;
	bh=a0YkX2PS2JCc49Jh6btHmApqKwX4jkIiDpRgiEVF5AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0tFFalcZMcfrvJIlqr9jQC9TPvVt7l+aGxED+fJzAadLqEFKt5/7b6+s/dDA8VVa
	 Vp3zpqZCnX/9qDaBQd6tvDKt7piKRu1dVp+I6++7SzuTr/WqP5vd3QNs+LL+7OdcVt
	 EcmNm3CUZASXN/36IH5HRXHrgbKsmKgLzjjfvM2DCUCkxsvCouw5DYGBZspPTO8rsf
	 Z6C3jzo4QuHh/pLvHFmf7Vs8up2lvQH/0jcet3KFSx64IAg7X0G4qr2+5AogAqmo7e
	 WuI17f/XpmhenWPdPKRab4hPNWwFeC1JhDyVkUZjmabG3KeqL/Lt6BQYLzIuUuHEC5
	 +Ss4PM/HpYM7w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v2 03/11] mptcp: add bpf_iter_task for mptcp_sched_data
Date: Fri,  7 Mar 2025 19:36:44 +0800
Message-ID: <620223de348631c8b8bf798b46c18002160c9235.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To make sure the mptcp_subflow bpf_iter is running in the
MPTCP context. This patch adds a simplified version of tracking
for it:

1. Add a 'struct task_struct *bpf_iter_task' field to struct
mptcp_sched_data.

2. Do a WRITE_ONCE(data->bpf_iter_task, current) before calling
a MPTCP BPF hook, and WRITE_ONCE(data->bpf_iter_task, NULL) after
the hook returns.

3. In bpf_iter_mptcp_subflow_new(), check

	"READ_ONCE(data->bpf_scheduler_task) == current"

to confirm the correct task, return -EINVAL if it doesn't match.

Also creates helpers for setting, clearing and checking that value.

Suggested-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.h | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 2c85ca92bb1c..bd3d1b3654dd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,6 +105,7 @@ struct mptcp_out_options {
 struct mptcp_sched_data {
 	u8	subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+	struct task_struct *bpf_iter_task;
 };
 
 struct mptcp_sched_ops {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3492b256ecba..0875b3cf4aba 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1291,4 +1291,23 @@ mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subflow_re
 static inline void mptcp_join_cookie_init(void) {}
 #endif
 
+static inline void mptcp_sched_set_bpf_iter_task(struct mptcp_sched_data *data)
+{
+	WRITE_ONCE(data->bpf_iter_task, current);
+}
+
+static inline void mptcp_sched_clear_bpf_iter_task(struct mptcp_sched_data *data)
+{
+	WRITE_ONCE(data->bpf_iter_task, NULL);
+}
+
+static inline bool mptcp_sched_check_bpf_iter_task(struct mptcp_sched_data *data)
+{
+	struct task_struct *task = READ_ONCE(data->bpf_iter_task);
+
+	if (task && task == current)
+		return true;
+	return false;
+}
+
 #endif /* __MPTCP_PROTOCOL_H */
-- 
2.43.0

