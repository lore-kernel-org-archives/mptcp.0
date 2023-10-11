Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94A1F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DvRZBJ4p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNai0sZSkCLKzKBe9wrbYGXZmFSc66vRqwxkeCgYC4/nUvANvHmkPp+G2SPPRa7NFMBv4adPkzbilcBdIJCEGYd+BqmUTw/guy5prrHmXA0u2ZMTwXc8tQ+p4W57/gDM9P3UjeSKxQX9Qwd7yXOdanTr8kqk1zMsZRQA0iFUGhGRJWOkWRZzEysZq790sjlL2wxm919LFwapdHwyBtf4YzuRDibNNwVSIWZZnwWjfDLq4/+jRXyJlbtccfR1AjA+oZJpGtrba+UUKolKemA9/3Sy6vjJy+ddZxYiTSJ2iJ01/8IPu0TFePbsoGfMlaRGPbqz3shnkrTZUa/1Wlsk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyRPeHAjR9p06hdEUcyenPU9HoXnE+ZUzkKyofQnITo=;
 b=UUAv9Y0F7drjmzdGpU0QW7n99azuCcAycR7WKxxsIAy8hmJOXQpLXTVr+Q5N025FXPoEvBMw208HaTS9YLTWIPax3W/JVBTNY38sGNK0u48vNg5VfQAq6I3YC15Lh5LYYBnu372N4ARv9uKKF9v1KreU3qYfAdDEPo+8TxlHV5r09B9F7DfG+9g3G98S9x+2GItPX8y/w2HK3Z5vcTvAdx+8QTL1i3aRIrEjDXVubEhcB2MrJvQWgoIXS9vhJUuXhsSKHDB9dl3r1QrH8AimaA/tlO5b+Qcle7mTZ5UDdhpPbHt4HSIOe2Bq2+fdp7grUnofAg8u+z6LmEFP1W7NfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyRPeHAjR9p06hdEUcyenPU9HoXnE+ZUzkKyofQnITo=;
 b=DvRZBJ4pCrVdto6ePB3isbn0Tp/ZajElOMuiwaJvhqYrGW7pedaBKm9bpkHHSy8dCAAcUhsx14fQ27Kfn85D1re9FsSEqsMhj8bo7LeK44k2Fu3EpbLH0YA+7U9f4aioU+QIsc2kDgaaOa9XP/3/+/CHgq3D+QCEy/d9L5KvXeED9EtPcqf/tpD2atGL9ooejZHYPo3iXcRXH47fjGMbjOJ3QSMNgQEHe9GNA2xdKAdF34mfZ/8D9AbW6L7vBWdi1Fh6MdZw+G5HUf5DxE6f/CRLtqUGNMNlUruER935maFFCfcxcKC2N7sVoH57DHXsyGbOX+k+uGaZR34FvX7m8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:34:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 4/7] selftests: mptcp: userspace pm remove initial subflow
