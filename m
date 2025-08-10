Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B051C6FE5
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754840378; cv=none; b=bAZk6jcDRfbaO02jYML5FDeAOgXcRJDeJG8uEg0iUeh3GtDsSTWCYG2rvnK7sLo8U9EhTpc43IuAODPVPaQIKqsgDsf7an3yS1jFWyJQPjQ3YITU4sJYEeCw9OGLPBWp1Md6hP2ajowW18OSyxlpEKPcYYf7eBGnIKkxziIkrt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754840378; c=relaxed/simple;
	bh=AXyFME8hPqDw6ZeiGZhLVvGW8AqPe5r1HS39bwV60Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=apMuZ877pVjRQLzmYey8GItwpF6H/p16uCaP1SDwrR5E7ZpAnexl1iLUCdzjzcxtY1ICk5MB2Bvz7Sln6lVM4sdFC24melDglQ2dtlt1NtmWfON/7jcCVjp0qvg893ex72oFFHafdjlb/h9f40uMZ5QBhgHqlEfn1rQK9lNXItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnGyF5yP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnGyF5yP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA9C4CEEB;
	Sun, 10 Aug 2025 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754840377;
	bh=AXyFME8hPqDw6ZeiGZhLVvGW8AqPe5r1HS39bwV60Pk=;
	h=From:To:Cc:Subject:Date:From;
	b=jnGyF5yPECV7kqOeOeSV+Vuu72ee+yIl+greagrPQZOeJdi1WqhRXXQB4blpwNABH
	 CERDSbF8bWh+pNtPomkkh8HR2ZxV7SZG5aUvyNXYHcCX/3K75zopGo4Y1EzrtJnExp
	 TyKTN0JM1+KltmQzMTzL4/XZ4yN6yfL/mzLWSEwbDJ1SH8wCi/9P6aeOyEAmjTPjuM
	 8titR6IN7hbj/9oRSiGIoTiAOdaPoY6YPriFKLlv9WB+mwyxASc6+qY3jgWajyPsoG
	 EyMNIQSHgzPqcNHTqZJKBHrWPf38lGp9pOflMoFaNOPrdB495iB0IA38ql5R5E1rSA
	 Y1Dnzm7fVfe8w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] tcp: md5: remove redundant l3flag variable
Date: Sun, 10 Aug 2025 23:38:52 +0800
Message-ID: <93d3186f303d1242a0bde737aeda97959c1eb5cc.1754840319.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The l3flag variable was redundant as it duplicated the value of
the 'flags' variable which already contains the interface index flag
status from cmd.tcpm_flags. This cleanup simplifies the code by
eliminating unnecessary variable duplication.

Changes:
1. Remove l3flag variable declarations
2. Replace l3flag usage with existing 'flags' variable
3. Maintain identical functionality with reduced complexity

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp_ipv4.c | 7 ++-----
 net/ipv6/tcp_ipv6.c | 9 +++------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 84d3d556ed80..e04cd0652ab3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1519,7 +1519,6 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	const union tcp_md5_addr *addr;
 	u8 prefixlen = 32;
 	int l3index = 0;
-	bool l3flag;
 	u8 flags;
 
 	if (optlen < sizeof(cmd))
@@ -1532,7 +1531,6 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 		return -EINVAL;
 
 	flags = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
-	l3flag = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
 
 	if (optname == TCP_MD5SIG_EXT &&
 	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
@@ -1541,8 +1539,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 			return -EINVAL;
 	}
 
-	if (optname == TCP_MD5SIG_EXT && cmd.tcpm_ifindex &&
-	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX) {
+	if (optname == TCP_MD5SIG_EXT && cmd.tcpm_ifindex && flags) {
 		struct net_device *dev;
 
 		rcu_read_lock();
@@ -1570,7 +1567,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET, l3flag ? l3index : -1, false))
+	if (tcp_ao_required(sk, addr, AF_INET, flags ? l3index : -1, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET, prefixlen, l3index, flags,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7577e7eb2c97..b2bfc5f03393 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -610,7 +610,6 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	union tcp_ao_addr *addr;
 	int l3index = 0;
 	u8 prefixlen;
-	bool l3flag;
 	u8 flags;
 
 	if (optlen < sizeof(cmd))
@@ -623,7 +622,6 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 		return -EINVAL;
 
 	flags = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
-	l3flag = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
 
 	if (optname == TCP_MD5SIG_EXT &&
 	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
@@ -635,8 +633,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 		prefixlen = ipv6_addr_v4mapped(&sin6->sin6_addr) ? 32 : 128;
 	}
 
-	if (optname == TCP_MD5SIG_EXT && cmd.tcpm_ifindex &&
-	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX) {
+	if (optname == TCP_MD5SIG_EXT && cmd.tcpm_ifindex && flags) {
 		struct net_device *dev;
 
 		rcu_read_lock();
@@ -671,7 +668,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 		 * See the comment in tcp_ao_add_cmd()
 		 */
 		if (tcp_ao_required(sk, addr, AF_INET,
-				    l3flag ? l3index : -1, false))
+				    flags ? l3index : -1, false))
 			return -EKEYREJECTED;
 		return tcp_md5_do_add(sk, addr,
 				      AF_INET, prefixlen, l3index, flags,
@@ -683,7 +680,7 @@ static int tcp_v6_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET6, l3flag ? l3index : -1, false))
+	if (tcp_ao_required(sk, addr, AF_INET6, flags ? l3index : -1, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET6, prefixlen, l3index, flags,
-- 
2.48.1

