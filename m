Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F361105
	for <mptcp@lists.linux.dev>; Sat,  6 May 2023 05:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFVbmb9rt+S3ylcQUgO6+CTOBIP0IwfZs7zx4iOnq6I5m1jSwhazFbqglX+jvTjheh+6t6wEjyhh8v/Ncu3lZao+DVRW8qtXOxTyt3jvLxtYpfB8RBB1mY9wwExDeMccQ32fNihbUd0dBDOXoVAE+Q8B335MkUgVumTmsiIoW7ZEx+tLShRfW07AdQ3NCzC/FYlS/t/DnwLrDcRJyUVa6xwljmPtKoxEnSx/I/g2Hq6afdTBNFOtuDEfp0E/jgn/5sLkpscnWL5vujixezXzbqYhjrsY9q/T9iZ2hxPfaHpEjAmfNrjGapCL6ONmByt+61TygHt7s2EmUe/i2WW+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPpfqvDwANNW5jAO2c/cYbsHsHiCbI3cd2jZwC2CSLE=;
 b=EtScF6a7UFJeV1UWd9ROAaJEjur4hn0zPL89poiK3q7qeubrLWeVmqApQ5sC6kBz+E518CD2TRkW//Bm93Ib4xGbLPt2k7CWrxGMBDNrabwt3Y3AB2wCWXTvnH8rPxCp5SciQcnghTi2FKg8BMWyZ/KORpZiho30ZaJv2aS+SPKdZzULgYUwl0lkKLrC7kjg2uZQTMBkqLPHj7eGq6cLXQGpg5T9GUZgIsJyRznXE6jDceU9Jn/htC+eQWnJcslu/uRN/S200h6Kruh5vZhSokU/2F2H9gE1UmBQiq7RD9uRyD9IFXYWx0Odz1Iu3vyafQLrn+inESoyvLwrKOXF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPpfqvDwANNW5jAO2c/cYbsHsHiCbI3cd2jZwC2CSLE=;
 b=vHJBxIKXjdJrKLdqZILfAPK34wMqUYbUE4hv28feucm+soWSLMFf6G4YNbpt45bHdxepD2pIMGuKKtuboqWBoR6cK7YXPCi+H/o5DtC/NINstnB3C3zTX/DJF9b1TLsDm6aMwHYr5HehE5IskExS5mm47S/jKUXYHyBSpLoFGIRXXXPh6SHn5qv5XXy4KjD5/SdXwqaYquMDsvvl0pf2eHAsu376nr6VLXYGgaIgJ5Q0w4UYaj+rVC0m5/azyu/sQu3awIvDhJ0aD7cS+R/BnMVIan8alC1djN4To4nVVTN0jShnR+60h5YYyUWJJOkMWWd3eLcnTcCvK+T113YYMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7612.eurprd04.prod.outlook.com (2603:10a6:10:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 05:10:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Sat, 6 May 2023
 05:10:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 12/12] selftests: mptcp: do endpoint manipulation out of transfer
