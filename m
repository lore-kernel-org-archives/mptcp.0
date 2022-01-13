Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F92C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd4e2AFgcFcFjQDy0IJna4J4mRyL7gobrT4pkp+TLNw=;
	b=DpmV88dL1oBjXn3BePGkV/YZ1Bt57S7JoVh8hZ5D5vAD7E84akAp2z12ENjIp1hz+ENOXH
	S6D04FWeV1t7YwVnxACn7B0RdOPqak7CKle1kxS3Fi1lQDUngH5h0dUaOI5uuZNHacgl5N
	UYae+/cAX5Kaqdi4cuVeW33rgFQ9fcE=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-O30nlrcVOUedofJQeMAYuQ-1; Thu, 13 Jan 2022 16:09:47 +0100
X-MC-Unique: O30nlrcVOUedofJQeMAYuQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoMnxlYEwn9WZmidnYLo6sxziS4Yav8BUWX2UgFtWE/pEyR+kNBub2UycVft9ADbyqcvxWAlsT7XeCJi8SbsXkCX4lmkyQn20Czimvv4hrTO0mGD2jOI5FozsUO5S/pnJUMV6Kdu7ekXnNjnLHRKQ83r35oiN66CFnL8jq8vD94KPoCQuUkzDQndnU5rTzeLFVpjG2U2Sq5+yCq0RYfVtdRnWmXdhIuyDCeHH6kml4SRyVivCkD90Qx1VGvb9RTKokShjyody4O5nJDpXnuB8socVt5SjDUmEKk0D1GM5qSQ0d4hWjVyYgHvIEQ5LAsQc5neZH3nZsUAL/qjvVDCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoJ8KRhayw9EuJihr0SxhpBsGAk86luyvXgy1cv9G/o=;
 b=BEfEUr2B1GHkiopeRLN7plGwqRcNWgOOrqBNwivxB22pOuA2t/qH6cXK2tid7Dk4IKSXB56G7SeIvk5rXq9tsZe6Ukhl7H7++AJtvgSOpZioUacWUipgBmNtBCq/h3I+4Li2DTGCa12u9clB+Pkq//DrdoDa18ZxEyfjCW6AdPRoQEj14wCrC30NfdLRZETgG8bgOXHiwWKrIarXSFfCJiR1pXanbiWQAx+4ieSxY6mHCNujpI+0UJrlMVMJMkm4h3LVDYRYvFZFxRhIyLrk2jSr/Wahfj2Xic3mbgXJE8LKlQ2QXBgKiIHEhN/XqJQic+0D4WHAUlADi1tutvR14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 15:09:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 3/5] selftests: mptcp: add wrapper for showing addrs