Date: Wed, 11 Oct 2023 21:34:59 +0800
Message-Id: <ad94cfc3e206d76f8e213d66fe2a73d335927496.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: a2619ea3-61d0-454a-91c3-08dbca5ece99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4YKcItnGhmKDmARm1NHv9gJ8zMAGeM9dYDXYLjPUiRNWehfQXL+tlC1w91PZYxdqh5Rz3zsl6W7bZEKrrmCgI88apeYpx0S4u0vmBCA5koppC2TwyXqIAuzGIjlG8lN+9KclTIvhyIo/J3jLtUWv3boaD+0t1Ro4c9fFBwd89NThIVY01RcEdNvKwU+3Lz3qj/z3tsjaowcVINpsnIRfPtm2IOiI2F4o/Dlnz7x7SNTUAxFnYkK1jzJ30sKC3+/ZiPb+5Dyf67ofidq7DFUftV0l4W76+/AKzi6VC4t9/hdv8qYTcmoHex/tRwojqSQ3kOo+54ZGOaDdflCshGuGdPr0pDxAm79nXAwRNmO8Ir52kB96uFihxYZwXsJPcBVbJo+u/q/HUqevTbHey9BYx2A8ScqksxQlR9YMCVeh/AmGWSNsQ2BPqZ3rCQfP7x0e8CDWNzkeUnuobtKGUmemmXEIm/SGcQ/7+luUfy3HJrHp+k+sE97KHA98rZioToS+AzJlUM56XUDR/nkwqdmzN1s30cxJqXs1D79Qkp6QDZ9wVAMI8VBXCgcx9TjQwqmU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5hiYYV7Kk6I5Ai5nNDzeM7qk5UyKmJi8CuQiKa41/j69lKmxLPT0ILCPoW7?=
 =?us-ascii?Q?SrGm0XIH7TXlAQH7Dzz7g92V1QRU+7mEiyskOqxLakgVPdLJBT9kN2q8QatD?=
 =?us-ascii?Q?nG/CMxkKVP+Gzm0yN8DWqUqo6JjBX81Yn/rjgVzebn7LqzO4/ov2ydYPFhG7?=
 =?us-ascii?Q?iUBg4snZ/FksNB14F8N9KzjMJx0zU+X0pJgFuQygKSxz0gO4FEIXJVxTJFdM?=
 =?us-ascii?Q?mBJajj0G8eoj0Fi539cpngcNw2ez78fdnq/y7qZh+mDUymn8/k4wG5xg+FB2?=
 =?us-ascii?Q?7XWU/8f+Yi1wsGU6vHFqNI+vGuFRaMO8Wd+754imHF87Q5tkP4KLi0rXC+er?=
 =?us-ascii?Q?tu2vSRNk4EK9IBL+jkpazwpxVfZhTYxbKshZlM7aADe9wRW2SCJShBB21jrZ?=
 =?us-ascii?Q?S4d5N+9XLlUSSPuPxwy4iaGr2O/U5lqP1oNYHBsTF4oFnUCdjszlx7a3TBTy?=
 =?us-ascii?Q?ixMVc4pPEoHSyx2Rid8icYsfWsyA/z4wdFA1XcIyfgX6KMuK3U1Lh3od3ZaE?=
 =?us-ascii?Q?8v1bHuYBg/wN2jMW1EvtUo5xhcnG+cAKr5VIyJ4al4O5yXgbd2BaIkVH0BtX?=
 =?us-ascii?Q?hc9GjuKbenRNb8jikeVIRp5taGBIrZ7zoNAoTHKzsewge+OxDXrhaCCZdGiy?=
 =?us-ascii?Q?yvYcsTFbdbXw2mRJLW3E1hB16b0G8ZwM6DU77DGgd7SI5peBKJaqwmtkYc1y?=
 =?us-ascii?Q?gJY/Fo56RAyIYVWKUS+8xFsIjVmeT/5KNvxRROVShnHTsHbzWhzPTPEnX1/m?=
 =?us-ascii?Q?MIBUB6gcLXudOm1RUyOVn1OLOSRI3nFIe7ibIP1HpEmLXdmm7twVVhlSeSah?=
 =?us-ascii?Q?i8bluG9hgrPZi1nOo2x8yzn+9NOj0JHkdf/luRZJsVhXhuTFBisehwdZSxQ2?=
 =?us-ascii?Q?KeK3RSoVYT5F3YhiCGwV2EY0ZOmxRnd7Q1VY8koL+e7hQQ/1IIOjyfIcF3Mb?=
 =?us-ascii?Q?l5fa/yGdJo/w3YT6K7jPRndgi1JiSDZsROwwL+/094ZB9wx+MQPKhN8cu7ds?=
 =?us-ascii?Q?a9ZdcpJ3m4FlyaGxYP45zWo6etMzDjzLGA/zNhm0iweyqUs6sAhfCqRa01AN?=
 =?us-ascii?Q?00boMekjSmVnFTYD+n0OzooECIgpqvlklI/j6VcyA4H/a2fmSh5etCdLZa2M?=
 =?us-ascii?Q?V0Dczvz/tXhs7tUGqshuiFl2ChQ5hEaE5E3g0sdzuK6h8xdTr1gUubqpGjrs?=
 =?us-ascii?Q?sfqxO7qTkCj+lycIGM2doIsH0XXRybadwqfIdGaBoKjlLHdO1RQa54OWhmuF?=
 =?us-ascii?Q?n/Ydu+hJO264LmML5w/d2bWW/gW9q9z5Xy9pnyImEhXrliuhm5shhm+3a7qo?=
 =?us-ascii?Q?ROu225Ze9/cRp4xZXo5JwVw7wsfdKYJPSVEfUr5MXiMC1J4GEejb8iLD12jx?=
 =?us-ascii?Q?OsHsdT7CY+NIYcJP1V7x2Vd8irrSFcG3AdxlqKoahkKsuLzSexcwJJGxW6Hr?=
 =?us-ascii?Q?yVzZken1GlYS36voMSZOrh499Iqz+RUnSAGNLo4hxb+Sh/DU3S0r5358L8Mc?=
 =?us-ascii?Q?QjivtZSlv2vKiacOfrC26Y4y6CVfrTyvakb5PdJOHrTGU6PwyHh2wSta5G70?=
 =?us-ascii?Q?/2djd+Vel/PO3mcfLQX5pUXE9j/sz/LM5JGwmNLp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2619ea3-61d0-454a-91c3-08dbca5ece99
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:34.6324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnnzaje5Yhtu5JwtSicQjAEUJ1K7i9F9nsIHLRNeg5fF3ugwvF/M50lwogmuycefnJbbCNfiWgDb9pnqpmH3uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

This patch adds a selftest for userpsace PM to remove the initial
subflow. Use userspace_pm_add_sf() to add a subflow, and pass initial
ip address to userspace_pm_rm_sf() to remove the initial subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ab6908b7b143..e1304383057c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3507,6 +3507,28 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove initial subflow
+	if reset_with_events "userspace pm remove initial subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		userspace_pm_add_sf $ns2 10.0.3.2 20
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		userspace_pm_rm_sf $ns2 10.0.1.2
+		chk_rm_nr 0 1
+		chk_rst_nr 0 0 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

