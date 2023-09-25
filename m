Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBA125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:41:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4yzjvTeFsn3HIR9Dt8CeIWTuazulxW668AXQ0xnxB8DygGvBTWNWE8Um0WJ6SoZckaTPAua+i49N3A9wwap+Qc7lu/5N+OQlS0adwWNTfN+osfBpRE5jpIL+4k0TD9r57pVLCey6U+kaxCJiZf5ogG4PUvRm9h7apHBr5vl4gQA1Dcm1XaI+wjHK32EP6kR2IWnIVQR51zIMpF7uNvXn2mRaK9JBgv4Reuym2F5UuNFNNQaeM3ojTJgui/+N+ZzGJzE8rNxXAPt9X2CPbI250KeVbgckPlCLrwD0FJSza0+y36pgGinRgqdrIqxwBRgdxGE3xOsaRYbq+V1YnmBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5FrInTQeLS4ZGU0VxRrWGZf+90hoB18A2M1DeCqiEs=;
 b=Rd00MRR8ZTomYcjsbCfYAJuUs+i4N5qI/B+6XYXQM+RstBamKHPqurhlbiTNrtvow09aZllrUutyJPDp2o0BbHkvKGvegcjVxBrOc1mB3Q5F8XEsGNEvAqIfVG1vaLjqhe+/pOJ+JY9F3dvbiMcdavYkMEo+q9h0M3Ni+F85xQ89gs8cpi0nRM004kw1/Iwa6RZsY+6YRVoh5CRe/5ixKx+xoNIWdnGtxoKNGYnt3LLX+DoBUy2dTf4rzO3OA7ydS8jDWwkUqkeEUwF/QCMqYLBYuQTKmMfglivj2h1ixXURk2npxKn0lYwdFqTDZD/wG29FvZqScCK5RAfw/p499Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5FrInTQeLS4ZGU0VxRrWGZf+90hoB18A2M1DeCqiEs=;
 b=LRH/+xJnkitDHiK6oafW8B4UMDq2392Su6wDJZHl7ziOp4lpfGWK7me8fSvfEfhoyDhPeGH2u9VdZUYfP182iZQ4pBcSUFVvs/qWiVCzFT8f/J5f475Ftm+SR0KRJenlPtQ4n/Hhjto/3M1oqtMBBaNEN+4C55UJB9xPyXLrpjikNBVwwvTHwTnRHiQgvQ65qfvJqVXaffazjTquf+HdIwiSvl4kKQ2BjQjpsEF/AhAvTujhDDxJ/SrcSTOOyOyW0gE9pDObnxxuFHgNRVCBZuyLVeLOMxQfh/Gcw+NGH61Y/+HKMaI06276hMsT2wqq2K8OS/dI8fUz4cLy3oWJeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8048.eurprd04.prod.outlook.com (2603:10a6:102:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Mon, 25 Sep
 2023 08:41:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:41:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 04/29] mptcp: move sk assignment statement ahead
