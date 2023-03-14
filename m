Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF4D17C6
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 03:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcRceOBLBsV69y3MKRybEGBhZAgyjlCSH1gIrrsxiCDlMF4r2NWjyBy6DCyXu8stWMUa+EwY1YqrxglGoXTRjgqTTnZWJCjJhQzWKWI+pYXeuwg0wC+NiTCy0jmE6ROIa7t2dtKWaIPCSaxOxeFLSy7Or6LSdG+9IlM0FccTNvqDYyhQs3jnTESTa1jfQDkCJpPjpE5K57QQgxqlgXvE0CmRMXUM7fhgsXscSqDGMCR4DQVNaJdsENqyxbhc7QbNn1e8ubNX3Dy/yvW1YbsXebUJXqUcdkq9JQZEpdVGQ43x+1VmMU8OJa/W4OzsQxImo6PEnV+/MAOtr08Ej3VrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLK4g1Wuo7j3ByCTZUM2TSNz+NB73vV1gcs4ndkluo0=;
 b=iXMfFb764wwOGlIGHkSJV5gFeoFDMZ0iC3UCa9SoxiJHEmxRF6U7grERgXDkvjeD2Ux5gVZs34epaknDY3j7VN63I6fSRgdxXRkjNKT7Igm5zVrhvbouU/ccc0G6Q1htmW+pW7yaXJlotX5fj7hfBOedK4I/HHeir6kV7gJwLanwOHo3DeoRdsT66aOU8Hc8CHDOx48af4r1zjpw79l0bJEzFk6AnS7I1Z+0SZfBfPoeEMycRtkniAeTMdVN4LLfkxweg8WshLNh7AX9m+sYBudckMHwpAh2TuJ/NZeSOJfnlw6nfO9+V3bTT3fovbHuQoCIlgd0m7aqWEkOWfBi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLK4g1Wuo7j3ByCTZUM2TSNz+NB73vV1gcs4ndkluo0=;
 b=ZD03/QHwocmj/3x5haXevpb9KFAJmUSeHEp5T5insZWZpKHS1F5TXVGvS0ih2yQhi6Xw6IRkvqmeNXT4Q42/+FvHDqDMMKWB2gY50FGaZqfVEHKPACgAhhFPq1TbH7uhZeypsIHM6JZeJBbCJqDjX/q6E0e5sfweif4wtHbEfJyt308EHRjLDpB6g5XDwnw/BovHMT0fUhmngMnuR8uNNaN4I0jufd1XkLuNyHmjO8I5ygHvOs39u103vC7yxoVWS5QKu1wuI9rbnwAtQzKmJe363ZzR9epsdQzkt5WGWVxKLfPwwApdU7ZeSUuSLuFNOndaNdKRXo6lOwg3psq5Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 03:00:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 03:00:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/7] mptcp: increase userspace pm add_addr_signaled
