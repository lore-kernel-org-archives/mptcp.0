Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758C163A5
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:40 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id bj12so33525856ejb.13
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkGlR0PhdX9YzLcyQnT+ALagHkjF/VZ3kM0OLZrGhoI=;
        b=zOhta0jYFYnvYRU+rMchA1fZfBBaTGiTsT3HYLWpZsl6xAhIQF5+2i1/rbPWLA3dn9
         Ot1sX4dwkr4+wx8pPl9BwBZfdL3QTNq/Rf8nCAlsTegj7zHknStXsSizm8IdOuZTyeZu
         GIUGETKwYalDfrtrLdeTMzr73aMsRL9MWjlwvaMgeC/uHUT8fiY8wz4veaaMa4nQAUCp
         iDSfzV53u0ncW52sIpskOzwFKqDLJn+x7bJ0wiIajM8kQTu2doKtvPWFOvq4JVaS275P
         dFDBTt3m19LETTP7c3F1nLObkWJewAff1sQMD0AXXOdmrV7X4ltDv21Iz2FQ8t9ADvHM
         g2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkGlR0PhdX9YzLcyQnT+ALagHkjF/VZ3kM0OLZrGhoI=;
        b=73vVp+Vev0viKx3KvwFxqvr3nDWnyp0UwbM6QbIx9uiuGlMspoLteSyKjbJNFOALX6
         /hF0PJe3p5+rLV7iKiWWo6hoW+iPhtwa+Z1lHAC+SwzJE1PHzEJTkdX/elRG5obMGM4y
         tJ7LP0L6Y0oa/unNCZ8RSAKKv7tO0K9rOwzbML1hucQTlUJEO+Oi/RNKG9zSPQbCLUm1
         A7bgCpnfAGZcdG7j4VMx6TiaSwWqmedZbOGmTbrn7ZY2gCS4leAf7zfc7MJMYBmP7ys0
         K8RVE2KEJXTPbgLWLyHPMqfljttwPJVsg4+Km/f0d8ji+auZYqWP77lWVSwBmXrhI0b9
         M7ew==
X-Gm-Message-State: AFqh2kr5PbxM2SNV0V/42DB3Tp6/PrYkSDBehrH2QrY62n6sHOnzdSmi
	JTUGOm2BV0cx/CSuL5qj0VVolrh+HOuWsvfaYad3hA==
X-Google-Smtp-Source: AMrXdXt/8MAcrbnzk+Xnr1+oOCNVExpAGAB5Acy//VL11RHN5FGRHUdZRFfGN/O2v/GedMrHxAbzgg==
X-Received: by 2002:a17:906:260e:b0:7c4:fe3c:cb2a with SMTP id h14-20020a170906260e00b007c4fe3ccb2amr19801204ejc.56.1672165298407;
        Tue, 27 Dec 2022 10:21:38 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:38 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 04/11] mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
Date: Tue, 27 Dec 2022 19:20:50 +0100
Message-Id: <20221227182057.2288816-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6443; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=E4UBs63mbgXRG6+3BLL7eIrHPGBDweqMzN61yUBammE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd5lRmD+g52JuCMSjzO+1IarqP8Ls8VBmerbvRt
 rnaw9riJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3eQAKCRD2t4JPQmmgc+zuEA
 Dc+75NeuYjlzh5kGt8De1Uk2gHC8bLMnZKHfd0B5uQuW2tFymvZf4wdBakuz0QsRzYqjhW0cGK0DNh
 ZqZKn3+8/Z+ksreWUKTZQ7VdeXSIIeTn2oWn1mxVhFKIazzphSXwR88gEqOoEj0uBjNU98Hz6LXxRl
 Lq0D3pPhcN9TLAENW/9ds8tK+eCNOfFIoeL83rSlxVQwh7ohEJfDd9xyaH7rhviRpbQoE+uCR1jlVs
 mdihSSYSuZ8zLcDmWUWXtll6lVS21Q6hn032+Rk1YZGEAprmkVxb2wKkXK82zh+tobYnM3yrp6vEO6
 c1j7cxsSIb95WstUS+OotdLOFfcLIUpfJ5uVy6LinSkNuRsb+qssnpY+bLgOT0juJoOprh+7pD1tSp
 H82IpFLrBMjlowlcTn+llN1I3IAtX8z9DIyqs7wqht18d/bbcpSU2B7A6H0QJhu1GUP2ucVTGyN8mc
 56YmcVJIw6qx4VM3C8msV12wW7Mcoj+CZWwmwWSmEtwNlkTdiZQQy1TmBpDcuBhS2S9D0TjAunBmQB
 08gQbK3UvBUYC36lNe7dp6JrLHl4RDvq1BvSiYJb7aOD1L38/JvVHiv3fm08P5sv/mc0+TU7caReZM
 gEHJAsKLKC0GTGN2xVw0JYvdFXUnKjXjRX/wtLMnTf/kM5UhGviv3m6Tlz4A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Currently the in-kernel PM arbitrary enforces that created subflow's
