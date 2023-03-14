Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977972565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1oP8gNvhwZY8a9/0cyznaYZFt4HiZgI4MC5XfrdNscr34hMjvZ5PVrlWKpr6mNpX3C5LSQjOwIPCT9CidYmegwj1Y4tOR0bsvHuJIaDBJeVO6GA/XDAImOLCUrbA4L4rGqKV0bU4nW/meao9V5sEn4TK7BTdzzMqGnCPYYbRtbScC+wbhQYjKsYvciPnrMcKkZDAMgBJNUCmv6uKs0Wng3jp7+Rz8kRNgF7QIrlXEYg7ZJNeP1gCGyUQi0BXaszj1Un+2S/S9hfUVGbz0+KmammY59njapvz+2VNh1b6QUnfoBeGC2jUZIlpEQDrtptgjtcw+02vhlITz3mdBYf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ew2h5gGi0lr+uyGAwExHNoaYC8uKjoobDnt5qkRue2w=;
 b=Ucuqrt/lWs9ogBIBy5TsVbJA04weLoTT+lZSMSGqpMzg96zqgkoADspZvUwoWyHvdaVgHtehESN+uL3WG32pLnbPWfsGvbv2hg1C/wxizDwcHJady90z3wxNdqLhSNm3+qrhkg0EeIh0aZ3mIgQ5LUp5Wy09xlE7EYi9mOoSqsfvweytZVJsA8Eli3xXagqbk/UYEx2fqVYOuZFDmDiVYqRznAfhXmIMldGyASbe5GCC5USNX0mn4VehkLiVqk5UGegNjBzPX++rgsHwcdg9cvNaqRbyQY4YtJozRn+2bdPwVAMIvc36jagSUkS3/WaM4/I5ELV2tA/J5+h82KhwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew2h5gGi0lr+uyGAwExHNoaYC8uKjoobDnt5qkRue2w=;
 b=X5aoUmPOJiHWKz0mHyKSAKRpKa+mx6TkUkTWobNh5yaYhqYDgV1l/H+Aj/VHJAj2SVlUvovOSHbDuNULTQOuZTs/N5oMX6R3znGXrhwWBnh0/Ag4hP5UWsfWdFh94Thy9USNskBEvsLsDgB6JofSbyP5VRPa3JzrCKzxBobVmpOPCtL3nuf9n49qNaCdhl6MJzsXyIOmJQCdiGwl7ZLMRKDiaSFSIAYG6uYZATadP/HwQbeVIfZ6WPEOblhpLg5i1z7uMFGPaEvElJHYwL5SVIUsiiuKQEQJBycRBbAifvC2qFffSqnCGy86vkcE0yNHNWVXEpKD7/0e9L4lDdKZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:30:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:30:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/7] mptcp: close remote subflow when destroying it
