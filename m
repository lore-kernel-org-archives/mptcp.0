Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78E10FB
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1T265YHTCbJ3oH9vRa9pt5vpuxTK0fRV/rC9jdoISTDSM+Ek7506NRdB0bSnVHvyr/zFA/uWK+C8BryWqrLMsNm0HzfSC0NIA43nrQ+6nFTISFKyYSUY4XVqx1AE7Kos1rFVC4Zs/QVgPNZGyHE6teoF6NY9Jt5X6YmHA+hi/bm+97XG6ml6THlTihehjzKujKXeXqAsCe0f8jPSKk1f1jbMnE2P01xiThlQbCFWG3YaoKso/K2Ttr6nPhnLwLKyK4yevdJsdFiUQrOhEQre/FBobLcQBlPNmzHAXpHQkE99PcCo1B3tdYT0oFK8FC7hejlOGVDNuCs1c9VpEKiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6AF0D5ZnDYG0YqUT7AWrGN56Xel0eGKLvjbUReK2vs=;
 b=FLICil/rb1bP6bOI0wJx4GoU+XIItgLnxMMT7WNnIGfCZomBAv2X+zQwDJPj5Jt76ILaHqF82dHhi1vi32S2XF0ZC6PdniPhF6iSIPvp/KW6DlPEISL1DvK8QtqmTRy3Z0jS6yZ9wSz3jPj5My/3+t0/ej4SUxiTonWhYY3+O1PUTUMp2c4WJI+MLHcjx3L4XFibxKm0GpmwB8kA+MwUd/gk1OMhUWV+8i8raNvzCRla0d3aB+W6ZPjQIWZtAJHVf8GJmw1SsOHZUQywFIcCaDCcjRbyq6OrQXaQs5kIxXNEOGbvZYlrqZ+u8jiYJVDBz0iqdHM/OXZL7gUpnWApCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6AF0D5ZnDYG0YqUT7AWrGN56Xel0eGKLvjbUReK2vs=;
 b=I3TRc3i6Of3HxW04foidHvywk7X1MIpTuY0VmKFnn0OlrTIlBx9bwbZP6mwQyZV3fHGp2xHzbUOkpxNZjK1MQ/c1kGrAGzQ0ipcu5feAodTtEQ6F8aDgzmvJX1eQbTMWHth7E/dSuTAIFXCbF0m6PiSaM78CQil2VArPbgO5o4U4uHeGT0+DnKP1RGXMbPhfZH5L7UZwUAB4uX5mkFPWztwVf2oWWQ/WjFFLeOuaBXBPfuix2O+fpXNOpEIMAhHemGvNF3D1eIUt7UMpt1V1WhraF7+rt27V8aZMNdQUIQ7Jk7b2u4A7y+zMhBcWMKcpotlOi7pDh7JC03m/hQGF0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 02:42:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:42:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/4] selftests: mptcp: add fullmesh env var
