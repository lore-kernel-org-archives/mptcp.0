Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792436769;
	b=f8VsBfqZURyOgc3H0o2rzFDtL3Koldw/J7BdFpGVMdeqKOj2RuahEMjE4DaklBqzguYy
	 FyEK0lKgEESfzd2zaSd1ynSE5q/7so/V6NUonyX2cj1r3YEcocsoIajTxXYZ1IQnGRaML
	 P+q7ccsTaKOs5pbhhhDqqacSUYXqSPJpWaht6dr94eYMC/7aD/6WnhsESvNkY4GArvmnu
	 aKFjpdH2zmk65T9/NTrLa5UcGsDy0oJgXrm8xCABzbRttHx3ZnwvdBE2b72sbtKjeqoG8
	 PFR59Uk0n0zzRW0G9cUd9RqXW+XBg4t65tU7rfE9GanD6/GLxqDz7s0HJTCk+P9TciQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792436769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
	b=aRmE5h7fq+b55CP+ltgEFZwWwUM4egqhHx9c29shLUldOHCqpns5jlvR2mS+imV7F4ol
	 uL0aK15VEeaCDHkxh6CJ4enBcIgMQwk/Z13ey2q3QsgzH5vMANFYbSX2WJSuLe4JqGXtv
	 Kuvn62kt9lbQ7LZeVrDI5hL0+JVv5pM9y138K58BxObKYQPV0gEmT3G1yvT1LGYGCRHU8
	 NCr52PTyXd6Mk00QiThwBgyaVZxWglcdc2WzZtTTGurnqEvpixJXhRrwGKFC1hQUYFMUb
	 Lqg6r8y54xmQIVeQMjzm/TT47tDUoSzKzf0KjSH2xSf+k0siIeYyh+/kxr+9Ec3fV4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LUuFaIP+;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1363606A321
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 19:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1363606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LUuFaIP+
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso4704710eec.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792436767; x=1793041567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=LUuFaIP+GeO+odqWwo2aBx+ZNdsfdYWa8wivTm6KruBDCpjS0u/VO6Q7xMvY/zgB0m
         q7DESFTjIoft44ZfSHPZOAAP2S6qqGOSmvVEOAS6CffJ39yAuV0pJ+3SkLB8bfmERjyH
         lAXYYoFsobJtyePEcbmHFSHzzBlOKGKtpZX4l5OAfLhpzO+eP20+L3626eXOADbUDdH+
         1H3itgmXhIif75wq94auZwT2Da2GUUyT44iIrmDlJtbuAh6EEICYVB2tXfPw2mjUFcVL
         J5z9e1hNePqIr6deWstAVeZth+h7lUaBrq2WpMmlZ5eZwH3MZyy5f6iOvU0vgIRTIe4f
         9sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792436767; x=1793041567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMGKjMwOlq6w5EX55Ph8mpyGT/IFXfzZRRGc1xWK8zc=;
        b=OZJHtuD2X0uQjMY/3wsencWYfulT9/LI/bBxH9xPwVL7oR8PFE/C0ydPc7H+YvaZVr
         Pl7JPYh0qH8IHj6PTifov8i7lJJZtLSJEkQZAjGZa5GPli+SD8ImnT+uVWhmYi9neUK1
         lof0VAF39yZvVCS8gTdbO1nyrw/uaCTAaBFSro4z0LlfBC3QPa7hPCebcJUoxfZcBI84
         /BV8j+MdBn0ZmVayDmyuxDgNqWtOxzgv8bzMW1qWZ9cu61MAxRxZpqUbezkgDpiWNsU3
         qUlPov5BZ0cb2u4PNkdJL20O/YNjZC5j8rDvWdfp18716lYlm8UOuq63b8iaLkuS5UC4
         bdAw==
X-Gm-Message-State: AFq9FYKuH1/mN1e7H4ZsllM2EoUDJM6JVxmFRN6HGSVXea8Ipity1HfP
	ucJretFsV/mThVpiiX2jC7S39nnhW1mn5CIRysWFdvqKlkQsY7M3YlUmJB8rDg==
