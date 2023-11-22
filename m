Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECD51035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ltaY1qfG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mC/v6Kivak+q9AuYXxGfFiTpge7H/YpkTVVKMq1164kJ9EgALCL4vi5wLecrt0TQoUxtzfxPHZn6cqYNcLtORWtWepeDcJVvaXhWHTVriwWlupnoBFDJjAs72z5WL7+/z4YSHonHVRLFCMoDzLQ9Kg8RMwlzGdr6UukyRPJys1UINXhJ3cKCxiitai/KeU5q1eJFso/Z2CJx+UUkAuKeaNbp/uu54rj9LhEGjmwqMV8UndWRF1u2FfHfIiUH9sJVvCTHcDwrrvsND1tEpNFwfwksunD/GxInsNSdGTDcoqU7iZuHcAR0lu66pm0KFRK+KacrEcZMVXA/4cbs7w6Cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysUkp4mVylQeoPS+00bES1AMp/um1WXzpOnC8sAj910=;
 b=iCm66ZZ2XWLviMQpDGYxxaQP9NCyESt+4hPOCooIJ/+3cegVo93Dq55MbpEW5UzcUsFJgFI67pgAO8Frb83PYdAgqevOFtAbN3bxFM1q452irWp0CbRWT+3YmXjXF3VQulD+mkfAtgJ3Igw9jswR6ITCPg1lW/4XNLsT6OgliLbnmTJ4bl76AVcOtfM5ASQiesRigdE+wpuvXTm8n6M5oApgy25FNWTzGOfePXtXxTx7hpUEIWKnbqPj0T49AymWGjYP5YIh4+cOxU786QF2z5ojnB1C1mmR67uh5D8dUNZWKHFcmH1xc4Q+KyqWcqTTyPhIxyu1iMDG9Vkj1A84Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysUkp4mVylQeoPS+00bES1AMp/um1WXzpOnC8sAj910=;
 b=ltaY1qfGJPP9znFiFyfvhO0hhd6Vei2F3iI3Os8GJpvy3h1LzCs7QIN+GaLXPrfXJci1gLBDQKOiTGMb9C66Q2PoE+GiwXh2m2Jvl/Dd6yx/dgbozAPllIXhzRVFCBKw1aZaddgK+4vEnOE+S+uLOEBLBCCEy6b9CiuTB361GQD6oVS05bC69xJ8UwvhaS2eyU0HyfGLX3mhpEG/AJcNHh5CJhdyur86d0yOGz1ditjyjfPEV2pFnwg7c6cUzOKe11kQ4VbwgGZJn0dKXoG1qsBsMX9CN6P6432+OzV6YWRKV6SrriOknNsbPHVxMkafkzh2h7gJfk9Iha9BRU0Egw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 16/33] selftests: mptcp: simult flows: print colored output
