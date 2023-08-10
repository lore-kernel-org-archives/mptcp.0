Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512DE1E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5fNII6CNzipHRnmHjCKJnhhSI6VIBi24x8auuzHyoaCKlbM3Y+620LL4HCFf4wwgBPDH1rIZ8wPoP3mAodf0u6WwanEeJSVhyp8cfIkOjzGMh5RLbJCPSEBBWQfNVcA+N9/bfneQckSUynZwvWVFu3dzP6sd+czbARMkR3iIUY/JJ9FvNeabzQwd6hxVNWSredUmqKLb3rsk1rHJXRvJZLa46SntWzV8zlsu4ETSP/wkxc3mjiiHMvX0dBcnsdFuCnhYpw7eBlNm7ovnj35Z6+QvzOYItkpPOjU/C+iigQv2cTXwmBMECwVER967s6SctPWOmDWOFQ9wPolBjOSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC31MacAOUbMMFcTxC8eG0Mxa1Fx6cAHvPIX47pvVRU=;
 b=n26AWMI3LLmsHDzUxkC+4QWE9YYTzhyxJ3jNK0mJoCvE6ADApUodAz+snbJwyyuw6dIDGjytrWXWI/+2NBiAI6bDMAPZnyTM3xD74dK+XOKd+orG+hfQ1TmYKv4cCaS+3U2geWZqCsmxtELZi5IXt4AKPcGrKkLuDxN7FR1PNOltw9M7kCjzIFfvYmAEIeKe5hsOrA+Lr/R9bmqbsYVv4c9aCVQnLI6pM0LXJzOJmx5bjdqjQQima++BLeMgohZYNRLXM7HEwqzSAymHYNCV+iGVPTn/G2LArsSkff7kvtX41zMoldDBQ676gBf2QXm8YxiwHjZ8P05+VCqWx/lGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC31MacAOUbMMFcTxC8eG0Mxa1Fx6cAHvPIX47pvVRU=;
 b=BcXeuOWY5iGJbozEYF/evdtEsCHeE4QQRxlRYIMRLnRs83VPvIN8fZGMLwlXHG4DWw+NrorGrHeuKtLWpjLi8TyWUm0pqeS82q6nxqIj+6cxtyghXyf3GtcQwsjWraKq3JTChRlevKyz50vnnSxKDqAopzt4gaOs/UHLRtIco+OO9/6dGUy/TZlwa1JTI0UeNBp6xNEroSCXKqYS6gEUr/YYz7cV7Y7LNHw9JnAb3IFKnFE/R4T8h9wLP3ZmJSc6xee9W4lI3Lo4WfzW1sXL4TkEe4Jyov2gbhRDSokeEdyqluchDc8OWqySuVAHbh+1k0T+ysChXDCJxGxEh4o/RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Thu, 10 Aug
 2023 14:10:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 01/11] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Thu, 10 Aug 2023 22:09:53 +0800
