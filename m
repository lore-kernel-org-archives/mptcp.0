Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140044.outbound.protection.outlook.com [40.107.14.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DE1FAB
	for <mptcp@lists.linux.dev>; Sun,  9 Oct 2022 08:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSEFvKjdIKIiB+IvA28J54OEbIkTxiGJwL9Gvv4llRoq3GTLBe/doYUuFHWnOdGalTFbNILeWI9Y+i7Omry35tXuQ0Q6dxHfZOgNY5e1ipouF142q6zJF1LLeOELkyZuM3D8tsdUPyawBaYCQfMgQZ0PPqPtZUQ/Feq7d3Lu26jV6Cg8sS3/TMLYzCuc5ITfoI+GPcHrbxzi6SVt+X3grPIJtHdqbRM9Uytl04iYgy8xKXX6QWHn5qt2vDenVN/fhAQIUFLVpjesJQgwOnmp6537QRoWJ5Zw1P1MTnxxl/FVMbZnMqj9k4ypdu3dm5W5vQTax4I3LRS6T+8+NnAcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37x+J/3ci3jZ7GZDang5aCaJFsDaebDEBC6ihqU2GHc=;
 b=daWngD/8uYkahtka7ESJe8IXJlgqnmCrHrlxkYPWjNLDil1xx2Qsz6FvbsuW460bb0vi/XTjvfHyPMZTxlEiDhaE198zWoDgGAyvHMlqRigL/VlzFzOcKJ6TIxkmW9A58cElKyxZHt//k9rhp1B043HBeDAJY8DFOAFDTts/HYGR0oou5wv5Psd8BuwJRklw5OOlWNAZkHdscfoGu950fVbnvMerZGnVmInXyFCqaFDol57qhdR9MF2/vdRrYMJVPKmDpB6GlHb9JX+7KaTh2pnd1H94NOx75rG4cebYtP8GfDBwTWK7ntgeA20Cokir6jhqRd/N7JJybsXmZk8dXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37x+J/3ci3jZ7GZDang5aCaJFsDaebDEBC6ihqU2GHc=;
 b=2LV8ptReOoBK1ryTUSJlZL3mu1hD6OlTOwvIFHPkCHcKiGEqdxMJYBIT0OKj1sL3mhIcDtePDast20ikYVx5ul2FrIoK573Xe32jIhfeg5kCbMVNEIiArEcV0ot6s00nOCc1Ri718lzKtsc+ZGUUAL9Y/iUdlvLFUTgrnHeUH6w3luXHMyH/OdKRWbA7God4hSXySfP2AZgB3xA1sbfYoofGindM/t2BNLRHy+rSmUM4w23BOmRV7nH8yP2U440vFvKGcFtFTd6twXTNs8b/MlPRUS2q9oRsyk46UJhEeVpx9jC8bPX+oW/Cj0xe4tdMonQcWdTXMke9nM0S61lPqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Sun, 9 Oct
 2022 08:35:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 08:35:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] Squash to "mptcp: multi subflows subflow_push_pending" v5
