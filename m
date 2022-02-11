Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052047D
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644573186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcE04E/Kumip33cbkuKqno/Essi+LYAVbRQAhfFnzq0=;
	b=H3t4iLKbRfLKyhC/ioc0qH45qjX9JrPFDLxrQGkhkfT2WoawFkap9sk2KbFrf6ihBcc7d7
	bzhkQ+oi7xTKfMyJt3MSjz83OQWN3g6I2ay061igJHUA0oO3yRt0gEO2N5O/h+5sFoJZMr
	1yn5g9VVAyv4N7qFUIMQB3ycqRTlDEk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-FcADWDlUPhujWqCjmiD3uA-1; Fri, 11 Feb 2022 10:53:05 +0100
X-MC-Unique: FcADWDlUPhujWqCjmiD3uA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJcK9Teskw58AHECqG2HykdpKhNy9xL6A78OK8AW9oxzbzxqGJII38lOm5Y6Bcv5TR3eP8VJfUuXg9GxIlPU5l3HuThV6T3+U+q1fiG7Wq8Bj8rfqvzcvUGeNz0Y64KZeTDeOXECaTZX76hoaoCvOMIn4T9ec4DtQY3Mx0cjo8lH/ASL0d0C47JsKGm33eaVC/I0DWjOxqQASCWZWBOlXu4U5hlysUiPKg6BlfojCTQryaZX6fH8lDx4ZHI9K4fkDEJO+GSoMruardrV0iOBy4G1ECq3v7X9a1tRuxrvCw/+OghSagdH8j79IWremeKcDs8JHK4Nw42EQQsTYE42Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGXB4Wk/EDNVmwBPVM6B8P+e1MIhJLamoTbyF8EpBqE=;
 b=QmCfj1jLv0dtMBfH2P5gUGaRDJrv2r2SAG7mobunTVEqGqlLe6iwmkO+odLB+IVT0jGALRZQ2Xfndo2YM/6vV8kfTG0ecABzGwseNlARtrxbBox7lXjNnHWU9xLTX/xN9cYIcPIZPqDfCbTIjWRL44n+hkNDYXjypfp9/ugHLPQzmeeL6a4PjVkevNF8yjlaIPnXjDs6yYOqshtJKqkei0oAJSr2Ce0gyNi1r+bxcskwj+QZBECKw6UEzKHY0Omi6QdxiJdq0WgEmtqL2A+ADkzEoTz2iyavGRGccmrsf79pK0hbsMnzAdttUeSG7HYuSdmAHTeMsSzmAxQ4bqHWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8651.eurprd04.prod.outlook.com (2603:10a6:20b:43e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 09:53:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 09:53:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 2/7] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Fri, 11 Feb 2022 17:53:00 +0800
