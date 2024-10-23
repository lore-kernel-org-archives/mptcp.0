Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E818953D
	for <mptcp@lists.linux.dev>; Wed, 23 Oct 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676436; cv=none; b=giFCwt6JwZwFDNVYu9hKiQgsrccsPchhDXR+M5RQIg4dgbYTZlrGSrjTVIntEhPPpk+am9EAc45Hcf8DsCH1b0KT994nBTVRiUfILEjw7X15rVQk2WFWppND0SXirqHz72PD70v9dsy+4UvQlGUid8blRldkHjHwVxp5a8AVQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676436; c=relaxed/simple;
	bh=Noo+9IDt1f2aQe6unlkVcJwLsr3XofXTxLxDAt0rp3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jartj/LHjD2BIwoG20mOkGAp+Pc2mzjqxaQObl1SXDgIicEt1vMGCgYKflAZwzHLxSXAUTZsm6lR3DHig/82CG4a2MF7jCS59QBWXHDylL8sBwilybwLhD0dK8i4YyVPa+3C0iE/BULGYwrV8yaymjyXFFa7XW9ypRF4LCE0Fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRqOaDGk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRqOaDGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD37C4CEC6;
	Wed, 23 Oct 2024 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729676436;
	bh=Noo+9IDt1f2aQe6unlkVcJwLsr3XofXTxLxDAt0rp3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sRqOaDGkeH/g8uXjir5HIUBkvsF03GR0++igklzbwfC3SxdeLuwqOIBUBOCuMokO+
	 4LqOv4jplqK+/5Xvs7X0TWwLqjNHkxEkMK1boeODnUPgTnB6qXqdx78WpyR2PqxF0N
	 uXI8Cy5EH0sUgIA6xp/gRTRmQAr+w15iwsaOhu06GGw+c9ENwbYLAk1vsG/RDWEQjM
	 JcZ44CMoSu9cYRdr8AeEXz8HXmHWACp7EWTLXtb86bzFfD847WW8BsJXxAg7vzkJrc
	 CRZQqTevkD06BUay0BJ/xFhjZm8HpDoFDHWIFZ+kmPMT9K45EqP5Ln7NKSCni5ufCB
	 8P7v8EIxgK0YQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 03/13] mptcp: add mptcp_validate_scheduler helper
Date: Wed, 23 Oct 2024 17:40:13 +0800
Message-ID: <9b98ae2d97757792f42a4d4f660c07dc509b2c00.1729676320.git.tanggeliang@kylinos.cn>
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

New interface .validate is added in bpf_struct_ops recently, implement
.validate as mptcp_validate_scheduler() for struct mptcp_sched_ops. In it
check whether the required ops "get_subflow" of struct mptcp_sched_ops
is implemented.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ab4e88b40efc..46bc7adb4763 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -744,6 +744,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_sched_init(void);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 73a24b9c96ff..d7be9c453488 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -71,10 +71,23 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	rcu_read_unlock();
 }
 
-int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->get_subflow) {
+		pr_err("%s does not implement required ops\n", sched->name);
 		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
+{
+	int ret;
+
+	ret = mptcp_validate_scheduler(sched);
+	if (ret)
+		return ret;
 
 	spin_lock(&mptcp_sched_list_lock);
 	if (mptcp_sched_find(sched->name)) {
-- 
2.45.2

