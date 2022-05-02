Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BF13214
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 20:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651524768; x=1683060768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uCmDuCffsSpAMH/ALNDVwMW6WhS/bEFusqTpuRquYcM=;
  b=Zn6zbpueiyd9hQwKc7IcWAft6jMmBrM8mc44NAO93y7dITrj0rf2tJUM
   oUEdhw81MRXf7UYzkgmlNCrEP+c5bG32QWsibIabyfl7ujt5/BaP5pMjt
   +bNSn+/yOAfnP+10mLnxCT0//YE6ruGtAVcRR0dNDkLPB4dn6JlVthxdH
   B8/L+oVRUdLj5zd581g5tLQ3rOUZ1NvJhOsgIkidvovL/e5FjD2VYj4+v
   GFlHU//iYp28oem0q7vIF+EAAX+vOuXw5i09pt9JWNwvIGY1hK4xcfbtg
   ysPJNbNbIYphsx8ahGh1ufW8fMQ5+Xd8tejL7Gf23XjEO8aDdS+KAtp/3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247875192"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="247875192"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="733619588"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.141.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 13:52:44 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Kishen Maloor <kishen.maloor@intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/7] mptcp: expose server_side attribute in MPTCP netlink events
Date: Mon,  2 May 2022 13:52:36 -0700
Message-Id: <20220502205237.129297-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
References: <20220502205237.129297-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kishen Maloor <kishen.maloor@intel.com>

This change records the 'server_side' attribute of MPTCP_EVENT_CREATED
and MPTCP_EVENT_ESTABLISHED events to inform their recipient about the
Client/Server role of the running MPTCP application.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/246
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
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
index eeaa96bcae6c..a4430c576ce9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1985,6 +1985,9 @@ static int mptcp_event_created(struct sk_buff *skb,
 	if (err)
 		return err;
 
+	if (nla_put_u8(skb, MPTCP_ATTR_SERVER_SIDE, READ_ONCE(msk->pm.server_side)))
+		return -EMSGSIZE;
+
 	return mptcp_event_add_subflow(skb, ssk);
 }
 
-- 
2.36.0

