Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40E17C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HShUH5M+rEZrliTfR829FjAFExsFWNQqQmvdRmRiVBWiaf/1bpm0UhswOwVbDWbeHPsY8SNZ1He+vLkkiZAjzsCMat3B/t/cdd/lPkvWCh6TrQJG0ncTvOtrl3/Hln51LyCSkZnC16i+1BCbXgKeqcFhUinjeg1dMuMQ0snPHtpd8W9ck1HPi7i5zYsvtzUjYBWcNz7uorADaJ9GOhSCjlQMil+W02zaZBMf1W/7lQb98vy1jOMEW6tRjkllm/iGDa9LEfCUg+v5yLm2dbRAVZiw7XiL0jePnHe5XHPUcz76FSZDRYAu92bYW8Lij3mY3OR0/b8cZ/ioUuqLriuLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q3Pb5hhORrKYruuZclE54GgXOTu3VlffPTcDcOMQhQ=;
 b=i2oxYlOs30vCm+BlgOvYSapg/Q9swbj/qac7GwLwKsatKiUD8grFPLWaFwMJj83XcLbj24bdG04WEl9kQgBIVANFijvXbFVypdHM2Fqo3lAgztp5duhpUxCmdiAk93xbgfuTLI3XmUaH1LNPWNsBC5Zu2FjiHu7qIXBs4ZjGNaET4gtLXMOTchSRZewFrpWm9cgBMr792xHSxMS+GxidT63dVL+uWfU43OCw+3SiMv3gZ+W1jcJol+d4trMJMhWODu4AGExxSUEak8h4ZkWnh+VzhFZRjhMrDL1tmj56dbge7WL6DW/OEFVtU+hXxIg/Lft1YYxV/q2qCZP8MvCuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q3Pb5hhORrKYruuZclE54GgXOTu3VlffPTcDcOMQhQ=;
 b=RLzrDMd9xkrzYJmc79QxVsIhCZ2XbkevEuTu3bD4Vk9wS93H3eNCf/uGwyhudRd5RHujrwWaj1fLs/nKf5/3TS5eYrtEef7gg4k+Qme7T7SDXDHbE/tCfb/XCuopjQKNULpA6Gopkf3/8f7+rRTqQ8pvun1wSSVAdhCoN6D9uVX0cUh4n0dKVqbOeVnemCirSPai9GGxFPJOYRwm/hMy3RM9gbUmNS4s4qWVX7da4BEW9EgAK3UsQifQuc4M0TQ28yt3rjgM9WGg9uTBhEWIv+6h8M9O8EGNDDOIQph7doZgKCjWRh3UurkjMZLijBu8waQnGt61u6KYkvBcG4OL1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:01:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:01:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/7] mptcp: update userspace pm subflows
