Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60049.outbound.protection.outlook.com [40.107.6.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD717CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ1YnMVIVEGOMfIqlf9wQF+g/b352PDCQpm03GC+nCvI7KXnd3BM/0xJtsBBFbaUOx7sN33dBzbdvxd/LXGYfJZurZeFUHKvsq8BZ+MIH0AMtt2QLEX4ZZ9Pim45o0ij4WJqK3DLtQsUeg+PgmPxs8kX+kNYrvOfxayMkVAH9oZBKXnZ83zPIRUtvYeDulo022MW/5hktEEazMwILIs5NtRDpEbyEbr/xfbv1n6csY6DocVYXPtCNiCgeW7kWK4Z1Y24FMYd0injAqzWNJqitVMzX/JZ+vuwYVXFRM12MrNmb6c95cMBXuvvI8FRxW1VGqlWKnKprgMfKObgGiieVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk2oVjLR6lQaEru+Kd2FoVg60IhV7Wx4P2acJ+dPX+g=;
 b=SluNYgWupXZaYjP+OtnMzliNH2DWJcl3sIG3fYPBb4SWLamxmsks2lra+wN/thhe3Cf/yNRfcT/bbYZ67/h9EX1MOWL8tCAPb2tVX9vWxjBWenZdwQhFfQTRr7GXB3MsdOq8OHgREB91dxNeznVE7X0HcB4YzJzpGw4kTyWPcj1b9zWFZj2Gm+rTmRi7mTHsSWgpajSBnK8qunto7mYrm7vHeVi9AzFZYHvaH9OJh7gASApw6moUev02QVFh8ih6pYVlNjYF8N1hr/AUWJpwLmvFaaBHM0Bcm6mjHYnC2q6iECfatjSJXAnGYPe2OEg6nEm/9Mbx4ct6MfT2/NnDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk2oVjLR6lQaEru+Kd2FoVg60IhV7Wx4P2acJ+dPX+g=;
 b=20esau6PzojWmUrcpb57+4aSirGjl3dbxJMvEj65edV05LckqEqz2sR/Wwax5JhT5VvsfeQ6R79jgWatNpE/z5ZkPe6aADuyCVAsa8E298Lt/85fmClfT7rdc0HNY5FhChq4B5MOKjEx7eyZ9w2sQ0QhzNoUD38FVtdt6pWhm3NzNI6fO9MK7vrHYTmjE5gsopx6dIngeCCV33oosYCRGCDEILvuXDQe/8vQpIw4dqFo31lXayoUHhZ35s3bfSV41p00MFtAJCm07SbGRWPYEcDVD5s6wQDxNoobcMjD/6+VQM1R6JvJ1Aa9lf/zcuOLjB5+o1BtKcIi08rAtQwhhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/16] Squash to "mptcp: multi subflows subflow_push_pending"
