Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ED018C35A
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381509; cv=none; b=rQYji+bJvMmuf6FHR1Sh/Q+r74jyN7RnR5iB7rGjnDR24Dbrcwf9g0nYuLKav/QJGtrCNcX4mfhFNRHimYz/fQPPDlbbzWr9DVTbUUjjNoUBIJQe0EcGFdRXdIaRO07oKwBPm9lMk+fALGxMlF52oIdcA59JG0EcOevIS3Tns9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381509; c=relaxed/simple;
	bh=R9qQz8gVzEiiFKH6i0kZ/cTPVAulJS3GlM2is5ziP9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5Cm5WTkLj0aOeJSuhabmtehJaILwRpP7Q6rmAcEMsEdlG+8GvLsJvLF5tadwqpCed3VCngsyA5qnDeTxLX/VG00NPwtZWDrQyBOJ0zlieupjZTGz7FVFF4zitZEqfplDXRP6krj+r3JLE7C62ccPpTHGlolyx92uETPMvrV+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/Gw/azZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/Gw/azZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBFF5C4CEC7;
	Tue,  8 Oct 2024 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728381509;
	bh=R9qQz8gVzEiiFKH6i0kZ/cTPVAulJS3GlM2is5ziP9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/Gw/azZCmrQC+fjqcnAlFKYbj8y5QSJ2DzfXqhXyvjteppxo7UI6g5CfP0Qq30sR
	 IHJ54SoONkAu8J5knpxlHjVySUc7b2gf0xnAwXrgz/HQj+ViQVojJ1ajHn1VLZYSw5
	 SuBJx5dRafhWWP5JIqVEQfmGckYaRZ7fzvVvSgyzwTDo8avCA4jBtLNnqL7sazerF3
	 KXcJoJcM8Tz6yF4JAhzL5jZOwtK+2p/S3aOrfmipupucRDdJvRoHpv817/liUSYC5G
	 TsNZwIo2xr5XiKT5MjYg0kSS4A6kEYa9yNdypwLPY3YV/cOVE6gxTAu6KYDcIWusNr
	 W5ufOQ3Bl9oQw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 02/13] mptcp: add addr parameter for get_addr
Date: Tue,  8 Oct 2024 17:58:06 +0800
Message-ID: <e7da00a805f2b166f0899b954f34367b845bf662.1728381245.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728381245.git.tanggeliang@kylinos.cn>
References: <cover.1728381245.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The netlink messages are sent both in mptcp_pm_nl_get_addr() and
mptcp_userspace_pm_get_addr(), this makes the code somewhat repetitive.
This is because the netlink PM and userspace PM use different locks to
protect the address entry that needs to be sent via the netlink message.
The former uses pernet->lock, and the latter uses msk->pm.lock.

The current get_addr() flow looks like this:

	lock();
	entry = get_entry();
	send_nlmsg(entry);
	unlock();

After holding the lock, get the entry from the list, send the entry, and
finally release the lock.

This patch changes the process by getting the entry while holding the lock,
then making a copy of the entry so that the lock can be released. Finally,
the copy of the entry is sent without locking:

	lock();
	entry = get_entry();
	*copy = *entry;
	unlock();

	send_nlmsg(copy);

This way we can reuse this send_nlmsg() code between the netlink PM and
userspace PM.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 33 ++++++++++++++++++---------------
 net/mptcp/pm_userspace.c | 24 +++++++++++++-----------
 net/mptcp/protocol.h     |  3 ++-
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 076a11d52057..886fb7c1468d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1791,13 +1791,14 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
-static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry *entry;
 	struct sk_buff *msg;
+	int ret = -EINVAL;
 	void *reply;
-	int ret;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -1813,34 +1814,36 @@ static int mptcp_pm_nl_get_addr(u8 id, struct genl_info *info)
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr_by_id(pernet, id);
-	if (!entry) {
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	spin_unlock_bh(&pernet->lock);
+
+	if (ret) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+		goto fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
+	ret = mptcp_nl_fill_addr(msg, addr);
 	if (ret)
-		goto unlock_fail;
+		goto fail;
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&pernet->lock);
 	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&pernet->lock);
-
 fail:
 	nlmsg_free(msg);
 	return ret;
 }
 
-static int mptcp_pm_get_addr(u8 id, struct genl_info *info)
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, info);
-	return mptcp_pm_nl_get_addr(id, info);
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
 }
 
 int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1853,7 +1856,7 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		return ret;
 
-	ret = mptcp_pm_get_addr(addr.addr.id, info);
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
 	return ret;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index da617d8bcc09..5c9f740bd9ac 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -629,7 +629,8 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 	return ret;
 }
 
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
@@ -661,26 +662,27 @@ int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
-	if (!entry) {
+	if (entry) {
+		*addr = *entry;
+		ret = 0;
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	release_sock(sk);
+
+	if (ret) {
 		GENL_SET_ERR_MSG(info, "address not found");
-		ret = -EINVAL;
-		goto unlock_fail;
+		goto fail;
 	}
 
-	ret = mptcp_nl_fill_addr(msg, entry);
+	ret = mptcp_nl_fill_addr(msg, addr);
 	if (ret)
-		goto unlock_fail;
+		goto fail;
 
 	genlmsg_end(msg, reply);
 	ret = genlmsg_reply(msg, info);
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 	sock_put(sk);
 	return ret;
 
-unlock_fail:
-	spin_unlock_bh(&msk->pm.lock);
-	release_sock(sk);
 fail:
 	nlmsg_free(msg);
 out:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 07cb80be98cb..4342be369914 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1127,7 +1127,8 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
 				 struct netlink_callback *cb);
-int mptcp_userspace_pm_get_addr(u8 id, struct genl_info *info);
+int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+				struct genl_info *info);
 
 static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflow)
 {
-- 
2.43.0

