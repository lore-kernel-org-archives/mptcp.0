Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02133F3
	for <mptcp@lists.linux.dev>; Wed,  4 May 2022 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651701268; x=1683237268;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Keh/V0hKcsPVV4uZnaQ4ISYtNk/JzPjaop5gmEJiqy4=;
  b=QvsoqF6fNuouDUaPTlDnPEgoREf5oXiapGlpNEUsb569g9VSV52+Q7T+
   CKVJ4qgOIwqB+VfhQK6G66v/1TYTJFLaMYFMFgw67nEzPoKRF47khqtbS
   wt3hZY4xfBUpQz6wzFXW3MvsgwzeU2aBbA8tGvXfhjbv5lO9KUw8KdoE1
   jEo/gapZRwymhC09qHm6L594KhY3Fhry9OIgOHliCM3vy53Xe+m7wMwwP
   YkF5FMUnHYWaXt2iRvdXoMks+MqY+uFPlFVMCNWlPMr0DbovCTskWiJ7N
   yLDsWuyFDnVIOyZeGLLbbky+Ni2iSXyzl+FtOiwF7pQwmfL/IqIagO85+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="249892481"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="249892481"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="621000370"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.251.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 14:54:17 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/5] mptcp: add mib for xmit window sharing
Date: Wed,  4 May 2022 14:54:05 -0700
Message-Id: <20220504215408.349318-3-mathew.j.martineau@linux.intel.com>
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

Bump a counter for counter when snd_wnd is shared among subflow,
for observability's sake.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index d93a8c9996fd..6a6f8151375a 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -56,6 +56,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
+	SNMP_MIB_ITEM("SndWndShared", MPTCP_MIB_SNDWNDSHARED),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 529d07af9e14..2411510bef66 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -49,6 +49,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after being stale */
+	MPTCP_MIB_SNDWNDSHARED,		/* Subflow snd wnd is overridden by msk's one */
 	__MPTCP_MIB_MAX
 };
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 97a375eabd34..6710960b74f3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1153,8 +1153,10 @@ static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *s
 	mptcp_snd_wnd = window_end - data_seq;
 	avail_size = min_t(unsigned int, mptcp_snd_wnd, avail_size);
 
-	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd))
+	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd)) {
 		tcp_sk(ssk)->snd_wnd = min_t(u64, U32_MAX, mptcp_snd_wnd);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_SNDWNDSHARED);
+	}
 
 	return avail_size;
 }
-- 
2.36.0

