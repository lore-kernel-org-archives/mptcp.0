Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BA7F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0JhJzGuf64qW8la0L+TdO1ywv/jjKUedfxy43e/rUQ=;
	b=gireqlWFZsVw6L3t3a+cjvQ4LvhQcbHn8kcFSqYO/iE7nS+TpBZi9LizfP4dLYMkxn5qoM
	J8uwptl92shSoyyYLXU1tJSI+k3BlkjTVLQVBUY0JZ8vD8on7/acqeYGZXvr9VVSyvFeso
	DVGgQXEhHoNFBRCwaSAmxmVnU1NxVSA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-Vmk1o43tOw-6nm0nhk9-ig-1; Fri, 11 Feb 2022 23:46:08 +0100
X-MC-Unique: Vmk1o43tOw-6nm0nhk9-ig-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBeEPdbGeUm7kEITW5VPJbhFz8hgyvhskwAFXE7PIm2stce0b8GC4CSfQxe7tv8h/vWVA6L0TZ+ulVMjFetM0uWKBwV51YcajBosW2Fpe2zxvHQvBMR19FuEFMcSmjmdALR/TM0d2hr0dU/DzhI1J3CYfvMa6+RG3phiLuANRvyjd4a6ovQAWKAe3vokEpDZEl+8cFJyXSSMqQapr/TwXH3/QVm3PVIXdt3ShR+lh9MJphwRlssIA+bsaoL7If79VqA3XaAULFIJXiWuGnJ0+UXuCyiwMfx40QrqfM1ehuF/zz0APr1vgdOvRk/6emiXHW0mKSxo5Eutkj2y9qNZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydy9JZZF+55NzEUf0NOh2ik7ePxRWxA9heN5azLOa4o=;
 b=PIl3MlXleljtQttV2E9LUvMvsNgpikRlNrjxcRaZpF0ziLXWMats1NhvSycijPvTwd77rtecdKA7bcBZTOU394x5oTDFm1wREVxH9ZE3Mxym42EvDjteCHDHwzg1Om/dA31zxGP5X7WQwaePgFttYHlNkJ0XOyoQ848ZI38GFAaqthUp/pnJIp0/aRl1PH3z5hZTxYbd0/u7aMWLRKgadp+VG6WLv0t6Ki1E5Q1Gkuldfx/0YKAeOWkwam8/ZJefPrEtQgLJPIyRJiAk7n0O3Zesra4BXutfqHULsUPiW/iFejCSzYuB0HAj2WHjtj1V9Jv7JaxAgi6YUWQiM0rwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:46:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:46:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 6/7] selftests: mptcp: reuse linkfail to make given size files
