Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2065.outbound.protection.outlook.com [40.107.103.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA96110F9
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 10:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+YF1uorSe1HzhWD1zSqZRBJKVG8uPYWH0wbJcBCWEO5pAutqXX6hNclaxOD0PnnRfOdFao5rnvDDGeCdw1cNq1O6HjtfA9DiQ8sulud3RerkQ+njFcsGAeG1tkwceJgN6DbJuBraw2eQnHfYSik6K5gi9Y9h33dYINy3hkB2siIB4zmC3hP0/VqSG+B2/0M7gIYeYTy5JS5dtdbCbnwc0yhm8gFVNO+veLpotTFfnLwCIG9ay3V9daZac6U//ZYJ3aAvbpjNbWUnvOLAKAFxhJWdtnvqoxhxPgzWBYWMfs2vGG3ob2sNVE+KLK9F0Y+zQDWxlEx0bx//coddEIkDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwNZtk54GwyDzTQw+BbkgDR018BpavfgGWNuz0lEWM4=;
 b=X/L7KcG3cjP1FsF740xAKhOX6Mmhm0sb6Ys9zyxb3oFqlt/3vLbwguwbSQz5ctZt6xrhZyjwZv22rEhURv8UuhJTc+IgpCk2jaWKU1YP7KJxwBUDsgB0DFy+cqLIiEdY//luOd4QoPvQD2XfSy0izUCmMQZzas7JG4h9AiV1eiOOfsgGgppuMuWtXh+Y1NMK3MdTWl5M2pMi3Nah4AGr43NiSKZI5KDvOKC7VffpIur3gatM/uPd3LP55SEdXpQI41/r7GSmss+Q6r1hRIqYPIWKFtYFX3czw0mYNaSbS/n+vArzOS1VHDFzwnuQrb0F/ktnqh4yWV5KaIHKoR2F5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwNZtk54GwyDzTQw+BbkgDR018BpavfgGWNuz0lEWM4=;
 b=FuXQu6KaSQ378lBWjETliKZUvmQdJi3iScBgbgDe9ba6q8fO+ppduOcTwMsgrdDy04o2ReWsFTeMcnb1BJP/7gEpYZo+NJLoMYkuIPoW3eu9/q/xLHBoK/a9VHngiPrBZNhkfUF/K9mttjihoH6yk2DUqSGBhLauXAL+reSsXaM78acp5JW9J+vkb/OHDyhYOerPYN1PNdng/tcc98PSDpWldM/IY0VgBKl8vaazfhEvD1FDHS8s2WkL9+FUwj6fw6NU+1fmVrbTRZdIvaQAVhpBj7K3GjqeuYGEZiYqgCcrf4pSmqbQx9vYZajnUbxobkRwwKw2N86fzdWbH4hRuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 10:45:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 10:45:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] mptcp: use entry->lsk directly
