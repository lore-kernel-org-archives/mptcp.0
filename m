Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA4111C97
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 08:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULjoAs9ouetnWRRm0Jw4UWfBuahsZI89a7Vd4rV2tsgV4aqwBspR9AS0HwPEvmnLtJFJdrpk5xDRon7GXGV3F0D1jnJa4XDhGMACUMNKrrbARlIJN4MXiJ6yf/KU4NIHU8rGV43RmGpv8L+yc7KFMgyb7JHuTQVCIj3TZTsbMhOpEwP58ze9vY1zFXxpxReKN3n5SRt+ZCsJ9tGoBh2DQCY3X4wE8BkDJopBjey3WM66uplS2P/+k9m0l0RmXCBoEWJwFI4qPHHtx67LkPDzywSE9vwgaZfj8EK5eBieNXF4QI5j5z8wonavKtIBAqGzRk0v3WTVrFVEGKDSQtS6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwrIzed/H/yrXk/eD+6R5hJCGEi0ln5Cc7BQuqsMJ/U=;
 b=PvJ4g54OUL0rdLQQu1Xxed5w5uYtepQlyJLt4BMocPwW/ZZpuo+Re6QQ98TKC/rBAPGAFsm2irFdWjA11l2G/L6K3zN1UArLSwICzLuYaXn4xp4PZh4z7pyotZvvmbX326/ELYaU6UZJh2tnMRiLgqlkB5JlxXxNECGoh02j2gLJIeFaULCXAq5y20EzxTrs9lPklLdRs4vtUNk37fqXxn9IOPXzefSyku977nPrP5ZCdBK+0UBF3KBJqI3OqIez+JpeGQ/VTUz8RNez7/dyJGYBqWGRCu5StznUZQd08iapqm2L6n8QICvkJ9vlFwINMufuN9mHIVghBpjb4OJ0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwrIzed/H/yrXk/eD+6R5hJCGEi0ln5Cc7BQuqsMJ/U=;
 b=iP2dtm444RlienC3nlfbxbHX58ANMQ3U+6MTetIehZcvnvoBz8ejbVB0/uiq01EvRzAbpjCd/3v7xEj1Zt4Z5zPY2YPzYYk/HZ5+iKUdhiKYeby6vdaG1GcH70IL1qKSkW9UZ/PsOX5o2H2CeT3nkXaoF/mEn1leL3dzelBiwbdqMmA2aY1rJYBbstvOsfCJhusEs71CmkMxAGFiLf1cSVjC4T8pyxwP+YXqO5ha9BcSfhuKpBEGtK5MqaIfZWbpUiHQD2zEv2zM63xZIrXps5irOe4i599Kc6O1v56EqWSmXUangUg1FcrJoLiXLqO6+/zDCFzsge3LzwPyr+M91w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8799.eurprd04.prod.outlook.com (2603:10a6:102:20e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:18:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:18:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 4/5] selftests: mptcp: check add_addr infos
