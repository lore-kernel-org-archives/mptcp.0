Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D932CA4
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641506806; x=1673042806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rdHOfvTm/dAwcmwRlIfBvl2VIjEbWqaZR3GfUuomywo=;
  b=njikCixZ2Rz6zwmOUpZTeZUwsNTbBvaZlJA7zp5JAfV//KfOxessyMq5
   iQq0H2kWQ0OLTmpTFScUr+Wg/77Gkc16S7Yr9nhh9ou9DXamuS2PW+bhs
   xwvKfWeXw5DR4VGzsISVyra+WfqFU3CnLT50Q3cSXM9K278nja/Ll9wSx
   R36sLB/eTnSdo8GD/xa4ptBOB2t/nv5mZeOP80lYcxhfmYMbuG0e6+HFC
   q57bpbLRZVXxcANB2KEAe2OWEDW/RhB+x3ZGZuFlAccT8SsresnzM5onX
   9cnDDZ1lY321Ahls4WH1/lznqQI1LgVkNK+hM7CkHdyO3I6Jqy3DvO897
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="240303710"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="240303710"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:06:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="618479818"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.94.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:06:43 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 2/3] mptcp: fix a DSS option writing error
Date: Thu,  6 Jan 2022 14:06:37 -0800
Message-Id: <20220106220638.305287-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220106220638.305287-1-mathew.j.martineau@linux.intel.com>
References: <20220106220638.305287-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

'ptr += 1;' was omitted in the original code.

If the DSS is the last option -- which is what we have most of the
time -- that's not an issue. But it is if we need to send something else
after like a RM_ADDR or an MP_PRIO.

Fixes: 1bff1e43a30e ("mptcp: optimize out option generation")
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 96c6efdd48bc..6661b1d6520f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1319,6 +1319,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
+			ptr += 1;
 		}
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
-- 
2.34.1

