Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A733F4
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701269; x=1683237269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rAc1/rLJSR1p6poXeUKLegm8cyFurQp8xHNbpGX67OY=;
  b=ZRezqdKQoWLzK7YmIwupqF7UNC8z/em8NcuoFUOrxDfAeyX7nPfU8qnF
   IW66F0dkQR4b4mhHMUGLGDYFTZ4gTnvZ7JB9I982F0YYmJtc9+XFG9n1E
   s4MzGf15ObUSJGn/u9D47xVBmYiPcMHuLMaTUZlQlL7FS8KwAFe6I4jwx
   AiHjnBFlEk5Ioba/DkA4e25hxFnFBZzNfgG9iKOgZ3JUqLH4kom+F3u82
   WJLzvi8GrjmsOuqzt6PBMOB8cyCx3d36K7XK9PzPzIkQWb0CiUuR38LLm
   PjN1lxD971dj92GMo6BqPgnQ/gfxkIEY2l8DXBHQNn6SJ+EfuaVv3F8ZN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="268064541"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="268064541"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621000387"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.251.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:22 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/5] mptcp: add more offered MIBs counter
Date: Wed,  4 May 2022 14:54:08 -0700
Message-Id: <20220504215408.349318-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
References: <20220504215408.349318-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Track the exceptional handling of MPTCP-level offered window
with a few more counters for observability.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/mib.c     | 3 +++
 net/mptcp/mib.h     | 5 +++++
 net/mptcp/options.c | 6 +++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 6a6f8151375a..0dac2863c6e1 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -57,6 +57,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
 	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
+	SNMP_MIB_ITEM("RcvWndShared", MPTCP_MIB_RCVWNDSHARED),
+	SNMP_MIB_ITEM("RcvWndConflictUpdate", MPTCP_MIB_RCVWNDCONFLICTUPDATE),
+	SNMP_MIB_ITEM("RcvWndConflict", MPTCP_MIB_RCVWNDCONFLICT),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2411510bef66..2be3596374f4 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -50,6 +50,11 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
 	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
+	MPTCP_MIB_RCVWNDSHARED,		/* Subflow rcv wnd is overridden by msk's one */
+	MPTCP_MIB_RCVWNDCONFLICTUPDATE,	/* subflow rcv wnd is overridden by msk's one due to
+					 * conflict with another subflow while updating msk rcv wnd
+					 */
+	MPTCP_MIB_RCVWNDCONFLICT,	/* Conflict with while updating msk rcv wnd */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3e3156cfe813..ac3b7b8a02f6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1248,8 +1248,11 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 
 			if (rcv_wnd == rcv_wnd_old)
 				break;
-			if (before64(rcv_wnd_new, rcv_wnd))
+			if (before64(rcv_wnd_new, rcv_wnd)) {
+				MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICTUPDATE);
 				goto raise_win;
+			}
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 			rcv_wnd_old = rcv_wnd;
 		}
 		return;
@@ -1275,6 +1278,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		/* RFC1323 scaling applied */
 		new_win >>= tp->rx_opt.rcv_wscale;
 		th->window = htons(new_win);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
 }
 
-- 
2.36.0

