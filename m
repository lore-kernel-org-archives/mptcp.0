Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F9374A1F
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556996; cv=none; b=W9VHsi8hzq+UMRiJU9pLfFG+5kcWGJEdRWhslwrt4AFIuqBvHr4aSPC+CYGVhrqmDGB30P1aihD8K5TfpjkPcyLOVq7ItiNreHd5MIwN8ic4ubhMczSZJ3SYLAO0+64TSGxDUVQj2FLEMxOlR/ZH+evqXRR7yUOLohgtYlKBHnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556996; c=relaxed/simple;
	bh=f8tgCjT83aIcTUbhHk9sOl+jqy/sFiMJokips0njS/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFl3vAbnSITZm2tu0IzjwwfdcEKjln/lW+gp2pKgdN9NVEojVkoM4wKlzxAaypU2BvL1lHIc+uad8XEfTBb3KLhd8eMt9JwEREU2sRpJFlkwovUXVc6NoCEIIpmmRlVBio7cMhyKwGMUoGN4HNv/xKxQilQbOIJ6e0IcKPS9GXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tptF59do; arc=none smtp.client-ip=95.215.58.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tptF59do"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=f8tgCjT83aIcTUbhHk9sOl+jqy/sFiMJokips0njS/M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787556992; v=1; x=1788161792;
 b=tptF59do4VBDPcxbXsXHNAit1b6kxxzrcFJoPojguusB+nH5D9Ec4QYMHihgSB2F+dJANhOR
 ojJTsdAhAE0guanP0HO/WBk1mJEfTwHwv+fP+qs/d7jYvUeKnKkwSkM/FHhOMrrE4+UQQbi/koI
 xwUbJqZNiEkt4ADIRBXVOYFo=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 48e89d095ac9123c;
	Mon, 24 Aug 2026 07:36:32 +0000
X-Mizu-Trace-ID: 48e89d095ac9123c
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v4 3/6] mptcp: use READ_ONCE() over sysctls
Date: Mon, 24 Aug 2026 15:36:22 +0800
Message-ID: <20260824073625.57471-4-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824073625.57471-1-gang.yan@linux.dev>
References: <20260824073625.57471-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

To avoid KCSAN issues.

This patch is in theory for -net, and will need to be split in multiple
patches, with different Fixes tags. But I prefer to wait for Eric's
patches, as I noticed he already started to modify mptcp_is_enabled:

  https://lore.kernel.org/CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com

Still, keeping this patch in this series, not to forget about it.

Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 76ff2a41ba38..5a75f9b76d15 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -50,39 +50,39 @@ static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
 
 int mptcp_is_enabled(const struct net *net)
 {
-	return mptcp_get_pernet(net)->mptcp_enabled;
+	return READ_ONCE(mptcp_get_pernet(net)->mptcp_enabled);
 }
 
 unsigned int mptcp_get_add_addr_timeout(const struct net *net)
 {
-	return mptcp_get_pernet(net)->add_addr_timeout;
+	return READ_ONCE(mptcp_get_pernet(net)->add_addr_timeout);
 }
 
 int mptcp_is_checksum_enabled(const struct net *net)
 {
-	return mptcp_get_pernet(net)->checksum_enabled;
+	return READ_ONCE(mptcp_get_pernet(net)->checksum_enabled);
 }
 
 int mptcp_allow_join_id0(const struct net *net)
 {
-	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+	return READ_ONCE(mptcp_get_pernet(net)->allow_join_initial_addr_port);
 }
 
 unsigned int mptcp_stale_loss_cnt(const struct net *net)
 {
-	return mptcp_get_pernet(net)->stale_loss_cnt;
+	return READ_ONCE(mptcp_get_pernet(net)->stale_loss_cnt);
 }
 
 unsigned int mptcp_close_timeout(const struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_DEAD))
 		return TCP_TIMEWAIT_LEN;
-	return mptcp_get_pernet(sock_net(sk))->close_timeout;
+	return READ_ONCE(mptcp_get_pernet(sock_net(sk))->close_timeout);
 }
 
 int mptcp_get_pm_type(const struct net *net)
 {
-	return mptcp_get_pernet(net)->pm_type;
+	return READ_ONCE(mptcp_get_pernet(net)->pm_type);
 }
 
 static struct mptcp_pm_ops *mptcp_pernet_pm(struct mptcp_pernet *pernet)
@@ -586,7 +586,7 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 
 	net = sock_net(ssk);
 	timeouts = inet_csk(ssk)->icsk_retransmits;
-	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+	to_max = READ_ONCE(mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback);
 
 	if (timeouts == to_max || (timeouts < to_max && expired)) {
 		subflow->mpc_drop = 1;
-- 
2.43.0

