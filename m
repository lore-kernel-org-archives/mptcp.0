Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E9B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bxQbmH4C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2DxkhgBEYlcSDukjlvgX+Q94yywlc4IoqgIkAFHRwMMZNZY90UVRIG1JqKJ79qdRj7B+2C5BadIBPu0r+bhOlLNILeS/VRYbdu+jxRB4JEV8gF3cp9Ak8vrcjQRFcykDlPMGXZ0USg51M44NSdhvXXqgmQA6zX5aHLMBVnbGudmHeMJtWvLyXeLdtKcplRHaOAq0ql4V5T/NoscdEMsHnjQepajfXbfFthiTy/rye2fZe3azBjTzDfwePXj4hw+Wy4DwvVVSr6M5lr2I9b/FHSEqmzamx1tpdpVRRohtJ/1ljTNHTxzYsK5vfXvU2v2gwbVocOvenQUYc2X1acdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzsmJHlwCCxViZFqp0VmZtdOuet9mlYBbBdmu9RMyHk=;
 b=NQUd66Sf5PfQB90FVbScLPMwGU7tAGrwu0kePhv2ruD8qT29Ql+GfZ1iCKPr/kz9z+xIujoZiysRtIqVjlQNod9euvPXtKK2KyckSP+AE0efe7C4y9PT/Mhlswa0dFJkMkFzNQ8R95Kxaiw489+y45cClidegg40JPP9ssU9E/SbctwdQ+q1QviXsDdoBiRu2Xb0YmBo1d5iowRQDVMWaMCfNZcL0HbPV8ErkNAv+G5gmos5bbNKxF4KkbFAxInl+aqyohaJvTqEvy/pz0N6phWH9xZZk5Osbqtb0kprtR/nlDWCwCw2uVhWfAKoUOzOVVexwypFLd94+doPJBu9Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzsmJHlwCCxViZFqp0VmZtdOuet9mlYBbBdmu9RMyHk=;
 b=bxQbmH4CCemq0m+JUOh/82uZdS18fTLC+Pln72OJaFf5Xs+jXNIoKMKZnyhe14bhjeVP74Qr6U5epwHrYAYrbIiG7/VdUHUg5G1eEZlMqH3lYzwQoAONm7Ja5lYO8Zyd4jqltYpflaOAi7uppUihKhHbW6K5yJcoEeWcoHvOmzhYlX5P3pR+vaiQOC5C1gescD1PvNEuSgluBAq+QK3jHvQ7iIPS0kqBapxtmwznPThQd5vXRYPWrkAoDx6Oa7ZL4HtKW2iZ0NClqfuGjQUFSkWaaOmYXCfMtKfyOCARHgNP98m9QLJiLcZn0Z6ksBAqT/f17s865Y33ljLBerwHTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v10 14/26] mptcp: check addrs list in userspace_pm_get_local_id