Date: Wed, 12 Oct 2022 12:50:27 +0800
Message-Id: <81ddbbc2faf43e74d85c35209550874bba48c9ed.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b33dbb8-0a6b-4cd3-008a-08daac0d6a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rRj30hKXFNLRCn6x6XERJ7GXBx8XloxrHwQlldfYkLTyuDt7v0S3VpHvcau/xAYUBjnUi9lROZBR+9F5VRPSrb+qpW910G4DtDcl/tl1SVcQVqqB+26Nhi14Azqr5N4+reWESI4vDUY6LAxfRENB55VPwTAHsgemjONJeoMCjY2kV2gWGmue6fDTuHQ+FTGHgjJlGLbpu1286Obaxgi0WsrhFm5g8E2bf3F2YKe1lD6nsKWTeT5O4ylImS1ShLJS3Mn//CiJCav2aUIjRTe8hjASi6hiL2ryRjhirSW6RS19W72fI0O0aSM0vPofGp5zap7vYLR6P6VtpWjxOUKWXoIYHKDglv0Vfg1DmPxq4KhS9OjDx5h+1qS8ADiRX4U1YLLfZvriT0lxYM5AQj/ckiJZQNNaduv/WqQIEPHHLKUeKglbOHfrVz9XQYy1ULqQ/d6chFDAV1dYnpyhCiLFaHSHyDDWRZv5OUJ63thjXv+OC+lFy1SCogLvmd992f7EAa9nIxgHaJxj+qiyjvgPT7xoipGcBDfOzP77IPANBCc2TluUaRkgxCrws9fnBFpbewpq43c1jnG4ppMrp/aQO8kXotAw8OXqcfbTdyFLba3a9FveYaK/2MpmvNegvG4pOG9RaZ56ULoAhDf7tRxhXePrrySd/YCeFyEpi8xfeSzBIjhfDLaYcyIrmiAVoCjC+7yM+CB7GcTVo/MaHXazi0b39G0bIeeqfda6cOjS6GJn8nAkkrJ4Ws9tiacWinJB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(4744005)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6uV0lPRx7u9hgViMCDMyhbQcU/1IoLqqYJIS9ea8vknrwEJTSfuahP9HNJNj?=
 =?us-ascii?Q?e+i7o5FxPglM7YnfI8SADwwzO/dGiwOUxtjFMkOjvRrihixuXZNF89BRn21x?=
 =?us-ascii?Q?sE3cSN7W0Nzs4VNNlITVv3QNRuh0hg/3SlvGdggkZ/6wPlPU5CQ+6OWjIOu3?=
 =?us-ascii?Q?nAr/89Am9YHjCugqFBOCqzzx9UQ6qUHyUifaIJ6WUqtEWdTi4BuZ8woQsaqn?=
 =?us-ascii?Q?YdhqOp9CrwOo3nnYG60ktg4n3PPSJZmc7H095ZLhKPMyvPkO6EO7TcnZU1Y+?=
 =?us-ascii?Q?X6MV8YtlLkbjtQOfP3E1AYqSnz2pXS6oeU1I8X/P1YCwmSNu5fyIwZAMx2jA?=
 =?us-ascii?Q?qd27rho5k/KgQAAnRMyC7dpNmCC8e4fLTyu/TPiyqyDkF5QdCYTeC8WzC1F1?=
 =?us-ascii?Q?1uYClNVB+tdB2L2Y+XOd+zZr1EAH6++urk9OVuWvVjeRvgmtPpFK9KW4C6g6?=
 =?us-ascii?Q?aG6Muek4GumXmOl/HIfGGIt4orbnZ4DOJnPgUWPQWyauycAa7Enmk0dMf2rr?=
 =?us-ascii?Q?7g06ZVzIXiL+8MiQvFxSgy4HRjZTGwIaqe41bOA3MFic4REPiKJsOkvSbqZN?=
 =?us-ascii?Q?XRhBAjft9CXSn40SUvewXfnWngwO8xolJpYBcV26JXIkQZzKNR2/ACh+bUCO?=
 =?us-ascii?Q?fETW3Ofx+jc9CMEI2KnYtpUiXsgt7hKs3yYXndOvWBUWNOsTygxCfk9XbrlM?=
 =?us-ascii?Q?0ZGPAHmx7nfDkZZPDy4GMvslrTk4dziZV4Rs1LVTCuaMXiIuI1OTTnKeGIZ4?=
 =?us-ascii?Q?hnW5u6BIW/q77rcDxgEw5cAiw8AitUVVII9bvdeetyFTZd7bhTaCzhFQxuwg?=
 =?us-ascii?Q?JoNvdKzZmTYkYc7lFqwObuQvfV+lsaCRnQDWUknyF1SdjxWeQcOnv9pLjeGD?=
 =?us-ascii?Q?hm+EEHffJZ/K0lYLW/3/piCZkkeyfrz5nV2q60V7ikq4fo0tX4c+0O6/8P06?=
 =?us-ascii?Q?rxphPBDbPZCt6j1HMWTgsw4xZFzDJN+qfoGBprLkdxA6eS1OYQTeMVc+Jxly?=
 =?us-ascii?Q?2yVei6xPdALG9LpSjC1IRTXxknaPcBRtyntlLDOhG+8NzOeNb9ojJ1d+u7h6?=
 =?us-ascii?Q?O7/tV3BkLrGIo72o9cCXs8DBED0lSS/YbvgfqvdBwIGelk+xdWi+AE46U/aa?=
 =?us-ascii?Q?PQP81XF289A6mLvIYXOwTspkitES3mQYvoCLITsLxdiC/q7h2C61fu2KzO6L?=
 =?us-ascii?Q?BxERex4BAkK7jFhl8FXogMleOXNsq8XyM4TyV6A8XzR0waP89c5Yo8aTh9kv?=
 =?us-ascii?Q?zaNgJVKszXjrxcMCwVSmRTqOHby2nmGN4K8yEpUOJtTSqUTmH6RmMGpM4SDc?=
 =?us-ascii?Q?ZLY2m2DUCGcqWcF0xE0HmFKl7KwdgS4EsbUdzHBuxrwWSB6lau/g0Mr3xpNb?=
 =?us-ascii?Q?9XwsZNToDylj1sAvoeGvV33Wlrj4dHjWfDu6865WEbcKCtl7RYPj4j06po1e?=
 =?us-ascii?Q?Au3oRSc1zzl8cR4ela/oS59kkbqmjz1Ly/7NpebPhTQiev4en1gD6fvnnl89?=
 =?us-ascii?Q?jXBFuLBB+svzlqGaoP3K9a5QlhnSMSJse+dACo+rqeAXwdyTCdBhDxbLof07?=
 =?us-ascii?Q?GJVrsA52e4KdK8/c+yO4VGRv9UAdliAVz0ILSLSehWNabPdEV9SBqCraR2qS?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b33dbb8-0a6b-4cd3-008a-08daac0d6a13
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:24.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5WN0322K0S+CX2Yv1BCnmQx5Tou+NqWGV32P9I2Vy3i8UMWNZeDajubaln1SYedKB3V098P8eSm/ZYXlYLtGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Pass data to mptcp_sched_get_send and __subflow_push_pending.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0f062bf63447..18e439e180dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1626,7 +1626,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			continue;
 		}
 
-		if (mptcp_sched_get_send(msk))
+		if (mptcp_sched_get_send(msk, &data))
 			goto out;
 
 		mptcp_for_each_subflow(msk, subflow) {
@@ -1647,7 +1647,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 					goto out;
 				}
 
-				ret = __subflow_push_pending(sk, ssk, &info);
+				ret = __subflow_push_pending(sk, ssk, &info, &data);
 				if (ret <= 0) {
 					if (ret == -EAGAIN)
 						goto again;
-- 
2.35.3

