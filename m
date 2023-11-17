Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2044.outbound.protection.outlook.com [40.107.247.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559CD28E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a283FDo2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7mPOToK9rtkr/GWGKa8ng6NruRrfUEz/Mf2AF91u66Z9BGtyg3zyS1xFKaZB2bH12pex+ToDg3l+KpuQVMD26lo8Q1YAXpILlJMF9mRNDPayI+zkh7C5W9Kjy8DAvXZ/ajiCPi4nZTkMVQ3DSGsnsi+Fr/Rgql3lC6AxwhVOUZMTP+0SpEf+P/5jPcDL7EW3zMR4WVl2mSKaBtGtyvob7R0tOIICdMnLAmtLjkwMxv1/dCn8xn3t5WmxfAWi13WhETiXoRxvMn0kEcN2DgRl9SS3Mn8tHRhNVUTIcXMr3bq+KCLHkfN/ax+OfZB9Prx0yZtXxLdvzAcBMgrep//HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8fBOvxUcdB6/Qw4FOyGEcT2F+mSte+m/WYOXoZKPpA=;
 b=HlpNIYufhjGeVIJgKnlU3BkDFMuvczUve41X6p3IoHQRIzXy5Dz2EWV5B7ad2opdgOj0qrL2AoUeKs/KcnUmSsERXytfIHV7ZnYg85F5CbyfanVX78VgAgFu1QLZFOEQq1pyAK+f+1ai1dtBT/rRi5eosb+E+97jvVbXEfxCPYGdauNDstmii33LC6HAMuRTD5HIkrC+K64yOzxyn6dsn3P+ZjBSnvefrTGljQpaXXfj23T0p8Pc9nSzk5t5Pdi4oEeZrC+dnueJxTVNuncQUdNOYaWe4ThlVJ6lnfOgftfMfROPGVKSrP1dY4Q9nZ274EImKawobaZAohx+3ALNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8fBOvxUcdB6/Qw4FOyGEcT2F+mSte+m/WYOXoZKPpA=;
 b=a283FDo2KwXk6PUkThQSmMBCtr7tVE12QhkYAPpXn8eC310zYrxPvMsAHoXD3OeOy99KB59VvpXqRNVY21lk8NJ/tHtHOxH1unAbIKCSDHpFRfwebRm45x/3FpQrwFRdXI774RNknCuoL9G33WPdvElhEbC95nLgd3HUK8atOmkopcDRZWS5ueboN1zYLY/vUGLfwbhw439pupceSLNgs2Ibn3jUxRUVTstbItJT4+BkgmNdDx02Me9QDNv3JojNSIysOQD5w3BKLE/lQ6Nx8nQWkXWQeqNBhYYk5WcpqoBOx+mZtlVPhDks+jlyua6bcbNzxJF1PjcwBAE5f7/fGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10047.eurprd04.prod.outlook.com (2603:10a6:150:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 22/26] mptcp: add userspace_pm_get_entry helper
Date: Fri, 17 Nov 2023 16:56:15 +0800
Message-Id: <5d13a7fe95db3dd7d92233288bf3715890855180.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0f6fd0-6305-4c18-4b57-08dbe74b61a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CrFGOTXKN8pK/D22mZSI21GCqCz6a8L0Lp5iqAcqYJNaQPaMbxZYCSTZcepobvLtVcKQEmOs+Eb+IpAyLwDr8/HULbHEjE/bGi/Sh2c7X6z73jSgG7ADvI08ugCb31HyrnmvRys1pIc3I77C5Vfqviy2+PWgQMCQLEPtOsGA7VDnB64Ej5t2JnJhEC3c5vazcJaoVbayke84B0mdcFpIIP4QcPCIPmvHI8I2C0N/x1sKK3yK5lMp/lxvQuARsKmo+ugwvpOfS4OvUoi1nL8hMTuerPS/OEmE3guigniALyechc6jlAjkrkcoI6SZYBLilmGdieHbx0johmG08uCTm7BrZ5WBf3lVi+lm7sH+nLGuFPa/LkWJEJ4OQ9vKZsbbhNN9bexreqbYbIPNmTr3WtGLGAeYHcxDpO/vu1z9Z0ikJCUxadXt7SCyfnrXiivEAV8NJnr3C6H6EQKiOGy5B9E9+sX2A7bb4RR6JkHtN+emUciLwCQSrbniSrCn7aZkRW2pIh1ylPLKzSZjuWhzKsKPMvsBdQ3sK8tWbXZXWBeCbJlpKUy5xdk07jrsLI64
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(107886003)(66476007)(6506007)(6666004)(6486002)(2616005)(6512007)(4326008)(8936002)(44832011)(5660300002)(8676002)(2906002)(26005)(83380400001)(41300700001)(316002)(478600001)(6916009)(66946007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Zckq3qiyW6q7WAcAILI9FhGyHBM0VVGVNcZWrm0DvpMb4aDiYOtj0UG6ma+?=
 =?us-ascii?Q?Ruj4JQuD/CIFl3f79BHzhB1uSqqqP26MFvAD3Ay1iDMbjC59wPXh6FY1JyaS?=
 =?us-ascii?Q?ktLui2D2vggFFjUInp2b1TKWtlO4l0YkQtCVfsiyRGxQcMIwOhJJLRfT/I1+?=
 =?us-ascii?Q?btEkuu9o7ikVar8aRwTLXA0FewkeMthd8A2LQo232dvjH+FpqtBvRFIOQpSR?=
 =?us-ascii?Q?UxFGrxlK2rsxV0HHmKRE7AeFBNBMJr1SdayoPcEHBHAmRXE08Bkth99rZtS7?=
 =?us-ascii?Q?FvAwDDp04AoOVwbITPAuHmrcFt3jPAvPdNyhoXV2cwfcnFd56Vy9g2RpTPvW?=
 =?us-ascii?Q?pnJcoRtXGrcsESdC7IZZ7NlPWtccXfGooFquHglk8fKjNi0vAKvbljgryy9N?=
 =?us-ascii?Q?e6ZkydETLp2Ul7Bhh/lCQv7ccbXRZLfZN4Y0xT7qv0E6/kQ/WdlLubkSyHjh?=
 =?us-ascii?Q?typ/XGw69iuv6BIAU3Sa8oMvbChiAPB23bFaxn1hYtoU6+NreVusBugkPf5i?=
 =?us-ascii?Q?tpQbSIrkTDSRo8/rqOYRkvKtv3X6VXMe8V4gsXx1gg3GJbtleOMXQVfZpnHb?=
 =?us-ascii?Q?oQ/0JfOBPhhnlrblbgxRTOpm0+oJ4kIMMHgXLo+PtHSjggj1U8RI5qP7B8YH?=
 =?us-ascii?Q?QoRtvEnMzjb8qIojtCnOxvOa8dIryWrDKdE6HLpd13M6rlemcjF00uX3XUe6?=
 =?us-ascii?Q?3VM11RQk2cRL1KOzcQEvAdb7twDp0oKzClvA06KTNz8uGCPjJbdoHq0r0U9d?=
 =?us-ascii?Q?Pc9w8HFOIHPKeyJYjplZm2ogcfqmxzcnt/OnOQnZ1vnkGZ3l95UKGkvwGw+v?=
 =?us-ascii?Q?7/yBqdwoRad8IqvGYJ+Ig3F6AZzm67wXsq/QuH0TVYzus8MtZ36yz3MKv6ai?=
 =?us-ascii?Q?T4ZRyKMJ8lGLsFOgQ0esIPYk+ITWLqtQwdT5E72iF0xeivrpOFa19DVXpo3o?=
 =?us-ascii?Q?kE8C3EUb+oBKbORUCkp1GbHSBZzk62GEJxETM1Kgv2GuKza9dvASjoFu0g9n?=
 =?us-ascii?Q?TxkMwRcLeUBA1NjSCVh9060VzEM6JxzV2wI9RqTjhpdi564C5foUFMqniqIj?=
 =?us-ascii?Q?erFEuFJcyyCczDmpWlj8TKdmN2NQ819eoTbc2sPLdLAPw8lxQor8PMoNpBJQ?=
 =?us-ascii?Q?rAfkhH8zlu0BIcaEtcycAeewEDakWlorSyfvVJM5GbtX+RqLStmuklJuJQH1?=
 =?us-ascii?Q?wFaXMtxEMJzIgvwYHVCOQ8jOpf0bmgmnpNnXyvsiQJGjxDbqEJAALKMEy0Y1?=
 =?us-ascii?Q?YD3U4b6Cd0T6LvCna/qxqjFy5HWkv72m3QhArXiHO6IKCardKa2nvO1ktPTo?=
 =?us-ascii?Q?+AbEZIM7fBHe/RdHU8CrhNOkXpmTzst5NJ5varMp6jUS26etIe1qApwVNF1X?=
 =?us-ascii?Q?HnfxJ4fyR1/+XpQvZTPZ1aGI0HcXCOkjO78f1T1Eq1s4eYZaC7gLDu1B3biO?=
 =?us-ascii?Q?1dBfu++tdXbd61BsTvan1NHCzXu9XLRYjNhbj/rZtKxY9FwMYMRm6sa2tInT?=
 =?us-ascii?Q?xcfsBSgeMhUVWhv88pMATTTdc/fui1me98M6GbCNPwbjLieEoR1KshD9n4Js?=
 =?us-ascii?Q?CH1hGTNntOPLTmnNQHHXAxUIHXcbgYuYvWGfvHUfrh60vQeEuirvBBi6vnOY?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0f6fd0-6305-4c18-4b57-08dbe74b61a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:35.0807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWFj3xt/Q7RTu29CDVliCFTZb8RlvPFVoHYJZSWg2ekLUkrGEH5UmQoIqUmPxO+VuViRE10VysGCMeDIbGv4fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10047

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9eb6c447f18f..255cb733c59b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -39,6 +39,20 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port, bool use_id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port, use_id))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool set_id)
@@ -101,18 +115,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
+	if (entry) {
+		/* TODO: a refcount is needed because the entry can
+		 * be used multiple times (e.g. fullmesh mode).
+		 */
+		list_del_rcu(&entry->list);
+		kfree(entry);
+		msk->pm.local_addr_used--;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -138,17 +151,12 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
+	struct mptcp_pm_addr_entry *entry, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
-			entry = e;
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_get_entry(msk, skc, false, false);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
-- 
2.35.3