Date: Tue, 14 Mar 2023 15:31:40 +0800
Message-Id: <d47a06abb5dae1f333a496183da5ba3e51e5a98e.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0042.jpnprd01.prod.outlook.com
 (2603:1096:404:28::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d578d46-e27c-40d2-bdca-08db245e0cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gzgKiybslc+jBT+Km5lfD8qt7zM4EWmBMZqhqIXSbqq43NoAPTAtEDLA9dBgqBdU3MR6a7fw+qtl1GZthNhfQgVCnfZFdorcZofg6mYWpoQ8AGf0YPsGGjssNtHZN6N3Ix/KgARTxfKpL/tYqVfFmK/d89Xf1I6/IBGvERaEIu5zOr3eY/XPiwHZRMFtycgVS8n6PzB/K5+0VrGjHCc8nnoCkhxN78FFcB5kZnHSUZ9paIzuxeA5ZWJa4MDZ66JX4/fIW8eviibsTh/q0A2pPuG1jVb+XgevTh8g1bHQoop9dpkBa7+esvzzmZUgo8yn4G/HVNVg+ekMH6X33ZxrDQNxlWS8WvVCxns2I9b2rZLOayto7X20IeGKRO22r0Z1j3+wlUX1j2ZCeIKR8swO1zDCOygZ5CPmKANXBaX9O+FwDEwr3xjL/VuNO8xVSgHUVKR3HaiMs4zNkCCvqhKZZm95pTVpbwWISJejeGyG2LoTbITfy9hv6yz9XKOldpox3ICWOhD1TaGbntRXMPplmiYAg4P1808FXjz/u+j1poZa15Kx/xCuQulu9Rqy8uWl5kP1xtLPFcPlZnuhuIeMfZnOMIt42fI65Gu/pRfuTlqjnz5V9LMXHAzRsk9lq5GY4lqo+aFEuB4bk0Y/bLEDoZxSzi/6ywJHkMXuhZLw3fAi9FdkODFGApLpcMtf1f+N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(6506007)(6512007)(86362001)(6666004)(107886003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GU/Mk2TvbeBTgqj4Q7cl1kcbLO83JAz3gGnW2he1J0O6CkrCPXDFTLx6veov?=
 =?us-ascii?Q?xy5DSGTWcXqJwjwvqZaGCvLQNRTIJwxd8fNK1rR1zhaX2+JATaPhQVKXkfxY?=
 =?us-ascii?Q?XE/zXpU3PAkX0T4DmPiMtg+XBI1qMnRNF3MQA8ZZB9Md1CDFPVC0SI7Obcm7?=
 =?us-ascii?Q?jbQVxZ5Ao9WPKwzzm8k73XzlOBYlqdW0k6k6S8tW4ak1K90TB+5l/j4z28XS?=
 =?us-ascii?Q?YtCx27mL1kO+i+++bPzuA1DUxZme3GPowmo3XrgSuIHLbytda2yc6Z8iOmMb?=
 =?us-ascii?Q?SjgD9IyhEXT3lAPchwwNUaapU4rmYq2jYLQC5RzC+XeqvkBFhiS0xmMo7TOu?=
 =?us-ascii?Q?y8JQO21SBchC7BXhV/32aOdwc6vHB8NXAdQ+lexHbpxMxBXDuOLlfS6eZfW/?=
 =?us-ascii?Q?ZluvElevz0sOSMpT98KqF9culY8oFOPsP8j46/IrPdePQj/DFM7A7ZGa5Xln?=
 =?us-ascii?Q?IcZo/VolweiTy3Jo779V13cz6mWOpOaRnF1VK927EhrjxfmmjwZl6kJNrbIw?=
 =?us-ascii?Q?dT3c+Ublf8cKGxkjXA11q+qvuCmxjr9n6HKOilMCCNob0ow5H2N5ye5bO4lF?=
 =?us-ascii?Q?ppwFr0/1V0m8KFajjqKR+cCYxUfIM1i4CQJiqMotNDH9fJP7o27Kf8u+IT7g?=
 =?us-ascii?Q?6JP9wLKSgwr8jcZVjMfgwOg7HN8/6DS+o+EXkH9uRS+l+GxelCj1KQ6aj5Mr?=
 =?us-ascii?Q?rkVFrlChAt2F7jJu/v7Zcrbm55RTvaRG0a35TGv85k7VwBvXXzt5tHyaVsxm?=
 =?us-ascii?Q?WQ2Qa8TJ2NUOhuj2XcgoAl2I5FRGqIjXbG84b7HAfmJEpib2z/Nulmd5WdTk?=
 =?us-ascii?Q?S2302UGpCaVUFG2U3Um1jNANCJPrVE0xwD4Zcb3Ea9bIuFoHodfE+UfZR02U?=
 =?us-ascii?Q?+SrWMvIAj8zB8x5ohD76DtehrPiBN+vJN3Uw2fs6Ach9EQ63m7ga7UFzKqmr?=
 =?us-ascii?Q?2k9j2R5OwzyHUPUA00pRv3V3XqlYaT4qtg4yL7YQ57fhEY4nWBS1YoRzf8qd?=
 =?us-ascii?Q?+SXJJOmMX6pBbRN7qsA/t6PpK7zwANjlb+Um6iN+Pw93VJ1O5A56EU/Y7qTC?=
 =?us-ascii?Q?3F6F6aVM0/JXquNP8WxHhNN1wJ5baftnNi3gi8HuWg4rQCgPbm86h4GBKBhb?=
 =?us-ascii?Q?i4b0ALfiKaRNMQAO+ATSGm6k+K1/igjQiex8B2nIq5zUvr8Qemizze0MMqun?=
 =?us-ascii?Q?GopG/wUh16Y2r6FFELkdkvoUUSZafNzUpwLf5GkJyCMXyCZ0NEph/Mm1n6Mx?=
 =?us-ascii?Q?xrm0K1kRCn/av3D0sdmwvRbXRQCGkU4DoIbnP9AqwtlwfGAeUaany23Q/KQ2?=
 =?us-ascii?Q?4jCGyG7xeVRIqrTQ9T0P678GUtG1F/0SagZUgv6ZxosdLTqg1nTRw/Tm4D21?=
 =?us-ascii?Q?omjkB4kReKDuHJ2qyDQvH42L9kEz3fWCzFxSsroJmeEw4pyhjwlw2M8c7bkB?=
 =?us-ascii?Q?TyIYrzyOd52nhcuW4JzpIOK1tu6ol/RfUIo68H6tjOhKRXcm8awR9v626f53?=
 =?us-ascii?Q?hkqElhVqoMGfFNBwAuze85k25k6qp//QqMikQgsNPk8Va5OevjiPuGE9TF/l?=
 =?us-ascii?Q?Vd7rAYlVZzzPodFE4mylIKAuhCHsZmTOJXSje3oUTBJfuae0BOuyT2PaAsyR?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d578d46-e27c-40d2-bdca-08db245e0cf4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:30:56.8448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXlAuVy7NRW9/arAmexwydV50dKD930s5iYokcSo9vs8Re388/zix0nz5HEg/btbC8YqAqjvIfwj8NheiNV+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

Not only close the local subflow but also send RM_ADDR by invoking
mptcp_pm_remove_addr() to close the remote subflow when a subflow is
destroyed by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c                        | 16 ++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 49f41a040485..8b077564e394 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -429,6 +429,22 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
+		struct mptcp_pm_addr_entry *entry, *tmp;
+
+		spin_lock_bh(&msk->pm.lock);
+		list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+			if (mptcp_addresses_equal(&entry->addr, &addr_l, false)) {
+				struct mptcp_rm_list list = { .nr = 0 };
+
+				list.ids[list.nr++] = entry->addr.id;
+				mptcp_pm_remove_addr(msk, &list);
+				list_del_rcu(&entry->list);
+				kfree(entry);
+				msk->pm.local_addr_used--;
+				break;
+			}
+		}
+		spin_unlock_bh(&msk->pm.lock);
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fafd19ec7e1f..506120401abe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3123,7 +3123,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
 		chk_join_nr 1 1 1
-		chk_rm_nr 0 1
+		chk_rm_nr 1 1
 		kill_events_pids
 	fi
 }
-- 
2.35.3

