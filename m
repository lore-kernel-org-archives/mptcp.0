Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7A5EC3
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHjETA2iz0mR02XWEPNtkBJ5xgdrZpAdsKkLabLyUTO7yR/P1tL+G9I0W8qTpuq97K7lHORRfIqGOAR6nwir8Gyoa6bDZGhdt/AW6KcJfyDDjp3esh7HYAG6Urgsso/09DpV/UnKyPRZiy+FurZKyCdh3HPbS4nKMZT3VEy2/31Qf9ILOSmDAKE6aDbm77L9lzwY8l/7MI2PZm5tOw5npzmPQ7BcZWDtELji4Oc5D+IBC15yVBXj3rvktUqbzBdXGtAoeQMg9h6RLC1r2BHtytqky7tJ7FjecyC+cjmQod+aqKrd1ZmbqI+2sNtFbD4mmgHN+TiMcr/M7d8/bY1zpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXl0pWak1x6tbzqh8MyjgRIYfHmLHaWi2nc9ECveKaY=;
 b=BIz4/Abx4Bi1g10nMbkXxnizeH5WlYTXtpTM3XiJ/D52HjF3CW8Cg+EGVaIPlNuqc2XVZyaoJFrpqSIVr/2VQQA6tcVhU1ZdOYJ2OK+XvxcH5Hvf4ZusarDM/nOPfjl1jaPk8zAfAAE5josxcJATGyhEGn1imBYImDB97Z5Z94z0tgAEvnnoObeJ0wT0wVrMkh6mL/tzVA/eJNAozy5cHxXJ6OZetcR48NRO6Xvm9wL84h+FWlN9hCbD81PxCwSUlGsykwR7gfIQYUNA4SYrdeW/zpNm4W9r5hXj2FYlRoUzyCHS+3Ycuadkq81HOOPvtQXPRJrttYw3KqF9Fe8fYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXl0pWak1x6tbzqh8MyjgRIYfHmLHaWi2nc9ECveKaY=;
 b=zQJRdEVJTDNRur2W11EVFsbyMB6WUIcprt4W49gZsfOMa9VujOEWAIIe7QJ1D2h6gji2dkZaQzLN5nTyJlMzwWgPH/f1wAsO2UgDdOw7oOAyPwu6ip4l/E93/9gcFp42J+p6onSAZksJoEISpOU8akIFPBANigiRoizah+g07cLwLBhQssUh+mSPZaYbSab2xY0AUF4Rno5EcwS+cgj6fq6Y1/1PBqPs94rIEq3ErIXlE9I8S/anT6V0E7hw5UfMFr5HffmB0aRG8fJFUBdeCPW9qxz5i0hF40TbXPmDP5t1QFSHqiCMzb7ggfcTrNfhlknueGwHSvbb2vkc6oL2Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 02:42:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:42:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] selftests: mptcp: add fastclose env var
