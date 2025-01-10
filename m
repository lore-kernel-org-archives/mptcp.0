Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757D3C2C6
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494596; cv=none; b=hSKXXKwixD2naKNJcJHUvx+/24pOnnLbjQzPCCtkqVO7AOvvygEwh10prDGMc5m8htlmX3DMS0q720jao7qND/+8iDu7MHz1ICQYYvvac4a7k+OM1hhrLckPB5BdUNQ9kDMW0jha+9+9Sh1b5cgyQSeNYjFKQXT0j+QiTW5e5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494596; c=relaxed/simple;
	bh=Eee+IaQkVtwPlipe5QgcZ9x675H/hogpGkijB9t88/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4aiSNbTwg6ftt36oQdauNmMhy7LHIPycOyXOrQ8H0aVUsaYY7/sP0DXSmG28bXy//LCg6t8ZFTY39pTR6eZcG7pG2e7RIHhPAljGGImMC1v7nx8yWdLqoOdjJAD6gAmAeaM+/Lios49kKZRNHlV0RS47d0FZ3BJ7en/53RJXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G551nmSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G551nmSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA66C4CED6;
	Fri, 10 Jan 2025 07:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494596;
	bh=Eee+IaQkVtwPlipe5QgcZ9x675H/hogpGkijB9t88/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G551nmSPc3SK2Rfy+1wPvKe4C4aVWkaCIB+JOdiS5dCPFYzZqQBiWdUXj4poW/O69
	 DvZb42HQDIO46lKXJF/Atvr/JOKCtEwvcZcshMgMs01TbcX3ybQ+4ISHoh6f8P3rDG
	 2Yp2ITemOiStBI6Hbwk4EpBczOO8fCPcdlcBKGvNLL5eBdghi26RAKghCZTRedBRNJ
	 S0+BBhJXhUZAgvml6blzpcVnz1eLLjy8nyIdoWeP669WGU2cpgjOjXRaMQyRrypX8A
	 IRH83RK9zfOBHoeqvWM2Qp8HROmafgXoJRBOhg7xhq+ejXUw1gPgV0MzO/W8vL00Bw
	 q+EbagbzCHKjQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 6/7] mptcp: change rem type of set_flags
Date: Fri, 10 Jan 2025 15:36:19 +0800
Message-ID: <95e26d31e0638c5352ec3020e8744341b87e2c47.1736494320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736494320.git.tanggeliang@kylinos.cn>
References: <cover.1736494320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined as
an mptcp_pm_addr_entry type address, while the remote address is defined as
an mptcp_addr_info type one:

        (struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type parameters.
This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 008c6367a75c..4007f67cc7b1 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -567,7 +567,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct mptcp_pm_addr_entry *entry;
 	struct nlattr *attr, *attr_rem;
 	struct mptcp_sock *msk;
@@ -597,11 +597,11 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	}
 
 	attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
-	ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+	ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 	if (ret < 0)
 		goto set_flags_err;
 
-	if (rem.addr.family == AF_UNSPEC) {
+	if (rem.family == AF_UNSPEC) {
 		NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
 				    "invalid remote address family");
 		ret = -EINVAL;
@@ -622,7 +622,7 @@ int mptcp_userspace_pm_set_flags(struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
-- 
2.45.2

