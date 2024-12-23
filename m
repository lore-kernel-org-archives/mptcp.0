Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77633D561
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734948369; cv=none; b=hyVX2qe0odyB5WT5xfjv2NMuTT0F5tyEoX5oVWMZnlWq+kUGxIEyM+bkbqaQWs7WgzTEfg9FhxqlWH+t7wQ7KXqjffwK3ttD4FKTbvQr8Ai5InA7Bn4M+JvX4mqbbDd4MSZju1rnxCIJCddTHA+fvSkRuYuCU6L7ezN7r8CTDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734948369; c=relaxed/simple;
	bh=GUC6UPVEwg82H1HmUxNgqQYuhTbvqxd2UsBllTVVQOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWLmkNJYqRZaHQXeLc486CMfr+vP7YDoMo/QlrVdO9sE4owfhEgvbGAKlwZ66aSo90BsSyg6+9yU2Ff+LunzmnkI6jxDfAe7Dw2wYbNnjJ7U+0Bg+bNoxj8BQ6lIEDriw1aIepK25q/QQzeNUd4bdBQFYHq/S2PHL3d/MXWBhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRiHqvLV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRiHqvLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F27FC4CED3;
	Mon, 23 Dec 2024 10:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734948369;
	bh=GUC6UPVEwg82H1HmUxNgqQYuhTbvqxd2UsBllTVVQOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRiHqvLVY0pr0D85d6Rwyoyrj9sARmsBJW8Y7XmfATMSbDohBqMqkhw2ZTQ8elV3t
	 ty/k639tsB/tbT7Z9gO3p7+s3E+ePw8n95dE6I8ukMW/oxysqYyy42P79VBrZI6/mL
	 KWHpBFyQZULzycJYWFkogEdEimi6blY85eb0kXPOyfbC++dutXaKA04KSUOGfEvz2Z
	 Ze3wZsSKln8xOfDGw9HlNETvD7khBepPk7YNBKZL6GdFYdcjx5NEC6vkdhOAiOKlA4
	 cLNy+PQSOtTfwChzd2ukOBskjfzQCXfpguT0OG+Bw23XsB/F2SRlQrcGCCq0ds/miQ
	 Jd0L1Lnv5++lQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v12 03/10] mptcp: drop struct mptcp_sched_data
Date: Mon, 23 Dec 2024 18:05:45 +0800
Message-ID: <96d9e097dcdea76f2a86946287de452f0694035b.1734947922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734947922.git.tanggeliang@kylinos.cn>
References: <cover.1734947922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The mptcp_subflow bpf_iter is added now, it's better to use the helper
bpf_for_each(mptcp_subflow) to traverse all subflows on the conn_list of
an MPTCP socket and then call kfunc to modify the fields of each subflow
in the WIP MPTCP BPF packet scheduler examples, instead of converting them
to a fixed array. With this helper, we can get rid of this subflow array
"contexts" and the size of it "subflows" in struct mptcp_sched_data. Then
the entire struct mptcp_sched_data can be dropped.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 13 ++-----------
 net/mptcp/sched.c   | 18 +++++++-----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 72d6e6597add..5fc0187a3669 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -100,18 +100,9 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_MAX		128
 #define MPTCP_SCHED_BUF_MAX	(MPTCP_SCHED_NAME_MAX * MPTCP_SCHED_MAX)
 
-#define MPTCP_SUBFLOWS_MAX	8
-
-struct mptcp_sched_data {
-	u8	subflows;
-	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
-};
-
 struct mptcp_sched_ops {
-	int (*get_send)(struct mptcp_sock *msk,
-			struct mptcp_sched_data *data);
-	int (*get_retrans)(struct mptcp_sock *msk,
-			   struct mptcp_sched_data *data);
+	int (*get_send)(struct mptcp_sock *msk);
+	int (*get_retrans)(struct mptcp_sock *msk);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5d6c0582c473..c84303202449 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,8 +16,7 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
-static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
-					struct mptcp_sched_data *data)
+static int mptcp_sched_default_get_send(struct mptcp_sock *msk)
 {
 	struct sock *ssk;
 
@@ -29,8 +28,7 @@ static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
 	return 0;
 }
 
-static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk,
-					   struct mptcp_sched_data *data)
+static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *ssk;
 
@@ -157,7 +155,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -178,14 +175,13 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk, &data);
-	return msk->sched->get_send(msk, &data);
+		return mptcp_sched_default_get_send(msk);
+	return msk->sched->get_send(msk);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -199,8 +195,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk, &data);
+		return mptcp_sched_default_get_retrans(msk);
 	if (!msk->sched->get_retrans)
-		return msk->sched->get_send(msk, &data);
-	return msk->sched->get_retrans(msk, &data);
+		return msk->sched->get_send(msk);
+	return msk->sched->get_retrans(msk);
 }
-- 
2.45.2