Date: Fri, 30 Jun 2023 10:42:32 +0800
Message-Id: <32cdac17a13eec3b0f8ad2ee4c3b213063738f27.1688092826.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688092826.git.geliang.tang@suse.com>
References: <cover.1688092826.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 20630394-e259-4115-cf42-08db7913b34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69wONpJnoALD4H41AAc8i7RBYxM+GJNOxyThb5O59UL44jGRx7bf6/ysybUWAH51zvxRiSxN4GhmbCQEGP+Ux+B4x2NohmTGCrHowC0o9aAJyFeXyDVgEfJIUCmfuGf4eBqP1P6XpZUitCgDR+LCLUmdAH0tCMEbidguS0X4IW59jxKTdPVAthjQtY0jac1Tcha8PV8ux/Rqrl825aTLrmJr7gKLgcQt9yHK8gGhOFXsUDxvbRLl1ERVR7SX1z6QS1eOOQ9MEVasdcD1DJA4Gv3odubpcw5ZIP8WgpMn77zv0dmgaEHHRlgvprdWUWvqeUbvbMLwSGwSRCsL1QVQVy8nsvxx3Bs+tw4T5IqNwmkM7wgLNJMDLue5CmCFtv1leVaIsPCyvitLO9xRSz1Z6KuOSEp095205zvUg+3luqkewU+DSFk/ePAT74kEm/ROdORHAjxRPd5e0SLrlHu426bZQIci38hrQ7i4NSF+QwcmFxWTC4tjWYfGo1yDvmnbGLFXSdHeaTgiUPpvLAeFzalFfkMppBI48nUsYBG7BF+mY2lQRVNqNGJT7h51rFdk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(107886003)(8936002)(8676002)(5660300002)(26005)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ojfa+clS+GYW0rWwQor3RkSTARlkYWSYnGkzGbPskrjbRHSsrKfSgXcLPWWy?=
 =?us-ascii?Q?dqEYX+5OhDv9a+cd+vCKukiYOq17ZfVSuTdQ24IKYwTEWD1xIZFXiCKJbwDf?=
 =?us-ascii?Q?Uc6UVWb2j4mNq7ca5HoZF9xZDOJpiiAB+3lOdMTRAMvnahbaBiySv7DoaZ1z?=
 =?us-ascii?Q?mNl9Jp+1AnI/orifHpbSO2DtLHCxNluC8Va5l4WG89Gkae8fdMR6JxD/mAGB?=
 =?us-ascii?Q?k2JbLYE/ugVOX7+u4CuJIJDm/vf4Stvf/0vgk79PIm8bJfMKzNu4bSfPeFRN?=
 =?us-ascii?Q?zoNdUrAPyiI36I34QqBahPM5cjaiRgXg9Debh6tFCWp+LQrtKw/K4Osn5dNq?=
 =?us-ascii?Q?VQm/PLj6CW8/u45XGS53GIV8MLR8FBy/20kvBEBd+j5qE4z9MqKPW65Dj6VJ?=
 =?us-ascii?Q?KdoIQFUlO2j4x+QuOM7AggJYb3HI3vJKXyBcRrMp64grZd0Uzt+d3Fh3N2PO?=
 =?us-ascii?Q?zAL515/GXoIJ7nCd7m/su3ZvV42okGRyRCoJOpUkw7eVDzcjwz1M7oi6oCe2?=
 =?us-ascii?Q?um40L09D+KhvtDHnW9sI6MIvzcTI1WhZydHnmUIjbJiQOHF0NrSe9o7qG+1e?=
 =?us-ascii?Q?iOpOiVrJVo4I/Oy7GJTFqXyLxyhWHLXgDEuXlPEMGaRQf1S2JOBMCrfXPgAt?=
 =?us-ascii?Q?dbTxwxYHGTIF8KZiESWW8OV0owWCVh1Ga/22/2gJ3BV/Xzu39WAzIqVDt6uH?=
 =?us-ascii?Q?+ZsSDDPxz9VeWNaXSfiPhZMvl/1IyTfDfIO4imIEjbhRmNZiLaatTDxwFNF4?=
 =?us-ascii?Q?9UXrpy+x/NU4K/oynJnkXv7R0pZhNPDZDWtgDHsL2iN7f1b2hKXXAD6jV+Ad?=
 =?us-ascii?Q?yZhZ6ngyYCyFh4+Wup5WYQLN3TSLf6G6Egv0BfMxMNNk6Qd0t4t/gvo1P09y?=
 =?us-ascii?Q?IGyE2aI18e2IzocpuluS3NmcHSGdPsL0onTYrb/PAOjqyzd6whRPdkJCuKP9?=
 =?us-ascii?Q?NzqQUHSLEBLk9oQhk9b73kPl95dhfhy9+dgtq3EuuzKVNAlHPXTBgHXCNlLs?=
 =?us-ascii?Q?Y3OSmc+miDKpQR/kY/rtpddaWhJ6946hPdYtnlIpRpiL25aWRiAIemHO4WR+?=
 =?us-ascii?Q?XJDKobxuclAVoBdieKr2oVRDkhdSz9T+OjhfcpOT+VbMfTid2bKH8rKauOP2?=
 =?us-ascii?Q?HJ/m03bUmQT0shyAb/0wWBENXic8jXzGAGPQIy8D7J02jvjYTWIVI6jWXwbr?=
 =?us-ascii?Q?1ZWRTJYJhiQmy5Lg4TGSLzFNQxSLXkhupTg7M7lvlV8/yTdzhmfyJX72m0+J?=
 =?us-ascii?Q?vUwnbiDGKcdz0Kk7r5hZgIfVPmiN3H26l5cb/EBJ2q5OdBT8/lSlUmeAGcr+?=
 =?us-ascii?Q?L6z4YRXVs51JsppsS3UU2+sTNpw4xFkKDd2v5KeXIBFyi3aoIUG6z+zafVIf?=
 =?us-ascii?Q?XV51opxvQce8jbFymr3C+Ei7INrEKkCuBWvzdUElp3WRndKVXxG/yYJpClW5?=
 =?us-ascii?Q?ZcYPVYZOTLnsiCdeZVtDK1fVzWB1KOPR20kx/mlJzrjMGjuYVoJepHTSNGJx?=
 =?us-ascii?Q?pkF4gHBcI6oNaq+BUEIgonA2zAcDfJDOjqozWPcHs7UbDAUG0xsqiDsDBVoX?=
 =?us-ascii?Q?dDn15fzyoIReXec5jrEr2bcCoLYTGAZdZ7fFSW2O?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20630394-e259-4115-cf42-08db7913b34a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:42:52.5473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ayqYe7EvGXhxyOgLQgq/9RzkntL7bNuUcqgXZy3gWhuVQEAUybvH+MJS9KuRMMBScUsV+6z3dtbieW3oSeSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

Use a new env var fastclose instead of passing fastclose to addr_nr_ns2.
It can be set with 'server' or 'client':

  addr_nr_ns2=fastclose_client \
          run_tests $ns1 $ns2 10.0.1.1

  ->

  fastclose=client \
          run_tests $ns1 $ns2 10.0.1.1.

With this change, the fullmesh flag setting code can be moved into
pm_nl_set_endpoint() from do_transfer().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ad0717cb0d7e..9b12573c55eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -54,6 +54,7 @@ test_linkfail=0
 addr_nr_ns1=0
 addr_nr_ns2=0
 sflags=""
+fastclose=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -831,6 +832,12 @@ pm_nl_set_endpoint()
 	local addr_nr_ns2=${addr_nr_ns2:-0}
 	local sflags=${sflags:-""}
 
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -983,6 +990,7 @@ do_transfer()
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
 	local FAILING_LINKS=${FAILING_LINKS:-""}
+	local fastclose=${fastclose:-""}
 
 	:> "$cout"
 	:> "$sout"
@@ -1019,11 +1027,10 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [ -n "${fastclose}" ]; then
 		if [ ${test_linkfail} -le 1 ]; then
 			echo "fastclose tests need test_linkfail argument"
 			fail_test
@@ -1032,7 +1039,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_linkfail}
-		local side=${addr_nr_ns2:10}
+		local side=${fastclose}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_linkfail}"
@@ -1045,10 +1052,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -3185,7 +3188,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_client \
+		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
@@ -3193,7 +3196,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		test_linkfail=1024 addr_nr_ns2=fastclose_server \
+		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
-- 
2.35.3

