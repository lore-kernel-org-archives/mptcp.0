Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1631A9FB0
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020510; cv=none; b=p0HVWRX8H73x3Nje+WlOv4heWwTNYSBh8djlXJQUUtEqRN/YdCimaa2+CkOdY1vB492/yqKxDUXabNTKEeMLYIb6vZkpbMey5n9Uw4I2O5vJFY4JyyPC/vJbU17ywjjwH+8UZSLNa24KpnJ9ItAxyyI52f8wOFjqm2TzH+yt1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020510; c=relaxed/simple;
	bh=NFR06h35glWZKnoPS6N0pkCotFZZGlj0ezm3vqJfUYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txT17AVA9FN7jEjJJoRadLDe/eQ9HfVpBbPA8IA6EC5zMxucsxsqHfzEWjvQ9xL1arEKi9Yj5SFxtUx/6ow5bT3dad8M7KgHiT3oU5H2iOJse9fHBs1XLrY/MOWzT3KkX1kHpO8WURjcHOrW4R1tKu6mPitKMI4yPGnQLPS/Ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juwxZeck; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juwxZeck"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9BAC4CEF0;
	Tue, 16 Sep 2025 11:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758020509;
	bh=NFR06h35glWZKnoPS6N0pkCotFZZGlj0ezm3vqJfUYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=juwxZeckVI5WzBT4LRn2Blhlg9RYF+EknOKsaqlxcZ5tQCgVaW8nxWg21TNdHZvVo
	 KotAg9IqJ20P8hJp/5fV4vqDA8cavUEeyDjYrH1lyMcOyV9GQwUHt4qKrHGbBizPOG
	 7x0AXgJoNwbxxDJr2LGSvHHqfpH7rHKC0jbmzojYwdsHKF3xo4UzSbR3LHIfiPEvVy
	 mivvc4uMrz++gOUquhTdueVJyAbWBAtqgfLRQ5o9EVlILbnWtEj01OQ5J2Zd/9WR11
	 prPd1AJzNiiQfHmBKpYK11367tkNdBqXd5L+Fye0CFZ7z+vyPb0Mf7ULxU1R0VhFpG
	 XhRt1hG2uUk7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Sep 2025 13:01:39 +0200
Subject: [PATCH mptcp-net v2 1/2] mptcp: pm: in-kernel: usable client side
 with C-flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-pm-c-flag-client-default-v2-1-3be2c5bc4d6a@kernel.org>
References: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
In-Reply-To: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6165; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NFR06h35glWZKnoPS6N0pkCotFZZGlj0ezm3vqJfUYQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJOOs86byl/+v//ZYZ5QovnnDOJzL91bbc/6+RrS7KyT
 mj82P3QvKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi0d8Z/nAfcXR6uMHa4MpK
 h2lp71+uns7PZsIpeuOA9Ox/qrL105UY/lmKZEz07rtS2siVp2m3XkhB+/oixclX3X0cn7Mu3xG
 uzwkA
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
- v2: move conditions to new helper (Geliang) + rename var, squash comm.
---
 net/mptcp/pm.c        |  7 +++++--
 net/mptcp/pm_kernel.c | 37 +++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h  |  7 +++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 02dfb379417e2843301f121039ec0d370b040ef7..edaf93fe6f86b32aee8e9bb88318b1dc2a7fcb5e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -637,9 +637,12 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	/* id0 should not have a different address */
+	/* - id0 should not have a different address
+	 * - special case for C-flag: linked to fill_local_addresses_vec()
+	 */
 	} else if ((addr->id == 0 && !mptcp_pm_is_init_remote_addr(msk, addr)) ||
-		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr) &&
+		    !mptcp_pm_add_addr_c_flag_case(msk))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index f30df8e884a0b3de9fb092e5774cafe08f6350ce..d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -389,10 +389,12 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	struct mptcp_addr_info mpc_addr;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
+	bool c_flag_case;
 	int i = 0;
 
 	pernet = pm_nl_get_pernet_from_msk(msk);
 	subflows_max = mptcp_pm_get_subflows_max(msk);
+	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
 
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
@@ -409,6 +411,10 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			locals[i].flags = entry->flags;
 			locals[i].ifindex = entry->ifindex;
 
+			if (c_flag_case)
+				__clear_bit(locals[i].addr.id,
+					    msk->pm.id_avail_bitmap);
+
 			/* Special case for ID0: set the correct ID */
 			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
 				locals[i].addr.id = 0;
@@ -419,6 +425,37 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	}
 	rcu_read_unlock();
 
+	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
+	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
+	 */
+	if (!i && c_flag_case) {
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9b5a248bad40491b678671b53f5f540d396a2a63..dd0662defd41c84474e44c559c571e3594b85d9e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1196,6 +1196,13 @@ static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
+static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
+	       msk->pm.local_addr_used == 0 &&
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
+}
+
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
 
 static inline struct mptcp_ext *mptcp_get_ext(const struct sk_buff *skb)

-- 
2.51.0