Date: Sat,  6 May 2023 13:09:00 +0800
Message-Id: <b38c982aef1256dc235a108cf0156a66ee3053dc.1683349666.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1683349666.git.geliang.tang@suse.com>
References: <cover.1683349666.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1beb89-5206-460b-9e9b-08db4df02f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yTJCDZZHIHd9bkwGcOVlB/+ntOlGPaMFwJ4LY/SKdqHXILb9cw5PJAh81zhYhtTOZnpUMZaiTwmHA2lVTAlrmRTJtlY7cgCWpTX+BjKLMMsRZj51hnuJyTpHKsV69P8gPa/GkDq0rzO/NfAxT+80g/NgtPulxxPGNm+HR8T7uV9PldHwzkT8/fPnidMwvqbI6uV9YujEmSfDNrtC9C6Kg3X3NAypLW+SeMB18E1kVIS3hIXaCEucgqPAiylUy9FLIjDGaAaSevI0w/Il1Vh2grAvkm6XE6/f9P8yS9j3Q+/gqbF3ApIhxQpd1n+iknphbh5a3k1Sfk3/hDMnFjWvoTnLffnyTLoyMhDzZJSkHBqtgd7vium4LTg6kRktqXGiJcsRPHWitq+cL25Fg3v8evz6Keduv+yjdRk0qDfl65/4n7mjcpXjS/upoehFB2XxvpJuLhSC1J6pdicS+TUp0Wqax/o8NLa2Aid5ledAJAOQZ1fa9u0qe28nRFw9rkjW2NJpT08rIva5dTVEIJKVe1w+qOKyjWLS3a1AkknDmf5CMyqTKtP6/WbC3K4DG+CQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(5660300002)(41300700001)(44832011)(66556008)(66946007)(66476007)(30864003)(6916009)(2906002)(4326008)(8676002)(316002)(8936002)(478600001)(6486002)(6666004)(83380400001)(107886003)(6512007)(6506007)(26005)(36756003)(86362001)(2616005)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MovTQv+jkpc5gPhPW2n7bLDpa6koaUpHwFzlCOAPkp/yUp19uI9D0pEaas6l?=
 =?us-ascii?Q?x1omBm5pgtya3Ga9DtDtfuNxUz2fhKi41Gdh0NKICLOUmZewIaLDSylOKYKy?=
 =?us-ascii?Q?Yuuzh4WPB+WaQhsIPOyKItTCeST415PstSdY1AxDEVFJPH6RZM9SYYvI31rn?=
 =?us-ascii?Q?OAFCL2MIKoQCAdxfQc/SL8iWGTCopOp/OpSOwcB5HV1iAEi0ecHDq5M/IH9S?=
 =?us-ascii?Q?cDJKb3oFIvhqqXtfvKtNYxI9go9MbkqEMHmqST4RTU5hkuY/THgHzVGQdRrY?=
 =?us-ascii?Q?H2UfNdhrd8H6uk/UBSzqMXVk/eBVGV3aZBBRI0/QCSDWLJLyy/lgZFl2f9dY?=
 =?us-ascii?Q?rL8UEENVua8JN+UVTDnpDDI43iAKH3ai11WoTJYBLuxPo6nn/5yVHloQUtsS?=
 =?us-ascii?Q?+7MkZeu9kvJ1EuXms70LUZe1xVWPp2eXb5Wur/JPotLDRYYoj7JewDyJsvvK?=
 =?us-ascii?Q?vRl303Qat8geqPeLXXTCrskhxlzOOUHZkC6DzedEBPVTwtfwY+/Hi9JeBM0V?=
 =?us-ascii?Q?ODhKM/rAteMUeflPbz7GJ9E/39uuCrunGqXB9RAqY4jxFiU/1nS0hyqg81cz?=
 =?us-ascii?Q?qRnxSy0UyfjLnzAfb3B/NTbGwZuw22ZdZJsDmQ2eXKTXdSTOCP8k7Lt6Y5h9?=
 =?us-ascii?Q?QQ0OsjiHigjgOEm4g59yVw68CNdDrP/GwPZOWFliUFmIHJwJkz5VI373LnQy?=
 =?us-ascii?Q?zNdX+ZnaxYFD0g0fGcT7Myus/vmTbkUGt0UcCpXyF8btuGcHcciFSR3AsMPv?=
 =?us-ascii?Q?tTFDXc5r+0tj/YcS4NKi6NV8Ii5P6Tnj2EAIqcOb/wpCZ1kM3nc2jGBgik0f?=
 =?us-ascii?Q?kkI0/0PsB45/u3l5VHyu/ohgJ9HRykuFaw+Ny5oEHo8+uTo5wq/NIN/wc+vp?=
 =?us-ascii?Q?3cMo6IWqdNum+886CK5XaMUpNUfJUTdTtClhtL+MoiFMU393c0lygoxXP1AB?=
 =?us-ascii?Q?7RPeTDjYbAJbq/cEtJNRsxTH1COhZCnN2ZHeNogpFrROFnXu90iI6oc9tsZP?=
 =?us-ascii?Q?F1sv5SiTzMNPdsGRhrp5lgxA5RVgVGwh+YmNTW1/oynjPPYAvrp7Z7AuMpsB?=
 =?us-ascii?Q?JhfYlgu3Q1SO835SadbyglFQT7nPpcSrTnF5Z4f+CGffY6xfUz+KQVABquj3?=
 =?us-ascii?Q?qcTPt4FtGqXJVhFLLImSs/umrae+olHQet44z/XPm5J7CRAEcky21u8mDsZO?=
 =?us-ascii?Q?zda0GUt7vl/gs18/okach1FJzLa2bO6b6cW0HOZOI7AFykYlIiGqxSCw7T0k?=
 =?us-ascii?Q?iTxDWa/1rGA0MvxyOQj7mu2piFI0aDbJQxxg2XmRzTKwDkCi0P4UBJkQF5/x?=
 =?us-ascii?Q?X6urr0Ph7SEXps/o0KLwVV+UzFRP2cToB9GXrQAy4Tf1CYqJYQ5VnRuOI5aQ?=
 =?us-ascii?Q?lvbXArBd+aofL+n3FSlIfcaqsDvTjP4S864CoDtXg2i11ZQb7sGauLjRKoTz?=
 =?us-ascii?Q?XJF3JjVKUsq6+c1VSuRsB2NXhHAETdai5PjRlBzHfGREJ/iytp5VE1itf7dX?=
 =?us-ascii?Q?YCzcCg0D313kW1TZUuYV3MApfjup39/qXmyBqip+fuVODlQK/dj5yWfSgC+G?=
 =?us-ascii?Q?dXWi2gZDv08zx3dlmYzN5Fc+X5p1xV8k9cZjvYBU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1beb89-5206-460b-9e9b-08db4df02f49
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 05:10:18.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PAKMPDipGW0OWQp/2OWl838LuaB3nGk8minvR1DH5x1n3zoT+IiVKumU5zunA+bMW2SyMeYz7wBY1VkeIlKHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7612

