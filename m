Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E62D263
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="knLwqg9y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1pIHKhmN6xJP7gslAV7rX7CYy74H2n2AepbS13uLHt/b6coQ664vfF+grIWISecmPfa6EEFvwZfWlgh7730atZ+Gc1uiD07ZGornviEe63/zvoZUKQmajyb+H84JkDOJJpbxh/5WteytZjWN9FQM1G8HGEJcAsWZSFN7f3OTvGVqT+x20IzMv5BPiBw10WJjGdikbODDvJQniEn6gTBeLV4XkI5I05uRTx1bq8HgKQOF1nAoMyyEjCM8ZD+WeAB1bHoWG96LLtzRtS8aSz2ywdV3eRg8qCbNOlgHi92C9W9ttlf7UtjOExmdxFEQQVQGbAb5vPXd+Hr62Oa4jAkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=aAgzv1ERlQ2MJMG1oj6B/ENLK5jAeMT/P+BFPImRr8XyVZhlWhuKT50LeJ7iIBjgDTsqfnRE5hEHDSB7ppm9bo+kcGd40NtuQJbrPqsT3htG/wF2Zonuq8+DZh+zcimVkQOMPr+nlc/eBYClm62isi7+thU+HX5eCp5gIqAlcqDslZebdzVdlk+AZwzZrL5NBV+LF5MucXooWP24u6oH4/n9m9xeDINA6q6f6KM3g4Hx/8kuI3oHl1ax8EvuxZMqZegKuzVobJNy6zg0V3I1+aAxyDxJNyf1Uyevk+0aRUr8WTSz+TmGGWwz9YN7wYgKOc/+MuInunNKs9+/tBBmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIHyqT6HE6SN+ei496ifxFyH6B28w5/Nfb2pvs1TXCU=;
 b=knLwqg9yHv5pcMaN1jkMOIyMRwxN8qKpZDcgVoONj1NM0QPcy63XgsaDgKS4eohIMgPMCTJiT3pjj6ID49wqborw72cfcuQx7skvim0y5V8I6/MYOjraGTGUynN7okVLuBIiGgR/giTeaEoEGU/9xUBe833578sofnHQ5HbLXek/7JWNzcl3qhYb5WTpXqhEuWzB8ZK6qcJomaUmOhrUenuPsFHmwOTi/q1hTPWrwBFSEtTo1E9vVTPLER5FuWKh3vWNAmEtcev6C68Mox8JelbfZ3tIRwx9Evo4I7vqwhcJfvs7amqQu12sh+K4p0RIypnw+khC9MuP9qZ5SXh9Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 03/26] mptcp: use pernet id_bitmap in userspace pm
