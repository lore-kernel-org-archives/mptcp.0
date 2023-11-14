Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD89612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5pS7MpvL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4XqSv3GjegTydPALCqK6+392zOFOWlbzL6JsSwSh6sJ62mmZ0/JsTtLIYSAia8S3sdZPj4BoZ4c5m/xh03NW4rWsWwa+9CfIIyt7KRuBsQ5hnPUYwTgEVMEhi+9RVK4ULfYNkbwyYtugqnB1l/01Jj6m8t1hanzx323h1CIO0Ge6LdhWgOTXs0CxauRVrgBwgiAKz3I4jpBzMFGGd/0AZx2PM6lG+jsOf2I/R00gwFp37UKhV5oMOZ00ZZ7JUg/mV2ppkRRF/gEiFxlf3OaG1hC/+x2lZ3Zt2jSzAKpUeaoZyUyiJVTsFGcAo31EJC7N4ITj5eTIg48c4vbxj0ZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U3CurSV/n5ykq6OhYD6nb8sVbokeful+uBInQxa/ZQ=;
 b=NHG/TlU+3EI9Vl14VmJpKHo3aw5N/phjobIdgLeKm0SCU6kNR9cJFtReggfz/tMJeOtplJxK0S5FFTY6cztH80on+UA9Rj6AsKKXO9DWUK6yY7Ok8DqsRdopsd1QTCTlp7d6lcsaX3hUCkfEnLGUfY2Zw6fku6ScjRtEcboO3v6pYgOTuTtNTJbKmZbgp2SHUFtJr3h6WzplIodvnyyVTRw5+6SZ7pofRehHBaky2XVrqDWYTmGinNFnatg+Zt0CI2umXaMD67pKyTdeATz/cmsmy43wVqthTQK3q9vRVMxi+PfjwZq9M6UNg4WpAPayclq8iY0l8MMF/X4H+xFhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U3CurSV/n5ykq6OhYD6nb8sVbokeful+uBInQxa/ZQ=;
 b=5pS7MpvLieiR1ozfg1zdURaJYtAuP7kAcroI4YMRrBJuz7RXzUrd94tR0Hi2fw8Ffl2/KHHOFCnH6Hmk61DiXd4pjUde/UPdCNjhFdIzu8UJwCTiod470ouKiPlbn7OkSuwDR0go0Spz//+TsxikTm/lbr/iN/EI9yR/A7J4ElJ33Wg5zouaHRAm57FAVjkez7YheS6xgTnwLq/lRkdBP35HJb+PZMMGfOwLbFNwQOwn53Kv9176J+1fSdZoXpT7u/AIiM3fBeAtFdzdKeY9qqAo+4J9phHuLWK3UdtFBFsK+Bw1D6PT48oeE7pICH03rs3vHTaiwIXzldbRO6WM9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 17/32] selftests: mptcp: add PORT instead of TEST_COUNT
