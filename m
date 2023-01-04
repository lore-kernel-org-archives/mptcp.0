Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58CAD55
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:15:58 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id fc4so84149798ejc.12
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9AFSUFfwnnN5pBtjBJ8jxeWxFDb6GcqJiEe5i0JjJ0=;
        b=dDbEmyJEq5RfSoRGMGDDcdPM6wbU+5EYjhtXOX3CR0xipDdla0wDeyel8h4MtVOIAy
         kjwXxCb4kTPQtz11o5BQ8kP2M/32w5+xZlMSsQ5A60WKU80iHs7j69P8HHfAYnFsO5WI
         IikWXXo5lvGkQwCRf28CUSilZm+zcSgkeVXXkjD13zlfVv4Ykt5jBFt3djIVH1wzSFKh
         RulDRO2RFiADu6nyzFjYEBaJIl8u9vXEDJ4hmSjAQlnnpCVBk8UOoGZKGyDsLSwcfg5+
         cytLv6083VDuQMO98P+auk5t6+vZAb1yfsKFcYElUZ4SBtO12+yYk9slZwotU6niGIgL
         +Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9AFSUFfwnnN5pBtjBJ8jxeWxFDb6GcqJiEe5i0JjJ0=;
        b=x/GefkJ/h/zGLfFE+ad/+FF83NUGl456+KvBGBMUysp/qgJiV477rwtIGry9Ao+uMd
         ty2YHwX8twYoREOK4dXt7Igf+EhLPfQIW6dzIvBgJP75v8HhkauJ2gKXkUMuZCmxuyrk
         NncR4/5i+t0VysMIsY2BICYU7wJJQzSQJmM5IGYEVIazIwNeH5H5jYIpAMFPOt0esvNI
         TNSlIlWQsTLjb24/GQ/ZXglVwPPiTXTUy43VbCEGEFjSQ6bb4oLkFh/PrQG5BUEb7ta7
         5AH6Nh0+8UG8NPiGk1Zx0P/188pUlOG3Fd1HaxevCUTWqxApBFShclHBll308XCUnoAa
         Zufw==
X-Gm-Message-State: AFqh2ko2wqixzMILpVw7KRUdQA3urcrYnfPObGfrhlxGWERK3fr6zqzU
	v7B044yv1tcRAbpKtyQqEqekJ49TwWXKEOYffrg=
X-Google-Smtp-Source: AMrXdXuPH5nyB2fgKkpbFMAie5cp2UhkAKmCg6/R6AtB+AM7rE83i3mhfq3lccpN9J3SEk8cCb3cvg==
X-Received: by 2002:a17:907:d601:b0:7c1:2d36:d11a with SMTP id wd1-20020a170907d60100b007c12d36d11amr46890433ejc.11.1672852556907;
        Wed, 04 Jan 2023 09:15:56 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:56 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 04/12] mptcp: let the in-kernel PM use mixed IPv4 and IPv6 addresses
Date: Wed,  4 Jan 2023 18:15:18 +0100
Message-Id: <20230104171526.1416746-5-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6570; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=EZau0IcHuZezehsM4S+L+WmU7fdtiMnSXR0653fkPKA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQHpM1oE+giBOmJ8py3SqUsjBASiJzO0F9PAm0P
 OC6/aAuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0BwAKCRD2t4JPQmmgc2uKEA
 CzxXZGt6ofJAUa5MHWglIJ/XeTP5cDjRutGeWPWk1A9gms9FO21JdO6NbnDrxObOVCvXXOXarqQ0Dg
 nR5/uLsC16vdMbAdT8+uFyqQ6LO9WQi2dwmAOSV4+K3bZovM5flZgBD9Fcq51XAgKPNWODly8Yj1PP
 C44Vhy58U3NeoBv40jco/bpQc/n7dxMABVcO0UU4BaxKFMApo/O9K5fUCQfx8mncyCEkiKiKT44Iv1
 HEGeLJ8V3sp/GXaWoHaJB6+Rq/pxM4f1x23lsCU67mW9pFTlUGxN337+k65BXsAX+m1XRf9nxZyhtt
 x+sTAJHk4jvGo6NXX92l53hFBtFQ7Q4Q7iJtru9/JGAUoi7hgQikOA7cMvNDvzVMmw6j1rScRjcE4F
 Gc7fI9tj1rsKAVMdlw7C/LiRV1X8ZQ8mBfvwq/ocAY54YViBdhZjUr7DMSUZbPZkSz21uQBpuZu962
 9KCyg4pmg/HpwW0Z/D8KNIuOp8bjsG5A/rZOSjnD7LJiTfWgVV++6JBDo88WoNQo79i8ZexVnohVNi
 J9snVk1kRdjHIh61akO1PUMrsibToODoahi1Y+CUIQkp/fFIqvdQkWrDz5VIZOtxzZWzpRpCJV+C87
 dXdMv+QJpDpIY/a0lhsDB5yHrOUXtWKcJLkQr36Yre4jZSrHG3JQRtLOqe3Q==
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