This patch moves endpoint manipulation out of do_transfer() into a new
function endpoint_manipulation(), then addr_nr_ns1 and addr_nr_ns2
arguments can be removed for do_transfer() and run_tests().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 525 +++++++++++-------
 1 file changed, 309 insertions(+), 216 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6c4c1dc817f5..1f04a9627ece 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -716,10 +716,8 @@ do_transfer()
 	local srv_proto="$4"
 	local connect_addr="$5"
 	local test_link_fail="$6"
-	local addr_nr_ns1="$7"
-	local addr_nr_ns2="$8"
-	local speed="$9"
-	local sflags="${10}"
+	local speed="$7"
+	local sflags="${8}"
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
@@ -759,7 +757,6 @@ do_transfer()
 		extra_args="-r ${speed:6}"
 	fi
 
-	local flags="subflow"
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
@@ -785,11 +782,6 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		sflags=0
-	fi
-	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
-		flags="${flags},fullmesh"
-		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
 
 	extra_srv_args="$extra_args $extra_srv_args"
@@ -830,145 +822,6 @@ do_transfer()
 	fi
 	local cpid=$!
 
-	# let the mptcp subflow be established in background before
-	# do endpoint manipulation
-	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
-		sleep 1
-	fi
-
-	if [ $addr_nr_ns1 -gt 0 ]; then
-		local counter=2
-		local add_nr_ns1=${addr_nr_ns1}
-		local id=10
-		while [ $add_nr_ns1 -gt 0 ]; do
-			local addr
-			if is_v6 "${connect_addr}"; then
-				addr="dead:beef:$counter::1"
-			else
-				addr="10.0.$counter.1"
-			fi
-			pm_nl_add_endpoint $ns1 $addr flags signal
-			counter=$((counter + 1))
-			add_nr_ns1=$((add_nr_ns1 - 1))
-			id=$((id + 1))
-		done
-	elif [ $addr_nr_ns1 -lt 0 ]; then
-		local rm_nr_ns1=$((-addr_nr_ns1))
-		if [ $rm_nr_ns1 -lt 8 ]; then
-			local counter=0
-			local line
-			pm_nl_show_endpoints ${listener_ns} | while read -r line; do
-				# shellcheck disable=SC2206 # we do want to split per word
-				local arr=($line)
-				local nr=0
-
-				local i
-				for i in "${arr[@]}"; do
-					if [ $i = "id" ]; then
-						if [ $counter -eq $rm_nr_ns1 ]; then
-							break
-						fi
-						id=${arr[$nr+1]}
-						rm_addr=$(rm_addr_count ${connector_ns})
-						pm_nl_del_endpoint ${listener_ns} $id
-						wait_rm_addr ${connector_ns} ${rm_addr}
-						counter=$((counter + 1))
-					fi
-					nr=$((nr + 1))
-				done
-			done
-		elif [ $rm_nr_ns1 -eq 8 ]; then
-			pm_nl_flush_endpoint ${listener_ns}
-		elif [ $rm_nr_ns1 -eq 9 ]; then
-			pm_nl_del_endpoint ${listener_ns} 0 ${connect_addr}
-		fi
-	fi
-
-	# if newly added endpoints must be deleted, give the background msk
-	# some time to created them
-	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
-
-	if [ $addr_nr_ns2 -gt 0 ]; then
-		local add_nr_ns2=${addr_nr_ns2}
-		local counter=3
-		local id=20
-		while [ $add_nr_ns2 -gt 0 ]; do
-			local addr
-			if is_v6 "${connect_addr}"; then
-				addr="dead:beef:$counter::2"
-			else
-				addr="10.0.$counter.2"
-			fi
-			pm_nl_add_endpoint $ns2 $addr flags $flags
-			counter=$((counter + 1))
-			add_nr_ns2=$((add_nr_ns2 - 1))
-			id=$((id + 1))
-		done
-	elif [ $addr_nr_ns2 -lt 0 ]; then
-		local rm_nr_ns2=$((-addr_nr_ns2))
-		if [ $rm_nr_ns2 -lt 8 ]; then
-			local counter=0
-			local line
-			pm_nl_show_endpoints ${connector_ns} | while read -r line; do
-				# shellcheck disable=SC2206 # we do want to split per word
-				local arr=($line)
-				local nr=0
-
-				local i
-				for i in "${arr[@]}"; do
-					if [ $i = "id" ]; then
-						if [ $counter -eq $rm_nr_ns2 ]; then
-							break
-						fi
-						local id rm_addr
-						# rm_addr are serialized, allow the previous one to
-						# complete
-						id=${arr[$nr+1]}
-						rm_addr=$(rm_addr_count ${listener_ns})
-						pm_nl_del_endpoint ${connector_ns} $id
-						wait_rm_addr ${listener_ns} ${rm_addr}
-						counter=$((counter + 1))
-					fi
-					nr=$((nr + 1))
-				done
-			done
-		elif [ $rm_nr_ns2 -eq 8 ]; then
-			pm_nl_flush_endpoint ${connector_ns}
-		elif [ $rm_nr_ns2 -eq 9 ]; then
-			local addr
-			if is_v6 "${connect_addr}"; then
-				addr="dead:beef:1::2"
-			else
-				addr="10.0.1.2"
-			fi
-			pm_nl_del_endpoint ${connector_ns} 0 $addr
-		fi
-	fi
-
-	if [ -n "${sflags}" ]; then
-		sleep 1
-
-		local netns
-		for netns in "$ns1" "$ns2"; do
-			local line
-			pm_nl_show_endpoints $netns | while read -r line; do
-				# shellcheck disable=SC2206 # we do want to split per word
-				local arr=($line)
-				local nr=0
-				local id
-
-				local i
-				for i in "${arr[@]}"; do
-					if [ $i = "id" ]; then
-						id=${arr[$nr+1]}
-					fi
-					nr=$((nr + 1))
-				done
-				pm_nl_change_endpoint $netns $id $sflags
-			done
-		done
-	fi
-
 	wait $cpid
 	local retc=$?
 	wait $spid
