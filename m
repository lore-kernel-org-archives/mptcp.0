Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584E53BA
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 05:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="zNzmlUxk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYXLIulYYTTC5MvnO0LsyIClot5DXznOjDty51YbXN/ijLnMvY787T+7EJhoq7gk/AA5K8YmEQawYfDcN7W9dMM2V7rx53Vh5A+sMSjfMugWCVTmp9SLkB254yKRmy1hFNytbzi1QDRx0G7WkJmYaKu3OTo7jqFIacXcwpluBXoWwmWLoY6TEYjfzW/mCty/h7n+k1CQllerz3DpTOoX1etjqLH+kFOHnH7XbLbfo33o+7UAqC7515ggPEyadqTQ7sKI3RTT0KuvdIvi5SgMtmMkypYvJflZ5U5pxlwNtvuM839XyzPW9jEBDo4n5wz/dBbg6Lj6DwRN5MkzQwaWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=h3/JwbQbfQ/BShI9M8yYEqc+0Sb4siCWkCCYGN/ULwbJgRl2AOW3y0zNqmW2jl/BvwR2FbvQffiwT3b0GDipoE0YxHX6JyS+ZjZZ462/O5Bev6vVyoAUBN8dk/aG0CJdAG/Iq53XUJlsRVHBNl7v7kANrzSy1eXuLhQJG5K0yx9Zifx2JLtGc+dwOaOpBZOhJsuG/JDfx0TurojmzwO+rBO6NRzn11zD0qdSe8NbEQDNfY8KFb6TcupiBkeztILZxO9J0BWVXJjZOlZkrPmurNsD1yrbFsXNRS96QZpZ3cJA1ZXQpGsMCSJM8hytk8ORMrb3TqXTfDPOrZkx/NqMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITrTqUSiTFPQLH+n/E4UD7SU+WUhgfcHxzNk2VWjDqk=;
 b=zNzmlUxksOd1/zOcF6EVzBMB++zLN+WOhYA3l8L3IqZd/eCM+/LRcoBnGUk+bGOEtDe/820ISCLffXneVsB86mSED2Ouue+uEkd/+CLdUIYx/oSUEoOqN4is5Lot99mUE7FRABQjWvNjS+6sp6ANashGRoqk7Hka8ESFxTgpoUtVr6zXMlx4YaR0vFnv3ECDDLAci1CZpNTViXwFY4Uf8ys2Wu5/lEz6fStJs+3MHKcprci+F3VVeaREIdYRQ9FTf7mFYHKEczl6WFECpLG3peygslv5fCCGq0e+5BDXZlQnUonc/98URybzXo5qh7jgZDGgPbwphyYy+JLEI5xSiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 05:46:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 05:46:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v16 7/8] mptcp: userspace pm rename remove_err to out
