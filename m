Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A67472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GUa3pHs4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM9Q/CSbp9uXUBIsvba3t2pQPPiO4VMPG5bI5fy2pXsaEdTAhknxW1sI73CuekthRFZnyFQu361ZtA8nJQnBOeDq2DMIypnpa9gYJuehEvtab4G+6f+edX3UXRETXUwCN/oTWO9ik9a6LtXPPTLwS/JQ9CF6ho9hmvgnrOgNvJn12qGy1h38WUU2CwFaN4fIA/UJnu8yZ3Yo3yWctSesgWxbdQuYQYtYKsP74aStLU3ce/fChEVkopdESbiNkeIDCTuS1L8MnAVKZFq/pcApEwROhoFieexEXE3YcBbZjFbwZ+rH4AXtxnTurJthyHsuS4acZ7LnJcSxCVOTCseqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75HHd5pxpV+TLStrT72VkkPukEjL38e3/JvEPFkzStI=;
 b=HZ7njnXHuHDK6OjF/3tC7v1YL4RxK3vf9DxEHPjxuAUi2TuaSgNmHTMx1ZWO8QjLWVzGBj4XlrWp/CFEqT/dqkEGZWFbd+nLznn3GjGsfCv2Q9t0/xA6iIQZhZIDrM2IWkJMoYQrWIDxSobq4ff9V85KevZ2y2+VBm6czFV4w61O6LRD/E2nd/+JAH/SO2xN5kyXXicVJ+kaf28sqveNhpbZ4nHqNsRwN6m96SuEPamIlihD4I19jW9iLiwlyzRjIgw4fsWfYtam6gzezy7huBxr86OeED4Ck4sWWyVINH8vGUEqcUvH+tVYCTcRiLsxLdfpMVs9zSw5VYaGZa4IAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75HHd5pxpV+TLStrT72VkkPukEjL38e3/JvEPFkzStI=;
 b=GUa3pHs4DqTQmAnI4hvsZ4BWQgR0r0YofcWX5Vjz8FIvecwzmMKD9q5IecOEFTVyygF+oK7Zr7VgdHm4MCvx3Uk4VzW6THLVVFCUtLc449sCZ/UGM1uugVSR5ClHIyQ+9Mi39kjQwGBRA+hk61T2WfsW4KtTysCG9hfT2X5j1SebhpMajj93A+X7SmV2ozWT6PJg7c8wAiHzX5UX43xljZKepEVm3gMNdzq7U23CoXlxgAEaSQms/7D9h+N1ZIjicG7H7oZiX7OUCVus2tkIzUNZrPFcKY/IiMEfTKjvx6qaazghqyLi5roVKTwpLnl1ZcJwR0d6FyHZ4lLJJ37tGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:37:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:37:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 06/12] mptcp: drop addr_match and id_match