Date: Wed, 26 Oct 2022 18:45:03 +0800
Message-Id: <6c8c57c5a419395f8f4a23aa8e3f76c830f0c12f.1666780919.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666780919.git.geliang.tang@suse.com>
References: <cover.1666780919.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0188.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 01fc8ab8-8d80-4c00-bfc0-08dab73f2d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aJBs/6YV3E2fwfYt+vmn2cL/UmUIJ7T9+W8FOjuMlETrDDtj5/71+cjOCpNxPPQQ1cd1zLBNIvl9G8rhc1CYn0PIxKmr0ijRAl/5AlKHL1t1EoM96BLRoJZiOi0BDFA13IW8FyDaNdI2wyTSYHaLr17+TBV2rFQ/scvWt9eAbnOXk3GEhP9A60QQ/E+qXD9SJetwHsS3dlhx2lQyqHsqf6lKN8ADCCMZll9UDpvS1c+uHk5XyhMGsgvP6JPeG2rWlHzAEExyKtez4I46lzm2RXaT8pJpJygHYgQp1RqjEKMriF0OZ314+FooYkXKcGymObPaBgN57UuIZcXOCFTU+9QdVXtsdoGaNTaPL6a+zI3boh6JFLzP8xS376YAQHls5LpgNmEjuworwepJkQoJupCucq1UQEqoEhUggvuhVvNFU4Dsr63mkKUplbYUGnmOMhDsV/9hLQOA3oLaAyPLKgqFkoGIDySBQlsU+wYaX6YlxfSJcWD1oFc+8pqgyizDLeDBM8I9LazKG1BRrYyC1wk/wBPz3txR8Htxe2nMt5aeH/WivqLKDS0dTI1tkFj1SYzrqn7ssLi9hcgbNRIMKe/OK3tCC1Kjn7F56RiKfIAhU/OmMUk+Rm+voGWfmmlcviTnutllmUGF+q4V1nED/3Hf1sVEBnq8cm83wEFNqWVeOljBO8EflMc7d9FaZBnr0u6tJVPRIGxqQpeHjlzumkIbs508zndfR7QNoFTtYT8BexS4z41rkdt/D7T8k+Q3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(41300700001)(38100700002)(6512007)(2906002)(186003)(26005)(83380400001)(2616005)(36756003)(8936002)(44832011)(5660300002)(478600001)(6486002)(107886003)(6666004)(86362001)(6506007)(8676002)(4326008)(66556008)(66946007)(66476007)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Om4gWO23dPgDgUbC0nXRnbfZnYkWuYfVch4BHGJXXNWrQsbyC9+sg9RvuTu?=
 =?us-ascii?Q?qfp/VJAcoB1vWAJtw8MUyyqEBIr0cNFz7+USPQEQUvm+vqqsC8wUQjr6a8J7?=
 =?us-ascii?Q?mGb6BXtAri3BtrBli7qlCcPG+qYrS20HfKBAVU07wU3lyFRp+ARyJ0bV+hbe?=
 =?us-ascii?Q?fv1p/DDB8MJYOza7EXj6PfBb+utEIb4J5YsOHc0kR3vONpbKLEdr2P+VL1Rn?=
 =?us-ascii?Q?OLzofgB//SgGEJ1n9EtF5nkbyMwTG9hq789lDxBDp4UGRyFS2KcEQY/5Jo/M?=
 =?us-ascii?Q?+l1vkuWTXuky026Fx+qS7smNRL/fRca31xXWj4hqZm7YSIb48QxjySt7+hPp?=
 =?us-ascii?Q?M4TsPtI0YiKQ4f/etNW/UhnuIj0Sj7DT7g6adUY7nLOhzq+V/b46DTpwdwX3?=
 =?us-ascii?Q?EPrum7l0UCDeQ45PHf2JtvSbLEpNkUcg0A6LLQ8OdKxKkFB+Z81iIxgSZEwN?=
 =?us-ascii?Q?fc6JsxUdkE2WyVi1ZcQXPBnD16wcXz4EZ3uJ6OtAdiE1ni40MxFE2nTpO3lF?=
 =?us-ascii?Q?0mozRBOeD/EZ21B7kGZ/G6f1HV9XkBXumDNx1sVKH351LX7UP1jbwXPiyzgm?=
 =?us-ascii?Q?c41k8b3sHVeFDQNKjee4iImWWAuqyobH5Ft3zEQMMxFx9gzpOqaWEjM+ZFil?=
 =?us-ascii?Q?kUV5VQ0IC62BTxFwiPgVjUQdgSNBWbBCvk3XrnHAy0BRg7nLYLUBYpDCdHIa?=
 =?us-ascii?Q?OMGqvHn5pT2JFZHCk/xiW/5Srp5H637cpGoafnglBTsMytlKX4x0Pv9RkGTQ?=
 =?us-ascii?Q?Z7V0x5FKi6vGwsPDgaxxY2jQJrI06r0lrth52wVv9XcHERRA1TVPWqo50PTR?=
 =?us-ascii?Q?tOWaGMsedb/11+Mng4KKByPwSql7IRkel9ctUstBhcN2z/2v1+wdHm+IOAW9?=
 =?us-ascii?Q?lAx/Kn1NvsvuXVE84QGh17FjI6Mr8tXdXvdMv1sHudZAyGnQ5WvLzEo71RRO?=
 =?us-ascii?Q?BvL9EsfdKf8D2URX3dSvxJkW1mrOOJler7ByhJ+AcHiRELyIcg7YJS9r+jTm?=
 =?us-ascii?Q?2/QM86fsWifF0RzEAeWwuJjKLsvmAP2NHNvXY1d0cL+pgjBdjDWZsPzCQtvi?=
 =?us-ascii?Q?e9CNUo5MXYRdms6TwYaHIhwqI4Jy6BvrSB0O3EDy2ai4h9E1bvEqirpGlgFT?=
 =?us-ascii?Q?E3qdJEIIuCM24dkb8jdYABTqR1Y9Wrods0OTpz2dqTVaEPIva9F+1LQaQCGm?=
 =?us-ascii?Q?TIqRp37Dt6izy4q6BmhDoHEFlNLhe/xZwsimHM1B8F5XrN6CLElU8nIO5pzq?=
 =?us-ascii?Q?hY+xmIbquE9tZZGO6ZrCSGxaz7k9i7dQtTC2Qyj7zg+bcsnezxjzRyLiX8W8?=
 =?us-ascii?Q?j8IJydjOxllH+KY7Nxj1dqtr36HXHUnH5yrjs9eefXKY2MvaAKarn8Ak3RdQ?=
 =?us-ascii?Q?erEKFQa5ndXPXVtUAm1z/4sVTqDO4WbAQMvfh6Wkc1WcXj8rWDhDQNvjdvVL?=
 =?us-ascii?Q?nzoOOOqdoj6eLRbDY6fn14liunz81LFRaaszoo/SJSxzeZ5dIlAzN+cGS3Xg?=
 =?us-ascii?Q?waVnmVO632tWpdmbK+MIy0+wwRQDA5/GeeeVB1ktlpssPFeoIkhvYkA87x9C?=
 =?us-ascii?Q?lmPBB0XTA4fvqmCoaHwn3a93sElN3P1O5Z7Q67ThRE+wmvosfHIbxDHpa3iJ?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fc8ab8-8d80-4c00-bfc0-08dab73f2d32
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 10:45:19.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpltgCwSPWX+bXX4hpELoaQp7otKNvI42oyPAsR7xiDQhHibr+ppk3z+cCjDkf8g/tDBMpIHZd6wcZoTEl4sUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338

This patch drops msk and ssock in mptcp_pm_nl_create_listen_socket(),
use entry->lsk directly instead of ssock.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 9813ed0fde9b..52a5847b9d74 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -992,8 +992,6 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 {
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
-	struct mptcp_sock *msk;
-	struct socket *ssock;
 	int backlog = 1024;
 	int err;
 
@@ -1002,30 +1000,18 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
-	msk = mptcp_sk(entry->lsk->sk);
-	if (!msk) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	ssock = __mptcp_nmpc_socket(msk);
-	if (!ssock) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (entry->addr.family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
+	err = kernel_bind(entry->lsk, (struct sockaddr *)&addr, addrlen);
 	if (err) {
 		pr_warn("kernel_bind error, err=%d", err);
 		goto out;
 	}
 
-	err = kernel_listen(ssock, backlog);
+	err = kernel_listen(entry->lsk, backlog);
 	if (err) {
 		pr_warn("kernel_listen error, err=%d", err);
 		goto out;
-- 
2.35.3

