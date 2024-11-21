Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3A230998
	for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157157; cv=none; b=bD15ijc9L+l+hlk/Us4sBxMUceWtpAW0/5nXsZQElWfuEaQ16z9B9WUSBYS//LGHuTVJF8hnP5wqLw961c4sa5enKh/kSNIJuAcfJyJkE7iP0DeU4oQfJenXO7O/CoU1lqp1obgVlrTQtsfY4NDKobEqJ7lt42twsTS7fbFR+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157157; c=relaxed/simple;
	bh=G9iZystPsNcfAOCqxBnP/CMJaZbsw80HcpJNOP2iml8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhbIC12BdXalPoA8OJgp1GcSSPwsV7QjNawX/NkgQgNvpqyFEOcG6wF7zD+O183fg0GIVyEwxlmGy6gdjoeWYtHqLE5CXncGWzWpEZ+FZw39YQFkc6mvhYzHqk05mW2me6Cs3p6paLXpc2YAAinPrt9XRSXAjxdtNOJOViVWM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGVw67Rs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGVw67Rs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEF4C4CECD;
	Thu, 21 Nov 2024 02:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732157157;
	bh=G9iZystPsNcfAOCqxBnP/CMJaZbsw80HcpJNOP2iml8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGVw67Rsby2+gw3+8qxYlRKtOWXiKPpbTfhJLginSLLBWMYjK1zbfa4nAP33gBXFN
	 ITNd1lV/TQUTaaVGXygJSw364JyCoKdjKxCr4lE3PWhTaqYxfC7kvNmgMlGg7nIRCO
	 cRWP5SwfZRGBCnjr5HAqQkXskJvx8XYqYtsDpKWu/XDxqYdqrgMLMzgVpLqY1vy3pe
	 9W+sPDDy1QUjsVZOSVhp3qGgEzDXqtNuaMFXbyHyhqSOPeSPyzWS731z/rM+BG8ppZ
	 L32x7T1G3AHDYkW3CEQLp8du4u5oDA2GV1FFWYVtm64n3z3FnuYAoAb2H7mTtfnqGg
	 9ZsneS8N9AM6g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: baohua@kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/8] mptcp: split get_subflow interface into two
Date: Thu, 21 Nov 2024 10:45:40 +0800
Message-ID: <5887e174fc52db76e9ce6a4683a694a693f8567a.1732153672.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1732153672.git.tanggeliang@kylinos.cn>
References: <cover.1732153672.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

get_retrans() interface of the burst packet scheduler invokes a sleeping
function mptcp_pm_subflow_chk_stale(), which calls __lock_sock_fast().
So get_retrans() interface should be set with BPF_F_SLEEPABLE flag in
BPF. But get_send() interface of this scheduler can't be set with
BPF_F_SLEEPABLE flag since it's invoked in ack_update_msk() under mptcp
data lock.

So this patch has to split get_subflow() interface of packet scheduer into
two interfaces: get_send() and get_retrans(). Then we can set get_retrans()
interface alone with BPF_F_SLEEPABLE flag.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h |  5 +++--
 net/mptcp/bpf.c     | 11 +++++++++--
 net/mptcp/sched.c   | 33 ++++++++++++++++++++++-----------
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 814b5f2e3ed5..2c85ca92bb1c 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -103,13 +103,14 @@ struct mptcp_out_options {
 #define MPTCP_SUBFLOWS_MAX	8
 
 struct mptcp_sched_data {
-	bool	reinject;
 	u8	subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	int (*get_subflow)(struct mptcp_sock *msk,
+	int (*get_send)(struct mptcp_sock *msk,
+			struct mptcp_sched_data *data);
+	int (*get_retrans)(struct mptcp_sock *msk,
 			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e9db856972cb..ab1de189ba4b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -156,7 +156,13 @@ static int bpf_mptcp_sched_init(struct btf *btf)
 	return 0;
 }
 
-static int __bpf_mptcp_sched_get_subflow(struct mptcp_sock *msk,
+static int __bpf_mptcp_sched_get_send(struct mptcp_sock *msk,
+				      struct mptcp_sched_data *data)
+{
+	return 0;
+}
+
+static int __bpf_mptcp_sched_get_retrans(struct mptcp_sock *msk,
 					 struct mptcp_sched_data *data)
 {
 	return 0;
@@ -171,7 +177,8 @@ static void __bpf_mptcp_sched_release(struct mptcp_sock *msk)
 }
 
 static struct mptcp_sched_ops __bpf_mptcp_sched_ops = {
-	.get_subflow	= __bpf_mptcp_sched_get_subflow,
+	.get_send	= __bpf_mptcp_sched_get_send,
+	.get_retrans	= __bpf_mptcp_sched_get_retrans,
 	.init		= __bpf_mptcp_sched_init,
 	.release	= __bpf_mptcp_sched_release,
 };
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6da60e35932f..7560693e5b7a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,13 +16,25 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
-static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
+static int mptcp_sched_default_get_send(struct mptcp_sock *msk,
+					struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = mptcp_subflow_get_send(msk);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static int mptcp_sched_default_get_retrans(struct mptcp_sock *msk,
 					   struct mptcp_sched_data *data)
 {
 	struct sock *ssk;
 
-	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
-			       mptcp_subflow_get_send(msk);
+	ssk = mptcp_subflow_get_retrans(msk);
 	if (!ssk)
 		return -EINVAL;
 
@@ -31,7 +43,8 @@ static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
 }
 
 static struct mptcp_sched_ops mptcp_sched_default = {
-	.get_subflow	= mptcp_sched_default_get_subflow,
+	.get_send	= mptcp_sched_default_get_send,
+	.get_retrans	= mptcp_sched_default_get_retrans,
 	.name		= "default",
 	.owner		= THIS_MODULE,
 };
@@ -73,7 +86,7 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->get_send || !sched->get_retrans)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
@@ -184,11 +197,10 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	data.reinject = false;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_subflow(msk, &data);
+		return mptcp_sched_default_get_send(msk, &data);
 	mptcp_sched_data_set_contexts(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	return msk->sched->get_send(msk, &data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
@@ -207,9 +219,8 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_subflow(msk, &data);
+		return mptcp_sched_default_get_retrans(msk, &data);
 	mptcp_sched_data_set_contexts(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	return msk->sched->get_retrans(msk, &data);
 }
-- 
2.43.0

