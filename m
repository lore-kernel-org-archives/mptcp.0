Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71A2F59
	for <mptcp@lists.linux.dev>; Fri, 22 Apr 2022 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664554; x=1682200554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IvAlB4kUGkNkLRy+VtIdYp9rNluXsVFF0Id0C7yAEHk=;
  b=h3Uf913ajbO3jAD7OgVlb3T++nNAnY0b80NWbbir3b+9NqkFotAF0yUO
   udo1Q+T+1kcOO0cljVxSo9NOYf4coNCCy1AYGGYzfZzTZRTBbXh2Fg0tE
   2wuDlKJIIAJngYAvppH/nif38WQ8aqg55u0+cqWHof0PCKEM83d0l/67C
   4hhR93f9133P5vSeR8SZEU9hpDj9El6/dx2OQK3Iop+E2gS5LeuGSJJd6
   73c2yRQdidQnQ5qJsB2O2vgnMDHCwUNEpOpsuuk0H38JvxF/grreR34Tl
   sCLf0Yqun5cKxie+z/tsyf71xiGrq/p5Sg3ImEqNcWuAOcO+vtugI1ynl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="244720734"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="244720734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="578119266"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.99.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:55:49 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 7/8] mptcp: dump infinite_map field in mptcp_dump_mpext
Date: Fri, 22 Apr 2022 14:55:42 -0700
Message-Id: <20220422215543.545732-8-mathew.j.martineau@linux.intel.com>
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

In trace event class mptcp_dump_mpext, dump the newly added infinite_map
field of struct mptcp_dump_mpext too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/trace/events/mptcp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index f8e28e686c65..563e48617374 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -84,6 +84,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__field(u8, reset_transient)
 		__field(u8, reset_reason)
 		__field(u8, csum_reqd)
+		__field(u8, infinite_map)
 	),
 
 	TP_fast_assign(
@@ -102,9 +103,10 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		__entry->reset_transient = mpext->reset_transient;
 		__entry->reset_reason = mpext->reset_reason;
 		__entry->csum_reqd = mpext->csum_reqd;
+		__entry->infinite_map = mpext->infinite_map;
 	),
 
-	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%x use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u",
+	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%x use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u infinite_map=%u",
 		  __entry->data_ack, __entry->data_seq,
 		  __entry->subflow_seq, __entry->data_len,
 		  __entry->csum, __entry->use_map,
@@ -112,7 +114,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
 		  __entry->use_ack, __entry->ack64,
 		  __entry->mpc_map, __entry->frozen,
 		  __entry->reset_transient, __entry->reset_reason,
-		  __entry->csum_reqd)
+		  __entry->csum_reqd, __entry->infinite_map)
 );
 
 DEFINE_EVENT(mptcp_dump_mpext, mptcp_sendmsg_frag,
-- 
2.36.0

