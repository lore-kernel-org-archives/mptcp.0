Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C171225788
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380062; cv=none; b=DgflnEFZ4cOznqRgtAr3I3cXzY76+XiPJLMlwuPSMjkvsfbtCU8eRUR5ms2a3vYeF3/dh2uxUI5VaK4dt1lSYlJN+AGuM+rt+LH58MgWghuL/ldbs6xcU2a33OJHZ3iFKUAg5zj8z+wd9RG4UAxlMQ5u7nuwysRs0X5vlGZeV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380062; c=relaxed/simple;
	bh=C9mYyO7qxj8YvjUdR4FXom/eD4KslfnHvcgYxG89tVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU6r9S8kl3CMTibGIbhveEaSlq8FZMJ/iDaqWlefs/TFskgNbYPxYQV8r8JA/o1oATZW2jIBOLG7C8pAOxMwgz4+dYFHeuEr+PqjHwIkz+d7s7AFEdfYGLiRto9XkfMwjO/wx2g+2NrxbH3YRG804xbyCmb2Iinl4Tf3wOecZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoAuRP1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoAuRP1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B391F00A3A;
	Thu, 30 Jul 2026 02:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380061;
	bh=bdpU5bkv5EDXMSRKKRe14O+/iRuTrTAescYnIhdNy64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aoAuRP1E1Qc1YA5GTc9ZWjCJc+fZewD8gXCnShnBb5h5Vykyl6VaXRzsrRjrT00IJ
	 1TLYGP5RsHBGMhEFE8EjrYXvDpGaz5clIThMxyTQBIBEEQzPG5nw7JPfwjv7SzGg4C
	 0jOBZu19+224HnTGVoH+ytPJjNrcdpBAp3LokYGmWyp5sqizTxUY1Oth7fIAEV8ayE
	 oifblta/vUZa1TThEMADHRv7wnls7Ai3m62mazEjHca7YN02eZq4bmNCJZy8xm7x3S
	 tGtUuExEyI1mogHtUgD0Rq2Bcwz8EkSXx8KdXz0aymoPXPNKEn5yqsid03Lz3T914v
	 OTk/Yo6+CrOlQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 05/10] ipv6: extract and export ip6_sock_set_tclass helpers
Date: Thu, 30 Jul 2026 10:53:58 +0800
Message-ID: <38818ad1f4e454278de4542ea9a88cb4d2ec8c0a.1785378180.git.tanggeliang@kylinos.cn>
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

The IPV6_TCLASS case in do_ipv6_setsockopt() inlined the same ECN mask
handling and inet6_sk(sk)->tclass write that callers need to do when
propagating a tclass value onto a freshly created socket.

Pull this into small helpers exported via <net/ipv6.h>, so external
modules (e.g. nvme-tcp, nvmet-tcp) can apply IPV6_TCLASS without
duplicating the ECN handling.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/ipv6.h       |  3 +++
 net/ipv6/ipv6_sockglue.c | 31 +++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3de07e738538..82e57b34ba57 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1252,6 +1252,9 @@ static inline void ip6_sock_set_recverr(struct sock *sk)
 	inet6_set_bit(RECVERR6, sk);
 }
 
+void __ip6_sock_set_tclass(struct sock *sk, int val);
+void ip6_sock_set_tclass(struct sock *sk, int val);
+
 #define IPV6_PREFER_SRC_MASK (IPV6_PREFER_SRC_TMP | IPV6_PREFER_SRC_PUBLIC | \
 			      IPV6_PREFER_SRC_COA)
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b4c977434c2e..c59f25fbb336 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -373,6 +373,28 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optname, sockptr_t optval,
 	return err;
 }
 
+void __ip6_sock_set_tclass(struct sock *sk, int val)
+{
+	u8 old_tclass = inet6_sk(sk)->tclass;
+
+	if (sk->sk_type == SOCK_STREAM) {
+		val &= ~INET_ECN_MASK;
+		val |= old_tclass & INET_ECN_MASK;
+	}
+	if (old_tclass != val) {
+		WRITE_ONCE(inet6_sk(sk)->tclass, val);
+		sk_dst_reset(sk);
+	}
+}
+
+void ip6_sock_set_tclass(struct sock *sk, int val)
+{
+	sockopt_lock_sock(sk);
+	__ip6_sock_set_tclass(sk, val);
+	sockopt_release_sock(sk);
+}
+EXPORT_SYMBOL(ip6_sock_set_tclass);
+
 int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		       sockptr_t optval, unsigned int optlen)
 {
@@ -713,14 +735,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		/* RFC 3542, 6.5: default traffic class of 0x0 */
 		if (val == -1)
 			val = 0;
-		if (sk->sk_type == SOCK_STREAM) {
-			val &= ~INET_ECN_MASK;
-			val |= np->tclass & INET_ECN_MASK;
-		}
-		if (np->tclass != val) {
-			np->tclass = val;
-			sk_dst_reset(sk);
-		}
+		__ip6_sock_set_tclass(sk, val);
 		retv = 0;
 		break;
 
-- 
2.53.0

