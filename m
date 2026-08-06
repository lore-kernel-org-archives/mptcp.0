Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C441BA97
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005995; cv=none; b=VJ9o/isngoXhvDH7ES8tm3U41ONXZhmtOmARmS8sPWM7S28326JDymunkJ3jckHhad7tlq6r8ANS6LpIZeGrMWA/J3u5S1PYvEo2BTc6iCCegzwmcx5hgecY1thwH1MR1ormO41/J0nmS89yC4voCir9FDHK10yYY1YIJ4R9/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005995; c=relaxed/simple;
	bh=w3VL+06PFXtlzaaJUTYcXQoVH6sazoOUcH/vdi6VwUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T1MR611fBOZlcTmq5LpQSTUsGfNFk+d0+VcxOPyNx6FFxi6dlyORx0zqgMg5fjwEgww4mm3xtr4rPSRqQGJtqjgLfJZN8pVFl2fumjT+5vMVOwidLFXVWHzFMWu4GB1wxgb3k2aiz5ZuTds+u80p8XR72rFqpIEwpF13eTWgUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDId5D7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDId5D7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234DE1F00A3A;
	Thu,  6 Aug 2026 08:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786005992;
	bh=Ykg/MN484lmK5vyBTCgl2AzeDbhvxxHSS8iNw+9RwjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cDId5D7dBRCBKXi0Y+Sqx++A5vwyer4rl5CdiNAnPzYu4Sv7kcMRcG4BK7fnXSMCi
	 +QnjLP3vf21KbwQnNC+xSdZEKx0WtqkrYpxJYi/EO2evvHW84LiRaBL5UtMp4+rkf6
	 p4/i/E/aCn+FB/TZzeUkKDiqUv7cqeBomvDx6y9u1OjJeEo+TeVDmBcJsPCaxCGkQi
	 Y9CoVbtlAeQ1aZAkMMIhT4AwkNgKbBit7f3r6TRafddioMxEzAsXWLEH20DaLUC3Rm
	 tOekHEN9WjMCw7V8ayvpoxgt5K1O6yhVF2vPUeo+oe5bJE2pYn1Xa7oY2l2DD9NwCs
	 g8ot68TVsnn9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Aug 2026 10:46:18 +0200
Subject: [PATCH mptcp-net v2 1/6] mptcp: pm: userspace: properly handle the
 ID0 case
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mptcp-pm-userspace-id0-case-v2-1-fea1808e1c57@kernel.org>
References: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
In-Reply-To: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6412; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=w3VL+06PFXtlzaaJUTYcXQoVH6sazoOUcH/vdi6VwUc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKPB84GvHv0JlfV5kuHHNKzT2m52BiRIVGcNLzJ4VWZ
 07Me6PUUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJGtHgz/cziC+rk/nctfve1W
 zYEeX+eYIP1JC9+u03saHJ8y30v7CsN/lzeXvtx1zvb/+EQxZvv7fcs9D5cbN5+Y3nR67ks/58n
 X+QE=
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

Three new small ones are required:

- To match the ID0 entry when the port is not specified: the initial
  port is used, like before.

- Not to match the ID0 entry when a new ID is required, and the address
  doesn't match.

- For the local_addr_used variable: this variable represents the number
  of extra addresses, not including the one linked to the initial
  subflow. The usage is similar to the one with the in-kernel PM.

In fact, the last two exceptions were also missing before when an entry
for the ID0 was present in the list, e.g. when a subflow from the same
address as the ID0 one was created.

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
---
 net/mptcp/pm.c           |  4 ++++
 net/mptcp/pm_userspace.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h     |  1 +
 3 files changed, 45 insertions(+), 5 deletions(-)

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
index 102d6d12e0de..b15f8908d503 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,10 +59,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		goto append_err;
 	}
 	mptcp_for_each_userspace_pm_addr(msk, e) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0 && needs_id)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
+		/* allow matching ID0 when no port is specified */
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr,
+						   e->addr.id != 0 ||
+						   entry->addr.port != 0);
+		if (entry->addr.id == 0 && needs_id) {
+			/* If ID needed, only match ID0 if addr match */
+			if (addr_match) {
+				entry->addr.id = e->addr.id;
+				id_match = true;
+			}
+		} else {
+			id_match = (e->addr.id == entry->addr.id);
+		}
 		if (addr_match || id_match)
 			break;
 		__set_bit(e->addr.id, id_bitmap);
@@ -104,17 +113,24 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	bool init_id0;
 
 	entry = mptcp_userspace_pm_lookup_addr(msk, &addr->addr);
 	if (!entry)
 		return -EINVAL;
 
+	/* The initial address ID doesn't increment local_addr_used */
+	init_id0 = entry->addr.id == 0 && entry->addr.port == 0;
+
 	/* TODO: a refcount is needed because the entry can
 	 * be used multiple times (e.g. fullmesh mode).
 	 */
 	list_del_rcu(&entry->list);
 	sock_kfree_s(sk, entry, sizeof(*entry));
-	msk->pm.local_addr_used--;
+
+	if (!init_id0)
+		msk->pm.local_addr_used--;
+
 	return 0;
 }
 
@@ -696,6 +712,25 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
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