Date: Fri, 17 Nov 2023 16:55:56 +0800
Message-Id: <4e23813dd9df18c1a1ce0b16f1356a541283c81c.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0024.apcprd06.prod.outlook.com
 (2603:1096:404:42::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed03980-2850-4daa-b216-08dbe74b16b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UMtpB2387jWUFNuANQC9OE2cvaVpXcsmsfjTwhsESmi+AXYX+fTgUnWAyd31MXkDbrIhg5X+DT4FfeQYcx0zDw9KKT/ik+m1ch1CQhthhndTXwg3r75pO1oCpnwD1ZRfzb0Yb3ygZg/HMCOsFwkjxM4WbbN/F89qFn709Eq/kxp8Oab21wmpUaBktugJmcuBs4iDAlQ0DUFpafmnxe9s11yuy0gmoGTYYYScuuFhjkh3ku5GZocAAwNIorJkRB4l0SlgiulG7APsbnphihEf/RaVlVNo0wrxf1vsgtvZQ9OrOQZDLnAaacOgQVbnDbkAOW8Jvg6zMUjTebgU6Ja3bvcwcF5lsUT7WF9qbEchhkNTg/BAhP2ZmpA/3mpWmaoEUp98GPMcVRFE5FQNpVFpqA8LcwsKNETSvQpSh5j47Ko9RI6glq2OqXqMF2J2R/OHttNhszOyYwc05LFAn99wDlcMC/RWLumRLsG/+2WPnnkUCj0kmEplYyk0eh+Z5x0MbAKyQ7zmfSOQvPW0cevkkmmBN9bpvW9rvaVWLNoVm7Fdmfg4aNzThln9IcLgLOAe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dVLHP6K+8XUC7MfJ6caB1WYAi7m/SklrQ8LKtASS6SqJEWzJsVoRAsZr+tO8?=
 =?us-ascii?Q?kgn3vEUFv1W/DAzwLlGXSQz+5x6YYg9LVGW3m+C3mciFQVh3YapBwYmIKw0n?=
 =?us-ascii?Q?3435UdOUV5+ZGpO2TCT+8dAqYoHWWv+E1lky+7ajGQH8Yn4dqriuMi7UV4Cs?=
 =?us-ascii?Q?2k8i4Rj1igHA+Xm6qBehH2TXKN3wCEO4P+nrkyHqgq/Cpq8Hws1EnvlpSnpj?=
 =?us-ascii?Q?+DBa/LFPHTRLuo7XX+0FMU3Qqr1ioX7psmLqizRutCnT4THsnIeyJgFLG/Ua?=
 =?us-ascii?Q?a7I5U/FJEzLTfcI6kBkXd8wmfcGn4OKVC0PuX8fCngMLaGnIfCq+V/F2mJNf?=
 =?us-ascii?Q?ufec/WD8q7ZpLQmxPbXRSNNSEW0Ax6DMDPTCW5QSP/F4bHD07ctLTZw0JMJ7?=
 =?us-ascii?Q?edgALjN6mvPLOUzfWA5RLTM14kK3tNsfQJ0ajNvufIWrXfYSPuFwICS7QSE/?=
 =?us-ascii?Q?pdb9cEa9KddrGvfR7re4SgTsaI089ZEOGBEEIgpufnWSmV9DKC1A8+atjv8t?=
 =?us-ascii?Q?v8VXQhCrPBsomf9RB07Now5X+DVkYvL8gjqG+tHN9c3OqcugU2q+TeYMawKK?=
 =?us-ascii?Q?t0x1FYqDs34TUHuZQwVtLcWVeN1NDQdnbw1d+41SItGsaWhuPfGYtGOrSQ45?=
 =?us-ascii?Q?20snf49tgU+tFTDxGhQeB94Kjw4egtD/6TxoLzjCVomNzmKOM6wDMXuH6BTm?=
 =?us-ascii?Q?d48haA7FI/HczckN6x8W2IpGB/QjKRWsh0VrfFuN6EAV5zzp2VMjkEHvFHW8?=
 =?us-ascii?Q?xA6JI9swyr7aRiUx2Fniv1qeTdpjqL3JGHqnYnuu0EbVqRxCNFfZqv47dXjV?=
 =?us-ascii?Q?MgQZqOR+Eby+6zOYejqe4PyCMuUh4ZDvtA3ibSxymi/lCSxaveor/3Smd5zk?=
 =?us-ascii?Q?r5NVORK/O2Qfx8cS+mYioCziOdkmA72Z4SY8W19f0258XtluIoTJYdIAYn0E?=
 =?us-ascii?Q?rwyXFNfcITCEoH1NJLCs4KvA9gdzk6e/GrDPE1uRU3yaI/jwzC14ZXuykLOO?=
 =?us-ascii?Q?5FTUpjQBB0hi2mx/HboJN+ujHPsMOEeeClRwEOFxgRw/qA80qKdKLCOYmSiK?=
 =?us-ascii?Q?jTTHUBS2AqgCtg4KYT8Dd6ebNP82to51taVmG69gnR0G1oAMoNF8AVGG38S8?=
 =?us-ascii?Q?qYJULRftU1VLniIXolMyglcOIHoWzBymK8DWfDvkq66NnwCPFeMUtvvgGW2A?=
 =?us-ascii?Q?UOw7JWydQT4bFgbrFcFtT1JsKz1k0capCnawZTZuMitQ9cV3ObSFw2OLmq+P?=
 =?us-ascii?Q?PLCe1GIf10c6Qt8UpLBQs6fch7SV4dapyBYoiCEPmMFU1xNVYlty6kPThZcU?=
 =?us-ascii?Q?KywpWuj/3Qsril7wIGVJVhIyRFnbeIcc+jJIra9Y/yq/wxGo89QoS9P7Yjpp?=
 =?us-ascii?Q?Ps+pqSbotk4meFtEq22Q0GTL49s7jXpPOjUsQnLkRN/Jof2xMcZBkw5YasxI?=
 =?us-ascii?Q?yo7GiiwMYYQKZ+yYaeh/MtfYa8b/GC+TtzoWqDGe9h9AknJCCx7gESuolysj?=
 =?us-ascii?Q?RWcC69cmX0w5sVJ6gVGIlgmTSdGyIngQpuQWMCUjnuFCTNF0nD3HdGTwunX3?=
 =?us-ascii?Q?LUp8l4TBb9jex/1iEY8aeS+9JSlhgSFAuZx1xtVN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed03980-2850-4daa-b216-08dbe74b16b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:29.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SQZ4SpQdAymEXqlFXSm4vc2WPSS3Q6heDXZl5TwKJZqPBEuO2C/+5Tpb3s3MoLiTg07z4bQ2SwrxVJYRKLUkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

This patch uses pm_nl_get_pernet_from_msk() to get the pernet id_bitmap
instead of using a local bitmap when appending a new local address into
the userspace PM local address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..b3a606a5e182 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -28,7 +28,7 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
-	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
@@ -36,8 +36,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bool id_match = false;
 	int ret = -EINVAL;
 
-	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
-
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
@@ -50,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		} else if (addr_match || id_match) {
 			break;
 		}
-		__set_bit(e->addr.id, id_bitmap);
 	}
 
 	if (!match && !addr_match && !id_match) {
@@ -65,9 +62,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 		*e = *entry;
 		if (!e->addr.id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
+			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
+		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.35.3

