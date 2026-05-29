Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41336BCDD
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024930; cv=none; b=d/TA6XM06XEIslDijYB7v06tQh2LuNKxmE4GbbxXFP44bwKNwbm+P1/k15YvrCcfV9xzcQbOxcKuRyB97UHxQTzOcuV4uk4kNxPIFgyn74mxNJy+XF/EGfhG6NEi31yXpqtQannpG7D73qGCEp7+oqXxFcD/9iUju/FdLMDJSYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024930; c=relaxed/simple;
	bh=HsUi+/WYX9tn1HmmHrLbARUCYzFRpKlky51VHQKhB2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sl1vJpFz9KkyEUulcVTactSjCzc9HF8LkGhUkSK9pnIhrB5Yj4ucy3mBrZa+lGuVwvDTNEheqFT3ug03eV1JVZ9NbGXW5gNjn5a8DNPP0tCYB0hegrYTj6BYKvUlpyF6yedHDvfq8Jl7eIaQW+XJ7OlWfCD41xpEanoH0bsFMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+gk0Rc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+gk0Rc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0771F00A3D;
	Fri, 29 May 2026 03:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024929;
	bh=NU6BbE28DVQHvcfdbBEgRDs1MNlxhhdK7wzNxwfnjso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h+gk0Rc5bCxuEb1G8xdEOxalQ+a8FASBE9YAp0CxM0A/REge6JBxMAyBBN0/ZaRUN
	 Occkt+PpSWLSf4i4Kuy/mBram+IwAcN5od71hurIGVdIWgxAMAyZTxOywNKHee8BES
	 3od2zHl9ruw3AfrT6Pd9+oIgSI2QTkVuSfLWzvgLX+ol7iIpkoE9pCeKPzwSFSo7IH
	 lgxsHYGI/JVcinkuGC30ivndvzrhexI0wO7qSYfip8OzF+Z2LOKbbmkVzFzhe6OD79
	 8vDPbpZ8JLB/KRTbUJRCWEYoizc0sznMCrhN3WsPtutt3d9Sq6pbFkSsJEmhe9TWN9
	 d4aO9lweIJDmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:45 +1000
Subject: [PATCH mptcp-next v4 07/15] mptcp: pm: drop TCP TS with ADD_ADDRv6
 + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-7-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4952; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HsUi+/WYX9tn1HmmHrLbARUCYzFRpKlky51VHQKhB2I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWh5Nvwrdi85wQmfA7jVFAM5kj4AyqtApS3
 YI7+v4bM1OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 c9VLEADisZRJBWNQ6dN1JLEtWKPu+b6QNIe16Jo4EVRBVREyAyuq94WpsHvEVW5z/oSZLHfRqRG
 3NMddw0pi50s8QCXGxmF18s7I5ocO0bcOoIQ6Hb/FmMwzOC5MmJ+z7OmErgq3zHyrlOr6Z2DBaf
 4mXw6NflF+NFuHJTDHvNzDkglqYaWaoYE8F6h7aJEila0E/QV24sbjFL8FEEIp9Y4iUidHMFTlg
 hJoexv6EmArxdI5g7JxwJNkI0+vsSXaYmpYNwsU6EfQwYVzyMAbbCfQe9K46RIKzJ/nlaTyH7Gy
 uibn9T5ZJ6j1Ut8UsglO71N46VhRTy396h3nYBp6px43RKSntrdauHzkcFx465J0RLpzOURfGaS
 JXWttNgoQUGYXmZLSpERvVWIdLNW/uMxgtGQPuGr1oNJ+wIzn1v1UDLa+GJYCaHOmtv7Ag0NiGR
 c7X3v+tuWpekMm9ZVKzcVWDediCkXJAIfmcNQaYDy9KNWlulip6pliaRuv8rRV0YQwmFxDQ+7NK
 ukFoUlMxPVvpUi4nWo7Wm7XEZaO2cDuJTqR4I7vLm/W85z48AcaFqHL8z7lI8keH585dXO3BEBB
 Z7bi0NQXUDorPCAECwA81Hihf7ByXfOwXCbPNOqPZHIztjKzvpTuyTDalASllHtrgR7W7NFoTrf
 wP/Qz+4dx3TgPeg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the signal.

To be able to send this ADD_ADDR, the TCP timestamps option can now be
dropped. This is done, when needed by setting the *drop_ts parameter
from mptcp_established_options. This feature is controlled by a new
net.mptcp.add_addr_v6_port_drop_ts sysctl knob, enabled by default.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature can be
controlled by a sysctl knob.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/448
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: split + fix reverse Xmas tree order + change label (Paolo)
v3: split the TCP part in the previous patch + s/has_ts/add_addr_drop_ts
---
 net/mptcp/options.c  |  8 ++++++--
 net/mptcp/pm.c       | 12 +++++++++++-
 net/mptcp/protocol.h |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c5635c8781ae..4673530018bf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -655,6 +655,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk,
 					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
+					       bool *drop_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -669,7 +670,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
-				      &drop_other_suboptions))
+				      &drop_other_suboptions, drop_ts))
 		return false;
 
 	/*
@@ -822,6 +823,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	bool add_addr_drop_ts = *drop_ts;
 	bool snd_data_fin;
 	bool ret = false;
 	int opt_size = 0;
@@ -872,10 +874,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
-	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
+					       &add_addr_drop_ts, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
+		*drop_ts = add_addr_drop_ts;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ae6eabdc2ac1..f63c6b117f97 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -906,7 +906,7 @@ static int mptcp_add_addr_len(int family, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions)
+			      bool *drop_other_suboptions, bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	bool ret = false;
@@ -950,6 +950,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		if (!*drop_other_suboptions)
 			goto out_unlock;
 
+		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
+			/* OK without TCP Timestamps? */
+			len -= TCPOLEN_TSTAMP_ALIGNED;
+			if (len <= remaining)
+				goto enough_space;
+		}
+
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
@@ -959,6 +966,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		goto drop_signal_mark;
 	}
 
+	*drop_ts = false;
+
+enough_space:
 	ret = true;
 	*size = len;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1c9376c5e8f0..bf4607c1fd04 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1213,7 +1213,7 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions);
+			      bool *drop_other_suboptions, bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0