Date: Fri, 13 Oct 2023 13:46:42 +0800
Message-Id: <f3b95f16487351197cb1ee66b399ee2ed0355e76.1697175899.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697175899.git.geliang.tang@suse.com>
References: <cover.1697175899.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2fd8c2-3ce3-4a37-a19e-08dbcbafbf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JNlROku6Xjf0Bp171jhrXwjOoCzsTEU2sqv3konFsxIJh8HR3+qqjoZ2TWUDIDnXPNtC2mkxTkoPOgyqrFkEQdEV4q2EI19Jrwphhz7gq48uIDjphc1VeFqHRSpsIRribvyEQhqq35biw3HOOnvl0U1Tq+47O2K+iCo+C49oSuQ1Bt8cfMYKPRYbf5UdSo4OCViJDEhD2Ob+lbOBi4WNYqxJxfjyE7TreOJhDoFFdNYxqSl+MFaS5GgZTLMLq92HwjfGQddlFjnEo5WV42ZaXWm/KDyoc0ap12L/3AwWBDaiZ/KpUVFSPjGLNyhvLk//7K3dHA1RvGRsfnJmtKH6iqA3nBWPwx4ZdFES4uBBrfKYWq/9mt2zDuJ7gA9kdTcSaPvdbR5KxmrCjE/habWRiNSKlcizeQFOi+Ef4CU6oL2c1EpiOrK7rrxn8mEv5rtWOYN+qJMn0SwZwuwSSUj3ZwwXANg9DCtVQ+TiIbFkFps3tAOn2MlzkFkO9LpHmWKCFCWaZ/U4Xe9aZ8QPSezlmZheH4yzDD6IpHTRP31u5Fz5HaDxO+84koinZY2d1V1MJHdMpys0OVxvVvR8rpnuCKBf/IBzyXDWXq0BEKAKSm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(376002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(2906002)(6486002)(478600001)(41300700001)(4326008)(8936002)(8676002)(5660300002)(44832011)(54906003)(66476007)(66946007)(6916009)(316002)(36756003)(66556008)(83380400001)(26005)(6506007)(2616005)(6512007)(38100700002)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0IKorCo1saJkzFAQFW5gZz+wpsDjbIebiswWLItVaGJaE3Qo9FpBlgk4BGj?=
 =?us-ascii?Q?AoI50NElCzGrj0Pqnu05+1uXg6yFkSMnPb0/xvKvsX+Yz16PvWtMeV+MbYVs?=
 =?us-ascii?Q?DDEc451wVWT7vxFrTYMystZ6B1V/Kwsdc0WyHj/96n7Yxo+Yn0hiClqEwro/?=
 =?us-ascii?Q?WveGEZgicttbuYgvkOxcdroPjlGxX1t/yJ5JxulsJnLfqS5ygXoqndGzCTen?=
 =?us-ascii?Q?jwt4gcxxKliXildQn3fXpVZPBEXrd8KSTqb+/k37RsFHb+cEP/CVgb1GlqPl?=
 =?us-ascii?Q?gYdUMe2SYepzVrxeIJU55+XT+WaAAhVIZR+dSI07dtC8OcRHlDjkXV2BKGTL?=
 =?us-ascii?Q?31588nlR7p9P8w5fxov/fs/QpJLUuxUvHgZFsHDYXOQp5jbqJXDZ5F4eR+q4?=
 =?us-ascii?Q?xerX5Ytwj8su78vSr2q3iMFWYsvf0CcrWCv12AaCsjEwyZcvb2W10eBc1JZv?=
 =?us-ascii?Q?672+Is+HEBl7N9QKAMcxFoLctlOg9c8T1MbWseVOhl7xCiS5IVPlYZXEPlZS?=
 =?us-ascii?Q?BOaftCSVp5RvqRu1Hizc0HbVqpXNpN1gWLxgmDKv5hdRTB/P6CcT8EWNlrJL?=
 =?us-ascii?Q?DGZYteMwtBW4JyjTFCaNbByYEFjG45woKgcL1NVmw0macmPLLg+y6SGvOL5m?=
 =?us-ascii?Q?LpjPCBTY09luGoXdwkdWXfESiGfJkWn3iUYiEALvuKwxtpw+/yLBTwHoa6BV?=
 =?us-ascii?Q?zIH6sFXQquQ8mjDIIZFRGZODJQlK8/uaxWtz/+jEwPR99HyTPoL075HpX5FH?=
 =?us-ascii?Q?OWMOS2KcgJCoQVSWIrY1tt0YjaI/JzK4WzUBFQ2oNJeltEgnUF+dkNzCPhui?=
 =?us-ascii?Q?nPEXNNp4439LNaklKtLKlXlq+eJLp+iOiDZCtZrwPViNEpxrWonYG2iXGnJz?=
 =?us-ascii?Q?//owTDawT3EedaLVL1jS1LzOXvcEM/OohCRmwCfTM6c42ru4k28I5Zmc55Vs?=
 =?us-ascii?Q?a7E6ZmyfN33E68SZbqwRUuSiJ8L+EdAJOmNs+n3/pWCasx5EY3SuqdCwpKnH?=
 =?us-ascii?Q?NgdLpEWCZGEPXeFo1o+VSmzdJp+HkjYxXZQSv5SfDSbkfrxsT0ntEVD6kequ?=
 =?us-ascii?Q?2+8KudkkosHOj3zbQWw9UF/cNIZx5DirRSf+VXpFdLAhTgz0HXil7rAitOJ/?=
 =?us-ascii?Q?v4qfVRLn4e26AsN3nwuNqg/G9U8oljOtsNXLR00p6LyuOzG/fy4B/grtXfaO?=
 =?us-ascii?Q?/+mnxnhrk9V+A/VpXA1c+qGMQQ0ngCFefAx9zKixjd3DnoJVGpgN+vWUpRKG?=
 =?us-ascii?Q?aRr+3XIvMW+cJSIy98enM6dy5sPqxYlI1KjyOBiO/Y0yLJ/Cl3rBsdX42Q7d?=
 =?us-ascii?Q?8fIr6vNQ7HreFsl8B9MGwpuSno6f6Ml7OOgdE7RE+zdO9U9OTd0ytKdyhdWJ?=
 =?us-ascii?Q?TPWHhUymgaiuKwWYHTR6emSGgBmaY8ZT/s9OOFT0DIo+aI/9TkAs3cgp/y9n?=
 =?us-ascii?Q?zKIQ5aLABoW43ggRLHLGKa2zrpucSGPazdxzkwhTENmi2aqlijbDKT/crSn/?=
 =?us-ascii?Q?TsRzomJL3xc952+RutvqEZwQXC0P+sJt8eYdBRvQKehhBQUy63kRo7qf5RiX?=
 =?us-ascii?Q?LyJkVEArMSuzEALmuJ931RudC8ztEfLcxt0M34/IfAfObuOvYSwtGESrDr64?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2fd8c2-3ce3-4a37-a19e-08dbcbafbf82
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 05:46:29.7561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tuaav93IOiVSoutMEfD9rhFs4EjbhEAUTVbHfK7qdY8GUBCn8Fzj8i9kG775CvNnuhFzFPuWKfIjNyOCx00C2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288

The value of 'err' will be not only '-EINVAL', but alse '0' most of the
time. So it's better to rename the lable 'remove_err' to 'out'.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea50e694125d..cdff3e631d2d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -276,12 +276,12 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
-		goto remove_err;
+		goto out;
 	}
 
 	if (id_val == 0) {
 		err = mptcp_userspace_remove_id_zero_address(msk, info);
-		goto remove_err;
+		goto out;
 	}
 
 	lock_sock(sk);
@@ -296,7 +296,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-		goto remove_err;
+		goto out;
 	}
 
 	list_move(&match->list, &free_list);
@@ -310,7 +310,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	err = 0;
- remove_err:
+out:
 	sock_put(sk);
 	return err;
 }
-- 
2.35.3

