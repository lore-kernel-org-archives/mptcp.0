Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A51B75
	for <mptcp@lists.linux.dev>; Tue, 15 Mar 2022 06:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647327553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnn9IZtqT4kIKhVOcqxMgAMgBMJFPZzZPkyzjN4QOtM=;
	b=HV3JYOoaxC5ZgmaIYeXECPeSI5yAlMbsTKm1hZTQcST6aEuiYtgOKOboLqkXHa8O4LZPmT
	6uBq+9MF42VQ3KrENqJGcDc9hKu1WZY2LPK4dJc11gOMVsLnbCOjTJo7eQE8YPYDc+xlRj
	sMklfkQF4yZA/TwKScEu6UK7iZX+3mc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-92YUEuDzOli0nT7uhMTyGg-1; Tue, 15 Mar 2022 07:59:12 +0100
X-MC-Unique: 92YUEuDzOli0nT7uhMTyGg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6QF/I/tHv05Qn57iagk60AxcyNTTKRh3Mu4rGoVd6wV+jsRPw0bvF4/gkQpIltaBK4Ix4v4IPyivI+kEouMTrl4/+xhOPiFNf6Q9+sTATnBaSL5lFrzolB+WRfZSH6Z6SVNKqJqvyLTcRHK7z/S3lGyYJCjH9+/BPNlrw6I8wXH4WKLKf37lhzhK2LCI0B4tYc5h2VhyMRX/NKTvJaMB8LBYAg4tduyZzhpI5CSFpCOzj+V9Uj9OR7u/iusVM57Fqr6tzGeOlH8kQpnrC0UBEzoNXGDDD9g2I9btGDT4yhBqY6IXpO3jD13GBUbO7Uebq/c9gEhHIrhtsvGbVZ0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JqS73Y7HFpZcVVKEOxTx68bXAb6XxNNvOwtcqTbRLg=;
 b=B9Xrgsw7ogV7sgivO8pPd++7rltVo7WjoaTQ9OJa4lFN/elYenvQJXMIkJPW8Hito88bL97B+fZzgQmLMDndcA8IQ6QhQiQMR+wg7j2q9+aMTETUX09TRkiFloRr9dq9IodzL1Kxpd1t7qeZ2ngRwF+qzVjSMY73ZSP04MYxjrDzVEQT9z3/TD5kQIsZ84ZYgifT7j1bmmqzjcz72ojph7AWwApaCVerHe+z3c0FZjy0NZQSC/qui9U0LR3Xr2QxGGkTz0PXGtMU99Oqbk4di3cLc7oHtGRRh15iSfL4fq6onoKU6eXrUoeH0DggwdG4aj6YkvSSuyXkeQYk+H5BOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3138.eurprd04.prod.outlook.com (2603:10a6:206:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 06:59:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 06:59:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 6/6] selftests: mptcp: print extra msg in chk_csum_nr
