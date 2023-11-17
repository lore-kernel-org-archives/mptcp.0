Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A81B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jL2XdgTM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5T99GR30dEHg5lNGeHMhp6JsY8Dh6kVTTJ99NeoHw8ZFA9P89pPq4De4lmxvv/icnqW9DyhAm/XX6YP8LoQrVMhFlVigXM4DADDmV2p3Nz4hF0HyxTmtViNjti6GWJgZ9AW9RXXpUWSPuOCOlIcQXNNMCC0LH7SODdLRvfMXc2VLxxkpOXnGqR1kS/gTNsXE9j3B+n240c0/iXhRr0q0oBoDPWmgTIx+1c9VDInpUrK5WTENWFvchPAi1oZqx6NDAabc4SXyDzHtC7PQ9RH8+2g3MdinHFsi1X3f16oIjgWqLH1puLRNdGZ4TqAuA1vovIaYcybZ81WiIE/NRLfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mV8hAcIp2hPILLEe+OnpQWRH80r74XwvgKxVdqXO/00=;
 b=IkFqfikVXtqfZe72xUkQjGFE+qD5vUCjfqS5OrdL+jeFjxnkGhI29i9DCh+fThRC6jFDK+PFoqAO19zcJcK5sZHLJY5hi6Bn+iFW81Cxw6ceVxd8l91L6f6Q0HmGXYEtEiFG2mi4a3sf0EyR0YaEKeApv0iv4QK2OyqKFVmoH3bEFF7aAq23a9wokyNNlYsLzo0NGWH3qFfXLKoVLItouRG4oNOzJ68OFAa5LGhq6RFSA67v0wmwlOeXW39VnHH3SOWGe44Dy5Fi6ODPYTiSs+RSnIIWhFs5yvbhxMwooRKGqwH+UmkepcuT3SmB6j1zpNcNK75ux4SxvNb9iuN80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mV8hAcIp2hPILLEe+OnpQWRH80r74XwvgKxVdqXO/00=;
 b=jL2XdgTMZP97U9rArpQBfm0K55oN969MBF5OnYwMSpiAe0CT29Pn1B4q9Uq52i0tirg0wyIhAWVRe1EKHf8aJZBWNXLsOJlj2AkpRhfFEvawottjPbtHfdJ/HGK6TSTXCe6GqpE7U7stTo6YAQTJKtn/qvRinLYx4a7wsfmSab4gBRHsX4ah5wnpwIOnOxuZDcCz/Eo56NVWWMDmai5bNbSk/0rFxa+NCpFK61VEwAnQ/LlOYXsHIc2+ZdyIIjHU1DUHGbKU9KwqsDn+9YfQASNZWEr+AZQX+3rC3h+f1vWFCnNYnFjYC8V7dLDi75Oly3ZIVOWjC/ScsBmMa1Tb6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 25/26] mptcp: add userspace pm addr entry refcount
