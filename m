Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31507280331;
	Sat,  8 Aug 2026 06:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786172169; cv=none; b=dLEQojh4oISrAVhGFbGRDXUmHn1MOOCiNHf4fA+C6md+jJNVhOUDcHeAHwxkrFpxD/h10dhvCyg1pq+fnC863y5pXtKSV9NT9TfBQIbFIS1s5xg7U9mf/kskq1fN8cHJEBMP+ZaV7pwtdoQKkT+kEoMtSV7R2fi5G/7iWjy9pHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786172169; c=relaxed/simple;
	bh=tjcQmC9X13vLV5s0rAOUH68SS0QKMQfhUttvxWBvD6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVuYvekZ+S1rWisbNUCN36JD8HnvjoEuHA1MM7A0eMR70h73v22ytpTgMwY/vhs9EDbhlNcxBIWWQyd/Y6YAc631I0V1qqlyDVIrer8BH6AhTHLR4xpB495BiyIwwevDL8AnnZJ6S1ksuQZ4hhrYfbsJMw6bZZI3ExX/0CL/rcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxWbENzL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxWbENzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CD61F00A3A;
	Sat,  8 Aug 2026 06:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786172167;
	bh=ypOrDttMwRDVN4cZ8OF0F/KPJUSC5NDL+vN1YYTZczA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxWbENzL8/t9ROL4iAURrGZ19ZdvtDa7J7tgtYzrNKosOEPh9KbfUpFJM/M2fPOJZ
	 axkqvX8FFnoEHZlUOoWPiDnJwoWU0Q0dMmsqO6Dskj+PBWH9KYgsx6KjCJZPzmN4cR
	 e1bA/PK5/YXvX9eQQIivitm9Vcts2yFOlf4Khm8KzNQh/cRcOF8Fv3iB+a6YStKXnO
	 UwgQakDrCWnGIDIhcFJvUrnYf362GDHjMwjzBWQViOlc462ac+57xLOx880AByRxL+
	 ajERHf6oa0o+TNuO7ASE6l5kGFY4WbSx4N7GBoSbS0UGAAE0N72ZT3Ai2JHFZN0S9S
	 yx5hVAiHVKVVA==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 1/3] ipv6: extract and export ip6_sock_set_tclass helpers
Date: Sat,  8 Aug 2026 14:54:59 +0800
Message-ID: <d06402e4fa9e1c879296dfb8ca5a73e34d4b13d2.1786171863.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

IPV6_TCLASS handling in do_ipv6_setsockopt() inlines the same ECN mask
logic and inet6_sk(sk)->tclass write that callers need when propagating
a tclass value onto a newly created socket.

Pull this into small helpers __ip6_sock_set_tclass()/ip6_sock_set_tclass()
exported via <net/ipv6.h>, so external modules can apply IPV6_TCLASS
without duplicating the ECN handling.

__ip6_sock_set_tclass() will be used by MPTCP's sockopt implementation
(similar to __ip_sock_set_tos), while ip6_sock_set_tclass() will be used
by nvme-tcp (similar to ip_sock_set_tos).

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

