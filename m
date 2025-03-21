Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA035947
	for <mptcp@lists.linux.dev>; Fri, 21 Mar 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742521543; cv=none; b=PyOy/MiM6Ri7YzBGWtfkRLWeTfGBpZB68PGBG3qWZJaqhUntzwCCOMNZ6PUmYLR6Mxc6hiBRcDz1smirrSkoYTmS4lyPQKuNnNXAoacq0xcG8V5rJB3odmVcPhfgUyba+aAxhnjscvYAeWXB1iseRwwF1QPWOu4KDz8n9amyX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742521543; c=relaxed/simple;
	bh=BXGTvkft48Pz1dNbiMCp+7S4/NhhiPI1UvstLtFjoHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+kV1NFm7l+oN3aLEnejJCrfQtQN+i5L9/HLMDX2+nZ51pryCaioSdtYYDskkQW/m4OI2EdNeGmNY6LIKYW45iC1s+CZvf0+ZSMskZgOcYkdst6EUp1Wy+n8t0cJ4uXnw/+mvIb8G9vSUoCYmd7x198UYt0U/8ANBU6/IieHOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbOyS0Wn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbOyS0Wn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8579C4CEDD;
	Fri, 21 Mar 2025 01:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742521542;
	bh=BXGTvkft48Pz1dNbiMCp+7S4/NhhiPI1UvstLtFjoHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbOyS0WnS7cVkCHJIg2EnrsyfouNO3OWnOAJNx/BsOzW0atnmTjVMDp9uu/oIMrGX
	 8fJWZJx7xMfYpk+JauAPHCCRa1gBp8zrOrtCSOy9dLOfoZmYWJnAyWIhxgm5uzR/qU
	 5JhRVR+PcgjNqWwqtnthVKLKhevZNdi2AFXns5jP81tJJdq2fpHqYUl6Ua918THteL
	 3u0SEEN6FBCRI86NEl6cYjvwaovlo5rFP2u9GWFjnmtDgKfB5KIu2sW1vYWlenYgwN
	 UrUN1EEb0iGi+zq+6Q+Z9uEYc709eY+dm/BktJbrdt9KSXMJ5L+fpY4StNh4fUpBnh
	 cTh3tAqzQ+xrw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 02/10] Squash to "mptcp: pm: add get_local_id() interface"
Date: Fri, 21 Mar 2025 09:44:56 +0800
Message-ID: <b67f462e31403e3f471359b4f1a760203ca5b572.1742521397.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742521397.git.tanggeliang@kylinos.cn>
References: <cover.1742521397.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add /* required */ comment for get_local_id and get_priority.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6a08ac862bbe..9f28ef550e10 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -118,6 +118,7 @@ struct mptcp_sched_ops {
 #define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
+	/* required */
 	int (*get_local_id)(struct mptcp_sock *msk,
 			    struct mptcp_pm_addr_entry *skc);
 	bool (*get_priority)(struct mptcp_sock *msk,
-- 
2.43.0

