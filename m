Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1A386C1B
	for <mptcp@lists.linux.dev>; Mon,  1 Jun 2026 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302469; cv=none; b=EBlwF+aj4/jMZfYVGJqmlitNvELek8fED/CvklXfC5HhvQRJ05D7YjiSGGuwr9Zubb2fttYhI1QG7IUpELgyNkzvvx35iPX9bAi5yY4m1IQFqcDMU6kt9/b14vFFYmcbP2GKmQ/j5/o9aRDDK5TboXPp83jgdUw8eKoWGcB0+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302469; c=relaxed/simple;
	bh=DvwRIfUN7YRZ5k5EVdGbqGg+rsg1sk3AYFpf1i2tPKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2raOPptJ0VcnJBg6vDuq1XL1BtDoTXqxdAVnuK8Ut5AfH+fg/bO7tVwGDCKcZseaJeJPxYGHmLxkDY5dhWrNoSgJTqAV2Cxhvs2k8kCov8lPifmYuLFoJDEEmJTl4mECqt3kLzf4GW7XI68fB+0qUzGg50JbhwqMcCSzwG7qfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIPytqUG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIPytqUG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4CF1F00893;
	Mon,  1 Jun 2026 08:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780302468;
	bh=5LUPFX4ujMQjL6zP3fvoKqQlqRl7A0D/ikfh0X3vUFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SIPytqUGzLjpJQOLAITGwuAjUtw7UF3yHhNobfFRji3pHI49YlH8Y/M2yPttQC2LD
	 cdWjU4TQc+mpbQ6zOFuVubc+EiIbZ0X60LHzIU/PhodLN2/u8q8YHndYCz8pS+5V3J
	 QVAfvCcamwlQnqMFSjUeu+a2zpK2Elch/j1WL9kQxuMHBOnfFQR7KwSHDuYkz9eQdA
	 sbj/1OcpyYsQ9rxHeXEVg9WlQfqqfX3xd+aREIWXomtYVt0wtaj2GcuAvHomqdHvSK
	 Wlgk9uA3hGXbI5rKEhXNv1kAXM7AoKm74J4lTQlaYOS5zw8Td19xIXXDjlflyisZQ7
	 oPHI7Eg1Vd6fQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 18:27:31 +1000
Subject: [PATCH mptcp-next 4/4] mptcp: use READ_ONCE() over sysctls
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-4-d7c842e80446@kernel.org>
References: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
In-Reply-To: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DvwRIfUN7YRZ5k5EVdGbqGg+rsg1sk3AYFpf1i2tPKU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHUJ9cX+s7BAZ+0fpAbLfrk6vpIOQKROslPtJ0
 XCgyCYxbnSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah1CfQAKCRD2t4JPQmmg
 c1ndEACyQssQHFT1lnOuyAZ0WTXZsUgWDTkZnWOkpnyZ/2D3wU524eVT381gBETbOoh/nGsYQqz
 bCoOY7kPC1T95RyWyornUfGmWXE9s0vGKfseZ2UMn0j5FrsYLEAxMNIf9u28pon4B9YaqMlyuLl
 /PmO4kWNY2PIR4nITwjJ2yOaGB5/ttHdo85jotYhrlU1n20hsGUIMNEQaUHx1l7pQjC/SsTUFXd
 nOJJCwFgWxxhBdyByTteIeI57f2ZUB0oR2gF5JW0T3blVsEmo0tzXv7L7uAPLv27L1u/QI9SIKA
 QKEzo4g9aVFAXOk3cfsvG4PwSstovoPEBYD0oAiUyP7K5LsRNjygi7AU1b5q8qcIkZDCTmn4D1P
 5HfTM987COvubbsCO5YAmn/dfbHSB45L4v7tDJAlgRKWwqeT/sV6+bOyams0TVEaJc7nw/41346
 aCyO1dfJHDb48ltP4rYkzqH1bhIcUuPJuT666QRn/pp0YfyYVhu7HvTZhh61teUOfH7XLjTqf4N
 zfiH/WTsLrmwkq4PsG9Z1delUbgBUEheRoFzW6hs547xLgm2jg8xtOARTJ443GRwtcASCFez3fN
 dsMq7lg0RWMI5QqZkvixXjM9cMQMfLXxgxBzDd9UXDntVjGM/M7cPrnCqy6my3btXHJCT+91DKm
 BGoPXRQ1M8LCoNg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

To avoid KCSAN issues.

This patch is in theory for -net, and will need to be split in multiple
patches, with different Fixes tags. But I prefer to wait for Eric's
patches, as I noticed he already started to modify mptcp_is_enabled:

  https://lore.kernel.org/CANn89iLdwhhwLyO6zRjWMEY3t9g60ZE8ZhOVx33ucg_uRETbmQ@mail.gmail.com

Still, keeping this patch in this series, not to forget about it.

Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/CANn89iL=os-60kDKqMDdyiXuPF5CG=eejS0vmthwpDGXz_Bp8A@mail.gmail.com
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..1dee42601700 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -50,39 +50,39 @@ static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
 
 int mptcp_is_enabled(const struct net *net)
 {
-	return mptcp_get_pernet(net)->mptcp_enabled;
+	return READ_ONCE(mptcp_get_pernet(net)->mptcp_enabled);
 }
 
 unsigned int mptcp_get_add_addr_timeout(const struct net *net)
 {
-	return mptcp_get_pernet(net)->add_addr_timeout;
+	return READ_ONCE(mptcp_get_pernet(net)->add_addr_timeout);
 }
 
 int mptcp_is_checksum_enabled(const struct net *net)
 {
-	return mptcp_get_pernet(net)->checksum_enabled;
+	return READ_ONCE(mptcp_get_pernet(net)->checksum_enabled);
 }
 
 int mptcp_allow_join_id0(const struct net *net)
 {
-	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
+	return READ_ONCE(mptcp_get_pernet(net)->allow_join_initial_addr_port);
 }
 
 unsigned int mptcp_stale_loss_cnt(const struct net *net)
 {
-	return mptcp_get_pernet(net)->stale_loss_cnt;
+	return READ_ONCE(mptcp_get_pernet(net)->stale_loss_cnt);
 }
 
 unsigned int mptcp_close_timeout(const struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_DEAD))
 		return TCP_TIMEWAIT_LEN;
-	return mptcp_get_pernet(sock_net(sk))->close_timeout;
+	return READ_ONCE(mptcp_get_pernet(sock_net(sk))->close_timeout);
 }
 
 int mptcp_get_pm_type(const struct net *net)
 {
-	return mptcp_get_pernet(net)->pm_type;
+	return READ_ONCE(mptcp_get_pernet(net)->pm_type);
 }
 
 const char *mptcp_get_path_manager(const struct net *net)
@@ -551,7 +551,7 @@ void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
 
 	net = sock_net(ssk);
 	timeouts = inet_csk(ssk)->icsk_retransmits;
-	to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
+	to_max = READ_ONCE(mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback);
 
 	if (timeouts == to_max || (timeouts < to_max && expired)) {
 		subflow->mpc_drop = 1;

-- 
2.53.0

