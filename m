Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A446AA8E;
	Wed, 12 Aug 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546573; cv=none; b=A7NUM8ZoQLTkJD2FJmF9r3H5YAERk4XuZQgGs8pX1F4OggTsHqTnFe/6WHlpmsdcuU4Rh7tJQIkZ3KZbHlPcP3u8gq3qLAso5f9OMaOLmTfhJLcPMWa5di5HKHP4uv38vsp+IBD6NNf6OFZ2qJ/dYRvan9qDSmMQG0EZ67J5oF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546573; c=relaxed/simple;
	bh=hIwnq+Z7LILmrxmKsmTq01ySBGJ3Uh/6E7+3MaTXdiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vy5k6r49EfBI7IOtYIACn3OGOJSHIeJA6MQeVGWuT1DcphM8rF+Ivov5BTN28anR3JyeihK/nY66ZAdTRHOxVw+1BnPk4udqOFEp58AQW+HCe4nZ8FIhH5XlpUM6uvnCk0nBOxl+5Luhm1Xe32SbZZ5mPST6xHyUobCbawn45qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0DOJ1oC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0DOJ1oC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAA11F00A3D;
	Wed, 12 Aug 2026 14:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546565;
	bh=SfJPkh6wWzKGhN4UjY4T+OCGz7au4PBOlmqjBLgCZ+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S0DOJ1oC3E2Swxn3BewO2MdGtxKkMWew9sZmq3fpUy0mYSS3vrVmMrSOkMmYYFgOS
	 phYoRPJeAYzmLYq9SrctmJ+Zt+tK1xkS6PB/TSNfYba8ywkJ+XAIbQkcnTvPwwo/Sf
	 TYgU8j/Cequp7On/zzULG+QKNbG7NTGLKQSUFkODomDrdgdSQAnIzoYvchPDjTHIRI
	 NbAs9LjguXBv6qmOoEXRzfcP55M+xDL7ik/+qbNzXgGRNLhHri67yGFjpQLxogyfDn
	 wZEMsVEDLHgB3j7aAL0R91o4G70uBmdD0dfi71LOx6oCc6A5PM7OCLeperpgQDobW5
	 skwxX8mKmKo5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Aug 2026 16:55:38 +0200
Subject: [PATCH net-next 03/11] mptcp: pm: userspace: make
 remove_addr_entry static
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-net-next-mptcp-misc-feat-7-3-v1-3-1905a818f6cb@kernel.org>
References: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
In-Reply-To: <20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1890; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hIwnq+Z7LILmrxmKsmTq01ySBGJ3Uh/6E7+3MaTXdiM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJqOku4Q6WtM/i7NbLMmbfckWW5eNnGMniiR1b6AzYl0
 7j+r/M7SlkYxLgYZMUUWaTbIvNnPq/iLfHys4CZw8oEMoSBi1MAJnJoOyPDRodZ/f21F6dtWbZW
 vaTByqHD7e8a92uJ6ifKXvI37N21hOF/znS/LUU5DYej71vV3VXmP33sJGPw82PR80SDkq5kziz
 mAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only used in pm_userspace.c.

While at it, use the mptcp_userspace_pm_ prefix, like most functions in
this file: that makes it clear it is specific to this userspace PM.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 7 ++++---
 net/mptcp/protocol.h     | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2203cc2d2748..b94fbb483bf9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -281,8 +281,9 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
 	return err;
 }
 
-void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
-				struct mptcp_pm_addr_entry *entry)
+static void
+mptcp_userspace_pm_remove_addr_entry(struct mptcp_sock *msk,
+				     struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_rm_list alist = { .nr = 0 };
 	int anno_nr = 0;
@@ -340,7 +341,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del_rcu(&match->list);
 	spin_unlock_bh(&msk->pm.lock);
 
-	mptcp_pm_remove_addr_entry(msk, match);
+	mptcp_userspace_pm_remove_addr_entry(msk, match);
 
 	release_sock(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 20627e12c113..06a107d4e839 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1149,8 +1149,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
 			   bool echo);
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
-void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
-				struct mptcp_pm_addr_entry *entry);
 
 /* the default path manager, used in mptcp_pm_unregister */
 extern struct mptcp_pm_ops mptcp_pm_kernel;

-- 
2.53.0

