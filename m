Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC2D37F74C
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092125; cv=none; b=ujtD54DQWKUzTFjOW66lfvobYMDZ0OWVH2eEJyugwEdSYYbgpq+7e/sQfEXOvoJSLMhyMmRUQIbh0msZ/kNzvXt5XPXNCII3f2J9qpAYx3PWeChtvS0K0ZGwzLMNsiUjWRvoz+Py5DqLejgOiTGgLEfrFOcgEVh3d0iP8lhGEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092125; c=relaxed/simple;
	bh=PsAf6aOFwwWNOdRDRZGLcNbLIDbeB6FmOkiZS2+Fzso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksklIa+5i738Qf6vqNwZ4F8dLD84qS88rdTP+R6nH7JxsW5PYbGTSEGWTdgt48dK5iqHQwAZ65bcKbI1RTR8XvWoEsti4iJ0/CEs2f9PQ3ylpnxcpw4aliJXprx7Gp17BjD0xVr8R56EaAMaFNuMcHKAal9+xbiaRkSAnmqHluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eca9bW6A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eca9bW6A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EED31F00A3A;
	Fri,  7 Aug 2026 08:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786092123;
	bh=HfmpyDWvAua5R7g7MwjzVD9n/Qq7gVNvPI6vDus6r+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Eca9bW6AFWrprtppaU/cIHnVVkJXexXOJnOFoDBt3Srj+mOSvkJ/9DaKEEBz5vY2I
	 uvUq0Yz6wLYAvdrHHP3geKe2uaOWN7F6LmGKRejhZSryv1ns0gAy7oA25VnkdvAvn9
	 7tozqx05YVhHrFm0Fz610hjF7zoaYMMOka3Kcm9mJRBn314yTtELyKTLpySxs+LgMZ
	 ww+Hr4vZEruGjVxmt5QXywSy8crbv0+QfvFwsaCnX1zRUsFfVpGg8iwBa2pxVEJSmH
	 26MihxgwByTaR7wwpbcHvNvlzscz8t+UrVBgVps3m18ljKfJRVFqvimgJHBpZG2fnJ
	 YBOwY6HWYAD7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Aug 2026 10:41:51 +0200
Subject: [PATCH mptcp-net v3 4/8] mptcp: pm: userspace: allow announcing
 ID0 addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mptcp-pm-userspace-id0-case-v3-4-de9088549924@kernel.org>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
In-Reply-To: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PsAf6aOFwwWNOdRDRZGLcNbLIDbeB6FmOkiZS2+Fzso=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKZwUXubU9DlinVHNpUcUOvYsOXFcsKst5Nzk1+Zh0d
 6R92l/WUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBG+l4wMu+X/+TFP/CNRHR82
 7dXuTR9vXyr+v3yHUVb4u+AXLF1TdzAybPptVf70/OUD+VMLzq09Pc/jwXfFl77Rbjsefk1uO7f
 bnQ0A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is valid to announce an address with the ID0, the in-kernel PM allows
to do that when re-announcing the initial IP address after having been
deleted.

So no need to have such exception. If the ID is set to 0, but the
address doesn't match with the existing one, an error will be returned
by mptcp_userspace_pm_append_new_local_addr().

Note that once removed, the ID0 entry could be replaced by another IP
address. The RFC8684 doesn't specify this specific case with ID0, but it
says [1]: "A host wishing to replace an existing Address ID MUST first
remove the existing one". In these unclear conditions, better to let the
responsibility to the userspace daemon to pick the same IP or another
one, similar to what was in place before.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.4.1-13 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: Add note about re-using the ID0 with another address (Sashiko)
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 27fed3519d39..2c13c6273ad3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -236,12 +236,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err < 0)
 		goto announce_err;
 
-	if (addr_val.addr.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
-		err = -EINVAL;
-		goto announce_err;
-	}
-
 	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr flags");
 		err = -EINVAL;

-- 
2.53.0

