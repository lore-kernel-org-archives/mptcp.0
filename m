Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596117C3
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 00:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666399554; x=1697935554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zhcIsV30RmXvtXV2KMqAcqNirSX2pOhDxfaozeXt4Dw=;
  b=YhMmiZxVYLySudXQIowkkDdrDA2p0fdfgyBPe6ndOMJSlucgIHV4Vf7I
   8NnG+gK58DBFf2pZO0VOil2W0dHIeSXg0HXou+yBYAGbj/D3o4S0jxnMY
   +oWz1vQ3VTUV/9tou5mPIXZ3RQ3X2esQH6kFuYjrseDOuBpw8DP0sR8VF
   GFz2siNcKi9NV7xFTswBnjTJXm6U1FSQOpCAh2pB2+P2t9j3nsCyqrIVQ
   VLR29D7vt/QT9H85Qyu3nUHmHOWWY8UDQnrqzoviBbBhMi5z2DL1NjPI4
   rLzSL2QWdrW3rwcs1t19OsfyqPNYHFegNNA/XrPk8eUDSy/tsox0uoU51
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308822191"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308822191"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:45:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581795621"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="581795621"
Received: from tremple-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:45:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/3] mptcp: sockopt: use new helper for TCP_DEFER_ACCEPT
Date: Fri, 21 Oct 2022 17:45:05 -0700
Message-Id: <20221022004505.160988-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221022004505.160988-1-mathew.j.martineau@linux.intel.com>
References: <20221022004505.160988-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

mptcp_setsockopt_sol_tcp_defer() was doing the same thing as
mptcp_setsockopt_first_sf_only() except for the returned code in case of
error.

Ignoring the error is needed to mimic how TCP_DEFER_ACCEPT is handled
when used with "plain" TCP sockets.

The specific function for TCP_DEFER_ACCEPT can be replaced by the new
mptcp_setsockopt_first_sf_only() helper and errors can be ignored to
stay compatible with TCP. A bit of cleanup.

Suggested-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 1857281a0dd5..f85e9bbfe86f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -758,18 +758,6 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
 	return -EOPNOTSUPP;
 }
 
-static int mptcp_setsockopt_sol_tcp_defer(struct mptcp_sock *msk, sockptr_t optval,
-					  unsigned int optlen)
-{
-	struct socket *listener;
-
-	listener = __mptcp_nmpc_socket(msk);
-	if (!listener)
-		return 0; /* TCP_DEFER_ACCEPT does not fail */
-
-	return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, optlen);
-}
-
 static int mptcp_setsockopt_first_sf_only(struct mptcp_sock *msk, int level, int optname,
 					  sockptr_t optval, unsigned int optlen)
 {
@@ -810,7 +798,9 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_NODELAY:
 		return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
 	case TCP_DEFER_ACCEPT:
-		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
+		/* See tcp.c: TCP_DEFER_ACCEPT does not fail */
+		mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname, optval, optlen);
+		return 0;
 	case TCP_FASTOPEN_CONNECT:
 	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
-- 
2.38.1

