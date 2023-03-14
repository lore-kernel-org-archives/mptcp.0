Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2072.outbound.protection.outlook.com [40.107.15.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393622565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQjz+sRuxOGd04Xtb1gKP/KKimJiH9XLPG9VW/0y47nrHfJzA9ay96JXYAdPNZZu5rEMQesM2VntgCs0h80wan44EXDujo21cdSISuU6sVHmHpjAKnKmjVFNORBxoRNRDo9NVzY5R4L+ek/CRF8gJvrLAVRuPmMTtql0ZegyQKZDEYBLOHYWR1UdlVLSFa3mrtz9GEIWmVnRQI2BnSS5N0l8+qwNg92GOeTKhHbv8cI0udrOz6wapKtjOIM41MwJoH7aG9H7NsWIAqwfI1nqR4QqElbRwiY/r/vevBypIwJpkCoXKEdy7rKjjIRdI2ZKbIAMKG1VkJRfBFCvyiH9lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cEHu9sm6jyJ5EEeZTAYPrwYn5yftBFE7FFnVv0DsyE=;
 b=I66a071Jy/eeAnZUBtBZUiThJpuTClqcDor2k+jv/zDSmw1nhBpIfwk4hmpKEPBU+DHGs/jREofzqG7Y2wFQ3hxZ5wpBLAHtZa9gfncK7pE9CvPl9+d1gLjtATpTMY6brz1XreFa9OrTZvLJngNngdWK5E7Nb0QVi8jszO5WAo3qk/8CJNCciVoCHWRknspLlIqbfoFsweWpDYdyH4NWvZxyxwh5aYYAjX4rGkaJjCIduI2gRj8ry7MN+Qpv3USOOIHwgWnu8vyBuABAze8T5ylHbwKpSfvO6vWGRFtEoF0aUOHFqNygDKGmAN50JLD9Gfrd2nAu5EAiIIJOnj8EFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cEHu9sm6jyJ5EEeZTAYPrwYn5yftBFE7FFnVv0DsyE=;
 b=ZQYm/WR0fF383jzjFuSx90uGio5eEM1G6fxZJdP6pI8PE1NVH6fbekE4rFT8xjA/HB0BeRlVqOAkCxxSsHO/W3sZ6OEYsbimI/GzlQzxcbv4n5/tb5RQz81R0vnKSxGErAkdXfV5NZIDXP56/KYDIAVVWp3tjdzKZmtWcad4MKVD6X2nKhhvnAXsptWEcnpH4ffOlp+tQLHfRyGVwP06wx95FA7MPDfV4e7UySskyqPlHkWfVdBVv7k6UPiUFZR0g1x1NELohDqzPkxeVsEHvHF28BI3QW7OXzj+Ct7GQtRuLG9bdhTm+IXXl1ei/xbjn8g1642pyZ1cYgeNwSpOSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:31:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:31:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 6/7] mptcp: make userspace_pm_append_new_local_addr static
