Received: from localhost.localdomain (unknown [147.136.157.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66927314A6A
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224106; cv=none; b=WC3lp0CsnsNS603xNJk2Ek2c9p1etfbPmAaOYwr0svqfl3m/6gklL/43Bd2zP6TsZaMrSEzkQ/7lNIkfBOQYJeBbGCGUzOfUM9T6EmqthuKXKo9LyfK4LTS2OM6SJbYWcKmil3hkN1S5SlxGGxnmPEXHyzJ5DRX+cCB6qn7fYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224106; c=relaxed/simple;
	bh=etMuBpTxIdlG/0pe4ZoTPFAIyHc5Bzq7Zr2u5b8H8Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9fJNIZ6ztQ0EeClSmmlQB4XTF3B00ttJCisxB5uNlIh6CIJKJz8zM+4EfskpUOYBBYXc4kuqV1M6ysgn552B5NdI3HTE9yueUYrrYeOjESoJqJKwPxtSKwOhsxvBZFDzfB8HO0LBRg6VNbF+sbAj1Pm2v3WpHfRkorKFvbxFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id B43899291FE; Thu, 23 Oct 2025 20:54:56 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: mptcp@lists.linux.dev
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with BPF sockmap
Date: Thu, 23 Oct 2025 20:54:32 +0800
Message-ID: <20251023125450.105859-2-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023125450.105859-1-jiayuan.chen@linux.dev>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the server has MPTCP enabled but receives a non-MP-capable request
from a client, it calls mptcp_fallback_tcp_ops().

Since non-MPTCP connections are allowed to use sockmap, which replaces
sk->sk_prot, using sk->sk_prot to determine the IP version in
mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
incorrect ops to sk->sk_socket->ops.

Additionally, when BPF Sockmap modifies the protocol handlers, the
original WARN_ON_ONCE(sk->sk_prot != &tcp_prot) check would falsely
trigger warnings.

Fix this by using the more stable sk_family to distinguish between IPv4
and IPv6 connections, ensuring correct fallback protocol operations are
selected even when BPF Sockmap has modified the socket protocol handlers.

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0292162a14ee..2393741bc310 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -61,11 +61,16 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 
 static const struct proto_ops *mptcp_fallback_tcp_ops(const struct sock *sk)
 {
+	/* When BPF sockmap is used, it may replace sk->sk_prot.
+	 * Using sk_family is a reliable way to determine the IP version.
+	 */
+	unsigned short family = READ_ONCE(sk->sk_family);
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	if (sk->sk_prot == &tcpv6_prot)
+	if (family == AF_INET6)
 		return &inet6_stream_ops;
 #endif
-	WARN_ON_ONCE(sk->sk_prot != &tcp_prot);
+	WARN_ON_ONCE(family != AF_INET);
 	return &inet_stream_ops;
 }
 
-- 
2.43.0

