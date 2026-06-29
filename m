Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CF344D88
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734928; cv=pass; b=XkavND06T0w7j2DJjHfAkzODtcqslDxDfc78CuFb3b2D5hBwwB0WyRPYWL+8f80nf9iHYSa63WGzp3Zu5OHmvUiYXqHohGs5Krp+GgReBpAOfxdKRAMd3dfnLWEHVjugc8wE56S2hxWMyy30ZrcCyx8tykspt/R3hs5ksbUjSFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734928; c=relaxed/simple;
	bh=NDMSGViNeJXiTb4XTXSDt42GklPTcd1BjKE0R+OLXtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAqzR/eQBtbvLqkwTYYflY11UDh/rlmfY0BSA48LF7JuYksUZIPh6fdlBOi1ZH+WCxadsHod8bZhPYxa6yLQcLM8VupEReBohKazp8evDf53ONIPkclNE+zr8cb40Q6EK7QchAcHchMGW8QHVaWm9M1r99+3aXxH3pzD0QHdTxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=ROPUcLxL reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="ROPUcLxL"
ARC-Seal: i=1; a=rsa-sha256; t=1782734896; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kl2TH8AWtdyX1DJca5GsPaGlC+1vQ1ZVAgBOSeXoFjhw0BsDPyCez8z9g2Dacm0moWmgxXtIRtAMJ+oorRLqgvjeBbQhyNJ78ywmFFUAq9QI81UeFX7QEAGaPIpDfyJDM4gw5iltZyzCKdMMfGepJbgNPMNL2Hf9yr95OEqWOeM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782734896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6uBz/Og5lkQ0n7sGZjz4+Usf3ATC4fD81HYsYh8Uf+I=; 
	b=EnDqgWCUaBTtkcFnO5S8B3aM2Aq2ktHHDo8muZNX+kjfZu+fvILGfXI0wSqmDhdFF1DMRPJlrna3Qotgw3/3HW14Bk03P9n2wy9Dq9BJID2LTrQqnPQQ0MWP6sDhJQb18aeL+5qwiZ7wExNjLx94JoxOy063X46eE3mcH8osydo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782734896;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=6uBz/Og5lkQ0n7sGZjz4+Usf3ATC4fD81HYsYh8Uf+I=;
	b=ROPUcLxLJO4pOoCG4BQ2jWpGWxbOs9XhbRcBep1nL6Patgar77KgZ63TCvqeqF3Y
	yTwkGK7K6lrvjkRrF9weEDZGhzuX4IEI9ExV5xSb6GePsMJdwTwufsQYn5Qzfyes5Em
	22Ebj/VyTEbykspcI+XdjEk3noj4WYOiBXe2ousE=
Received: by mx.zohomail.com with SMTPS id 1782734894576889.2873021767887;
	Mon, 29 Jun 2026 05:08:14 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 29 Jun 2026 17:37:35 +0530
Subject: [PATCH mptcp-next 2/4] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-mptcp_bpf_kfunc_fixes-v1-2-8cc875f36f53@mpiricsoftware.com>
References: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_pm_subflow_chk_stale() is exposed to BPF MPTCP packet schedulers as
a kfunc whose second argument is a generic "struct sock *ssk". The
verifier only checks that the argument is a trusted struct sock; it cannot
tell a subflow's TCP socket from any other socket. A scheduler
get_retrans() program can therefore pass a non-subflow socket (e.g.
(struct sock *)msk, or any other full socket), and
mptcp_pm_subflow_chk_stale() reinterprets it via mptcp_subflow_ctx(),
which is an unchecked cast of inet_csk(ssk)->icsk_ulp_data. On a
non-subflow socket the derived subflow is bogus, and the function reads
tcp_sk(ssk) state and writes through that bogus pointer
(subflow->stale_rcv_tstamp, subflow->stale_count).

This kfunc legitimately operates on a subflow TCP socket, so the fix is a
runtime role check rather than a narrower arg type: register a
bpf_mptcp_pm_subflow_chk_stale() wrapper that validates ssk is a full
MPTCP subflow TCP socket before calling the internal helper, like
bpf_mptcp_subflow_ctx(). A scheduler passing a real subflow socket is
unaffected; update the in-tree burst scheduler selftest accordingly.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/bpf.c                                     | 10 +++++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 9355fb53e89d5..30d3cbb23efb0 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -306,6 +306,14 @@ __bpf_kfunc static void bpf_mptcp_set_timeout(struct mptcp_sock *msk)
 	mptcp_set_timeout((struct sock *)msk);
 }
 
+__bpf_kfunc static void
+bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
+{
+	if (ssk && sk_fullsock(ssk) && ssk->sk_type == SOCK_STREAM &&
+	    ssk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(ssk))
+		mptcp_pm_subflow_chk_stale(msk, ssk);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
@@ -327,7 +335,7 @@ BTF_ID_FLAGS(func, mptcp_subflow_active)
 BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
-BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_mptcp_common_kfunc_ids)
 
 static int bpf_mptcp_common_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 1c4673d7c2338..408c65ed897b5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -25,7 +25,7 @@ extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
 extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow) __ksym;
-extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
+extern void bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
@@ -140,7 +140,7 @@ int BPF_PROG(bpf_burst_get_retrans, struct mptcp_sock *msk)
 
 		/* still data outstanding at TCP level? skip this */
 		if (!tcp_rtx_and_write_queues_empty(ssk)) {
-			mptcp_pm_subflow_chk_stale(msk, ssk);
+			bpf_mptcp_pm_subflow_chk_stale(msk, ssk);
 			min_stale_count = min(min_stale_count, subflow->stale_count);
 			continue;
 		}

-- 
2.34.1

