Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23891DB148
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020272; cv=none; b=VCs3smcTjhO/EOTfp9od67sU3DCopMu0uSTqsypP/BQ8zrkgGgjF/shWBBiRtDql8YuGNrGOSS0x6M+i8vsvvpCN5IswDN/QpRd7nyAswnkkd5HzRITP6p5hDMca/VXfvXmwv9I0EHfDA6BJtKKBuWLMUvETAHpoorCreAuuUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020272; c=relaxed/simple;
	bh=Y6xIYwqk3FgDyG02TrhdxWf39xpI957l/g7Fvj17daA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsrtiDowErby7AYDV1n5Uc31uPo3gvBGTMTwMIS7xiaAxnDPXkTHtGbQrAzOSWfWaz8BALJB9AoMRkoy+7osYTViknCe+miuVbs6hH/PVuyeKfGwN+4QB1vpEncPl0KhNtlOF3HvND3TBYXNulFHWvTXAg24uK0NX0/R8XQ9ISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIz8YJRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIz8YJRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0F7C4CED6;
	Thu, 20 Feb 2025 02:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020272;
	bh=Y6xIYwqk3FgDyG02TrhdxWf39xpI957l/g7Fvj17daA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PIz8YJRLgYZwD/nTQ6QWHTWmIq+gSIDMbyDt34kiEcQCnb5SqXx1njR9uUsQqou5W
	 xnrb89YvhEuH77GCs5dbHqpinYoUEyBBN1kFcr+9ZfyZbmAK3vY1P3a++MV6HS44oI
	 urC8r4qgPVzY+/w6vnrNShveKH0+zKZLDuGg9fV3xs5TWpGXKThfF0XLQYI7T/4Mvl
	 1OyNt8hyK12usSuJ8HZF31ECH4N49IctyvWryBSIe1i2it+DdiBJNy7waciUkMThp7
	 lNn7ug9Q5PRNMuPSwiw+9POsOhBshjJyA5yxG49y2rspixuUobZ47OTZe8ZgDErzp6
	 jPlnbbMfYv5vg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 8/9] mptcp: pm: drop get_local_id helpers
Date: Thu, 20 Feb 2025 10:57:32 +0800
Message-ID: <69747874cdc72593caadf51725cf8835bc45661b.1740019794.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740019794.git.tanggeliang@kylinos.cn>
References: <cover.1740019794.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now mptcp_pm_nl_get_local_id() and mptcp_userspace_pm_get_local_id()
helpers can be dropped, and mptcp_pm_get_local_id() can directly invoke
get_local_id() interface through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 6 +++---
 net/mptcp/pm_netlink.c   | 4 ++--
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 4 ----
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9d42aed440a0..d2cc93e21bee 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -438,10 +438,10 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	skc_local.addr.id = 0;
 	skc_local.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
+	if (!msk->pm.ops || !msk->pm.ops->get_local_id)
+		return -ENOTSUPP;
 	mptcp_pm_param_set_contexts(&param, &skc_local, NULL);
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_local_id(msk, &param);
-	return mptcp_pm_nl_get_local_id(msk, &param);
+	return msk->pm.ops->get_local_id(msk, &param);
 }
 
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e0f8754e261e..33b19ff7a313 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1139,8 +1139,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	return err;
 }
 
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_param *param)
+static int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
+				    struct mptcp_pm_param *param)
 {
 	struct mptcp_pm_addr_entry *skc = &param->entry;
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6e51335c8bc1..b233d8469a48 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -130,8 +130,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_param *param)
+static int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
+					   struct mptcp_pm_param *param)
 {
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cddb919fc120..d06add105df5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1129,10 +1129,6 @@ void mptcp_pm_param_set_contexts(struct mptcp_pm_param *param,
 				 const struct mptcp_pm_addr_entry *entry,
 				 const struct mptcp_addr_info *addr);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
-			     struct mptcp_pm_param *param);
-int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
-				    struct mptcp_pm_param *param);
 bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
-- 
2.43.0

