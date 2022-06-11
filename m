Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C982A21
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 14:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W67ifl0jSdY9ah15w19T9qvk01FtcGa5sIAbfYn7cf9E/+n53g77Ji0ufl9dBu6/KhJKAooF5rluC52OZk50XUSWyDwq3b6D6Yq+Bl99wSyvyPu9AEa+JYYv9FaqKYXzCSTYwxe/IAX+kD39zfIhav6bfh/oM4TGrGpq+5Max3//yOyEwW7HohVQvM+iYGjImm2QRi1Yg66jSCXoOLojCE2SXI/n74npgFLyySCOqd6SYlbKHzBFlmz2RMEqGKd9OLJBadnJkGLmSHJFZelpII6uZBsPTVnnpEtqvTt4h8c3pMNLNJpjApX23D4nwrqGtAiGOTsc1ZLq8xNyeFn+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f8ltqDoaMw/d1Zjg64aLn4j15aIsfPIDgUz4zeLI7s=;
 b=lCbRSo+N89+6lfy1tOS03mivcw/yfviaEtNn00V/7rSIfKdL8ezGJRbAuJ5UMSGClVEjV9TGTx0pXBI0r4A/Ye5Z+2kWOdDUJrjCmQS56uCXPlxScZFawqBgkqlPoRRpWWPjd5lEhtEzEQzTEERdPPLE4PStxHHQdi3K6t8FgAc7TOxV0e1G9cgM++XzU0G1k8pLk2lxUZugpb0/o3Fl5zrIauhkR18BVxTtYuLUEK82sCrtx3GSTZbl4aqmZ70/WI2NA4GQMihk5cCDa98cDNXr6pxnifo+Re9ZMss2HCXXcWnEGvGBdrasUmrnum0gFoW/Mb0c9xTo6kak9rkOqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f8ltqDoaMw/d1Zjg64aLn4j15aIsfPIDgUz4zeLI7s=;
 b=0VaKcFHwdRLjx/C3qXsVWZwIcNN3U/FGR4lc0m+gbPaiu30+RHnUF7T+N8FrtQuPNj9ocDa9PNBBHwYBv7sGpEc2XevgiQMzSxXdN1BPdNctsryHpKcK3vCCEKm+aWdAUJaSExV+5sRPWN4F10VFs9N/SslIRuj7fj746sDSv2Auwx26aTXgEaFw5shlduRZRASy6eAau821l8dBy1KxjTJ287arfUyDnw363WCzER9UFk70OcQN3NVeDKEiwcS5/ZM6Ie71iO2exNRjZT3zKwWpGcQtC1A1r+i1nxi+F1BwCXvkUTCXZ4AhoW6FXFNm2QmQSYMUGSZ80JnArJYHIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4944.eurprd04.prod.outlook.com (2603:10a6:803:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Sat, 11 Jun
 2022 14:54:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 14:54:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/5] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