@@ -1038,10 +891,8 @@ run_tests()
 	local connector_ns="$2"
 	local connect_addr="$3"
 	local test_linkfail="${4:-0}"
-	local addr_nr_ns1="${5:-0}"
-	local addr_nr_ns2="${6:-0}"
-	local speed="${7:-fast}"
-	local sflags="${8:-""}"
+	local speed="${5:-fast}"
+	local sflags="${6:-""}"
 
 	local size
 
@@ -1086,7 +937,7 @@ run_tests()
 	fi
 
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
+		${test_linkfail} ${speed} ${sflags}
 }
 
 dump_stats()
@@ -1796,6 +1647,159 @@ set_userspace_pm()
 	ip netns exec $ns sysctl -q net.mptcp.pm_type=1
 }
 
+endpoint_manipulation()
+{
+	local connect_addr="$1"
+	local addr_nr_ns1="$2"
+	local addr_nr_ns2="${3:-0}"
+	local sflags="${4:-""}"
+
+	local flags="subflow"
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		flags="${flags},fullmesh"
+		addr_nr_ns2=${addr_nr_ns2:9}
+	fi
+
+	# let the mptcp subflow be established in background before
+	# do endpoint manipulation
+	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
+		sleep 1
+	fi
+
+	if [ $addr_nr_ns1 -gt 0 ]; then
+		local counter=2
+		local add_nr_ns1=${addr_nr_ns1}
+		local id=10
+		while [ $add_nr_ns1 -gt 0 ]; do
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:$counter::1"
+			else
+				addr="10.0.$counter.1"
+			fi
+			pm_nl_add_endpoint $ns1 $addr flags signal
+			counter=$((counter + 1))
+			add_nr_ns1=$((add_nr_ns1 - 1))
+			id=$((id + 1))
+		done
+	elif [ $addr_nr_ns1 -lt 0 ]; then
+		local rm_nr_ns1=$((-addr_nr_ns1))
+		if [ $rm_nr_ns1 -lt 8 ]; then
+			local counter=0
+			local line
+			pm_nl_show_endpoints $ns1 | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
+				local arr=($line)
+				local nr=0
+
+				local i
+				for i in "${arr[@]}"; do
+					if [ $i = "id" ]; then
+						if [ $counter -eq $rm_nr_ns1 ]; then
+							break
+						fi
+						id=${arr[$nr+1]}
+						rm_addr=$(rm_addr_count $ns2)
+						pm_nl_del_endpoint $ns1 $id
+						wait_rm_addr $ns2 ${rm_addr}
+						counter=$((counter + 1))
+					fi
+					nr=$((nr + 1))
+				done
+			done
+		elif [ $rm_nr_ns1 -eq 8 ]; then
+			pm_nl_flush_endpoint $ns1
+		elif [ $rm_nr_ns1 -eq 9 ]; then
+			pm_nl_del_endpoint $ns1 0 ${connect_addr}
+		fi
+	fi
+
+	# if newly added endpoints must be deleted, give the background msk
+	# some time to created them
+	[ $addr_nr_ns1 -gt 0 ] && [ $addr_nr_ns2 -lt 0 ] && sleep 1
+
+	if [ $addr_nr_ns2 -gt 0 ]; then
+		local add_nr_ns2=${addr_nr_ns2}
+		local counter=3
+		local id=20
+		while [ $add_nr_ns2 -gt 0 ]; do
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:$counter::2"
+			else
+				addr="10.0.$counter.2"
+			fi
+			pm_nl_add_endpoint $ns2 $addr flags $flags
+			counter=$((counter + 1))
+			add_nr_ns2=$((add_nr_ns2 - 1))
+			id=$((id + 1))
+		done
+	elif [ $addr_nr_ns2 -lt 0 ]; then
+		local rm_nr_ns2=$((-addr_nr_ns2))
+		if [ $rm_nr_ns2 -lt 8 ]; then
+			local counter=0
+			local line
+			pm_nl_show_endpoints $ns2 | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
+				local arr=($line)
+				local nr=0
+
+				local i
+				for i in "${arr[@]}"; do
+					if [ $i = "id" ]; then
+						if [ $counter -eq $rm_nr_ns2 ]; then
+							break
+						fi
+						local id rm_addr
+						# rm_addr are serialized, allow the previous one to
+						# complete
+						id=${arr[$nr+1]}
+						rm_addr=$(rm_addr_count $ns1)
+						pm_nl_del_endpoint $ns2 $id
+						wait_rm_addr $ns1 ${rm_addr}
+						counter=$((counter + 1))
+					fi
+					nr=$((nr + 1))
+				done
+			done
+		elif [ $rm_nr_ns2 -eq 8 ]; then
+			pm_nl_flush_endpoint $ns2
+		elif [ $rm_nr_ns2 -eq 9 ]; then
+			local addr
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:1::2"
+			else
+				addr="10.0.1.2"
+			fi
+			pm_nl_del_endpoint $ns2 0 $addr
+		fi
+	fi
+
+	if [ -n "${sflags}" ]; then
+		sleep 1
+
+		local netns
+		for netns in "$ns1" "$ns2"; do
+			local line
+			pm_nl_show_endpoints $netns | while read -r line; do
+				# shellcheck disable=SC2206 # we do want to split per word
+				local arr=($line)
+				local nr=0
+				local id
+
+				local i
+				for i in "${arr[@]}"; do
+					if [ $i = "id" ]; then
+						id=${arr[$nr+1]}
+					fi
+					nr=$((nr + 1))
+				done
+				pm_nl_change_endpoint $netns $id $sflags
+			done
+		done
+	fi
+}
+
 subflows_tests()
 {
 	if reset "no JOIN"; then
@@ -1868,7 +1872,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -1879,7 +1883,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1890,7 +1894,7 @@ subflows_error_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 DROP
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -1902,7 +1906,7 @@ subflows_error_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		filter_tcp_from $ns1 10.0.3.2 REJECT
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow &
 
 		# mpj subflow will be in TW after the reset
 		wait_attempt_fail $ns2
@@ -2001,7 +2005,7 @@ signal_address_tests()
 
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 3 3 3
 
 		# the server will not signal the address terminating
@@ -2102,7 +2106,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_tx_nr 4 4
 		chk_add_nr 4 0
@@ -2113,7 +2117,7 @@ add_addr_timeout_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 4 0
 	fi
@@ -2124,7 +2128,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 2 2 2
 		chk_add_nr 8 0
 	fi
@@ -2135,7 +2139,7 @@ add_addr_timeout_tests()
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10
 		chk_join_nr 1 1 1
 		chk_add_nr 8 0
 	fi
@@ -2148,10 +2152,12 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -1
 		chk_join_nr 1 1 1
 		chk_rm_tx_nr 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# multiple subflows, remove
@@ -2160,9 +2166,11 @@ remove_tests()
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -2
 		chk_join_nr 2 2 2
 		chk_rm_nr 2 2
+		kill_tests_wait
 	fi
 
 	# single address, remove
@@ -2170,10 +2178,12 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_tests_wait
 	fi
 
 	# subflow and signal, remove
@@ -2182,10 +2192,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# subflows and signal, remove
@@ -2195,10 +2207,12 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1 -2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 2 2
+		kill_tests_wait
 	fi
 
 	# addresses remove
@@ -2208,10 +2222,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -3
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert
+		kill_tests_wait
 	fi
 
 	# invalid addresses remove
@@ -2221,10 +2237,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -3 0 speed_10
+		run_tests $ns1 $ns2 10.0.1.1 0 speed_10 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -3
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		kill_tests_wait
 	fi
 
 	# subflows and signal, flush
@@ -2234,10 +2252,13 @@ remove_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		wait_mpj $ns2
+		endpoint_manipulation 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		kill_tests_wait
 	fi
 
 	# subflows flush
@@ -2247,10 +2268,13 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		wait_mpj $ns2
+		endpoint_manipulation 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_rm_tx_nr 0
 		chk_rm_nr 0 3 simult
+		kill_tests_wait
 	fi
 
 	# addresses flush
@@ -2260,10 +2284,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8 -8
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 		chk_rm_nr 3 3 invert simult
+		kill_tests_wait
 	fi
 
 	# invalid addresses flush
@@ -2273,10 +2299,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -8
 		chk_join_nr 1 1 1
 		chk_add_nr 3 3
 		chk_rm_nr 3 1 invert
+		kill_tests_wait
 	fi
 
 	# remove id 0 subflow
@@ -2284,9 +2312,11 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -9
 		chk_join_nr 1 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# remove id 0 address
@@ -2294,10 +2324,12 @@ remove_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -9
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_tests_wait
 	fi
 }
 
