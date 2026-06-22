Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAAB23370F
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782107127; cv=none; b=WxuPrN5HeNZnjPUiehxfT/ifp+6b5Wb9RMAfo/UUpsOommD0nazh8Iv/IyowJHqPuIAgt2n1PyXLdR+9QhabNsgll99kx1+eOLSFVGntIBE7J9An5LdSV3HqbiLO6cXhiP5/pLBtr13mYUdhu6NyZ2vF4ff6qt0MtYiE3fPQtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782107127; c=relaxed/simple;
	bh=HSVHdZ9FvFrkqL9nrrZTv7VzB6JIRdqzbrIXDlMn2vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEPQ1M7Ser0igrmISgfaz1T3OpDj909AmawACt+Vs1SjCCJdXK/u6G58nS+qkVWCYD/d6SLCjvwLWK276gh7DYOilnjBot5UYEm2bmUvYZRHkBDsP/AJugKfsJuhv2ZSpi0QJMxRoAPcwNZG7gKFHKlwUbQ7nkKoqITh67C+s2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUb05sR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUb05sR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24A21F00A3A;
	Mon, 22 Jun 2026 05:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782107126;
	bh=/h/0Acka8EVlY31LkuuvWJz8yeLpPn4ytT4iocaqNsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dUb05sR9wReB5MV9e2052l4aura6xBFM/oNkjrfv1elno5+28WliOWowHR85DL+Fg
	 wEx7BmVrnnZxE0p6ztbM93s0D4ipegn8XbMrwmTqnKmTNW1pynuPPT6zSvIN5t6Ytv
	 9TmI4T08nHB5UmyF5KPhMGQ8xJEjYsK/+SYIVha0kXs4zWoIydJslgYqwBkXmVCkU4
	 KqqGXHbNLXp0RGkbfENw0MqSQKZmZADmeU3oCWisx0wzdeZNO9uoqobQ/hftIkvkIn
	 uqNSrMZiJqTit3diIG1MumfQMc5HS1NvJ9ffbrO46yzHpyZyLFlaraKYc49YMVo3g4
	 /MYx2rRuwYQnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/7] Squash to "selftests/bpf: Add bpf_rr scheduler & test"
Date: Mon, 22 Jun 2026 13:45:06 +0800
Message-ID: <89fe8219efe03d16f0bb9eccc6075f0adadbe1a5.1782106180.git.tanggeliang@kylinos.cn>
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

Rewrite bpf_rr_get_send to use a single traversal over subflows instead
of calling bpf_mptcp_subflow_ctx() and bpf_iter_mptcp_subflow_next().
The new implementation:
- Records the first subflow as a fallback
- Uses a flag to find the subflow after ptr->last_snd
- Falls back to first when last_snd is NULL or not found

This eliminates unsafe pointer handling and avoids verifier trust issues.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 30 +++++++++++--------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 3c685c77f67f..10cef8abf206 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -33,33 +33,37 @@ void BPF_PROG(mptcp_sched_rr_release, struct mptcp_sock *msk)
 SEC("struct_ops")
 int BPF_PROG(bpf_rr_get_send, struct mptcp_sock *msk)
 {
-	struct mptcp_subflow_context *subflow, *next;
+	struct mptcp_subflow_context *subflow, *first = NULL, *next = NULL;
 	struct mptcp_rr_storage *ptr;
+	bool found = false;
 
 	ptr = bpf_sk_storage_get(&mptcp_rr_map, msk, 0,
 				 BPF_LOCAL_STORAGE_GET_F_CREATE);
 	if (!ptr)
 		return -1;
 
-	next = bpf_mptcp_subflow_ctx(msk->first);
-	if (!next)
-		return -1;
-
-	if (!ptr->last_snd)
-		goto out;
-
 	bpf_for_each(mptcp_subflow, subflow, (struct sock *)msk) {
-		if (mptcp_subflow_tcp_sock(subflow) == ptr->last_snd) {
-			subflow = bpf_iter_mptcp_subflow_next(&___it);
-			if (!subflow)
-				break;
+		if (!first)
+			first = subflow;
+
+		if (!ptr->last_snd)
+			break;
 
+		if (found) {
 			next = subflow;
 			break;
 		}
+
+		if (mptcp_subflow_tcp_sock(subflow) == ptr->last_snd)
+			found = true;
 	}
 
-out:
+	if (!first)
+		return -1;
+
+	if (!next)
+		next = first;
+
 	mptcp_subflow_set_scheduled(next, true);
 	ptr->last_snd = mptcp_subflow_tcp_sock(next);
 	return 0;
-- 
2.53.0

