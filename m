Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5474427FB3
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172932; cv=none; b=iXQ6bY+GYaf+BK+G4W3y/cIe6ADwL8akXx9K0/kvY6m5h2+YOOsVaQ0BXKIVxtch9B2frOYWvK0YZ7EILFumFuE5Mifist/Lms0wKHGVc4w+JTQgyWzhZdtegqAEcgN6PJz5PhUJYTkraquunrv91OniBbNRGZ8LAQaMO8xiMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172932; c=relaxed/simple;
	bh=NVrf8jHNtA9y/hbHfmk9WChvN4+t6mG9LKED9lZgBz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gtunc8V4FQhkptRzwaDhrGNzgNCtp5GXIWuUBTHRZrdl4EmoAHHyXwVpxG+/4nG23XfMRv3A6xzvaIKFgbtBh1VQP57QkdDrA4DOIhmEjrMXaqhcWnvB/GwLUGaR+K4XKGRtenaAPEvw7qDunwt6RC+xvTemKQjfV83s8Iuxpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uv68jj/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uv68jj/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FB01F00A3D;
	Mon, 27 Jul 2026 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172930;
	bh=HxZM1f1cz1OQVFwy8cdF8E3WzPVsGgFIHkbj8N1R5KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Uv68jj/4NUo3Ex6BPVGxH7qIR83uCeQqygC4MgfSqYz+boYDNGZbU/lceHB4zm5ry
	 SyobNdlGkm03tZOKBTzhB5WWhil9Agra6XreLObWDsZd5xemsXTdBVIQyLljKUyPxp
	 KEW3CPuCTxF6TQ2y0h8e4QZEN7GkRWOyLgkfqdRw6U/U6deUiidLxoYG/WePewCT9o
	 bQdlKoQYadJwvcGYyMx69DEgu8MIrXdcGIwfu+xpLsEm6gVf0MHJ5akc7jO/UNNGtz
	 ib2VcpDeZ8vj3f2fl7guYt1Wr/aUJhvwhwjeaeS33NPmwE5UifhxlxqOouhj55ThnP
	 TA8m2BTe4yyyg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jul 2026 19:21:50 +0200
Subject: [PATCH mptcp-net 1/6] mptcp: pm: userspace: properly handle the
 ID0 case
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-1-9877f02a9bae@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4414; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NVrf8jHNtA9y/hbHfmk9WChvN4+t6mG9LKED9lZgBz4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJ2//u477fdFbp2CrOKUtfJ5WnfF8xgvO/9k+3y9l1
 h6pqRx9HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5GM3IsK2htz51+dzH3KeU
 v7SrPXJYIRJv82xLZj1fzR6u2cm3dRkZ1rg2MVxd+fzQ4/DTnH28te8io/mz3vUuesXh5eol0m7
 JDgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In MPTCP, the local address and port used by the initial subflow has the
ID "0". It means that when this address and port are used for some
operations -- e.g. creating a new subflow -- they should be linked to
the ID0, and no other addresses and ports can get this special ID while
the initial IP address and port is used.

So far, the ID0 case was handled as an exception: each operation dealing
with the ID0 had to be handled differently. Except that this was done in
some places like removing the ID0, but not everywhere the list of local
addresses was iterated. This way of handling the ID0 is prone to bugs
and harder to maintain. Instead, the initial local address corresponding
to ID0 can be added to the list when a connection is created, and the
number of exceptions can be dramatically reduced, handling this case
like any others with existing local address. The existing exceptions are
going to be removed in the following patches.

The main downside of this is that each connection will now have one
allocated entry added the list, possibly one more than before. But that
seems OK to do that with the userspace PM where the path management is
done per connection, with many Netlink messages sent back and forth.
Adding a few more bytes per connections on such setup seems acceptable.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           |  4 ++++
 net/mptcp/pm_userspace.c | 23 ++++++++++++++++++++++-
 net/mptcp/protocol.h     |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 05e29ce18b26..8421048f1a20 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -548,6 +548,10 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 	pr_debug("msk=%p, token=%u side=%d\n", msk, READ_ONCE(msk->token), server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
+
+	if (mptcp_pm_is_userspace(msk))
+		mptcp_pm_userspace_created(msk, ssk);
+
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 73094bdbdbf2..6e6eeda91ade 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -55,7 +55,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	mptcp_for_each_userspace_pm_addr(msk, e) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		/* allow matching ID0 when no port is specified */
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr,
+						   e->addr.id != 0 ||
+						   entry->addr.port != 0);
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -692,6 +695,24 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	return ret;
 }
 
+/* Add the initial local address (ID0) to the local list: easier that way */
+void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	entry = sock_kmalloc((struct sock *)msk, sizeof(*entry), GFP_ATOMIC);
+	/* Fine not to handle the ID0 case in memory pressure */
+	if (!entry)
+		return;
+
+	memset(entry, 0, sizeof(*entry));
+	mptcp_local_address((struct sock_common *)ssk, &entry->addr);
+
+	spin_lock_bh(&msk->pm.lock);
+	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static void mptcp_pm_userspace_release(struct mptcp_sock *msk)
 {
 	mptcp_userspace_pm_free_local_addr_list(msk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index da40c6f3705f..087367cdd307 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1236,6 +1236,7 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);

-- 
2.53.0