Date: Wed, 22 Nov 2023 19:31:04 +0800
Message-Id: <6eb7d66bfe03fe769f9cf058684e05f9bcb4280f.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0030.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb4431e-033b-4be9-c97b-08dbeb4ed008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lTBQoMHNL7wzpBdwXmXzZDan8J9RMVPF4wLV86LwttVazH8Yyk2Ptzj8jV7VUFiwMU5ineLBrIm2vzdD2v5gTQN/zy5Fw9qOvYnUUkwaOd7KSO0UW8TVNG+jFHTDfA3fq+pp2+QDxJ+ou1AG4hFgpA0LLhACXSFYVFOcF7ZPzbDjY2XR0lchTTT6ZhF706oHakQt0OV9eMFNWSnFQLMrE7aOwdPJJ221Gr6AOYqjHUGSc8vJoAVMg84mlIsNNhXjpEnDHfGRRvo7b5cuDWIXzFS0J6cpQbpDYXbKaVzfNdY5DgX49ZxN1dUSRZX9Eqk0rhaTDYgvZdkWd3Ja5FOqffb8qWqjpgNBTcRViPS1S8nd0ilqWqSn8u/g50F8DpKj69gZhwaTxFplQRg6cqddtAQ+uEsZnA28rYAYPCA7+UR3MLle9zVMIhQhW8+UPz7P7+q1/i3SA5Ik1Kt7aFdaBI1R6VOHYbdYwmtLzIH/IBkdOg0WVcrS0sq/agQNogyk3lllqLjid94ctp0xnA/hP/J0OEBlwyzcgsfLxKSGORyk5KRIAuKXKA5s5thVlsRyDGt9oxNQzirNvbW2DIUYhpZmrjriElGJQY2qyAV3Acc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y61kQR5yDn9RTKkZMNqMN5n3+bHIeNN0lc6YldQnG0o8BXdSwYMeRay1oS5R?=
 =?us-ascii?Q?SInptrTdff3bLMuPjfqfXnpjzgOXsWb5lEypYRbK7GRQ0Ss0QHGQraw1wdbq?=
 =?us-ascii?Q?/9cOABB8H4Z47JdpcrFeC5AayTqPaJvITdC86BqMyRl7ab3pQc25raAuu+tG?=
 =?us-ascii?Q?RQ0+Jj1QOY8MaoYo3Un0qVwcP33DJhX82yY8fJCrf1PaJODFJIlnqUj7Mc29?=
 =?us-ascii?Q?KkTeiOAVyGv/ryQqsZA3tpvNCtCmDqnlVXqhti/kbs8YicQmuei3JZWZVJor?=
 =?us-ascii?Q?UvYmcWGu57Ju2KTz6oxztNBdH9pI2AInq2wqKYAj+juLZKz/rGf4tnUn/q5p?=
 =?us-ascii?Q?/7O4L6xKSy0G+zA4ab/cURCLdF2aeveV5BR7KQ0pOrnfrz3pbS1eYxe1uBkp?=
 =?us-ascii?Q?zfLkxwt+zBknO1BQce1Ze4KG/uAEyAA2rWN7XlJPDLPFpWZDyHWzutWnk5Re?=
 =?us-ascii?Q?tWt5ugXbwIBydpYkB5hfkizvn7qbW6aLLtGbIqgoj7uK4EiQYIOfUbYNrL6u?=
 =?us-ascii?Q?8IYdqOGBNyDW67UxSvnxcMDl9YqXRAeLhf6Qar07N765UTBovIMJK6lvYkPj?=
 =?us-ascii?Q?wzkMFc14R/8hRQvlbvLj3dNIJgbPvRNnpilFVgNcWCzC/W+GZZZ/2eq7jptR?=
 =?us-ascii?Q?Usxe9h7IzoXBNKIKn05T4cxG7TohzxUaWPmPWz2+tvMuC8pztHwG9HYOhVFV?=
 =?us-ascii?Q?rrXA9L5bf/+9Ps45iOLzG6sPeyvycw70SFeXs0BGdrVnHnKIT32DGa9D7ajt?=
 =?us-ascii?Q?SN868uu3h2f5P1beK+D3Py02AzO0ki9UPPIrHvdt5MRuLo8/oeZMpyzR6xtZ?=
 =?us-ascii?Q?O2lgj16RQLdV+9tJ++e2v+h0SGcWY7kLSkcuTyWLEa6a2fjYWJoyyP8Mfwck?=
 =?us-ascii?Q?x+lBZB+kgpopDmh2dSwJBINjmtoD63N0bQUNHNR2uv8rexlBJLb5QSChrGgM?=
 =?us-ascii?Q?c9vcG/+tR2jI9b9LmEPBt6dFR/3/opoPSYRozDBvvxw3PSRimuGAIfBhisEM?=
 =?us-ascii?Q?c4to89vr8m4K393JauKRdn1SYrxlQBMgurXZ3GnsAMkVqpowSpIJ1i1kuNu6?=
 =?us-ascii?Q?oja/7VhhuMgb1QEWIomHAJKvKMD4gc0JSgYxRsDOdw9TW3ONNWnUft/4MEqc?=
 =?us-ascii?Q?qzjvA4raoG2FN6vQJWC2s42mlrP5dFpHIRcnfaFeOz7NoHVSRM+Sn8DPYKYO?=
 =?us-ascii?Q?MSwai814dUpL17wWMI6fkaRbUET3Kmz7BgniPvs2xXKOevK+4kAYydoL/mO2?=
 =?us-ascii?Q?xmTA4Rg4nPqWJVe3M+bGkfvxYm1fjr1fvkSHNe3Y0qlfCOpScBD2x4Wt56aA?=
 =?us-ascii?Q?hAbWIlaJ0k1d9Wf9/0ZEi9LF/E8MRKvr03arfYaTo2KYRmeEd65S9hEnUrGA?=
 =?us-ascii?Q?0sLIiHtMTaCju3iQNFoMjqQlAIirNf+u/xw6TBAKhw2nef3WJcvf+U7+87+B?=
 =?us-ascii?Q?Tu2ei8ESnOCsJkW8o4IJybIFeTr35txdJaowe9j9SJJB53xFNOxoSGYk2WZR?=
 =?us-ascii?Q?drmBf+28RVd4PJsPNl60Xs5jYzlaL1RUHTnn45fqdunjkdizJxLnzSjcBH6H?=
 =?us-ascii?Q?fHu8cs/mkiGLooSzfcf2SwSL8Nlb0wERFdLfOiN5qmKTPZJQil8QJ5tVLy4e?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb4431e-033b-4be9-c97b-08dbeb4ed008
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:13.4276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 009uTpkHQFRP/A0KPBPGVa//RI+7uv0wRi7U9oxTYyTJPRkJeO/mcnBKXnjt2DvkMq6qKlHW4wq4c3pMMQjIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

Use mptcp_lib_print_ok() and _err() helpers in script simult_flows.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index c1a21cd8c076..86f021bccae0 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -175,12 +175,12 @@ do_transfer()
 	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
-		echo "[ OK ]"
+		mptcp_lib_print_ok "[ OK ]"
 		cat "$capout"
 		return 0
 	fi
 
-	echo " [ FAIL ]"
+	mptcp_lib_print_err " [ FAIL ]"
 	echo "client exit code $retc, server $rets" 1>&2
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
 	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-- 
2.35.3

