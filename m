Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98835CB6E
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107129; cv=none; b=S3CAiqAgyqAkpk4gj5g6YxtvCo9UM1EqyjVs4Li0SPI3+agfrCEuuCT+iTe7LB79ybfE8RK5A7FdOllGOEixUsEgRfTQ+HeA+eJx4OpESB5t2mSxvFmrRDgDAyPJ6iPNyQKXBeksAX8720+oMUmunjwRG65iF8w5t2g2tBkrx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107129; c=relaxed/simple;
	bh=Mw+1o4rF8vNREt6l8EWQ3xs/m4kxAL0OA0dN3Gn3vcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9yiUSKDrLEsCkKuhiD8jZq3JN/Wjx5FYVECD2TN8b5RJWLYTnbvc7ph1x8FiFvdCwe8KR7QyMCWr/QDI5Rgwdj76ZDsIW/headh5rrdzZMbhL/j6cwsRhb9LsrARzIHcF26CCw5UFUHqYbgEEyLuPDosR6Um0fbm4UAFqpHlVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cus6nBvy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cus6nBvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD7F1F000E9;
	Mon, 22 Jun 2026 05:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107127;
	bh=tBkYRsA0jgJvbtXoN6VKY5g0sWH9rsfb4cuOcntGBq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cus6nBvyVA1AhZ1bvZrOuHQyfs+YCSQI56aX4/hJo3sv3CDqe/795RmCsxbx7hukR
	 oFoi2U2MCY5MV2twUvj2GdJN2by+UcCmEIVa+g4mkorMdZBCeZHQa4kPTPAMN/8TUt
	 zYv6ExQ/NJqMuxRPncdEGTXd+Qg4Sjakx2dbrLZa3HPCFAJKi3AFY5xUJ6QiAx49xh
	 S8kZNKWvDOCHqS8xn+NPrkfeTgf80xF0F9op3CdCnHWMRxF7NBDQiYwo2rYPSVz2nl
	 fWhUnFz57vwj4kOwONzUksg1VvvKb8iLwKxt49qVedlvg6FIyxKwQNKIy+iU8wJpaN
	 tF51q4jJBFquQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/7] Squash to "selftests/bpf: Add bpf_burst scheduler & test" 2
Date: Mon, 22 Jun 2026 13:45:07 +0800
Message-ID: <9424d61f707814629bffe2f6093a330cd82b1410.1782106180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782106180.git.tanggeliang@kylinos.cn>
References: <cover.1782106180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Modify bpf_burst_get_send to store subflow pointers instead of sock
pointers in the send_info array, eliminating the need to call
bpf_mptcp_subflow_ctx() for reverse lookup. The selected subflow pointer
from the iterator is trusted, so it can be used directly for scheduling
and member updates. This resolves the verifier error caused by passing
untrusted sock pointers to kfuncs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 22 +++++++++++--------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index bd258776076c..585d643d6e31 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -9,6 +9,11 @@ char _license[] SEC("license") = "GPL";
 
 #define MPTCP_SEND_BURST_SIZE	65428
 
+struct bpf_subflow_send_info {
+	struct mptcp_subflow_context *subflow;
+	u64 linger_time;
+};
+
 #define SSK_MODE_ACTIVE	0
 #define SSK_MODE_BACKUP	1
 #define SSK_MODE_MAX	2
@@ -81,7 +86,7 @@ void BPF_PROG(mptcp_sched_burst_release, struct mptcp_sock *msk)
 SEC("struct_ops")
 int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 {
-	struct subflow_send_info send_info[SSK_MODE_MAX];
+	struct bpf_subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
@@ -91,7 +96,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].ssk = NULL;
+		send_info[i].subflow = NULL;
 		send_info[i].linger_time = -1;
 	}
 
@@ -114,7 +119,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[backup].linger_time) {
-			send_info[backup].ssk = ssk;
+			send_info[backup].subflow = subflow;
 			send_info[backup].linger_time = linger_time;
 		}
 	}
@@ -122,18 +127,17 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+		send_info[SSK_MODE_ACTIVE].subflow = send_info[SSK_MODE_BACKUP].subflow;
 
-	ssk = send_info[SSK_MODE_ACTIVE].ssk;
-	if (!ssk || !sk_stream_memory_free(msk, ssk))
+	subflow = send_info[SSK_MODE_ACTIVE].subflow;
+	if (!subflow)
 		return -1;
 
-	subflow = bpf_mptcp_subflow_ctx(ssk);
-	if (!subflow)
+	ssk = mptcp_subflow_tcp_sock(subflow);
+	if (!ssk || !sk_stream_memory_free(msk, ssk))
 		return -1;
 
 	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
-	ssk = bpf_core_cast(ssk, struct sock);
 	wmem = ssk->sk_wmem_queued;
 	if (!burst)
 		goto out;
-- 
2.53.0

