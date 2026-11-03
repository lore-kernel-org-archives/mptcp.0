Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676624;
	b=tlBQQAp7t2L+Sze+21WkzRZjVmerqKbJ+sY69Qm7nFEMo+NcQ7AgkuaI5M1WBc+7KVvE
	 7VNqlntnNOTdYvNFWz14iXupxoBhg34relVyPueZOoQrXf5N+NUVEcSZ5KdWgtZ/EHCrU
	 ee7cXhoWq0I/vGKSwvsK4SozYUqffhiD8gM4oEiq0neaos3zgMA5BOY6jh6aCk4Gi9y1A
	 u/H3tC3ffRFx5Odqt7uZqzajZ/UQJrIBJzy0D2Vm02KsPkVgeA2gYHI9en+PtNSVhAkJI
	 PY3YAkk7X7bdSoMfr6DoL6xOY9KFgDw5xIDJETZ5PMFc95oQNzIbkk4COQ+rS5KMeRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ahOYnMXfAv5QhyhyaBuTnItWlG1UQzUccllGBFPXCHY=;
	b=fn6qtgPDX1Z1zPn68PBb0BG7AgSX6/z6ZLV7PaykzF9IcxhkQGFckayqLzSb/d0WFFYR
	 vjPMnzebWVv0BakOww7/3eRBLY4MgtV0NWWEh/JhVSvbOBW9ITfSoIcaEzFi9MJY3GNRP
	 Oxcw5H5I85WgX64uwneFlBtVfapjjJvzu6C63CaEOXFX0xCS+rv75fl3eXTDHfiNGGWaQ
	 vyQMBv+2MPAb1XDJ6eZjaM3uzaLFJG9/QrXGge30QpulzConwy0cG8acHl7txZeGPgoM8
	 Oa7C+bLROH7tDGLiL2QV+S4HHJ2T4Bqd05mPywe+4VzWpyZBcrPmJp5yQkmkzek4+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXeB+xrw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84663606A326
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LXeB+xrw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407811F000C1;
	Tue,  3 Nov 2026 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676624;
	bh=ahOYnMXfAv5QhyhyaBuTnItWlG1UQzUccllGBFPXCHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LXeB+xrwm7+pGUp45tbc4JWHZd9t+JAfIJPnEvk4gi3YJAdUPPh5+O/b4vBMe8u2+
	 y5cptS2Pq19ko+kDhk3a23ACZJxCOkRmbR/MnPdVZ5lVN37IBf/OmZ45jsv1OgmV4S
	 o2F+h/ejIaaLfolJXYE5igGM7lM5Br7hGNSmriEsZ9F9gEm058kmn3RQFEbtXjgYJe
	 hIyluFr29hSSUG5NX035V7z+rDdaC9c9Kz1HHfEo50SzMkc38dyotSKeLQkUDmMJ19
	 fGo3x0g3fXQ+88S58gXxPIP4UHWXW2YvEwm9FZHnLoFrAlX3Gx7IqSzs+y1vRxH4xa
	 aR50sbsmFLK0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 2/7] mptcp: use mptcp_data_avail in mptcp_inq_hint
Date: Tue,  3 Nov 2026 11:29:51 +0800
Message-ID: <ccd9f70eddb3df2c311b75f559d9acea3233295f.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
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

Update mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
(bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
map_seq.

This change aligns mptcp_inq_hint() with mptcp_inq() and provides more
consistent behavior across different connection types, including passive
TFO connections where the TFO skb has map_seq set to -skb->len (data
before IASN). Using mptcp_data_avail() avoids potential overflow issues
when ack_seq is set to iasn.

The EOF hint behavior (returning 1 when socket is closed with no data)
is preserved by checking if avail is zero and the socket state indicates
closure or shutdown.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0caa31525b90..1704e689bc93 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2402,22 +2402,16 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val = mptcp_data_avail(msk);
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
-
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
+	if (!hint_val &&
+	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
 		return 1;
 
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

