Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F91364024;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773043426; cv=none; b=qvSeIzs85Oi3g/EU0hs6/L4QCouzi2EXPclzImv7SepexnAjt4VzOOgsNwINw7Czx99OqPz9LzKuR4PKLMwvUP0jbZugJEi4ExUPvaxhcOAKM2murogQmnh2r7ZaV7JgIbvtVBqPsP0sLqPlV5VD+uYIvsQzLEQK1zagDh3rwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773043426; c=relaxed/simple;
	bh=PF4BYVQIZV4oiBVr6sVA/qCdRg+/Hpu3GxmXH0vlCp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GNreYX4b5I+C8PggwE0j3BWckXNpgG8f9qVeFVRvPy5yUl70FnaxftnkTpeYc6sEDXS4MdfpbJ7LPkvSXIIVmrDkFnFmCsYGm1dPh0Sv5h5pys4mGEvIdaVbgDlIy+MB4FTTwJK0D4rpQLd5mUMe8igljxnohowBMDUPuX2I/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it9EN7WQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it9EN7WQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D273C2BCAF;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773043426;
	bh=PF4BYVQIZV4oiBVr6sVA/qCdRg+/Hpu3GxmXH0vlCp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=it9EN7WQc94rTb5cRGgCpBpC+cj2zX5hDKm3THKsESfenOxz/IpKyLewL9fmP2SY9
	 wh0Ix3wtBOLd1aWKnypJ6OIUAdIEv5uhAoIVMS4eYicq2eVnVWmhPo6Rlrzy3rn0YW
	 FNILMNJbDBgzhhxA4Zc5g0xCcSi7cEhyNEKqcHW1Z87vjIdfpeLCh3f74616n+Z3Wo
	 vlFiJhFoVzQt57qJtPjbWAea/Wi5p4V9GU4fWbW9GmFByJvQtWTKeJ8jtI18AHsnc/
	 QWPM3OnTWZ5ExHYEMlFTpbSF4onM83wPdbKyiGtmhDneu+UjDtKCamRSYiRE925LMT
	 cvPg6lxa6V7Kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE93EF3709;
	Mon,  9 Mar 2026 08:03:46 +0000 (UTC)
From: Simon Baatz via B4 Relay <devnull+gmbnomis.gmail.com@kernel.org>
Date: Mon, 09 Mar 2026 09:02:28 +0100
Subject: [PATCH net-next v3 3/6] tcp: increase LINUX_MIB_BEYOND_WINDOW for
 SKB_DROP_REASON_TCP_OVERWINDOW
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-3-4c7f96b1ec69@gmail.com>
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 David Ahern <dsahern@kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
 Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 mptcp@lists.linux.dev, Simon Baatz <gmbnomis@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773043425; l=994;
 i=gmbnomis@gmail.com; s=20260220; h=from:subject:message-id;
 bh=h0fO7UL8KcWCVKdqBvyw3pkMf8DPB6tVI+LGsyguBYs=;
 b=7/WazVRQuzI6bzee3cpoq4pYjQNWmvWmXipOZLpR8MPj4XIv7lRXuRQWQjerVzWTs5qLbOt68
 aOgylmzR+b7Brk0uC/+a/cKqwVA5l/sUSkIdC1L1EFb4zNj/dvghxMD
X-Developer-Key: i=gmbnomis@gmail.com; a=ed25519;
 pk=T/JIz/6F5bf1uQJr69lmyi7czVG+F9TVZ/8x5z9Wtqw=
X-Endpoint-Received: by B4 Relay for gmbnomis@gmail.com/20260220 with
 auth_id=641
X-Original-From: Simon Baatz <gmbnomis@gmail.com>
Reply-To: gmbnomis@gmail.com

From: Simon Baatz <gmbnomis@gmail.com>

Since commit 9ca48d616ed7 ("tcp: do not accept packets beyond
window"), the path leading to SKB_DROP_REASON_TCP_OVERWINDOW in
tcp_data_queue() is probably dead. However, it can be reached now when
tcp_max_receive_window() is larger than tcp_receive_window(). In that
case, increment LINUX_MIB_BEYOND_WINDOW as done in tcp_sequence().

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2e1b237608150c2e9c9baf73cf047ed0823ca555..e6b2f4be7723db14acf2ae528df17b6d106b9da9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5678,6 +5678,7 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	if (!before(TCP_SKB_CB(skb)->seq,
 		    tp->rcv_nxt + tcp_receive_window(tp))) {
 		reason = SKB_DROP_REASON_TCP_OVERWINDOW;
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_BEYOND_WINDOW);
 		goto out_of_window;
 	}
 

-- 
2.53.0


