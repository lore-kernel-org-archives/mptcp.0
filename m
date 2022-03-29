Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729C20E6
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 02:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648520053; x=1680056053;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=kfzkYvxkvtrOkLLjy4C+eKMJJ5Jur2DgftgTUihqKsY=;
  b=CU8P/gSvWozSfHIOTDyW1/wEVXMUBCp8b6lXgGOR98jaXCJEtttoSfK+
   rTGTu+wl44jG6DrcPvubWqCpB4esr9uCkdLJ2w0N1WqGldPjU7XEzRW49
   Dg8HWtt6xPvXbHjw1Wd2ga5GVdXSUIOa85mfbdmYyiRFEkg/yUYhHC1Th
   0KtPrhrh8mqVdo/EWu9lmLzx075P2cRsRUoKrj09Oc4kjm4lNA0oC7kgi
   KCQG5iKWskz7nH3OROkahK8e/d/i6hutvCNn50RlYc0kTONYbBPpwa5JM
   +vWAY3K9Ndv4M68xj9ezJ69lC1zi2RyjL8BKIZ6JK52bTV8OetA5RfI46
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="345578747"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="345578747"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="564202554"
Received: from otc-tsn-4.jf.intel.com ([10.23.153.135])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:14:08 -0700
From: Kishen Maloor <kishen.maloor@intel.com>
To: kishen.maloor@intel.com,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v9 6/6] mptcp: expose server_side attribute in MPTCP netlink events
Date: Mon, 28 Mar 2022 22:14:01 -0400
Message-Id: <20220329021401.1196466-7-kishen.maloor@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329021401.1196466-1-kishen.maloor@intel.com>
References: <20220329021401.1196466-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change records the 'server_side' attribute of MPTCP_EVENT_CREATED
and MPTCP_EVENT_ESTABLISHED events to inform their recipient about the
Client/Server role of the running MPTCP application.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/246
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/pm_netlink.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 9690efedb5fa..e41ea01a94bb 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -188,6 +188,7 @@ enum mptcp_event_attr {
 	MPTCP_ATTR_IF_IDX,	/* s32 */
 	MPTCP_ATTR_RESET_REASON,/* u32 */
 	MPTCP_ATTR_RESET_FLAGS, /* u32 */
+	MPTCP_ATTR_SERVER_SIDE,	/* u8 */
 
 	__MPTCP_ATTR_AFTER_LAST
 };
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6b555b20fd6f..7c92af2ad900 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1978,6 +1978,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.31.1