Date: Thu, 13 Jan 2022 23:08:37 +0800
Message-ID: <0b33d984c614b3ef3fa29056c3187ea9ef7fdda1.1642086296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642086296.git.geliang.tang@suse.com>
References: <cover.1642086296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d287dd7-2d62-499b-e857-08d9d6a6bc89
X-MS-TrafficTypeDiagnostic: AM8PR04MB7361:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB73612A2C75DD687909ADE252F8539@AM8PR04MB7361.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Spn7rKTnY5/Mm0pRbUfAWUO4+TehWvQtwxG3/Od/mJGmtTmTS7bbV1HZ3Ka+hw6vzdkL305nmt+VAqZRA3jiXKOvlweBgoxNkzwwl1/A0jc3WcpaYpTE68nfOlImR7PR/VegElCUe4EmIdQ6jXRq2ie8a5tGd3OogtHV0bk1n8OytYsUgtlwkaCkJHIkedGdA739STmb6XHiFv7iIfGp26zBioSkWryYTFZVEL79+dpAcqg5Bz98yo5ZwWaE3vmCZp5zR03Mw4GQbqKDSRF+2fXDWvIaPjTubEwZu1L6R5vdyeiTq8ivgrIQhpyc0OBDt3mc48Sx+Yot6MkNacOFpO0PTmOe+Mq/X9abwBdG3l4/dk7u63pROWLcWUJIfpDhJZfXJPEMe0LJhyd04yZ5AsvlViIln4kHPeBQxeG9mjz3QuA+hGpga3lnkzsnEL8myJheDHocRgzne65CX13S84L8yIv9eO9T50hwMzJydDUpRuAZ0sq0f3UCexdHZj32cVdB90FwlIsjilDr4Mwb37abb21fGdQLBDfpK9Ge5JOpCLA3Yqr4LA0IW3GeAPNz1emnzxqStvqmU+LVibl5MSN+d014e1Vz0egL80UMl0SRK8sxQLqLke0TP9Rf9nGYkMtAeTNZblaQcb0qugMmSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8936002)(86362001)(508600001)(44832011)(107886003)(6916009)(6666004)(38100700002)(316002)(2906002)(36756003)(186003)(66476007)(83380400001)(5660300002)(6512007)(6506007)(66556008)(8676002)(66946007)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?idyYCSnQTsGihIJLVkyy7WzaVjClOINKsHMhK4AsygUEEpXhkWCoTsnvzkd2?=
 =?us-ascii?Q?CusJwpy4cXiJhZkCqpITZ2TlSa5H5vk/QhSW7jO/TzlVsz3iojybDyxaIiN3?=
 =?us-ascii?Q?UOZVYK7mm59B7xLGTCxtTjciC7K3cmlJHm6HTjXl+hPoA5OHyx5k37a1OsaB?=
 =?us-ascii?Q?l2CTWhSV74mtCmSw+YYpEgu3SXIm7aulYp+6BfdCG0MUeVdtchj+OUkKkUUr?=
 =?us-ascii?Q?Kwe5JLg/bf9oVG4DFPlIS/bvNsg/INyKuq0ptZSIxELLp4acuaHKbwNrecaD?=
 =?us-ascii?Q?dx2PyaNf8IPRZHx01HWvgMT+Jn4F8YNCBPZNFftP99NAGJZPAy6awp/BJeGF?=
 =?us-ascii?Q?jHpj/63yFluBBplIBYkOPsyes43JqhZvDL1x4L7H25LNnpRwy6ZdGNYJFdiH?=
 =?us-ascii?Q?85ipGZl7clIY2HHNKu/LPK8DAohueLZrvYT/T3eWx0zeDs5Rau0HiVqvGTNw?=
 =?us-ascii?Q?ZI/2Lqz5K0wd147GpLZvu2fx+uRC82QqCQQeHg5l3h1TxE5gSiiwthuR52FK?=
 =?us-ascii?Q?q67VzPZ/Yrhayc5n6Q304bjlXt1O608WTbcb+I1XHsYWWBwYpM6azmKA5tn/?=
 =?us-ascii?Q?/fJnmbeStkVLqVXYXZ3BcaLerRrr9BzkIxgmfJof8Nd2z86pUE9KeCr2UAM2?=
 =?us-ascii?Q?RI6+GS3O/tndxjJxLweM+iWMTlde8rKSeJfGe7FL8Z/u4IbZ6uG+kDFSnang?=
 =?us-ascii?Q?2eYZwfo7yLm3TbEIhh/YQ7Wy59PbIs4nbIFbbNqdk4TSzvnX4Z/vd3UENJxu?=
 =?us-ascii?Q?iNqliFRmDBnld/5Dsoo2OxtJcdgAGKKh9M/RdiAsR+HfUHLaWs8eKZpYE81J?=
 =?us-ascii?Q?s0XVaMdE52ecD3fUyONR0mkOnIA2Yf6V6GEX3VMMN1Ce2t6eg7Mo2vArjjIX?=
 =?us-ascii?Q?PQKVuJLoYfVkBHahnkrPBgqrmtb+rTM92yGVvuS7QSMTxReI6BWq4t2pS/BM?=
 =?us-ascii?Q?KA+ozMJe9YSLnrjjnlIwVetqs6DXnPRqCDUMKgaQ/IdUEUdkyXIqfObOALQJ?=
 =?us-ascii?Q?OpyrxtwtDUdadYfUCGOp0UOkTd0NsoMB4bJq/lDT9NsZiWIJhUvA/XLcNwxk?=
 =?us-ascii?Q?ANlBgfA4UVbBrPWgst5tMvK33mh2jpN9hSqCBK7kHbMKsA1By/on0xu/nbKa?=
 =?us-ascii?Q?kd1CI2VuQzbuRHd+usrakVtewHqH1oPCi9JaOwuklsyTxW/4x2lmNmWcXO4I?=
 =?us-ascii?Q?QEqiwIIbeoS9B/QXP+V8R5cbJUfat4/XU2q6oAC97sZXjuEpZEjL8e7UWXCo?=
 =?us-ascii?Q?4jUznNm6Yswri01f/AX+XgIjmT+yOOoyf+jnJcFVMs91tKCs+kcrsjEAoHE+?=
 =?us-ascii?Q?RmIQnjDLVD2jOOXqUWAAFvpvk5K917Y2bE+IqdI1teF2viDAWHu6clBJuSuX?=
 =?us-ascii?Q?63saAguZo+5TR7gBqoQrQFSDKZH6IjP9HMrWWRZFPwXPSHkZzglI5FIAyCYj?=
 =?us-ascii?Q?ED/NOAqyDV0q84KcUFMeH46GkJSipTxq7k2Cwv+3xA9uc8dmGCb2pdfQu3/1?=
 =?us-ascii?Q?3I68y5I9tkGHYM+PQ9LSFO8z5WOLtBuyfA0r2rfwfcWDkxZ5PrAWVUGi3/4a?=
 =?us-ascii?Q?bkkaeCPCl1E8sASshK2kOPhnlCE2nCacM9EJkThiBOMtql1BUJkCeVwEH7XC?=
 =?us-ascii?Q?l5jRx46TDvpHo7Gl9FUQ8pEvwLTh0QsLu8cL20vRGIN0sC3IVk/yaF1z8Vri?=
 =?us-ascii?Q?+oUM3E1ZoDhZsnAZmWI1VIEGgtI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d287dd7-2d62-499b-e857-08d9d6a6bc89
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:46.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHuvhZrx1NkdyJv+YgmaEtlhcFqbVrQRCfDcDT/lHRKe94FN8/TORh2F9xU0jCAuAyIyWj3fO1NsJY8JqTzM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

This patch implemented a new function named pm_nl_show_endpoints(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM
endpoints.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl commands
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9150007fec30..06b1a3823bb4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -365,6 +365,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoints()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint show
+	else
+		ip netns exec $ns ./pm_nl_ctl dump
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -473,7 +484,7 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -526,7 +537,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -562,7 +573,7 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
 				local addr
 				local port=3D0
--=20
2.31.1