Date: Fri, 17 Nov 2023 16:56:18 +0800
Message-Id: <a9d98287b0ea571d70dc7b1c35586d90ce66537a.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0057.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: 751602b4-4864-485a-f2cd-08dbe74b6f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	brDodIP5sVBc0gSET37ujebt1hipPq9QVNCpBIB2A2QpT7aSTFk3UMHqYnLUs1xBfEmiJT91NoQBQ0pPv7pJ6MpD/+COgv9IQ/X5R2CWvX7GrM3BO19iZL7k1D4rPQFE8xw01vlM8fgdgLNY5M3mrUd+YYsrPkpk3uA1kXdJA9xtmNt1sTzykfAjdG1aJKiz+qHrrxdoWLX3y7E1wfzIUPGs2swZjNwJPJRv9l0bQ5C1f0x7QN+II1uyZczo1nTQd22SlYE7k+MXyXoiRillgQAhRgX/ggckxBj9szabEMzh+eVYgbBXbwsPPkfvAk56M6MZeOw21kU9VjhugiCDBBArjWTYGpFGf6JKvj/svsMZRKBele/VK31+mxgU645GE+UmwMZNR4bXdos9Ea9WMsxlCo8t1o47NGvq2uexVzw9khToU/8aAyR8akuynti8eE8xS7spY7R4s3cnyd60QSiGZV3SIhIegyU+Y51z8r7hnYMJz+TUWhCBoRQhA5r+6ntWlUg9tRe/yCz7qHaPPC/pUY+6v2A/F+7GfMN3B8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(107886003)(66476007)(6506007)(6666004)(6486002)(966005)(2616005)(6512007)(4326008)(8936002)(44832011)(5660300002)(8676002)(2906002)(26005)(83380400001)(41300700001)(316002)(478600001)(6916009)(66946007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F8POkwSn2M+EwDtBovX1vZzVzzjPQEh8LfnJ91BhnblnY9YV5HoVxbuD1W14?=
 =?us-ascii?Q?bRFbUDY1bppWkedcztN6bqQ5pSIir3mNmL4qPnNOorp1siV7X91kv3fDwvwJ?=
 =?us-ascii?Q?PDUpG/acrlR2V69mT7k0gmhFg2ujMfgcrrR+MgI+LxSVVx6KexLjrjSccLOO?=
 =?us-ascii?Q?QCdATTRlk54SyfVDXYqCF6blzr4KzuiWWZDVkmcud3kBpItMWGoZE36fiMhH?=
 =?us-ascii?Q?Y8wLOw/pReO3rAmz30pjMTr0sL2y/lftHoO/cHSby43SZ4i4H7H7VzHRK/nz?=
 =?us-ascii?Q?ncZ6FnPogWouRt1cuTnaonwbjJJ2Sa+seYOO8QTOt8iKm4Nw7+Oadr9aO/vC?=
 =?us-ascii?Q?6aLmrkYu9OT19zsj2fYaqO/rQpnveSbmwd1fZ3kBqXMfylsyKWRQc/0lnoFg?=
 =?us-ascii?Q?sXc9KDZv6pZW/P2WE8yiOT73vumwV5sYrrdvZFa546F4jLprS2YlQrUi0o5R?=
 =?us-ascii?Q?vgNptcWjpgV7WCbiKo8UdAj9W/iFPcLgNjrM0Czhql7MAkqkidtB+/n5IdSc?=
 =?us-ascii?Q?hc6fIyGygIXwc7o7bW8rVdRrZxeV1gVkBDN+u7qHKD+8shnJKSaU531lNIE7?=
 =?us-ascii?Q?yvbQGgIgu/YJh+JF35uvWaPt+nf1TBL79DUmCLD52uDUonHBZSxuo6uniDO0?=
 =?us-ascii?Q?SuBKHcQOCvvl/EaEYh2lC08nfynEhX8z2J01o2RTMjXdg64M3k6kHtdfPGA6?=
 =?us-ascii?Q?UG6ZsCOQM3bowc7HywI1lDfqUUTbxWTa1xK67N1DMsRAJjrgo0WN23MykpfA?=
 =?us-ascii?Q?LIb8AWXzVi3SWSq4ClFcHnfckYBLV4KFBJOzKXDq0zdIfFk/h8pCKo3OiyZ0?=
 =?us-ascii?Q?jY4SgqsnhcMBmludUV1P8ZDxOF32ARfRx0ssw/7gC0t0vMyADnpkMtY7Tli/?=
 =?us-ascii?Q?Fnqki+hf4nXd7l9wyWT3pY9FQTiCE+2jDhraxCIQzXL0NTleXstwRGQzoDh3?=
 =?us-ascii?Q?Q7+iNqtF2Yw7L4wsLXGuF404zTh4U9KGafFfZpdwAptLf1BfJRoRBD7lSB4L?=
 =?us-ascii?Q?wlIFOrYGYgGvRLnwwmOVhxsgK9/YrwdxX2Eo1YlcY/6VUgb+KnmezsX7+kQt?=
 =?us-ascii?Q?zRfEqXZHW0IrjsW89LHdFBCoBYmm9mbx1HGWbKD+pJRmgtPiy/Yn5lL89fq3?=
 =?us-ascii?Q?ub8JIf7MxKrrJ5xVnpLe9ssbbvlBlYrdOKqczT3Gk0KHMFOI/LI/XYJpzyYC?=
 =?us-ascii?Q?ssFHdgObhE7VW/sMRgQsXgnWnRnerNmt1JaYhXPoxrItB7ZBt9AkFZMZuLQW?=
 =?us-ascii?Q?WO6kr285jK/8z2r01N8SV2EjfTlLprdVFfoi3wSO7ZjvoNSbtcu9KQCeInxl?=
 =?us-ascii?Q?Xk3TJgD1vSrsvkOcHTQsWCLHq0G5Md0w3gpZoj/C/t2bD3bE/VtK019k7APJ?=
 =?us-ascii?Q?hQIw60MuqbI2cPJuKFPTsgybmasvuO7fkuI6vBFHEOLTr5/KOL9XnVaFc9zj?=
 =?us-ascii?Q?leLvK5tBp9WM0ZSlOUmTK82QGpbjssRBaiM9JZIbWe5FL0st3LYbYzfhxX8g?=
 =?us-ascii?Q?gGELyFCAJok9QgZe6m3D+fjc9jfpvFWK44+nOH59WaFyh8LwltOfzvhfMUT3?=
 =?us-ascii?Q?KgZ20Txk8HGHiXDDaKM7ZZY6gBVSJPrhe++E1BMr5MO8dkd8t6USEMxHdKkl?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751602b4-4864-485a-f2cd-08dbe74b6f23
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:59.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhfSx1s/+jJPgSlRB5BVTa24e2M7cXun0XNCILIvYfV76hn10ycU5uRCpn21mlYrFvN2J7Kzib74MML67ZgdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

This patch adds the refcount of addree entry in userspace PM. Add a new
counter 'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter when an address is announced or a subflow is created
in mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(). And
decrease it when an address is removed or a subflow is closed in
mptcp_pm_nl_remove_doit() and mptcp_userspace_pm_delete_local_addr(). If
the counter reaches to 1, free this entry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8879792ffa7a..ef1babcdf651 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -84,6 +84,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -109,12 +110,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -215,6 +215,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -320,8 +325,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -407,10 +414,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace pm uninitialized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 02ae42135072..e2b71fc62603 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