Date: Fri, 30 Jun 2023 10:42:33 +0800
Message-Id: <88e33d74b07ebc7b92a4835f0aef0d9de46d947b.1688092826.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688092826.git.geliang.tang@suse.com>
References: <cover.1688092826.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 835b3c2f-65d0-4705-628b-08db7913b761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yfyGFCWv4RQkTjPnklb/m42vXseOZumP/HY1qiEc951mhP/Fmp+qE6GKzvJpODZ2e75YfpbpWWZUNd5/McrBq1pAJGh6eZzNqbbCY/BaQ9XpL/z2ag7SDuPF0s5rt4T6bTbB3XXyfMRiJD2Fu88SrfZw8PKFBVctTh4IC/Q0ltMErUQFxQeFMiFyfvtADSYL9AI7d3+O6CO2jczBvLwPoZZKPFPB00obDEPgkqfiYhO2KC4uAfw/PpeWQEjk4AkP3TT377Ryq4guA2py2BeVYPBHtDUcES2oGNnsU6SWLdJgfowpQxLU1+B48BUKYEv+tvojBouJnXh3YRVTSEdOjXWfA9IsWn/vs9C9q4jtcD5qdjPBSJnMJZGb+PAiN8BF2eLrm94njpCl39cPlm1tvGppRoYlFhOi9bb9yzakIWCRvvrb+y4cao/KO+KvHgfHHpCNPp2cqPVI/al/d92gr5lE7GMspKq3kIhtSaPVfffhB9u6Ufkj++6XT6OwJNbaL0/3ES7VOoF3NqTJMU+KJ87LCh6QUwTco4D4rUT0qC6HN5R3yzHCqYTz1nLKLfKK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(107886003)(8936002)(8676002)(5660300002)(26005)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4iiNL548aixZoO23sHlygw1loQv2QrfudCrtbbhODvoiEXY8VRnfGB2p4vF?=
 =?us-ascii?Q?cVsgRJykRwO1sPKf/S5/wpyKNQ+Biczx+OOLtbWDbwx1JwmYMDOl9Rih/W1H?=
 =?us-ascii?Q?kNnnWLkqaT5wmGKJQjsSeVfQhfx8EgUGJ6gKT0tnwta0a3D63C8PSNyZjFdv?=
 =?us-ascii?Q?f8sg0ye72r8IvFaNVWEJfpD6l2rE6EanxoRi2ISpTuEw3rCKh0/8WJEVOkda?=
 =?us-ascii?Q?MVypxVX9+143PgftCKBd2geCKV5VgL41cx6Yr4/JDC++aFPPLl/yUf/w3+NM?=
 =?us-ascii?Q?ZwLFNZqh7A2LJG7fX+CItQIcrSscNs8Bdf3yNSySVhhnTplq+8VWNiLTkN/5?=
 =?us-ascii?Q?seDxAms85baZekhAJOgWNpDxt0C1qN7lR/S2sVgH4h5XHq2qdqJnItxvPe1K?=
 =?us-ascii?Q?atYIvuWyV+Cw6+M1Cz1CmqoITqtoi1rBdF/RakzFbvUz25tst9esFaTyuoz8?=
 =?us-ascii?Q?T4Yx3rxwlSFHln/tdVvG4gkdqCu8rod14lWDqWg691cP0WcQTUaXOQZuY5L+?=
 =?us-ascii?Q?O1c7UrWQf8FSWDbfwXoqqQuppLlySkM+NjdaL5F2eBZR0ulf9TKJMXYt2V6/?=
 =?us-ascii?Q?CT0spUJB3IDE1Jf6ZKT0RR7jq/ZMP+gH8FKUrBbfwet492g2Y0r03JLF+F3a?=
 =?us-ascii?Q?9xvQIMrpDRGIS/h+X09UP8CbG4DOdLOPR/vcGboyIq/xP8Ln22lHxqnCL0Vf?=
 =?us-ascii?Q?rFJ5SmmwErbk3U+SSEsi5ZivSbfyXrQw6vqLkDc2HxnBBvXzuPX2aPCAEhaT?=
 =?us-ascii?Q?RE9nAoRDd+1CdxuRWA9PbPL3j/PceXg8e3d+6YtHtjr1EfvlJ+V64znuLV82?=
 =?us-ascii?Q?zfv7w3M0vSF4JLygDVAAvLJqlaQMb3FuCSBop7zLAKP5ZPzcBgxofMpPSEFO?=
 =?us-ascii?Q?Zq4cms0mXXypNjstidCoUro4H2yusiFvJLh4/Q+j9GX1gdwGDbTQjtkzMM7G?=
 =?us-ascii?Q?GNTj4rWV1B08eX2OKqUpHdU4NDI62p6l3ChgOv+WFGME2fjnnFHfWKBETG4v?=
 =?us-ascii?Q?4nzOIBUsg+1iw7ndlyIuM722LPv4Urb6+hTe36hc3Jar0kKiTSeQBlwXqRgA?=
 =?us-ascii?Q?06rm3tFAOrxqPJXhqoKf0Tp+POSXxjpaQTia4+MiA1apo8LWGUEdvwsZoyIL?=
 =?us-ascii?Q?rPczWCNDsh+dXXGlz1rx52bANzQPwUx7Km9JNbS6KSdCSiW9FiImiFpH/UVk?=
 =?us-ascii?Q?n6lOzuSebG4om2ziq+Hukn79MMHAz3ngNsaXsHGhLycItRLu5VCaF6NkDsg4?=
 =?us-ascii?Q?7BTjmW6b+/og6DXO43dudLsmZM2YADRmjdWC7S4PXdYMdAU61w00Y6XzhVgT?=
 =?us-ascii?Q?rxzuf4yxiSfdagWDQsUMfmRmL/Fnzj/haRQQPZpnTGEkcNcQlwEd9y61jB+9?=
 =?us-ascii?Q?yedsmqZAPYEpI/OwSTJFvhQWuq9l9+7xcjuj3MXJOxDJNe+bG75PAmd+o5Rs?=
 =?us-ascii?Q?d2bpUqjjIljlzr7S7jRDvqoy0PYStBZU8zc4EXX08j6PAiKNkixGjx7y/Keo?=
 =?us-ascii?Q?irwuIutaCjWs5XRlQgY2I8i9bzUTSDozTE2YpjJfbLXihwp7G5O/TT7UbY2t?=
 =?us-ascii?Q?wqFIwtMKKPFa5gB3BeY2Xlfx832iruUAFcsMFqle?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835b3c2f-65d0-4705-628b-08db7913b761
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:42:59.2929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTve+ZG8bxuldz28yx2j/5gHFSMOnXek2OFAVBiJDRv+M1NddoqvuVXCVnlufDQsdsRIj/qH3ZrdZC9wRNAp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Use a new env var fullmesh instead of passing 'fullmesh_*' to addr_nr_ns2.
It can be set with the actual value of addr_nr_ns2 now:

  addr_nr_ns2=fullmesh_1 \
          run_tests $ns1 $ns2 10.0.1.1

  ->

  fullmesh=1 \
          run_tests $ns1 $ns2 10.0.1.1.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9b12573c55eb..bda250f703ba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -55,6 +55,7 @@ addr_nr_ns1=0
 addr_nr_ns2=0
 sflags=""
 fastclose=""
+fullmesh=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -831,11 +832,12 @@ pm_nl_set_endpoint()
 	local addr_nr_ns1=${addr_nr_ns1:-0}
 	local addr_nr_ns2=${addr_nr_ns2:-0}
 	local sflags=${sflags:-""}
+	local fullmesh=${fullmesh:-""}
 
 	local flags="subflow"
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+	if [ -n "${fullmesh}" ]; then
 		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
+		addr_nr_ns2=${fullmesh}
 	fi
 
 	# let the mptcp subflow be established in background before
@@ -2688,7 +2690,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		addr_nr_ns2=fullmesh_1 \
+		fullmesh=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1 slow
 		chk_join_nr 4 4 4
 	fi
@@ -3101,7 +3103,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_1 \
+		fullmesh=1 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
@@ -3114,7 +3116,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_2 \
+		fullmesh=2 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
@@ -3128,7 +3130,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		addr_nr_ns2=fullmesh_2 \
+		fullmesh=2 \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
@@ -3152,7 +3154,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		addr_nr_ns2=fullmesh_1 sflags=nofullmesh \
+		fullmesh=1 sflags=nofullmesh \
 			run_tests $ns1 $ns2 10.0.1.1 slow
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
-- 
2.35.3