Date: Sat, 12 Feb 2022 06:45:42 +0800
Message-ID: <b383115cdf16305aca93336bd559c0c374df7187.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a56bd5ce-d73e-434f-619c-08d9edb04a53
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB56525752653854A55ECCC34CF8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fOwTt86LqacSsBgp9m4Z/T5zbI5fbbHa8GE9WoKvRu6SVYDk3bUjb0AlzyX6JB6dbhWTUfEDznVoLhercdz0u7dpMJ5Wt2L4B7gOZr3N8Pkj+jGgb771Idefx4YaY+vYnLW5D7U+ji2xQsbsh3Eg0LY1Wu0OMW0JngP4dLteAMn0RYzA44STMZO1nC2Dj7p0gKiJ+tkY9H7r+gA/8KyQB9KwJ1hYhLtVEKnOWK9lnKctpx9jSxPCnuAmRbuq3gXojw7huOX9X644YmQu4uEAyrool6g+RTEhj2xp1qpKeW7qZ1Macf9UFe2nB/1eqX4Ni0SdcDvrzmfPBVg1pyXgUAFgSQliT0R6fFU9DIhsFcClMBdAT6jtH7jS06tHPjyzW4CsIiNY8Oku0Ma1Sf9b/xi4Exzw9V6XCK/8E0dKHz2bpYMOuMnaF48f/UghSZq5jXmscfaM+7fP7Af7GY9Go0rBHxXFQ2/qyNNr3S47/MWLf5nB9dG8AQ02Lkm3/1EjHmzTUAtOH6S2OgA7NJkO43jwp/wODg69OHpnIiLEmwqgy4KH8awTVOo9o0s1ugfWNM25DxrjfOpOLZkNc7JnKFwFAC49vydgsBtioozQFuzxEY1D4IJ3CO95ON+U2QQEDD1d4DNNqihwd6qHtaBw6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(6666004)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s4ywM8n16jK7LaWmuionhPE7I0r2rJLHHz8rOtiiJh9vHoPQydkSKI9jPCB/?=
 =?us-ascii?Q?X8DzFxG+m+cdaEsiPgdwutGj+hlrs6ELldWSqzjWaXBeK0kuaoWZ6kOL4DDM?=
 =?us-ascii?Q?0bSyZ6nHVrCiHJZyY7hT5JmmBacf49ctAd0jdxqZ3yutqXpY8JfmgM3Gi3WG?=
 =?us-ascii?Q?ey5BUid7yXMNB47KudySay0RvBiZGL/wB1aFxVODyJZPlQgt/epfRmZ2k37m?=
 =?us-ascii?Q?3ki4fkD4B87uf2dKDfd13R39JLdEsxFDq1yY1wDLJtUd5O8PiWFr9Hb6If2F?=
 =?us-ascii?Q?IDZDPupG2bt5EMhiaOug901qlQlGgwClUqG+7O9CZDQX9upsNXrT6mTQ/Dyx?=
 =?us-ascii?Q?zq/dykxZmJpTWf3GwY+HUJmAXFGa2IK/C9ZBbyrwA+aHvwKWaAw84VYtNrKr?=
 =?us-ascii?Q?XKvFFEQAeC6vZLAsn09ZfQHZxq2mXMqf4pItrzJTIkrgIaNWDQFLnVZn+ClD?=
 =?us-ascii?Q?Rbc3YkmlhxQBZMfqkpD0Xz46mrqA2D1sK0MLijuvVV38qsgo1SoD7W/wrLcq?=
 =?us-ascii?Q?5JObzfrYhQYNPiW42n7N97Mdmo+Qg38R5h5/SHiwmPZk3L8uaW84DD4I3C/M?=
 =?us-ascii?Q?Xl73AbgkZUTjPqfIR6WS2Q7WJa51z7/U/wnvl8oq2nmBlVm6zpsG5NZxpTio?=
 =?us-ascii?Q?OUR9JmrxZbP8p081VjYufczYFsf56rgQKmjT1k+gndwSQF5UUONi8sG1pdmU?=
 =?us-ascii?Q?9TQlPoLhOfACZjIl/d8Mclv39s/cAJD5wP6i7LkFOYcBrU4tZc+hQDwDmXtB?=
 =?us-ascii?Q?VQ2vqozEtpvwUuaOhBKPCzlu9qFLVCYYpx6akMIkdyfVMyp0VpybWqhhTSYr?=
 =?us-ascii?Q?qpNIowux3SYDUbZ3GixjIfqqqa4MIjLOKTywUOSabiHlQc2cuMzm2F6UrqZa?=
 =?us-ascii?Q?baFdPFp5qcfK8ro3VwsMwpEx7SBV3vhB6r/MGUJF29k3z+eUgGcl/i2dmwSJ?=
 =?us-ascii?Q?2WeQ4hcTVbvKeqMe6KD3yHJTX4QVQIsCN5E7T/ZANC8Q7UOsWHVEvSHPzqqo?=
 =?us-ascii?Q?vgnX4007jk0v1g00iUUkI/fYS5UZI77tfM4Mq491ZCfS7nNlTO3MLbDvm7TS?=
 =?us-ascii?Q?rRT8YtoNuCcBo9i8Jz0nkuc0Wk9n9ZyF3OwWCWb7VsGRv+LS340TFw0S+ID1?=
 =?us-ascii?Q?ADReFqCBrWyzw0lKg069DtTgqBf5mFFYrnC7AWxJdoWR23/Y4mcUCeVjuaNb?=
 =?us-ascii?Q?zCp7yoASOwhA0B18GSnqg2MqfjPxM8F9PKyx8XbLdP+retXxAqEXznxaeXhF?=
 =?us-ascii?Q?iLo8Dk05IJoQy4W6bFWIfcQPY7Je3mYR9BjqkCt5zi15C/7MMce1lUbdUYyy?=
 =?us-ascii?Q?1jBzb8faVC+mlYZ6snKfpASDcjHbD7VprWXN55Fiitz22e3vvlHT+T/YGzFR?=
 =?us-ascii?Q?38UsPnYx5hCYT9xOTA37+aDioOpjDL4CcAgGUvn+hPHZ3g723Bhc0ew0T/OP?=
 =?us-ascii?Q?eJ3lQirwGzKSsLzYWcgoum4QokmxODqPkq+eJEwj+Pv0Rv84DarTwh1x0hH8?=
 =?us-ascii?Q?rCV2TnpfF5SpbPV4hBXC+ErypBHtYQgrvfvhiHge/VB9BjF6c4GM/N22FGbm?=
 =?us-ascii?Q?MyLQh3znnya73M9UEL5ztOqvNYXJj6LIo593Oi0y6l2b/0z+Vy9C5AEJaywo?=
 =?us-ascii?Q?sX4ljtNe9imvFW0ClSwlE+MPp6TcknLQGrj/1ip/24hk4wcNN06yQBQ+dqbI?=
 =?us-ascii?Q?1HAxXv88aUc//5ecFdcIxZyaABA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56bd5ce-d73e-434f-619c-08d9edb04a53
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:46:06.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ+FPrbhR8TCegJ5qJcdN2KnE0/dzhKOOlAZlcDXtMAC5lHcXRUWq7DmsoUKSn2ohcd+ZwEMdOyovaj/65Pz4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It's
useful for the test cases using different file sizes.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f0d0d540ee0c..21add441c08a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -446,7 +446,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -466,13 +466,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+		timeout ${timeout_test} \
+			ip netns exec ${connector_ns} \
+				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -632,7 +638,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -679,9 +685,16 @@ run_tests()
 	lret=3D0
 	oldin=3D""
=20
+	# The values above 2 are reused to make test files
+	# with the given sizes (KB)
+	if [ "$test_linkfail" -gt 2 ]; then
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" $test_linkfail
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -694,7 +707,12 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" $test_linkfail
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
--=20
2.34.1

