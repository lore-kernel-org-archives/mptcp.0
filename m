Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38903187357
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268162; cv=none; b=fRPtnX64iZJhmkeAt7u1r4RzgxBX/QgahcJeTZwl7rLOO50A9tEoBogIgzpSnK9Gj3y7m8xCyJexIBupEcKDkjoi31GoNExHTUrauPNV0aF9zh7SAzvGEnJqWVoaa7eyxkOKeNqSPlcoqclJsyJkf7hUZMUdYXsBRJNYs93ZfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268162; c=relaxed/simple;
	bh=rjEniUY9LS7YomeFWzdX/evdWHB/tnFmR/a7VtVogJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poeGtAAlW9WuoUrP8MDyeKiJG53wbRGQkGvuILI9p29lJ0kzQeR61M05ZV6nbeCJcC6yAveryIqoDWlu5lprryVLAEndUHzosJ+omQ0so91C30qLWsYSFvTaoOl/3Oz+eHZY8enNa+4Oi4S/m5xWDuLvyIac8Vp0/+VidgMZ49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsaoKxtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsaoKxtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B81BC4CECB;
	Mon,  2 Sep 2024 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725268161;
	bh=rjEniUY9LS7YomeFWzdX/evdWHB/tnFmR/a7VtVogJE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DsaoKxtjYTOoCYxWamyIlspaEtBXChSk2nJPOM6PeBe+BDkEgU3Uw0VwJeEND10dK
	 lqhFHUoMTa6m6kUbhRRnAIG3FLXeZqzYqgj0KK0X/8aZyu9ltvfR7cjnQZ5tPDbnYM
	 xv1vj9yhuN732sY7kdJ/ycu9plDMEqr25Ho+ZIVOG1YkK8mIeCk70ILySMwDGKVQfU
	 CjYJxYeYqmJiYG0eFZNBxBLmgQqHsnwLfN6oeIFsOcI9SRLpPsET9vxiy1erjlCvAI
	 H0R6VLITcJGnAqXfZIDc4+r7+KoOaL2XjMWVRncdS9pPkDmuav1tqbhNgZuR/Vjrk0
	 VGdoy6VZpSIXw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 11:09:09 +0200
Subject: [PATCH mptcp-next 2/3] mptcp: fallback to TCP after SYN+MPC drops
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-mptcp-fallback-x-mpc-v1-2-86d9170ddff7@kernel.org>
References: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
In-Reply-To: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4433; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rjEniUY9LS7YomeFWzdX/evdWHB/tnFmR/a7VtVogJE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1YC+gj2ZqqsM+Nrl+z/57rpKRPXraX/BYVqF/
 ejYUoEkAAqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWAvgAKCRD2t4JPQmmg
 c62fEADa+12gqocSDc06XaU1E8XI5R578ehPmj4VvSPHxh64nbEbPnP6JjAPPhzBez2/Zmbeqm4
 s9Dqa5ljoRw3qualVyF9al+H3Vp0/qA+FfBfQJpQLYcu7vJeyOeijUtG9vGqsaNDFty1rWLNjpG
 n0aLGMBjt6OjM2DDB5k3bCzgzAc6cYPbbL+OEpgOicvYsumrio+b+/YKDaigvXjs3v91psYF71R
 CVs1RMOIMQpNaOK9oV4n9DEvkEkUAf8ssS6K+zg5V8qgRLOoMQ4eI/1IiHgO29AjXfiynMkjcQN
 ziijJwruR0SkWQbPiqyx3+gntLM8WSiNjgvEkO89YyGpEgPwPar7ZuQAwFnBvlXUzW7mc0lGKj9
 snUxg3LWQ/MqSA/o0UnQ78dht51cl3wZ1d3uBuOC9sVLHeMNpcTNpcw9tpDXgErACdBl82xkND3
 ERHjlCdk4ZDuSZp9uliAelAXFk3Xdle+kWUuHpSWSMTwyusN6ipCbfDijRUYYVNkA5Kn74LIluO
 14E4Xe6GAWrN5D/fDBFARPm3alppGpqOP22Obvk4VwccrHLXDGuzdx9kgsnr4y+0SlXEm9+gBJY
 LxcRUb3NQM/0K9lEKPmGmOh4Q0VVw1b8DQ2joearS6XZHu9aXD6PZElPLAQr40Sb1ZhzTdfwzxD
 UAa/eKWq6JPxQmA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some middleboxes might be nasty with MPTCP, and decide to drop packets
with MPTCP options, instead of just dropping the MPTCP options (or
letting them pass...).

In this case, it sounds better to fallback to "plain" TCP, and try
again.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/477
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/net/mptcp.h  |  4 ++++
 net/ipv4/tcp_timer.c |  1 +
 net/mptcp/ctrl.c     | 20 ++++++++++++++++++++
 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 5 files changed, 27 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0bc4ab03f487..814b5f2e3ed5 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -223,6 +223,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 
 	return htonl(0u);
 }
+
+void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
 #else
 
 static inline void mptcp_init(void)
@@ -307,6 +309,8 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 }
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
+
+static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 86169127e4d1..79064580c8c0 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -282,6 +282,7 @@ static int tcp_write_timeout(struct sock *sk)
 		expired = retransmits_timed_out(sk, retry_until,
 						READ_ONCE(icsk->icsk_user_timeout));
 	tcp_fastopen_active_detect_blackhole(sk, expired);
+	mptcp_active_detect_blackhole(sk, expired);
 
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTO_CB_FLAG))
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RTO_CB,
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 99382c317ebb..0b23e3c5e8ff 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -12,6 +12,7 @@
 #include <net/netns/generic.h>
 
 #include "protocol.h"
+#include "mib.h"
 
 #define MPTCP_SYSCTL_PATH "net/mptcp"
 
@@ -277,6 +278,25 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
 
 #endif /* CONFIG_SYSCTL */
 
+/* Check the number of retransmissions, and fallback to TCP if needed */
+void mptcp_active_detect_blackhole(struct sock *ssk, bool expired)
+{
+	struct mptcp_subflow_context *subflow;
+	u32 timeouts;
+
+	if (!sk_is_mptcp(ssk))
+		return;
+
+	timeouts = inet_csk(ssk)->icsk_retransmits;
+	subflow = mptcp_subflow_ctx(ssk);
+
+	if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT &&
+	    (timeouts == 2 || (timeouts < 2 && expired))) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVEDROP);
+		mptcp_subflow_early_fallback(mptcp_sk(subflow->conn), subflow);
+	}
+}
+
 static int __net_init mptcp_net_init(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index ec0d461cb921..d70a3e2bfad6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -15,6 +15,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBACK),
+	SNMP_MIB_ITEM("MPCapableSYNTXDrop", MPTCP_MIB_MPCAPABLEACTIVEDROP),
 	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index d68136f93dac..062775700b63 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -10,6 +10,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way handshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way handshake */
+	MPTCP_MIB_MPCAPABLEACTIVEDROP,	/* Client-side fallback due to a MPC drop */
 	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */

-- 
2.45.2

