Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E62C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pk2vVTdqSdjsLhTZ6R69xwHe/laxHIMIiAX328CQViM=;
	b=PwGq1RRSGKjD3ETdLwTKtfjr5XJ/Gv5JlClwH+oxcFsJ54RN2kNTurc5hjCzlLyKWYqHoI
	G2ge0573iuMir5SFno1CtSPOfPWPyp2/4kH8yiFn9bENude2ezAw62fsS+K+uzAjxGP3kT
	hwIUN81MMq5f2dSrIgLpQ7eQg+vE/FQ=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-e443Z-m7ORie7NzimNEAMg-1; Thu, 13 Jan 2022 16:09:41 +0100
X-MC-Unique: e443Z-m7ORie7NzimNEAMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDY8zcSDhaxYoFPw3gP4hHZYgdw3vgDBh4aB+JwX1GXpLqAE1kQVwkH85ZRE/t4t1Z2bQ1YphumU1dh4fs9Qhfi6pXbilFXF0dYwVNwOFWxc5fLmWOuq01e6WMdhA5WTTQqRl8SiwLz8zePIyB0A+EUBHUZvGpjQlntO7gePxDxnZxU+7I3nTK55dM9j/BQz1NmFSYSykeudBheK97qtfTjlu1m1ukGdsmsia37aXZp2vpvXRTTK0eIBeMLEg1YK47TzgacPNhrVzXwlnmFEFH0wYA++zmRQ40rsWzWSAtvKVRBjeLFnvAKVHffEDcdOXyLItWxxekycHVfkYqFavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BufGqQERJQDuc9LX9Fmz32KkebCz65zInVqp79wlF2g=;
 b=QXKOHGvcIee3ZnAPbUeigXW9Eaeuqn1aAL7xuDCGUQiV38i7FwWJuLOKaaWUl2wQ/rhhCnDX6ggNfm/nv5wJmk623hIRRLPlzZdFSIREVYRocLsy+BgVIhFkwIMAgdspYDdTFXKxsh6dyXhQJvGM8lUfKnir94v6Qp0I+KoNe6XOljARLN2fBTDUJPKyawoH+nz2CHHyNnCgvl5msnjt742mv8JZRPKVW4mg+1bnTD/XxrgjTh8ITTETtA3pgQXgLPSpsyzhAFOBIhvK7mAdZNT7kgq74b0fi52BtnFCdHYKlJSaJoTCeHvcuUQpmUUT02qHxJJ2e9xIjnr8S+3q+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Thu, 13 Jan
 2022 15:09:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/5] selftests: mptcp: new approach of getting ID
