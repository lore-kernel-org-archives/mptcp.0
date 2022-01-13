Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1922C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642065204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaKuM7JFXjD+swK/MgR5KjV7ds1IqZlDpbxyKYNjPkA=;
	b=EdmZbkL6qwnxTNZQNfZ8NsA/WdehFDiJRYMqN47rAqckTJNUlG3Zaow3S/5GDOxGrWB4/Q
	N6yroTSgSyX9fvIlwWfQnMdS7+K816LH3Kyf1z3pzMLRGkmr1JGOyGEf9vnUO+02m19aVO
	wTwCqL2tk6Dp5B55dcY8URm5/ZQJtoY=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-S3c5_FnVPDGdLSdz51be6A-1; Thu, 13 Jan 2022 10:13:23 +0100
X-MC-Unique: S3c5_FnVPDGdLSdz51be6A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLj9WxrBqCqMEaMzxDFpuY044eeCEVdF20i7c3S9r6jDo5e3twaRmC1+vvYCzyzA4408iS1Zq0M0xyEcHXKBSS2bMHnt6KYLI2hB32wQGEsfcjUp8iuyeMBBNZ93bIH7bfOdNOJ4GnDaGVpJxaNqpSYvsK/agnuPiJanB/H5mdmR3ftc718PJDkjywyfaFIrwH5VuxJjE678+OkjlSIXiyALHUVVK+sCAvEnvHWcSseJu1DuzqOa5SeCWEK8ieWTqxBxbqAmSzrYfSt1hz4BxO4HgRRId88armYHhPYN3/3fuJn/1q8TtirYnARrGz3dKFrwLRHzHrlgFaBR3iaiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UaAskPCicBCcOq6q2AEjoq8mBWrczQKIHOoAAvGlVA=;
 b=BFb0CZgDcswCKQbcjz+onjPnbJvchDdczfal/XacUt/aWv6O0m+WHcG6lLMIjLxFsmhIMuVdKm2hK6y05nmIgc5ma+XfJpznJRx4ATzZ27YLuMaNEt6EY7o+Gy2RQgT0Jq9rGbkpUH7H3YO28K8fQF/+KKDXO33SoflJALDCt7/TBVXlRyTY//pWfV5YvKq67tzBpcWX9n9Lk5wB1AD6uIUBkPGl4tQZXvVFmiStXEba28J7ZETRECiS/p7TeznvpRKyq+MgRCgOEAW27n3WlE2jdc+FSEZBMjLh7fzRRV8Hp0I3yyQS26B6807S3T6DW+y44coy9eqkiU2YhnL0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6448.eurprd04.prod.outlook.com (2603:10a6:803:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 09:13:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:13:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/3] selftests: mptcp: add backup with port testcase
