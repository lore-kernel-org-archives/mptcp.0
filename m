Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309528;
	b=xY+liuh8y8ZN50HBYlHirNhHcngdNPIqAaoTD1ywJiA7cbLOXblfr5lOLVey+SPjJ4zA
	 jmbNVzwvBJZacK3+iAyxX3/QsQO99UTt8yubK1sV2suK50jEV4i7mTbiKWIyWCF0kDc3v
	 PDntXTRpmOUlKpVpJia3JbOjXT/dLVkT1Sr2s8oP8/uqsaWjnhbxsefP+8/PNyNxItOPs
	 0+9smlIfAV8famLlTUWHVS1TQPhWd02xHLxPgizPKhe71R3776FgLfLka1BBR+WUrNAQC
	 FxclDUCQTte4nA9ILQ8wBNmnUOIX/7xxWIttrDZRlDDXM8qCplBD0wmVOsAlLJ3J0lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309528;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YiCK5Jj4VRRHy/fecTbn6QsuOjg25bt0JwD4qMhkTJc=;
	b=FTcL4KI14IyF6H3RcepzoJfKQwxeFhzyfQEu9djjFIaJ1gzG/N+mhL+WIpvlUfN8uBZZ
	 IK37Hna7Z6bGAagk8JFSc54XPWusnjJRus9hHLSbKeUFTQvU08bf9ZaPyXNGP8XvqIqPa
	 1g+bjeEIWxK4nY7QTO+8Pk03PEW5pFTrH3pL3rHs6EKTAB2gTrmheIh3gwyW25TRWVzKA
	 MtB/U4VpnzEXhBnldgqoAjDkju0UGAoLavpeRfSJTfr4Rk0j/cz4/DfSlpo/IbQlX4kZx
	 hkR57GL5kyuvBbu+KXnvoHmbGNg1TeVFk76wEvaxDadx5dCgMn5FE5PURgB3Qi2CfWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL+KJZHq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF1606A31A
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FL+KJZHq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021921F031E0;
	Thu, 29 Oct 2026 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309527;
	bh=YiCK5Jj4VRRHy/fecTbn6QsuOjg25bt0JwD4qMhkTJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FL+KJZHqVlBZ/kCL24c/xGT50mETWZ1k6HG43FDMHgHdH+HthGGsw+s+0cCz95+gN
	 OZrSzpLUzjzs9w0a5N4+QaHGpPucDvElCjojf+3ho+NFIDdZl70Pw6OQw0VkPrDIis
	 GEusY3lA3YAZZq0ITh74k5e7a1K/deoOfrbBL14hwmX8+jW1jnIw0tpt6kjCYGKrmF
	 SkEH8r/RGQtk7FUqfAW+FsHo4Zk3NJSTImH1HK/O1UqrakL8BU1HPt5rWzzH9xJrvr
	 VXnoBSLWb0WkQLwsKdbFbflr/xpIvBD24OJsHe61UM86tP0/eZBm9wZSZhmI2t5Xof
	 5npMMpSMlnRHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 29 Oct 2026 22:31:49 +0100
Subject: [PATCH mptcp-net v4 4/8] mptcp: pm: userspace: allow announcing
 ID0 addr
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-mptcp-pm-userspace-id0-case-v4-4-555066fa4292@kernel.org>
References: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
In-Reply-To: <20261029-mptcp-pm-userspace-id0-case-v4-0-555066fa4292@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RhvRsmm764l/fbDteakqbdBfWAuivqGjDaDiK0dm4QA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIe7w74K788atJhJ0Oz8BaJB7E+Bxd6aX0PLc9/cU9Zn
 mnZ7qPnO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACaiocXwP2PWXP6rm2M+6u44
 t9TrlueUJF5D7yj7K2GRSyXPuDM9aWdkmH/8lnvvu9p39WrPHq1euOZmV+JZxTylut61JwwzTCs
 9GQE=
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
sashiko: check the next patches before pointing at existing issues.
v2: Add note about re-using the ID0 with another address (Sashiko)
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 74969b86fb81..66dbf67fd6d8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -239,12 +239,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
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
2.55.0

