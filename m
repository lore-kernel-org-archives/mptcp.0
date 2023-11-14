Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2044.outbound.protection.outlook.com [40.107.13.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384C4174A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dutxh/D7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDTiFqjsnnaePx7iElTw8oTFdgjehznZ7X11xmIBKnv+uKVEqSRmcqlVFxYfEtIxg62pLhyEUm4YiZ45tr5CwK1xcn1RtXRkYsjFhFS1G7KgRh49qi5uiJ6Qj3l3Sudb6v/OoEB2l6ZsZi2jSx9z5tKwvh4NT4hMX4d1Q5312PP2oiqbqE3r4ITeQwunRBn9NULTp4+5/c21QOnYVhPsUvNLB7XNAOWToVgoN0fp13cXIMcv9tyZOtmm4QS9MSHogjgOKKldZ4QCtrYCVMuu/cKcPeTF0i+ma20jkaj7HX4he/gJobOCNG4g3vGtipr0Y0l1ncxmZfjy5wgFWDk7MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+sZEd79vfC9K60v83ZLEyoGSfWpc+oamA46pSlT6z0=;
 b=kEx4UzABqBjEqi3+KAYo8XnpTNJGyByfHOlMX/4u5Cm8S72eOaLo1gU/l8QizT1baMuku2F+oBqzAtwFxxuoEyelzLTZWGYgFugZFDp/5hKv4Qj+/laxZ3Gs2W9I+AqKPKED1qG/7fst8vDKY1S6o+yI1fvR1LdiGYpqDC4RoxrzlEbPo3V17HNEQz9tVbTwq/yU1Tqy1l47W9/8O8AH6eczJda/JvNsrh2C1zpEl/iMS5ZoVnj/350g/4h494HuQH37O5WKbLpIeaKLb2RrhePkAcuTzd4VQCQCvatlwAvHpy5yrX5p0PTvtv/yJUGMJJhTeeEkAiYn/EIItPwSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+sZEd79vfC9K60v83ZLEyoGSfWpc+oamA46pSlT6z0=;
 b=Dutxh/D7Cws0u1R17Pj7nwRi5uBf4bofXtmt1UUNWe+gUA52AdmbEuuXTOiWg5mi4RVTh9F2vwGv5xryfaUI5a67e/D8urOHwLII+Cv8I26wSP1wmquNjw4z+xaCJEmffD+LE5JUP8OPRI+rQ+PPqAiEgn+wpX0gnMWbie2sAlB+BXr5zqEP9QWhj9xEU8WD4B3WVMoqFpaHv08bM7c0PG9AOPbJ/3LvsElCmzQHZYHjP3VYJgJu6ABHo49IFskovI0WXJlfqtg3LTVRPEhrPlGGLHkEXpRtb/PhBd5sfE8RPF/Az0B7pGwPC5YxrRi25yFwfyKw0W/i5HzOvq3PWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8663.eurprd04.prod.outlook.com (2603:10a6:10:2de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 14:39:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 14:39:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net] selftests: mptcp: join: fix mptcp_subflow_send_ack lookup
Date: Tue, 14 Nov 2023 22:39:29 +0800
Message-Id: <be920296c8454c2b3c3acddee67828e94a8aa32a.1699972742.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:404:15::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b481c6-7752-432c-a71a-08dbe51f7a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JT87PFiUXr2b1zYJDVaNgZTrko2s6qZTdkyK+bSF+cs+UDVnMyt4+Yup1iHpxu37SuRCb9j6ho+yikyau5zgWGzBfyQMlI994h/iJglFor0HSdt41F7RJunxqwb69ZSCL4Mo8vCjGWqRZ1FRiR1wh84gO47pmY2HiUDpu3RHE94K0C0UbapVrk5dAcClLaO3p2TiBtQD4o1BD0aM+xyi1B4tzL10TaEq5iJHgDEk3NlWeBmyheRzFjvwYjYlD6Q9/seuymssre/gNdQ/68nTbnIZT/P4XtCCmTKFIVA71tCjdKwk7yybOtcOjOMPyPwGukEYkyIm53elo2xLUz2CQinQpr6QW2HJTJcX/8hxiVCFakIYYolNSX1F8XeTDCU6RcmAcHziLDyhwdWlt9CwSHPyIfCNTQEJiYV8dq4OjnbUMRniK6nqvL/TpR0bld8S4qVHOqynfWqf1D3SiI0Oo4dlVRavA7rjT/q549ebPTP7QOLLI/wN42rTFwVWNxpgyG5xAgg01xEhEMawhVqq4akaTyKmbJQ0IbKsUWZCvX//vkxn35f6Wrj96FkmiJROgBwxR++oz5JRYIvB3eFxULvxX78cbUTOeL1pbwVLz5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(6512007)(107886003)(26005)(6486002)(478600001)(86362001)(36756003)(8676002)(8936002)(4326008)(41300700001)(44832011)(2906002)(5660300002)(66476007)(66556008)(66946007)(6916009)(316002)(6666004)(6506007)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lN+jso3TsAXEpi1IZZqVO+bCPt86ceZCv/yI3Lcr9Zuitl74kLuHi7H7HYpK?=
 =?us-ascii?Q?Mzw+SDZe0L3F4KeNu+jq/g9R5RyUWkv7gEwTWD5wMdVnXvICimwXHCZT9yim?=
 =?us-ascii?Q?RgPoJNTzybOtaeX+/KLIumXn2Tf4vRLyuCrL5Lz15bKDSVE9JVNn3V9cNdFM?=
 =?us-ascii?Q?Ftd9j/zoHfODZeWGaMMp5/ehVOUDkcut2s2oGrh5LLHHyQgXERMnbrz0WtG/?=
 =?us-ascii?Q?6o5rp9XoLgF2Q+Vch0sMzkv5UhCWxxxhn+KXRs9LStZGXqeVCSgOaD3dosn4?=
 =?us-ascii?Q?FX0O8yisFfOzQNOeVF7cd+ESeXhz3e+ZV1e4hBmpF+Ztm2NAJSJbTaqGFE6i?=
 =?us-ascii?Q?e16gF3RVZdwhCA6vqHxD9Oq/6BTn8vUTaHB08FvE4+5obo8KlFFgCv/dQSxP?=
 =?us-ascii?Q?j+iIGZUtKCn1GFcA2qX5Ig9x9U4tBdCfmIVQW/kQM1AcA07cZUvPD+uWgEon?=
 =?us-ascii?Q?p3S1fdyW+k9ZxuPqRkqoxm38RCqm/l3wRu93rLawKk7z+Wlg4ivjQsQPTe0d?=
 =?us-ascii?Q?tQZR1khO4r6+N9F2qRfrJiBHaZkqF7vPVRMLdrZqRcBMlw8bCd/QBrk+0u4A?=
 =?us-ascii?Q?7iwfzQ9NzxyfkCoa/agROU6rID5RVoU8se/O/Oi8PzXhqf4c5jID0hsWBIaz?=
 =?us-ascii?Q?7rz0xdFjGTK8Keh6HjsgJ6wHxHtvlb5p6eBngfWVDYoF9eJLtDk94oLoa5Mm?=
 =?us-ascii?Q?pZeCisnkNgJnqVvQTyn10tiGWdtsFyLJY3x/32aUXFc919CRBerP88wEjfUJ?=
 =?us-ascii?Q?AwDgSY7INLnGkIa+bhgbf5OJ+CPMpHqY37nIFEA3IegSuQ5OS6eCGFOV7us1?=
 =?us-ascii?Q?neBxKFW1DMBwX9KYLaPbIuZx2nBjgqSjhL5qsFjpkUEb2LqYQX2gRpetQf2G?=
 =?us-ascii?Q?pqXeuEyB7J2RopFv8sIQq0mRS6aIxCddrfdK1v2l6EMHZ8rs7jMJI3iBY1YE?=
 =?us-ascii?Q?09PQAnMnwP/vfM2HvVNZdF9KA3WrKPVFPgb0lVFgzN+qrhuHs7MQQ8nAS5Yw?=
 =?us-ascii?Q?CtZ0BdY5unhutRgGQwVOLBMBv3AsPo681ErtMj1yMc20B02Q0PfoaHS+pKUP?=
 =?us-ascii?Q?T022lzEeAOmGQS7lJBqQ6Lk00UPqKrt0Fs2VVcaI+m5h7wiU18VBFC+/KM5O?=
 =?us-ascii?Q?QgEn7b2vs/POBAcH5MIMwmDgrv5cPoy1p2Oc1km7AT/zT3YDEntWdjvZc9qD?=
 =?us-ascii?Q?JLlgfhohM1C4JDz6GwojrT+QvW+VVmz5IOIFmynkxGNSVoKh6aV1in9xSNsK?=
 =?us-ascii?Q?2zf123Zfso2cxyYMHX3ZA6CRc2a293sReGrB2IGqBghEqACexfJBImiZa5MJ?=
 =?us-ascii?Q?DabgqeRbf5Qui0pn7v1EvR6Ep10a4MDjIr+rPwPuNePKEogaHL5W4vdT/N2u?=
 =?us-ascii?Q?PCPNARnj5BMYQ7whwsc2DSMKXVXY9p6Ap7tvfQjq9+4Bjq9HINCPGzImyAcX?=
 =?us-ascii?Q?ddVKtpgPnh1t8kRx/rWcK6eMVWiRw5lAWNHatDZhpw74EdE7wLg//uzkd2V0?=
 =?us-ascii?Q?RDbyATn50bxX0RF2kuAfMAT1N/jrk4gGtqRo3kN3enWE03VUjFEMQ0ZFA5D/?=
 =?us-ascii?Q?nOIM8YewvIy6N9VhbI5fLppRSfZeNsdUQCqi7l++QekevpKV4EoJXuBrANJ5?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b481c6-7752-432c-a71a-08dbe51f7a54
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 14:39:18.0438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNU4pHjNeR+I8Gfel2PZoTdH3JJktOcVj2JnTIx8mZQ2v+f+WJYxS68eMsvtxHrFnWNhRavrn7Aojz5qS+FjXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8663

mpc backup tests will skip unexpected sometimes, since static function
like mptcp_subflow_send_ack may also be listed in /proc/kallsyms, with
a 't' in front of it, not 'T' ('T' is for a global function):

 > grep "mptcp_subflow_send_ack" /proc/kallsyms

 0000000000000000 T __pfx___mptcp_subflow_send_ack
 0000000000000000 T __mptcp_subflow_send_ack
 0000000000000000 t __pfx_mptcp_subflow_send_ack
 0000000000000000 t mptcp_subflow_send_ack

In this case, mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"
will be flase, mpc backup tests will skip. This is not what we expected.

The correct logic here should be: if mptcp_subflow_send_ack is not a
global function in kallsyms, do these mpc backup tests. So a 'T' must
be added in front of mptcp_subflow_send_ack.

Fixes: 632978f0a961 ("selftests: mptcp: join: skip MPC backups tests if not supported")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1606474232f6..6fbc70332caa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2755,7 +2755,7 @@ backup_tests()
 	fi
 
 	if reset "mpc backup" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2764,7 +2764,7 @@ backup_tests()
 	fi
 
 	if reset "mpc backup both sides" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		speed=slow \
@@ -2774,7 +2774,7 @@ backup_tests()
 	fi
 
 	if reset "mpc switch to backup" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2783,7 +2783,7 @@ backup_tests()
 	fi
 
 	if reset "mpc switch to backup both sides" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup speed=slow \
-- 
2.35.3

