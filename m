Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03732C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=alThrNifp/OSjxHl/4li6lFqZXGq0WSvAO1M4Q05kR8=;
	b=dDROkYL6nqTt1j7g0doMBoHbCALfNbvSb2P7Z/bzl0nDyM8jjAlItCuPeHe9INKVavhjU4
	uul9OJOn4iPQM9ywQ9KGo+rrgB/l0aAo+cSLenu2f6gCeo4Ganb625zcquwLc6xB2hiraG
	CjQ34AZIB5bISZ3mkaIeVGSB/Sw7vaA=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-U6Kyw0NzO4yZhZ04WHxFdA-1; Fri, 07 Jan 2022 07:17:16 +0100
X-MC-Unique: U6Kyw0NzO4yZhZ04WHxFdA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX++23/KY4eEKkbJAXJ8eo+pESOo2eBKh/b2krrVgj0ABuJgCNFJ6R0h2YlANDSUDPMSobhrrn7RYTknlRQHmUg/ayZvcQoHQhsIjv/As4krOkUbYt7mL6GYRk8nnk+8udx/GReCHmoMXxnber8L1rv3Hwr8AaIC6FYZDv+RtNP8ZcjK3Fa6qg4cwFUF8zaICuZ/Se7qyU9jnKpR7pfHJXYIIGK0B/3V7mxZEFsBtnDj3J3JrDW1FPiBPlsSflbsw30TeYBGGBE7P6IPiQp8WJxw2W7A3UmhEtHWaGUEJj4FmwvG820gX58/uhOblvPMe/VE460SGasix+NmeTQYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oe/690Jw0b2v/upReELVvbs4JwlgUM0q6esPjYVUlc=;
 b=g4i2LdaN6tSizYsuWRkiow0DAT737caTr44ALg1Lx40s1SMy/Ye+IiQBqV/TEbsxhQNjGq6OgMps6UmZtq3ZMpYt95xH9FsrNeWGiGd3MgYFlAtlZQEKc9z8Duvqq78SSjAzKDfQivJBLptt55CbdkSQp/RqXP/nm3RqhaDZwhWQRZM1SQ86jW526Me1fbX5M1bBE6SFBMyuW6o2lj1u+K7Hf4z75xq3CeQtotHDbGVX+yiGVLo8py69jWtJ8G+5x0H4pcE+OcllB8vBvV9WakSLt7vvEkGQ17v9WYWamqhptXp75Gybrory0A6syOzuLL7/VIXpAmRUjiEomTLPhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3369.eurprd04.prod.outlook.com (2603:10a6:7:81::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 06:17:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:17:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 1/9] selftests: mptcp: rewrite removing tests
