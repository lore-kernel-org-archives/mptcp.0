Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4957C
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 11:53:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljq/K7xIpJtvkJpehjcuvxC+3ZcabHMzN1kcvlNucJeGz3GdvA4WRbKRlT0WDcCzjpxW2wk3SiAS+OBdZW43PfJt12o+ftdaiY0Wj/2PIyfSVGsYyQz80pufuQ2N0sQBKVPZXQigDxUVigQE5lzzEy8G5hRN0DhXmsmPwXJGFrpz+BzokyY6ClnKZrBtaUdTRj6kVPqSrexxiSeBIv2BawQLDHTulBh2A8ViAErE+R4lPkDPgwDAxKm2pJl9VezVhnnHk/PbkrhRvkH4rqrFEe72XTIJKyxOCGg1EnmOcfvL9a68KyRzK/3UAD6SmlztwQwCitU7FiLIG9KY9jK9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWBdW+UF+silnkwVlBaT1bm0Ucz97sxJKWx3labaXfU=;
 b=X5gw+t0+osfGEutynmHuP4hdMBCGrC+qHDhInjXx5JwRmtxcPO1lWUUwuiBCIkbqzqb5aXV7eKvsDcpGnYUid0DHW1IJxScppbjgb4G4utN4Azt5H4RPzjmhXgwmDoSUDwvW4kldszZtxwLQKEsNJBXW7vGiHhemChZNgzEaEzELdPHaUfqlLd8KneM+EvI8zhG/o36mbI43P4k8CBJXD8SP4gKaRrVSGMa5xv0okvtoT01u+fuFl2uIN/8JFW1GwuwCZo6FUuusrtTpVeJuqQ6hfav3mXiUp1ZdTLx8gBnWFCVXcmLSE0vrrHhCkWzqqs0ByCcqmtmY4pjLmYwOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWBdW+UF+silnkwVlBaT1bm0Ucz97sxJKWx3labaXfU=;
 b=hMwxzs8Kz7ZnoTzDTIN2X8Il/hhXsPXrrfwrijHSdawtQQR5XkMa5AdyNjmMPVErVHV32efOEaibGGcnhoGSruteFyGKILccMdeMPX1XimauiaGmFgQOIO7gf8cSPNRZ+35fVRTabIEZGqsQpY2G3l1859A7EFGfhZ4FM1RvzrmjnXy1FM6sb/LpgW7G0ignwJQpyv/al7MsGG9uX5VHjh4cT6JNqy8IijnyQLlQl0kl93yR9NirR419L9s8SzT+tR34SB3tftBG8i67wPKzH1AjhPmyA8TogpEURSba+OB1LhGUY67/vEB2CZOCExLRNUHMD8U4UkyhtF6m3j52/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 11:53:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7368:7ff:a1f0:3f5e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7368:7ff:a1f0:3f5e%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 11:53:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v3] mptcp: use entry->lsk directly
