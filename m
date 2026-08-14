Received: from mta0.migadu.com (out-115.mta0.migadu.com [91.218.175.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE33C3F5B
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 03:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786678082; cv=none; b=qAxkHK9i4nKLAT/FggSpNiT66xiz3U0ZFk8eURZvq/7M939h1GT4bl6qz8FoyKTlNuhJNwiVgxQvg0jjrS7e+plKdTe8wIXwwM11BHxc58Iea75+Spgd6z1QyqtPXLLQKPciO63qM01yjfReLFI/yR749UMzvCPpX3DMoAYdCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786678082; c=relaxed/simple;
	bh=mHD4B+jARIxWcsDVS0BR+Rm441PM3N/jXtts10HLGcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hS882CMeJEGNMcG1DuxlUxJM3e2zIs/cenO9XsLkCrpe6HqXw34V+TsuMcHKP6vWk8bfzUdoICKisBHL3+BkmR6qb64eIeAK8Vo3pEHgYV9T+46G8b+MWvo+bufrSj1uPP8L/KRU3hyu/nPj8262DLG/wL9ru/8lrZK98dU0um4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bLit9NYb; arc=none smtp.client-ip=91.218.175.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bLit9NYb"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=mHD4B+jARIxWcsDVS0BR+Rm441PM3N/jXtts10HLGcA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786678077; v=1; x=1787282877;
 b=bLit9NYbaRSbnQ3ThPoPxpfwI/4nEpIEw79YP6mZQoK740sI6mpsc9T+mmzOwvVvDBouyOjj
 eGWMscV2GxlxqU9CBU741OT4AuvqyP1nlc4xZapQeRtBLbBXgKVNehBAjEU51v7/WY2XCzQF309
 L/sGxm+6yop74RtS3iMDcg60=
X-Envelope-To: mptcp@lists.linux.dev
Received: from ctao-book.. (111.162.215.50)
	by smtp.migadu.com with ESMTPS id 6353f9d69b88a8f2;
	Fri, 14 Aug 2026 03:27:57 +0000
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [RFC PATCH mptcp-next] mptcp: annotate data-races around sysctl reads
Date: Fri, 14 Aug 2026 11:27:49 +0800
Message-ID: <20260814032749.2222975-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

#626 plans a READ_ONCE-over-sysctls series for the string sysctls; this
is the numeric side. Asking whether to send it on its own or fold it in.

The per-netns MPTCP sysctl values (net.mptcp.enabled, add_addr_timeout,
checksum_enabled, allow_join_initial_addr_port, stale_loss_cnt,
close_timeout, pm_type) are written from the sysctl handlers and read
without locking through the ctrl.c accessors.

Add READ_ONCE() on the readers and WRITE_ONCE() on the pm_type store in
proc_path_manager(), matching what is already done for other mptcp
fields (fully_established, local_id, remote_id, sysctl_tcp_wmem[0]).

The string sysctls (path_manager, scheduler) are not covered: they need
atomic replacement, see the tracker below.

KCSAN reproduces the race on net.mptcp.enabled, and the READ_ONCE makes
it go away:

  BUG: KCSAN: data-race in mptcp_is_enabled / proc_dou8vec_minmax

  write to 0xffff8f93c18553e9 of 1 bytes by task 214 on cpu 1:
   proc_dou8vec_minmax+0x1b1/0x200
   proc_sys_call_handler+0x268/0x350
   vfs_write+0x423/0x710

  read to 0xffff8f93c18553e9 of 1 bytes by task 72 on cpu 0:
   mptcp_is_enabled+0x50/0x60
   mptcp_init_sock+0x2a/0x1c0
   inet_create+0x3f9/0x5a0

  value changed: 0x00 -> 0x01

No functional change.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/626
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/ctrl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..b0ef6aea4eba 100644
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

 const char *mptcp_get_path_manager(const struct net *net)
@@ -230,7 +230,7 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
 				pm_type = MPTCP_PM_TYPE_KERNEL;
 			else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
 				pm_type = MPTCP_PM_TYPE_USERSPACE;
-			pernet->pm_type = pm_type;
+			WRITE_ONCE(pernet->pm_type, pm_type);
 		}
 	}

--
2.43.0
