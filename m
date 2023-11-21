Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E93C081
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POmMDYQP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRAMSvoyDygIpr0FjsXOplCTCfEXrR7qmkVALNcmg2frHpE2IcSctTCl3tlp6Gepy3K0eW5M3o9zwofbp1NiwcZS2nQBz4J4/bknZDBnkSWureopwp0+sxbjw2W4YeA7+SwPhrM3P1eAzKnspYGEVeaBiDJ9/O6FKYjyntNMF1v43hlxFmqUZ3OQuS+wjbmOMVKpeVwy64iNOKdZlK9hFEIllvqftvqwVE9NbsbPzqqU6XYrIoowNRAbZ6m6VfyarPlCoddLDftxnbvM3fafdyh4UJLqmq4KtSu3Z5A7kfDclREkLg76EDRqcDkVzK6hGwU11Sdc49DxhQK9DZDR+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6MGksTFx+t4yzf6kvysgft7dLwKH1cppACIWDAADlc=;
 b=ZdBIcrdH/AdIe/vqhpeTj4My6Q9qMJ8z7UekfLu6owfz1paqVM0woTeZPnhZnBGORFVBYkvtA8WECLjYOr99l1LP5wUtSQQssN/kzLFv2Ds5tkSl5BB81KO8sAZJYEoJKIkgpGz+fxyestgpsdaFBWjYj8vVdT2WktcHn3hLy8N5SMegAchM9JuSuTr77zzaNioYMNiZ77LUy48AnIblVIPFfh0L61bDVAzQciv+0ib8jxniUxHvMORf33bPnwh/Zc0P2qjIWvFKsuSzvLkW+YTX8dnBYNsH8+mGk96tyUhfwu3gCc64AL4JstC3J7dcY4EBuvaCQD71NlOssu/hUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6MGksTFx+t4yzf6kvysgft7dLwKH1cppACIWDAADlc=;
 b=POmMDYQPzgRfaoyyA1e7LyTie0K8Y4MR8hfGqupI9I7JNmygCbStSi7nozk/e4TRH4ZPjTu3DbFjH9KeFyQEnmyrqOe+ADxP03rTzu4r23cOHD4P+UoiB6jHmuriv01T/yC/cSlYm1hcnCPKg+HwJliu/VRPQhXePm+mx36N4Mru1aE/SRudT+pdwZR/zq5kP+3HAwLRvsko92HFErvb8fuBTj6wt3ye125D8qdweqU2P4KHbqCOl7rkfaU6p6ULhTue0i6WXIlGUvTOp5i+PiewLJSH13S8G3xODTGmLfCs7Sn7xlp0B3Zgpu60ZZlQVwgrTy1nG2/lSOyoTh30Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:56:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:56:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 25/28] mptcp: drop addr_match and id_match
