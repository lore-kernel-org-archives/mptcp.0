Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8123243D
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924520; cv=none; b=YGIi9NRGFYwox4a9m4I76RLjlFtgB7Rh7M1TS+JU7dZ3Vv7LbW00EP+WuGAfRvWChLVtalxd57sCgcRH3ByKF9BDBhVyUaGrN4tGkg3jnKmprvVSbPvkrnayR+vVaQZuNpc6UA+W4wu4XcZe3HatAo1hqSFIe0v43HTlQj9zN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924520; c=relaxed/simple;
	bh=p/cY8bi5/8Li20u+/3HfOi4iyUK6++jVt8KeFPy9WYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLa6sPkItADBKpq/GtI/Uiq0n+5ZjEluRdPSWeYfETvmXZq6RRHBtC/Q/uouJw0PdPWCc2HqYF/E41nyBUozXITZheaXIdl+6f90ZpkktUcI49r9+rx42Cnxv6z2oIHhAIxCH2VVSxuylAgf3FQQDgRzxDkDsqnjZBETZ0E30L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov79ekO1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov79ekO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6703C4CEDF;
	Wed, 15 Jan 2025 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924519;
	bh=p/cY8bi5/8Li20u+/3HfOi4iyUK6++jVt8KeFPy9WYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ov79ekO1b08ltZLuvhcNCivemfB6jg4xF8ULzV7C1P2Vkd8ZeDGzLpnV7o14YsXrj
	 AUkr0AlHvntQIiGUavndOxNbs8mfy7v6E6x7VA/A2WDsIotKm/rtdS84zHON4wBJMp
	 1nuxon6bRyJ8d5gKCHySBDXOWNqq3+R5ewp7mSRAY3GxJcjEzKznwRf95buBzn287/
	 vckSw78p5TzLfTDc+leZMe3iyas8+gJMxh/XqZH3/DAPgSpf9PD0w4ZO8O6y5uoItb
	 Qhp3XJnDazoKW+8A16JbPn9a9iMi3ULqfEF/c9XBukY6aqfGeEig/ixa/xV6ER5gUj
	 iTW4FDs/Qn0Bg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 7/7] mptcp: change is_backup interfaces as get_flags
Date: Wed, 15 Jan 2025 15:01:40 +0800
Message-ID: <95a0cce72e48504cffcb5050a90f2a93d4be5651.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

is_backup() interface of the path managers is not very common. A more
common approach is to add a get_flags() interface to obtain the flags
value of a given address. Then is_backup() can be implemented through
get_flags() by test whether backup flag is set in the flags value.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           |  7 +++++--
 net/mptcp/pm_netlink.c   |  9 +++++----
 net/mptcp/pm_userspace.c | 10 +++++-----
 net/mptcp/protocol.h     |  6 ++++--
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8d9acc984a36..a0f4d06692cc 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -429,13 +429,16 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 {
 	struct mptcp_addr_info skc_local;
+	u8 flags;
 
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
 
 	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_is_backup(msk, &skc_local);
+		flags = mptcp_userspace_pm_get_flags(msk, &skc_local);
+	else
+		flags = mptcp_pm_nl_get_flags(msk, &skc_local);
 
-	return mptcp_pm_nl_is_backup(msk, &skc_local);
+	return !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 }
 
 static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 16c901fabfa2..4be4214cad34 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1168,18 +1168,19 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 	return ret;
 }
 
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk,
+			 struct mptcp_addr_info *skc)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *entry;
-	bool backup;
+	u8 flags;
 
 	rcu_read_lock();
 	entry = __lookup_addr(pernet, skc);
-	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	flags = entry ? entry->flags : 0;
 	rcu_read_unlock();
 
-	return backup;
+	return flags;
 }
 
 #define MPTCP_PM_CMD_GRP_OFFSET       0
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4f3e742ee41b..a7b836309d2b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -149,18 +149,18 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	return mptcp_userspace_pm_append_new_local_addr(msk, local, true);
 }
 
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
-				  struct mptcp_addr_info *skc)
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc)
 {
 	struct mptcp_pm_addr_entry *entry;
-	bool backup;
+	u8 flags;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr(msk, skc);
-	backup = entry && !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	flags = entry ? entry->flags : 0;
 	spin_unlock_bh(&msk->pm.lock);
 
-	return backup;
+	return flags;
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 318b293d0be1..80a18877e47d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1134,8 +1134,10 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_pm_addr_entry *local);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
-bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+u8 mptcp_pm_nl_get_flags(struct mptcp_sock *msk,
+			 struct mptcp_addr_info *skc);
+u8 mptcp_userspace_pm_get_flags(struct mptcp_sock *msk,
+				struct mptcp_addr_info *skc);
 int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
 			  struct netlink_callback *cb);
 int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
-- 
2.43.0