Date: Tue, 15 Mar 2022 14:58:26 +0800
Message-ID: <be2f8bba76fd1a74f31e23f1fd1c5fde457e5108.1647327162.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647327162.git.geliang.tang@suse.com>
References: <cover.1647327162.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10d06f45-ebd6-4725-e827-08da06514f2d
X-MS-TrafficTypeDiagnostic: AM5PR04MB3138:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB31387F781E807E463242E7F5F8109@AM5PR04MB3138.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w5EB0zTaLFzhhjnFbazkqfqRcz4mO224uQ1igxSihlOFb/FyN0gS8hbSBcepiKSS0TSxjJ7OZDbAoC5utPpFAL9BM9dXEKM7h4+iaog1NfBhCN1skQl1tTK3tANx3Vdcc1xBQQSsTBJkioB3uu9rRNxHZJsR7dZE2pvCqTzg3ivUh02aiQVrWFpsrK//jmq6WCLm6gGgF+EQYaREPBm+/vpOrLe9QWvzny3VpWtwXqfBYxgNfvLGJUF5snK6MFMmbkm7cXKowLA1McpRiTMtWE5deC9Tu6iPg808YEPbpzPUlwKU6ID7TPUDpgbF745yWMZOIrEY54WnrJfZUdlS/HlJxMvMUhJws9x/GfYuIx5dc+a7E8MzxFE5iWSh2YQ82wyqiT48UCcUb09JfScCRPJX4DdvrAlHliBjXe6MmYdyFaXD1P4lEZGMvrkDdGZGet9409fc43IjSGw5YDEeuCn9iXb5B1sCDImcGPm57a6CuEv2Dj6C2zoVPSJDQt4G9YolW6hpPAF666jP/oR22p4neeOTqtOp3Oheo1KyKGyBruS2aW1JfXlEMN1yXdDWbxoKI55YsHFjmRMKOlRLO3gvtHKV9UR91UxnQu65XZ8PNvBDsjfoz0e/n0pK2mvOBamCEG0hpZWtlOPzbUCPvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(66946007)(66556008)(6506007)(6512007)(6666004)(38100700002)(36756003)(6486002)(5660300002)(508600001)(66476007)(107886003)(83380400001)(6916009)(8936002)(2906002)(86362001)(44832011)(2616005)(316002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AYSNRZvXtbG7Ew0ioPfo86v9/8pFpGGhvJq5PPnQnl1axftgoC9mRGBB8Ltc?=
 =?us-ascii?Q?nnLxvL/BclrmWc1oYfG74MBk6jhDMiD90vleuKedCX5yw5z82Jomw8Ti07je?=
 =?us-ascii?Q?cPy7XBPv0BKrTVuQZ1bARSn0zIY/b+kK7xOuPEIkAhLeR2G9MyKUp1TVdJiP?=
 =?us-ascii?Q?luxVy06QldsGM0KDi3kjw0AJNmO6rmpUbomxGwNRABgY6ur3WNRX0WD/pV3y?=
 =?us-ascii?Q?3hBynyyYXccix5EoNl+D3WiZPoIGUsy9hiSjls55ErkhYKIw3CP0ykSRARzt?=
 =?us-ascii?Q?7rvhOXW91THRKxWhElQotcMVGuxcrsnj848OTkhDXFrqw0MKy8YX/12MsoNt?=
 =?us-ascii?Q?4sthIUU0RRS3sSr168iFoyif43LDvh8jyIWcVbdldC6SgiO/Ukjnz9cxPQ+y?=
 =?us-ascii?Q?t2fH9VkNML3SJBwbRZIs4HqIGY53qnQgA8eFt8PoOeBC7HkpLH6OKm6BlKhf?=
 =?us-ascii?Q?mDrgO4b3aL8lq0hzIBlcyo/V5EJPhphqO+wiLu3OnIL2K8gYzG+gHekZhczU?=
 =?us-ascii?Q?hcCAw0SsoR+RMm+VqXdF3n0Rb1AOKVwNjgXl3yuK7q1cnCUkwWDuLrfW214m?=
 =?us-ascii?Q?nJVNNe8Y7p59rv2POAWFVtK0lx2Erq2v4LjljnvO/2ji7Yu4bGV5iP/wP/+I?=
 =?us-ascii?Q?UXTrPPXq38tA8fdEOA+TXqJ4jI0fCEfZ0bZVXcnTK2ZBhSTTFEMzQVihoE4P?=
 =?us-ascii?Q?QugPkVhifFX1c11EUyvDvQh+trkhBo6y99hFg7wfn9pBckfuG3tSBDlddmrx?=
 =?us-ascii?Q?5Ak2k4aMg9UTt77+JJJEi0tgP+ynTMwSC2r8Jkg67qHB/qArCt3JgioqAczR?=
 =?us-ascii?Q?dYZpAB3YJwgHGPGJIdkZvSQQxoWA61ilHDQbrBSxC7dsD+zUlRO+c3M/3+zU?=
 =?us-ascii?Q?6XX/A40nf/pGkiQfm3jpDEsq1tl8vcFb5ESEOSqYk7FASbtLei2cgI+g1h+Y?=
 =?us-ascii?Q?+5K4no6XY9yonrTBzjjc3ZyyNawb1I2ki8Woh54ZT94UdWSGy3H1JMbXl8qB?=
 =?us-ascii?Q?gDg01awxV5y3XLnV2W/4Q0x4A6maYUFORohW+POgCHxeIL/86oXbhv3/Riqg?=
 =?us-ascii?Q?S0QEbJkHCBDDS5l0JL13PVVAsnetZfy8ycC74LFJgVesM2fgxv6poauuykpj?=
 =?us-ascii?Q?B2+ZF+E64/HHOcaHTlhmYhP82p5VkckExeHrvN80zbA6mhiQKQzJvbGtIYms?=
 =?us-ascii?Q?mnlb/n+Y1FkZA9rTrmSUTB6O2AB2MxknypbuhXEL4/K94lOyvo2yp+uZfGbQ?=
 =?us-ascii?Q?oJlZlItkl3qXBQtXRyrjEMu3dq0g5XcYVZjldDVbTSueJtvUZ1Z80VoOzNoj?=
 =?us-ascii?Q?6jpv8idVQSLOqbpvLLHnsI0Ys59cO+uhRadF1HIyLEhsTuDINHqV1icii+tn?=
 =?us-ascii?Q?GybzXoeAOWQTqWinJcDbyutY78CWv49F05laVCnLawT+Vleq46P+no25wHDj?=
 =?us-ascii?Q?oxU7VzniU4X166pJft6qG8S8xuLXE2noPl97tSaVmyVnMdggb0NkxIsLwbrm?=
 =?us-ascii?Q?VBjgUoAPaa52JbRa3Cg1FYbUEcvWJzKO7O50czp9mx5WtA1Pm8nFTGMe1Q?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d06f45-ebd6-4725-e827-08da06514f2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 06:59:11.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ar9fI+yEPD68buSQI+h6To6wAw2+QSEqlhrNqV7prnCDsbTik0w8cBF/eijZBUVtSZFkQ3dlpUDq6+LooIpPwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3138

When the multiple checksum errors occur in chk_csum_nr(), print the
numbers of the errors as an extra message.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2b77576d773c..375b087edc7b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1014,6 +1014,7 @@ chk_csum_nr()
 	local csum_ns2=3D${2:-0}
 	local count
 	local dump_stats
+	local extra_msg=3D""
 	local allow_multi_errors_ns1=3D0
 	local allow_multi_errors_ns2=3D0
=20
@@ -1029,6 +1030,9 @@ chk_csum_nr()
 	printf "%-${nr_blank}s %s" " " "sum"
 	count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '=
{print $2}')
 	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$csum_ns1" ]; then
+		extra_msg=3D"$extra_msg ns1=3D$count"
+	fi
 	if { [ "$count" !=3D $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } =
||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; =
then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
@@ -1040,15 +1044,20 @@ chk_csum_nr()
 	echo -n " - csum  "
 	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '=
{print $2}')
 	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$csum_ns2" ]; then
+		extra_msg=3D"$extra_msg ns2=3D$count"
+	fi
 	if { [ "$count" !=3D $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } =
||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; =
then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_fail_nr()
--=20
2.34.1

