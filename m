Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E007472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G0dqphDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmnqnnN+7qyCVVZmGn+V3E2Vuk4vK/PI+MVeJcmD+moR6xGQIjwaz3hQz3hR1the7L/t8e7sdqyy3tIS4PiVfu4Jdm+W6qBSjAPlrK6ZLLbXj8drsthUiYeOKAN4oC285Wn1UZRvoWVn1L07NmFmliz0OmKqJlroa7BQukTZngiQO48dOVdCJK+y9CHxIl3IV+5W2PGipMZ+LBFsTVfB1aanY5qzCLO/Tr2RO1JyjZD+qJA6MfL6z9oOuVCmqgIRpGQAJgaTfsubaoYzg7s5UxQtXz2ET29IsC1qP1hH6fcnlFMiA5hz5R4b9Ngod6jmVdW/0wbFPAE6EXeILSWuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WfKbNxPPcaxO38SeKwjn1TAWk147Y/8EqqNjKSgv0U=;
 b=faUSazmqHHl70XTP+60AzmxOCzB3RxZre2gBw3FeZ8t0KNKXoXwoFPfApudWBAZzVX2uAEY0Nw9c35V1hGTrP5FG+BPdZ+goIDLirKCzSe8vedDH3y9YqsFbrZdboDf44Ei7I9OYlM7rdDWkC45zPPpczYFR5lby9nLsNEyYjvEuu99QB0MxtsrOi75TBi/rxbOqpuvkiJg4f2olqHxB1HMncFtxt2c0ONK0zsagljsFAQbeVru99r6YDtzLXCPRrGPnheIBOv43LXRr2oEhRYI9XpGGIwzbkTSImqnXqy0QWiExikR6+DaJcOY3Q22djUKrLFVD5MHh1I8TkHPP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WfKbNxPPcaxO38SeKwjn1TAWk147Y/8EqqNjKSgv0U=;
 b=G0dqphDwUfvtvyVN9/j+Jynay2AtMqGxdX+8bBtPjeYaXIQdwIzRMndexNjQYlFfxslJyTSQk8MaRNaAXZbyg2gM5Bh41lFBRbi0TY1cxej52kZUsyjzTdLZZGRFWVvvOM1o1nAkDknoTzTuc1pDot42YNtYhO8w9E2BgwcBne9RwVHLgIpH9s6OupLnXf2iRL887SDWsqBE8DDdzazS6pSLXyaLfe+yCfr0P3H0asIgEzSDNPvAncHblFG8J6LtCotFrjAUSB6iZfk4LSzusUcR1fQPA6mhA0x83z6/Co6sLPVFeK2ROFyHRzySekXvEQeCLgDy0DtQgLVy0kTTXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 05/12] mptcp: add netlink pm addr entry refcount
