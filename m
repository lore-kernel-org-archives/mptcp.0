Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046884356
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646685890; x=1678221890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/eP9FA3TlK1JhqXDW8j+WHnR3670oSgdS19K3yRsgGA=;
  b=Nc3SKl4qPl2uyX4+VocbLD43/cXKURaaHiiOoUmU5T0zpbU79Jlyjzmd
   qnZF8+0Z/PAlqtctnA59OfkGwg1CynXRau5joa3BjzVMAo41JI5m1+5qP
   BCobAEAB3huJoaG8iN9nVJgR8rIyx/Q3iHipO17Blsnoibmf8mXTSH24H
   G6Ex2rZZRsCM8stobUOoAf/fzVu3i/1pPa1K3MX+AXsJsxcPiBVaKRAlE
   7g3YMiFq0BRWT6DaYirpM+g+HWy0WJ9kRdbvqUFkV3Vc2LYo6Q3CqqaHx
   fV7Hr4PAPi9Uw1pAMbyo46bk16EpDtV5YkNrYvNhOdw8BNDb1SFUuY3n4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="317731795"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="317731795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553320496"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.192.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:44:45 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 9/9] mptcp: add fullmesh flag check for adding address
Date: Mon,  7 Mar 2022 12:44:39 -0800
Message-Id: <20220307204439.65164-10-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
References: <20220307204439.65164-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

The fullmesh flag mustn't be used with the signal flag when adding an
address. This patch added the necessary flags check for this case.

Fixes: 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index e090810bb35d..800515fe5e1d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1264,6 +1264,12 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	if (addr.flags & MPTCP_PM_ADDR_FLAG_SIGNAL &&
+	    addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+		GENL_SET_ERR_MSG(info, "flags mustn't have both signal and fullmesh");
+		return -EINVAL;
+	}
+
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_IMPLICIT) {
 		GENL_SET_ERR_MSG(info, "can't create IMPLICIT endpoint");
 		return -EINVAL;
-- 
2.35.1