Date: Thu, 13 Jan 2022 23:08:36 +0800
Message-ID: <723e575b4ad64f2a2b6d186d94c8d09eb1545c52.1642086296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642086296.git.geliang.tang@suse.com>
References: <cover.1642086296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af13af0d-f8c2-49d8-0578-08d9d6a6b884
X-MS-TrafficTypeDiagnostic: AM8PR04MB7361:EE_
X-Microsoft-Antispam-PRVS:
	<AM8PR04MB73611B10B6F369024AF7FF30F8539@AM8PR04MB7361.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AgcR39qb2BdMrnA0qQyRs92TZdS4ySjBMZTqAsjxJvz8WSLUdCb0jaQGBzGbJF5myoaGbjafXunXdZ+6C08DHCVFujEao9xgdS4jtbUV63xFMvF8WTQQRJqVvsYFKyEK8XtMkmz3vPRBm8DN1wM2nGm9cGEiqzqxBbreEuzyRicvDG4DocpcXCGZNIm619BvmtKcamp4LqaY+ZaTHP91jvtyFLb/5YLthp446aoFUPKw1pxMXO3oax2K1VRrjjhf85HnuNjA3muSSeljsmPs3GLS7JrUiZC/p7Zj2f2GpT838uBBbACF0whOUHfUTBVVrgvxSLLGfuoduY5krCr5+DCd694tG121wm8XqAheSgOR87pPJTFRcypmIZm998WwQH18q95eCxk0ueyC9ogk9Ep9PX9UHOF7huhZIZ5WAMfhM10ESVkZb6bXwZqosDHZZQ3k1Yh5wGNiyuZnbFLS/wr+GeB5a5RmsjmXqsZO8MK3EANpk3K7IZiACHPGMQP0Am6wBQPlQg4xDA1Fl5u98C7/aGy6dDWc07cBDg/h9ZmtfOr2zBqY8cIcSt3TwVV1RbrpFlT9v8YDQgWBxAfw4OJgr7IlyqiTrPJs6HW5w6lrPXthLuOIEPCbvCIBHeI6vbWjJgvKSJ+jEc9wUPK9ow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8936002)(86362001)(508600001)(44832011)(107886003)(6916009)(6666004)(38100700002)(316002)(2906002)(36756003)(186003)(66476007)(83380400001)(5660300002)(6512007)(6506007)(66556008)(8676002)(66946007)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+XWBIgubEkFjU1xIERZ3p/upQLHIG9J3K7QV+y49FrouA8UEqGUYd2ZKXDcM?=
 =?us-ascii?Q?b0moFEQOC6Aq6gllrdkAsxvbKuWCRiD0hoon9cK/h23zZWNzWFNWua9abzL9?=
 =?us-ascii?Q?FJu3iCM1/sdGK/Jc5bT2lL+oVn7DM97Tec+D5h0s0p3j/X76CCWUq5LjDWEw?=
 =?us-ascii?Q?AQBLeBA15hFQmJA99Z2U9//3vIaqzdSrR1DW+Zia/WZYw/4fmF1LA6fx55Yu?=
 =?us-ascii?Q?da2qtySgx6kUldXHb8Gmrup5e+MmEfEAirc2MS/vyBo5u+sqqTX6AMNUjKsg?=
 =?us-ascii?Q?rH/euS+Cg5DgHb3w2WIzZD/Ih53jw+1mcsAYA6aSYI8B+Yr5pfMtqHOdnD2L?=
 =?us-ascii?Q?NYPDZAZmyWmwQ1gG48BBhMI3eJPRU1z/bYwXGC8pN4kP91b75yQUhfz9M2r3?=
 =?us-ascii?Q?LNFL7KshWXPgKkOy3XxyUE9IfTQKx6Sl4i5y2hQ0WmB7VVmwy8XbuaaJFKiO?=
 =?us-ascii?Q?l10FrYuJfjl+3Dsauub2y49kmjquirSpvut0lgaW7gG8YWkb0KQuBPzIx0dq?=
 =?us-ascii?Q?gQQ9gHNOyZknsyo4OWqNDb9IQJCk+UjRh8bNMNhE/SgJ05ldPjP9yfL57ZFF?=
 =?us-ascii?Q?sPy7rtUXSS9PDJx9AG4fM71TyuNsXincRpe1lwkscGLQOEsoIRMgPsoU5mrf?=
 =?us-ascii?Q?9uIekVWLtni/Ica8vnDtCybK3ym4Pjy1XyJrU317dpRw2n8Lu09tPe7+1rp2?=
 =?us-ascii?Q?pQqCbsNAttlVDrFp96Q0mWp3sTQhkzNCCWpLNZgFlS88FRUk2I9PGUXDt3t0?=
 =?us-ascii?Q?W2sAQv3LWzVr+D7FEfVoKvU8TNg86shBkMpFl4DBqoi7jMYiVZw/Pa00HgI4?=
 =?us-ascii?Q?iCul3QSA4SWsoUuoVMVa/cfq1S3RzP92DLNKmXMcd8QDkAA/Is/QelFJ/S8f?=
 =?us-ascii?Q?zVOQc2v9y9IesNPB2LW+DRu060cm2cYkH67BQG4c8OLA5lVYO1j4rW/kjp8v?=
 =?us-ascii?Q?XIjdo0NNPJjXHUvd5NU53iRv/ybfnZIXv4H0ujR/UtXQiw7Nrpa7WuyWHlN4?=
 =?us-ascii?Q?NGad3ofvkVrqvfeeMm1SUzblDG4nChcFIuazqlG5BMJuDTx0wsxGr0yJvvX/?=
 =?us-ascii?Q?GRVVwoGGZBgRKwrF3EBuSo8ObfcILW36ev8/F9JVOnASGDkO8blbvnmaSwue?=
 =?us-ascii?Q?z2Tl/SxeHbA91zviEaI3DOgDt3sUPa++s8BS4Gji9SMlsQe2raKgpuoFc/Tt?=
 =?us-ascii?Q?X8zLZRSN6jtt8BC9Eh2xEtPFTY9jYEuR1uWO7Ex3u/+2GepFvrWZbePIQL7u?=
 =?us-ascii?Q?g6U9UqKxt+4Oqcjf3W3M4JzWC8RNjZGL6wCcvwk5RTBGq4ZEBVZS4k08zTYs?=
 =?us-ascii?Q?CDSWj/KDRJTopZFCMIy/VJ3DewXVTS4fOSkVEBJ6tm4qN/WCs6gRrQUMaRc7?=
 =?us-ascii?Q?DnlhVgnsFg+ss5vRhAb6qfI8VfrgQfxvNm6+Pn99uvVszVtpGEN/weq60bhb?=
 =?us-ascii?Q?eCb8emg4TxglHEHkNc1crEA1R48vo+wXy861gs3qE3lwavwJAP52AsXUCHwd?=
 =?us-ascii?Q?W3Vl2lC8jK297nSwr9NZjHz2qo2MmsF3BVlpSroi9C84SyeRQ8b0Yn3QDn3Y?=
 =?us-ascii?Q?VaHNgYFQosKV+yZDddoL6P0rEdIsk1ORoeNB5piLhtVQfBG0lfNjAPBo2WCm?=
 =?us-ascii?Q?y9I6Jj2z5csU2NGsV/u6P1k8P7cqxb1eQo0Cpo0W8QZhGqDO19qyE6F1iViX?=
 =?us-ascii?Q?JaOFcaZuv+bASZ/SXdM4NKMND2U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af13af0d-f8c2-49d8-0578-08d9d6a6b884
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:39.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4H0WqP7XgHOrh6WB1KWnlrci3fSnCYGfUdOCpWRKc1PXuhQO4lKXS4F/Y6sxpSmKBdBQqLiiRog5yKcyTlSvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361

This patch implemented a more flexible approach to get the address ID
from the PM dump output.

The original 'pos+=3D5' in the remoing tests only works for the simple
case of 'pm_nl_ctl show':

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
index 9954e0106c1a..9150007fec30 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -472,20 +472,25 @@ do_transfer()
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
-					pm_nl_del_endpoint ${listener_ns} $id
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
+						pm_nl_del_endpoint ${listener_ns} $id
+						wait_rm_addr ${connector_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
 			pm_nl_flush_endpoint ${listener_ns}
 		elif [ $rm_nr_ns1 -eq 9 ]; then
@@ -520,21 +525,27 @@ do_transfer()
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
-					pm_nl_del_endpoint ${connector_ns} $id
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
+						pm_nl_del_endpoint ${connector_ns} $id
+						wait_rm_addr ${listener_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
--=20
2.31.1

