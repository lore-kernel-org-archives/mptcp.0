Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F03C4407
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ODCtHvCj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHiBMO7njGnrvi21rURH/Spp133mM0CEOtCGh+fElrP5uD7/OZI9lcnY1T0PaH3YR6tNrD9NBlkqqD7laJenQjaFdiDuexw84B01iihFthM2/KZJU4n9+oTALS64vOMA/OfMVctnomDshaPfqfVkzb51gbBrWy7CCxRlN8dLodftjwvZLIAYHAXWIkwkw65Z4Bs7K2BRSrhu/ON6hgm7T3Hny0sUlc05WoUWuPCCHFlpUr1fTIY6N9jo3KPaJ9rXGrUIQ656wzj8lrgbyTkQD8jH2CDmHwyODijZlcaRR42L3HjBKtd/pfx1gNqpkQ7OEZPOSZ0RLg2ugZTzhzxNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cF+z6uN5edzwJWV7abOzpoi0PldDrgYlJA7x5/etgv8=;
 b=UvNEgqDuUNGAciYnwK9Wi4dwqiwT/Pdtd2Rjmp897qkCZE06OlPPFuit2AYlR2gX8zGwXndFlAZgDpCym6eABmAPHm/FV+axPO2GL4LESlOiWIRzB1HWMtPR/eBWeRO+tXnejBqsCB34gGR9jbu4tcpl4OjEsFBeyRF6vIjt+7JUGb8oG4RjKtoOZyPy6VxpePjzc/kIfxqgu96K2iJDLYjgkgmOlN5SKW+/2ss1TEaLjKc+hUdbosyvsZXVLccQv5Y+Fv8z5P2s9svqNcOWluZvY5i5IewFzO6Z/lj8yZkpxZ4SOAv888UPjxY7bP9psuTg5jUPg7lc55Ua1x2Hzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF+z6uN5edzwJWV7abOzpoi0PldDrgYlJA7x5/etgv8=;
 b=ODCtHvCjALWXM55+Xsn4gAfsu/vUCIMPS5uv2UdFTdJOAW7G5J1MF8/jjafg3lmo7kbiUdraQE3zTx7G8MmaVrDsqZlLrhy3A9eNUyv86K3FNmCW/2EpEAcnA7nye5P94EX6ZFTiym+VTIg1Lr2+ZhWCgCNYGoBhsSl9seZFyZrxwISW0FSwvkDd9tw0VfaSQTR6y6OXAss/JbGmVu05TjIWC5FW3l6PBloZ2bLaFTacxe7K3q3ueAzczzWClpY2V8x+gcGuCBKKX8T4CifeGoqk21Y+GGr6IzigkBNKfXxWJQPBj9mKm7eyxx/5Zf8nFybptY+QympJzVngDuH94g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 18/21] mptcp: drop addr_match and id_match