Date: Sat,  4 Nov 2023 16:35:53 +0800
Message-Id: <284c033345aa0a9b315f337463f41cb28e67442e.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e934d15-1ac1-4c4e-ffca-08dbdd1148d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TW2ZyAfm2cJ4ocv6s2L47odY2T01qysseReJFje1118tfUq1ls8EsnKTTD8pfL5llIodSHK/QU/TrOP+yRL7gDQFneWLCK7Bl6ZPA3gcJ/vwqUH2kBJeIUrZv7PZuQ7naXpPnT097QCzRRhCY4febvrhOS3brZDFUT+OSg4oHHEq3t514TzcutdmOrqg0I+UqCYZ/18Qyuyw+pSIoqSEdwq6C+ZaOdym+mNw2eGik9gHXTpoxxcglxoMIv6HH7UksAlPFZARoXoshYLn+eoxdPkFSuuYJCzVNe0R8KsZHOCMuEvJ31lWuZKiKck2X4fYN3y+UoWcWBE090x74ZZwbU2tYgB/pz9dCV/6fAwi+5h9aC+BH1cLEk2WFlmclTC91b6p6qI9s2KGXphTFFdOmEuD5l+JpwBC02GU5YFBwwNBweMjBil5NdZFaWT1thhbfWBR1YTG44y2Kcn6w83I28VVWHNGf8Fd1Fjj0Tq4AVuFnGD0V0FxZ0XYEsw3JXHPBy8rSGmqJjvxz6jeb6oPmrclpq+86wII7RZaq4NOXJcoi8nCZMch8BA/BjQvDhjra2/hQZPQoJBMQhX7GOFobHVR6NPi6x2WhrsXjAfFQu8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IOOGPWvyUGrW89xEWePNx/xmy9hOuDwaXFnTDY4MNA3DK4Alm2Rq6dO4LrPQ?=
 =?us-ascii?Q?OepvcJ23/ftttY//qWnMIWlvhKb6NElL0BN4HBsND3WxfX57aSdSCgvxmRoA?=
 =?us-ascii?Q?I7sXcu41vCAiBsxRBcrn8J7Ud20sLlxfoFysiyw+0z86I2xW5VwkNshRzhUd?=
 =?us-ascii?Q?O20+4iBWhKwY/da0U6ZGwPUNapCkDvNrqMDOrLmWnXRvafFvozqJoCC31XJq?=
 =?us-ascii?Q?0dH4ykpBIOCKNgqW/NinTii2rR6V11ImLYT73KuHUU/CD5mTOB2mCpLJVSJP?=
 =?us-ascii?Q?VhCqy+qk7mggKMDrvpIpUnjKokKlA7EQra+z36w4ZO3en29yr4ND9kaalHM3?=
 =?us-ascii?Q?6jgKf+mlfbZa6MMKswb/kvPUg4PUCJGICcgREVzSk/ap7J6QF/h9xwPeJ6/w?=
 =?us-ascii?Q?XHIvjrXm/Ecac032sLtQ/i7hCQF9OWfTOSTJ8scpI5UgAnQlgBHy+AP3Y6E/?=
 =?us-ascii?Q?VAm4/iS+22k6Jf20oNs8Ev/Z/38xpWlszIwS7214Hs6weXHeWG88PONXM3GB?=
 =?us-ascii?Q?xzTYoN3zaAeMn68KzmkkGJVTIJ5p8UHKydQt1ihS65sVth2CsgayYaR/+Eep?=
 =?us-ascii?Q?gtjU5jmK3JFznx2sTOPi0QGg6ELU6DywFpmBgaRjc77QDfMVKyh47nIDfhdt?=
 =?us-ascii?Q?cF5G+cJznyLLXZ54yTq2D+ZZ5pqs4SiLcSLoI8msLEKtWvYRUQCey+CXLno2?=
 =?us-ascii?Q?jbua0QYRVK69UwDDcc5gjUENPBdHY35RbNVfLq2C7kCH9eIIZT0A34buMViM?=
 =?us-ascii?Q?DJAPaNQadxCqZW9cxSmaOLYmP9rvkDKiXQMHhL+GX7VwhL8+C6qGrkt9vgXt?=
 =?us-ascii?Q?3qGG0DgmR0YSX4sayVVnJy2p0QtYrciyrMJYXmi55bXKitB0w0CCeXW3I5DZ?=
 =?us-ascii?Q?SCRrCWSO/CVu+8lu+aK+eiC44QvzcNvVhBUL/8BEDJgdBjs4X/f83Od0EYxT?=
 =?us-ascii?Q?xCVfiouAnnivI/O/UuQHxOYHosh2h95buvxAH3j7aRtBNV4EJ0BQQmnlFt/U?=
 =?us-ascii?Q?f62sAoEpUpDcoMur7JOxi6K7slsYSGJlrG/GzYvisBwmF77RMi2Syo773tJC?=
 =?us-ascii?Q?uSGtKKBurFTlRpD4TnhLwfqw2J3qs0U3DBnVFf7v0dWoAhBHe/X/lHcSwUc0?=
 =?us-ascii?Q?9SQMhx/ScRdSkFmFIgmjHohC5f8luiXh3lt23XjtSbas9gmKQ4o0x0UaZu4i?=
 =?us-ascii?Q?D/t0Slx7eBoastoue1xEVc7flBazk8/Cdu0JSRsRCEfxHvr+6s772YtEWrIy?=
 =?us-ascii?Q?In8dcnCpVdnNPXLk4V8Bs4JAUnctRcT16AMzxq18yuSVqmBhuPS359WJD6pC?=
 =?us-ascii?Q?wwD7rMlGaqkzC7YKbBZr3L7wTzEGLYmk0afES1dxBnyV2Hn7JsQFAV2oeQYX?=
 =?us-ascii?Q?LbnfAaSp/5xJIijc2TMecromIs7UBuB4+8704yzOaOBKH7tMJGK26l/tOis9?=
 =?us-ascii?Q?Fgs6OSanR6RvHk1FW9K9vtitOSYBx4RhbPZ71DiQkeIeXwS5QYAN/+6elkxQ?=
 =?us-ascii?Q?JNWFHh0O+mC/dD8n4ffbYZUbxrZGDGnjM7PLu9t6o2B5mi18YE6UkeD84fZQ?=
 =?us-ascii?Q?PWBUnWqn94Z8WjPJI7tFRxBxz8iygzSw6SGiGjhI6RRRfZTGlyaDLiXkaCnG?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e934d15-1ac1-4c4e-ffca-08dbdd1148d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:31.1020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBLNg97yYz+DNHZc/2LhtflsIbeUjCZNVBoM4FQMrSoCjTTmA/RXgAtWFAHyZrAS4beUmGS3JGThmFlUknmO2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1.

Increase this refcount counter when a subflow connecting or an address
signaling in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec().

Decrease it in __mptcp_pm_release_addr_entry(). When the counter reaches
1, then free this entry.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea507ed7aad1..7aa4faa47f07 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -569,8 +569,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt))
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -610,7 +612,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
 		}
@@ -862,9 +865,11 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
-	if (entry->lsk)
-		sock_release(entry->lsk);
-	kfree(entry);
+	if (!refcount_dec_not_one(&entry->refcnt)) {
+		if (entry->lsk)
+			sock_release(entry->lsk);
+		kfree(entry);
+	}
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
@@ -1054,6 +1059,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1281,6 +1287,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.35.3

