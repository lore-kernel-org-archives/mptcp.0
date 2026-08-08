Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E437E5F2
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786160494; cv=none; b=f9+uFwWONVih1HkhoPvO1iC/qjh+d4C5S/n4h4Irg6fNPYnerlqgzpanRDrHvL0BEqwHmzbynJsguOkX0ckrZmrAdRx5T3YRZ6y2P7Q1s0MWOhB+JPoq7M0xyFOpZfv4fi6l/dibW/rawV8LzZfrXxAEIW3cKFSp45COJBjjJvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786160494; c=relaxed/simple;
	bh=BwRUT2O93ZD2cksMJGvWO5dYxYsMTEByoRGICSy3CD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8sPM+erJuvtWW01duqD26DInVIO+WzXPOzbx4q83U4shl5MMZLBQuoRKBfFAtfQ/oZaJj2amUxPpcmZydRAX0bCb4c5oxhWt7V1OR78SIKoBjd3kAhwYHNiDrDYFxIIuqFQ86fjNiklFR0f7OFYrcNRECeGC2YhOiq09hBH6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWhNznwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWhNznwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37661F00A3A;
	Sat,  8 Aug 2026 03:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786160493;
	bh=MqME45l+0rzeGJj0dgXYg9B3mx5+9lLV/xWFrD/bozg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hWhNznwJEO8GEgU22P1Llf3itETo7kAR0vCg9dWZz16lW9gBmWL8LiSr4ZvdROp7h
	 uG6MJSFuby+YTjEc/AXMEGWBLkVew1Plkdv4uJhLhqniQk9JlFcZZb/6KvJDw0EtqJ
	 Hd2VUCxIxMRHkd3Jczaas1Zf/IlAIaAKjH8Zv+etWvQkDx9zFj4PB2JlVglV8f+bcc
	 zLj2wK+mk5HvVRUgmTxrSvjvj5ulFwBdm4EtksqGWcg24l8Qf/GX8Tt3yv46oVI2lG
	 wP8+mIqjNT1gkgieMGtqKEmD1HuOGn1BSuO4ZpFth3GUT1LryIwhhF741TGndZEPJC
	 2qAaWb1E6Mogw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 09/11] mptcp: copy the subflow's tos/tclass to the msk on accept
Date: Sat,  8 Aug 2026 11:40:39 +0800
Message-ID: <43e947bb70e402ada9d0292c95cd3f3c2cdc56e3.1786159812.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786159812.git.tanggeliang@kylinos.cn>
References: <cover.1786159812.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When a new MPTCP socket is accepted, copy the tos (and rcv_tos for IPv4)
or tclass (and rcv_flowinfo for IPv6) from the first subflow to the
newly-created msk.

This mirrors what plain TCP does in tcp_v4_syn_recv_sock() and
tcp_v6_syn_recv_sock(), where these values are copied from the incoming
skb to the accepted socket.

Without this, MP_JOIN subflows created later would inherit tos/tclass=0
from the msk and lose the peer's reflected value, causing inconsistent
traffic class behavior.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f19777c04d32..e4fc929abe55 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3757,6 +3757,23 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 #endif
 		mptcp_copy_ip_options(nsk, sk);
 
+	if (ssk->sk_family == AF_INET) {
+		inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+		__ip_sock_set_tos(nsk, inet_sk(ssk)->tos);
+	}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (ssk->sk_family == AF_INET6 &&
+		 ipv6_addr_v4mapped(&ssk->sk_v6_daddr)) {
+		inet_sk(nsk)->rcv_tos = inet_sk(ssk)->rcv_tos;
+		__ip_sock_set_tos(nsk, inet_sk(ssk)->tos);
+		inet6_sk(nsk)->rcv_flowinfo = 0;
+	}
+	else if (ssk->sk_family == AF_INET6) {
+		inet6_sk(nsk)->rcv_flowinfo = inet6_sk(ssk)->rcv_flowinfo;
+		__ip6_sock_set_tclass(nsk, inet6_sk(ssk)->tclass);
+	}
+#endif
+
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
 	WRITE_ONCE(msk->token, subflow_req->token);
-- 
2.53.0

