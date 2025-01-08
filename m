Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3395156653
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 04:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310090; cv=none; b=sA6Xm6OerMYswf+uvFD87O/Z5I/pHs/Jtkdk3J004EhA9ywltjz5RDrleY8kn0PIHzLNoPBHpErolzaAOLQHUmPfgKHuk7eUnjcUhakUQ/Ait+OVKEAwmXARMi2D41lkewFr/X4ABQnSyigro5qEMZcXO1gGXrAiZ4T0mht3BxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310090; c=relaxed/simple;
	bh=Nb324xVpXeMqRUT6Ba+GMKnin+xiWtkYOjpyaheLzzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2frV8sjEXrKCn+kn2AMKS7aqJOdyrCehgglsib/G8NhIsyGKOyuSAQAcPrpt6JBUrCJ4PZNYmH8or9scLaHlusftGU90N+txC9trFXZR2dy+in+nF8N4J909Facs/JCxlgVGwbNy3ZGdb6tLU9taq2qpitPG6n9hfgTwdPVYcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsRw63Y+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsRw63Y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA3FC4CEE1;
	Wed,  8 Jan 2025 04:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736310087;
	bh=Nb324xVpXeMqRUT6Ba+GMKnin+xiWtkYOjpyaheLzzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KsRw63Y+FpUSc/C1P4TFREwPNSetUnpyCBkRzxFZXNunPSVbpo+t5lhemAQA8t0e+
	 arsI9nz9tIGuzWD7HXbdSqdcN0dKubOBB5+KvFvrSfFaVSf2r6GI68V/WP7IPJl0E2
	 0i9trc/piKNQ+Lbr/Omn7Zl9nxLxtTBpf/MgzBGlcee+ztNGpKVZfKY1P1vUP35rGw
	 BMXo7UcEy/6ZT76ursE1FEa9ZqMAut653cQw3VKPw1T5ZhaqaJtYU1rU/AsVJ4zs0u
	 EKGjwafUpxcyZDKN7U8HNOYy4kvzGtawWNYYo4HneI87dB2AJ2eOVsjrM41CZ8wgWy
	 2UveWmtiom1hg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 5/8] mptcp: userspace pm set_flags id support
Date: Wed,  8 Jan 2025 12:21:09 +0800
Message-ID: <30061158e34c4fbf9063150e6aec40c0eed42b6b.1736308884.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736308884.git.tanggeliang@kylinos.cn>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to in-kernel PM, this patch adds address ID support to set_flags()
interface of userspace PM, allowing it to work with either an address or
an address ID.

When an address ID is used, mptcp_userspace_pm_lookup_addr_by_id() helper
is used to look up the address entry in the local address list instead of
using mptcp_userspace_pm_lookup_addr().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d69e37f27c6..3fad1201bc51 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -571,6 +571,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
+	u8 lookup_by_id = 0;
 	int ret = -EINVAL;
 	struct sock *sk;
 	u8 bkup = 0;
@@ -590,12 +591,8 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (loc.addr.family == AF_UNSPEC) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr,
-				    "invalid local address family");
-		ret = -EINVAL;
-		goto set_flags_err;
-	}
+	if (loc.addr.family == AF_UNSPEC)
+		lookup_by_id = 1;
 
 	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
@@ -613,7 +610,8 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
+	entry = lookup_by_id ? mptcp_userspace_pm_lookup_addr_by_id(msk, loc.addr.id) :
+			       mptcp_userspace_pm_lookup_addr(msk, &loc.addr);
 	if (entry) {
 		if (bkup)
 			entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
@@ -623,7 +621,8 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, entry ? &entry->addr : &loc.addr,
+					   &rem.addr, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
-- 
2.45.2

