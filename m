Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6034CD8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhasprsoKpw+fZmGqHs68CxxO1v8gtgyljgIB8Obw0PFohGErpRec8oINfbDRPJugFEIktDH4DcaB99WhQ2geDnVCjXm4L2g9GYIY2jg0P39+cvurlQ6Djm1to6Ru3nm8eJfR4j32jwDBGhGZuXM3eKRO/WFZItP38dKDaPlvDLCeGOXjQ7s9YtDk5WwrbwsF09t89udfaPdH+FAXDZbyW4XoK4o700NKclCtC5y4QNXiafAo+tMIkpru2ikZWArTL8a0AAAhOf66qxjDFZc25F5KeEEpc5ZpaAqgI66T8hP6ppVes/zyRxNi9L8CteEJ3fY3W18BrZSDsvolW+GZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Zjp9bt/yuNdQy6C1YPaMp+mCE4nkYPA2S0UrQedhZg=;
 b=igMXbUFCap3j7GZbeEWQz8BXMAGiCiygAKgvjPQWx8XIsFaJNpZuwzahqGJxQ6/mZu7375Sa6ywoPCOfUfXqWGXwmfHFmS6bVrua8Yyo0b4ewhkVbYx65T6aFxsgiN3bhGPZhYLceaaK97ffMDeRbrSJH/djetSyf1a6u1zutddQ2e13n9S6JfKJB/5NrbVzQlokmQQzbPbkjWki9td8iiKNUEW2ybhSDaVB3IRhdgbidtEu/7a6k2rqcmuqiTNx/tp2VqAFW5VLqsrEwPIecHWgWt0NueAvjvtv1i86F5gHs2pA67x6LcBofVZ4RCR5iAg3L5/l+zO/z4tF0jUksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Zjp9bt/yuNdQy6C1YPaMp+mCE4nkYPA2S0UrQedhZg=;
 b=l/+q2rc10fFRHTFPuRzwwU7zc9VsA4djtdBFrotRaE1F4CQCEXLrudE9x5qvUC8U8TlpXG4MiXR3zuui2AYBqt3+Mh4eGiZIuR6o3JMFFlw4nDJ1L+Kj9wnWj+Lvv+I5A51c1C0isQt15EAjpniEnWJgj3Yff7ZqHLtb+I/OgEyrtzmbXrPdWFiLiEr9XBVe60fN+IoR340byrolRFyctRfnMYWoR6isYnJGvwOqr2P+79E1IHDiEW2JEFWw+es7bvLrKVr8IOR79wwsBOXcokccEFIoZzcenjyNup8Mw8nGJPXbbVrZa1Uim3/38KxT8r4PN9big9BUR2Akwddtsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:03:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:03:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v2 14/30] mptcp: userspace pm allow creating id 0 subflow