Date: Tue, 14 Nov 2023 14:35:15 +0800
Message-Id: <3e7d10bf2f29dbacf821e49c02f4d087e898927c.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c23b5d1-b454-425b-fd09-08dbe4dc2f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w97/r4JYS52rUl7Yk2s22x+l3jEPSS+teCeNa+1GBZ1cF1PYyYdkz78YNAkjas7Fs/RaJyo6e5JaSOmYlQrD4BgDaj7Fn97M3/EV1+yCxA4Lu6Nuw1dt65l5lYPh5Z2rLmA5tp172ENAASKvQzHrGqJBvHjaG+XrnRvZeVwIaGoheyNvzzb9orHzrjQZDAZLygX456ka0IPHkPAoQwUebSFw9jZXCUSDTlwVqOOoTRbOnQ8nprJ0ItnyiS6Lqexd7/uCbzLfRqieLaL7kKiunuOUPDZPBCd60oTpQAlvbnpuWbM/TB4mxxudGtXCOJbuHhm+jurdoaczRj7Nt4Hcl3c1aH9CXiXfj9htDKscj6QOSHlb+NenSAmaDhzbiCfiCIBVQB9vZRrJsYb1koFnIu98PQ+TDnjx6p7vK6sXgopN16JVrmOmtKTBsTKGsZpX4HIcADH56m7ezHT2bhI57/IWEWRe6US2SRhBzQqEjEYXEUJQq+4Recbmx1RCAVn8M2y/06MY9jewo8CfieicQUF0AjSYfVQx9kqIgAMhd5PgeeNHlMdXpZQ+5zH108vA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0byq+7t8LFrQftT975n36aQkQFzYeablvmg63XGGyMT8k1oWJdXqZLnehS0Z?=
 =?us-ascii?Q?kwP8WvmNzGCMfkw9/rVdJFR+ly25AkgrcRVzgiEfrXRMs4fdxfXWfdOvDUFu?=
 =?us-ascii?Q?CfiYHCbQo0uB/tHaU2OXPLLXf6te9VLW8PMpNsfXzdnhtLwk9J7oBYUnfJnP?=
 =?us-ascii?Q?f53HlDFIdvtMP4C89/8wFOeN0ZJEigykbdRi4UUPAYE2jOW1BBvRj5wLox50?=
 =?us-ascii?Q?7wq020SkKybApLVxi1Ev89ftafTMdxU5reu7PivITuW1qX02sWXRhVS2TUdX?=
 =?us-ascii?Q?PUvOag/PJkCxi554x+JtqUrJdPw7jFS8OHsna8vdC8ktFZtYDkbk71NfW0lV?=
 =?us-ascii?Q?Ik5dIb2Y1Cu4A+HA1bLYk4B5YwdA/FctJL3np+1+8y1wLQ3a4WtG03OB7lD4?=
 =?us-ascii?Q?ccoxv7yChlKXRbKmbJ6P4+vdnbVOXuKNZlwR9+tLoIJzvP0RdFlJsjK8MBUA?=
 =?us-ascii?Q?uDp44ZccektOCJr0aaHzRg9L5pbi6K0n+1TCs/JOEhhADOfY6Yv0WDTCwDW1?=
 =?us-ascii?Q?aIR7vq9D9optKXEzpS505M3yA0nUq6H3Ojm7moBRgTjQynN0EeKKyYbu7QAY?=
 =?us-ascii?Q?Bc0Qj/PZ+n/U2DBGoP/MHOFXfqgzc8ZJr+3KPG3wyJ9xr40iGvMIQQLJmeSQ?=
 =?us-ascii?Q?CQ0n2HHQ5Vft7mnytb78mvZFwzWSTg1xmQOI5+pO8UmnEWT8U1Ma1f72YuEy?=
 =?us-ascii?Q?Cy6rc+WWwAvRH23B58+7PZfjmKDhlyKMyz4GpSGGuhEQF70sO0g2ypKinFaI?=
 =?us-ascii?Q?K1D6+nxnw5mAkNhaCapS2vsLlzEZ0+dASk8iQmuok8xPBTJymFS4qdlLwAKM?=
 =?us-ascii?Q?vJCMU7dVgUxesYsgeYsC6fAjyhxmYOLAPh1gD2lu+/pYZ2xIYeutNGCGqNze?=
 =?us-ascii?Q?IMjcVzJ6al+cc75B0T6K0ULTQ4mYvVdLHrO48yT7OyzWT+dU6oel3F/349tg?=
 =?us-ascii?Q?I0meKZTNAJEV3z5C/lLhcMzfJY/aHgZCz78TgndWKGKmA6tncFB31JfocFMW?=
 =?us-ascii?Q?Tpppb2Y4pA9GoA8X6o0bHjeB5HCO3JfKJmmRhijawMNmYMMTnzr2KR6nleKt?=
 =?us-ascii?Q?awmC8nPMpKNqbl80bW3rc/LHx3RX6WFL71gFUO0bu+GfRZYU/sDFAGUEt4YZ?=
 =?us-ascii?Q?yFyS9eFUiMm7JOGXvAGCv4pLRTnkvAhdzp4wCOr47zXPctzVwOJDYrJN8WHX?=
 =?us-ascii?Q?QqG5x4YUjMdXlY+jua44qYq3QYK3Gd4inP4keMfZJlOP+EjghkNWLNUjJdS3?=
 =?us-ascii?Q?6SmnwFT01dxXNKPsuh99/9ISOtdMfM0JW2Ar6oxIgYvs88a4Nw3EcRngEWiV?=
 =?us-ascii?Q?MFygb7tEBFPMrRBeOl+P3iXa8FczKpzJ+VTgumq2sgEATkQ6sabnXMYg8eaF?=
 =?us-ascii?Q?+3mzV1P21xM4EDBQKa/UX3+90ObnwCNs2UydVh9R5tj0DjyOv/dDQQybdx4a?=
 =?us-ascii?Q?51S9RLrLewvdTKc6AW5kRKgEuVX7MMhesjy6Rzj/nWLTB2RWezNlQw0gUsDB?=
 =?us-ascii?Q?08t3h3hWn++umSWHgFvJp8pzw0bDjTgT3hYvEfCR+7XEZWDLyTpiDVsLNOtv?=
 =?us-ascii?Q?YXXGb44a51Tnyr4S16WkKfk0gihocxbbu/nQRboL6EvaEjdwdDYK54quRQPx?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c23b5d1-b454-425b-fd09-08dbe4dc2f16
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:33.8225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94rSmtUe6d973PpbIliUzd67vnCAPv8kUH6J4GgHj4dacdaM1WbzHr1KA14R0WiKctzN0/5PP9q99tQHlpjgOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 71c47fca375c..994f2bfd74be 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,26 +59,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -97,10 +84,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