Date: Fri,  4 Nov 2022 19:53:54 +0800
Message-Id: <20221104115354.3413-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0114.apcprd03.prod.outlook.com
 (2603:1096:4:91::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 0323a29a-386e-40c8-c5e6-08dabe5b3ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H0nRY+ohElMu9IbiJshsZxEynNOREv/2pn6IZTtPtQWeP6s5uBULN+7oiSvEg8phAdOJixzpOGXCQ1dJM2QfFr5X41y2xYurmXXVcXzWHHViWfd5tDBPtGtMsx6wE8kQmMOcIT3btFJ+FzM6fIlmOPQtQ+uI+sGeiee4kCwQ0w59arjqqh47nuoHJ0aHRKUH0d9XzhKsEmWgq3JoC6khp6kyFLH0hmOZp7C9FxgHZi363h2VuR6qS79+fct2raTsESjzRGKV0reEcd55UHem5ThFlrxO8YHJwaWwc0+Vx5SFM2d+W/AafslJwqA+U4U6U3nPzO6hJR/JYYUmZfZyJ3yQCrnVqaqEocyANUdqLA2MydeLmgzFektXK+vegSbyLchGlJzwbnmsanlBz21eiSA6YR89e4j9JJOYYwmdNb1mb+4mtkqhZi0UpcCssclGGNaFk1SGquD5CsX+UK6pz2TZmMrYTeM6G4Yb2kMYkpwpZF3SqdqYZPQ02O8KzJev3i3YcLQfEUQlJY7d73OQ+p9Pl5auYEGp9Yj1La98vI+6PoLGpMSAy5ckqBUQmwtDZeYTVqnIAhbfvYFkjAZBXv43FI4PKVH0k6DwYA4z5i9M1n/dRXxHkZVzBU733bRmI6TXW2pAAgxQBNLEQbTY6zm6138RQP1vmWNCKh3RucZN7usKpId38tgimIIhI20LnpvL40fnHZa3ufHKUMY9t8gNscu+rt7dLzvRunKGGBFCF6/bnbk5AfseGhyHPewmr4VdC2ccturKEz1VM9CyAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199015)(83380400001)(41300700001)(38100700002)(5660300002)(44832011)(86362001)(6486002)(107886003)(6506007)(66476007)(8936002)(66946007)(66556008)(4326008)(6666004)(1076003)(2616005)(186003)(26005)(316002)(6512007)(8676002)(478600001)(6916009)(36756003)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BrV3O/J733ydAB+alg4glxhIgM3z/IuEffKXJ0zHesHZXUBK3DZBBLY/gUE3?=
 =?us-ascii?Q?8gbjWhfOHq8YIWHtTDIePEALpG5t3eg2cGnw+LpnC9EGNSxuk/lfyf534A7/?=
 =?us-ascii?Q?p0zL47GOTkIbEP8GLBWI7JfmrtMrYu5TSyn7meAe36AhrVY+gLmaWwX1rWIr?=
 =?us-ascii?Q?rpLkG+NJn1qshL8Pi5GjLiy2k7lDWG1Zcx9eUUdx3cB5iFAfXB8ud52PyMet?=
 =?us-ascii?Q?jlfCbTqXa3I8egCrz1jClY8PNFdg+XH8Y4hWxsg7/F/38urLonfidrIvY9mO?=
 =?us-ascii?Q?mkHk4KfoQmL02vzSw/Rn6R5gWE5JhEdxe/xNWVf06np5gO9tkKRmpqiVPNQw?=
 =?us-ascii?Q?9GWFtFAUI7c46tgGspufRsKGV2lNUuUtsSYnGWp5CdpFbNfksRuQG0p8yKJg?=
 =?us-ascii?Q?ui723Yb8Gy8ow1ogbXkM3fBXndLAvhvO2l7LzLLpCAs4BUPgXpuAMXhVFcIf?=
 =?us-ascii?Q?gn/IDNbCmcllPmsGgtuQPRIEGlKlDXqlZDswZSAB92XdxOU7Lt4YwXqr0nnf?=
 =?us-ascii?Q?iRBhqYq+iJtdXZa2C7zUxDqM00Ml95xphSkffDIfWTNOIXG+Nz5HqF3A+FZG?=
 =?us-ascii?Q?N8OfFZK5g3OFQCkJLWkjpCQle1n2mex0kT8/ipVctcfTF9Qna7NHOo/NtWr5?=
 =?us-ascii?Q?zLA6L0Y9ww9TUvpJCqBcAZ+2oKRdBaGgLsHc6eM1yb6HYDb/40SKhHJAUBB0?=
 =?us-ascii?Q?zkoNbBYgRgyCArZOPHnwfvqRRc13vsK7bn5B5+44/I/bsG4eL+axAleIBTV/?=
 =?us-ascii?Q?I3muT9c6bL6D/pvga198zihoaXWsWl6+SEtVQhnFzEWwo4mqEmtUVPmJVtN5?=
 =?us-ascii?Q?f+/HPSgMfODWRVkLmmcYVUclk57OEx69Qn4TZkucRor+7FAuLd1cf49yeBzR?=
 =?us-ascii?Q?RJReARNsqHFlUtjnILGBlFYKGU7hybLdnqLBihPBzTt9Sw/cSN1uKRkkPQzO?=
 =?us-ascii?Q?zWvBlqBynXEelO/99rx2MGJsoLNfkqi4aE0WoYShrw2dARVN7BWqdpX0L/Vz?=
 =?us-ascii?Q?bA5EoD3N0sTA03AOhVdQdbYv3x2TkHUVNfivVN+RKAUgA+thwWTxIg7hWvIu?=
 =?us-ascii?Q?f3m3Ls1iKoDuSqQrDDxHM2K/Ch+vnfiS7zXC4ErOYFpvd2CfT0bqihhVWSVI?=
 =?us-ascii?Q?Ot/tOWH2VAyDySe6C7z/x7ICwnTqkwACy08kfUEn9V1DQOitchpbC44GicmO?=
 =?us-ascii?Q?fdgN9PjrSg6cWaeoVG4kro5C3d8u0Xv1OEarmIMi1IPJ38UhuIBRMjh41y8E?=
 =?us-ascii?Q?sj+VKLpKFx66PuIxa88A/F3UIMpa0Y2eJyWzc313ZzsyAuKf3AMIfAoVBv0N?=
 =?us-ascii?Q?oisWaCIa70c/PF6P4aRSlXoX8GmTAcN1ysfKGi6JlFmh0Qkk30vjRFEWroHG?=
 =?us-ascii?Q?wXkdmDYIqKYiZiqcOWeDY/Abe4jeJ9Bbg5lpWmhuOzJ0QnTDxXXfaI8NR3No?=
 =?us-ascii?Q?dvPIAuucllQ9czSCL+6QSVVzGit4TjShWLaPIkDHwcRb1cHhus2Sih1L3eiR?=
 =?us-ascii?Q?1LUXxLdcxLDyxU7mJh5tZxJPloW77KRVWGAy881/Gc6Z0ERh1HLT8RQyVTv0?=
 =?us-ascii?Q?z3FQPcUAhjHRKPq+fV6RRaHFzGAYRXK4mf5U+bnT3+p/P6EzWunDf3/brXI/?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0323a29a-386e-40c8-c5e6-08dabe5b3ba6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 11:53:48.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9xR653Rk2CaEOml38RZWOsvcX7leQoijdPpZg5XPiBmXhaRizEBfVOZmsvsBi4VeX9OPT+LEFSaB1gsp45fqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551

entry->lsk should be used as the PM listening socket directly in
mptcp_pm_nl_create_listen_socket(), not the initial subflow socket.

This patch fixes this, use entry->lsk directly instead of ssock.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v3:
 - use mptcp-net tag, add Fixes tag, update commit log.
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

