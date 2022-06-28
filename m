Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE48371
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656378172; x=1687914172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRyJYOK7yo5gR8RosTvvsjBH18Xem2fgvLOcM3eLcR8=;
  b=DwE4f3/ip1oqG4LzW726GXD1R7pEBKB0KD/jytyKIXnlmannXbLiHZtE
   LJMtX87PHZ5PRnYvjk/51qzg8+mDm200yorCniVgpvEkU9SOcPzMeG5ZQ
   ucgQ7si6AGP51qj3vPDW53GjlGucwE8JITOTrme29InN4voaqXerY+Ewr
   IXclVijsGzUSLm+/xMBGOyraQSVSRfSfUGlFZd4rzn3y3WvPNUzLHAmfJ
   3Hijd6u0APgtwJaro4mB0gCserU7TJNVYUEqa+MSJrcOZ14Ghjy5+bEeV
   fg6fL8HSyHC25bgkwMD+NHj5NlynVfEUK8UMfKolSlytH15WWR4XihxsI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270347718"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270347718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692867387"
Received: from cgarner-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.0.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 5/9] mptcp: consistent map handling on failure
Date: Mon, 27 Jun 2022 18:02:39 -0700
Message-Id: <20220628010243.166605-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
References: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

When the MPTCP receive path reach a non fatal fall-back condition, e.g.
when the MPC sockets must fall-back to TCP, the existing code is a little
self-inconsistent: it reports that new data is available - return true -
but sets the MPC flag to the opposite value.

As the consequence read operations in some exceptional scenario may block
unexpectedly.

Address the issue setting the correct MPC read status. Additionally avoid
some code duplication in the fatal fall-back scenario.

Fixes: 9c81be0dbc89 ("mptcp: add MP_FAIL response support")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/subflow.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b34b96fb742f..03862103665d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1252,17 +1252,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			subflow->send_mp_fail = 1;
 
 			if (!READ_ONCE(msk->allow_infinite_fallback)) {
-				ssk->sk_err = EBADMSG;
-				tcp_set_state(ssk, TCP_CLOSE);
 				subflow->reset_transient = 0;
 				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-				tcp_send_active_reset(ssk, GFP_ATOMIC);
-				while ((skb = skb_peek(&ssk->sk_receive_queue)))
-					sk_eat_skb(ssk, skb);
-			} else {
-				mptcp_subflow_fail(msk, ssk);
+				goto reset;
 			}
-			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
+			mptcp_subflow_fail(msk, ssk);
+			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
 			return true;
 		}
 
@@ -1270,10 +1265,14 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
-			ssk->sk_err = EBADMSG;
-			tcp_set_state(ssk, TCP_CLOSE);
 			subflow->reset_transient = 0;
 			subflow->reset_reason = MPTCP_RST_EMPTCP;
+
+reset:
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			while ((skb = skb_peek(&ssk->sk_receive_queue)))
+				sk_eat_skb(ssk, skb);
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_NODATA);
 			return false;
-- 
2.37.0