@@ -2307,42 +2339,54 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 1
 		chk_join_nr 1 1 1
+		kill_tests_wait
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 10.0.1.1 0 0 2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 2
 		chk_join_nr 2 2 2
+		kill_tests_wait
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 2 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		wait_mpj $ns2
+		endpoint_manipulation dead:beef:1::1 0 2
+		wait_mpj $ns2
 		chk_join_nr 2 2 2
+		kill_tests_wait
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 2
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		kill_tests_wait
 	fi
 }
 
@@ -2353,14 +2397,14 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# add_address, unused IPv6
 	if reset "unused signal address IPv6"; then
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 0 0 0
 		chk_add_nr 1 1
 	fi
@@ -2370,7 +2414,7 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 	fi
@@ -2380,10 +2424,12 @@ ipv6_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_rm_nr 1 1 invert
+		kill_tests_wait
 	fi
 
 	# subflow and signal IPv6, remove
@@ -2392,10 +2438,12 @@ ipv6_tests()
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 }
 
@@ -2492,7 +2540,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 	fi
 
@@ -2501,7 +2549,7 @@ mixed_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2511,7 +2559,7 @@ mixed_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
-		run_tests $ns1 $ns2 dead:beef:2::1 0 0 0 slow
+		run_tests $ns1 $ns2 dead:beef:2::1 0 slow
 		chk_join_nr 1 1 1
 	fi
 
