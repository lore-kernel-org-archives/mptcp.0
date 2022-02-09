Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD51A2F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644398507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RCdDpcjDqQaX/hpXhZ6+Z5WKdzIs6TDA4o+VElNevyM=;
	b=B04b79fm5Kp4kQ2yrYOVzYDVqwivQDiFNdsjZ/Sd62tsy/OWavtroFZidt4nAzBz+wXf4R
	d85gWNov+t1Xc8hSxuv6Fc1a7vuhyNiYSiNEojtjUnIRjzUatIrr2SschAWGSsbbcaYK4E
	+pt/oTYdGL7DmJs6EjWgdlpjvSBQ25s=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-cZKocIzMN4eLu-XORk6Ogw-1; Wed, 09 Feb 2022 10:21:46 +0100
X-MC-Unique: cZKocIzMN4eLu-XORk6Ogw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnL/SjX9GxaTrqcmzVyv9wc8IZsPfR/KW/Mnglwsf18EycJShE7epQfjWPMM30RzvmTkOWJu2q6DhD+/sCx4imSHeikjFsJ5BdbeKXZeJQWVL6PCdoJwkHiuk9TCtaN/KnBXJNPDTor5ZSMlHR7Os0Ph6ot+DjglVhJ9V8qrS0s05ZGLBYPf8Ld9XLymXqngo/WdD7JD4Sieh+RceSX8QU9sIVPOtttP8eJ/B6uB52HESvUujxm6m7yM/AKRfw3USy7xqr1sGffLng6XpVtzMCiEDLm8m9z5bNWSFw+ds/SKQgb42Ut/TWpzL+BueC2T60wsBGpcypJCbovP4QQCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngiac8WgtFwk0pMGuldkws35rzB1mRDyz3BrlK6o6NI=;
 b=ZIUqjmLzMOp0odpmgUSzgyOXyOG0JQukcMKaIAvlfMItLN0yz+N8pD+xGmbhyL7UdT2bVuMfL4QY3dx/tVjtTAI1mIBF7XdMEcLtiRj3OKH/B9sKLeh3pYXxVEH3/4tY/ktDrKQ5UBptbRMcJzZUxSQVZAJMPOxLX+vqu49aD0II1e7lTw/ugRyxEcr1WmSQLLQTUUHuatoKuKnUWz6l/uupbRCpOq7QJDYgNsBqigp6K7rgKgFY9KeX8mTskwhidZzb6peuXjx5hilqsw3IZj5YOiLjVLUk6x0MKaieGQXEocsKoOpVzHoOw7ejvn2zXOiHYr8cCqoqSllR+uKLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB2734.eurprd04.prod.outlook.com (2603:10a6:800:ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 09:21:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 09:21:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mp_fail testcases"
Date: Wed,  9 Feb 2022 17:22:06 +0800
Message-ID: <9e7b9137e6b32792597abe9d541cfd4e3f4fc4f8.1644398503.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a61af39f-453a-4ee5-66ef-08d9ebad9769
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2734:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB273417D21B1D511111F08DEFF82E9@VI1PR0402MB2734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	peNM2s0iYMLR74VGyG/dSmDZYTW53vJspH9exHl74hqcRBqaDuXdUh/tT/0fdQdpySq16gPb5HXf7AxVQwkgWIrM8eUokcW+spMyx97oFZxyOk7QecPf7xzvjRCn3cL7bNgYK0yAiGhcDUjoSJnrIFhVpWfj32V9cblQ57xW1XOx7qRvIcA30kToGUG25w391xVdsJkJCT0rFxxaeqDrFanEijxf02Y6vClUpkmm3iTuxqiJuuKknakffzaEm/z8/CN8zhZzNjZ/5/EtIlosxs5SizUY5KgfhLStP0/Nb0KjoaQAmlpSmqe8Pz5z9KdYTAFhiiQIeao8gC7/j26plGDrRtkUGgFEqwgF98Lb+c18O5uFJ33/l379TgwqinQlvgfygoIX8sJ6OkBBNgON8IQQGCsjTK+c/FNZCyV70YparrpqIHoMHYnxivZ6xfpQg4CRyvJsbrwgSVO4j6leiMW1C5hz/AWzwiwwS65xs7Nh8crTwrwfAAU91USXQN97AAp/GB57oYoctNB/wCqaKA+87sknFqY3pTt4ImO9k6BjET8kvmtTRxOP+EnA/8g8XjGsVI0vQlI4u0lV0/ZYAmtPQJkqbAn4zUP1M3BRRmt5VJkDoDzl0+GDjQqbbdLhIvooYTayeNX4hiOna2zYYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6486002)(508600001)(66476007)(66556008)(316002)(6916009)(36756003)(2616005)(44832011)(6512007)(55236004)(4326008)(6666004)(83380400001)(107886003)(2906002)(26005)(8676002)(186003)(5660300002)(6506007)(38100700002)(66946007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dRxCu+ZQY/NtTfggzusbQVlzWxvhJf4pr2zBoc1jhCXcAqCUP+3mHaSL/8kj?=
 =?us-ascii?Q?o7k+bqeJMV8nEqb1DXS04DXgI84ky8ulf/SxE/Dj13+KXbhIei9/1M/t1BuU?=
 =?us-ascii?Q?Lod/T3yQzGUWpb1hVY5bXZL3ODdNGxRU3gQbm7L24+Vyf+V0lGbZe1TYLTlg?=
 =?us-ascii?Q?EFKwxYxX232iMmL9d85HiplbkfwZhpvm1lm1ZqV6Wft62YtaMwJl6pRYNMNE?=
 =?us-ascii?Q?xEeS8VtvyRoSzmUkWp3DeQNhgiCWpOtz+B6YQ1IApnEP/tjxzf+cyueOsGq9?=
 =?us-ascii?Q?3L4oqpc2b6ZmrRu8NVGYzhmKtvyZYJVocUuNed4ble0OIeKZkqJvTN72dd+m?=
 =?us-ascii?Q?oSavAGttb/SI1xZbq5IVNensWEjREiMmAL5HWoXqrBoccXZQyngDKFzVRvzX?=
 =?us-ascii?Q?VF6tsLLVE4PdqqeBW0q5xhaxV9t8qzdqBeYr3T8BwlAaYNFuYHFKQl9v2fjy?=
 =?us-ascii?Q?wy6B9kwNqZjVAnYSeVlWaomvZh6cXHy/BKyDH+kbVkmiwKdhDIGFuotm4qad?=
 =?us-ascii?Q?NQtnnqU6cHPKde5R1S/nYVG9LdpaclnwwXzjgEtF5p1UKgzt4oLS9stPVS5I?=
 =?us-ascii?Q?WgfKGZrOfShPFE4eRR4Uh/GapSpqffeMC/x/xehK0oKZyn32tTzAdes83KNZ?=
 =?us-ascii?Q?wWGhNZMEbwsINTHMB6tCsAX6RO38OisJOfdXRmXGPcooTfrKkEgDx31Fo2Z5?=
 =?us-ascii?Q?FYQzLAItM3OXnmJlYlzEtWfv7NSLrkv7kZBS4OQkaW0VU7pgr7xiD1/IcluI?=
 =?us-ascii?Q?KIbaeKJZbu3tLkI+PQRTbvjvZuvxNT/VfWE8G+qPec305JnNXOAi17VBDRzm?=
 =?us-ascii?Q?cwyzzdqzERPHoeZmwff8AprKejYsryvWwzSP1MukaCf5iBc2DiveH7WA4Jm9?=
 =?us-ascii?Q?/Q7GCpDSSxbNOOnOeMGeln9ngFjTLVMTUfbqhH5cTsLPIlG+QjB7Ev5uxEyg?=
 =?us-ascii?Q?dkVAOC9IYYJGSmIhKxAsmYPmbPUykHWM3RJ+5x5700PnWyLJjtsNf2+v0ltw?=
 =?us-ascii?Q?A49E+CNGzl2ofXUNmsaiXHlwQtFyIZ8f96/NTJK8YX9IIDajBA/y2WxfoSVO?=
 =?us-ascii?Q?ASMYyYXhulBxAjVCmhohT9vgQNsA4NQ7+OTusn4yE8HwGnAKj/x6ZMtyhPpn?=
 =?us-ascii?Q?W3ydnwvoGgWTHgfStnrA+La/2XlyfEm/KdVhXb5x8mZcjJyRJ/0gHP0OesVV?=
 =?us-ascii?Q?7a/30zeCxbEBt9GVNXlTqdKCOoMA1vbTlzKDYQ2gAm+4ag/NmjWSEjhLvtDp?=
 =?us-ascii?Q?2hu5Qn1aodoCNDUgi/6tJT9bJZMRIpjDgBOGv4GQjJLoNWGuUHfLNEr4jfgK?=
 =?us-ascii?Q?s/zEkvmMWsFGs3du4YUIu38sv+VNPSTwl7RWq4vfK+OdFxQqy+zocBfuCJfo?=
 =?us-ascii?Q?TgsbsXMfj0iYYGtHTWa6hDdydUxquEXltp666Y1cRkV2YQA3Cx61uBO06eyn?=
 =?us-ascii?Q?AIPP3k78LuZgzYTHTIwxcDFlEFwNdq+y/YI47oHBaflegX3m9o9p+5Zut5Oa?=
 =?us-ascii?Q?79N/Z6+TbyhYLZ883E5k0qQLa1a8XD7m+Er0LkRo4TjorkVJDCe26STW7OHu?=
 =?us-ascii?Q?9SKInHdaRM1bVnMSW3zX0Jvtw2zkx7rTPrsYaIRqH8OwcNahSueQnQEZOFKt?=
 =?us-ascii?Q?nmkwO0iyRNE5CJgLAm56nCc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61af39f-453a-4ee5-66ef-08d9ebad9769
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 09:21:45.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AN6sZ5qFnaA4X03MWYfKH0NEs32OEWH2jhf27sSPtOY7p+/2OSqaipJaMjygVCpyHycoub78iQjgloa0bcexug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2734

Use '|| exit 1' as Matt suggested.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 880430058492..62bae737c081 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -212,19 +212,15 @@ reset_with_fail()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42
-	if [ $? -ne 0 ];then
-		echo "SKIP: Couldn not add the $tables rule"
-		exit $ksft_skip
-	fi
+		-j MARK --set-mark 42 || exit 1
=20
-	tc -n $ns2 qdisc add dev ns2eth$i clsact
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100
+		index 100 || exit 1
 }
=20
 ip -Version > /dev/null 2>&1
--=20
2.34.1

