Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FD257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ru6+Y8XK+QAwkZT3JbpfGbVcIWNvkBD0X816B7tqQ/g=;
	b=kb35/MquWKdWDOpa/lRI1ekS2VIRC1tZwrHXWBVKI72HHidm0rbyBx5M+bewPUQODPqzKh
	3uaVde75iCgsYUyzSHK0sGQsl2wyO6EZjBDEMXH4MuaGEEsiiIQygtmys2NH6sFtpaDkLO
	JwaomyUBJKtqMh8umW2JMWS/PtEd9ZI=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-zcqeX1tZPdm7wQiTWYgzzQ-1; Sat, 12 Feb 2022 17:15:57 +0100
X-MC-Unique: zcqeX1tZPdm7wQiTWYgzzQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlUPg/5nFKpvuUus+BTN7Qs9hR4h+TqIFysyYSuAGFrVIj/NNoPixRRyeSJJgObijNjPyC+rf0H+MQIeG8NWQZdqEUh4ILGAA/KzM9irGxiq/JIztBYN+ttoAE+pnt+8mXNdHW1YXsRv9OjcZ/BG3MGwWsVcM/tzJ01cHyRS8aLHibwSlhktX/zLjYdfNKMjRIcvsf9Zd/gML9QMAJrDsmHp7/EQqX99v3M/kZrpLM+gRUePFzIqLGqTdmafcP0oEYbtFLGv5BeaIJuk344OtaJzGqQO3zksuSGI/Y7pty1MiV+vg/FtRdKY71bujaGV0S93vJtl2+nJcNq4hOFQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuO4bBZlqzRncNdbdkPr1PK6y9J39RwJkZM4QRs35hc=;
 b=MTCedmuq+TJz5i+FssnyZfY68JQTPwJC6URlxbktxkmvW1GGKJIWv2VSBRWytkY5rfx6urjLnM5zL0kcoBtddsAut5bEme0wHAwYKe7/Sv1iiN787cXIOTS5GQi2iQaXYKG2BhPArsvQX5aWavQmV6evv3uyNkYB9OWysaj1WVPJIk3/IiWeXoqBGJFDgXYOGgmh+7d3GDxLXZVrizWedH4G3Wg7/Sxt1ls1D9+5cfS76H0lBfm/3eFFcCACDkjPzxXAz0W/37+Mhq1kmFXkEyHjWdH+6ciGGoUqGYLWJ14GWPVz8FY07xZRtQao56zmp6aczDfSUCf9hAVqpTmt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:15:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:15:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/6] selftests: mptcp: add extra_args in do_transfer
