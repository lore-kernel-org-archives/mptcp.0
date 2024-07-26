Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F5EEB2
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004137; cv=none; b=AUZ9bBYmgii72ZIUU7GP4XPO2WyFOgGu7PBtnsnkaMM+Rr/ZJXJljsJXSlgMmlxuRIzxJsxk0uaBHhBeSLI4OHl5IRFywzCU7yRzzrV9XpCnqPggS28ovnPQlWiEiXFycLRLO8Kx6Om/U0h6hVGSlKUg5vzs3ekgjOw8Wo1gckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004137; c=relaxed/simple;
	bh=/cmdvJT5Gad6cPwXZd2hg71GhRcpI1wLIsFSm6YgtGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lie73VHFfjsJPynV40eRuMEoGuqyeVbcBaT52PHPOM4XY2V8Pr04+v5cVdRFvzhcv/nxoQBfMEyj38Ax8GfNeu56r1xqAksrl/tno6OdOFtl7UnMSqu7Npk+AtPRc5YKTEKnHPLL1xBNJh6jqBCZv1wkx2sD9sd+8AH7kI0HYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag6JpCxD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag6JpCxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2574C4AF0E;
	Fri, 26 Jul 2024 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004136;
	bh=/cmdvJT5Gad6cPwXZd2hg71GhRcpI1wLIsFSm6YgtGU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ag6JpCxDanW68Cbk2f4YbzbtZ8pJSA9+aEBp7Tiv9D9IA4Pphix/4LyATrrxkIbV3
	 Kzi2KW/VMauns2kvPlByD22k+efa41gdQ3B5/QAssSgK/PVDPbkg7zCo+dnYvknnMT
	 jqylUNWe6KsNkrxDI5NEx2ipOd/wg4ZTja/fAviLlbIgFE1COKroaqk6UM+/NC0rnv
	 UpyMKprI0s72TAP2umWrJQkAoi4+q+5qRnnmhjUnZKAQef9a+KX1JgI+DoCxbs1oLP
	 4K8ZbKJJSDa55swIbHQ8IlAsbPed9Q0VfLxLdwM1DzAzwFkwIjmlUbGjsF+kE3hYsh
	 RCkjG3BuGuP6A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:34 +0200
Subject: [PATCH mptcp-net v5 08/13] mptcp: pm: fullmesh: select the right
 ID later
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-8-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/cmdvJT5Gad6cPwXZd2hg71GhRcpI1wLIsFSm6YgtGU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7Kc5GfaDGEyP5d1DD0jP4kFnhGqMgT+zPDqt
 +Qx49UIA7iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 cxwKEADq+/HViBk1E2ic19pVindb8Q9BL+d6taY1DKYAX4butBUcr778cHHOkfcfxGQ+00t4W9k
 wa2j2BD6vLIg7KuEn6Tajkv434UKoMZH01FBtVNEVUEJ8YGFiKOV8hHnPlzuiUO2Pt+bRBfBBGg
 A39rP8FfEU5+wlbU/mU1mn9mhcpXH0RD+st3sgIR5Fz/ihLVGUSLOmc8Gre/WQUF+7f7f0thK+M
 UZrPk8+9IELXxG2Yh08Cs955hCT1QkiycuHWYLlvKAEPvXzMhIhevD3uwcn5Xc+a5/T7eCgXXhK
 GiiflGXini1geIKmGZMDi54iih4nl/ykcOOJm3prxEWsr3+1W5Sv3ggxIxpNP9nrNmOGjyyBdyt
 I3iQoCWLH65F+4bN68KRoryfAfaHbTqUlfParWiwiW4gsGTS3V0GESzbCYmTyXiAgoTVQftX94F
 1zuywSGKUSsktzNHt453W/1fSL/mZCRuWwUGE2fWAPiBNxXa5V5qJsQ8LPbAw7zA2GJOwy8zgXB
 eMGZUIfqLOpSqb3Omojfl7JykMDh+WI5uJKfTeoIt0fEB/5db3RwjzplkK0EHm8B8Ia7oXd3N8j
 h7yN5eAd+IF0UZQJqDxySr3UIt8dM+nZY6DsTn9u0bT4n6LHAw+YATxeRjecmMTFIYurPrPaclG
 7fbLNJQWa7/gPKQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When reacting upon the reception of an ADD_ADDR, the in-kernel PM first
looks for fullmesh endpoints. If there are some, it will pick them,
using their entry ID.

It should set the ID 0 when using the endpoint corresponding to the
initial subflow, it is a special case imposed by the MPTCP specs.

Note that msk->mpc_endpoint_id might not be set when receiving the first
ADD_ADDR from the server. So better to compare the addresses.

Fixes: 1a0d6136c5f0 ("mptcp: local addresses fullmesh")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v4:
   - Check that msk->first is not NULL.
---
 net/mptcp/pm_netlink.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6a1495fec7ae..bc9c2e40881e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -636,6 +636,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -643,6 +644,9 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
+	if (msk->first)
+		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
@@ -653,7 +657,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct ID */
+			if (msk->first &&
+			    mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();

-- 
2.45.2

