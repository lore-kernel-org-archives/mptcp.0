Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553772
	for <mptcp@lists.linux.dev>; Tue, 22 Jun 2021 04:46:00 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:60308.1638703953
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-10482a78b4d84243ae8fb1d52823714b (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 95D5228009C;
	Tue, 22 Jun 2021 12:46:01 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id c1cb54f9348e4f9da99e2760240f8b43 for mptcp@lists.linux.dev;
	Tue Jun 22 12:45:59 2021
X-Transaction-ID: c1cb54f9348e4f9da99e2760240f8b43
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v5 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
Date: Tue, 22 Jun 2021 12:45:34 +0800
Message-Id: <1624337135-149084-4-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1624337135-149084-1-git-send-email-liyonglong@chinatelecom.cn>
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
 include/net/mptcp.h  |   2 +-
 net/mptcp/options.c  | 105 ++++++++++++++++++++++++++++++---------------------
 net/mptcp/pm.c       |  30 +++++----------
 net/mptcp/protocol.h |  13 ++++---
 4 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 637e90b..d2c6ebe 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -61,7 +61,7 @@ struct mptcp_out_options {
 	u64 sndr_key;
 	u64 rcvr_key;
 	u64 ahmac;
-	struct mptcp_addr_info addr;
+	struct mptcp_addr_info local;
 	struct mptcp_addr_info remote;
 	struct mptcp_rm_list rm_list;
 	u8 join_id;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1aec016..a1fafed 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -655,13 +655,19 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
-	bool echo;
-	bool port;
-	int len;
+	struct mptcp_addr_info remote;
+	struct mptcp_addr_info local;
+	u8 add_addr, flags = 0xff;
+	int len = 0;
 
-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk) ||
-	     mptcp_pm_should_add_signal_echo(msk)) &&
+	if (!mptcp_pm_should_add_signal(msk))
+		return false;
+
+	mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
+	if ((mptcp_pm_should_add_signal_echo(msk) ||
+	     (!mptcp_pm_should_add_signal_echo(msk) &&
+	      mptcp_pm_should_add_signal_addr(msk) &&
+	      (local.family == AF_INET6 || local.port))) &&
 	    skb && skb_is_tcp_pure_ack(skb)) {
 		pr_debug("drop other suboptions");
 		opts->suboptions = 0;
@@ -671,25 +677,35 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		drop_other_suboptions = true;
 	}
 
-	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
-		return false;
-
-	len = mptcp_add_addr_len(opts->addr.family, echo, port);
-	if (remaining < len)
-		return false;
+	if (mptcp_pm_should_add_signal_echo(msk)) {
+		len = mptcp_add_addr_len(remote.family, true, !!remote.port);
+		if (remaining < len)
+			return false;
+		opts->remote = remote;
+		flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
+		opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
+	} else {
+		len = mptcp_add_addr_len(local.family, false, !!local.port);
+		if (remaining < len)
+			return false;
+		opts->local = local;
+		opts->ahmac = add_addr_generate_hmac(msk->local_key,
+						     msk->remote_key,
+						     &opts->local);
+		opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
+		flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
+	}
 
 	*size = len;
 	if (drop_other_suboptions)
 		*size -= opt_size;
-	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
-	if (!echo) {
-		opts->ahmac = add_addr_generate_hmac(msk->local_key,
-						     msk->remote_key,
-						     &opts->addr);
-	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
-		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
+	spin_lock_bh(&msk->pm.lock);
+	WRITE_ONCE(msk->pm.addr_signal, flags & msk->pm.addr_signal);
+	spin_unlock_bh(&msk->pm.lock);
+
+	pr_debug("addr_signal:%x, echo=%d, local_addr_id=%d, ahmac=%llu, local_port=%d, remote_addr_id=%d, remote_port=%d",
+		 add_addr, mptcp_pm_should_add_signal_echo(msk), opts->local.id,
+		 opts->ahmac, ntohs(opts->local.port), opts->remote.id, ntohs(opts->remote.port));
 
 	return true;
 }
@@ -1228,45 +1244,51 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	}
 
 mp_capable_done:
-	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
-		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
-		u8 echo = MPTCP_ADDR_ECHO;
+	if ((OPTION_MPTCP_ADD_ADDR | OPTION_MPTCP_ADD_ECHO) & opts->suboptions) {
+		struct mptcp_addr_info *addr_info;
+		u8 len = 0;
+		u8 echo = 0;
+
+		if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
+			len += sizeof(opts->ahmac);
+			addr_info = &opts->local;
+		} else {
+			echo = MPTCP_ADDR_ECHO;
+			addr_info = &opts->remote;
+		}
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		if (opts->addr.family == AF_INET6)
-			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+		if (addr_info->family == AF_INET6)
+			len += TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+		else
 #endif
