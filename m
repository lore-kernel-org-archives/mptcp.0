Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B383D288C08;
	Mon, 22 Jun 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125129; cv=none; b=a6WvPZPBhqHTgjFLQN0ghC+qpnUl5hBCYURCff/LKprkzpazIzC/9a2MdZG/ZfTejmwgg7AJJYjwCViKvo3LK0oa7s/Acd0o2vteFgPNhWnmCNCKKrG7fLuTVrzUsHChBM47a+mPJUqPIQNCrcb8QkN7/20AWasnFOlmOxoOfuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125129; c=relaxed/simple;
	bh=+EDQjqw/VgpJAoh5blkvsxy93vUaO1Qxy6iOVtA96p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgi3BuTN2UMX4If+pmrp6TydHl3ZGxtK0WT30NY5Bxo+pSClalpqUavXzBVryuKZHgcGIFqMyhMLzygveGGnTxiroYprnATovguZo2mEvbdl8w/gFPyi2tkuYwc3V42ENzevn+HpvgvO57TPMM5AMw3jsohZsJVvW1W9N8HXh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vw/mEO6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw/mEO6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076961F000E9;
	Mon, 22 Jun 2026 10:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125128;
	bh=g9X9BHQkTTlvnervJXfft5QAn1V/XvkEgw0/jLS2oR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vw/mEO6XwF2FN1+aR2Z6GOSkordwceH4hi1dWKggd54yVXDEDmNVPKYlwhZtGVF8Y
	 wGKxcutQsT5YRFjDkCsGqTr566FRLbwTu9/Ipi8Ryx8jt4Q7yRTzw3tZQY1OVDF/ug
	 JEjFZ/W3xNVz8biWzV2lZCFoGkoa1OTmf0f0MR3FT3YQ2Q5BigNL8WW0nUu5B6aB1K
	 Ai69oXJwXrc/XJRgN0Ak6Rv5Hhxt690N0+aPFKSb+mDnuLlB55XPUkdQRrnHF1I20W
	 YuAyhr4HoZtMsmeLBMQ5ogtSj1E2WNtNEmzltjZAPUSS33pVcbM64awolaWAWR01Mm
	 r8ANLPW0unmTQ==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 13/17] tls: disable device offload for mptcp sockets
Date: Mon, 22 Jun 2026 18:43:33 +0800
Message-ID: <8f0f4a336e0348f2169b55703950d3c6a9297589.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP TLS hardware offload is not yet implemented. Return -EOPNOTSUPP
when attempting to enable device offload on MPTCP sockets.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index c44a59d9d715..e535edc23d0d 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1074,6 +1074,9 @@ int tls_set_device_offload(struct sock *sk)
 	ctx = tls_get_ctx(sk);
 	prot = &ctx->prot_info;
 
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (ctx->priv_ctx_tx)
 		return -EEXIST;
 
@@ -1196,6 +1199,9 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	struct net_device *netdev;
 	int rc = 0;
 
+	if (sk->sk_protocol == IPPROTO_MPTCP)
+		return -EOPNOTSUPP;
+
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-- 
2.53.0