Date: Sat, 11 Jun 2022 22:54:35 +0800
Message-Id: <4ed5348a34b4de9b482fe192fc271a59ee334e37.1654958401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654958401.git.geliang.tang@suse.com>
References: <cover.1654958401.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 113ad8b7-937b-4034-0dd5-08da4bba5a85
X-MS-TrafficTypeDiagnostic: VI1PR04MB4944:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4944ADCE9286FC368C57E0C7F8A99@VI1PR04MB4944.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z1fsy68a/AN1wL0DUiuh2FKi2D5ijsraD2kEqyaOZerTXJcg1g9p+0xMSyvSD8rRnRQLev7yDzkAEDEVCmSAqTC1UP3y2BV7kYFUWgQ8an9FXOldxJG/7jw7Dzn62oItN5s1ECzYvdvSfp1v6sVCzKaW389hURnGxfwAU/RUJW7PNgJzUu3T0XTIEupuCMLGjYaFi1Z57ptOk4edxyFpxBns4AYnyIBypBHd8X9MJ0+tfwSSbVeR0ILvrnVVNs6llg4fF3Wo5MWl9cf58q8g49/mjvdgleYTJHT8o4j6teArJnN0DlctEQ8jkkZ1J0SRqB9wWI4C4rx9U2YDfJnktYdN+YBi4RpRRzw9UmEuWnE47mVRhV/guFYcHCKmgxgRzCt2HQZfyzSoelD7HQm+uvwWStzkMwR6CbC4Iflh8IREwSYN7AxoHJ9+uQnvD8fkiLnCQBZWnVrSIL6vjbaOT66U8Vaj7wpDawjBpc7EgTsx0VCwswmUumJlRNKAia4cvkbc+94S3y2HLkOJYw3thBHSCN0xhz6cp8uzCAH8VOy0g+wCwwTv0phYok6fPcwiOJLxAXLimTyOvMuxOBkcKVw9q93Bw1qjfPIR37UWbTqEzU/t3hhvsOHfwvOGU0c/rbjGii127rgsUOIavRf5VstWid9e56Rvy/BRDrQmNq87eHpfuQuX8VcLG8WNxtnPJ5YhvToG6DpXdXsAZbBzDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(107886003)(38100700002)(316002)(36756003)(2616005)(508600001)(6506007)(66476007)(66556008)(66946007)(8676002)(83380400001)(86362001)(186003)(6666004)(44832011)(5660300002)(4744005)(2906002)(26005)(6512007)(6486002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvjUDILKnzB9QnsgTx7QL72nJbLX7IJyqc2GE9APY+knfwR6FXC1CkXYOJl9?=
 =?us-ascii?Q?kBX3+nPqpmEBfaWfMIZRt1pvW+/k30idEOMmOcQ7bq4yX8UiBQmrLswQfLHj?=
 =?us-ascii?Q?bdFlgjR77tQuKcvsd0/hlgmhnr9tFtMzW3cuy/yxzZcXSsKCn+jNBWXqZ1Zu?=
 =?us-ascii?Q?KfL1AJcvHAgO+2e4Up1I9REO0ylI3G1U5mklxrZuoyREO3yubCxIkZMzaspf?=
 =?us-ascii?Q?526vWIKOzO1rKlx6w3sVJezSxeeyDB8EvXsUmrsaKL/KcMS822TqvJzafXmr?=
 =?us-ascii?Q?ooi5tIANn0Ar6mEOZ8fLdMWnrvpaMDKfre27EfQ9iEHH/vdDpQVy/1+4qjPP?=
 =?us-ascii?Q?vuVMHl/fFSdaF2UKAWryIIF3FERr9VwbCYPp6JjKNWEjjHH58F9KaCkPbSav?=
 =?us-ascii?Q?1xflpW+NXwdEJB+Ntx8m1PJWZoBvNWkbhn1VPbwzhIuQm1CvNYekIR+3XE4n?=
 =?us-ascii?Q?Mx1X+qBrqIdaEGbfhTQpUKuMOF/KLy1hDaFjf2aFJo84qjS3LucRhTlFPpUo?=
 =?us-ascii?Q?qWNW6CEyt8ld9XGRd87s8leFttBG4kMWmvHU379Y5HpeUMLZ5Lg7a7L4MWy6?=
 =?us-ascii?Q?6f/H4mJ0WCOEB7EY6kzfzRWiWNEF0z3fWX/51v3Bo+ehQd798qwJD8TVn/XT?=
 =?us-ascii?Q?BE7uBhJ6iFsJExgDdrkLotZlSG3JvDrKUCTnnZC8lNlwGBiVvrkwPLZPSjGn?=
 =?us-ascii?Q?dsl1DUV0XSJfpvXgqlxoRPkStNKhHJ9nceO9wLvLvBjCM1TPAvqLK17uVw3f?=
 =?us-ascii?Q?kCUMPeqKVEYPsX4ofSBvKJA7VL8zKgoV7K3hj40e2E0eiYlk4OJ4DkRQiz+q?=
 =?us-ascii?Q?va12CU6kGTuNoheqN+67rR4qYIJQwDX4k30MDewyV6toqf8F30pIB22hnrmf?=
 =?us-ascii?Q?eaM9GXcN9d10Z30wlzhtzjfAOxOSN5zroXGWGhUo10lmxShXsCIbgcBvhwuK?=
 =?us-ascii?Q?/Zm4V1HfCqF5ExOx2A69kZXPpbCVkvapWBebnkloOTjrcHwhsJQ59UowZ+EA?=
 =?us-ascii?Q?FPjJwRskZQV5KQPYtK7hTNzm+eNmW2TWhJaYHCLPphiNBoiHExFccnSpVh3T?=
 =?us-ascii?Q?AxdQOc/uGDLNhx2jhdRDVykLkv1ZYUani9zQ2azBoh/q2W+9M2B6BmL8bsFK?=
 =?us-ascii?Q?h1K2vRRwO5z/r+8+T04CqvYuXCeKVH8XZ9TzBCYdHQdBZjA+0o1pMtUxfTWY?=
 =?us-ascii?Q?oehNcZfY8Ly0TIXfK4igPIr8hvb1xyih+HP7kttQ1Wvb6FDq7PTn4RXoFeWn?=
 =?us-ascii?Q?of87IynMEcJXkaM2pNp83WFESFMQ4t06DVh8wW/OZpl4fEXSQ3c8SIjwZWTx?=
 =?us-ascii?Q?a4wRgYQ8Ii5eVuHP6r3h9s4IsoKE6LdigxqvhFOMcaqhDnhKC/CDVJcd29Vs?=
 =?us-ascii?Q?gTD+c3vjBkcv0FL+wyhjTSMSq2AiPaOWxdZpRXXfeeuId8uqCUVu3trz8zvJ?=
 =?us-ascii?Q?XlbNnhujPgkOLwoE2TWwxJmZDvtfWS5wf0TomRUX/o3SIDKts+SDHGLnfP71?=
 =?us-ascii?Q?xCg6NNjXfiEDtrvtBKoH/MnzNIE9gEpe92pVwgYyB+Rt6JZ4qmKjafyvySQe?=
 =?us-ascii?Q?SWFjniE0nhR6W7b36vNMPM/ynFcr8NoJXcEU05tl8DIx85mZZ3NEPNNxYJ5T?=
 =?us-ascii?Q?VyVAsi5Av5R1nn76RjvTK/gmqIsOQD9Ib5QE47QYthExSPtD4otJcNnrDpeC?=
 =?us-ascii?Q?gfMZpyTwqcBOOCgGGeNh9cAG7dMaOkN36HwQRRJfFFAx8Rmi5p5QTcz01AD6?=
 =?us-ascii?Q?KgVefNuMtMtPWYWbuYNcS8luZ6cdgKc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113ad8b7-937b-4034-0dd5-08da4bba5a85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 14:54:58.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVwnuCTfHGDp4KPBqH4rZmofXmUbZU2zXIpBPkqFcPENxdcKwOUtPibaTfnzcdbwVRllCwxoL+CoyHF1M0QEPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4944

This patch increases MPTCP_MIB_RMSUBFLOW mib counter in userspace pm
destroy subflow function mptcp_nl_cmd_sf_destroy() when removing subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f56378e4f597..ebbab5200290 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -5,6 +5,7 @@
  */
 
 #include "protocol.h"
+#include "mib.h"
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
@@ -418,6 +419,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
+		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

