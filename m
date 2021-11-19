Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A92C81
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 20:41:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="295303538"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="295303538"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 12:41:47 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="506889214"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.14.166])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 12:41:44 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Poorva Sonparote <psonparo@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/4] ipv4: Exposing __ip_sock_set_tos() in ip.h
Date: Fri, 19 Nov 2021 12:41:34 -0800
Message-Id: <20211119204137.415733-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211119204137.415733-1-mathew.j.martineau@linux.intel.com>
References: <20211119204137.415733-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Poorva Sonparote <psonparo@redhat.com>

Making the static function __ip_sock_set_tos() from net/ipv4/ip_sockglue.c
accessible by declaring it in include/net/ip.h
The reason for doing this is to use this function to set IP_TOS value in
mptcp_setsockopt() without the lock.

Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/ip.h       | 1 +
 net/ipv4/ip_sockglue.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 7d1088888c10..81e23a102a0d 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -783,5 +783,6 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
 void ip_sock_set_pktinfo(struct sock *sk);
 void ip_sock_set_recverr(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
+void  __ip_sock_set_tos(struct sock *sk, int val);
 
 #endif	/* _IP_H */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 38d29b175ca6..445a9ecaefa1 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -576,7 +576,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	return err;
 }
 
-static void __ip_sock_set_tos(struct sock *sk, int val)
+void __ip_sock_set_tos(struct sock *sk, int val)
 {
 	if (sk->sk_type == SOCK_STREAM) {
 		val &= ~INET_ECN_MASK;
-- 
2.34.0

