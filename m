Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AB03BB49
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kFKdaHcE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTtcpIgUYKbzp2aGQCDzSTeP1GfqTJF4HfKcpuinGIwXJR0aDmGVqU7sgoCJL+F08OyVntWvPnuiUcQn46MCOFiskeg2eSbvoPDZf0DgHujQJgrp4sopBJ8Px2MnWhZ2SQGhKliQTSDk8KXLJ+pxIHPrDYd78t6b1ao1lxVMmKH8PxHoL2CFLrOF2lhiVLoBx1n/r+L3nwJINxD4Otenc7N9DSpa1SsuN5Qq1ImNPcrSxe8iusNOj47wZ4y9g3klEPW8Zv3zzjNgk9eqoNqoCQYPjFEH4c+aUtnLZMzL/Fx/AS4WEjtX2KO/OmW+ArdW+JSYUlAaMG0aAAKQ5nDJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyO0dDjGQ8YNpkhOtnfh0sLwo5M8qTyjkoRsOX/2DU0=;
 b=fndYXqZQdguihvBKPZnbIW2rVqrAZESAx3quZEf+sm48qVSa4y/7UGYAmQD0eY1fpILg65V2oLR3t4mDnkiUSWx5EWxtOZRiWft3juPlzlE0nmsPmalLskh1V0mdaEXIeOp3Q4VFV6rgiCALXLXKj6/7+8UhOj0rscHLZiCOoDgxsBz2XUNoJ/HQJKHJJ50rIECfAoolPwobY9P8jRS6MfgVjdUkz5D1r4Vy1GxE8jeyLgetC8x7cdA8+76RhGszLX5g0fkdlEzd3H1ox8JpvMUKtdZ5oh5ctrzOg9cmrq2g0e+7q2/TTNK65Xp4tCmr7ZMrz08v1XxfVBfUh4Gy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyO0dDjGQ8YNpkhOtnfh0sLwo5M8qTyjkoRsOX/2DU0=;
 b=kFKdaHcEKOka5vD4199GjJU0vU4YRihJbnCtcEZwZZUKaO1QnG0QXBeiEP+GfRT2Z5TRsskvJkOY3mVD/gYIIwNjvukTv25h8bJTmiYmMGGTucfhFPoV2XIXd+Ss35UKdxBo5aMzUhald2KlUZZFQ/NIPZ0kyLKTto0f/5f7tSYPreFmUcm2Y43TAx5TYpz8gtIw2P6F+OvS5lh9JUFSvECl3WdlIpKYHLE5QCziHBB0WTrECRbE6W/WwO/+EUh2liIGiwHaLZaURwSMonnOF+HBiXoH/6pppqs8CplF1KGNE8WrBhgJmqmqQECxxZ3S/LnVHKfKKT0ZJMtsaA3big==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:55:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 18/28] mptcp: add mptcp_pm_remove_subflows helper