Date: Tue, 14 Nov 2023 14:35:36 +0800
Message-Id: <df63e3e3ac75ade7d81904be46997acb7c379ef3.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: b129602d-88e7-4a25-8f34-08dbe4dc8ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y+qWNoWrj9Lq8yFo3hk3QPCS+kGBoUg97WVT4d+CaUzIGea+kCUGqWfYN//0LxjUrMZlema2gWQdgiX47s9KtB0z2JuaMt6u5QToKvi5sIaFXm+dXqGR21KLUp5fPj7d5N7ONPzIQMsOnCNdFHf9n/fhHzTAHEcwBt8flIErreBENHDIv3Wh/rW837Hc8549nHd+Bi3z8f5hPpU+yi/aVLS5khqMMcnL1RUL09g/qDFMZX5gElZ6CrR5j/aGn2tkzhOBTFY83HWoQ2UwX0kstmwjNogUb+rf3FvrgP4EcdYYCCqsiIEBIjrfqMkU4/+oFvR2XKX4yScPYSuAnY463XzLD/CDW78bjzXvgBDBy9oAr9PbW1IPTEhyrQwEZV0BcVC1uWluhhXc0VvOHFOmgDYelV+eVCp8AkqElgTq3U8xoRxrC57WH/9ARfCSWFkcc05q/52RrtmLZAMUw8k1OvULy1jdxM9SfzpkgEe8Y5LMLuwJRYQURpB+9UkXe9GyRHghWPzs+pK3FR7+PjaAMrlBm6bCGOo1JFFNUG7wnp/aaabjlqHylgirmYJHJ7kf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gnBUOYCMe1CGREJa7UzPjaSctbHWy/PrdApXTH8YFFpTjOStvaej2gN3d0Z+?=
 =?us-ascii?Q?BLDtct+7TM0KhX5M1LSqjZzdluaJcDU23YNA+gsyO27jVmicgN4sem/FFSb8?=
 =?us-ascii?Q?ipgTXwmyv8CkrIwimbhH4ZGYiKrzqQN3yqsjjWeXT9i1aI0HjkMwCcOML9Kk?=
 =?us-ascii?Q?G9wigzhkA45gHQPsSaxp6njP6b3GAAE9wHcAVyEXQht8SS0jOOU350sXy7b7?=
 =?us-ascii?Q?ie2EAT44kKwogO196hhJM+IPSUQ4ewxFF0CJJTG0Q9NeUk+hPLM43QE9CpDr?=
 =?us-ascii?Q?mlwOQtCCXulz7FcUlncjBVJgywTGjV5EQrcI8Eabi2Ai04X2hLzjbYlWJ8i1?=
 =?us-ascii?Q?y5WFhdE/pCLBqtfuwNGQgk+XlliewEEGkfbo63NvV9ktVg1ik+FTzvv7TGf/?=
 =?us-ascii?Q?BONNrCGM3JzF3n5ZvCNzcrtjLy5jLlHw23vrwS6rnqboPo+2opEenDqnEz+h?=
 =?us-ascii?Q?MXw8iJQKopJTx28+x080xYMctG3zG2fgKVh8BXHaj5Tr36SKr9HJvSgRTz/i?=
 =?us-ascii?Q?MjarCAc6ns/LTT/jP+y4aNEZQu6LAbadQzAJBEC4SoGCLX4eI05AoK/GuZ5i?=
 =?us-ascii?Q?r++sTzgpRlQkvp9dKlT0skH5xW6fDWS3p6cW1MCMTFPi8g5yqYRDic+EY0hi?=
 =?us-ascii?Q?hhgL08nupCh/IOTFJIHloS0Wbyu9Q05O1qJbBZNEORXX8XFvdpVaRaUl5OUd?=
 =?us-ascii?Q?ishrg62ZGwSajJ0dOcZ661s0AQFtsvTQx9DOZd1tcK/nWn36Rau2tDc3Tqm4?=
 =?us-ascii?Q?C02Y+D/Dp7JSnyvFsM1WNc4MKStTwxfWt1tAys4PKCNSS6ZjkgfMrE3aluVu?=
 =?us-ascii?Q?DqnuDa/vvCnKQvncyhpc+VZYDW+C6D61OLmzy5Vi37hsGKK8nJlO1UGztNkm?=
 =?us-ascii?Q?vmOrefth95988xDPZPp+eXVlz9cxQvIRn0Px09LnnYkrK4PLSkhuMEysswdL?=
 =?us-ascii?Q?QbDJmXIQP6B9cPekCBGRk6cIWDIRwi36EqonYy8ZNgZaqC5X0sKHPJ+tGfXo?=
 =?us-ascii?Q?AgXa4gHdyoh7/eSWIOK4lPDGLo9c+8XuwSowaAeqxZdw9nd/xxzrKkqquKcz?=
 =?us-ascii?Q?xl5mPQSpcAvks8Q0ekS2T1+ZT3Vdvab+gXtGbMZYwO4WdxyhIXMewSgyXeU/?=
 =?us-ascii?Q?ZgwuNecAIYKz9aeC2zqWAqwMcpOok88XZ1YbOcdAI9mGtdt50LVBylwR9tMC?=
 =?us-ascii?Q?gUT4BxOYDHyWwFEtmLI1QOLW51XJylt1+U8HCUVz0B/NLkKyeVdVPxf4HOun?=
 =?us-ascii?Q?HRTZSF1swJMpArNqhYLT2R3AoOC6VdFOGVz90PgLpQqvgXjbVVrSrA5mzXYF?=
 =?us-ascii?Q?w10wXPcLJ9qewAl6qFN9HtExbko25N5SO3xehRu+01m6x8+5euZJgXWu/Daf?=
 =?us-ascii?Q?dSCMdcVJgcXkmunas2NlnF69LUwya4xWKU9LrzH0w3f3W9zdLfg5uXjrvSr2?=
 =?us-ascii?Q?888eTcZMx80qk+ZLmsPBV38ng373DhsKgko13YbsZOB4fKKv6n2UfUugHksd?=
 =?us-ascii?Q?liJIBXmHIXmtiW9lElV/vj04/jmZDKD4NY45vZpAbqi/60aY85iL8/BTgFWr?=
 =?us-ascii?Q?WHtMfP41yotSNMuETia7ygmV/FdOOki8yhIJu3bs?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b129602d-88e7-4a25-8f34-08dbe4dc8ab1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:07.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br3IRP9uQcKz0IqxVKbsaHCtFllukgGp/C0P6f5g9nVkNMppUfED4T2uQG3/52JRHMg3L3gk9gGjOmF1tJ+ptA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

This patch adds a new counter 'PORT' instead of TEST_COUNT to increase
port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4041414c8804..0a6d40c3aa85 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -28,6 +28,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -308,8 +309,9 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+$TEST_COUNT))
+	port=$((10000+$PORT))
 	TEST_COUNT=$((TEST_COUNT+1))
+	PORT=$((PORT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -691,7 +693,7 @@ EOF
 
 	mptcp_lib_print_info "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.35.3

