Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26F1D5CD9
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998028; cv=none; b=BACy1zOvrUB6PFnELuIBD5mlWLHM6iX+Tq62aed9NZx/UtAfhuoqMSXfjHStQVb4lnJdGQZ1KONIKTGrQp9+uh4mox7mwxl5Ww7iZK/dE93wkQYT8h482UEvAmEnO+OkJof0ud9LcnecXtc06LV4YO1S2pm5opQob9V0zihGgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998028; c=relaxed/simple;
	bh=vKlvxkWIzS/8vMddXtyi+A5jNgKZvuAia2fitdYo9Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z66S/RxI8rcVF9Rha6m5rwtjbQSnTlMBs7Ciq9uTQitvg+Y/IDW9URilekfXPTNipC7HSCkaioTBBGGkeQiVBLxNcW/nqtVjB9SnApVlHabO9dvDKNWwkNDRiJP/SbjYCWsHB/7ey9JUUw06+kjTRdojyAtW6VHBEZ6GbAxb71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrFnpVEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrFnpVEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7556C4CEE8;
	Mon,  3 Mar 2025 10:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998028;
	bh=vKlvxkWIzS/8vMddXtyi+A5jNgKZvuAia2fitdYo9Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrFnpVEhONKMs9jO5ZIt5VyfVca/lGRCjjwhzhBgWrTujDrQB+AtD8hFxBDspp2U8
	 oTcberZYnBZgkvzafqdl2HrTbNZnUjNSZCGvhZAYVynwlpNx2cDa5q1EswKDv+K7pJ
	 r+cwPaDIdSzbAPqJMdbL5SYVQoTD4oPRkEFuvNDxWVEUqncMGZnsMG7M7NTouLK66g
	 YSNjX8edXTb7SYiA+qNNI1j4xBVtdWyuBJXud7ur6M0Nz1AHzV7xqGvJDrnyPC841v
	 2hTnFPlv4kaEtQPkvy2Kxm4/hK0GcYhA6CkpGZpdQpvvtwLYBE+Tc+g+iij/fk1w4i
	 /iVnQ8dTl3fuA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/5] Squash to "bpf: Extend bpf_skc_to_mptcp_sock to MPTCP sock"
Date: Mon,  3 Mar 2025 18:33:34 +0800
Message-ID: <c43f5e1fe8da4db01749ede9d18af1a3a2134fd4.1740997925.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740997925.git.tanggeliang@kylinos.cn>
References: <cover.1740997925.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Set msk->bpf_iter_task in bpf_mptcp_sock_from_sock() to allow
mptcp_subflow bpt_iter can be used in cgroup/getsockopt,
otherwise, the selftest in this set fails.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/bpf.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index be222fa5f308..aff92f458e7f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -197,14 +197,22 @@ static struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 struct mptcp_sock *bpf_mptcp_sock_from_sock(struct sock *sk)
 {
+	struct mptcp_sock *msk;
+
 	if (unlikely(!sk || !sk_fullsock(sk)))
 		return NULL;
 
-	if (sk->sk_protocol == IPPROTO_MPTCP)
-		return mptcp_sk(sk);
+	if (sk->sk_protocol == IPPROTO_MPTCP) {
+		msk = mptcp_sk(sk);
+		mptcp_set_bpf_iter_task(msk);
+		return msk;
+	}
 
-	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk))
-		return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+	if (sk->sk_protocol == IPPROTO_TCP && sk_is_mptcp(sk)) {
+		msk = mptcp_sk(mptcp_subflow_ctx(sk)->conn);
+		mptcp_set_bpf_iter_task(msk);
+		return msk;
+	}
 
 	return NULL;
 }
-- 
2.43.0