@@ -2522,8 +2570,11 @@ mixed_tests()
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
-		run_tests $ns1 $ns2 dead:beef:1::1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 dead:beef:1::1 0 slow 2>/dev/null &
+		endpoint_manipulation dead:beef:1::1 0 fullmesh_1
+		wait_mpj $ns1
 		chk_join_nr 4 4 4
+		kill_tests_wait
 	fi
 }
 
@@ -2534,9 +2585,11 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 nobackup
 		chk_join_nr 1 1 1
 		chk_prio_nr 0 1
+		kill_tests_wait
 	fi
 
 	# single address, backup
@@ -2544,10 +2597,13 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		wait_mpj $ns1
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
+		kill_tests_wait
 	fi
 
 	# single address with port, backup
@@ -2555,15 +2611,18 @@ backup_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		wait_mpj $ns1
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_prio_nr 1 1
+		kill_tests_wait
 	fi
 
 	if reset "mpc backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
@@ -2571,24 +2630,28 @@ backup_tests()
 	if reset "mpc backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
 	fi
 
 	if reset "mpc switch to backup"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
+		kill_tests_wait
 	fi
 
 	if reset "mpc switch to backup both sides"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 1 1
+		kill_tests_wait
 	fi
 }
 
@@ -2672,7 +2735,8 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
@@ -2680,6 +2744,7 @@ add_addr_ports_tests()
 		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
 		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
 		kill_events_pids
