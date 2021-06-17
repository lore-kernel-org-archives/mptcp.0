Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07B70
	for <mptcp@lists.linux.dev>; Thu, 17 Jun 2021 09:15:02 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:35304.1563350684
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-5115ca8f26c14b9a91d0dcf6ea180cd4 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id DBA17280098;
	Thu, 17 Jun 2021 17:15:01 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id 56f720f064a34810a2105cea6568f839 for mptcp@lists.linux.dev;
	Thu Jun 17 17:15:00 2021
X-Transaction-ID: 56f720f064a34810a2105cea6568f839
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH v3 3/4] mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
Date: Thu, 17 Jun 2021 17:14:35 +0800
Message-Id: <1623921276-97178-4-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
References: <1623921276-97178-1-git-send-email-liyonglong@chinatelecom.cn>
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
 net/mptcp/options.c  | 161 +++++++++++++++++++++++++++++++++------------------
 net/mptcp/pm.c       |  30 +++-------
 net/mptcp/protocol.h |  13 +++--
 3 files changed, 122 insertions(+), 82 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1aec016..3ecf2c6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -655,43 +655,72 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
-	bool echo;
-	bool port;
+	struct mptcp_addr_info remote;
+	struct mptcp_addr_info local;
+	int ret = false;
+	u8 add_addr, flags;
 	int len;
 
