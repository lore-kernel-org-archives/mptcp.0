Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67B2F99B3
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334977; cv=none; b=f9G4N64XIKpDOQjDvpPE9moZbmgn9XQhc7XTWbJmRqmeLf4NrRZ28gQVYpKb9cXB1Dcc8cE7GxSNkyct8ao8NCQetfkbCSXwBfiXwCSJQbnQG3qzLflM8LXu0TDmVU1zn8jOuWXQusEPUbK8dVCvqmoWCweVlQKNuyY3IDDjUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334977; c=relaxed/simple;
	bh=8CbuYlkjmsSs7Ma5qCln9dfxTghgpfqX/J3N4LCnDj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDjHgZAOtgCQwl0W1Nj/VrAUmJW0b1eEko2DrTplVbIRXqc/vXV9RXajU5SMFzbD976K+JMmEwHIHcNDCcg5FplFhvVIwvj384xibqYqkb7Xdb5CtZDykHDAPjlxnr1ANFej0Im/vqjKjFXt/aAdDgsAJtORQFyRHAT7w0jmdfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcNNhPus; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcNNhPus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BD5C4CEF8;
	Wed,  5 Nov 2025 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334977;
	bh=8CbuYlkjmsSs7Ma5qCln9dfxTghgpfqX/J3N4LCnDj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dcNNhPusf7mZ2+FP1R8o6bpcHlF1Er/OBjK8RQc5yB41zdovfdY250gU0+/75XcYS
	 oCFm26DA/PHTV/urpE5vBYGRph5xkK8xU1+KCrM68GWhmgKeU3dBMLpLLbf11hvrIt
	 U7y1K9me3PhtwHi+yYIWunm2ORY9q7Q9P3eGlRm+UaRJxovZ2iCln9ORPKZabhTpyl
	 pHzELaW7NWisc/GiCeXspZpF4TP7LcInxYHCfwCHOhS+u/XfCUKwGk88eA58iG69EV
	 prCBHQihvLsk+25OZWMdlVExJE0r6rg70JMvM0COIULKeJDKAZnGAjfd3lAzh43NF0
	 4VjBTr3Lr3K2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/7] tcp: md5: remove redundant l3flag variable
Date: Wed,  5 Nov 2025 17:29:24 +0800
Message-ID: <12ffcf64dc2c0b371183bf0c932043ae92e93baf.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The l3flag variable duplicates the value of 'flags' which already
contains TCP_MD5SIG_FLAG_IFINDEX status. Remove it to simplify code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp_ipv4.c | 7 ++-----
 net/ipv6/tcp_ipv6.c | 9 +++------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b7526a7888cb..2584ccae01e5 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1512,7 +1512,6 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	const union tcp_md5_addr *addr;
 	u8 prefixlen = 32;
 	int l3index = 0;
-	bool l3flag;
 	u8 flags;
 
 	if (optlen < sizeof(cmd))
@@ -1525,7 +1524,6 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 		return -EINVAL;
 
 	flags = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
-	l3flag = cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX;
 
 	if (optname == TCP_MD5SIG_EXT &&
 	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_PREFIX) {
@@ -1534,8 +1532,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 			return -EINVAL;
 	}
 
-	if (optname == TCP_MD5SIG_EXT && cmd.tcpm_ifindex &&
-	    cmd.tcpm_flags & TCP_MD5SIG_FLAG_IFINDEX) {
+	if (optname == TCP_MD5SIG_EXT && cmd.tcpm_ifindex && flags) {
 		struct net_device *dev;
 
 		rcu_read_lock();
@@ -1563,7 +1560,7 @@ static int tcp_v4_parse_md5_keys(struct sock *sk, int optname,
 	/* Don't allow keys for peers that have a matching TCP-AO key.
 	 * See the comment in tcp_ao_add_cmd()
 	 */
-	if (tcp_ao_required(sk, addr, AF_INET, l3flag ? l3index : -1, false))
+	if (tcp_ao_required(sk, addr, AF_INET, flags ? l3index : -1, false))
 		return -EKEYREJECTED;
 
 	return tcp_md5_do_add(sk, addr, AF_INET, prefixlen, l3index, flags,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7df21c1cba21..184b223fa0db 100644
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
2.43.0

