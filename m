Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F74071E7
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734908; cv=pass; b=PWACwu2sHU8qziI2oPk8mjIY5i7so3SIfxxx/1Cr7aqRG5i20mQaKfRifBnKWGAjHTFom0FOS5PquyzlFASCMCKl4FLQhfp3CdJvZgiiCLJ2kaH/nfVz17VZ3ryEzve08meIFQR8XCEtfsH+zx4/yeQG29TPPJp4LFl0GuuEodI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734908; c=relaxed/simple;
	bh=q5i0aSF2kkLypPb305UtsW8d/olZCupJeFCMmvKIrkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBfMggwxUOGqcN+5qk6qgrfjqjqHUfgyYMIJ4BSf3tvx4uSPFxefRGntMRO3jaEc6A779SYS6ZdrT/WLUY9Qww3nVXE5vQuuCa5PNjuP7MRO7h7S9b5lZjZIEIIG4/0ers0cCYYLGkSg+E517stmlmHoE879txr7wP6rWoByJac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=P7MVGtMc reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="P7MVGtMc"
ARC-Seal: i=1; a=rsa-sha256; t=1782734892; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gqR2RSNfSpYeuU5kUL/LhugCxyYQXiOUH0z5xZObRBzp1C5rNRtv1rJincKFufuDpCHXhzomqXzYrHWkkJQlYeOqTpoXt4wBQpjMKkO//FPkYSepNsaCs7/BOnEWsVlMMx56hYRsURB2In0uCpMA9+GBynYlyOBVy9L0w1lYGtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782734892; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8QFw/XHYOGhjIW2BP+GoaEtVWkDrQfcVRvjs99OAAjw=; 
	b=cMyZYRkpFrS0Ii6v0OKvlDg+ZFgkTQbXDrOA+jwmU1sHt92gW2zBNMVzshTJmWzNDEGPEfmUL1oboeTHQiovoE8wSDKrRPSKQ2FP3S1GwilHIKqg7R4XAMUOiwJ82igvEdDEcE7G1amHiOTj4oQStc1lhZgwZKbsMx1U+JCbco0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782734892;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=8QFw/XHYOGhjIW2BP+GoaEtVWkDrQfcVRvjs99OAAjw=;
	b=P7MVGtMcXGYGVzB+d9sbUWGvRmseNRBs6gWhU9eKjwMmVkKyqfjqL0d0T0phiz01
	U0cHIaWdQCMTd0itQvhokV65l0vVU//C/cEs6Yb56Mk8ETB8qd/CDk1oc8NLecITiyA
	HUZxjd+Yp2kc6NXoZ2gSV+ugKnzM9Ejlrfe4AKo8=
Received: by mx.zohomail.com with SMTPS id 1782734890635758.9205377284165;
	Mon, 29 Jun 2026 05:08:10 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Mon, 29 Jun 2026 17:37:34 +0530
Subject: [PATCH mptcp-next 1/4] Squash to "bpf: Export mptcp packet
 scheduler helpers"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-mptcp_bpf_kfunc_fixes-v1-1-8cc875f36f53@mpiricsoftware.com>
References: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
In-Reply-To: <20260629-mptcp_bpf_kfunc_fixes-v1-0-8cc875f36f53@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

mptcp_set_timeout() is exposed to BPF MPTCP packet schedulers as a kfunc
taking a generic "struct sock *". The verifier only checks that the
argument is a trusted struct sock; it cannot distinguish an MPTCP-level
socket (msk) from a subflow's TCP socket. A scheduler get_send() program
can therefore pass a subflow socket (e.g. msk->first, or the result of
bpf_mptcp_subflow_tcp_sock()), which mptcp_set_timeout() upcasts via
mptcp_sk() and iterates as msk->conn_list. On a subflow socket those
bytes are live TCP state, so the walk yields a wild mptcp_subflow_context
and the subsequent subflow->tcp_sock dereference faults (GPF / KASAN
user-memory-access).

Narrow the kfunc-facing type: register a bpf_mptcp_set_timeout() wrapper
taking "struct mptcp_sock *" instead of the raw mptcp_set_timeout()
symbol, so the verifier's BTF-id check rejects a non-msk socket at
program load time. A scheduler that passes its msk is unaffected; update
the in-tree burst scheduler selftest accordingly.

Found by an MPTCP protocol-flow harness extending BRF (arXiv:2305.08782).

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 net/mptcp/bpf.c                                     | 7 ++++++-
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0845061ddc65c..9355fb53e89d5 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -301,6 +301,11 @@ bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow)
 	return false;
 }
 
+__bpf_kfunc static void bpf_mptcp_set_timeout(struct mptcp_sock *msk)
+{
+	mptcp_set_timeout((struct sock *)msk);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_mptcp_iter_kfunc_ids)
@@ -319,7 +324,7 @@ BTF_ID_FLAGS(func, bpf_mptcp_subflow_ctx, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_mptcp_subflow_tcp_sock, KF_RET_NULL)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_subflow_active)
-BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, bpf_mptcp_set_timeout)
 BTF_ID_FLAGS(func, mptcp_wnd_end)
 BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
 BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale, KF_SLEEPABLE)
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 8ff529d38a595..1c4673d7c2338 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -22,7 +22,7 @@ struct bpf_subflow_send_info {
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
 
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
-extern void mptcp_set_timeout(struct sock *sk) __ksym;
+extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow) __ksym;
 extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
@@ -99,7 +99,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 			send_info[backup].linger_time = linger_time;
 		}
 	}
-	mptcp_set_timeout(sk);
+	bpf_mptcp_set_timeout(msk);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)

-- 
2.34.1

