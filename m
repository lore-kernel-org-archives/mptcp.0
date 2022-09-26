Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684994A14
	for <mptcp@lists.linux.dev>; Mon, 26 Sep 2022 23:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664234866; x=1695770866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dTdNtwOMsNbFRYHs8fkMG5KM7mukDSfJKHtWQRWdNQ8=;
  b=D3vLVigstQRnm/4JMZ5RJOnjd7hI/rFBHGRcpp2UmUt3FmAY7ogU2XlD
   tov4ZbggR2/VYKT9qBezlWDJZ0j8BLBVWaTw/A8FxSq3VB22A+AZqo2mG
   aSmYT+7ysuqsjktgDSGRZrOOMT3IGEJtcUl/McnPRdwfK8A+i07qnxZxC
   0Uuwj2TUBjs9CJpgqZlo/uY8pduxFgeduJBPn6lwdAueMBpduYimcNHah
   3S6OvWAecwmHL9ouM+I8L7cHaPyee9rEfCES8FqFr1Yd2ODpV6i5WRsG8
   liWs25gg2k7rif5pSav3qjP9xoFYW2QTpwHd6H/2DngG1EFHpcld12n2h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="280890868"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="280890868"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="572424285"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="572424285"
Received: from sankarka-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.3.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 16:27:43 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dmytro@shytyi.net,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/4] mptcp: add TCP_FASTOPEN_CONNECT socket option
Date: Mon, 26 Sep 2022 16:27:36 -0700
Message-Id: <20220926232739.76317-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926232739.76317-1-mathew.j.martineau@linux.intel.com>
References: <20220926232739.76317-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Hesmans <benjamin.hesmans@tessares.net>

Set the option for the first subflow only. For the other subflows TFO
can't be used because a mapping would be needed to cover the data in the
SYN.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 423d3826ca1e..c7cb68c725b2 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_NOTSENT_LOWAT:
 		case TCP_TX_DELAY:
 		case TCP_INQ:
+		case TCP_FASTOPEN_CONNECT:
 			return true;
 		}
 
@@ -567,7 +568,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
-		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN TCP_FASTOPEN_CONNECT, TCP_FASTOPEN_NO_COOKIE,
+		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN, TCP_FASTOPEN_NO_COOKIE,
 		 * are not supported fastopen is currently unsupported
 		 */
 	}
@@ -768,6 +769,19 @@ static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optv
 	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
 }
 
+static int mptcp_setsockopt_sol_tcp_fastopen_connect(struct mptcp_sock *msk, sockptr_t optval,
+						     unsigned int optlen)
+{
+	struct socket *sock;
+
+	/* Limit to first subflow */
+	sock = __mptcp_nmpc_socket(msk);
+	if (!sock)
+		return -EINVAL;
+
+	return tcp_setsockopt(sock->sk, SOL_TCP, TCP_FASTOPEN_CONNECT, optval, optlen);
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -796,6 +810,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+	case TCP_FASTOPEN_CONNECT:
+		return mptcp_setsockopt_sol_tcp_fastopen_connect(msk, optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -1157,6 +1173,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_INFO:
 	case TCP_CC_INFO:
 	case TCP_DEFER_ACCEPT:
+	case TCP_FASTOPEN_CONNECT:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
-- 
2.37.3

