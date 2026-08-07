Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D8363096
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092125; cv=none; b=HBqsL/Xb+qsLM3QW1izAIglJ0IJ/6udtwF1pD1oRy7h/OlEdFpLXROF5OzsrCJaabvv2Gpwk8uZ/GZHKTlnjMjDpsE6iZ0tpe5TMhomqH4o4EdaHIgobwtKd5MDSEmDGfIbptbuIV62nACCLED1kEbS/2rMQ2EaCuLdZJfC5vb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092125; c=relaxed/simple;
	bh=Iw0J80hmMVIXVDH9gSMCsfAx5zDQWfkb7qWoVUxe5+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdaFEJLmKlzGDTlHjqjORv2+eL+X1LBYICcu6AdMwWpZcJj1Dl3UtbtJS7zDaqh6Suk1fYtpAhlsCxXVRhmzY5oVlCtsUI5aPY4vauyzUNcTbC3FVOkE3TislF3qdtXDeKwsrYx7KtkPpbMKUeXvK1Tbkn3z7tsFIUnouDPmHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BurYvFYp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BurYvFYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0D21F000E9;
	Fri,  7 Aug 2026 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092122;
	bh=hk5zDGBo5xWN/u3H1NR9bT2AO5UFDkdvL373SmX+IpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BurYvFYpiKDFH2OlUeAB7BJNwZm57l9s5A2QEnX106MgoaZ+WUQMmx8ka7NugwzUZ
	 MciQSL1tfMxsY38LOJATMryxLVYL1CZX0JaJ91rvJEwAWGqJMxKmxFnW6oJ4gsUUUM
	 1bRzg8Hk9RT6aUyDqHlwFGXiJ8B5Xjj7lwpI50T5YmnqBAsjFU6zBZoKl0WZ4fFrhR
	 JXOHgfSmif46PujRM5x0EGf2dTSg7K+4VBwL78JBBUMh2AZr2vBrZ3FOsiF7jmZgIf
	 HvHimxlh5WfCc6VGK9DKXH3UR5iKH5WcDgNQKPi/ciKxsW0eKBIazdlkE3lo1OiPLS
	 r4Ptct2kKnOtw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:50 +0200
Subject: [PATCH mptcp-net v3 3/8] mptcp: pm: userspace: ID0 is not part of
 local_addr_used
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-3-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Iw0J80hmMVIXVDH9gSMCsfAx5zDQWfkb7qWoVUxe5+o=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZwUH8e5yf/rrn07OocvBt/ZKrmbl4nyxef+zWRLnb
 FPeaee2dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkYB3DPyXnHVx1Jwx3hNxf
 zvHh16XS9Wu/NE3qSl2mw73VfopLcQ7D/2C9kx8kWzbV6vZdvf70t0e0cFaahkZk0+UbH+bMtHf
 XYgAA
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
v3:
 - split from patch 1.
 - do the same check when incrementing it to avoid a "leak". (Sashiko)
 - use a new dedicated helper, clearer.
---
 net/mptcp/pm_userspace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3f1471ec3fc7..27fed3519d39 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -27,6 +27,12 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static bool
+is_init_id0(struct mptcp_pm_addr_entry *entry)
+{
+	return entry->addr.id == 0 && entry->addr.port == 0;
+}
+
 static struct mptcp_pm_addr_entry *
 mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
 			       const struct mptcp_addr_info *addr)
@@ -95,7 +101,9 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
-		msk->pm.local_addr_used++;
+		/* Just to avoid this counter not to decrease when deleted */
+		if (!is_init_id0(e))
+			msk->pm.local_addr_used++;
 		ret = e->addr.id;
 	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
@@ -121,12 +129,15 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
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
2.53.0