Date: Mon, 25 Sep 2023 16:41:43 +0800
Message-Id: <5c816778b28c8f42f1dbdf1fac081164da2a3364.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fde335e-886e-46db-c648-08dbbda3418f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lQ9KbrgVVXUsSceJc680uZzuRnT0g2/SLK117dYv66DSHplWzm4081MjAUYmAySq0qlUmuf+6voI80FOn9PT2RN3bIvDCVUCppeKtE3r5ak+M3eECCefwR5r6gGcKprZQV6RlJgDexTWPM2jfMN931hGDj3/ZNx1lbOMMAD0F60hlEsjBrYQZSZeCR7XtIO8AF+5+W5wUmBnkBngpRQvBXedZ6fHZdgJrKkfs8DPCOSwyq6FAfOpnhHKTnNmYwzhIEt3OsqS0BypNdRCE8RUvkjmDiyy4M5dOzkEFjcNGDXAkVb0pht1Sbk+VzdMoWYM/+Fja/djy2V3whtKD7xnNP3mvmK1TfKamVB78+DD1yzZe10PGN8lO8giRa4lxiSO00HhWqjpbZeCZ1rsfBGbiCrSKb/w9edbgh7AQuAX5TlsL6LF2mmErOIqgayI8ZeQXxreoiIWybojBI1vzA1JK5pcZ2u9QAutZByS866QQ9aDSLiSQNPAYsqPGE1NDkOPHY/RudgV8fgysWYNHW2ZtEnG1zGS6gyGpYYuIounVe/5LWAozEGX8aCF2TEsApad
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799009)(36756003)(38100700002)(86362001)(2906002)(6666004)(6486002)(5660300002)(6512007)(478600001)(44832011)(66946007)(41300700001)(4326008)(8936002)(6506007)(66476007)(8676002)(6916009)(2616005)(83380400001)(66556008)(316002)(26005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LClnfpiNj3jWq7/rPjO8qLfLQ0GHxm4b1cw7DLnY3KKq/LfD8satftnymu6y?=
 =?us-ascii?Q?8P0q4RsCi2mwPTMqxqF45C7m+8rRSUhWolneqGTdw8pM1Lxaa0CFTFwGBiNZ?=
 =?us-ascii?Q?SumMz4418btqoUF/KEO///vSxGJWHO7M0pwQ9hpHCkiHXCTfGxUk54MMMTC/?=
 =?us-ascii?Q?fl6dtwHJKlMN2KACpyZtc+cn26rdPwliBXM9NHiAiTd2q0C3+UIW9KX455P/?=
 =?us-ascii?Q?eSwhN+eJheAXF094VWcWK9RwT4tAR2kASbdvF+FAfz75tbR8FCWDVwnN1GSQ?=
 =?us-ascii?Q?nwUjh+IDgsDi1q9zMiIIW1KhYEVwaId2wgBsly8qXGQOCuw4rX8a22wOZ3mG?=
 =?us-ascii?Q?cxwFNnr6cqszsG4kd3QJ1XE8lJIgmVZvP6AX6cIMR7s3Gg9BSdv4wFBIzGVK?=
 =?us-ascii?Q?WbVVuGKylkon1GWya3DuZgVYy4M2IsB/oujsYRFAGbF+MTpN7wzz70YPnzBr?=
 =?us-ascii?Q?fzljiHoz2xPqXy19JHwlXmOcQzQY32GrvKQ3JK4r6J6Pwhb750zhdDPsQ+6d?=
 =?us-ascii?Q?+Vz60aanpVwQ4ynvHeI1VdSFS2521wpldomCpRn88W6A3EROFlSuNkjPqhe6?=
 =?us-ascii?Q?bRJ3YPvCDdniFz1TcQW8NONkTuZhDXcTLGgx8QAUTr9ABtHVxfiOUnZHgxpH?=
 =?us-ascii?Q?ZvVjPEDcgNtag91njdpm+uR5yPHnRVfBNxFPWnyQF3hDq4yjMYkRFy4SWABN?=
 =?us-ascii?Q?RRlaDq59pmcktAVw/xKrelEeMKPgt2gHhgDSnz1gxCHnCLsRvPypexuqJfLP?=
 =?us-ascii?Q?01Bpdtonm2+Eo3ZNqItkoOdH9fqBdcVnOHp14P6fobRYGDB3XJ7BRtHTOCX/?=
 =?us-ascii?Q?arIKJAIsB7KUEctYgwvG7DNmdZ3qQALF1GNcNUyTziMftuAMVoZKKNFKuASG?=
 =?us-ascii?Q?+pKZBY+E0PRhUAP3Jc/NgLFpTTL7aysNPY3LkGq4pxbSafT2D2aqTdJn8Ofr?=
 =?us-ascii?Q?BoVZ6D0Xg60tF9xuANIIpv22e3z3qh2zuwFCllCIrwSXDLN5j/tDwp3TWLXs?=
 =?us-ascii?Q?pNBiGa0/WkfndxUPkops+qSUTTzJ+fme8ifSb5L0dHD9YrDmQG5WJ4/4XZEN?=
 =?us-ascii?Q?DY+60smYgpriElP6WRkTOj/q2mjBYDJ9NZVm2g8llZHtMiS004iS3TpJ4+1J?=
 =?us-ascii?Q?qhFl0Es8br9hneP91z5Th1D8vbdhmI0AqQAykPr+yE9M/IMBJCThoBU/SG4h?=
 =?us-ascii?Q?0g78ea74KHLio7uUQasltJAHA3qs36hDZgggmRgJEZwaLzeTI2yTpa6GavAi?=
 =?us-ascii?Q?9jlPTWppBDAkqilQmM/Kk7myejj/W6s1azasTQWb0S3/HJ1rSQCkXo7wyP4+?=
 =?us-ascii?Q?cMY9JeqKGu6QgfNRx5imr5FBIzg3WIkjOefYI5XwTfIyQPUf9v6YcVV6HbFc?=
 =?us-ascii?Q?wtNZ6gNXi8Yq6SJTc6NngxkOsuDKIlFfTNm94wu8YoyClXmkGujIz45L+azq?=
 =?us-ascii?Q?y1l9aw+yfztKh/eizvtdbf1858/+YsQLhPwgOWWDxJCRf6ZdEz+VqG0r6cqh?=
 =?us-ascii?Q?q0nPQZKA/YsWw8mVpTzKjyE8JfDgzjTJyvCc3VGtf3kzoqOKsGBDE/MQ6eXC?=
 =?us-ascii?Q?ds5kLRD4oyorjX3x33FNoE+rJEzXgOfvvKWEkWrL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fde335e-886e-46db-c648-08dbbda3418f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:41:48.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiABLEJHGfuOK3NOIkEMza8tnO4jx0ue/POfHdUU1ClxydG4vNN1TJAxRxb7/pcL6r8rT393YEXSmStRuTCEbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8048

If we move the sk assignment statement ahead in mptcp_nl_cmd_sf_create()
or mptcp_nl_cmd_sf_destroy(), right after the msk null-check statements,
sk can be used after the create_err or destroy_err labels instead of
open-coding it again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 07f602144d5e..bc1824a56dea 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -296,6 +296,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto create_err;
@@ -319,8 +321,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	sk = (struct sock *)msk;
-
 	if (!mptcp_pm_addr_families_match(sk, &addr_l, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
@@ -348,7 +348,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -425,6 +425,8 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto destroy_err;
@@ -454,7 +456,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 		goto destroy_err;
 	}
 
-	sk = (struct sock *)msk;
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
@@ -474,7 +475,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	release_sock(sk);
 
 destroy_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
-- 
2.35.3

