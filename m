Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309527;
	b=l98hbuMF0lfmId1HMfb20TN2Md6omQKMPxUQPrWEb4CX30WLQs9hcBnG1fy/D6e5m4YX
	 t33hjNE/KCmlsxSIsZOLDRWrdBAbNOSzGjCs2c2UEnPxWv8b881MiPhTMgNQT5OwgTvO9
	 IPKTYDl4xNXBFhHeAzARaGED2HC8/8Cb3aTqj0qZPbVV5sM5Fql4TbX+2xn/8wbqTkpqB
	 TrlbssMy4TxCRv0hl8cVUym7Sg6qIwXnUOLH0vzklcUolHXSQ9fY0BK3Bm8eoTKBFQiTa
	 xCUYhSrk091ZotAMMGueYY41mB8uILk7AqAl3YyXw6W6jSJtq3dC4tN3G3aucHZLPpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309527;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=o1xzL/rAqWXRY5gnIvTD/rPCVClM4/ctORTZ/ieUWXI=;
	b=ifiKMuH3IkfzkHmgZkbwYhO8YwvxXEWm9Oi15VBzWc7b5JxznxaFqc5i6ucaTE2tTYWS
	 ihTPsAkY93zl8NmTaS2tsgvy8mgTFe5QvfMZM1mMGII7ypoygTluCJR2ZTCTch0OdG9OA
	 oYSvnRxyLTpI00hD43GW96D0/ec2hH1AghaVfgNGUU/OGZ53wctfiNvwCkP+1IUHsv9Qw
	 WefYybvk0i0xYhor2SFtkwPh+AVlE67EbxYjqPATVz1t53DKYxl1Zy/a5gYbZ+n+uWfRa
	 j+5v7j+c0cf+leuYqxFHXnl57ikRa+nm3FlZSZPGu2IVHv0mYs2zweFXAFrTY1Tschw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyzEjvbW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F82606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eyzEjvbW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECF51F01816;
	Thu, 29 Oct 2026 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309526;
	bh=o1xzL/rAqWXRY5gnIvTD/rPCVClM4/ctORTZ/ieUWXI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eyzEjvbW13wnkz+hwgSZtM9Exijr6eM27IGaTFcjDkhk+H0ctWM6Mbo9iRXUbpHCn
	 aIvDL1OilEfbf5nJU3GEcOUyL8Y270ej0cIeNwhTr+tcZFdBH2KQc2Ah0cWPq1KEeh
	 M5qi/C0DetGNNhqUPhUqcI/SROThM+iZDjIDo2sbGzGHgyzMMHCA8KlMmtJEMQj0Mb
	 H1cpoyatoLL8JmY3SV8FfnMWRCly8zmhvry6fDQXh891NorJG/dyO1AgVkk439VEiY
	 iPIEEVCdJxTdGkggYpwnCBBQtxBCc4Wuih647gQwHIIpHZXszHFubrkOaCFiyZt66x
	 mJkS1yPRwcQQQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:48 +0100
Subject: [PATCH mptcp-net v4 3/8] mptcp: pm: userspace: ID0 is not part of
 local_addr_used
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-3-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MJF5UucRTSbdz1A4jWZ4kEervi6VoRbLTIqZ4JN4ZAA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7/b/4KCXsHh5hM5Tk9PBexduPmuumcD7Z/8q5eO/v
 6Xezlc/01HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR9dwM/+O73O/P3m32/pjN
 fY6GkG75w8wGv5W2nVu6RXXjVu6tDu4M/4x9JJ5/28trtSva7d12wSPtC5uFJX1XTJe4HNwiEPi
 6hxUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The PM's local_addr_used counter doesn't take into account the ID0,
similar to what is done with the in-kernel PM.

When deleting a local address, only decrement the counter if it is not
linked to the (initial) ID0. Similarly, do not increment it when
re-adding the exact same entry.

Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
sashiko: check the next patches before pointing at existing issues.
v3:
 - split from patch 1.
 - do the same check when incrementing it to avoid a "leak". (Sashiko)
 - use a new dedicated helper, clearer.
v4: move to one line when declaring is_init_id0. (Geliang)
---
 net/mptcp/pm_userspace.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 68a02b15a4c5..74969b86fb81 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -27,6 +27,11 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static bool is_init_id0(struct mptcp_pm_addr_entry *entry)
+{
+	return entry->addr.id == 0 && entry->addr.port == 0;
+}
+
 static struct mptcp_pm_addr_entry *
 mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
@@ -99,7 +104,9 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		e->addr.id = id;
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
-		msk->pm.local_addr_used++;
+		/* Just to avoid this counter not to decrease when deleted */
+		if (!is_init_id0(e))
+			msk->pm.local_addr_used++;
 		ret = e->addr.id;
 	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
@@ -125,12 +132,15 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	if (!entry)
 		return -EINVAL;
 
+	/* The initial address ID doesn't increment local_addr_used */
+	if (!is_init_id0(entry))
+		msk->pm.local_addr_used--;
+
 	/* TODO: a refcount is needed because the entry can
 	 * be used multiple times (e.g. fullmesh mode).
 	 */
 	list_del_rcu(&entry->list);
 	sock_kfree_s(sk, entry, sizeof(*entry));
-	msk->pm.local_addr_used--;
 	return 0;
 }
 

-- 
2.55.0