Date: Sun,  9 Oct 2022 16:36:04 +0800
Message-Id: <20221009083604.14151-2-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221009083604.14151-1-geliang.tang@suse.com>
References: <20221009083604.14151-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 41dcd720-5971-4712-30ab-08daa9d1387b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ainRYw6250/62eLmZCB1W5GKj+7lm0Qltyjhxdj3d+B9UP2Wnf24sJxMFAR+ItcLR4vASob8HLUUUOXUjzck9ZsmxPFYMS4jTLFFIoQysJWEKW5KQnrrMH8sCOQMqtKngKCjMRSzfGO+3zV1yWR7GAVzlAfxM2wv10p6jG3aojg8Kag1pAkxYRdOm7pD0VaT6yzvdKfQF5QfSKs0baK9jdla4dWBAT5K2p7c9cuvkuxd/TevbOzCPAGOd/Ogw/Cm55plJzZy76qyxBbSlFxG4zA8W9pgOfIBGplJR2cFm0o0KeINCB/JoXCy7MiitjvTgVoi4D8xntw4FeTVq6w2C1T/z9PcDi9iQLaMcDl4V5r6ignRk1fvB5kfSx/Xi+bNE67X+svm93UTZhS6O5WvzaIzN8XEIIK6ZFIQu+DG8iGgHO05B/nm3jycVdEhWUdW0aQrLK0FhtQWJcx72yXadB00dF1wmfFg6PVqX/Svn0Wkdt6ObR1NMZ4kEe5cJDgasq6BXfmJ8a28gSO5LHQ4sIJ76YBNq0rzuO9Odo2xj1M/XssO5kDFC1U3LODMJC5BggIt9HU3xcUBr6W9lLHMO15AlkYmbzyL3KQSPDOPfk4MOmjRtW7Ie89QCJg5FNOq/VwY1G3fo1eDDrH9lYJp3i0BTBQ3xNRRD9C6Y/2X0ArsQO/DStyAgkN4DVPWSySeeaAGvSF8CRL/y8rckSBDTa7eGlT0HtXj40v+SDVZ/ssCJyk6WC65mwK2bxbe2Nse
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39850400004)(451199015)(44832011)(2906002)(5660300002)(6486002)(107886003)(36756003)(316002)(478600001)(38100700002)(66946007)(8676002)(6666004)(6916009)(83380400001)(66476007)(6506007)(4326008)(66556008)(86362001)(2616005)(41300700001)(8936002)(186003)(26005)(6512007)(1076003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ECJLawuaXw9mYw5ilt49BgF3zMUfQYRTGx5oyQAnTLSbtq4FrceSqGyroZvp?=
 =?us-ascii?Q?obyFo/gVEAZNmmWoHCd7x04hVeSXtaPFKIPyIsx415IqdWQfF0k2uOkLfWZM?=
 =?us-ascii?Q?LnnH9pNyyDesbuMD2vbDAxv1fhsnTpXKwlc/uO9rb/tWHSx3nXZoJwo6WOAW?=
 =?us-ascii?Q?yiqk701Pd80j91AhEjIgoaWsbypTOr220G0rphi08rTzA7YeW0i6XdOiVP7Z?=
 =?us-ascii?Q?eLFJJ5KqN07IH+qmjPZX9+AeKexpGYRK5QWp4w2a91rfeTlO2uquX+vlOeyl?=
 =?us-ascii?Q?oNwYuknbZgIcF9jXg3gbusukfdMBfNTE3viMHk2dYA6jaxxw6yRlySdpbobD?=
 =?us-ascii?Q?9kYjia9yAHTdxEKdZ/hGPw9erIaeEvqvCw8xbv+I17NTBKTB3escwZNVUxKc?=
 =?us-ascii?Q?gXw2Pni3arPwG2fqo2wgxRLRJMdSjLV4s9NOp8fOuCei1tKFkwo+iVGqsdFu?=
 =?us-ascii?Q?79i9jUVI+68SkZDRSyGzI0IP2AjAJxSBaT3Nrorx+pUc1o0PsDdUwf4CgnjK?=
 =?us-ascii?Q?d9Oxb5qa0TK/SkG+5DthuvFXG6faIWnpqtb7NAJH3xjWvr1Vme64TmBHxFnS?=
 =?us-ascii?Q?AMOjqr5lfEe5h+F7QsQK0RCm93lN/f8mydnBiGmx0T/PTBfh7fxX140FbxQ5?=
 =?us-ascii?Q?KG3TfGTKKZRI4tkG0fEwDs+xsNnyHY2UKRXUQan5kzNmbt9xPQD0FcCsiXKF?=
 =?us-ascii?Q?RsIr0i6YBvGmEG4Cpph4ZNDx1yULa1rkuyr2eRbA8sDy0Em7JBYh+i8BUhSH?=
 =?us-ascii?Q?dYyW9MQyr7H21cMyLm24dNkZ5+SaldplAOGqDcXzCvNm0cwArdXkygUfntRy?=
 =?us-ascii?Q?qz/qN6hIlFUlXdf7oMMGvKudR7aRzZsjH1oUByN0D20r0UgdS9G0fO016XVy?=
 =?us-ascii?Q?4GVrBlQKvDiOti8Y3t27BI9OHFSq7LzQ8+RZEm3zeaL4GVTZk7QW1Og3iROP?=
 =?us-ascii?Q?MEmi+7EDT+xHQInVNuJv5VC2yoH3QoAtW1FkF8b3OOrcKS1Iu4Evo5NPBeZs?=
 =?us-ascii?Q?77SR760Wo4fMxjDJNjVuDLRVXLXmWnvSEHx9mMutrY06h72XJqvE9hBP4ktD?=
 =?us-ascii?Q?9P4OBsT9ZQ3brngTtGmwVV591c/ep88fI2iAx+T/nEb5O+0tZ9Vl/lg6nytW?=
 =?us-ascii?Q?Ir4XP1zf/624mz7ZaTI/GuS0ZvdnKcNktw6daXXY0lQsN6DhRQY/CUjU3mQp?=
 =?us-ascii?Q?gDNk0wGDVPvJCsIlWT9G9qScH3Tp+65VtxS4SL499hS2bTg6N2OHaassEbZA?=
 =?us-ascii?Q?FRRXEzBo9iDZgMr0eqW3KdnmJr66uVemPIKSGH47AVEDBiUPBMoxDMLZL/I8?=
 =?us-ascii?Q?K+sk5qHmBSywaVGvwJ6WsLQZqo0PyiPOK4ZSaA4ZAB6Nz8GBd7pnojSf8Eij?=
 =?us-ascii?Q?p0yJxsQ+r3ZNxb7ybo9JHQrbM2ch0Wow4vauqI/Z3VA84f43+p0PoUSoQBID?=
 =?us-ascii?Q?4mdbhF014MmOsJchprZXwszcd8/OmkyFMuC7lysRVTTKzJdYw6D0BjFAAfye?=
 =?us-ascii?Q?qw5PG6Vc2cjPhVJdGeGT5TzMNB7ueR16bhrPs3dOkL6DwjEr84H6a9KgJISl?=
 =?us-ascii?Q?xJ96s9qP0p7KJFuHznj6Nbu5VOObb37bGQNg9jew1LIbv1axZoW/G4v2ftUT?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41dcd720-5971-4712-30ab-08daa9d1387b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 08:35:28.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNP3oZIPHI5koTFqIGxbAFW4sWTEqEcBv4Ho+bc7U2LzkKJj5sq+Ze3oYEImacWv8NbTRR4ck2muOpBCKDPI3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

Update the first chunk of data pushing.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff2c1bbf4484..acc220bfb34e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1614,17 +1614,8 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 		/* check for a different subflow usage only after
 		 * spooling the first chunk of data
 		 */
-		if (first) {
-			ret = __subflow_push_pending(sk, ssk, &info);
-			if (ret <= 0) {
-				if (ret == -EAGAIN)
-					goto again;
-				break;
-			}
-			first = false;
-			msk->last_snd = ssk;
-			continue;
-		}
+		if (first)
+			goto push;
 
 		if (mptcp_sched_get_send(msk))
 			goto out;
@@ -1643,6 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					continue;
 				}
 
+push:
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
 					if (ret == -EAGAIN)
@@ -1650,6 +1642,10 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					goto out;
 				}
 				msk->last_snd = ssk;
+				if (first) {
+					first = false;
+					goto again;
+				}
 				mptcp_subflow_set_scheduled(subflow, false);
 			}
 		}
-- 
2.35.3

