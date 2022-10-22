Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3317CF
	for <mptcp@lists.linux.dev>; Sat, 22 Oct 2022 00:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666399552; x=1697935552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bts6J7VmVqhJslBL4eKvBMqv2XznmmoBLJcdMMDN+8A=;
  b=TlVNLXPWRDb8ykMdbbsMyU/yNeRg5wG9WhbYigrT6m56MZ0x/4mlJtr+
   oOCvQalNyPj6aqvmYMiB6zB3D+IedV289qcHI0QH34qm6HrC9nIW17V/6
   /jH5fAATygDDkMYy0lkrv/Jq5igCFEvpVp5DZaa8QG002IEwlMN+8SvuN
   3vZrXUy6MQ7bP1UYj4uLUkKClgFSbFWu2qm9iJ8GR7C1FOFIbikVrJ5D0
   o+oC30t3MG45L9CkTCMojSamoNMKPejb3/alRVeuTQdsHCOaqJQKvd7g2
   siAp8aIOzBJVp8Za/7wQ4tVYQI2sipQ6OHvap7JaaqIytzlq6PD9gjVSY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308822190"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308822190"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:45:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581795620"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="581795620"
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
Subject: [PATCH net-next 2/3] mptcp: add TCP_FASTOPEN_NO_COOKIE support
Date: Fri, 21 Oct 2022 17:45:04 -0700
Message-Id: <20221022004505.160988-3-mathew.j.martineau@linux.intel.com>
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

The goal of this socket option is to configure MPTCP + TFO without
cookie per socket.

It was already possible to enable TFO without a cookie per netns by
setting net.ipv4.tcp_fastopen sysctl knob to the right value. Per route
was also supported by setting 'fastopen_no_cookie' option. This patch
adds a per socket support like it is possible to do with TCP thanks to
TCP_FASTOPEN_NO_COOKIE socket option.

The only thing to do here is to relay the request to the first subflow
like it is already done for TCP_FASTOPEN_CONNECT.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8d3b09d75c3a..1857281a0dd5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -560,6 +560,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		case TCP_TX_DELAY:
 		case TCP_INQ:
 		case TCP_FASTOPEN_CONNECT:
+		case TCP_FASTOPEN_NO_COOKIE:
 			return true;
 		}
 
@@ -568,8 +569,8 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* TCP_REPAIR, TCP_REPAIR_QUEUE, TCP_QUEUE_SEQ, TCP_REPAIR_OPTIONS,
 		 * TCP_REPAIR_WINDOW are not supported, better avoid this mess
 		 */
-		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN, TCP_FASTOPEN_NO_COOKIE,
-		 * are not supported fastopen is currently unsupported
+		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN are not supported because
+		 * fastopen for the listener side is currently unsupported
 		 */
 	}
 	return false;
@@ -811,6 +812,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_DEFER_ACCEPT:
 		return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
 	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_setsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	}
@@ -1175,6 +1177,7 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CC_INFO:
 	case TCP_DEFER_ACCEPT:
 	case TCP_FASTOPEN_CONNECT:
+	case TCP_FASTOPEN_NO_COOKIE:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
 	case TCP_INQ:
-- 
2.38.1

