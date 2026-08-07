Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9B363096
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092123; cv=none; b=Ibj0Z/XoVl8/wIwE1j6Pmem8kdnjOkOHRIYhhkouJQMf4fN2jnQE1i3L0hElYnfgqZwfOeSMXOnl8mYWUtU+yCZFn8lW6CB3ACe2CuL4fgtbZjk6U4uReieV2nBzzL9jZs85t7dsKKRSx9M3RfxwOzPcXuoBoCpPmrsAnAt6YPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092123; c=relaxed/simple;
	bh=pQRKBO7A/N+F2nFGDi5tNgHJt/0ea1X9mQal4EWMTBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MRAYzRdo2eE3JAlHpjTO5dplEMI3RwenKy1k7gNsSkDcJgXXvt0EH2/ZQoRplrFMgtENANd9seAJLhl7Hj/SfhZ7PDAq2jXDrxDZVQci+pA7BXvyx4PKRH7AhhyZvctnBhiVKULVJNfPcqxQN8NkbZCgwplTqKIOXXIyS3ANnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm4L+xxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm4L+xxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82CA1F00A3A;
	Fri,  7 Aug 2026 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092121;
	bh=MiTeTHzLoDbaeuTuvLx3IvmYwFOyKJk+OfMJdJYxmOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Wm4L+xxq/TYn+XJ5driUJa+DVcuhB5Yrt+NP0FTv8yZIIGVJrFbNtIJdki8z4yEW6
	 PlGT3+nn+kJol6DjjHGHMnMEFpmhtbDZj+a8UYJr7efIzm0O2EpahtM8AF/YtybriD
	 QhTA3aZqdkL+brUqkO2K6OuEJmNpYw+cWvqMCkweMsNNyVn7jyti1xd2je58DgaFwH
	 u36ZlaqXrhB8iH73ZRU3/8r/hFMPGczzvO/3fyCqIPKKGzHh/dCKLNdf4ayTE+JZQx
	 6GWFygzwXYCxbi19DtxpnLO8e/JkTqfJivIWvaKnVDFJLqAA4Jk9X7IWgg1AQvx4HS
	 xAcwh5UKpYAxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:48 +0200
Subject: [PATCH mptcp-net v3 1/8] mptcp: pm: userspace: properly handle the
 ID0 case
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-1-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4305; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pQRKBO7A/N+F2nFGDi5tNgHJt/0ea1X9mQal4EWMTBw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZwV65YeEhD/mec6ndCV9+dQZ5Qe3XWq5ZeDwn+e+u
 +XUcPnjHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5e5fhf1z829cT7Fe2OBid
 W/cgWPPUw8uN5+VeHg18qXBNQj/jxwlGhhUz5QwuLDvlqiAj8nPlwdm/T2yezSs6L//GKquAhHW
 2BUwA
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
v2:
 - List new exceptions in the commit message.
 - Handle local_addr_used with the ID0 case properly. (Sashiko)
 - Handle needs_id where the addrs don't match, but the IDs (0) does. (S)
v3:
 - Split local_addr_used case: that's fixing another commit.
 - Set port to 0 (msk) instead of adding exceptions in lookups.
---
 net/mptcp/pm.c           |  4 ++++
 net/mptcp/pm_userspace.c | 20 ++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 25 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5e499ec1c50a..4ff12fe25d0b 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -551,6 +551,10 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 	pr_debug("msk=%p, token=%u side=%d\n", msk, READ_ONCE(msk->token), server_side);
 
 	WRITE_ONCE(pm->server_side, server_side);
+
+	if (mptcp_pm_is_userspace(msk))
+		mptcp_pm_userspace_created(msk, ssk);
+
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 102d6d12e0de..663cbeb79548 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -696,6 +696,26 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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
+	entry->addr.port = 0; /* msk port */
+
+	spin_lock_bh(&msk->pm.lock);
+	list_add_tail_rcu(&entry->list, &msk->pm.userspace_pm_local_addr_list);
+	/* The initial address ID doesn't increment local_addr_used */
+	spin_unlock_bh(&msk->pm.lock);
+}
+
 static struct mptcp_pm_ops mptcp_pm_userspace = {
 	.get_local_id		= mptcp_pm_userspace_get_local_id,
 	.get_priority		= mptcp_pm_userspace_get_priority,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 2f5b2f671c44..3e6d08b89476 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1238,6 +1238,7 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
+void mptcp_pm_userspace_created(struct mptcp_sock *msk, const struct sock *ssk);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);

-- 
2.53.0

