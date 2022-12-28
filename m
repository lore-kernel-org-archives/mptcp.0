Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EED10E9
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:11 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id u9so37538562ejo.0
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9AFSUFfwnnN5pBtjBJ8jxeWxFDb6GcqJiEe5i0JjJ0=;
        b=8DBQ2DG3J8F4eCbPXZaDSpi9MmaVUAM2n2kMEVqGDNperVPT9JCi2Jp9xsO725YYdl
         9Pd+YinZFiYhKSlfYRCz6F8hqFiQ1XIKqS6uvGM19en6/AFzsupm51cke3ivZtRdP7os
         wyCYY57CuA9E8O3yu+op/hrCwiseV5of2npVFD7QNopgXNfvxGX64hO317hRb0sx/ICI
         ANoLMocICZ2p0rOkQLYjwahfgK6NxUSNq4Ice/iQCbyViTXOPDTOS6FJ5CuaTVw332Qf
         +gwD5PFOEDRX0C3MC1xLmaHfoJ0mpiRX7zmjemxQWT/tEKtVV6POU1XLXKCLVJvAXJAi
         CuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9AFSUFfwnnN5pBtjBJ8jxeWxFDb6GcqJiEe5i0JjJ0=;
        b=UjEVkVNT9lxG/hc2D9vcZf8+uce6qh7vkEInSfmn0EXlYEeCZTGwOmmOCKcgD1aXIx
         Ht4seFmZ84u39BoqOuDuvpMujos4ATttfJxlfHOTlyMCtHAhPUac+ouhB/abEGWTh48g
         F88FC8KHI/bfjwNIXjajqkZNvLkjXJTjXlpWGYC0MbvDxrzXm2eNvL0p5CdmBXkk377O
         1L9KH9y3F7vxkH44ZWmanmTP2h21T08PWbs2Z5X/M/o9AM1mjsogdbRCWr1+7sf7lOn5
         gmJzYn7DlbGWO6mDIx+tC3qXFWHOiY0illrnlH1MD1M0M7m9Fcg+8LlEaw4Vr8Mxs/6F
         MILg==
X-Gm-Message-State: AFqh2kq29VnUg/ennAGGydXAdUN81tnGsZRQnygqUBqKUdfaB71dVU8f
	hWfiiRzb4wQ+2AST5rZFI2UdTO1ZsSjkQOPpJqrLZw==
X-Google-Smtp-Source: AMrXdXuHPLYkZv6d4mekO7JoMKKDNE0hR586tU1cGVX7PcgCRo5f8WHiTwmvXfiNRN8anGk7ZVelpA==
X-Received: by 2002:a17:907:6d0b:b0:83f:1f64:c1e with SMTP id sa11-20020a1709076d0b00b0083f1f640c1emr22551860ejc.47.1672222689488;
        Wed, 28 Dec 2022 02:18:09 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:09 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 04/12] mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
Date: Wed, 28 Dec 2022 11:17:40 +0100
Message-Id: <20221228101748.2518303-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6570; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=EZau0IcHuZezehsM4S+L+WmU7fdtiMnSXR0653fkPKA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe+pM1oE+giBOmJ8py3SqUsjBASiJzO0F9PAm0P
 OC6/aAuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvgAKCRD2t4JPQmmgc0BYD/
 9M8hCmeV/t0Inq55XLdeya3MQFa68lAl58elruu4YJTnhoatSsnXfI6427rTdLuLRZjbQgr8U5kOKc
 jk5yi+XJw1yOrSJvOq/7K8bEj9YV9Hf2E3p445Zs0LtYz0yXx5qP4nAQdt4Ho/oGN5MJ7fIYeVX+as
 lpDv1NHuyQ8e8f4vCMhxvkjNNjKDBcSezkO3N9I1HqKr1r1IMHZl5tgspXEMMzHsFK1SiGWgZQwxQ7
 y9IS0oQt95BrmhGO/GL2HjiL2CcOni0LfNbp62Cc3G1vzRdbbhfhYpEaNNq6ScJQzojkz3jhPBXO2g
 ObIYUc/kSdrHnvUjO+gq0m1si1WXKa+5FW5MAW2iyfjEHsH9ZGFMWSjRF/VrfNsp6EYsj/baIH4YZl
 at2Ki2FRR/tJ603Q4rhJtnQwNd1EeL3EqfdZ1JHjUCsHOlxSdkUp6wE/5oK1DLfPkvfs6qgWC7BKpb
 vLQGYS0bdv23BkpO3CpqVQ1tKtpGhbBP0Y/1sqHrgiWTuRHG8wlPHCdR/5N2XpK3tWqSOsE9iyqQX+
 YqiuzfcMTw+JOosv1m2SdiSZPKnqmJjRLuJ4z5fXMvUq9kxBKZEBBL8/Wo+KpSDK3KEICGiC1aMQYZ
 wZiByKfAWEKIUmjI8gz8iFqukKFs1xXsoxEojCuxCA9S12CSTVLu3xm4wIPg==
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
    v3->v4:
      - fix compilation error without CONFIG_MPTCP_IPV6
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

 net/mptcp/pm_netlink.c | 58 ++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f2a43e13bacd..e82a112b8779 100644
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
@@ -663,8 +655,18 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
+		struct mptcp_addr_info local;
+
 		memset(&local, 0, sizeof(local));
-		local.family = msk->pm.remote.family;
+		local.family =
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			       remote->family == AF_INET6 &&
+			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
+#endif
+			       remote->family;
+
+		if (!mptcp_pm_addr_families_match(sk, &local, remote))
+			return 0;
 
 		msk->pm.subflows++;
 		addrs[i++] = local;
@@ -703,7 +705,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
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