Date: Thu, 13 Jan 2022 17:12:39 +0800
Message-ID: <cb0601b61fbca9f27a48e7e40bfd895739d67018.1642064550.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642064550.git.geliang.tang@suse.com>
References: <cover.1642064550.git.geliang.tang@suse.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9d4ad7a-a7d4-40b4-9d9c-08d9d674f289
X-MS-TrafficTypeDiagnostic: VE1PR04MB6448:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB64483945B88DD07329925B68F8539@VE1PR04MB6448.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	APXA6FVquehUgbcm+5WByZxTwnAUtctgQBJecQwVpPgaqPK58x5ZHdZWO4eaUUJmy8UlkNsvG01RePptprsxi6T0Vj6LfQp4Ewgx7TRRusn8cyUu3bG3/XNB7t+pobFnBSXLFd9O+q37TEhqsGJ80+oFTqT8QdsLmqr/croy8EnyMOp+6W1Zb1uX/NElFpg8HrhqEMQTmWyjWzaU7JH7IoxlI+l2Yk/lnmrnoQ1NhG6njofO6X4uYjHgUFCuZqPZTfPmANbp2515dpEVEhh0s4MHRd6H9aY9A3qW/y8PYP8cH3ynERJOaV7fJAcGmYGtBESWQEySXozwlZ/2pNroVkwbGM2u+HQXryc7fRZySXihX98C8w+RjfAoUtX03X3yUsuOS10t/y8UuIFJFNoEIzzOeswkV62CUHEEb8H6ky7zRh4O0HaBfitjXbpV0wlLuzjjd0+Um/GlaoXOAMxGCNSiSU0gmhU3i/EULzhtwB6JQLwWqJvaPgzO4bx0cKPz2Sv5upkPeiVoqv76ahrTJ/H7l8LWvf6v+sAEVPPqFseGB5EDAE6LWhvI3+ZgDIlIKHrrTTl52PiNDtyDheocrkUvcEck9N56R8uqocx3AOW6mhALc+FR/H6m1ByVZPn5DmdAyRhSrLGaW7U0jbN8pA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(36756003)(508600001)(6916009)(66476007)(66556008)(38100700002)(6506007)(55236004)(86362001)(66946007)(6666004)(8676002)(26005)(186003)(2906002)(2616005)(4326008)(44832011)(8936002)(107886003)(6486002)(83380400001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y2VSPGfy+v2xWfA5TIdqIEjTjyuVc842lj2qCBBjOAbCSXZ47Y8NpAXelCtB?=
 =?us-ascii?Q?2hZ3HmExm42nOUuesHGfKSnjgXqRX5mpoHHZnIoDtxT/3vbvJJKNFAG/VYp7?=
 =?us-ascii?Q?kN3QTHV5b3N655Qj4x60eaT8ZPPjcAu6upe9HpAuIoPfWrdpLlSDMhQ98XIL?=
 =?us-ascii?Q?RT9D2p3zvQiyRLzEhCSW9c7HypjknPhHkFicds7Jb+3wH4d1tTX4h85tsAaV?=
 =?us-ascii?Q?TrvJbapWxAqEUOCirzftZOahrgs/weOg+4X/RXrK2fJmb6oQA9lz0NXxDhcL?=
 =?us-ascii?Q?B9+02NDZuQ3OFnPuL87Mb7Y129/V+KcD3WJ24G6j1CKUzbxdKY7jFLtIwHAC?=
 =?us-ascii?Q?NdT0+Q8cVHtDZkd68VaMh0ox1Id5oYjosuyJMtrBdTiTK7wQST0YnNzCTNWi?=
 =?us-ascii?Q?N2zx5Q6JiB1oCWu4pnlP2yAtneUtczuL7gzMP/YTP7tAcZ3QZHyd8uqFbvje?=
 =?us-ascii?Q?2ZRMmer6XAGBlZYTGU652riBSWWhkiY8yoq5KBuk/dKou5wsyn82Te6zi9Uh?=
 =?us-ascii?Q?IttUKr8eJT0pDXQIVAqFHJHfxpWG436OQQ7axt68jU2L1KA0wK21Elzp1W0e?=
 =?us-ascii?Q?jJr5UcVQXumaJMMgHXPS16G0CKEsZoj0Z+J7RcfRErXStIqRDfLQ4MyoPS/o?=
 =?us-ascii?Q?bZcgSXG97up46LWkeFjXRH3LgkY59sVTnrHMDAY3GEOUNSZSCrNkYaEFEYMa?=
 =?us-ascii?Q?E4xAbrQ+2hnMBsJZbBU/7SClldCYR6iGQDcjhJckWfVylUbh+WdvnpvHdZcY?=
 =?us-ascii?Q?5X9+2ZSTxn0kyLyt/51xgX7Y3/NR6ahi7bjclSds661a3y8+fewklRhzfCQr?=
 =?us-ascii?Q?91tMVxcWUsCrWBewh2ESZ4nzj+IjUSgYmALhUir995ZmDjvc21tFYN9v4Azd?=
 =?us-ascii?Q?CFpWhX17QX1Z3f3i+SEdskldPoGAZdMrym5Iha/IfIrut0SNb2LbwhlyJvGk?=
 =?us-ascii?Q?pHKQ8FNqUrOWNz8qs91w4ZhLeQ1yOCseoI03t18CAAP9Zr8yY1kMzKJr+/Uh?=
 =?us-ascii?Q?lmyyg8sS5Q/pZZqvZM9NxQV/FYV24odIZ0VWw38/oCy3a8XIaXtgPn1xDHPR?=
 =?us-ascii?Q?m+ReOt5nk8udaw51cugPHKTAS0JhmhDe9lyqmuLGXOJs3tnUpIsEz4Jr1rOg?=
 =?us-ascii?Q?H6tLTw0wY2seZ0qEV+jwpT2Hydqvz1ojvgkdYH6ERAJfP18n4W7Mg0bQoLiK?=
 =?us-ascii?Q?lOc7PQzDYmi86bkwtf0+je2glyfRkpKN2HsrUi3jO7wRUfoRE/mZRcz3CPA/?=
 =?us-ascii?Q?YNWt1aGNIWMPEMh0BBPPKhVQsHZKmEqEXPbsNmPkb2qX1/XHqI26p3p9ywo+?=
 =?us-ascii?Q?41XAQBrvkWlryxC+kJqe9CS0uwzNGSIpKMNNtg1alvzCbGM0+OS6VxZwNGRC?=
 =?us-ascii?Q?3Sa6Rf/QEEnskSR8ed0ICDe5VfKRTGcGnpLvDDm661zdIqdjHvM282IkBrBZ?=
 =?us-ascii?Q?sX2x9xKrxHRlzilACXSlh4R/4tSk8wxyYgJl/Hm2zKXq/8gwuDxavPLH4TNx?=
 =?us-ascii?Q?RjlmJJM+6TZwlSsS2pQ1Z/PJ5BLhYdmssO/9qvgv7zJ4hKz56tARbZQp8arr?=
 =?us-ascii?Q?3DVFhcVSEztUge8M68Xzdh2LIX98rOdfhTWyVI7dayTTaiYKNeCmqCJ+dgpj?=
 =?us-ascii?Q?iWIa6FeDHT7xDlcNEyzc+9I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d4ad7a-a7d4-40b4-9d9c-08d9d674f289
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:13:22.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmsJPwSTD2bm5C1NIceI6e/XUgouX+3axc8bzd/pClV6P+bl0ekJUHyKCDq7EFg9531at352m/vG92HO2zov1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6448

This patch added the backup testcase using an address with a port number.

The original backup tests only work for the output of 'pm_nl_ctl dump'
without the port number. It chooses the last item in the dump to parse
the address in it, and in this case, the address is showed at the end
of the item.

But it dosen't work for the dump with the port number, in this case, the
port number is showed at the end of the item, not the address.

This patch implemented a more flexible approach to get the address and
the port number from the dump to fit for the port number case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 25725be98342..1a751c86d956 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -239,6 +239,16 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
=20
+is_addr()
+{
+	[ -z "${1##*[.:]*}" ]
+}
+
+is_number()
+{
+	[[ $1 =3D=3D ?(-)+([0-9]) ]]
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -464,11 +474,26 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				addr=3D${dump[${#dump[@]} - 1]}
-				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
-			fi
+			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local addr
+				local port=3D0
+
+				for i in ${arr[@]}; do
+					if is_addr $i; then
+						addr=3D$i
+					fi
+					if is_number $i; then
+						if [ $i -gt 10000 ]; then
+							port=3D$i
+						fi
+					fi
+				done
+				if [ $port -gt 0 ]; then
+					_port=3D"port $port"
+				fi
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
+			done
 		done
 	fi
=20
@@ -1651,6 +1676,16 @@ backup_tests()
 	chk_add_nr 1 1
 	chk_prio_nr 1 0
 	chk_rm_nr 0 0
+
+	# single address with port, backup
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+	chk_join_nr "single address with port, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0
 }
=20
 add_addr_ports_tests()
--=20
2.31.1

