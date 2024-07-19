Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876E183CA1
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391896; cv=none; b=dgk2g85qpDXO5+nt4grYf5zKVtNSYZu0d6faXHlzmpiBTq6SfttmzPgEzNZEbWNGTX4+OAof68Qd3o0Ba48GZfBmwWtj32oMTit2+W06f+se35sUL28OPTTMBb0Z6zdON9gsdrKc2wvodoosmvlrQfhDHIJBPLzfNJFqYQ8lyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391896; c=relaxed/simple;
	bh=Gq19EVxp4y7fsbZBvTEyrGKHXIbKGlWR0Acz4Iq6Ix0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxiuHfqU/ItCH0LbAU/dHwiZTX3zfVZ/Y04HvD5u1lvfUcFu02WvIjcWOIfi3GQoVXQtSArgV3jtKvHq7PfHSeVNlKzHjw2eUbHUVgHsyRO7ix/xwSnUPhdNtxVCb9T2IlSrLkXUjITXCgypCWW1MoQXHxNKCxX0hJx1n5fINfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6ubquNn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6ubquNn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674E2C32782;
	Fri, 19 Jul 2024 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721391896;
	bh=Gq19EVxp4y7fsbZBvTEyrGKHXIbKGlWR0Acz4Iq6Ix0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P6ubquNngfhqq4qiBbevQNesd0e8J68P8nyb97qZ6WCBG2mZouJdZ/RL+k0J9QdFJ
	 QIjy/Dm7JwRBQymX+fACfCDTl3E0IKZGos84uN+NG886ARIL9qOwsoeMPMx0TgHlMU
	 Hl7eLn5FkltcZFBygugEcZf6F7VKv+2DT3DYzhDJlsu5ek3XhSDEA+n8Xbas6xVgs/
	 Tqy9t6i1KQaBKsAGGQlcrLHqPgG2/xGSF5YK4JQOZoHxz9h1ZwfDahmYnDHvUJku5m
	 Z0DjWMqJZroeoa60QCDmAUP2BW0wVlGHlyutIM8OYIGbBuJkHPbTjhxEZoVr1Sf9Nn
	 BvmzUFib7XA9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 14:24:30 +0200
Subject: [PATCH mptcp-net v3 19/20] mptcp: pm: fullmesh: select the right
 ID later
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-avail-v3-19-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Gq19EVxp4y7fsbZBvTEyrGKHXIbKGlWR0Acz4Iq6Ix0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmlsA7Mo1VKxI6q8CkaHC9tLtGYxeo5LqehSzF
 6Z+3Vnr1X2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZppbAAAKCRD2t4JPQmmg
 cz22D/9CXycSghLs5lon6EGoohB0Ug91rSOJYnidaNdnm7km6rrX6/fafcdPmR7tCLNRv4zZkej
 +ObhBuCV3omHIK3H/XZ+/yYk9B/MbRSt/rNC6ggVdwB/W5hjhlFYsMsM+2tT/ArhgdqZgfOJCio
 6mqogqAy0CsuOKMTbu7eqQ1H0n6EDBvPqqG9ZCRtk6svUH68jEa/n2HVhYFSThtHCb/xRYYnGVc
 CnpD0/WQW76iwiWQ6lmaH0OiaXo5wqe/FoCyVi8USvAlz6fYAL2RwySvQWFvQdFa1nivr8/1xZj
 tLgDuFrdrlLgpFC2pOctRwIh5LuhmS294kl4X5q46Xy2ZVNfDejENVbFyaT/gi7TlSnCk6qw9MK
 QUQxD1tLx0sEmVNO4qAIK328l4yT02YK0WdUnc3P4YClZeiMo2Uz6ITlMJLmSe6uZiR93UK95kP
 /eQC3dYhVR7enY1g+VnUSgZJXqynIpkVFP78nLlGW2SGt/G3jXRDe4o6BfdQ29FlGl2/gHCJ+6a
 6UrNkbp6ubz1BpwdhCu+70KGpu2hu9vSXbHANTuy4WUMVO4fgneH25EJyps+woZ/IOfR2h7RWup
 1cTmO+tCgoZi+f4bYgtmIrCDSWPKABrPhqu+2qpY9HyvnSrJciQ+vpJjJoklnWYVBxgOG8YJVqx
 qeswkFc0TksG4cA==
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
 net/mptcp/pm_netlink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec23bb32862f..1b0e1617e90a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -637,12 +637,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -654,7 +656,13 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
-			addrs[i++] = entry->addr;
+			addrs[i] = entry->addr;
+
+			/* Special case for ID0: set the correct endpoint */
+			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
+				addrs[i].id = 0;
+
+			i++;
 		}
 	}
 	rcu_read_unlock();

-- 
2.45.2

