Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0142CB0
	for <mptcp@lists.linux.dev>; Fri,  3 Dec 2021 22:35:52 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="235802948"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="235802948"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:35:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460185313"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.18.88])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 14:35:47 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Maxim Galaganov <max@internet.ru>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 08/10] tcp: expose __tcp_sock_set_cork and __tcp_sock_set_nodelay
Date: Fri,  3 Dec 2021 14:35:39 -0800
Message-Id: <20211203223541.69364-9-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Galaganov <max@internet.ru>

Expose __tcp_sock_set_cork() and __tcp_sock_set_nodelay() for use in
MPTCP setsockopt code -- namely for syncing MPTCP socket options with
subflows inside sync_socket_options() while already holding the subflow
socket lock.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Maxim Galaganov <max@internet.ru>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/linux/tcp.h | 2 ++
 net/ipv4/tcp.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 48d8a363319e..78b91bb92f0d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -512,11 +512,13 @@ static inline u16 tcp_mss_clamp(const struct tcp_sock *tp, u16 mss)
 int tcp_skb_shift(struct sk_buff *to, struct sk_buff *from, int pcount,
 		  int shiftlen);
 
+void __tcp_sock_set_cork(struct sock *sk, bool on);
 void tcp_sock_set_cork(struct sock *sk, bool on);
 int tcp_sock_set_keepcnt(struct sock *sk, int val);
 int tcp_sock_set_keepidle_locked(struct sock *sk, int val);
 int tcp_sock_set_keepidle(struct sock *sk, int val);
 int tcp_sock_set_keepintvl(struct sock *sk, int val);
+void __tcp_sock_set_nodelay(struct sock *sk, bool on);
 void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6ab82e1a1d41..20054618c87e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3207,7 +3207,7 @@ static void tcp_enable_tx_delay(void)
  * TCP_CORK can be set together with TCP_NODELAY and it is stronger than
  * TCP_NODELAY.
  */
-static void __tcp_sock_set_cork(struct sock *sk, bool on)
+void __tcp_sock_set_cork(struct sock *sk, bool on)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -3235,7 +3235,7 @@ EXPORT_SYMBOL(tcp_sock_set_cork);
  * However, when TCP_NODELAY is set we make an explicit push, which overrides
  * even TCP_CORK for currently queued segments.
  */
-static void __tcp_sock_set_nodelay(struct sock *sk, bool on)
+void __tcp_sock_set_nodelay(struct sock *sk, bool on)
 {
 	if (on) {
 		tcp_sk(sk)->nonagle |= TCP_NAGLE_OFF|TCP_NAGLE_PUSH;
-- 
2.34.1

