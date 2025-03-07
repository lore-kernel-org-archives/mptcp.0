Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573F20764E
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347421; cv=none; b=tOchXY4B6G5dFwXceA5fqdasHVMPvNx0hX99Az8LQ+deuGslNuwgy6e6zWeItgGjdH2+bjb83H7Z5h8yyBU5Jr+Xdt4I8CnqI2OrTyrxDItu8acg/q54F72lM6Z7+jwC4gc2jZACrH2MPAfoqiX001xG8fvHePJdaBYAONZcsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347421; c=relaxed/simple;
	bh=qtm12duyYEtXIEeOzHi1drQznTkTzUvWb4H6rcxQYEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwbNLva6FNcYQEO+Vvl7R3vIhvVKQ2zw9NdKIJiAY3LTLVM0rjBPxVNwHORI/AzmQJV3/pLXOhQLgyokHCc2Zo3G+E3ZgMSkOMEA8BtZiHM1fa45MbnJqlMus6jAQm/1A8073gEoB9nEsZHyCnSUOAb2PX4j6b72pOJbhsYlCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCsikcS1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCsikcS1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7462C4CEE5;
	Fri,  7 Mar 2025 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347421;
	bh=qtm12duyYEtXIEeOzHi1drQznTkTzUvWb4H6rcxQYEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZCsikcS1hShMrzBaCizblO2JZYXg+ixVfv/+NBcalukArok/WOU8xC9mJBFdEUVy+
	 MEcxY7P9gTTszrSX5urOk1tW5d+M9Iu6SjevuSJ1Ijn8BLy6YEDHuePzDiKP3k97Q/
	 0LRcmm6XUpl81+4bGDjfFF3iqo4W49dMncmLvMOZESaLq+d32juKni86zsjG9Tu6c8
	 6jdEv3NWsuxYNk6QdSO3zvk7bD9NiZpeNzpKY5sCiCncFQ0ACqQtk9CMgDL5Lpfe2u
	 5bhlwZ8gsZyDebT3RJ4GDfT+uKwoiSQZaUa6p+y0dYEa55FfZ7T2JewulSkqYz9P+2
	 dK7n5y1CeI8sw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 01/11] Revert "mptcp: sched: remove mptcp_sched_data"
Date: Fri,  7 Mar 2025 19:36:42 +0800
Message-ID: <9a414d874ffc0dfc9849513c3faf293b13ddeaf0.1741347233.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741347233.git.tanggeliang@kylinos.cn>
References: <cover.1741347233.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Keep mptcp scheduler API unchanged.
Add back struct mptcp_sched_data.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 13 +++++++++++--
 net/mptcp/sched.c   | 18 +++++++++++-------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index e9832a8f981e..2c85ca92bb1c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,9 +100,18 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_MAX		128
 #define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
 
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_sched_data {
+	u8	subflows;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
+};
+
 struct mptcp_sched_ops {
-	int (*get_send)(struct mptcp_sock *msk);
-	int (*get_retrans)(struct mptcp_sock *msk);
+	int (*get_send)(struct mptcp_sock *msk,
+			struct mptcp_sched_data *data);
+	int (*get_retrans)(struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f09f7eb1d63f..c16c6fbd4ba2 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,7 +16,8 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
-static int mptcp_sched_default_get_send(struct mptcp_sock *msk)
+static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
+					struct mptcp_sched_data *data)
 {
 	struct sock *ssk;
 
@@ -28,7 +29,8 @@ static int mptcp_sched_default_get_send(struct mptcp_sock *msk)
 	return 0;
 }
 
-static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk)
+static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
 {
 	struct sock *ssk;
 
@@ -155,6 +157,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -175,13 +178,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk);
-	return msk->sched->get_send(msk);
+		return mptcp_sched_default_get_send(msk, data);
+	return msk->sched->get_send(msk, data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data *data = NULL;
 
 	msk_owned_by_me(msk);
 
@@ -195,8 +199,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk);
+		return mptcp_sched_default_get_retrans(msk, data);
 	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk);
-	return msk->sched->get_send(msk);
+		return msk->sched->get_retrans(msk, data);
+	return msk->sched->get_send(msk, data);
 }
-- 
2.43.0