Date: Sun, 13 Feb 2022 00:15:39 +0800
Message-ID: <49265662f0e878e3b9181e42457d495d5c715e75.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644682054.git.geliang.tang@suse.com>
References: <cover.1644682054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:203:d0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54a7d943-3b54-4783-d02e-08d9ee42f318
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB654822F1F65E629C4582430DF8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7PbRvY3rEXz9XvTLGOFYuHYKjDbYGfFhcoIOf4k808eUOqslZepAQiAmhLbhNrzLPLDvm1HhjVRPEWoA9E2xoW3SL5czoWpV+RMIlE8XJvBMlQyj1qWGvWFqRGl1PJB7U5dHdyLXZh8T/75mfYVzCPNffTFLr33LhkmCH4KF3cLJB/5a5QMogGSRn8y4CWaWsevh9mtiqX2oB2c7y9AVhHMXqFiklUDKKh0Wp4KNpl5KE0Oy8/aXZsvTs9xELY96uC/udpiioy7BbxxNDDL74Zz75IECzBQNca58HVKiTAcrxx31gnJWskJW9AEQ4O+BN7+6/tjXIefT7zUHd89RvrrnlmvZm2QZVLNww6pwrqaVQIqQqhAbLqmEaUU5ikTdpk3KFgAjHa0esXnpvRgDD2yYN9QFFdzFJVOd+9KwzeDJgLW1KwLKyW+u5gYJNdEppR5MdeMgXSuvK9Y4mDVKhHPDqhOkDwsiFj2gNvpasKVCELY1giBg+zpJOePZ8g7FJwAse+RjmqE2YG1xVsIJU8aDa8wxjiWhZYA0M/ll2AGCYtqKAtk5IV6E1Jch1E1y7CMbgTf2k3a+m8Sj1fKowk0sSFgPoA8jtoE70+WeqMSusc+eWzogXopmMQlIXIJT2dIFBltedzI3dAgvGT9drhUjHX+yXR1WE7Wi+ayIVz5UT4G4WagLkkx4+JZLH2C4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(6666004)(186003)(26005)(2616005)(83380400001)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rq8IX4zPPWevrR8SXfhYtU1VI9DnvzNKaL1LlQPxzzNztzD5vnj6uB6DsqZz?=
 =?us-ascii?Q?4YmN14EBT0OwVWHBwLUDToBrDt+hh60ryGNNWhpx1OdHKGOmZDyaMq8rL3jJ?=
 =?us-ascii?Q?eKXHaFdtWMJUlX9qczRiS8LGQybIslMrbhok5oM5UfXEsSXlb/IJlbuF5a3W?=
 =?us-ascii?Q?0pSGQybJw3w5C33kFpldAHeNkoNPMis6h1M/HCh/+zck/IhpZoeR13gK1rFg?=
 =?us-ascii?Q?2dLd28GiMQhuWJ9QY9aPU9B1NyLzEemJs+eVY+V2VsxfBNXLF5w1eOmy6uyO?=
 =?us-ascii?Q?azZhlVNM1O4snr62AAehJl2/yRCWt7+xSYwtq/G0ZDE0vmBupTrgePH35c3P?=
 =?us-ascii?Q?ZRR1zmFfS6rfrI2cljA20BKRMOZWhH6ZedkA/RgWxcjiWVOR5thOv4vA4kJO?=
 =?us-ascii?Q?VlD9/x7UFnQRsRkz9rqyy3WAao9rjFwgEMKKM1uyw2KF3qYGY441iLPAdohW?=
 =?us-ascii?Q?7zfDmrQanW0YTP7PqFWLsvq0hMwS7cnA60iucY0vYnvKKmOhXwfST4hS3LR8?=
 =?us-ascii?Q?bn5YcTABu68Hq5wF4AWRQgf5COuq5XY74TxTO3asFB30HHzwkXmgWxxHJuVO?=
 =?us-ascii?Q?5m42skcgRW2k6miIRvC2PBkj6/HJY61HXwnY/n+Rmvpad8dnfSa2NIUOmo9A?=
 =?us-ascii?Q?V4sXkUlUZ6Vk/vDWUqhxIHR0i9Ag5aueSYD08ydnPizPVrbK+m4Ql7qovIkC?=
 =?us-ascii?Q?/aHzLNmUAGBtn3W0LJXNiilLWWIfBP/yX7X/4iuaDnnx8xTLGZvDPFZETX3Y?=
 =?us-ascii?Q?WRTkwSz4ushKC58LAVrFEYkjri0bguy271bN0bPJfFWyYodRD9Q3JC+KjnHd?=
 =?us-ascii?Q?f8NhG372mb3KzGY90C2DIzdOpYdyvQSg7ejwhTJ9nTNsTyZWKjPUilLVEzyc?=
 =?us-ascii?Q?PJ1pgF9s9xkMOdoq8K0x302fdyjadnRL+iGR1irVaopWx7TfupHWZO2pJ08A?=
 =?us-ascii?Q?WKDgYJX7EHPPSq0dpvHR3EEanR7XBBcgjtLnsIBwzPVw3VnnVjB1AuHqRWyG?=
 =?us-ascii?Q?GgY/KH9MOd9EPUOcWIZG2ykaw4ggDHZCoTewHu6a4jkOaPCVs+3jWDjzXLpE?=
 =?us-ascii?Q?uuuX2iBgaPan/e8rBBljeLF6R6M7Bx39f0t9gd0QkpAi1naB5ZwyF3wTSz/o?=
 =?us-ascii?Q?IoVImGtjEkX99pyMqaqHY071pnDA7Bjp/ab/UgfSlG1flvhS3Zv9H5fuA1rJ?=
 =?us-ascii?Q?IakJA88+FjNAtLyCEjXe8td5hRUlgdCWKzftHe29gWtDy3V5n9QdwQATpm3H?=
 =?us-ascii?Q?lDQWisI1nVAmco7Sd2rqu6CjNRr7xrnJz0FyBJUIesASDmx1HkAq6NkoLOIJ?=
 =?us-ascii?Q?Mdbmh0mx8IOLkW/v+Ih40cp6Sma9cuSrL9U+aqsEBaYBTm+68TZL25MbI2ed?=
 =?us-ascii?Q?IoQZC3W2R/cIYWqH055WMQ5JXMQC7dGRSfYoHYNzXSwE1rKcq+l+l+835/oS?=
 =?us-ascii?Q?0oqfsRCo2ZBRtmXutsqWD/TV9Bp1MLkPCJLxEt7pIr1hARF6qaR/+iRxDogZ?=
 =?us-ascii?Q?WfFZxNZrp5s3fu6c8lP2M4AJZBJJVEA4NWseUkIzVQ8ivkPN0OSCKQtVknuP?=
 =?us-ascii?Q?AFySH/tFLh1e7xBBDmVfOhVsn8RyL6uy9zr+kyEMzX3P86kol/dSSaP0X4he?=
 =?us-ascii?Q?vwUIyMmAJlDg0blZSKIWY8E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a7d943-3b54-4783-d02e-08d9ee42f318
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:15:56.6346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AxyKaimRFhYdMe+ZMcIIgm1mfy82A7XN70SqYkD8r/vyXarPELytalY6c+l5TdcjJ7i5mo37qRLKIgBAxQDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

Instead of using a global variable mptcp_connect, this patch added
a new local variable extra_args in do_transfer() to store the extra
argments passing to the mptcp_connect commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 000272eec5a5..5321cab1400c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@ cout=3D""
 ksft_skip=3D4
 timeout_poll=3D30
 timeout_test=3D$((timeout_poll * 2 + 1))
-mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 ip_mptcp=3D0
@@ -454,12 +453,13 @@ do_transfer()
 	NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} =
\
 		nstat -n
=20
+	local extra_args
 	if [ $speed =3D "fast" ]; then
-		mptcp_connect=3D"./mptcp_connect -j"
+		extra_args=3D"-j"
 	elif [ $speed =3D "slow" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 50"
+		extra_args=3D"-r 50"
 	elif [ $speed =3D "least" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 10"
+		extra_args=3D"-r 10"
 	fi
=20
 	local local_addr
@@ -472,13 +472,13 @@ do_transfer()
 	if [ "$test_link_fail" -eq 2 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sinfail" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sin" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	spid=3D$!
=20
@@ -487,15 +487,15 @@ do_transfer()
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
-				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$connect_addr < "$cin" > "$cout" &
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_args $connect_addr < "$cin" > "$cout" &
 	else
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
-					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$connect_addr > "$cout" &
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
--=20
2.34.1