Date: Mon,  5 Jun 2023 16:18:07 +0800
Message-Id: <6d5a0a743388b88f2d80829ad1dbdeccf8213865.1685952776.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685952776.git.geliang.tang@suse.com>
References: <cover.1685952776.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 932f765c-d1c1-4093-a349-08db659d7637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0OsnxdLWbDWdSN+4h8gbzG32C/j6faNPPr9yY6p00J2X0qEHFIVgUtGQ5526FwDtq/vRM7uEiD+iDgDP0UxITSty6VpKYbI3EUaF3ljo5ab0aoGrVR2x9ig/mLa9AMxq7IlGLNlGTwaFrSIGhLQiUpVu+zfaDcEpONsJ3Evbk159H9TZ1to6CUwGdIasP8Dulwckxx+QRnhM5KN0++8jC1YPWmoFu9pfog+B9dakUNQhVdJMVypkOhmEqSpixl9jntwHn43Bfu+ejcJuc3RC9vU1qbL3SyBlPQsxR3IOOn72HPYQ6esoEg5ytSbPQbvQO1i3IgYyK+KvRjTXv3dW2mRf1ixDiPgDUZDhQatDRha+8+N2gIarZ9cAZ+cYsfTy5/8ctW1zn8Bv6bxNIWWcDfbWfxJH4ZwQ66l+cD8GvEhA5qcEp0mXzoeOrSlbpBcQgJ1Gq80gTnszQK7dDhm5awMXXYXst07ArrLUeJTqCm7Dlr/Vapfm1J5DdnEq/UTwlMi5GExteUC1DArQXyhFGjqfuZ5fCl+SvdxnB4IAjquoZ6NVAI5SeRwZwhlfNwI9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(478600001)(6916009)(8936002)(8676002)(4326008)(66946007)(66556008)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(83380400001)(6666004)(6486002)(107886003)(6512007)(26005)(6506007)(86362001)(44832011)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kh66g/+RqeV7MQ/m9J3coNIXKcK4uydTJKK+BBH6GrfpWOmX6SJaWnEWe0/D?=
 =?us-ascii?Q?S8V1h+3682QaUR0tD2WOKMKyYN/buL5irKbUVPi1+9IZGOtPFSCZeT6gXBxO?=
 =?us-ascii?Q?WVM2AuaId9FN0oUb27Q4f0mVFNgHqXllihzrnH/cJ8F3nDAuYPuvumzuIw+K?=
 =?us-ascii?Q?esjknVlSfFk/hatQTvCdQrKU5xRQJX9DryhD4czdCm1lm9ws6NkufmrRLtnD?=
 =?us-ascii?Q?pm6xJgwOKcTBHy+oJpL8D5Va6+ww+wq1iBb/FLbNsuGcI4/bNVczdgc6qw6O?=
 =?us-ascii?Q?ZuUMhiq+0HZj/7clOvXLwvl/O7wUCgz2Ma3Q8h3JOXPrLd58YL79Lrt0Uy0W?=
 =?us-ascii?Q?aeYJnZP3RUa6noS5Ax9lsa9lO2U+fie+fZiZSZ6s9bdxyOqk1MF15VBrNAAN?=
 =?us-ascii?Q?xQpWQnomEzdof9HoP6G22BvUTNenP/bIj+s4nBCtI0jJkW0iij9unfCeyuLn?=
 =?us-ascii?Q?uhTq7saQWchyGHfplovPF/vRtrhez7Hj6Od/uoEvoT7cjCPoHgvNnmaKz01b?=
 =?us-ascii?Q?0mYXiHOlWC5RucPut4r2/mOxRb3z4dqJ4d+S2C/I9BZqTw+LcNhFURbWKQ1h?=
 =?us-ascii?Q?OBopkfp5KTAGgEab4kPelgWaBbQzpNI39u/LYr1FUNiYfVnYhKahTfSYjC1b?=
 =?us-ascii?Q?5bp+dcI5GM7y/WwZjwRFSCpP+XdoghoCkAL/pySSCxQIG0Gn+7c0qFvZ7xEa?=
 =?us-ascii?Q?ADv8go9xqck0MViPT5slSWjWg1vTHTx7pJPZAchovEfEMzv5NuUUeU8LRBG6?=
 =?us-ascii?Q?09xvuxS5xiGqkYBk6KGdHpX4XQSMKtgqmfKHPdDwl0hV8zPH2Wv1HpZZNYTv?=
 =?us-ascii?Q?76aY+w7ZxQE1NY0XskuGBlPe8VOt8Z8SKlzfydD7f+6RvANTBaO+Gwj8HHfh?=
 =?us-ascii?Q?rhYp2uvs7c0kMEel9U4o4jIShPb38Y9Rg9iRDimXHOMxRYTTzRDEeVdvmi0p?=
 =?us-ascii?Q?GHqO/CMIFhH840Nhueh+vdECQUXenwKAiiqBvAtZYebljWTajo7XSvtJbdOA?=
 =?us-ascii?Q?FY+aPB2UV2LNrRtb3gPS9rF8Hs2f0ZJjh467xxHuQoQWgrRApdIi5e2NcSb+?=
 =?us-ascii?Q?MnF8Qg0G42alt1Ou1yMhW+LuZmRY5WZZ1SEbH0Nftj/wk04P2d4WOU179Y6b?=
 =?us-ascii?Q?eKyW4FexiNH8MB41uNGsQny3k9u8aVPhFuL8WmJFuJkfBGxGjO6FmZpxvjel?=
 =?us-ascii?Q?8ejV1sTMNYSKfxAtx611p98VSyyByow0gQLAZ2HdULzFZoio18EBRi1zi+7i?=
 =?us-ascii?Q?n6rCgUc4aD1zb+eUPIZIf7C6lWIWQ9xJx2nwMj9VWHQ3vtxqEhrchtsNhC/v?=
 =?us-ascii?Q?B6/qX9/bO35a4Z5o8covnL5ihRrEYy4+IAMLAdPAcXkVPFYkiL//k6AsFeLx?=
 =?us-ascii?Q?3UzsgXUQLvOdCbbVja9QFfT+8SAM9vxiWy09lnBmdStNqqE2bt2KYCX80nfS?=
 =?us-ascii?Q?62XxJZRE/jwya06rD3TEyIZijdufgKLIlmvLNa+w0yqHPEf0Rz8RJqDeh6eM?=
 =?us-ascii?Q?+JrgmdQQWPA83cm3JSb3bOhR+/zZtffyKGsh8aKuWsz6dHXcf+wOEQkOt2OA?=
 =?us-ascii?Q?kOYVkKawI+SAg1SWzsKsaMRdKhoX8uxFKPv5O/Nw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932f765c-d1c1-4093-a349-08db659d7637
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 08:18:37.2312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mog5Kk21sRbWTAXKEHfoP3cDpcfPv0uIhDoLMYq3+LLZqs6/givKkjh9cualCe1Kz6cy4U+hxB6cqNfCOlL1xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8799

This patch checks add_addr_signal and add_addr_accepted in
chk_mptcp_info(), and do this checks in userspace_tests()
and endpoint_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1a0239d448f0..5c2367c84cea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1718,8 +1718,8 @@ chk_mptcp_info()
 	local cnt2
 	local dump_stats
 
-	if [ $info1 != "subflows" ] ||
-	   [ $info2 != "subflows" ]; then
+	if [ $info1 != "subflows" ] && [ $info1 != "add_addr_signal" ] ||
+	   [ $info2 != "subflows" ] && [ $info2 != "add_addr_accepted" ]; then
 		echo "[fail] unsupported argument: $info1:$info2"
 		fail_test
 		return 1
@@ -3169,6 +3169,7 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		userspace_pm_rm_addr 10.0.2.1 10
 		wait_rm_addr $ns1 1
 		chk_rm_nr 1 1 invert
@@ -3210,6 +3211,7 @@ endpoint_tests()
 		pm_nl_check_endpoint 1 "creation" \
 			$ns2 10.0.2.2 id 1 flags implicit
 		chk_mptcp_info subflows 1 subflows 1
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 33
 		pm_nl_check_endpoint 0 "ID change is prevented" \
-- 
2.35.3

