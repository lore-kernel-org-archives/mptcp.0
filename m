Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86777A
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664550; x=1682200550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1ZI/wWdgV4VW/clVksEhHQFe+EsRIy22X9gG8piZujc=;
  b=kxVU0nsN6ltSsDXZFS7FipCM8GDvo7qZ77Qjc1rgXOYu+nPojut0+XFL
   w8mwut9dRxN2uRviD6UUsaujCABBKmNYY9KhOKBS9XI+z7iCDTV/OgXuj
   M1zpgZSHAskRp3aLJbr2wbqF/SZ+8bt3k6tk2bv3nQ5VTaWPeVDafkiA6
   QAcZTvHVRPhpQsS7Cr2t6577YbTRTPTNB8zGPuUkWAPrAjFPfKZ00L/wM
   IYtvv9o+qAhKgENTvx4Vd8LjLgm3DLtN9intCcuLC/bnw4mRDrbmSiott
   UpqAdKlE/NCn9ZmIeZSpFObakgclmHulnnyp3TeYxBVkHoJtIbfT6ejYP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720726"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720726"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119255"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.99.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:48 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/8] mptcp: don't send RST for single subflow
Date: Fri, 22 Apr 2022 14:55:36 -0700
Message-Id: <20220422215543.545732-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
References: <20220422215543.545732-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

When a bad checksum is detected and a single subflow is in use, don't
send RST + MP_FAIL, send data_ack + MP_FAIL instead.

So invoke tcp_send_active_reset() only when mptcp_has_another_subflow()
is true.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index aba260f547da..f217926f6a9c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1206,14 +1206,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
 		if (mptcp_has_another_subflow(ssk)) {
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 		return true;
 	}
-- 
2.36.0