Date: Sat,  4 Nov 2023 16:35:54 +0800
Message-Id: <abb6184cbd427fb0f67b79d492868c3815b1529f.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: d52a21c6-a94d-4598-77a8-08dbdd114bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ge5rzYtKmB0tgonLVUpQPRRFdlytKQTx5y7YS4e37/t/BLrfJiusEKIPYMnMAoU5zfK4kESpYJwJRs2uNjVchgh2FBkxvN3K+9WusV3odbh4n/6+Ht40eRNoaXZ5Vs2HmDnSj9FCCYzYMN6NmbUpQTz4vGac1AWmxvDXtbLuG8p9y1N5W4YH4DkZ13khjaQF6P0S/phCzjpPMOec1Z1QlodcIkl1z6ZC0SvGvrp7rOshwGOBnzH2MxrKiv5v6p0+MlqGqHwrow80B6ir0HbUTAjAJejT+W5CRrg3ZhHrn7kxXcriwFv8hAjlUVJNfDNPywa5bX8qSRjO6FrS/QZspUwwfalH6xKkFOI1UYfuCEN0unXVJXNFkC4mfjxjARVqAB3OMpHDT+5QlxokMUaGR/+gcMOfifoLyGHSPP2jMTcfMJJyou2c95QPj7eaZpAJNs+gTpKzIXV5RylAEbtqLVQ+BtX3jBWyJyeUeYTuZii9TqWqoj5t5+1oDXaiNjHPz2e9F0AiyOs05HgIsZAZceHO/t4B63gQTnjXBw6AXFgJK/0uM3KYBuOJV1KShVwB4XuIAwXRIrXnlzIPSGSa41kWPY5J09qBEfVZy5wpIEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(6666004)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQFhmvQAW+0x0v3H0dkqtVczVKiQhbvznHt4SE1qVHY3ydLzE3eUxoYdegh9?=
 =?us-ascii?Q?z1KNOUg2RVImjgU7DxJCwoCvlvawfQ6mPmpe5z7yRsZDEjiTx2/Ok9kTMr79?=
 =?us-ascii?Q?bBL1Fw4Q8wnAwKFU3fb8A0uEC39Ix5T1kk4oZCUdhhG0EZCib0hd5hCM48o+?=
 =?us-ascii?Q?fjt4eTiSDf+BMaiw3W1BrvXbeEEhy6qGw5yablREiCiMF2HTDvpzeasBv6k6?=
 =?us-ascii?Q?5C0/06KCe6YVRUTivZbjkUinvmIJRj97QqN+xagAVixg1WRO+lKxWOtA1hYH?=
 =?us-ascii?Q?cF9bFfQnQSCV/FKAldEJs8yD/zO7wR35PBNijH3HKRJJbagzNMDy/Bh2470t?=
 =?us-ascii?Q?Y+itiNdGlyRSpkzzrgnjuUGQLRgNfgQA4z7KXrqtiU444ncYTqWZrShq0/9v?=
 =?us-ascii?Q?k8wPofFoqFHnTofPpPB0/TNkKRircachpn/UvCU3S6sDjkj3tato12hUTPkk?=
 =?us-ascii?Q?aiBX5NPwTROVssRQBMAanajh31Lxy8bIPq+GeJn/oMjG1r7xqqnJESjruMjR?=
 =?us-ascii?Q?PkMKkjK7MFywQEBkGBwgpbOO8EPe0Y3i9NV1/GINawE3NsPzwQPUmNZGNclA?=
 =?us-ascii?Q?oCPLyv399eQUGsx0g9hSHHseGMtd3i4nJQhibOB83MI3m8/byaI6f5vd6KY9?=
 =?us-ascii?Q?6sKkE4B8XOJwE8oiVHMYFbvqJQjqjClfOpo/WxoEIxl710OfvLsWQ0zQVYtJ?=
 =?us-ascii?Q?A48N8pYqGxKcjFElhwZn4GKZx8KAfc3g8vnECzk9LUsDZvvCEOEiKZFmZQwI?=
 =?us-ascii?Q?hm1wxUacsBsLTMQtvLe+HQmY+SO5i9pIkSO/ZiWVZJbah8ty9GoGgZMP4sm7?=
 =?us-ascii?Q?T7nSIMgw3yvRNOa6tR8bl6zuPddjF+J2IdOp0m6TAm+EAG7RDGXwePx54WN/?=
 =?us-ascii?Q?Sv+jUx3t+WwIdNN2AT9BAEUcnFUk2OflI+seBoSm68hVuSwa3o7reAwZZ6zt?=
 =?us-ascii?Q?dYnvMnEbl76nnJ85U2Oecy3P3tEIV8e66qPaWcl5e6ILNU8ACgKXzJPBJRlF?=
 =?us-ascii?Q?IP7dKzRnRI/JDu5qdsb6G58gIe1ERimCyO0pGztGBlJ0bmsIJp7nAkRoHp5h?=
 =?us-ascii?Q?Qhk6b9mrfDQCYfDtu8Eca18LQ9uJy/i5NmFNJWL+XORZKIPryCVn8oVuVRn9?=
 =?us-ascii?Q?hGpgP9VnhkDwhwAzYuRBv/9d1sNmbwLrmSr6i7O6J10IgAiUrRjTxe+obA1v?=
 =?us-ascii?Q?RLnwaGIQ6/CiHlDOHT62AV6JFT2RTSpeSrQY6cBen6CLU0kWqOxdBuveqF+P?=
 =?us-ascii?Q?yKezBqNmosDUnnjEII8H8taOcB0cvHtMLJLpCAZK3eJgQine806I5TGEWMLK?=
 =?us-ascii?Q?dAqXPf6pBbLsRIgUIxyQvYpxIWCtK7iShc7rmkkWTmAXoGHEZrU3GAm6rWHi?=
 =?us-ascii?Q?oL6eYi+nUjFaAsWrip6xCXv0tozDKFvmxC+nJvbBx8D57MQm36qTfdeXsEqp?=
 =?us-ascii?Q?pJKIysCW5Xgj8+Abri/J5zg66b7YLIR9aB6li7j1anA5Rt0IDq9SVKak87I5?=
 =?us-ascii?Q?mfpNjJn3yRg5Z20oHpai14w2/COKIfnblgK54V5ihDLKu2nxlDjTqKWfzf/5?=
 =?us-ascii?Q?/1/fm84KRDSYPhLgtyhxA0iZu1AXSA543WWynHhlLfrIbkqG6xH3SDqvbr4Y?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52a21c6-a94d-4598-77a8-08dbdd114bdc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:37:36.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwrOpnpJHNALLV4R+tMsGRfenCcbniHxt1JFyasBbxZSD+fNt1doxs1QrI2q4vBNo+inJaq8pkJrwEXMc/w1OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3e8304fc1271..a00c3d8854ff 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -60,26 +60,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
 
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	e = mptcp_userspace_pm_get_entry(msk, &entry->addr, true);
+	if (e && entry->addr.id == 0)
+		entry->addr.id = e->addr.id;
+	if (e && e->addr.id == entry->addr.id)
+		match = e;
 
-	if (!match && !addr_match && !id_match) {
+	if (!match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
-- 
2.35.3

