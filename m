Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720753;
	b=vZwt/p37VTEjBT9xf3arJJfOSfZVZMvgOrGn6aU0DPMiBbjKrrqVCpTtuBHFdrp8vOTr
	 5djBgRu4lTjdHfBZGvu9MFRDhW1Eco3xAug1ad7+31JgCBMiwfrJvLwa0nu0cMr5gej7c
	 Krw94SF45Kx+/yqAHmrp9PmnFg8TdUSl1n1LvJvsrqSxUiA3Ql1V7TiEqZeUNv2sX9Shf
	 BP+AsrRtTV7+TCIf1jPBNp1nTTquvGWfdwIL9PlBcOQLmivCOQ7uEWOYk6cpXSqeW91Eh
	 i9DGgMhEHlCziLgxDSFp4hF9WnTfpMsJG22Kt8H9jq66ULTQkOgb119Ie42ibuuJgxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aFdF5u/9iPbWs+2wPPKei9h8xLo9BMNish6khhgYwxg=;
	b=zrYetlaLICaP2BzgdphBnIhaYYngAZp1NqsMinPuHuLHB8VqP5JcxmmFG3mAa7xwzZqG
	 l8lv5xWJQIv+K22zvTSYn3og2phhmKhEO7Mha+ZH6auzw4j9GmyTZJWOQ0AJuZADA5u7L
	 iJv4F1bRGBPoQSKRulTGJ7psO6OVxLPdwwKkC66nLyygKB2x0jqGJXfL7ZA12dtI78gbx
	 QZHYxD+wCGqsZluQh8rZOc7Wv04PmQPI8137w8wb2JpjK7e2ghnm9qzAsxF92kCeaSuy5
	 ThseF3Ym2pfW01FjD24LBhEMf0Kd9FUtQ2zd0ctbrO4ltUSTMKa2QMmK9aUi088eSyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwgZUbyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF1606A31E
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LwgZUbyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284121F01829;
	Fri, 23 Oct 2026 01:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720753;
	bh=aFdF5u/9iPbWs+2wPPKei9h8xLo9BMNish6khhgYwxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwgZUbyEy6RyW3B3Jm28T6ZWjTPhkJy6EaeVOfGwA29EwVEPA+rT8X1gs/d4G18gx
	 JQq3Q+MMs8/P0RCBI51HWeZgmtRQytG6j5SigIx2LR3Si76a/+PvYLkMgNS6zqQ1nH
	 1EvBec592WIchBNQFeAE5LYWI9Ygvn1opF063kLNr0GQJGtOdCfTGL6GxbiUdgXwi2
	 a+r0QY2VYOApN+ZlkIYtmER4bAL2ho67pa3/UrMRfL0ciOA2OIj53XFIlVif/InHSa
	 OzYiGrq5BR02UHhkbLmR53vm1jHr/MP6oLaPeylveyKh9GaoHwbircTfquEzTPYaFy
	 1iZS89+/r1ARg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v15 06/11] mptcp: align FIN handling with TCP via SOCK_DONE
Date: Fri, 23 Oct 2026 09:58:47 +0800
Message-ID: <920d36c7943127f886900b7cdd7404e9b2acab85.1792718041.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792718041.git.tanggeliang@kylinos.cn>
References: <cover.1792718041.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TCP uses SOCK_DONE to mark FIN reception because RCV_SHUTDOWN alone is
ambiguous: it is also set by RST (via SHUTDOWN_MASK) without an ack_seq
increment. Mirror tcp_fin()/tcp_disconnect() in MPTCP:

- Set SOCK_DONE in mptcp_check_data_fin() next to RCV_SHUTDOWN.
- Use SOCK_DONE in mptcp_inq_hint() instead of TCP_CLOSE/RCV_SHUTDOWN,
  mirroring tcp_inq_hint().
- Check SOCK_DONE in mptcp_recvmsg() before sock_error() for clean-close
  path.
- Reset SOCK_DONE in mptcp_disconnect().

All SOCK_DONE access runs under msk socket ownership; existing
smp_mb__before_atomic() orders RCV_SHUTDOWN before state transitions.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3c3ad8991799..7b0005d47bea 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -740,6 +740,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+		sock_set_flag(sk, SOCK_DONE);
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
@@ -2423,7 +2424,7 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 		return INT_MAX;
 
 	if (!hint_val &&
-	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
+	    sock_flag(sk, SOCK_DONE))
 		return 1;
 
 	return (unsigned int)hint_val;
@@ -2495,6 +2496,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    !timeo)
 				break;
 		} else {
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+
 			copied = sock_error(sk);
 			if (copied)
 				break;
@@ -3740,6 +3744,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->copied_seq = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
+	sock_reset_flag(sk, SOCK_DONE);
 	sk_error_report(sk);
 	return 0;
 }
-- 
2.55.0