+		kill_tests_wait
 	fi
 
 	# subflow and signal with port, remove
@@ -2688,10 +2753,12 @@ add_addr_ports_tests()
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 -1 -1
 		chk_join_nr 2 2 2
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1
+		kill_tests_wait
 	fi
 
 	# subflows and signal with port, flush
@@ -2701,10 +2768,13 @@ add_addr_ports_tests()
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		wait_mpj $ns2
+		endpoint_manipulation 10.0.1.1 -8 -2
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
 		chk_rm_nr 1 3 invert simult
+		kill_tests_wait
 	fi
 
 	# multiple addresses with port
@@ -2903,9 +2973,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 1
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# fullmesh 2
@@ -2915,9 +2987,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		wait_mpj $ns1
+		endpoint_manipulation 10.0.1.1 0 fullmesh_1
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# fullmesh 3
@@ -2927,9 +3002,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 5
 		pm_nl_set_limits $ns2 1 5
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_2
 		chk_join_nr 5 5 5
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# fullmesh 4
@@ -2940,9 +3017,11 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 2 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_2
 		chk_join_nr 4 4 4
 		chk_add_nr 1 1
+		kill_tests_wait
 	fi
 
 	# set fullmesh flag
@@ -2950,9 +3029,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 1 fullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 
 	# set nofullmesh flag
@@ -2960,9 +3042,12 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 fullmesh_1 nofullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 
 	# set backup,fullmesh flags
@@ -2970,10 +3055,13 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
-		run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow backup,fullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 1 backup,fullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 
 	# set nobackup,nofullmesh flags
@@ -2981,24 +3069,27 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup,nofullmesh
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 0 nobackup,nofullmesh
+		wait_mpj $ns1
 		chk_join_nr 2 2 2
 		chk_prio_nr 0 1
 		chk_rm_nr 0 1
+		kill_tests_wait
 	fi
 }
 
 fastclose_tests()
 {
 	if reset "fastclose test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset "fastclose server test"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
@@ -3141,7 +3232,7 @@ userspace_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
+		run_tests $ns1 $ns2 10.0.1.1 0 slow backup
 		chk_join_nr 1 1 0
 		chk_prio_nr 0 0
 	fi
@@ -3153,16 +3244,18 @@ userspace_tests()
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
+		endpoint_manipulation 10.0.1.1 0 -1
 		chk_join_nr 0 0 0
 		chk_rm_nr 0 0
+		kill_tests_wait
 	fi
 
 	# userspace pm add & remove address
 	if reset_with_events "userspace pm add & remove address"; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 		wait_mpj $ns1
 		userspace_pm_add_addr 10.0.2.1 10
 		sleep 1
@@ -3183,7 +3276,7 @@ userspace_tests()
 	if reset_with_events "userspace pm create destroy subflow"; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 		wait_mpj $ns2
 		userspace_pm_add_sf 10.0.3.2 20
 		sleep 1
@@ -3206,7 +3299,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3234,7 +3327,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		run_tests $ns1 $ns2 10.0.1.1 4 speed_20 2>/dev/null &
 
 		wait_mpj $ns2
 		chk_subflow_nr needtitle "before delete" 2
-- 
2.35.3

