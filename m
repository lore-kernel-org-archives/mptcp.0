Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5E22330F
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579671; cv=none; b=XcRDyWzPJwWLoAkqxcRYjnFatRFcdFNNuQ1sWR4W7TNgLEoN0guSO22yvJsGAqCYACu4hDsysDkBaV4DYNLV25lF+0ShJ93FGObFbft3qsBOHYYe9RgNK08devV1nviPwC2e0LrRqiyPsHCubXlhMn9JgKiJvW30URyn5a4lnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579671; c=relaxed/simple;
	bh=IT2fZ3Zi9XcQXRWaWib0FbYPyxqCtMkRNMtzHusQiPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q/DBiiFxBVJlJUtdRJezT1da6bfI0Q6z1uRCgCN+jWfTCgQ5hew8PJpCHC6WBDJhSNPvmnnRLI1yoCm/xbjd78J7B2jxDh3tmDCjnZXtAnGhoDKh+Ovno2lVCuiIYzu5DYxSne/trGRhAW0oIqe5sS8V/q+gMzXQqRhNXX1o13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYJQmJNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYJQmJNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CFEC4CEE4;
	Wed, 26 Feb 2025 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740579671;
	bh=IT2fZ3Zi9XcQXRWaWib0FbYPyxqCtMkRNMtzHusQiPE=;
	h=From:Date:Subject:To:Cc:From;
	b=cYJQmJNEHtRuxblWjJXm/xup6zQtXphZhn9b3FeDgVDIv67xK1LJnUUcAdOnsnxcl
	 jAewOK1RUY4vkTYaefiBayUnf3OUjHNP6fBLCAw4YBMIExMt8BJc7HG6Uv/BGVbUGl
	 Oy7ZHIE3SwgpjejN/gbnmZ8kg/2fu7S5kfyz57MZ8j+aeat71OZl8iOSNZUoRND2yK
	 9QbiIUtdNSh3C9pRWs18f3HNs4HXOPrqNFrt0vAOUfXU39G8b+cRy2JGVoWzT8Icrk
	 NkUiC5AGlNZomC9ZHYgmg4bR/E15dJBIN6r6L5Q6bIey5tBaYqrtPx5rIgj1R9XqKS
	 E74dA8dmAnHIw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 26 Feb 2025 15:21:03 +0100
Subject: [PATCH mptcp-next v2] mptcp: pm: exit early with ADD_ADDR echo if
 possible
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-mptcp-userspace-avoid-worker-v2-1-4b144f314353@kernel.org>
X-B4-Tracking: v=1; b=H4sIAE4jv2cC/41NSw6CMBC9Cpm1NTDlE1x5D8OiKQM0attMsWJI7
 26DFzBv9f47BGJDAS7FDkzRBONsJngqQC/KziTMmDlgiU2JWIunX7UXr1wLXmkSKjozirfjO7H
 o5STbjmSvVQt5wjNNZjvmb/BrWtpWGLK3mLA6/hzPsToS/53ESmRgJ7EZJfWqvmbV0uPseIYhp
 fQFKSIOgNUAAAA=
X-Change-ID: 20250224-mptcp-userspace-avoid-worker-93f367e39ca6
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IT2fZ3Zi9XcQXRWaWib0FbYPyxqCtMkRNMtzHusQiPE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvyNVhxTWmVsdD4jPsXu71/Yw1wKnCE7BsERlA
 JgwwI3RAWeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ78jVQAKCRD2t4JPQmmg
 c3DPEADGrqxFGsB+pGnJy/16hKscRNeqI4qVg+51Lpy3g96ce0ypQDX/2PjctPWXGdeL5BbWTMB
 B0KbIi9Bzpq2y3Wtktr0XJxXuSEmgrVkpkO01yDdtgBTNhMIOCKVuG2vYRfU9XIPDbdChISW5f4
 unz91aNAngtf/fb6zk2dAmr5TLEQJ5NLOYwKb7NoDvSxJMhJvs1D1XqWh4u57L/LnhI+EMLpP5c
 6VN4NE59OyE7BzkOfWLnBc9Lq2+gSJ1vwV5g55QJWrBzxuae8F8A75+c2a0j7KRFLEO5XaaMGe5
 VMbikcnLtCnkeo0A3GvkQoPAESl3eR14IQXepVHuYYWL5FTtX1nI+F/Py72qdrFFyg/TCRJxu2e
 qXd/fj+XmplBgHw6yHAoL5YzNaDRW6jBNOPBwx7Wnr5YOXNU5lc+yGJXfDDYDugn0JUk9YNJ+c9
 Tqn0Att3kHOKZDLIgNgkK/06PL9Gvln0Gfv4yH4y5T06g65lynI+uiVCc4yFG8oyxLA0YN2Jto2
 oEguKOegL6mJJh7o2ay1T7fFbJ+SM4a5QVbIYy28q5a+dq8uyZH4m6PvqYevKsh0UBlMQ9+ejiJ
 WIYo3SEox3xhY4HT1kjRGHjgRm1PbDkthluDgQs3lOznHL2uMZA1XqlVxNcxJFpwoyAyCZi3yI4
 jsNI8UNF7bZrAug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the userspace PM is used, or when the in-kernel limits are reached,
there will be no need to schedule the PM worker to signal new addresses.
That corresponds to pm->work_pending set to 0.

In this case, an early exit can be done in mptcp_pm_add_addr_echoed()
not to hold the PM lock, and iterate over the announced addresses list,
not to schedule the worker anyway in this case. This is similar to what
is done when a connection or a subflow has been established.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Link to v1: https://lore.kernel.org/r/20250224-mptcp-userspace-avoid-worker-v1-1-127325d3e9a4@kernel.org
---
Notes:
- v2:
  - Only modify mptcp_pm_add_addr_echoed().
  - The rest doesn't need to or shouldn't be modified (Geliang).
Cc: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16cacce6c10fe86467aa7ef8e588f9f535b586fb..6c8cadf84f31f4c7dcc38b787beda048d5362dc8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,6 +251,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
+	if (!READ_ONCE(pm->work_pending))
+		return;
+
 	spin_lock_bh(&pm->lock);
 
 	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))

---
base-commit: 1238896935ea03f333a183a32fab666cc0c20e3b
change-id: 20250224-mptcp-userspace-avoid-worker-93f367e39ca6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

