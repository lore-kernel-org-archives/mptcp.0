Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460572
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 17:02:10 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:54022.267134115
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-436ef2b3ccc547e0a5ea08a54c44f662 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id A56A82800DD;
	Thu,  8 Jul 2021 01:02:06 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id b9c920d6a4d1428ca5ba1444f939b94c for mptcp@lists.linux.dev;
	Thu Jul  8 01:02:11 2021
X-Transaction-ID: b9c920d6a4d1428ca5ba1444f939b94c
X-filter-score:
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v8 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
Date: Thu,  8 Jul 2021 01:01:40 +0800
Message-Id: <1625677301-139357-4-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1625677301-139357-1-git-send-email-liyonglong@chinatelecom.cn>
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
 net/mptcp/options.c  | 51 ++++++++++++++++++++++++++++-----------------------
 net/mptcp/pm.c       | 20 ++++++++++++++------
 net/mptcp/protocol.h | 26 ++++++++++++++++++--------
 4 files changed, 62 insertions(+), 38 deletions(-)

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
index 1aec016..de20312 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -655,13 +655,16 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
-	bool echo;
-	bool port;
+	u8 add_addr;
 	int len;
 
-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk) ||
-	     mptcp_pm_should_add_signal_echo(msk)) &&
+	if (!mptcp_pm_should_add_signal(msk) ||
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, opts, &add_addr))
+		return false;
+
+	if (((add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) ||
+	     ((add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
+	      (opts->local.family == AF_INET6 || opts->local.port))) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
@@ -671,11 +674,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		drop_other_suboptions = true;
 	}
 
-	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
-		return false;
-
-	len = mptcp_add_addr_len(opts->addr.family, echo, port);
+	len = mptcp_add_addr_len(opts, add_addr);
 	if (remaining < len)
 		return false;
 
@@ -683,13 +682,15 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	if (drop_other_suboptions)
 		*size -= opt_size;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
-	if (!echo) {
+	if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
+	    (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
-						     &opts->addr);
+						     &opts->local);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
-		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
+	pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
+		 add_addr, (opts->ahmac == 0), opts->local.id, opts->ahmac,
+		 ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
 
 	return true;
 }
@@ -1229,15 +1230,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 
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
@@ -1246,25 +1251,25 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
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
index 6a91189..ad61b77 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -253,8 +253,9 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+			      unsigned int opt_size, unsigned int remaining,
+			      struct mptcp_out_options *opts,  u8 *add_addr)
 {
 	int ret = false;
 
@@ -264,13 +265,20 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 
-	*echo = mptcp_pm_should_add_signal_echo(msk);
-	*port = mptcp_pm_should_add_signal_port(msk);
+	opts->local = msk->pm.local;
+	opts->remote = msk->pm.remote;
+	*add_addr = msk->pm.addr_signal;
 
-	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *port))
+	if (((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)) ||
+	     ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL)) &&
+	      (msk->pm.local.family == AF_INET6 || msk->pm.local.port))) &&
+	    skb && skb_is_tcp_pure_ack(skb)) {
+		remaining += opt_size;
+	}
+
+	if (remaining < mptcp_add_addr_len(opts, *add_addr))
 		goto out_unlock;
 
-	*saddr = msk->pm.local;
 	if ((msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_ECHO)))
 		WRITE_ONCE(msk->pm.addr_signal, msk->pm.addr_signal & ~BIT(MPTCP_ADD_ADDR_ECHO));
 	else
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0b0ec0..f7be24a 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -737,16 +737,25 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 	return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
 
-static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool port)
+static inline unsigned int mptcp_add_addr_len(struct mptcp_out_options *opts,
+					      u8 add_addr)
 {
-	u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
+	struct mptcp_addr_info *addr = &opts->remote;
+	u8 len = 0;
 
-	if (family == AF_INET6)
-		len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
-	if (!echo)
+	if (!(add_addr & BIT(MPTCP_ADD_ADDR_ECHO)) &&
+	    (add_addr & BIT(MPTCP_ADD_ADDR_SIGNAL))) {
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
@@ -760,8 +769,9 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
+			      unsigned int opt_size, unsigned int remaining,
+			      struct mptcp_out_options *opts,  u8 *add_addr);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
1.8.3.1

