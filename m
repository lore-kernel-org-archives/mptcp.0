Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783555;
	b=oS54anQLLk7ObqWhY7zIRfbe4/WF6OECjQ0kcmWK5+flk6zNimB1WdgVlof2j+fqrLYD
	 g0wCAMY7QOVA2/dGUk6LuYdvDJgu82SqxAtAsmzxk5+0OUhNW2pIOnFUQDCp1m0Vveq0v
	 WQjz/3Q3KWSRhU5geF2MI5Jtjh6yXTDzhR+H7yGP7twaxf8G6CetdXAzuyTBOufQD4T+E
	 f7nQMe0cKe/UdgAaoNgKowHtkh35KzGkhTYIXCkQOZG/h3COrUhr8rANliKJKp9BassXO
	 MjPzz0YakNwc2gVXyY0/Ik67E06mApALRkMfA/57lTewl3H5HhKP03c/uTeUaYDTlcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783555;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uSe9WMIjgNivZz+mf4oQPcRc7qsTQtjfI7P1LdxS+k4=;
	b=CTyMtHJAbZQKvNlulapmrIaObmQ1pi7SP3pQ6jfD8LobBZ0y5W9JSyNRrJW8Vzt0HUU+
	 gqX2P3LcN9Lb3LI16lYX3Fs8G17Wa2XzNbm4IPJoP8VoLEEfUmbR5cGNEo7s/CfEhKnVG
	 dibxZDhzArdS2V8XRXP1+1mdpNB5mV+CG2i+awj2j5ZjqXHZgMNCo6KQgeWk7nxUoXDjR
	 C6Z0DOvXRZRYIjUPxvmmbI+RXOlDWzpf0D4kcuyq5t/ggdvwR0hdRfnQB6obDNWJ5sZnj
	 pIxh4TKfWiuo+F8dHNGUj5K6C2GfZnKuuKuuhlfgZIiDV5KC3+e44qemZiK4Kv45DAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HX9KDFFU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95651606A327
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HX9KDFFU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6780A1F000C1
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 12:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783555;
	bh=uSe9WMIjgNivZz+mf4oQPcRc7qsTQtjfI7P1LdxS+k4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=HX9KDFFUwyE/rJ6pebXrqzOIvBvS9zR+3UBokccq8xoLw1wmBChCceRa2veTdeU1+
	 ZvG+ryckVxjSFVHOV2fBtA/X7DnUUo0ot4Cr3OJ+1qyw/BgClZAbL/2QbcyVqC2BYg
	 LqUWNX0q2wATFI21RsM9m1y7kCQY7EZwmToJ5a7ZDs5MqL1+L2DoidAKgm9Ji3mugZ
	 3M7FFJQ4PfQEBltpXzvjDIKCipiF6rL+l0nNngHQgRi390tBDmAdqJ8rowPVEWta1o
	 G2lsPWhMwS06XO7IduSaY/5ZtVznexiwiZuUwQYZxf5rHspcXEqIdRjWkVR61VcvUu
	 hM5+KHxokgAuw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v11 2/7] mptcp: remove redundant orig_offset in carve_data_frag
Date: Fri, 27 Nov 2026 20:45:22 +0800
Message-ID: <90ddf1a1390104c4e793311dda36bb834e2453a4.1795783388.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
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

mptcp_carve_data_frag() already receives struct page_frag via its 'pfrag'
parameter, making the separate 'orig_offset' parameter redundant since it
merely duplicates pfrag->offset.

Simplify the function signature by removing this unnecessary parameter
and directly accessing the offset from struct pfrag internally.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9ae52caf47e..504d0b196d84 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1302,9 +1302,9 @@ static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag)
 {
+	int orig_offset = pfrag->offset;
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
@@ -2111,7 +2111,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			if (!mptcp_page_frag_refill(sk, pfrag))
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			dfrag = mptcp_carve_data_frag(msk, pfrag);
 			frag_truesize = dfrag->overhead;
 		}
 
-- 
2.55.0