+			len += TCPOLEN_MPTCP_ADD_ADDR_BASE;
 
-		if (opts->addr.port)
+		if (addr_info->port)
 			len += TCPOLEN_MPTCP_PORT_LEN;
 
-		if (opts->ahmac) {
-			len += sizeof(opts->ahmac);
-			echo = 0;
-		}
-
 		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
-				      len, echo, opts->addr.id);
-		if (opts->addr.family == AF_INET) {
-			memcpy((u8 *)ptr, (u8 *)&opts->addr.addr.s_addr, 4);
+				      len, echo, addr_info->id);
+		if (addr_info->family == AF_INET) {
+			memcpy((u8 *)ptr, (u8 *)&addr_info->addr.s_addr, 4);
 			ptr += 1;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (opts->addr.family == AF_INET6) {
-			memcpy((u8 *)ptr, opts->addr.addr6.s6_addr, 16);
+		else if (addr_info->family == AF_INET6) {
+			memcpy((u8 *)ptr, addr_info->addr6.s6_addr, 16);
 			ptr += 4;
 		}
 #endif
 
-		if (!opts->addr.port) {
-			if (opts->ahmac) {
+		if (!addr_info->port) {
+			if (!echo) {
 				put_unaligned_be64(opts->ahmac, ptr);
 				ptr += 2;
 			}
 		} else {
-			u16 port = ntohs(opts->addr.port);
+			u16 port = ntohs(addr_info->port);
 
-			if (opts->ahmac) {
+			if (!echo) {
 				u8 *bptr = (u8 *)ptr;
 
 				put_unaligned_be16(port, bptr);
@@ -1275,7 +1297,6 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				bptr += 8;
 				put_unaligned_be16(TCPOPT_NOP << 8 |
 						   TCPOPT_NOP, bptr);
-
 				ptr += 3;
 			} else {
 				put_unaligned_be32(port << 16 |
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 107a5a2..a62d4a5 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -22,7 +22,8 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	if (add_addr) {
+	if (add_addr &
+	    (echo ? BIT(MPTCP_ADD_ADDR_ECHO) : BIT(MPTCP_ADD_ADDR_SIGNAL))) {
 		pr_warn("addr_signal error, add_addr=%d", add_addr);
 		return -EINVAL;
 	}
@@ -252,32 +253,19 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 /* path manager helpers */
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port)
+void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_addr_info *saddr,
+			      struct mptcp_addr_info *daddr, u8 *add_addr)
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
-
 	*saddr = msk->pm.local;
-	add_addr = msk->pm.addr_signal & ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO));
-	WRITE_ONCE(msk->pm.addr_signal, add_addr);
-	ret = true;
+	*daddr = msk->pm.remote;
+	*add_addr = msk->pm.addr_signal;
 
-out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
-	return ret;
+
+	if ((mptcp_pm_should_add_signal_echo(msk)) && (mptcp_pm_should_add_signal_addr(msk)))
+		mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
 }
 
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a0b0ec0..90fb532 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -22,10 +22,11 @@
 #define OPTION_MPTCP_MPJ_SYNACK	BIT(4)
 #define OPTION_MPTCP_MPJ_ACK	BIT(5)
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
-#define OPTION_MPTCP_RM_ADDR	BIT(7)
-#define OPTION_MPTCP_FASTCLOSE	BIT(8)
-#define OPTION_MPTCP_PRIO	BIT(9)
-#define OPTION_MPTCP_RST	BIT(10)
+#define OPTION_MPTCP_ADD_ECHO	BIT(7)
+#define OPTION_MPTCP_RM_ADDR	BIT(8)
+#define OPTION_MPTCP_FASTCLOSE	BIT(9)
+#define OPTION_MPTCP_PRIO	BIT(10)
+#define OPTION_MPTCP_RST	BIT(11)
 
 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -760,8 +761,8 @@ static inline int mptcp_rm_addr_len(const struct mptcp_rm_list *rm_list)
 	return TCPOLEN_MPTCP_RM_ADDR_BASE + roundup(rm_list->nr - 1, 4) + 1;
 }
 
-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
-			      struct mptcp_addr_info *saddr, bool *echo, bool *port);
+void mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct mptcp_addr_info *saddr,
+			      struct mptcp_addr_info *daddr, u8 *add_addr);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
-- 
1.8.3.1