Message-ID: <075df2856987fb4e276cf4308f2cd2b2df032c98.1644572307.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644572307.git.geliang.tang@suse.com>
References: <cover.1644572307.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07dd5441-c000-46da-8494-08d9ed444c31
X-MS-TrafficTypeDiagnostic: AM9PR04MB8651:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8651B50DAFD6AE36F29BF157F8309@AM9PR04MB8651.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dDTdQRakwXlmhBrrxxCH4knv12fClX1y/IXzwwYiNqDPo0JB/iAMlZgtQYx1UnUWou9C8bmmSeWMvJy9IAh7CFf2aiapDeJyCqTEzQ032LWpI+BU4DBXxN8mdCRM1uC4dGnDzecoWI323itT7u+6IozPnuggRJ/e15wzGgO9yyXWkMD6WUy8Nyjp/8TXffjXu9FHFtch/l28ZeMDdsqMpmQvWUgNVSbiPOcQf5+y2L8DhgmtNNvFCj3sh24BmPimDrwJbWOzQh47AWNHugiM0qALMqq8B+fPNAiSmBlSVTiY/jzJHr1R/l7Wop11qVPIEcVKA9j37SzusUGkocgAhV9XWcvOnJrcJb57vUfEPY8T+i2CLUGbuCEOoTxDnBKjHxIjkmvcHOEZ9tF7wsrg1aQulUZSvbowLKsOuy2Q0/lnJS9eEbOylqZuXlSPDl+QOh90ts47R3j6vpbRe0Z6npbtvi1V1ECNgnsSPo098jjnbpLOyaOvIKNPhdqYIvQtv4GfvfqVXWN3PN02mWdvZP7CUWNF/OFX+leFFP6dzwpc4Qy1PReLwHrd21aNQNhy6sfvLM5eURZ2voF1OnsTomzuIhZlox1XEdBas7eFrCKfdON2uHI+J034+aEcLrwWlhg0gc9bqngtY9S7IarULQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(2906002)(44832011)(26005)(83380400001)(36756003)(2616005)(5660300002)(107886003)(8936002)(38100700002)(55236004)(6512007)(6486002)(316002)(6916009)(6506007)(508600001)(4326008)(66476007)(66556008)(6666004)(66946007)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gBZ/PzJa2CGXIIZjoKgu3XJcp8kbzZm43Mv0m6CQa25bsPORdRF/i8Y4X7L?=
 =?us-ascii?Q?c9Ct3mDVnC89AOzDpyQKF8o6vSpDBYmeja5wn7Jy5IVtcZL8nCvZmr+ZAtKi?=
 =?us-ascii?Q?lqq/oJVgIohRJPqWb4ZJORmLedFc4LNWxg6CMfNB1+FpVFtGRgUJRgy36wWJ?=
 =?us-ascii?Q?vMLyy3FfY33E2suYdCz4gDvLEanLcAWoDJBGuO6KvNqUTfcYQTS2k/SrZ+nB?=
 =?us-ascii?Q?JHONQlSMdMyaXqg9UD3QqnxqzBQwLUP9tcMcqTnBytSP0R2Cv9kqO3fSYfcn?=
 =?us-ascii?Q?VhXIij4R2Wz+SkP0mONLAGaAQJiXHWrUZ8M+I3UHTZS9q6GFZ/nAO+IlduJT?=
 =?us-ascii?Q?bw06LNZZntcxpMhIOO4GiKbVvOeIBrKZhugy/tQ/PAGNfOY8HaA60I9Voas9?=
 =?us-ascii?Q?wcLKSf8YyiaM8GhaLGOSs4wyiMHZJvFDHQ43ntXXJeH/8llZLS9ZdrpPVLyW?=
 =?us-ascii?Q?7UuFP+cbga68QFkME8LiIiVafSZma70ibqbXLWwJucV1FuSdPJkfPo+Z9cOn?=
 =?us-ascii?Q?PjKsxnStJJI7UvRHWayfMEZM0xsQwxDfL8N/elZ9tQCBfzWppO/0jFNLjhfN?=
 =?us-ascii?Q?xAy4Ed8NjeMk019N4FrBSeNCEiiPUC8D03C3QidUnJ8jB+g6qyM0qoNjxYGL?=
 =?us-ascii?Q?8l2tpAL6XWDXGbgyPprzAmI6Wpgldj7MLnamyB+Q+cM28kzwq7QQ+PhFa3Vw?=
 =?us-ascii?Q?oceieOT+e0A2fl57yjpsIFHQg/vQep90u1+jul5NILrGY6CUElX1AgC4PPc7?=
 =?us-ascii?Q?OPKbY/ydmTXkRSMYh1yFV6ShCpZjF+lFJKkoiJVQTJ+TbrwUs/OgjXg/6y1N?=
 =?us-ascii?Q?5/GC6r9btvRhnMb/eU4iByHlXQFsI67PJEWI1len23m42X2TxKU7efzJk+gs?=
 =?us-ascii?Q?4ah1i9V386NHA31V0qvChWjfod01VanovAoGjXWUS7nVLsp4Ihx2zySFt9gT?=
 =?us-ascii?Q?D+HKtAvlTwy9SZR71TXf5UyOzHgrluY0Xj+1zSG873e9z5z3mkL+HwklXQ0d?=
 =?us-ascii?Q?LnE2RmWfBl9uVE9ZzV8PtIDu9LayvQ22FNpv5l3k3xw9FaCNJB3luxkS99Ue?=
 =?us-ascii?Q?7wCTsheiSARYjAekV6FjS7UHqFnnkP7tH4jy7dxrPyJYlyzQcFPJZz3Sv4wz?=
 =?us-ascii?Q?3fcMxkZVgmjC3YG5/f8/PCoVAg7X+bigXo1BksHmrKv/bYqGg5CnC+H0Ugu5?=
 =?us-ascii?Q?SxXx8z/XP/okelwVFmVr/wEQt9DVUOy8gJR6YQZOMPjkt1mk9mnaSAl2uwEQ?=
 =?us-ascii?Q?NMeLvjqB5h3px7b3XGy6nqNM2XeCF/XFtbuSiJZcqLc/6hlTl1RuCrjbh1TM?=
 =?us-ascii?Q?VrYNSAdOnYmVYs6ddB/qZ+KLZLXHC8oxMOKM4ExSQ1VeosUXmXgflhry4WU7?=
 =?us-ascii?Q?H1wDJKPpKTEm7Qdq/vkeR2ZGd150+PiTNuJjxdSlxBkN6MN9Hb3/yfwXaFph?=
 =?us-ascii?Q?XkKqusUpM8qCNBwiEFejsvON96uBPpBYh6jL/7LdRqInDou2Ouu5fe1DqlIj?=
 =?us-ascii?Q?6wTKPuGTvnZd2ssWlwS1CXQGcXhE0SWI8EJMxQYUc7P3I1NvADJacqfonDMz?=
 =?us-ascii?Q?wYsdK9cWR/eC3DOqTEw2B1Gug21NF4NbTPQBMHeRHUFb2jZHI58Ua88kGlpj?=
 =?us-ascii?Q?Z48X5Gn5wFoA+f4QjLvD7Lo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07dd5441-c000-46da-8494-08d9ed444c31
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 09:53:04.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFO/ukWZeUYrYDWaz/lpueSwK5vFwYHGOY15lOJaQmhYoLmWiAHp7uuj1A/iH3/M6K7zh35X5a77Ba4xdbLTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8651

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 0b4bd2df2538..9b75569e423a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -784,27 +784,27 @@ chk_fail_nr()
=20
 chk_infi_nr()
 {
-	local mp_infi_nr_tx=3D$1
-	local mp_infi_nr_rx=3D$2
+	local infi_tx=3D$1
+	local infi_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+	if [ "$count" !=3D "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - irx   "
+	echo -n " - infirx"
 	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+	if [ "$count" !=3D "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
--=20
2.34.1

