Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C483A2F25F0
	for <mptcp@lists.linux.dev>; Fri,  3 Jul 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097880; cv=pass; b=mAMvhnMfL2v98l2adYysYeVZI53mi12+PuOmMZibuo1QBe1oNPWCrwzmzCyZ4TIyhLqo3l/LUgVacWi3+ghoyv4nPz+662cUOp+BrUqZBDeYvffx38fX8jl1r+Cw762q05C93UboFG1Y1WfhF05vTfp5hLE54okEMP6Tssgbth8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097880; c=relaxed/simple;
	bh=x3FOASwRgJ9JiR3X/540C2XI/QabO5fA8OFY+akqCos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzH+lqLIQiuFSk2LEAdKXvWAa2ji+PtJpTI5QdIvA/p6feYivklKrKEs+ycdfRmv0uArRNEREXWUNfxYACqazMYgArqp39Lfan19luGbPqVme56xB4CYU23KJ6cNTTdQ4ZLb4t7OeVCHnXnoPpDLvJ7y01HhgJAxZzy+xFjJlE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=V2dT9T2f reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="V2dT9T2f"
ARC-Seal: i=1; a=rsa-sha256; t=1783097855; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WpBLZ8unb+BIeSZ8umszvPmRV3fqNuF4HNOBUktyfavxBuDbtsg+iCSJj4s1N9Hp0OKTH5qppegN953LKLxwdrwxJGV1sHbzyk1wWj43IfagJjKV4OIh/3KvTlrYb0j90+0FM/JZs3+QLpPeGe68eRRik7aIu1ky3+S01lCcF/A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1783097855; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NKHSLkH/TJRsSbq7fyp/wMx2DN5jrBz2S57uFZ/hzqk=; 
	b=fotL2vcY8hNJZDNFaoJZehpo3EDi1n72zec5UlOgQONgGZxAJVg13xPbLPAaBlWvO2KMIe9gwQWBsOl/R9GhjzEkgi/TH1It6icB58uKViBsBtYxdfQ05jxq/Xa3/LyMmGCouKlHOLR6kKEqL/WZMtKQtMFFDWDubb01v9e24bQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783097855;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=NKHSLkH/TJRsSbq7fyp/wMx2DN5jrBz2S57uFZ/hzqk=;
	b=V2dT9T2fGQ0pbs3ZMiLVRNsIaIpduhIcMw7bCBXYRfI/mqo2XZeps0HfbmDnMjjM
	ygwAbw3vSLe+yunJUWes4Zohi7vrVf3IK4T/LQ9YiW1WT5x7ziN8tVnX1erhqKJVfvz
	LiW2zxXIVKkV1jdV3rrDELxEGFOkvyZC44tTHPYw=
Received: by mx.zohomail.com with SMTPS id 1783097853491389.2793988394534;
	Fri, 3 Jul 2026 09:57:33 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
Date: Fri, 03 Jul 2026 22:27:11 +0530
Subject: [PATCH mptcp-next v2 3/5] Squash to "selftests/bpf: Add bpf_burst
 scheduler & test"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-mptcp_bpf_kfunc_fixes-v2-3-87ae3c64dc7e@mpiricsoftware.com>
References: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
In-Reply-To: <20260703-mptcp_bpf_kfunc_fixes-v2-0-87ae3c64dc7e@mpiricsoftware.com>
To: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 kalpan.jani@mpiricsoftware.com, janak@mpiric.us, shardulsb08@gmail.com, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>
X-Mailer: b4 0.15.2
X-ZohoMailClient: External

The bpf_burst scheduler selftest calls the mptcp_set_timeout() and
mptcp_pm_subflow_chk_stale() kfuncs by their raw names. The companion
squash-to patches to "bpf: Export mptcp packet scheduler helpers" narrow
those kfuncs behind bpf_mptcp_set_timeout() and
bpf_mptcp_pm_subflow_chk_stale() wrappers. Update the burst scheduler's
extern declarations and call sites to the wrapper names so it keeps
building and loading.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 8ff529d38a595..408c65ed897b5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -22,10 +22,10 @@ struct bpf_subflow_send_info {
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) == NULL)
 
 extern bool mptcp_subflow_active(struct mptcp_subflow_context *subflow) __ksym;
-extern void mptcp_set_timeout(struct sock *sk) __ksym;
+extern void bpf_mptcp_set_timeout(struct mptcp_sock *msk) __ksym;
 extern __u64 mptcp_wnd_end(const struct mptcp_sock *msk) __ksym;
 extern bool bpf_sk_stream_memory_free(const struct mptcp_subflow_context *subflow) __ksym;
-extern void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
+extern void bpf_mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk) __ksym;
 
 static __always_inline __u64 div_u64(__u64 dividend, __u32 divisor)
 {
@@ -99,7 +99,7 @@ int BPF_PROG(bpf_burst_get_send, struct mptcp_sock *msk)
 			send_info[backup].linger_time = linger_time;
 		}
 	}
-	mptcp_set_timeout(sk);
+	bpf_mptcp_set_timeout(msk);
 
 	/* pick the best backup if no other subflow is active */
 	if (!nr_active)
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

