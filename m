Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F920E717
	for <mptcp@lists.linux.dev>; Fri,  7 Mar 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347427; cv=none; b=qvmtjovKP/H52UJ3q3dYeWVaYWB+GHx2cqycwNN9tbIuHw9BUkRAgUVtLHejPRfhxFT+Rt5gaVduW56dOC7CUQkS4InI0lCAm90JWf96Z2E8Z/g0r1+8AXsa+gabQgJL9iNBcc+PlnF2Al0dUZLJnXUWbSD5K7AvyRuibONWAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347427; c=relaxed/simple;
	bh=4zDTzs/dsrlDyQcA6b/rZ6+Zut62yH8ZjdgFlSDWeRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZ5aZEpN4Rckre/pmIZktFNLPq7wx3c+9L0jik/4PcT24Daieg/dcGSJV8lV3W6/NyO5rGlDlC3bPJ96AMDmUTsj0+I+s+At4dw42dqPlhPCSJxzUfBS4lgD35xcolx98RRaD5k3fD4Uzfnw1m2gw5YFugV7mqSrxCrPmy6JL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOKscJB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOKscJB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CD2C4CED1;
	Fri,  7 Mar 2025 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741347427;
	bh=4zDTzs/dsrlDyQcA6b/rZ6+Zut62yH8ZjdgFlSDWeRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HOKscJB+DqjeC0l1/wL//5NIrRRQJuTAQ7vBhDV0WmKyl/DpQ7+BK+mCf+qNUJg9Y
	 ShoPHzDi0Fwn04jeSpaLLxwzjfQeFnKt3QbY03CZ6o551W+dfI+nypKYmUZgfbxhg7
	 fadXMXPuMnzwFPf1qpHpllPgwhWAugb8YtFDnjQlxCWseKB6cIN4dk8MnKHcxqYGFO
	 Qo3/J4DYWcm/++C5L+YRj+KmEj1oPGWGNwWXlE8dzEnHXZKa0GtVXqXPpUEW6i2GK2
	 hbx95Kpk3MTYmdHkzXVPSaoS9VUpGzEyTGKo0QOPFENYBdcpcdTj0qU0rVApC61tDO
	 F+9cI7SzCiOdg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 04/11] mptcp: set and clear bpf_iter_task
Date: Fri,  7 Mar 2025 19:36:45 +0800
Message-ID: <13fa1f655448b76ce1a3dfabbdfdcc13c49d43ad.1741347233.git.tanggeliang@kylinos.cn>
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

Set bpf_iter_task before invoking get_send() and get_retrans(), and
clear it afterwords.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/sched.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c16c6fbd4ba2..ffb531b5a4d6 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -157,7 +157,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data *data = NULL;
+	struct mptcp_sched_data data;
+	int ret;
 
 	msk_owned_by_me(msk);
 
@@ -178,14 +179,20 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_send(msk, data);
-	return msk->sched->get_send(msk, data);
+		return mptcp_sched_default_get_send(msk, &data);
+
+	mptcp_sched_set_bpf_iter_task(&data);
+	ret = msk->sched->get_send(msk, &data);
+	mptcp_sched_clear_bpf_iter_task(&data);
+
+	return ret;
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data *data = NULL;
+	struct mptcp_sched_data data;
+	int ret;
 
 	msk_owned_by_me(msk);
 
@@ -199,8 +206,14 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 	}
 
 	if (msk->sched == &mptcp_sched_default || !msk->sched)
-		return mptcp_sched_default_get_retrans(msk, data);
+		return mptcp_sched_default_get_retrans(msk, &data);
+
+	mptcp_sched_set_bpf_iter_task(&data);
 	if (msk->sched->get_retrans)
-		return msk->sched->get_retrans(msk, data);
-	return msk->sched->get_send(msk, data);
+		ret = msk->sched->get_retrans(msk, &data);
+	else
+		ret = msk->sched->get_send(msk, &data);
+	mptcp_sched_clear_bpf_iter_task(&data);
+
+	return ret;
 }
-- 
2.43.0

