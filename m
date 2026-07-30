Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364B305E28
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380056; cv=none; b=synqen9GZrPZB0593RqQN+AVGIekUTEGB03BMXbPO00PyMo6KlNf7CkGijW4cExxiQ4LlE8fu9QcMMCG5BF/71IMaXFArepcQo/ErXBvlNGO+OpD8bKjkA8CuDqdJW+QC8RKfN8GA3iEzWiOemd6ML/93pohu39u4Z0Rvcywx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380056; c=relaxed/simple;
	bh=s8pq05OInwO8anMtKSeboSR9vH0O5yCtMQNiEBAcHsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3nUcYO32i9eGtNUB+l1LnDrUf0eaee/m+PyzcsmIApwqz3jcsQKwGhHJJyDXforpfFFgT5ZtnWBnjh/e27lRzGL1f2I7udnAjjpc3aVCBN7x9GAWAVkpIWRE12DJ5XLtSsUz/ZSoxhfhbz1x2vvl3W2eGlbQOzVHvhkn5NIoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7S4yBSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7S4yBSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639BC1F00A3A;
	Thu, 30 Jul 2026 02:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380055;
	bh=swZuJTtqz0JiPaHZ7U6Tc7cZUI0KHu5XATW4pxYnpZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b7S4yBSjAOwTFvmf0RObG2ZWMmRZsC5mD+nh/HR975X/wi038pjS7RDw0JQGXbwUx
	 p3NoM4sc+CAkAqow+paS5PXnSmxOL3a6q/5gYkeXwXW4NWiJdtzDIVeFyeg/5Kk/oI
	 IGOKlrnAPPrCkccojXDVStZLuAsO77vJHXNeKGFMHLzudAzD3wXHokCJcBId5VJ2lD
	 i36HZpdd36+DFiYhH/d/9WLALyKW9pFVOrlGyRyJDnnKzETBnf0PZV3ZKnVBNjVYDp
	 dzYXDzzRx7N19T/hgsc4QLHIrYDOzJ9HniNdzjRxpeidJzSNhV6T+OgG8ih+M6Vicq
	 5kM46o90gpurg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 01/10] mptcp: preserve msk's sk_bound_dev_if on PM-default subflows
Date: Thu, 30 Jul 2026 10:53:54 +0800
Message-ID: <fc150fbcf8384d9ef0b3c650de3759399773a144.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When the path manager creates a new subflow via __mptcp_subflow_connect(),
it currently writes local->ifindex to ssk->sk_bound_dev_if unconditionally.
The value was previously synced from the msk by mptcp_sockopt_sync_locked()
-> sync_socket_options(), so the unconditional write in the connect path
overwrites that inheritance.

When the path manager leaves local->ifindex at 0 (no interface pinned
for this subflow), the write wipes the synced value and clears any
SO_BINDTODEVICE / SO_BINDTOIFINDEX binding the user set on the msk. The
subflow then becomes free to route over any interface, bypassing VRF and
per-interface binding restrictions the user explicitly requested on the
master socket.

Only override sk_bound_dev_if when the path manager actually picked an
interface for this subflow; otherwise keep the value inherited from the
msk.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/subflow.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..c39243c85f50 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1667,7 +1667,15 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	ssk->sk_bound_dev_if = local->ifindex;
+	/* Only override the bound device if the path manager picked one.
+	 * When local->ifindex == 0 the subflow must inherit sk_bound_dev_if
+	 * synced from the msk via mptcp_sockopt_sync_locked() - otherwise
+	 * SO_BINDTODEVICE / SO_BINDTOIFINDEX set on the master socket would
+	 * be silently cleared, letting traffic route over unintended
+	 * interfaces (bypassing VRF / interface-binding restrictions).
+	 */
+	if (local->ifindex)
+		ssk->sk_bound_dev_if = local->ifindex;
 	err = kernel_bind(sf, (struct sockaddr_unsized *)&addr, addrlen);
 	if (err) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTXBINDERR);
-- 
2.53.0

