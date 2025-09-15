Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CD28B7DB
	for <mptcp@lists.linux.dev>; Mon, 15 Sep 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757959889; cv=none; b=D5rr8y88Qw8LDGQke+7b37UUdp19PutYAuZxcCGxGTTOZdBfpPSiMwZnHRoLZNdYcvSrRGfdXTb/49mMff2dfT5SfmqcG0+DCL7IQnCkpSiLK0heJ+Rh4fpO2Ai2DEBiRG20iSvmddaBao2X5GmnJm6ig9MBrJfLPPfFjX3IWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757959889; c=relaxed/simple;
	bh=HIDhG+BeyXVdg/HuozQ8gYFALpURpCF+Tq9ZteTAXdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXBu+BgIfBicmBtN/rlgoAeBBk049+sOed3EsDlsKt4W2Kx+iH1k+DbfKAwtTp5+BgFq3JR+it+cB5UpIZgkXGvjtMosfTYCCBtvlHZ2hE+dT2+RewqCYxvrisoexnz7vKEdWroMjF5Oqy+GdQ+jn/1mCmJhyiJj8IxMjpndmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+VwlLrg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+VwlLrg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7422BC4CEF7;
	Mon, 15 Sep 2025 18:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757959888;
	bh=HIDhG+BeyXVdg/HuozQ8gYFALpURpCF+Tq9ZteTAXdk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d+VwlLrgqiy4yIPIwN6/KMmq1s9cwmsl1E3BQxDBaThnoMXYz1fIpjR8onW8eR1gB
	 voli+vIwT+iP39eTQ0UnP/tmNn7FMoNIVFihdnKlrCRyQUcmei/4AP2xQUEA+5WKdX
	 lvQJ5FFUYSTwujlapzIp+s2ZDePJ7jOYZVr1fkOlhgm6QWorJ36HFDci6bbtAW1CAv
	 e+ATlLxaOt2rJO77AG8StGkrEaABwO14l+OuCSKsuLcwAh0FoSmsda+NS5Ou8HtTDN
	 RNrlmgMteuMLYzLT65El9ZOaLlSZKAX7xorYHoTQSFHjTQBjyh57glRUBXH9p3f7e7
	 YJgWAxvyoZ6Dg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Sep 2025 20:11:17 +0200
Subject: [PATCH mptcp-net 1/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pm-c-flag-client-default-v1-1-6bb241e4d991@kernel.org>
References: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
In-Reply-To: <20250915-pm-c-flag-client-default-v1-0-6bb241e4d991@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5507; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HIDhG+BeyXVdg/HuozQ8gYFALpURpCF+Tq9ZteTAXdk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOhJ1lfqwZd4K37UkN607uSIu8PCdP7a+LV7x3FFr63
 3ZttenujlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImcimNkWPBM57L11Hmzpq4+
 MqeeeW7Lu74tS175eVXeKDh6RFZEgo2RYWfOqQ8/f5lM2LHsdPOjpzdPv+ZrSM4SifjWu5yRZ5p
 2PA8A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When servers set the C-flag in their MP_CAPABLE to tell clients not to
create subflows to the initial address and port, clients will likely not
use their other endpoints. That's because the in-kernel path-manager
uses the 'subflow' endpoints to create subflows only to the initial
address and port.

If the limits have not been modified to accept ADD_ADDR, the client
doesn't try to establish new subflows. If the limits accept ADD_ADDR,
the routing routes will be used to select the source IP.

The C-flag is typically set when the server is operating behind a legacy
Layer 4 load balancer, or using anycast IP address. Clients having their
different 'subflow' endpoints setup, don't end up creating multiple
subflows as expected, and causing some deployment issues.

A special case is then added here: when servers set the C-flag in the
MPC and directly sends an ADD_ADDR, this single ADD_ADDR is accepted.
The 'subflows' endpoints will then be used with this new remote IP and
port. This exception is only allowed when the ADD_ADDR is sent
immediately after the 3WHS, and makes the client switching to the 'fully
established' mode. After that, 'select_local_address()' will not be able
to find any subflows, because 'id_avail_bitmap' will be filled in
mptcp_pm_create_subflow_or_signal_addr(), when switching to 'fully
established' mode.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/536
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- I tried to find a simple solution that can hopefully be backported to
  cover the 'CDN' use-case.
- I tried to find a solution respecting the 'accepted add addr' limit,
  but I don't see how to... That's why here I limit the exception a
  maximum: when this limit is 0 (default case), only the first ADD_ADDR,
  etc. Feel free to share what you think about that.
- I have some additional code doing some cleanup, and I started to look
  at #503, which is a bit linked to that.
---
 net/mptcp/pm.c        |  7 +++++--
 net/mptcp/pm_kernel.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 02dfb379417e2843301f121039ec0d370b040ef7..fda8d1880224dedbbfb20954f93a04da435346df 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
+	/* id0 should not have a different address ; special case for C-flag */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+		    (!READ_ONCE(msk->pm.remote_deny_join_id0) ||
+		     msk->pm.local_addr_used != 0 ||
+		     mptcp_pm_get_add_addr_accept_max(msk) != 0))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index f30df8e884a0b3de9fb092e5774cafe08f6350ce..408801e20ed6e874b80ccbf38af76abc13615a3a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -389,10 +389,15 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool deny_join_id0;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	deny_join_id0 = remote->id && READ_ONCE(msk->pm.remote_deny_join_id0) &&
+			!READ_ONCE(msk->pm.accept_addr) &&
+			msk->pm.local_addr_used == 0 &&
+			mptcp_pm_get_add_addr_accept_max(msk) == 0;
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -409,6 +414,9 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
+			if (deny_join_id0)
+				__clear_bit(locals[i].addr.id, msk->pm.id_avail_bitmap);
+
 			/* Special case for ID0: set the correct ID */
 			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
 				locals[i].addr.id = 0;
@@ -419,6 +427,37 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
+	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
+	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
+	 */
+	if (!i && deny_join_id0) {
+		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+		while (msk->pm.local_addr_used < local_addr_max &&
+		       msk->pm.subflows < subflows_max) {
+			struct mptcp_pm_local *local = &locals[i];
+
+			if (!select_local_address(pernet, msk, local))
+				break;
+
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+			if (!mptcp_pm_addr_families_match(sk, &local->addr,
+							  remote))
+				continue;
+
+			if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+						  local->addr.port))
+				continue;
+
+			msk->pm.local_addr_used++;
+			msk->pm.subflows++;
+			i++;
+		}
+
+		return i;
+	}
+
 	/* If the array is empty, fill in the single
 	 * 'IPADDRANY' local address
 	 */

-- 
2.51.0

