Received: from mta1.migadu.com (out-58.mta1.migadu.com [95.215.58.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04D44A3F1
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046527; cv=none; b=NmZBn6Xdw7WR88xiEaRQBwGZt2Lbcb12DuBW6HhMkS+L+cRFZIhXy4Z8JW/I+gT1740QiPkf4luOKT5l9DtgUob5u3OASNpPVS4FmhOjt8Yalp/1AWunu/XTQjy4aQUO48CSYN0mK0ynCgq/mz9UiAkYxqfXeM00uLC/ydEK94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046527; c=relaxed/simple;
	bh=05cTNLwMT8/hVXFkto5mbiM22GsL41QZB1BhW/KJ1mI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPwyuTnusbF1spqphSIJRBdu861bOMxx3VQo04SvosKbEp6RS9dCjV75ROtDf2MstvRPI7GJ0T5AvxymMOMHQ2t/2bxFmZeS7hQZReaPzNwZUs9yQ1836mPX1N8bdcS1U0ZuJhtZo/cZy6WTDPFCebRbzotJS7KqQ0SC1PymQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QPgjpA21; arc=none smtp.client-ip=95.215.58.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QPgjpA21"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=05cTNLwMT8/hVXFkto5mbiM22GsL41QZB1BhW/KJ1mI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046523; v=1; x=1787651323;
 b=QPgjpA21v0ZpHBgroOpNJpufNUoXk1lwiEOvP9+uNwmtv2oQx3NKT0NA29afUXzpkSb0rOfi
 7nexyj6bgI+1f8FDXQ0t5g/seX94eq1195E8Fon83cVoVZcR44LEGNmyAO5/N/Ajkpj7L7USFh8
 H9E4Uy6dB89r2r+v53g1+DjA=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id b2c84cbadcce5fdb;
	Tue, 18 Aug 2026 09:48:43 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 3/5] mptcp: use READ_ONCE() over sysctls
Date: Tue, 18 Aug 2026 17:48:23 +0800
Message-ID: <20260818094825.48446-4-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818094825.48446-1-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
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

Also write the pm_type field derived from the path manager name with
WRITE_ONCE() in proc_path_manager(), to pair with the READ_ONCE() on
mptcp_get_pm_type() added by this patch.

Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index c0481b09c1a1..733706f06f1b 100644
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
@@ -251,7 +251,7 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 				pm_type = MPTCP_PM_TYPE_KERNEL;
 			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
 				pm_type = MPTCP_PM_TYPE_USERSPACE;
-			pernet->pm_type = pm_type;
+			WRITE_ONCE(pernet->pm_type, pm_type);
 		}
 	}
 
@@ -572,7 +572,7 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 
 	net = sock_net(ssk);
 	timeouts = inet_csk(ssk)->icsk_retransmits;
-	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+	to_max = READ_ONCE(mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback);
 
 	if (timeouts == to_max || (timeouts < to_max && expired)) {
 		subflow->mpc_drop = 1;
-- 
2.43.0