Date: Tue, 21 Nov 2023 17:52:48 +0800
Message-Id: <c09b7dfc84f40e68f672d56a7bf188d789288c7d.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 752f73ef-1105-434f-ab70-08dbea781825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qkC6LUxLny079JCesZhLi7cP2c8Js2oiWmcBJGYyh2STLM4O1r4QBP6eeFQAE6FqHlLzfytvTFh4vHkebmidBAAj096FFKIM3YUHRlJ9Byshafp98oosLXMZX1kurnXJSIOPll4zo8i1mfFCtUe9w+Fv3tckv4WAd1GKBQAQGDE8JG2PocfnpBfJLE4QKLJIctYPvG0vbbKkmlNQFfaqdxOMnL3Fyv7x8RjfIDcPccRwSmJJqcLsKpqxn1oe5xM7U0BKr5Brwe73NnPi0OyGcJXDMtYD4MqOZL951as0rCM5KFHWbUuvzJ18tQaPIeYGOza0UcpMUhC/ghWCFBTj8zft2kMg8BS2odwRhXbA9ny85Xo43P0xJlzV59jaPUhxFg9kt1RmAF3H8mMKjaaPWWH42jwpnxDLxkh+AAHmBr0OL3Ofcnz4lgHmqwaDbXLcAfzeGk7pGkn7a33h5BRvATBDH1CaBglPkOcZFkHzZ4/ifam8qasf3Nsr23ZO3x5gRUOSnwxNFsiJC54EmNOeDCcY0AvAcNsF41DU0Bj73Cz5ByB3ocMSPw+Dwt38fZXm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ndt7KERMciV8uE5vv0tOfae8771lyMnZqE7n3GWJV6FCkny05Hq99XHh8+Ds?=
 =?us-ascii?Q?FcnVUMURMpSKcUZVTrwqcfnSuabj5g3+JO+U+HbSKeN/9/p3X+DtvkzOooPd?=
 =?us-ascii?Q?imRRz1qQ9y6AJmLCEqX/dNActtiGneBKV0pzYJHgO0oPyabNKqA84CMrvWXj?=
 =?us-ascii?Q?2HfGq5qUWeKKRl+pC5ClVt1DbNEJJuOca4a2TKjQWSlS/4FmG+JWEQ9jrgpm?=
 =?us-ascii?Q?v+JvbKEq+v4TbMQpcB2cPw++qFJCSycH9iBHPH3gt+9f7L8zed7OKwUaBts3?=
 =?us-ascii?Q?/LxTvzjzU9J7Om6nKXckZdrtrIXzXdLEFddeJIZBxw0qbbAWdfgwAx2qNuvn?=
 =?us-ascii?Q?MfEdiKY6piX/qtL+2dD0FGmTx64VlFCMbhJW6qmG1UgCisA4MMcJOrjSMKt5?=
 =?us-ascii?Q?6goS3Di0CsWRMA6Bmf12qRTWn2BskS/wksyNk6pp55SQrZVKPP38advk7fj1?=
 =?us-ascii?Q?vr4kza4NAtfgz36z6YxSRitxqWUSyE4nuT1EMAsbD3lgNTKeK1FsQugE7XDr?=
 =?us-ascii?Q?rgmoRu3PPi6Fmgod0Ev9qIoel6KkaeIxe4dU/yjEwZ5FcUDB2FfqwyqzsuYj?=
 =?us-ascii?Q?KhOaxosYejm3ieAE8ojpOaiCAqTTCMOejcCGLL970sG+6zoGexZitxzFGqRF?=
 =?us-ascii?Q?qE7oJu3uiwJ6xKKtOVbq5I6C1LNUay8w9LkRMkO0toTL6iThA4HYE0s9dJKG?=
 =?us-ascii?Q?u7X6Izpso8ECps11K7cK81UXltRSjPzCXN1nmO0ov8cDtay/XaYrcRRtnUIO?=
 =?us-ascii?Q?nepsO/Pd6xDJw3IVsesuyUbRx+kQn+WgNi96z34cEy+du/XtRZPti3d7aRdw?=
 =?us-ascii?Q?rdDTJ3UdTTEXeAalkg5ky23k8kE8Z4kgyhW9H8F9J1fKW27bVOw5/yMiL0iP?=
 =?us-ascii?Q?2ZXQc8jjRXoLdmAeXvOUa2VYXqvf/BLjrKGWmSrfT+07uALsjyOwm833jsXW?=
 =?us-ascii?Q?6pMLxbdDFFFgwFxVdS8BKhY29OWNn9hDSmhTm3TTwJTPVdwPFUSkIrYDDw78?=
 =?us-ascii?Q?D2zg/nOJjkJbzly3bC6zvtDr+c5skZBw3XEXBV3xbDYnSupTf4OAeRPuogh4?=
 =?us-ascii?Q?BplYgzLooV7FA/wSbjIUyBOmsbBtabpyPslYMXZUSZ9f/L9H3yR3j9dBCkvS?=
 =?us-ascii?Q?m40pQWcVK4lyTaiIApkqGem+eET48XwXwNNoYl1GbbTakwPMXL048rd1ZXMo?=
 =?us-ascii?Q?gUtA5GjCItANV4JyPde750PWhYfurbw/34e4oblbud89HDa7B/3UxGhXLj9c?=
 =?us-ascii?Q?DukfFrPmFNUXVv3A3CnB0CqRFS62VWSlQuZYpJVOW3F7Xs4yrYPcddwIn+69?=
 =?us-ascii?Q?N3IZPfvIQ4Zhfebw3hi2j3VjawbFQ3DrRsR0tNhhhm9J/XKvXwuiIzpFqOC2?=
 =?us-ascii?Q?BTcjtVUtHcuHQuIPor2L5mtNeOdA1dnSAk33F8BzcErIutUS8Bs/4mkEU/VT?=
 =?us-ascii?Q?u0x6GN3vlBfcJv7HmZD95CANFZ7xZeMXrBf+WytPuL4PWh+LjCK3PehoI6Cw?=
 =?us-ascii?Q?e8vVD0sr1Nd7VZQx5140VLXIWARkRktjyXZr/AVtlGvbpjF/U1IgRoHSiq6+?=
 =?us-ascii?Q?2jEDS1gC/7PI0bwD0LL9YiJNLUeWBjZ7G+kYgMBvgQq9F648yyi1dvr/W7Zz?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 752f73ef-1105-434f-ab70-08dbea781825
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:56:12.8188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wXYtcwYeFzYfXhxta21E5UqbJ6EfHf69eUOcPKzV2jO6jrbM6yy8jJammceBanl51hxLvw2trvhtfe07JTBTDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8c7553d7ee65..a608166af121 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -61,26 +61,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0 && !set_id)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -99,10 +86,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0 && !set_id)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

