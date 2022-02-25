Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74410EF
	for <mptcp@lists.linux.dev>; Fri, 25 Feb 2022 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645750388; x=1677286388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jppViAbtrq9fvgOH1K0JJZbz2wwEgWwtbwzSeFNMgyo=;
  b=TjVI30JpPBKSbvau4fnrb9A8vYKqMbeYsNeq4s7do1XR6GAa1sRJ6/tw
   pW7+2hYD4mwKe08Q0OeooIBVtQNFviJgoPO3vSX62t8dctDHmzq/4HZMl
   K5cEOFoZaRsBS6fESfBu959QdoN9wfoRZ+dd+DXdZrZm80JY4gH9kwg4C
   xLPAB8n444Bhgt2Z3jJoj8zkJ4EVJrN2bIoRwNy5p4HJMWwLFqLCrlSnh
   CNIlteVXE556HlHL3wsiuIoR2jOxxKBTlO2G4pc54Nx8CNyjXycDjLb7R
   64zeLXRbRwpxkfwKJ09TS1h8S32vMsAuJyEV+ambRRmSVPsJ77UBfisL4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252117837"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="252117837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:05 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="638050198"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:53:04 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	fw@strlen.de,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 1/3] mptcp: accurate SIOCOUTQ for fallback socket
Date: Thu, 24 Feb 2022 16:52:57 -0800
Message-Id: <20220225005259.318898-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
References: <20220225005259.318898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP SIOCOUTQ implementation is not very accurate in
case of fallback: it only measures the data in the MPTCP-level
write queue, but it does not take in account the subflow
write queue utilization. In case of fallback the first can be
empty, while the latter is not.

The above produces sporadic self-tests issues and can foul
legit user-space application.

Fix the issue additionally querying the subflow in case of fallback.

Fixes: 644807e3e462 ("mptcp: add SIOCINQ, OUTQ and OUTQNSD ioctls")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/260
Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f60f01b14fac..12bb28c5007e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3294,6 +3294,17 @@ static int mptcp_ioctl_outq(const struct mptcp_sock *msk, u64 v)
 		return 0;
 
 	delta = msk->write_seq - v;
+	if (__mptcp_check_fallback(msk) && msk->first) {
+		struct tcp_sock *tp = tcp_sk(msk->first);
+
+		/* the first subflow is disconnected after close - see
+		 * __mptcp_close_ssk(). tcp_disconnect() moves the write_seq
+		 * so ignore that status, too.
+		 */
+		if (!((1 << msk->first->sk_state) &
+		      (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_CLOSE)))
+			delta += READ_ONCE(tp->write_seq) - tp->snd_una;
+	}
 	if (delta > INT_MAX)
 		delta = INT_MAX;
 
-- 
2.35.1