Date: Tue, 21 Nov 2023 17:52:41 +0800
Message-Id: <2fbb194df90383b1c28ac607c51e8be60c1f501a.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e130209-4829-4449-a0ac-08dbea77fcc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kWd4MdUYxcOVhnEv6pwOuZNnEvoWoJaBTmP2k+a6UN57paUpyCQRr1H3TGogxV9COHJZ74znE81lyzpeygHAj93SbADR7NNSldIxfru1FirLM7KwMOA1TIH+GYakVG7vDmiPsNIdt3OVjGDoscSmRrC0d01iSIbMZNzEldIsFA4fk0KE8kn/ijJVl+w6HNx4wrN+/GdHJZZp4Bct2yvKsfNcUDzo02SnSA1G9qbM+z2kxBg0Y4KNTzmyCpDm2sKkjZ8VFjpVrczVyFqB/akLECi9TwTqmTh7XHuZic+ohCPWT9irfeI/gOocscUkPwA6muGzKmNRNHO39T7Rj/YLazvGuSz5DYNMfflAliOIYe7uBLrrsIdJ/GQx0+yhj8vF8cwVnrQuvwYPMs1tolk5A7MQaKVHe/3pIUuLnx/3sYkH++M763+Yzkzoh7KuQbtxcCr7sku6vgoVQ8SE7PKmGefLZoTxCGhoyj+F6UZck+L2Ai6CwjVQ2pEu/9p/ofhDqL8CIJV0H1sHou2Gymo8hK1xU+k37kOWsRh/UK3hsaEBo8DIAddHZTkoAQC4SIvE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PvT+FqjMNegrIApSydWPNpMNUrQdpqd3wnBDYykUm8eQjLViKWOilerfncBH?=
 =?us-ascii?Q?zaqACdu+uHt+KZuEB/71CVTDrsGF3OcdRUSQhhDS8+yk5v8DjvfeNlG7jdhh?=
 =?us-ascii?Q?4oD78fw3DieOn9pPWkxt6M0USebAD6KY3yAd4CPjWWocvlsnJoZVCu3qt2nv?=
 =?us-ascii?Q?/zLcQSBqgbzVCErvE4REx7jVvb19ShCyTzLx9fijsuOLYfl2ySbHKr/lLlUp?=
 =?us-ascii?Q?OZJ5gJaapuITOX+uvu8r1vmvjgUyxmiHcLQtsq1xG1m7euj+nZWnE0R/w7AU?=
 =?us-ascii?Q?XW0Q1xdkJozHRVheq5dLDvIcS2kG07Un6fBLrBVQ0A4rQjEb6aRd+9Pau9NM?=
 =?us-ascii?Q?/Xx44AgsPJ4+R0P8/t5YIODIoNsqahoF7cKdA+iaMZRfZIQZ4qP+4uEgne3h?=
 =?us-ascii?Q?fxboFvX59RlNjdEj4OfuoS9KD2cMCivpder1U+nB1pAk2Qt6wZBjkHmHuK75?=
 =?us-ascii?Q?U1UnRTN0PtzGa3gZfV17FJ6UHsn93FF0TjR73ZZ0PTnehnjUyJe0nEapqcPe?=
 =?us-ascii?Q?sFm5bD3lA7sS2giq1DjsarfUGrQvzcMZXch7DETX39ZY+98HWEYJIZ6J1EDk?=
 =?us-ascii?Q?hURXC0t/TAmlioED/WqA3FoSezN8gySmk8MlhSigMSU/8ihHP3LGL+XtyPZp?=
 =?us-ascii?Q?0v/y6o/2gYNmTqKdO+7MH1t3u3LhFHW7/aieF13nBhmTu/dcLWphaAAnw26h?=
 =?us-ascii?Q?Og4TxL5rvEObVrKECkz9TqPY/lPWNCLeM2yi9sjUiTdaKWaJwx/0q4Ms3uCR?=
 =?us-ascii?Q?yX6cKyh2xFdNKg/sss7TH+zvLZoWQbstheybD+3i+d5G/p+ho8KZ56FpGLls?=
 =?us-ascii?Q?3qC1SpNoQcQ1ljFFVctnLRn34oabrQBWrBiaLDeiBqCP68oMRUbKQ/E5Mhyc?=
 =?us-ascii?Q?FUXvWHAK/lOM1kx7ZDjKg771N2VrymfPS4oUR+xDhQj7rS+53voscgAl1Thl?=
 =?us-ascii?Q?8hgShWmcufsyp4vUT4GA3e7smU6i9HJbtsKimf56R3Y3XEYY5TJN0xL2OQJX?=
 =?us-ascii?Q?uJpdPRb83Zob2EG3CvCcEgtKpq2Ckh167ag6R6q44kjZlMChpkq4zj5IBZ38?=
 =?us-ascii?Q?5bFF8meMgTCrKcnlOF9BMYA+AxOSvOX8DMAflXfaeD70iKLKpjWduQ4UmUCn?=
 =?us-ascii?Q?z1ndCYfJA1H/dmbv4Tsg11yJqzIsUABlfKAQAmLhGHTxoHXM4acvSg+YlNzP?=
 =?us-ascii?Q?3ivlf6lWm1CShbktIfZtzyeaLwvUPOYeLE6xdjZ9mWgY9ynLSgr8v8KRzUFZ?=
 =?us-ascii?Q?XLIeq52OPk3EK4zfII2jsKZCJt24FlPsST86E/1+HZkMVUaTzmeO2lWMQR1b?=
 =?us-ascii?Q?RyFpdZWRCz9CP2tbarRzFw62AardcCEnRR1sOZBTbVziZHiS6YbHwO47btQ0?=
 =?us-ascii?Q?TTTCkbRiFvT8i6O3bXO09O4YSyQ/XEqEcUzTXXbCacAgH3ks+pm1qyZ3ZM1w?=
 =?us-ascii?Q?JRabo9UuRCnLiaiSuvY32ZfB3mefOk/nBGF6QsYzUPfwlA8lkZCk+HIAzAbx?=
 =?us-ascii?Q?9pbF0PV0/hOWn9LWu2gINU5qpx3E6KwHLlDIw2k+zrLPFmG1mnuiLMNHIIVY?=
 =?us-ascii?Q?PIWJN8VZGdhHroFe0sTLr45hYL92nSmtGJoVZ6dWhj91vb1I2PW4JwpEMT8D?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e130209-4829-4449-a0ac-08dbea77fcc6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:26.7795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImjnCeAHZrSks85DAAcQbGdwSG4Bi0OaXDaXaSEBS7Qz245ryCCVmEDP13c+w9DROUN8Tz39cyQwKG+RzOUxew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

Similar to mptcp_pm_remove_addrs(), this patch adds a new helper
mptcp_pm_remove_subflows() to remove subflows related to addresses
in the rm_list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 15 +++++++++++++++
 net/mptcp/protocol.h   |  1 +
 2 files changed, 16 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a510c7d56d0e..a4dc2bc8fb55 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1489,6 +1489,21 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
+void mptcp_pm_remove_subflows(struct mptcp_sock *msk, struct list_head *rm_list)
+{
+	struct mptcp_rm_list slist = { .nr = 0 };
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, rm_list, list) {
+		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
+		    slist.nr < MPTCP_RM_IDS_MAX)
+			slist.ids[slist.nr++] = entry->addr.id;
+	}
+
+	if (slist.nr)
+		mptcp_pm_remove_subflow(msk, &slist);
+}
+
 static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					       struct list_head *rm_list)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 94126212da8c..efb24c05a7e2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -941,6 +941,7 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
+void mptcp_pm_remove_subflows(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.35.3