-	if ((mptcp_pm_should_add_signal_ipv6(msk) ||
-	     mptcp_pm_should_add_signal_port(msk) ||
-	     mptcp_pm_should_add_signal_echo(msk)) &&
-	    skb && skb_is_tcp_pure_ack(skb)) {
-		pr_debug("drop other suboptions");
-		opts->suboptions = 0;
-		opts->ext_copy.use_ack = 0;
-		opts->ext_copy.use_map = 0;
-		remaining += opt_size;
-		drop_other_suboptions = true;
-	}
-
-	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &opts->addr, &echo, &port)))
-		return false;
-
-	len = mptcp_add_addr_len(opts->addr.family, echo, port);
-	if (remaining < len)
-		return false;
-
-	*size = len;
-	if (drop_other_suboptions)
-		*size -= opt_size;
-	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
-	if (!echo) {
+	if (!mptcp_pm_should_add_signal(msk))
+		goto out;
+
+	*size = 0;
+	mptcp_pm_add_addr_signal(msk, &local, &remote, &add_addr);
+	if (mptcp_pm_should_add_signal_echo(msk)) {
+		if (skb && skb_is_tcp_pure_ack(skb)) {
+			pr_debug("drop other suboptions");
+			opts->suboptions = 0;
+			opts->ext_copy.use_ack = 0;
+			opts->ext_copy.use_map = 0;
+			remaining += opt_size;
+			drop_other_suboptions = true;
+		}
+		len = mptcp_add_addr_len(remote.family, true, !!remote.port);
+		if (remaining < len && mptcp_pm_should_add_signal_addr(msk))
+			goto add_addr;
+		else if (remaining < len)
+			goto out;
+		remaining -= len;
+		*size += len;
+		opts->remote = remote;
+		flags = (u8)~BIT(MPTCP_ADD_ADDR_ECHO);
+		opts->suboptions |= OPTION_MPTCP_ADD_ECHO;
+		pr_debug("addr_id=%d, echo=1, port=%d addr_signal:%x",
+			 opts->remote.id, ntohs(opts->remote.port), add_addr);
+	} else if (mptcp_pm_should_add_signal_addr(msk)) {
+add_addr:
+		if ((local.family == AF_INET6 || local.port) && skb &&
+		    skb_is_tcp_pure_ack(skb)) {
+			pr_debug("drop other suboptions");
+			opts->suboptions = 0;
+			opts->ext_copy.use_ack = 0;
+			opts->ext_copy.use_map = 0;
+			remaining += opt_size;
+			drop_other_suboptions = true;
+		}
+		len = mptcp_add_addr_len(local.family, false, !!local.port);
+		if (remaining < len)
+			goto out;
+		*size += len;
+		opts->addr = local;
 		opts->ahmac = add_addr_generate_hmac(msk->local_key,
 						     msk->remote_key,
 						     &opts->addr);
+		opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
+		flags = (u8)~BIT(MPTCP_ADD_ADDR_SIGNAL);
+		pr_debug("addr_id=%d, ahmac=%llu, echo=0, port=%d, addr_signal:%x",
+			 opts->addr.id, opts->ahmac, ntohs(opts->addr.port), add_addr);
 	}
-	pr_debug("addr_id=%d, ahmac=%llu, echo=%d, port=%d",
-		 opts->addr.id, opts->ahmac, echo, ntohs(opts->addr.port));
 
-	return true;
+	if (drop_other_suboptions)
+		*size -= opt_size;
+	spin_lock_bh(&msk->pm.lock);
+	WRITE_ONCE(msk->pm.addr_signal, flags | msk->pm.addr_signal);
+	spin_unlock_bh(&msk->pm.lock);
+	ret = true;
+
+out:
+	return ret;
 }
 
 static bool mptcp_established_options_rm_addr(struct sock *sk,
@@ -1230,21 +1259,18 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 mp_capable_done:
 	if (OPTION_MPTCP_ADD_ADDR & opts->suboptions) {
 		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
-		u8 echo = MPTCP_ADDR_ECHO;
+		u8 echo = 0;
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		if (opts->addr.family == AF_INET6)
 			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
 #endif
 
+		len += sizeof(opts->ahmac);
+
 		if (opts->addr.port)
 			len += TCPOLEN_MPTCP_PORT_LEN;
 
-		if (opts->ahmac) {
-			len += sizeof(opts->ahmac);
-			echo = 0;
-		}
-
 		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
 				      len, echo, opts->addr.id);
 		if (opts->addr.family == AF_INET) {
@@ -1259,30 +1285,55 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 #endif
 
 		if (!opts->addr.port) {
-			if (opts->ahmac) {
-				put_unaligned_be64(opts->ahmac, ptr);
-				ptr += 2;
-			}
+			put_unaligned_be64(opts->ahmac, ptr);
+			ptr += 2;
 		} else {
 			u16 port = ntohs(opts->addr.port);
+			u8 *bptr = (u8 *)ptr;
 
-			if (opts->ahmac) {
-				u8 *bptr = (u8 *)ptr;
+			put_unaligned_be16(port, bptr);
+			bptr += 2;
+			put_unaligned_be64(opts->ahmac, bptr);
+			bptr += 8;
+			put_unaligned_be16(TCPOPT_NOP << 8 |
+					   TCPOPT_NOP, bptr);
 
-				put_unaligned_be16(port, bptr);
-				bptr += 2;
-				put_unaligned_be64(opts->ahmac, bptr);
-				bptr += 8;
-				put_unaligned_be16(TCPOPT_NOP << 8 |
-						   TCPOPT_NOP, bptr);
+			ptr += 3;
+		}
+	}
 
-				ptr += 3;
-			} else {
-				put_unaligned_be32(port << 16 |
-						   TCPOPT_NOP << 8 |
-						   TCPOPT_NOP, ptr);
-				ptr += 1;
-			}
+	if (OPTION_MPTCP_ADD_ECHO & opts->suboptions) {
+		u8 len = TCPOLEN_MPTCP_ADD_ADDR_BASE;
+		u8 echo = MPTCP_ADDR_ECHO;
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		if (opts->remote.family == AF_INET6)
+			len = TCPOLEN_MPTCP_ADD_ADDR6_BASE;
+#endif
+
+		if (opts->remote.port)
+			len += TCPOLEN_MPTCP_PORT_LEN;
+
+		*ptr++ = mptcp_option(MPTCPOPT_ADD_ADDR,
+				      len, echo, opts->remote.id);
+		if (opts->remote.family == AF_INET) {
+			memcpy((u8 *)ptr, (u8 *)&opts->remote.addr.s_addr, 4);
+			ptr += 1;
+		}
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		else if (opts->remote.family == AF_INET6) {
+			memcpy((u8 *)ptr, opts->remote.addr6.s6_addr, 16);
+			ptr += 4;
+		}
+#endif
+
+		if (opts->remote.port) {
+			u16 port = ntohs(opts->remote.port);
+
+			put_unaligned_be32(port << 16 |
+					   TCPOPT_NOP << 8 |
+					   TCPOPT_NOP, ptr);
+			ptr += 1;
 		}
 	}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 74be6d7..a62d4a5 100644
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
-	add_addr = msk->pm.addr_signal & BIT(MPTCP_RM_ADDR_SIGNAL);
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