Date: Tue, 14 Mar 2023 15:31:43 +0800
Message-Id: <f873620d6ee0289528e9d8709a6a32c297df8767.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fba9ac3-4017-498f-9824-08db245e1f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T1LVi+UD9x0glk++ei8uqhzGewN+O2k4gMjP7oOGsJy4AL/VFPPV0xz/HAisG/qipobGPQlFc3+sfd+QhGyomQJnbbmE+Z61Q422gARlsIbbDv7Bp7LNk8LJad58IxMWumx7UJ/E37dsbcD+wAO56wUVgzmhKpZ1mWWqyEHtP7DxVzBkhXWxJz7jgiY93V9vsvdlWbtwWYVNjNdOKw15M6lUCCmDymdWaOHPFdfIdlFJEVU5kWSle/8VYGdPwK0l9dJLrBrPMfsnn4k1Eo81TAyBqwX6Co58Fav/xo9Oc6NMr8SBpd6CDzgIVAvy778SWHi4IT3uZXdVZKdQFztn6Ul5rwrX5gr71BO5xv34xER5FiNVBTxozGhsGrrdZqJ3ozPGKyhAZ6XiU+Nkzw4+pR2ugp/iUdC/1qdkwbfaIXg8I2v5VKyqi06dodxqoh7JKaLsW0dLQC3qFPlyfqccGSncpiDGNg7bDpAq6czmDSzkIxlSb3oXLdzr4F7iCMfI/dthfmWZwUwQXi06fUwf9VNmr1bztjzv9hkmbx3Vi2XomqsmYwsyXPhk4ae4H4wlwAI/C+3MvXABzgN2B6c4JKPBs0vCVgx7YL5w/P7pHyT09Z8K8iR/1P5yzsG0DYgi75DbFCw/SffsPAsJ/q98l+tJVUyT/dLr5AG+BQGRD1tWcgM87FJXUfSA6Ctt2Cyo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(6506007)(6512007)(86362001)(6666004)(107886003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(83380400001)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rzNC2hfcQiSUhtllXurbwqTubP8G7gr2FBO+hTpVyeUYOiJdRVuHHgyXcHG2?=
 =?us-ascii?Q?JlvsRbjgeqa1Hl60k/egmXznc4LS3siFDAvGnfkvvmw4gWGiqMMKigutiLYM?=
 =?us-ascii?Q?6ew+F/WjEnU8CVW+lLjHX7+r65tQeeRSkPCH+jR5pPq8hOSTwFHGms30s3oZ?=
 =?us-ascii?Q?U4U6dWUGF2MxMcFR33xoCttpakLPcJm5wzZm7u/X6uO3OfAV8c3BMf47GSbj?=
 =?us-ascii?Q?/FaInnKyUTWAfF8XW04JHxPUQrkDhbmbjP5IiUjOS7++FA7WfP4Gu6HCFI1f?=
 =?us-ascii?Q?QFxTv8fRoKoAz4/GYs5EETuinodTrXmciw2tsx+I0rrSxScakxllDAhUV3Br?=
 =?us-ascii?Q?BMSOTWgV4ToOPbEgyzidb0r6ieEqrt2toNRBFDPLgelVScP0VVt0J0I00lHG?=
 =?us-ascii?Q?pAb3zxtFcmVImpjBZ/a+AGsUabe8gNVFMXVzltBD+QGw5JROuqr7WERblBrU?=
 =?us-ascii?Q?hyhIPFyD3spvzMm+2SDcjhW2NCxFPsg2uG6LbYeNS4LfTQ/sSsZwgLh6kV9B?=
 =?us-ascii?Q?2cFopuiMmuZe6/VR5aj9uiXkD9QFBlSBWYtpMU5RgSpqeEA3kMv0m7oqUJIW?=
 =?us-ascii?Q?IsW+gubu8Y7LhAn2U0OtDf2OQDz0l9jeEXBqRGSgvdpzZkbDaflDxJnLhRV/?=
 =?us-ascii?Q?2788ogEN+sWb9rgndlWL1z02fslHu+eW7MfIEamOd2nUmIPCSiTGdk3ad8RZ?=
 =?us-ascii?Q?32vy+GjIDvgvb7cQCvoPOXdAsDx/DEK+RmTBCBgipC+uxTZvmhqql2whH/Rd?=
 =?us-ascii?Q?kyDTbmi2n32PzAnPoOAAZzcG264QdEcEmu56dfB8PQTyWpGm52g9SZTPPHuU?=
 =?us-ascii?Q?hEtiA/mbbR0ju3U42+7ZQw4NcYwrn0uWxD95XnLotUWgm97SwEO6/qRKieA/?=
 =?us-ascii?Q?XIUP+bhfKJyb1q5U+HcZA6K57CwcffV1uwvCO7N/ZgAzWzJ/vFv21dJ6yeMH?=
 =?us-ascii?Q?/B6Jjllbky0ugjbEWkTJKVYRmwkNqtEd/pj22Ameuz1Abf92wvtIUdCnyXAk?=
 =?us-ascii?Q?PJQabuTy0I9YFeieeIsCdCdFnznrC7eTQzXJ7YuPXRarUI1KABFh9lme950D?=
 =?us-ascii?Q?QGhEFJyXg/PHymmhWP4P7wbFxP2nmSgnTbfYtwTfWfid4sFhBsEKVxQun4rn?=
 =?us-ascii?Q?D9oK1BUhu8XY/6S51Zu5yuI41NOJnVyvdJo/S/AwB4oG6OaH9VPcbZoxANgA?=
 =?us-ascii?Q?rX++IEAbWSQ+NG/gLKoVd5eJUsL5zQgcmo0MjXF8IppZRZa1Q0IQA8i4aemF?=
 =?us-ascii?Q?QtclERwYV2qSx1/ge0GtfI5rT9HsWO4HxxHYgiB2r98k9R0sTbgJgpfgyXig?=
 =?us-ascii?Q?hUCTa11eFww1oSyBdFekPLfzOyxoYWFmtu+zaSCtwvh8rVLjMBZlJq5JIGwQ?=
 =?us-ascii?Q?xKJ7/yzfEPeCjGQdZ6hIWgSZ/DK5W66WWoDmt3a+VEFsM36Ms5hDRC3esCBn?=
 =?us-ascii?Q?7L+GnwDqj2Q4hD5P7jXtwIWYTQxBxLxI5mCxfn6O4w5u9mNEJ0V6dVMJwysF?=
 =?us-ascii?Q?5pyIwGqDXw8AP9o7o0d45LlLFFZRd+NZi2aORWtwYOY5tcTKNR6VY+EaS0uy?=
 =?us-ascii?Q?9ZACWCvE9I/UiftYRmlw3fbFHTHBt62SkAiFpO3KTjhD21lIRCZLBehjeKZv?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fba9ac3-4017-498f-9824-08db245e1f4f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:31:27.5455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOA/KtBXlRJ7aLW8HZJ8km9W1o79QndYTF7ivJqvbfDE4ZWdCZgqfz/MkKZ8yN9HTys9RqqoFgRbmghvCBj4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

mptcp_userspace_pm_append_new_local_addr is only used in pm_userspace.c,
so make it static.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 4 ++--
 net/mptcp/protocol.h     | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 465928c59917..2bda1a217709 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,8 +25,8 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry)
+static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
+						    struct mptcp_pm_addr_entry *entry)
 {
 	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 	struct mptcp_pm_addr_entry *match = NULL;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 46962a2581b4..421e587a4d62 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -849,8 +849,6 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
 void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
-int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-					     struct mptcp_pm_addr_entry *entry);
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info);
 int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info);
-- 
2.35.3