Date: Fri,  7 Jan 2022 14:16:53 +0800
Message-ID: <a7e0d5fbffbb2b3894383daa3712e293da700bfb.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80c09aaa-d15d-4792-ea56-08d9d1a55951
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3369:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB33698BB58114C0DE37B7251AF84D9@HE1PR0402MB3369.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9tuo2NsG7ewmQwufFQfNvf4LI6nhhw0yjWKsW3yhgXDXtk24AGx60A542LccKLks8MNXQ/Lw30S14dhRxYOeK5A8fLe5+a/lQ19Niq6bbXzLTOn3IHd8bKhX/stIzOPWMEiY8ZJhYmauMQVso+jogjJC1etJJj1LWqdZsTI/MopnOvay1SW/CGIOfBrV5LS1gcjqhbnqHDWn7EGR74PMEZMWpLi+01YRTLFtZi1uiVtKADPD8As4/JIH6VnzRbmlFHw0to90d9gwbUQOjm8tP/C883mwLhwMkapoUhs88LGJ0w6B0ks+dnvnFZ/Hh+LwDN77YdbViMxfT29Cq55hRLND9TA5PQ3EjZJN6Hx3zV5Nua8vKQx03la8Ys2ZzS19ekq2pPc2VFrgqM4MMKMDOXzf7zpuKTiqjuUpQQNSTOD8LxUmAxHsfXdUNa0pSIcRKN9QqPTr2qshRjvx3oeomGvlcGvM5VNZ7IDD/EfQDeFKrcwhqtQj9fI03N1zdiEmk9sMatmIsJqOsKxBqqEMiI0ASUvzdN9EdXnZfL87r2kqgTlXN2HS4M4/+5r4gzax4DGPRdJDKtelTH/N1ObPJOuMKkJIPqiovfgv0MtC403q45f4zQNZZxPVHYZ5m4j5OzSi9lK5mkudETB6dtVLYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6506007)(36756003)(86362001)(55236004)(6666004)(6512007)(8676002)(6916009)(26005)(107886003)(316002)(5660300002)(186003)(2906002)(6486002)(66476007)(83380400001)(8936002)(44832011)(2616005)(66946007)(38100700002)(508600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2kweVOrMqHDsMTjI031oyDUa3SGZAXJZKR03HVkMDabhPOUFPtwkd63VZQl?=
 =?us-ascii?Q?Cq/TrkBocz9ByiIKRa26S9iW2Pfd2I49Q3GHtSWJYyfS/zjGLD5YycBGWHXr?=
 =?us-ascii?Q?I6uAidSfqEeC997Iiff1fghbbedvYZcBB6w2OxsDn+R/Q+0BUErjOHOfLM44?=
 =?us-ascii?Q?Bz/UxFZzDDV9MjT7UrCHxzzqwRJAN92FH57cyX2xMf+uYcnrOsZc9JY4kCfL?=
 =?us-ascii?Q?A6vGHgHBnh0Srg/4WaRRCDbJz0cfBeaKhhwYyIK3O2FtVHnji0BDWF57UlZB?=
 =?us-ascii?Q?Mea64WLVNx8vHhKjGi8MwUhOt3Gw5CbFFL+7Zg2/AcsFXfdf1npYeMrwEa4q?=
 =?us-ascii?Q?h6IMW5OOV4H78t88E9x7B7nzPHDueJdGELKOahX404B4B+fxYKnXNtJw1knV?=
 =?us-ascii?Q?2H9eCf9Sz4w9H66wCWcJt7rfHewvjO1KNGszk8EZLiXwwd4ii+HlvhZnqTwv?=
 =?us-ascii?Q?WhMAsmwDUfNq6DrO0eLT5NSRLf6WlSS3i0D7NE/m8jEPXWhFAsFenzYLd9Mt?=
 =?us-ascii?Q?/AD0uhD6QIjBMt3uV5j8HV7vmOVtB3dAVG8XFF6trC+qYYDsR/uiEdB0nVLC?=
 =?us-ascii?Q?IbO2tiCUs042AuM6jWtjX2iqgrVN2B/ydzy1zfkbABmt/vlNOKV/IfiUhwdH?=
 =?us-ascii?Q?txcgQfk6GeMQdYBp33sGYbYENnHow8WGs6mooWa2HUmHR8VSVpIutzFYftEI?=
 =?us-ascii?Q?QBKtDVyvUHVtTu59WRr96JNSxpY16nvzFnc7uzeWbcAaAUIqvmWaBKzEbDhb?=
 =?us-ascii?Q?xwqFhs7don/I0Qg0t9PU3Y7wyvYcKOCKQFhOfckurK14vQ/NnqIiXUujB7ox?=
 =?us-ascii?Q?/gOMLNmFnJcHvZ2CEu3sSylO/jD6+zbkXj/l4s+84mWEholzSCCd6BhkDX5q?=
 =?us-ascii?Q?H+qLXC2KRYobsFBXKjWUU3Ow7RQnRFRjDVcrEHkvZrKsnfsM6o5tI8sJc5iP?=
 =?us-ascii?Q?eH2TpAdJSw3CB1V3PkyYKg8NAslzt5QUOJLGCCHYkGVn+Fu6anZkhMSp337r?=
 =?us-ascii?Q?vKYsLWkB+pAFer2AEtNMJiS9gShh4WKqOCu3+Q2BkrIV7T6ihcdAGSP8iAy5?=
 =?us-ascii?Q?ZoWzMNAwfB7HVgXHPCOmsbjIwBnjFI6B2XaqNJikxeM0mKerN1Kslf0SoJr0?=
 =?us-ascii?Q?nZquximsuq8JTLNFjITFcImZdyD+A1j/8R5ApEQ6t5ZQ1z3RkFEfFfFQvrCc?=
 =?us-ascii?Q?nMSRhNVhdbIdt+HqTPjrPloOOI1eRZDwFApE2DPVfTdpKUIzz00+9JUVKD98?=
 =?us-ascii?Q?xs9lIz8AboT+knSpKaldFwo7J3iKTZ9AG4/VjZK8Lm4OMg5x/j5oi7uXv0VN?=
 =?us-ascii?Q?WUB+Wq9UFmsb59D/rYYGJHMasjH8J+axSZfHbjY4WbUbALm2NH9MtPZBFfsd?=
 =?us-ascii?Q?RPH7foa8UgrJ9SGdZpvJ+lMCbvea2d+pp9GfFTLS52VN2/sJSF0dAwU6OFqr?=
 =?us-ascii?Q?6vN1ksJMAHQcIEBYUeFvR5KvIdmxAJwNINcEVlgYIWmixK9x32Vp3RepbHtw?=
 =?us-ascii?Q?auM6KjfFjWUZARmu2ahpuO9hly4PYASZTa1kkcUMlYB0HVDNB3ArPTY4vZK/?=
 =?us-ascii?Q?pHioHb0TS6NIhba+2NKfQWhQApUgnc1HeWHUmJncb/tb9SVMz/MkGctOC+DM?=
 =?us-ascii?Q?GE3L22Gm4JZ9MfDij6HEdn4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c09aaa-d15d-4792-ea56-08d9d1a55951
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:17:15.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sx47jA39i7dF0Dfbj9M3t1AmtgQVRtb5vPmXtscWR8pnMsBRlvPA5hyaNMPc2uFZNoAoeKPzQ4lASr3i47O2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3369

'pos+=3D5' in the remoing tests only works for the simple case of
'pm_nl_ctl show':

id 1 flags subflow 10.0.1.1

It dosen't work for the outputs with dev or port:

id 1 flags signal 10.0.2.1 10100
id 1 flags subflow dev ns2eth3 10.0.3.2

This patch rewrites it to fit for more cases and the output of
'ip mptcp'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..b41126d4b1c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -385,20 +385,25 @@ do_transfer()
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
-			counter=3D1
-			pos=3D1
-			dump=3D(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				while [ $counter -le $rm_nr_ns1 ]
-				do
-					id=3D${dump[$pos]}
-					rm_addr=3D$(rm_addr_count ${connector_ns})
-					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
-					wait_rm_addr ${connector_ns} ${rm_addr}
-					let counter+=3D1
-					let pos+=3D5
+			counter=3D0
+			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local nr=3D0
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						if [ $counter -eq $rm_nr_ns1 ]; then
+							break
+						fi
+						id=3D${arr[$nr+1]}
+						rm_addr=3D$(rm_addr_count ${connector_ns})
+						ip netns exec ${listener_ns} ./pm_nl_ctl del $id
+						wait_rm_addr ${connector_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns1 -eq 9 ]; then
@@ -433,21 +438,27 @@ do_transfer()
 	elif [ $addr_nr_ns2 -lt 0 ]; then
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
-			counter=3D1
-			pos=3D1
-			dump=3D(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				while [ $counter -le $rm_nr_ns2 ]
-				do
-					# rm_addr are serialized, allow the previous one to complete
-					id=3D${dump[$pos]}
-					rm_addr=3D$(rm_addr_count ${listener_ns})
-					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
-					wait_rm_addr ${listener_ns} ${rm_addr}
-					let counter+=3D1
-					let pos+=3D5
+			counter=3D0
+			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local nr=3D0
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						if [ $counter -eq $rm_nr_ns2 ]; then
+							break
+						fi
+						# rm_addr are serialized, allow the previous one to
+						# complete
+						id=3D${arr[$nr+1]}
+						rm_addr=3D$(rm_addr_count ${listener_ns})
+						ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+						wait_rm_addr ${listener_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns2 -eq 9 ]; then
--=20
2.31.1

