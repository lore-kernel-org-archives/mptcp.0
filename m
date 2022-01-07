Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DB2C9D
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 00:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641514852; x=1673050852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCyq5RZUHo1umQP1x3X959pDNQKh7V3k2L2OZJIpa1w=;
  b=JAwRomtzhGt2es+0IA4h2NZ5QOc6dInRoEsoTNxUeeNLeUa7tou2MpVj
   hcXa3wz8552olofdR/XgScC9AsRMcIXRfTwDtOL/3q6JRE86KWbRPglM/
   Tzfp+dag7f4Py412+Q0o0wx55SHvfIAIKTznopGdh1w1bD8Uq70L6U3XI
   qoKimKfD1+vdtZYQEYtk6CBkUanbC2WlnVaw11ytCI326WgvGzW+zFlG9
   oDITarhmWcNzo/zSJ9Oi6tMHLnmCFe3O95/TqSodALSp3ekvL9GAF/jWG
   5+bHUTTqXQJP9as3CK0dChp6aMGlw4XkU/pGQSU6sG0QsgInNnry5Q/87
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329111031"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="329111031"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="618508504"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:20:35 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 05/13] mptcp: implement support for user-space disconnect
Date: Thu,  6 Jan 2022 16:20:18 -0800
Message-Id: <20220107002026.375427-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
References: <20220107002026.375427-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Handle explicitly AF_UNSPEC in mptcp_stream_connnect() to
allow user-space to disconnect established MPTCP connections

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 628cd60c9d0f..667e153e6e24 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3404,9 +3404,20 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	struct mptcp_sock *msk = mptcp_sk(sock->sk);
 	struct mptcp_subflow_context *subflow;
 	struct socket *ssock;
-	int err;
+	int err = -EINVAL;
 
 	lock_sock(sock->sk);
+	if (uaddr) {
+		if (addr_len < sizeof(uaddr->sa_family))
+			goto unlock;
+
+		if (uaddr->sa_family == AF_UNSPEC) {
+			err = mptcp_disconnect(sock->sk, flags);
+			sock->state = err ? SS_DISCONNECTING : SS_UNCONNECTED;
+			goto unlock;
+		}
+	}
+
 	if (sock->state != SS_UNCONNECTED && msk->subflow) {
 		/* pending connection or invalid state, let existing subflow
 		 * cope with that
@@ -3416,10 +3427,8 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	}
 
 	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
+	if (!ssock)
 		goto unlock;
-	}
 
 	mptcp_token_destroy(msk);
 	inet_sk_state_store(sock->sk, TCP_SYN_SENT);
-- 
2.34.1