Date: Fri, 17 Nov 2023 16:56:07 +0800
Message-Id: <cfb060cd3e8f8b50691f9385f6c72562bc237c20.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d3d9a6-3b85-45dc-231f-08dbe74b4528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q3bbv+s/DXljhixJkGM60Dr7MRnMU7WeFUdaHVBsGJaWXIurGuxDVDLotH3mWE6z/6GVvaHCz128eRQXAt9u2qDtSx3/px32TBqBgGTVwL2U8IZPU7MtyVnQoh2zmuAvG8/WlYTS4FUVXr5IN6jFDDlZkF6jiNfxoYZPazuhR5nMqutAkXbRU6asUgKwEgtVk9OQNwXNmT+jmmy13uDNU+vfuv7tGDINyytYlaOWHuWDsnJVlrokLXzRLUuctLcP01L0WMf8DkG0kUbsGlVarDs5wR3uhNIaDp1DLteNpmCs/2LDD8MOW43JMHhT9e3EDbRf+Z4gcCLZJOzdPd92brqxpudGv20abB/cHgUwtDwPNZKu3iMnr0QyAEC9ZWWmtjxFb+pXbC/ssPZBCmUyMs+/+CI+fo+zuVBGBy3h8fJtbyod0jTLbyqQOl8SGdr9Bci5OjtLbjJR5k1NYbbl2qmmxINlhI0dZf7WxXjnCLPdT0CiswmpxPQIebmHTb+90Z37dU+5Vy7bG7wno2J4s6IGSS/r5uN8TzABFmtjcKnhrMFu9G4rnJK73Fs5SKy6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a5UYFxikls81QtA7SuWWmQFeRHieG5SvDdunnmT8QDok2QYyYblshg4lykUI?=
 =?us-ascii?Q?seYbxoT3oQuARUZ80URsBwZhg/sAERj8Pq4fTWePH1699jTS3o5cFDhAYttF?=
 =?us-ascii?Q?WTmGGxOcZnKtPS2X3X0tsRAwzYdiF2Ao6Y52jvZOQN6WILjQV5bElPTg09Uo?=
 =?us-ascii?Q?C3uRgo6gKK4N5WjZ8e6qLbcq3+351Kln67mEWYAVz4KapB7Z4jQFY7EITwvg?=
 =?us-ascii?Q?9c52XykHu73pqhPObS+No2zY1jvyzTb5IAZEaF+eNUbfPrLvPiSreIK4BIO+?=
 =?us-ascii?Q?yx3/6z9jah/3i+nQKaGzpyTDxw4v009iPQQZb7cLByZZyXHXSIMoIvB+wj2S?=
 =?us-ascii?Q?mhkQEtV0AOcpsFxsEEwV9UMn9xnA0Lzt38aEM/kGKeTfnV4U3KXBj1uj9lAz?=
 =?us-ascii?Q?qrOISmoszDBSktjKzkeCOA7277UWJt11S5sBXQzNc/qArfnPRmrknhyP9Y9b?=
 =?us-ascii?Q?G1bRRXSuy2iJfSUudkbL/f8rbByOTjCnm8SSs6LsN/jnj12QNiqrwm7ye8ae?=
 =?us-ascii?Q?31uqFMioraWG0OeuqI38Qi7veXuQY8YtTwtL2XywO8R61OKPN5MdD2XxSA+9?=
 =?us-ascii?Q?A1BleisHdGZTVdvzIXy3B7BKn1vHQ9jlM+Kvs3Hv3ibxqGRqbtOmyTbEGm1v?=
 =?us-ascii?Q?E0OIZaQEFf2vCXHusyovaINSR+x7UO2OImVJTX/DvFLuyvLop5pU12TVKn/K?=
 =?us-ascii?Q?peQZutajTSLhN6JlsoUTN/MEQk2mZtvPpxhmf133VtKdVXRkrStFA0REcjBl?=
 =?us-ascii?Q?FEXdRdCHhb12XV8sz2tb6tVfLSXOCC1Yi/+KBGRFKv2CpNpX2lDEiR/R5zNI?=
 =?us-ascii?Q?FQ7zxskX8Fyb/nqK2kNtyyLPEKWVUoVTvyGhjFAEvR8vkKOyM1lKD0mUU9PN?=
 =?us-ascii?Q?/y43lqmmzouqP1YpxJ8e3kgBFgu5Vx4fOLvWLt+BF8VqWmhs1nobS4TxZo7e?=
 =?us-ascii?Q?JJhTKPliN573P035Q1se2zSqQV4lm/vkVtl2RtNeJVuX93y369DKduD/ela7?=
 =?us-ascii?Q?zSayx74QeFwN2r45amzHSvUcAQWFvQKGHjybpwBiIPZRedPcebDBtsxywdyD?=
 =?us-ascii?Q?R7mDgRV3wLTZlSlMRCf/1GRvf7n69xD4Ld8cN6w1iAVJddbAJKfUaHwhB1c9?=
 =?us-ascii?Q?D4VT6DRcqhn6u2tFjcHCjNsMQcW95ei3w0MO523DV3MpOmwysYYLNeau8uGY?=
 =?us-ascii?Q?sDNR9E7lUWmf+Hc/YYzorDSdm/k/3iLpOSzIOWFY+VjHpdtMt0NrC3m+swux?=
 =?us-ascii?Q?SuW9Rc2l8nxuMycE9QaPalDB0pQiybThvrd02IpH1ktXO/LiXEs7cdeQptu7?=
 =?us-ascii?Q?CKumM7rWIkFxzJ0vyTFIhgejPnk8YuRScLNQNXK0uBAx+sfOJf5NdPhKXb6A?=
 =?us-ascii?Q?9/pOT+Qc650oSjNjXrinJKpzxpeRbJTMFrl5PQEGL5QPI+vJdq5Is4TzXdrD?=
 =?us-ascii?Q?JunlOUNmX6C9U3hUTtSPSbkoI04eaWaVXUpEd99k3fFP77RB3LxOb5wQlJTS?=
 =?us-ascii?Q?HHUOttSd0BFocgB1b8Hb7LN/R7F8unBZqDKodvHtHIqNRQwJBjcZaPwWouFh?=
 =?us-ascii?Q?02oWwTzLyaS1kCiNJGPxPQt1zpp0hLIPq4fyPZXtieAiOvBJN8DnB93PaawO?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d3d9a6-3b85-45dc-231f-08dbe74b4528
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:47.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzRwc6RiWuOdpSv0L174n9+UtGCWXHRwV8IMkvZx2WmqixIDNoi516g08sCy66ACfINjeiE/KCbSu+fvazNlyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

Before adding a new entry in mptcp_userspace_pm_get_local_id(), it's
better to check whether this address is already in userspace pm local
address list. If it's in the list, no need to add a new entry, just
return it's address ID and use this address.

Fixes: b20137012d9 ("mptcp: read attributes of addr entries managed by userspace PMs")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c9dc25fa8540..489bb0e61118 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -136,10 +136,21 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry new_entry;
+	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+			entry = e;
+			break;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+	if (entry)
+		return entry->addr.id;
+
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
 	new_entry.addr.id = 0;
-- 
2.35.3