Date: Tue, 14 Mar 2023 11:01:43 +0800
Message-Id: <d47056db89b6fa8d809718b98d0f65497f117229.1678762832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678762832.git.geliang.tang@suse.com>
References: <cover.1678762832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: bc745077-d89b-4c87-289a-08db2438556e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UN/HtVL0SWeCwx5sEhYGQXAOjz44AJriX3auHH/jAca66H5qWq6TYRmI06SN9tz2vzbn5TZPi6sOD+PGpn/ot0JrY73TQEi5nxDlGZEFtlihyWtIrOj+RZmfIIUdqTy7/XwGB8jgHRuOV8rDWNgVHJynA7Ezzy+sr4g/X0ItiOZ/uaZw+AgcGYM6ZLi7/6fa1oSZlf+NkpV8nh1WQqiCIky7Mz5+M5VyGfyqIVXbh0xHAYEkwyAPa1/ojAQC3DIYcvHcW1gTcRtkWBZZKpYg27VaHnMC9Sowe6H/7YGwMseoHI2dyw5bRdOCvEVVWWp7fxTn63Shhjgf0PkAx9l2VPvgHNH4vR6WwIPF+tLZpwmuj6vJR06KcwE4/ywflPWHVc0LJ52GSRBhNSN60VH0j33/Ll9DoACqm8ZUfKEH+jmHhfi9ECyJ3GCy9drYObbhpFSIg7smuEV6xdHt/NTIMr0YQ0BO2+94soO5rYWK5J+YlCOatGlbWwy7y5CDkolmYWM5gAwUYx6my9ySPD/KwWebI7hhR5syQA7LkMeqjBIBNCY1j6qPNxvZeXSwPNW7GisT5MaP4Co205lyyq7UJ4dDdb/FkKAyzG0WPDiZdf4K306j1f/ZtN6XvTsCK0ZPNfwJJfRvJGe50A4oTf7P83FxqzT7l/oJTHzKgf/2P7AJCUJ4FjKSQXjJhWdb/gAN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(36756003)(44832011)(5660300002)(4744005)(83380400001)(186003)(478600001)(6666004)(107886003)(6506007)(6486002)(6512007)(26005)(2616005)(6916009)(4326008)(66946007)(8936002)(8676002)(66556008)(66476007)(41300700001)(316002)(86362001)(38100700002)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7yJLT61HBQ34MeXLzxBIuo/96ZgdN4g5ifC5kmLfGvWO0DqPTPdV0Ca66Wht?=
 =?us-ascii?Q?/K7eV8KysX9EB/B7RFnI9NE8kstBWh22mNm08ngCYkYgZ40j1rK1jYSfN9rF?=
 =?us-ascii?Q?kHLPqx5MVKXw+yySf/Ky0A6ui2qdivFboISHVKKpmc3clVvIxLZiQyt0tQEh?=
 =?us-ascii?Q?OVSfDtQqwFSVMToix8HGb19SOLrwlvEe9JDIbO6QA261WxVj7KluiQTCX+8Y?=
 =?us-ascii?Q?jyFij2cKVhJ6YxOmvGTz4lVwBPUlykHnaZ7W0JDsSR6fsz1JdKWOU9/a0imN?=
 =?us-ascii?Q?jcskaQsznb6/tfgcdQ5Hlach74JMCTj3KRTecRFV4530vSMdh3bcewgeQEdP?=
 =?us-ascii?Q?ZBh5D4Ou74EZL+ssd8T/XzWvPyKSBOYVI9B6U4eWuLshtKUm0lqcERGAFAnB?=
 =?us-ascii?Q?LhIoqwlhkhqeFeokfBITEM0DNs8Ixbk8o75UAj0uqnwStBMzUhKMMvwfk0NQ?=
 =?us-ascii?Q?/+wwrbN/tSGeBdVbeOaJPCvockWbN+5KQc5X1InQO1kYV92d7y4lYPbHUA10?=
 =?us-ascii?Q?IJYc38dUB0NNSrbl93EadGuuJnMV2my1WANQyDASyBnogYwPgUtovBkPtT8E?=
 =?us-ascii?Q?TTQfwzkOy9E7GPq1nccS/pzc9BXSShpPIi9POpYq4Mlzt4JKA9tbQqdCsyVb?=
 =?us-ascii?Q?ciqoD2kRKJn5rA+AyHIQDSkUdpEKFbcSPqKBUzjjAe/17VB6kgs4jVl2L5h1?=
 =?us-ascii?Q?c7Met6m1EYy9do6Kz7aMrefivAPcnNLFi91psTZ4AaVnh8ZSaqEfX4v4GJZ9?=
 =?us-ascii?Q?lsmxP2WGjYXOQvlLrI9SBwYEXJ6REQ8lZJOgdU/Zy/KPcDRwm+vU2/sw0Ie9?=
 =?us-ascii?Q?H4weV7UKzSm92TWfMmsYNYS1M6veqm0M1rytHPjCHAdVWzXqjTQNzrDy9rL+?=
 =?us-ascii?Q?nE6UyaIt4YtBDnQAQRuKwlXInn+elR6cwWHR32Se2nolQD8iUJ0bwWAeXUYA?=
 =?us-ascii?Q?1qIzMei8sFiDMeYQo72P9xnuRbu2mOO/IlTcd41FMCfRU+Frv0ECWo/+PdIc?=
 =?us-ascii?Q?0rHwdpepjLqKnnpWGP6VZpepBKsQlEPBWzKyvh+N8ix/0nSQmcIWrOwNsc8G?=
 =?us-ascii?Q?P7FfBCO7APpZeIaT7QvGVyj/oEsu7VaJOFpec4r1XpNGKyHq5SQ1uFVh3vxJ?=
 =?us-ascii?Q?rNZoLVys7IyDx0abQMud6llrnXd1O6YhlbtCcDzH7+jXNt266PEwgHPo5iyE?=
 =?us-ascii?Q?VR6jMcp6jFDaek2dyS3+HUckkKY9sk0btI5wb6V3eU+ZIZD/IXTPc07cOSWc?=
 =?us-ascii?Q?mss58kCsKS9kIJOVgS4wCCipmecM8PkUnVm1Ml799OKwlbUBld/4ZwwA1wpb?=
 =?us-ascii?Q?0+O0oMh9yZz79NG+OrBIZx0ftegTS6ki7V8frp+T4UEqAL6EzUS9OxfCwgeE?=
 =?us-ascii?Q?Ic5ewnmFUOKC0cphgSym4HnhiajWZPZaTGazU0G6OjF8+k/f1f1n+L7iltQk?=
 =?us-ascii?Q?X9eaaARyBivDjf7yVBs8kc8EJZNTlCLPHKdwyPBXKUuGuquyIYINMCwPtndT?=
 =?us-ascii?Q?zOARN3tV0whtcGXVNXzB+jMsLF+mPQPI2xUX01rfKGAi8AvJL/3EmhcaXxT+?=
 =?us-ascii?Q?sxP3QNjDImTNk5b9kem5C3FN111CX3Nld7Nl7CEklvkjAe/1vNdESr6AJ4Zp?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc745077-d89b-4c87-289a-08db2438556e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 03:00:57.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gtpeAymjWbQ4dHL4vgBqXKf57D5LazEcAeEmWdskAQdoCi4x/gzL4X2JRkaBXpfe+wJOIbGpW2ImIMeO0dMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
userspace address is announced by userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ebadfafaa203..1e5c2753c4ea 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -170,6 +170,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
+		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 	}
-- 
2.35.3