family must match the main MPTCP socket while the RFC allows mixing
IPv4 and IPv6 subflows.

This patch changes the in-kernel PM logic to create subflows matching
the currently selected source (or destination) address. IPv4 sockets
can pick only IPv4 addresses (and v4 mapped in v6), while IPv6 sockets
not restricted to V6ONLY can pick either IPv4 and IPv6 addresses as
long as the source and destination matches.

A helper, previously introduced is used to ease family matching checks,
taking care of IPv4 vs IPv4-mapped-IPv6 vs IPv6 only addresses.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/269
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---

Notes:
    v2->v3:
      - the helper has been moved to an earlier commit ("mptcp: netlink:
        respect v4/v6-only sockets") and to pm.c because needed to fix a bug.
      - the helper also takes into account different cases of IPv4 addresses
        mapped in v6 and has been renamed.
      - fill_local_addresses_vec() now considers v4-mapped-v6 as AF_INET not
        to change the behaviour and break selftests.
      - add_addr_accepted is not incremented if the ADD_ADDR cannot be used
        (e.g. v4/v6-only sockets)
      - if no subflows need to be created, the PM lock is no longer
        manipulated.

 net/mptcp/pm_netlink.c | 55 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2a43e13bacd..2729605c975c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -152,7 +152,6 @@ static struct mptcp_pm_addr_entry *
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk)
 {
-	const struct sock *sk = (const struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry, *ret = NULL;
 
 	msk_owned_by_me(msk);
@@ -165,16 +164,6 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		if (entry->addr.family != sk->sk_family) {
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			if ((entry->addr.family == AF_INET &&
-			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
-			    (sk->sk_family == AF_INET &&
-			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
-#endif
-				continue;
-		}
-
 		ret = entry;
 		break;
 	}
@@ -423,7 +412,9 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
 /* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
+static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
+					      struct mptcp_addr_info *local,
+					      bool fullmesh,
 					      struct mptcp_addr_info *addrs)
 {
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
@@ -443,6 +434,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 		if (deny_id0)
 			return 0;
 
+		if (!mptcp_pm_addr_families_match(sk, local, &remote))
+			return 0;
+
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
@@ -453,6 +447,9 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
+			if (!mptcp_pm_addr_families_match(sk, local, &addrs[i]))
+				continue;
+
 			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
 			    msk->pm.subflows < subflows_max) {
 				msk->pm.subflows++;
@@ -600,9 +597,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
-		if (nr)
-			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
+		if (nr == 0)
+			continue;
+
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
 			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
@@ -625,11 +624,11 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  * and return the array size.
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
+					     struct mptcp_addr_info *remote,
 					     struct mptcp_addr_info *addrs)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info local;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
 	int i = 0;
@@ -642,15 +641,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
 			continue;
 
-		if (entry->addr.family != sk->sk_family) {
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			if ((entry->addr.family == AF_INET &&
-			     !ipv6_addr_v4mapped(&sk->sk_v6_daddr)) ||
-			    (sk->sk_family == AF_INET &&
-			     !ipv6_addr_v4mapped(&entry->addr.addr6)))
-#endif
-				continue;
-		}
+		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
+			continue;
 
 		if (msk->pm.subflows < subflows_max) {
 			msk->pm.subflows++;
@@ -663,8 +655,15 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
-		local.family = msk->pm.remote.family;
+		local.family = remote->family == AF_INET6 &&
+			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
+			       remote->family;
+
+		if (!mptcp_pm_addr_families_match(sk, &local, remote))
+			return 0;
 
 		msk->pm.subflows++;
 		addrs[i++] = local;
@@ -703,7 +702,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, addrs);
+	if (nr == 0)
+		return;
 
 	msk->pm.add_addr_accepted++;
 	if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
-- 
2.37.2