Date: Tue, 19 Sep 2023 12:02:15 +0800
Message-Id: <4bdc9790ea25455308e5c71d26b1cb88c1779956.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0273.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e40441-7c24-40ee-0217-08dbb8c56ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rqoKN1SJDkyl7ZZmgnHUHA7IPfEzsK5dpEqpN2Ybdoo9ngXlT6e3EaZdfodM+ON2bYtkHZYimKvR5HoHj3wLXeHTYhA8Euk71SJs224zbjPb6ehUIqsL0AYbpERgIHFYRUIJIdufRC3QvV2Aj78o53+bVLdcFJw3llyCEe1sXc3clGrZygU/SsQlyjFSJ1DOIX9dZ/vS8MI/+c5n+Za81LdUsWWgE2QvuwH9p9JiABhY6EPAB8Fd6pFdzf478UgN/pRQ+V+wCmSknXCpI6IQeho8cQMZM0ypNOLCHEkuu1ouPF/2lOzi9eRhRN//dHpGGd14N0dCwB4l2Ozhu3kr35iUDB798gmPjlPoBfVNm3MEn1OcS3nEyD+cGWRz5bbWPVZN16cnj1p512Xf491t6CRXb6FtD9+QutNUhPJ8qLZDoYZjdc1LLuB2E/gMXEF8fjxLIzbNl5mcudVnV2NxrQ3iGO1WztgTYECLMS3gdUbtlHwuHD7m9YE2SyXEuTc5Q10LSduvoXm0iMJ3wBdpAcqYmRiDG1LfNnm52XvafHR7M1Clzsurs+1+hMnYSR/sPxS0AxaOn/lvc9YMvUdO27okLwtHo7e5MoMn86SFkFI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(54906003)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(966005)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uwBDz1W0s1otCKQXttCwBdHQo+PfHGN1vK6kmN6v7h26jQp/AEn+4wQC7wH?=
 =?us-ascii?Q?nN8Ek23mbHGB3SC0Glu26vPj8NTFWoAFrOgCsdH1u+4zJryUJRdmu+RE0DYg?=
 =?us-ascii?Q?Ft+A4cPEZAAdv5S85Fri8pZOMCNHFAUnoNgbfhu4XzCYM8CtEwq1iqwrZeEC?=
 =?us-ascii?Q?NvgAe96GQb5h0Ui/gtrpJopdYWxdZ9JgXJDtWEeQFmUqBiOMgQYJcoXYCbpS?=
 =?us-ascii?Q?Ry6DSUZPGqpD7JRL1UzhOMVrF7TP+zr3gYYQxDYpHIlTHrzUGQiyEIR3zQqJ?=
 =?us-ascii?Q?f8mDY57Y4C3O1FHlnpPXbDUF7IWmT7aTEAYFgkuiXApMqqScLm2IIrYqtEx8?=
 =?us-ascii?Q?+XYs81wfM5CLUtHZRkXQnQQzf4CnebJRz2Iv8n5FAQAJU0U0qNDYTBwJd+8v?=
 =?us-ascii?Q?rt6YoPvRf7qhlEj++wm+CAPgv50/HLiBtFqz7FjUddNctRuZd1rg53SeV5bd?=
 =?us-ascii?Q?y7sxQl0QqnVuPpnqzxDyKSlKwQ7sS7yO3NyejtyT7C/5aGzgQlL4ngVbVKki?=
 =?us-ascii?Q?D4DdqK/9v9MgZQkz0UFSWEcOc9Vvlg+ZahQBVRSf8lWmvVm0ub75F+bUpuB5?=
 =?us-ascii?Q?kIRymj+tIluQaj8Hlqvq2t17aj0MxNPgIj8Jqm0L1/EqP/jpH0CIkdEareNH?=
 =?us-ascii?Q?mdtEWBANHZVyEtfFkZ1bi0iSNMgQcG8bmcFj8RP4xd4vESSVh+Xj0VfBWwpe?=
 =?us-ascii?Q?kIRTC7FQT7s4qst1pPn+erngjEedZVf4oiEk9StjJ6URoqCtZLgIckOf/7DQ?=
 =?us-ascii?Q?U9RRSCtqDkw13S33MDn4ZN0DZyG02PFEapfYod0k5OuD5Z7txVsCQ9CXCkZC?=
 =?us-ascii?Q?npJzviGlUA2+R9HButuNjmadvEezFAtwP6JgddSJ6l9zCcAFFNsbCcg9SlB3?=
 =?us-ascii?Q?X7NtzEWctDyoK9uO/PA+sbcIF9P9atI0dvFwDcYaNxSEjwhFY4dkwXSPcTnU?=
 =?us-ascii?Q?UxQAg2mAG45oS9JD90EQKq18H8k3UUTzQtKlPL3KyXoru0T6EWO+TfiqY/BH?=
 =?us-ascii?Q?GoTzzk84FtoyDXXf0yyuaB3nGdnvRDyK4cUM5OT0cO4a5K/hsy9dSJYD4LB2?=
 =?us-ascii?Q?jHJiw1BFzv9aLmKRxE7btEtt4pulTvP1DQuv+cVC6CJa2K0vp4mSExB5p96B?=
 =?us-ascii?Q?AdeSI8DQt8O9u19lcJ+RMA/bj8BH8SzzRdnUuGGgb4Tksaz4bAsaM2usDy52?=
 =?us-ascii?Q?pkQ0cgMjqxw5zND80VOQ8a9uUym2LSuxKQWL3FMeO0HHiKpl/MDnKQbRLaqR?=
 =?us-ascii?Q?YzWmHf1HHXWOp27qRdKQiqwWWvF1gndXOU+I7LUYkScATsW4Th+WDzO0KaQo?=
 =?us-ascii?Q?413Im8nwJBXSmOL9qbHqU3pBWUf7aLitNLBEB6z0DCjC6UKvu8qs51JxEGyo?=
 =?us-ascii?Q?LPaNm3FfTdtW5TBDa3orw6SgCgJI9dBSyZIC+br83aj6QFksjHvV0ib4+SkM?=
 =?us-ascii?Q?youfUyov0YZsj67q9z+l43iahPBpJNk595ZAwdncz09uvYw9sLenUlVx7pBp?=
 =?us-ascii?Q?8m50E2I/+lsJrrLdbUiDFstql/QvDQuGQSsDrw5D3SFO/mVl7N31QPy1jse1?=
 =?us-ascii?Q?kbY1z9ctPjbnHyZrJ4e8pIQkZAq93JkaOgHYba2D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e40441-7c24-40ee-0217-08dbb8c56ae4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:03:44.5879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qt7T5mmQQmPd2SOkq25HC8Y4PJePPrDwSXHy7eOx88fFttfhqdZwAYZ1Ms/DJVIj34R2NmgTV6i7He1BIe/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch drops id 0 limitation in mptcp_nl_cmd_sf_create() to allow
creating additional subflows with the local addr ID 0.

There is no reason not to allow additional subflows from this local
address: we should be able to create new subflows from the initial
endpoint. This limitation was breaking fullmesh support from userspace.

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/391
Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9429cf91a9e9..d8dac3eda7dc 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -315,12 +315,6 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (addr_l.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "missing local addr id");
-		err = -EINVAL;
-		goto create_err;
-	}
-
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
-- 
2.35.3