Date: Tue, 14 Mar 2023 11:01:44 +0800
Message-Id: <1c7f66a91369bf0a17dbfcd487cb88c774aea42e.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd5d50f-510b-490b-4e06-08db24385a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QvQeKjpY7Ozam+dhirVRJ8Gy12GeDnzEIlTsaJZ3OoD+/Qjjb+hn6+1esQzYNM6kgLt69m9AyIuHClPYM5Nk2pPbkuIyCxZtv7yRGW6alpUkTqQbXC2yV4pQzlUNq5WFqiOHt0d88otJYraQf8Ct4vNQ3LjN4/IB+Unh/rLn9e5MuF5ZLK/JDAGMuEoOxchefg6x8s1PAAaCDKnSSWlcJZCWpeERxYExn0EWZyvDmBt2ssEIcHOTz8DsbffeIL0bhRPprrzfVYjSNB6XTNx9yVU6hS2AEXGTsk2u8Mgt0Vakhu6EzyKMVJkAiyPagJNSTcmKVkrjDQoInNrMiDrLQPKw/631+/yKewKdkSCxBBDRDX2HirasmQpxHRmEcYL/nQv93oXDxo7ADsXmUV0mqTWKxiUvVQ+b9uIAQwPMS8GYuqm8nPLSYbZe4iURFRJsUnpEt9vggHNBtEkREsZW731bvh5E9WM0wisnJpp4NzWhySZs9FA1jZ872ckiv/bqOxvg4t20ZR2OdVk7v3akJBF2FLTlrxA9D2FQ7MZbNIes+5X4nwUqvFiv6yRsdWPiyEc+0B4ZNihcGgqiKjA5G+LS+wmmuS9TatbYW+DQ9uRE631UD6mjIUjaBr/+fA02py/09NqGwTt5lwQRoDX2c44xkjUYG+txS7ETQ8rmDwIttewFDbN/Ut1auR9DQQgD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(83380400001)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(15650500001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ek3K+OoLFVYbgyR05IukgXsyp7EIYyzqpamduwBA9dgzy0iQXAGdb4HLYl/t?=
 =?us-ascii?Q?XZriqvoUNNAa4Bw4NkT2CpyimK85nluDZsuIzRJcPBugNxXhkSf51j7hWYZG?=
 =?us-ascii?Q?SjIWbZa7i1F+BkXwmaInzvURfeATFYijyFmqr6O7jxO2fJzrudtfcy5aApXL?=
 =?us-ascii?Q?ebofrgOvHutOB8FSwlU2hcsuUhl2BkAFrkzumY91/dvgYwTxQnWp+4D8VR3Q?=
 =?us-ascii?Q?E0Woubb9xDgxpJqM+uwu5jM2xWfAh9bhchpj+7aY2YJxfYUiyXlYZA+xtDdE?=
 =?us-ascii?Q?Vv1NgRTR19yClrrmlXthbKX3dEaWtXmFfDQLJfSQEbnrskosba3T6YU7JsVH?=
 =?us-ascii?Q?bQKdIOx4/puOzioeB2pomtpcVjUdW5IhIAXn3ZfopgpaRsr7QAwZyORxXRVR?=
 =?us-ascii?Q?XhgOAJroPmu9Pw+lFsD6aqTYXf229KoI3hJ28Dr4RGsRssmPLFcYbMUKE7EB?=
 =?us-ascii?Q?Uc7YpSwz3fUJ70gyjCjWaYoMboWr3En4Bz6ldyjvzosC0irrO1oMVtP5TSUz?=
 =?us-ascii?Q?CHfAfEBxCpcXmY/mRqPZnngo8zPTKkWOPqfXSLF4xRP84yQlZB+AEwQCf3BW?=
 =?us-ascii?Q?YbkmQKrWjF2Mq7ZZEzf9tcOrjY7ATpqfWEaWNITCo84rL5uB6TnlmdgeyOq2?=
 =?us-ascii?Q?YPnvG/UKMvGw0uAyd/ct4uMZ2pDqWOii9AxiE+YO2RmuQjNLep1XO+0cCU06?=
 =?us-ascii?Q?aJxdYP8Ko5zb38Yi5E2ZoMdTQS8+4zyldRdEb1XoPJjB7PHSiep7JpUgy/Nr?=
 =?us-ascii?Q?FwtA8pAMr4QlPC08pnEzXLELTiswQbHlpAg8ds4AUOyuy3cYJfOAliV/HYIJ?=
 =?us-ascii?Q?XWwFtfgkbbFXkOE0v4VRIYjqi7vBGSbmQEsBTaKYeunsr7v4JbX8YkH7nLD7?=
 =?us-ascii?Q?gh9vpIBq9rR6ttJPM4SaQmgsZAtJUwVeViGAEMTqiuqt0u8qF/P2o70BTI9K?=
 =?us-ascii?Q?FZgXlmjRXL6AwAfCrr3yBdBLXgP0McC+MC89Tjs5s1ScbfPiy+He+XNmBOKm?=
 =?us-ascii?Q?8C0xuUVFeuI4QBR2+ebPjtG9gx46Xo61jlgRN72qXbXTXH9vqUBH5kJlBkRY?=
 =?us-ascii?Q?41mQZNTPaKJk/iUr9++UxTfJvJ3doI1nFNsK+UT1m8oneOuz5FZfvuthnlW3?=
 =?us-ascii?Q?019HoII71+1I8VA9CHwl2vwpZ+t5eC5DNAdodkATy9xPHn5YdOGosqxNKmVA?=
 =?us-ascii?Q?PXezCrTUZE/RfXgdrqHWGwjhj3AhQCzs7iFjJRZTZ/F7GR0Si4SIM2LkzBjg?=
 =?us-ascii?Q?YfXYFAjWe/acxzIBXawY5W7bgTGvi2ZjNPO0G9jEsb0u3kMnesBiL5IaLyrS?=
 =?us-ascii?Q?+QuTgsYGpaVN2pPRIRLSJYS7TMrJI+EBZKK6bagKcvP1z5a0HFPNLBxB830o?=
 =?us-ascii?Q?HKUWI8YS/aFPFXNJObFOqMlNW2d9mm+Z45KhLCZYplFJU6IuE4c1gLax3Bzo?=
 =?us-ascii?Q?LLjYJaQjySXNYNwuAj0Mygc/vr4TMoEq7ZNxFI891InEiEMPkn+TEZaDjxhw?=
 =?us-ascii?Q?yvkxzCsuYK1b6D4/960SEoIqTBgTvOWs8rHLg6gFesgYlH6MRmsjcscwflBY?=
 =?us-ascii?Q?XXfdPQYkodxmYcjmG1B+AKK7vPek/LLBTMBqObtuKXksr1Y7WSnE/znJVeG1?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd5d50f-510b-490b-4e06-08db24385a3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:01:05.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pVkdRzUSzAoj5YCO+jGi9Fq7empOzMRv/8lWh32vnhyraRSv2b6lmkRKXiBuJ8ZzjfJExVLseFCPWFwnTIEnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

Increase pm subflows counter on both server side and client side when
userspace pm creates a new subflow, and decrease the counter when it
closes a subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           | 21 +++++++++++++++++----
 net/mptcp/pm_userspace.c |  1 +
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 4ed4d29d9c11..bb01f15d8e0a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
 	unsigned int subflows_max;
 	int ret = 0;
 
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_active(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		if (mptcp_userspace_pm_active(msk)) {
+			spin_lock_bh(&pm->lock);
+			pm->subflows++;
+			spin_unlock_bh(&pm->lock);
+			return true;
+		}
+		return false;
+	}
 
 	subflows_max = mptcp_pm_get_subflows_max(msk);
 
@@ -181,8 +188,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
 	struct mptcp_pm_data *pm = &msk->pm;
 	bool update_subflows;
 
-	update_subflows = (subflow->request_join || subflow->mp_join) &&
-			  mptcp_pm_is_kernel(msk);
+	if (mptcp_pm_is_userspace(msk)) {
+		spin_lock_bh(&pm->lock);
+		pm->subflows--;
+		spin_unlock_bh(&pm->lock);
+		return;
+	}
+
+	update_subflows = (subflow->request_join || subflow->mp_join);
 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
 		return;
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 1e5c2753c4ea..a2fce8486d60 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -310,6 +310,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 
 	spin_lock_bh(&msk->pm.lock);
 	msk->pm.local_addr_used++;
+	msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
 
 	lock_sock(sk);
-- 
2.35.3

