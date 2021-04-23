Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E871
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 01:11:14 +0000 (UTC)
IronPort-SDR: rDHOqT+Z/pumXmpPhyYyxzzWfP8y33UN0zUJ9qz2L2e/J/wvoEuekDn5fMcJCgrS8r2Wp66Z65
 zAwbh12bE+Uw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183129209"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183129209"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:11:12 -0700
IronPort-SDR: ggVEoO6rUkBQiHxSvUdv3F0la8T20phITXToqEA8Mk4hG/5IK1yjtFfWFWJgMsEpEg8Ial8AeL
 iI7T8U+zAFqg==
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="428187143"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.254.71.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:11:12 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net
Subject: [PATCH mptcp-next] Squash-to: mptcp: Retransmit DATA_FIN (again)
Date: Thu, 22 Apr 2021 18:11:08 -0700
Message-Id: <20210423011108.179263-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous testing happened to involve cases where data had been sent and
the retrans timer was already running. Packetdrill testing revealed that
the timer was not being started in cases where no data had been
transmitted, so __mptcp_retrans() was never called. This change starts
the timer when the original DATA_FIN is sent, if the timer is not
already running.

Packetdrill PR is forthcoming.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6cbddfc18158..aec8e77b18e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2497,6 +2497,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			mptcp_set_timeout(sk, ssk);
 			tcp_send_ack(ssk);
+			if (!mptcp_timer_pending(sk))
+				mptcp_reset_timer(sk);
 		}
 		break;
 	}
-- 
2.31.1