X-Gm-Gg: AYBFou1/+FJXzdwiI6QfQzWshrJgSZU1a2ShS3t9jfgM5Et2iKVO751yDj6ygQrmm5+
	By6n0rzEO96nCWfkSKJiRTQWu5sPOlDNxS+bHFYjN/8TKpPcxkxzuiMTZPGAix6kmp2dxm/rD6Y
	BvHlOa5OqOmCaOlHPUNuefGD5zsPGO/9zCW+niB6ZyLTLWv0E3c17cbhAPzgyvzQ6R/gdX6Hq+s
	OA5LiR/Xk49jJ1vO2niWRXmIm8XThjDwXh85Qrgutrki13yp5lxmk3h6gbIGAo18mgIQfeBu3Ik
	Xauh6vh6mLnTFQg14EW+mlmdUOsB5dleRAZcYyTeKpPd92QHRmbRDCBSjBh1svdUoiwrC6eHedv
	Bub6MEGvgCPWZUgXWeQL3zvhBtaLjewqAN5Tor9GJnBA1O6GlQ21uRs2wsMqoT9N0xfnPzRcWDs
	tSghFEGJdgkHqrv/Q1KwERPAXINpQW00T4lwwfdubAkhlTRdjOrJoszqIf6160cSEfa8Dzb0yDD
	SZz4NU=
X-Received: by 2002:a05:7300:10d:b0:351:1e89:66ab with SMTP id 5a478bee46e88-361a0e85fc5mr12489234eec.7.1792436766863;
        Mon, 19 Oct 2026 12:06:06 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm62848024eec.24.2026.10.19.12.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:06:06 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH mptcp-net v4 1/2] mptcp: pm: in-kernel: fullmesh: skip closed subflows
Date: Mon, 19 Oct 2026 19:05:57 +0000
Message-ID: <20261019190558.465270-2-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019190558.465270-1-w453y.me@gmail.com>
References: <20261019190558.465270-1-w453y.me@gmail.com>
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

With fullmesh endpoints, if the endpoint used by the initial subflow is
removed and then added back, no new subflow is created from it: the
connection never uses this local address again.

The initial subflow is kept in the conn_list once closed. If it was
still established when closed, it keeps the local ID 0, which is also
the ID used by the re-added endpoint, and fill_remote_addresses_fullmesh()
then marks its remote ID as unavailable. If it was already in TCP_CLOSE,
e.g. after a reset, it is disconnected and its context is reset: the
'closing' flag and the remote ID are cleared, and its remote address
and port are zeroed. It is then picked as a remote address, with the
address 0.0.0.0, the port 0 and the ID 0, which also marks the remote
ID 0 as unavailable. In both cases, when the peer has a single address,
all subflows use the remote ID 0, and no valid remote address is left.

Skip the subflows being closed or in TCP_CLOSE state, both when looking
for the remote IDs already in use and when picking the remote addresses.
__mptcp_subflow_active() cannot be used here: subflows still being
established have to keep their remote ID marked as in use, to avoid
creating duplicated subflows.

Without the fullmesh flag, the remote address is taken from the MPTCP
socket, so this issue is specific to fullmesh endpoints.

Fixes: 045e9d812868 ("mptcp: fix duplicate subflow creation")
Cc: stable@vger.kernel.org
Signed-off-by: Abdul Wasey <w453y.me@gmail.com>
---
 net/mptcp/pm_kernel.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 1a7750813..24cdb170b 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -199,6 +199,16 @@ fill_remote_addr(struct mptcp_sock *msk, struct mptcp_addr_info *local,
 	return 1;
 }
 
+/* Closed subflows can stay in the conn_list, e.g. the initial one: their
+ * addresses and IDs are not reliable, possibly even reset.
+ */
+static bool mptcp_subflow_is_closed(struct mptcp_subflow_context *subflow)
+{
+	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return subflow->closing || inet_sk_state_load(ssk) == TCP_CLOSE;
+}
+
 static unsigned int
 fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 			       struct mptcp_addr_info *local,
@@ -216,11 +226,18 @@ fill_remote_addresses_fullmesh(struct mptcp_sock *msk,
 	 * already created by incoming ADD_ADDR
 	 */
 	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
-	mptcp_for_each_subflow(msk, subflow)
+	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		if (READ_ONCE(subflow->local_id) == local->id)
 			__set_bit(subflow->remote_id, unavail_id);
+	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		if (mptcp_subflow_is_closed(subflow))
+			continue;
+
 		ssk = mptcp_subflow_tcp_sock(subflow);
 		mptcp_remote_address((struct sock_common *)ssk, &addrs[i]);
 		addrs[i].id = READ_ONCE(subflow->remote_id);
-- 
2.43.0

