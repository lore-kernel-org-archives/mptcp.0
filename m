Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4D18E02A
	for <mptcp@lists.linux.dev>; Mon, 23 Dec 2024 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942624; cv=none; b=U4jjAHgJ+ES3nRzNWwrb4YsQX1SoMGPcAEAIMBwLlN4toTHu947XSV+LRHS3khwruLa+zID7vWKjzWYUhquvB5jk8xuX5YYR43itCRrQ50Wz42aOIjgmhc1Ww9uVyYPOj3geRB8jBWoTllFVdysabO9ECpAW2rb/TyZZU7ubGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942624; c=relaxed/simple;
	bh=Gc5LKxQ3OcogXSwdYqvHiBccFxxgprSou6++gckWMV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDtzyBH2PAojmr3Ppng1jHCaL1WAu9z/gZZNWsUOUuo6irhwaLRsrx7RddWfVx56f+hypzbNgmfR291xVVNekCMToGIxe5H0jpMzXMhwyj6jZKA7BekF+KtN3PY+YCGGOx8nB9J2m0WoFEm/tvstBuN2vJLIMqqSzI3f+HKzctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TR3qrxy+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TR3qrxy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAD1C4CED4;
	Mon, 23 Dec 2024 08:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734942624;
	bh=Gc5LKxQ3OcogXSwdYqvHiBccFxxgprSou6++gckWMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TR3qrxy+Zigh8LnwH5HaAY4NiPfEyYyD9p/uCYxdxzFkHmStVHtp98UQBdLFGc+5Q
	 XM9ggf0UUHopKB2Hofun+Aid7DE2h0hoWKti3pdxLrg4OTdrfhaaqFFres5DCstunt
	 bF92k1Q0OaUOPkrbxvaTxh2z2fLanQ5qqTG/fVF1M4NnOzbOMceuvxCSAxTl9XgLAy
	 dvsZkrSK+6IOu7qTlx/WMBFRaOeXKw+XyADkFdBTU9EzpJrDNblskMTp0MyDj3Vob1
	 WcOK491juweWGJaYa8u8B/hRhJUThvy9sfMd1baV2SWyZbb3tTwwXu6yOPJndqj4hX
	 KVjZGayYEuMbg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/9] mptcp: split get_subflow interface into two
Date: Mon, 23 Dec 2024 16:30:07 +0800
Message-ID: <90848e85beae21f0ab67c5b6bc629bd8911c1891.1734942318.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734942318.git.tanggeliang@kylinos.cn>
References: <cover.1734942318.git.tanggeliang@kylinos.cn>
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
 net/mptcp/sched.c   | 35 ++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 94d5976f7b8d..72d6e6597add 100644
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
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6da60e35932f..0b1e472e59a0 100644
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
+	if (!sched->get_send)
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
@@ -207,9 +219,10 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 			return 0;
 	}
 
-	data.reinject = true;
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_subflow(msk, &data);
+		return mptcp_sched_default_get_retrans(msk, &data);
 	mptcp_sched_data_set_contexts(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	if (!msk->sched->get_retrans)
+		return msk->sched->get_send(msk, &data);
+	return msk->sched->get_retrans(msk, &data);
 }
-- 
2.45.2

