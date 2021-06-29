Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D176C29D6
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 01:42:04 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:33510.417183281
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5a0c242f35f34769876aa48fc24ed7bb (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 1A68F28010C;
	Tue, 29 Jun 2021 09:42:03 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 19fe964f885c4089a3336712f5cb2728 for mptcp@lists.linux.dev;
	Tue Jun 29 09:42:03 2021
X-Transaction-ID: 19fe964f885c4089a3336712f5cb2728
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v6 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
Date: Tue, 29 Jun 2021 09:41:38 +0800
Message-Id: <1624930899-99623-4-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1624930899-99623-1-git-send-email-liyonglong@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

according MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO flag build
ADD_ADDR/echo-ADD_ADDR option

add a suboptions type OPTION_MPTCP_ADD_ECHO to mark as echo option

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 include/net/mptcp.h  |  3 ++-
 net/mptcp/options.c  | 65 +++++++++++++++++++++++++++++++---------------------
 net/mptcp/pm.c       | 33 +++++++++++---------------
 net/mptcp/protocol.h | 23 ++++++++++++-------
 4 files changed, 69 insertions(+), 55 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index d61bbbf..d2c6ebe 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -61,7 +61,8 @@ struct mptcp_out_options {
 	u64 sndr_key;
 	u64 rcvr_key;
 	u64 ahmac;
-	struct mptcp_addr_info addr;
+	struct mptcp_addr_info local;
+	struct mptcp_addr_info remote;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
 	u8 backup;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1aec016..1707bec 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -655,13 +655,15 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
-	bool echo;
-	bool port;
-	int len;
+	u8 add_addr, flags = 0xff;
+	int len = 0;
 
-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk) ||
-	     mptcp_pm_should_add_signal_echo(msk)) &&
+	if (!mptcp_pm_add_addr_signal(msk, opts, &add_addr))
+		return false;
+
+	if ((mptcp_pm_should_add_signal_echo(msk) ||
+	     (mptcp_pm_should_add_signal_addr(msk) &&
+	      (opts->local.family == AF_INET6 || opts->local.port))) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
@@ -671,11 +673,17 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		drop_other_suboptions = true;
 	}
 
-	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
-		return false;
 
-	len = mptcp_add_addr_len(opts->addr.family, echo, port);
+	if (mptcp_pm_should_add_signal_echo(msk)) {
+		flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
+	} else {
+		opts->ahmac = add_addr_generate_hmac(msk->local_key,
+						     msk->remote_key,
+						     &opts->local);
+		flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	}
+
+	len = mptcp_add_addr_len(opts);
 	if (remaining < len)
 		return false;
 
@@ -683,13 +691,14 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -= opt_size;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
-	if (!echo) {
-		opts->ahmac = add_addr_generate_hmac(msk->local_key,
-						     msk->remote_key,
-						     &opts->addr);
-	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
-		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
+
+	spin_lock_bh(&msk->pm.lock);
+	WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
+	spin_unlock_bh(&msk->pm.lock);
+
+	pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
+		 add_addr, (opts->ahmac == 0), opts->local.id,
+		 opts->ahmac, ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
 
 	return true;
 }
@@ -1229,15 +1238,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+		struct mptcp_addr_info *addr = &opts->remote;
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
 		u8 echo = MPTCP_ADDR_ECHO;
 
+		if (opts->ahmac)
+			addr = &opts->local;
+
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (opts->addr.family == AF_INET6)
+		if (addr->family == AF_INET6)
 			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 #endif
 
-		if (opts->addr.port)
+		if (addr->port)
 			len += TCPOLEN_MPTCP_PORT_LEN;
 
 		if (opts->ahmac) {
@@ -1246,25 +1259,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		}
 
 		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
-				      len, echo, opts->addr.id);
-		if (opts->addr.family == AF_INET) {
-			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
+				      len, echo, addr->id);
+		if (addr->family == AF_INET) {
+			memcpy((u8 *)ptr, (u8 *)&addr->addr.s_addr, 4);
 			ptr += 1;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (opts->addr.family == AF_INET6) {
-			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
+		else if (addr->family == AF_INET6) {
+			memcpy((u8 *)ptr, addr->addr6.s6_addr, 16);
 			ptr += 4;
 		}
 #endif
 
-		if (!opts->addr.port) {
+		if (!addr->port) {
 			if (opts->ahmac) {
 				put_unaligned_be64(opts->ahmac, ptr);
 				ptr += 2;
 			}
 		} else {
-			u16 port = ntohs(opts->addr.port);
+			u16 port = ntohs(addr->port);
 
 			if (opts->ahmac) {
 				u8 *bptr = (u8 *)ptr;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index cf873e9..9c621293 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -253,32 +253,25 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_out_options *opts,
+			      u8 *add_addr)
 {
-	u8 add_addr;
-	int ret = false;
-
 	spin_lock_bh(&msk->pm.lock);
 
-	/* double check after the lock is acquired */
-	if (!mptcp_pm_should_add_signal(msk))
-		goto out_unlock;
-
-	*echo = mptcp_pm_should_add_signal_echo(msk);
-	*port = mptcp_pm_should_add_signal_port(msk);
-
-	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
-		goto out_unlock;
+	if (!mptcp_pm_should_add_signal(msk)) {
+		spin_unlock_bh(&msk->pm.lock);
+		return false;
+	}
 
-	*saddr = msk->pm.local;
-	add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
-	WRITE_ONCE(msk->pm.addr_signal, add_addr);
-	ret = true;
+	opts->local = msk->pm.local;
+	opts->remote = msk->pm.remote;
+	*add_addr = msk->pm.addr_signal;
 
-out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
-	return ret;
+
+	if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
+	return true;
 }
 
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0b0ec0..0bfbbdef 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -737,16 +737,23 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
+static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *opts)
 {
-	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
+	u8 len = 0;
+	struct mptcp_addr_info *addr = &opts->remote;
 
-	if (family == AF_INET6)
-		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-	if (!echo)
+	if (opts->ahmac) {
+		addr = &opts->local;
 		len += MPTCPOPT_THMAC_LEN;
+	}
+
+	if (addr->family == AF_INET6)
+		len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+	else
+		len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
+
 	/* account for 2 trailing 'nop' options */
-	if (port)
+	if (addr->port)
 		len += TCPOLEN_MPTCP_PORT_LEN + TCPOLEN_MPTCP_PORT_ALIGN;
 
 	return len;
@@ -760,8 +767,8 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_out_options *opts,
+			      u8 *add_addr);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
1.8.3.1