Message-Id: <52921a8d32a536ba306805b80142122e1644a9c2.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fcc8dd-582d-4506-66e0-08db99ab7c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TcUdMmy5WUxAwD7p6AOV1zP/P1wuJfoilWtf1LB1IddNn8O+rW2+2TAU8DkeV+DBeC0BTAdE6DdNbH/8VuLE/HsNknWp/jwS7EXuWZOdXQxrOEqkeIJCtrmLKjL6rbXn7PxYUHNmqPuE6TP8d4//RG9GSbevCDG7BN3iN4UKIlriXSYgMIr+NSbCGqFMMkqrzp8IOvjLgtkS2cDUvIn5dks8U3v7NF0+Qohar92j0gQxV7VVAMe4W01CJlydtYcYA60yW3ouClPa73VC23fQRi7chnQvoeJIge9+8IvtAZr18v3X8wRasWaRuDwkz53enzGFjr79S62WCCTN8oNXnuN4V9pekaBSaHyIOH2Bhi+rds9ZW3D+fMhkIJqPqg6bOhn64OqhA0PWsV5BKeAekZFRaJwVX/IF20K/KvccclhuQW3Vv5X9vfawhvdcGMn3Cy5sVbGlfOaGIGFxm5Qf8cgFPXJuUjGm3k+EN4F9TclRB1jklmSJID/V7DEDrApTHKRip7kXFYhi0t7OmVAhE4S7ymSzhaRJXBw6oXxpFI0hbJM4O+2jDCeP+aIRWYo3afxcWEIVcxaX4CcMsh3kOHeVRmtq9qzQnEVyX0zW7qg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(6506007)(6916009)(36756003)(4326008)(6512007)(316002)(86362001)(38100700002)(478600001)(66946007)(6666004)(66476007)(6486002)(66556008)(26005)(107886003)(8936002)(4744005)(41300700001)(8676002)(2906002)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1EdlIygPSe0UOhsfZrYOz7Onxo0B7FKO5dxRaH+kCiqbowhN+sXZTDWJh/al?=
 =?us-ascii?Q?zS5QqPtdV2Ji3TmLMAh7S+aftWg0Kez8FDrDbqpw2Jegp/6xiMM7s9+flIxV?=
 =?us-ascii?Q?XdJ370wAhIYbpdaSBkQ1DCB2sB5QbuW4N8G1Akv+04o43fxH/aHbKbzjgYps?=
 =?us-ascii?Q?2HIpZNNjjm0HdubnjZBCYLKVhVKfawnXW3AomU9toLnadn8auGJyolSXThJ2?=
 =?us-ascii?Q?aosqQyzg9myCH7lIVEiTgr4H6LqKb9t7QDQy2i04aNC58xTNM14z8RLcfmXn?=
 =?us-ascii?Q?JmguY6VJGOQRlAzuUbaAEkGdeEOgjUn3HKhMU0DmSOhA3+MgtX52ak0LwS5G?=
 =?us-ascii?Q?zS5ywQUMzOVSEEsGLlk9nMVKSMxkFvvkkRei6aF1bFH9PLhaYZnO8+UiYGEU?=
 =?us-ascii?Q?mTzYBCYwckB4yL35ScM1KItRaJdH+yqItqBbQACyt57625AdY674RH5Kmldd?=
 =?us-ascii?Q?PsS4oKwP0ObAut36G2UoQPSksUmUDyYXXaL39189NcONoVuk8kzfNICPk0y3?=
 =?us-ascii?Q?EhB2EZ68BkEQQBCw5U6iVpaER1bEeBC0jA6bH7gU8t9aU573aFPrWIyPLgOB?=
 =?us-ascii?Q?Nz7qS1B4GDtplS4fzhuFuk6afJR5SG0hLfkotUdsRb0bd3LlBqPqQFdFiZby?=
 =?us-ascii?Q?CmCuvbNv524nm4H8K2a6O5Z4g4eve2O2kf8SlV2tYm/yly4CcKZwHynScQ32?=
 =?us-ascii?Q?9Ni+/7Gvzb+KNEjTjnmMuwBtE0BZ41vqKtFRQT9z34Gqr57BPt2iy/bxua+r?=
 =?us-ascii?Q?QpS44BRtWYWdeqAo24Zmpw9d+mkVDfhPt2nMuLSk9eW+l5f6Ejh+1jJ8c4rD?=
 =?us-ascii?Q?4T9cBfDLvkV2DSX6xvdxH9NqN1DE0xA/FUOAmI5eqziVZqoXB5E1+H43cuVv?=
 =?us-ascii?Q?+cngKOBGMcrtWGNTHlKeThDMfwdQ1oajlMPByVecXA3ocVvUOUi3Uxmz/X8W?=
 =?us-ascii?Q?9wN8CLDFIs1KHxjGzva2pPGOc5yCsI6OZ2Sug4LeZuDCCvy7ohAymBcIkcGC?=
 =?us-ascii?Q?uLYXsis/p/XDwYVhZSf/RHDn3yLJ7Zu49thZf9VsSZuEaZTRp5M8tMPzne4F?=
 =?us-ascii?Q?kEKKEqcTKw+4FCAvDqWtWNTCA25zD/4+TubsA/hz8GHYmQvnpatZusZxliBe?=
 =?us-ascii?Q?ME8sZFnSDoYmIHialxTPZcIS2e0xPC3y2sdT/iWaymuBo7PmvpE0xJ+/hr8x?=
 =?us-ascii?Q?PJBg4StQCVby4cL6ExUvZdGN5xcbZiDj9W2MjKTUXtelHUgAgdkwho/3Y0Q6?=
 =?us-ascii?Q?Jr4Cgj3ODLI67AfCLH/UuyjGOO39X+C1neYA/QKZoLrR2NjZ9h35XpBmFzPq?=
 =?us-ascii?Q?qCN977eIG+7VTyTylW474F7E/Pwvk1ihQRbM2JLHoK7Snip1rNYPkVGMZWNp?=
 =?us-ascii?Q?etRcC/XPTA1VWHwZ9X4u2S6j7k+YXWW4MTmkH1XVaO2FH+o0We6pcjLrXKQa?=
 =?us-ascii?Q?lEOJirHg4XghRw346vP1RooVqWaGAGRnIkgDAdk0A+s0ezY3amDjUEfMbh3g?=
 =?us-ascii?Q?qsZOA7Y+jSixsuYwJA1fDj3JZB/8cDyBAR6qMa02I7EC4xtNtA0D14DBCOxS?=
 =?us-ascii?Q?022l2pQbRWsCguaYBy1cbShd5bUdJvYkp7cIeX4n?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fcc8dd-582d-4506-66e0-08db99ab7c3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:00.8410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/I0/GVNgA8WwugWTDZTl1h8JCcfC2ypDEaxw/NmZ3h0baSmA+VKPsmtLTcrUwvWlDgroGEFSm0FoS2FsthAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

Add get_params and set_params interfaces.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ba0e1ee68a05..84ca8380acb1 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -105,11 +105,21 @@ struct mptcp_sched_data {
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
+struct mptcp_sched_params {
+	union {
+		int	snd_burst;
+	};
+};
+
 struct mptcp_sched_ops {
 	void (*data_init)(struct mptcp_sock *msk,
 			  struct mptcp_sched_data *data);
 	int (*get_subflow)(struct mptcp_sock *msk,
 			   const struct mptcp_sched_data *data);
+	int (*get_params)(struct mptcp_sock *msk,
+			  struct mptcp_sched_params *params);
+	int (*set_params)(struct mptcp_sock *msk,
+			  struct mptcp_sched_params *params);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
-- 
2.35.3

