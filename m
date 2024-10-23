Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAD18953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676435; cv=none; b=blG1T3qphyPcgasYaxJutb0Mmnm2fP2kIqFVf/CpvcfzBNOH0KwJuj3BC666YEs3ArW2RQEGMWHRLrfMEl1g3nc2MSfsDBA2P+sArBP1f7t8cvdRY8TNbT5NpWnBVQLNsACkeRDu7JXuC/A5NvY6JfVz2Ht5Bx5sJimqek8X7qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676435; c=relaxed/simple;
	bh=7QjwmySbNnrWKYeba8wvxYopSKW9+212Gx9lZ73qJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV4Z//t6LobxR+xkmHMWJ/3Lb7ZdwnTiN91e4lrCql7kTmA2y3d+uTIp5Qhnq3bSgJqLCG7wClH6wMG/j/1vbgm89bUB4Y/L8nq9lPXoSKWUGd+a9l4z7GUpVAhqrQx/JZndqz7ljn+ZJaL5BYX6cT/okDDZ+L2mvvXwh3SnM4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByYDpmCS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByYDpmCS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E7C4CEC6;
	Wed, 23 Oct 2024 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676434;
	bh=7QjwmySbNnrWKYeba8wvxYopSKW9+212Gx9lZ73qJvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByYDpmCStUBZTtfncO+iyYAFfkR5xipyGAZ0u5LlM1wt42HsuYbmyDIpbw2PbMA4b
	 JvKAS78U3Rwk4tZDE/mObEAMTAbC4UpRRvq+v4Ooa796HBh1xpLURcVRX2i9laOoIr
	 iJnlyH0zEyvowXJUDx0k7GoipttYu0Tn9yt5YEIJM6JuHgRITZ+qenA8LRqmuEY+Ex
	 4AfVgPeK3lbRiV9Sjw7x7qfY5TIJ6rgJ3GEplA2iqsPJ1XV0/GU8toq93WMhkp6jsF
	 uicddZToV334uNqAPFk7Th4rJmPt8aOxnCUcmUgn5Hvp6GWUw6QaKqFPAJxntxVvAW
	 f9GflcV7boMjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 02/13] mptcp: make mptcp_subflow_set_scheduled inline
Date: Wed, 23 Oct 2024 17:40:12 +0800
Message-ID: <9a923def3da410c97d08af04c42ca9863bd1f4db.1729676320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729676320.git.tanggeliang@kylinos.cn>
References: <cover.1729676320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Now mptcp_subflow_set_scheduled is no longer used in BPF, but only in
kernel. A new mptcp_subflow_set_scheduled helper has been implemented
in BPF specifically for use with BPF. To avoid compilation errors due
to duplicate names, this function has been made inline in kernel and
moved to protocol.h.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 9 +++++++--
 net/mptcp/sched.c    | 6 ------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4c72a73594f..ab4e88b40efc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -750,13 +750,18 @@ void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
-void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
-				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
+static inline void
+mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
+			    bool scheduled)
+{
+	WRITE_ONCE(subflow->scheduled, scheduled);
+}
+
 static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->bytes_received) - READ_ONCE(msk->bytes_consumed);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6da60e35932f..73a24b9c96ff 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -135,12 +135,6 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
 
-void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
-				 bool scheduled)
-{
-	WRITE_ONCE(subflow->scheduled, scheduled);
-}
-
 static void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 					  struct mptcp_sched_data *data)
 {
-- 
2.45.2

