Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244818629E
	for <mptcp@lists.linux.dev>; Mon, 15 Jul 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038212; cv=none; b=po3sAwLIBM63H3R5fgRkIDB6sO3D5piX9/tW+Cw7QO+dzJ2ljVyUQ57UtyGv5Vzl++s4Zv4LdRQmMyeedpyqVlwWKrqi+NeKhUYupOk4lKPyyr7o0+8kCmWP16CBP82FPzk1cXUuS4adChkIjdKntCM+Ew0Is06KZLIVAPUzz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038212; c=relaxed/simple;
	bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxQT62IuRW2GTkq0/HicXHgaKKTsmLiS8ATAXoc8nzYWJs7xU/3HbZ8XMoyEzdxM3SyN5rKtV+MNhTEvzIp/KATVpIRs8KCmE353xN9MzxgW8JrOYJ870XzCP7iG/7u8Lh7D+5ZCt9RUjp+82NmgDLDHQgw34y4IzH1yc09aNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQRTb/Za; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQRTb/Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3456C4AF0E;
	Mon, 15 Jul 2024 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721038212;
	bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CQRTb/ZaJQTeCVfqs5oFmViGZ3dWQWiz5V7JADWJaxyPY1wpwKWCOdnQBBgIm8ZY8
	 pWgSjLYZULs3g8eQzyZpOAjsdNzOKoNlLPp2meDZ//XRzgUtV120W/0hBpPjELTvEw
	 dcwmfsP21z/Rsh9t1n/6FA/Viy6FoRb5jgjO7eqeoh+chMh9WcksJC9erxb5OlVzgR
	 mZDOr4a5S3eXnKtj2z2zWR7u82KR0kIpHJhUTvmdV0RuepnFKU7op8Ied3blvACITQ
	 0+po6bARXwFMlCZbaR/yUQ9XsvNzVM9yPM3QU7c5tdIj6+Fe2ON3gteltrcky6D775
	 qaWstnTCu+F1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 15 Jul 2024 12:09:46 +0200
Subject: [PATCH mptcp-net v2 08/17] mptcp: pm: re-using ID of unused
 removed ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-mptcp-pm-avail-v2-8-fc5153bd1f6e@kernel.org>
References: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
In-Reply-To: <20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2I6vmk+jwCRqxKwCtsRxnsAvhqqiS5h3MAqfuPR50Z8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlPV3yRjgu0V5wWad5gscAV5FzJfZ58/7Gt4sv
 PqycZCRM/aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpT1dwAKCRD2t4JPQmmg
 c1MdD/9dmEEczwYv7ab5dhpgqZleJd82r0xPMQmMz2e7HECla78q3jQKUlBMSDszZZfViZ4kW5T
 f+bfmRm75UuAh1GBXx6hMgMjCk3sos27FP/6yL9CymAUnxGvBdo90WtBajaSCUlH0ukKeXXj5bn
 duMVZ3OdiL/tewLDRvjcYjS6KyyJbcb/AEVWkbIif88oizdpDkWnEmTZ9T7ZFXSHPpRG3MjnNs0
 boyCUS0H2Vod35XKyY5xnsiM7LCiYpnNl47tAym/C6IZVNWKmp0JUYxbTYFzgg5oqSOTw504fUe
 IPlAgpxJe9fcugQ1eNzv8wM33zh7U+Y2G1CLyke4s15ZsSZftgsOBYZT1ESI5y6j9qqzFxmg41e
 REmTNa9hjkphzb0v3b+ew5yjKTPi8lJVnVe+YTRSEJ24M9vHM03eTM6F8JLwJESe4nxRTCGKVNF
 IP4/Jo1/1PCX2+dsrLMEaK7GlOE2VEbq2bwj4OghpE3z9jT4k713xwHuOmc0Pke3JY5O9Xe667i
 qA9d8PF7jpxm7oy52QbBpQ/YfVz/UvlYPuTmVX8B942nXSnJf7R+guWVBXI6ihgA5sVlIzBCiGy
 XsqQC7nG3shS6KwMgX4Cflhxl4bjiZQzzYcrMmvNLdUCgg6swzhrO+Kz/w3MNEDzZ+eG/1xchSc
 iGud0cCtgK/hMhg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If no subflow is attached to the 'signal' endpoint that is being
removed, the addr ID will not be marked as available again.

Mark the linked ID as available when removing the address entry from the
list to cover this case.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2e94f2a9f2a6..d44d318dce03 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1394,6 +1394,11 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
+		spin_lock_bh(&msk->pm.lock);
+		__set_bit(entry->addr.id ? : msk->mpc_endpoint_id,
+			  msk->pm.id_avail_bitmap);
+		spin_unlock_bh(&msk->pm.lock);
+
 		list_del(&entry->list);
 		kfree(entry);
 		return true;

-- 
2.45.2

