Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85AF1DE2D8
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920584; cv=none; b=GFNAuHGd09gdCCtLsaP+0vv/Siguxa+fH9NxLJy5GA+43QmnGPmmqetaEKo2Nq6cIXFgvim0OguRnj5pxtzyWV4sLf99+KHJIVTPaI18Dta1ftSyEzY4pwKaEaPcDbF92FDG0fFIbkNR3mnYrxxzO2/gN3hhxvL4UoE8Bk8KfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920584; c=relaxed/simple;
	bh=C5DA2VYREDHFFathj4vYgqapxCLlZHnQmTactqOBdO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9PcJT12fxArfxY98PUWEzwkqXvUpjcN+gnu6A3Wvfg9DISmYZQhj1isKQ0UWNXwX++mwU0ft78WYJ/z3Vc4sRHLBIC3WRukKEV+cAoxPTuJPQUn4NE8oQwJTUf8oHXiulZLCHnV93Q/hnOT7ygt2i0iUdicqOYFNP91/WclDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COBLUh0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COBLUh0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F7CC4CED1;
	Fri,  7 Feb 2025 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738920583;
	bh=C5DA2VYREDHFFathj4vYgqapxCLlZHnQmTactqOBdO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=COBLUh0YmhjhUaxTVX1deme8Z1GGImx3qJAKDwnhmJa2VVV8HqiViMXfOo4Qd2h04
	 UJeuGMzF/VqAwLHzKMLrBhukijtV1RLG5wYGgKUzX8bE+XmEVmj0owEIIL7Chwh7K4
	 AkfwWyD2lGIihnZZyOemMs+UoUpXTNAwxKPcJPoZK/yk3IOqGPxb5W0wYrMlzaX3ox
	 QjlsY/EqUHG6iRggYwVqEAq+Oq6q+DuUqSQ1Fd7cqrmHSdbluOVHIyiCNuY5htYGVA
	 WvX5Q6uYVR7tldyesQdL31DZWNKWeUJ23kPDMf1eH6V0wyJ59+TqZDvnAJ8p21+CgP
	 PPuWbugVooiLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 2/4] mptcp: define BPF path manager type
Date: Fri,  7 Feb 2025 17:29:32 +0800
Message-ID: <7d8321d1aba118d8541435fb9847d5dfbf3ad888.1738919954.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738919954.git.tanggeliang@kylinos.cn>
References: <cover.1738919954.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines a new path manager type: MPTCP_PM_TYPE_BPF_USERSPACE,
which is used for the userspace path manager implemented in BPF. This
path manager is also a userspace path manager, so add this new type in
mptcp_pm_is_userspace() too.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93445c24de93..cd36ffe8509b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -198,6 +198,7 @@ enum mptcp_pm_status {
 enum mptcp_pm_type {
 	MPTCP_PM_TYPE_KERNEL = 0,
 	MPTCP_PM_TYPE_USERSPACE,
+	MPTCP_PM_TYPE_BPF_USERSPACE,
 
 	__MPTCP_PM_TYPE_NR,
 	__MPTCP_PM_TYPE_MAX = __MPTCP_PM_TYPE_NR - 1,
@@ -1093,7 +1094,10 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 
 static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
 {
-	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
+	enum mptcp_pm_type pm_type = READ_ONCE(msk->pm.pm_type);
+
+	return (pm_type == MPTCP_PM_TYPE_USERSPACE ||
+		pm_type == MPTCP_PM_TYPE_BPF_USERSPACE);
 }
 
 static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
-- 
2.43.0

