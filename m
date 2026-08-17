Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A91DA60D
	for <mptcp@lists.linux.dev>; Mon, 17 Aug 2026 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929905; cv=none; b=fZTIqzG6mQMTWiIEE8dnl2D0kbVHYg6D4ZQ0noryXXhD4ktxRBavplRMy3GuloBMYkQYZjEQ2dZbl6eehvRoXtdYMdnj1xvFY3tSaLqraXOFP2L/8qDGyDn5xOcJBHIbfhWgIla1wPUp2w77GC2EgTpXwFZzON9jr1RUP3gIBCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929905; c=relaxed/simple;
	bh=Nqb9mmwXW1X6inPAqyP+MG9t0GgIXJC/mk9ewJPmndM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u66u5IrTnkNvWYY8yzwWujsRVrxlCgUeydmORaAFdy6OEY7mPYwTUgqPo14DCrdrvfLWtQmsj7CqLWwes2DIDs0NAWJWWK5MQIp76kdLOfOT19rikppgd8Ut2snowJoFi8DJE/zsLvMxU2oSIFJDsc8ypDfG3QW2CZTBaV9GSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HkvO5sRF; arc=none smtp.client-ip=91.218.175.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HkvO5sRF"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Nqb9mmwXW1X6inPAqyP+MG9t0GgIXJC/mk9ewJPmndM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786929901; v=1; x=1787534701;
 b=HkvO5sRFUOCAkZlEsCrSR9A8ZIAp5NjcejIHgQLYauEU53dDV1edO7mvjPN/6WB5kegRZKfT
 D5h+ptrHuMx9+LXPttuvGm+8E9rymhXpB+elHAYKRO/WHZn2PKY0yiAqFLnF0whEixDHsJZ8P/Q
 y2HYFSQqoGle0xaJ3VweYXys=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 088fd7490c298bf8;
	Mon, 17 Aug 2026 01:25:01 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH mptcp-next 3/3] mptcp: use READ_ONCE() over sysctls
Date: Mon, 17 Aug 2026 09:24:52 +0800
Message-ID: <20260817012452.7519-4-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817012452.7519-1-gang.yan@linux.dev>
References: <20260817012452.7519-1-gang.yan@linux.dev>
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
index fa28aecfb856..309bbb2a4eb0 100644
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
 
 void mptcp_get_path_manager(const struct net *net, char *name)
@@ -589,7 +589,7 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 
 	net = sock_net(ssk);
 	timeouts = inet_csk(ssk)->icsk_retransmits;
-	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+	to_max = READ_ONCE(mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback);
 
 	if (timeouts == to_max || (timeouts < to_max && expired)) {
 		subflow->mpc_drop = 1;
-- 
2.43.0

