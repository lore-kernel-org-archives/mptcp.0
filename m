Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802E47C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azj42IoOKBFEy3xW37JMLTZP21WPjIa+ruCGNAXtCIY=;
	b=C933vIJncVvRWScnmQaix0FhFvBIV6qbkeMZzABaQsxjlxAgGdkUEAsNwwDsMoAz87j3QR
	ZEHgCjeFIiyhsa1q/suM9THdX31Q95ytktRZFqLcGKgpz5zgzPONzjDHj2CVm+o4jCmnoU
	ojEOZL65LYoFp32zWi1b5Pi0mAHIIUQ=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-v61aGB4oMvqfjNg4q8zG3w-1; Wed, 16 Feb 2022 12:05:38 +0100
X-MC-Unique: v61aGB4oMvqfjNg4q8zG3w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJE40Uq2l+ZmvaOh4z0K4Gor/2WLj3JAW7YzlQ9AF5nmCyNSDFVA/juuBaDnzC0pJn+hkb20RhS1J0bSLtJOm63VPH57tLPzqmYKy+HBDsXU8xs+803etiViTPTmnIM5pMWcVglEFv0geOf4uPhtlBOIgNXpbqEJi601ou/t17Fred67Psh9iF1Qv6PBUgmjSMsJ0lcFO7121/lvR30cxuN29RAEL5/7qLOw0A/D+e5fzcDTabcXJykCd8xhgR9JPXIPzGPYVyMNBGccAZq77UURorSW6OxrTm4zRYBidv7N/p2qmc/GVWILeWn6T6WUpAH4OmYxOfoI7Df0DWUK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyMgsui9auyyRCrRlmmBIXE8LftfDS+cmgpTqzzV4O4=;
 b=UQUO5Z0GtqhZiWMFukKU7Ai+PY0XEHsaxGmDaPKsRCMBE8fu+ReCfJqfXhNfuIrRoLenAtepJZkg04Ru9d9OuqDndQP1xaS1QljzOfJ36DFuRmJOZ5OIRqfT91Y0eRadkQDZc0KsNcSxLkqnCkO9PyJD+MiYPsrmKqhQQrZG5iakSRm3QaUwtmWO+yad3XSObZZJC2rTwE7mOBqkplUIp+YyT1amXD8tSydEFjrMiPfe1eRtLXXw+D7EB2gSpcCg2fRnX9pKl0mNOoj5h3q1+6hYuEq2M6MDwG/fSAfr2e0Lswb4NvADIzZmLYndqixFls9qp6oQGxO9Zt+E0wVftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5799.eurprd04.prod.outlook.com (2603:10a6:20b:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:05:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:05:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 6/6] selftests: mptcp: MP_FAIL timeout testcases TODO
Date: Wed, 16 Feb 2022 19:05:13 +0800
Message-ID: <38b55fd2b80168cacf38c23a699ea8af356d5f80.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97202666-08ce-48a4-0bc4-08d9f13c42d4
X-MS-TrafficTypeDiagnostic: AM6PR04MB5799:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB57994551D4C30A91085D0E10F8359@AM6PR04MB5799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FV4aisULFqzPxRNTLg5tZZXoJBxmihXoYrT8FoWQlZgD4VpaGwY+Pn2a+RYxj3npx6AAoREisjo+lovqZDbgf9Ak92A/9m9wh0hb5szQOEEiU3Teq4sW0tcHo3NvLFhD/G0/5gRB/D9R4MLmAGnmi8osc+i2GjOM+3iSvc74gpO6pAc9WZDA39cKapBZkbWyTAle5Mf1FcigwHn9arNHHSnUrDCX1BcpSG8jJOXqPiEVUxFVn2YfEG6LbV53z0KYKuLqic0zUWF3RJDXpPgpGDB0tND4GzOlas3DMkCYFM9WN5GcLt8GujengFx7KbeusdogX1boE7MpXwQqvpKHzOa6RQHA08Mrwg569LvRDihGRrBhJRV3PPAvqX1dXm+P3JURzqwa0HYdYbPa3HgdpU79hO/JX/GHe/nGVJdRW+uR7jUpO3K3alkB+xOUPl8JLUn0ou34j6FrsrWMytHbAbvhScZmc1/4X/0F9sbX/jyOXiEvdg1Bn7l8LaSHmHLIq+IXWKkd0eJbzbjCWtodUFEWMqK4LeH+8g1F3iPpXHWrbeNBRpx8u1eIAdIoL4zMshZWNdxxyiS0phgP0kH7aaNdp5WYLhz46mfuMQjcQdYe7g9OFJjv7a67FdxG0EMLb8R5EdIEpD5zl73JeDJ8HA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(36756003)(107886003)(86362001)(66946007)(66476007)(55236004)(44832011)(26005)(186003)(83380400001)(8936002)(2616005)(6486002)(316002)(38100700002)(6916009)(4326008)(8676002)(6666004)(6512007)(6506007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eB9GFaz8gV1qteGdi3EkHgvNYU8kJJebKxWv0Slu8X/Pjw1SUZ9schCcvsyQ?=
 =?us-ascii?Q?/64WWDSc6o8VuIftgRd+658G0CaRE9ApXGFJ3XG2OdNni41KC8FmzP2f9oNq?=
 =?us-ascii?Q?xevSLETg1dKVifHuCHrI89jc6Dtl8fJTyXzaP109w4Lw3hr775O+fuIQCABS?=
 =?us-ascii?Q?V2AagwRcfigtSEyyugXtUFEbBpSK/fraCI9I2+5yjtZCIO4SKuHKp7ZOvZSH?=
 =?us-ascii?Q?Ys8wuNarZGdasglO9d/6Tub7EzIB12hYT1oiWOzt3auT4Nx2dbDq4gih2rWX?=
 =?us-ascii?Q?UQxGynoVa6QiexSbNB4g5DrlnHLtk4JBUjrdGXrT81wW/0tuAmQgGQ9tFDAt?=
 =?us-ascii?Q?qrr3+gBasuP6UUx9l7FtpfCmv3/7P47qhdsrAUvacb+eYebPDqpzTO7yT7oM?=
 =?us-ascii?Q?+Zo8/5BSINLrNOsHmQrIb6D3jRmDU8chwYxyKvPecBTNnDhrQSQ8Uv867UWr?=
 =?us-ascii?Q?RXSyCMCCJuCSe1blsM9eHQMiC8EoZzjKWx/cq6AbklTfnE2sFQA/yIE0Fp6b?=
 =?us-ascii?Q?ic1jtKAgTiVYQJPC2qCdQcyNUWbaHYhwam0ZZUBWc4+K2h1iXc9LsFpxgRFy?=
 =?us-ascii?Q?GAqJ/yewkYgHmdgqnTk8Klk5Xk2+7XWhvA3DmDGvZgCR/DauKx+fDucaZrhW?=
 =?us-ascii?Q?QAqIgUe85JKPIbWsMw3/6vLcTOp9JpXEKeZ4Zr8efFW6lEakM4W52PYmlXl9?=
 =?us-ascii?Q?a7JA65r+kaDTSsmCaGRM1Zlg+7JzG19uxDMCViM9ZPsl/s9yJq3kESD+zeu2?=
 =?us-ascii?Q?UvcU6AfawhA5/ukC7TFtOGff3Ri+IrnCyK2ssxaWnK9upwEDnolNVz1k6QoB?=
 =?us-ascii?Q?MVNbXRopGdIWeoN7TKadX9+WxF3w586f8KHlcyIUio54eMmDvYzt8nD888uC?=
 =?us-ascii?Q?M3FBkbeD5gtu3dHoQW6KTjhk5kQjc717UWPHybziBg6cjlzKCByYZM4JJ6Di?=
 =?us-ascii?Q?b7FnNSm6R9yAPylEAWmAnKj5wUcYy0uLQ78k7nW/nvvbMDWXpi6I20Q4HRqd?=
 =?us-ascii?Q?iLJ+IUFVBNd9Zu+BASKX2PvxUG+CZEPBqyObxd3FGn2WwNV7pJWdos1W3ioP?=
 =?us-ascii?Q?J2g+kdLhJv4wWiFEvy06gxWXGf8cjXfuqjHubiSnKCAv9RKg3MTS2x29udIE?=
 =?us-ascii?Q?Ih2oUdzMAw4VLo4uGxtvJ3UH+1x75v06ZTfNd2DGRRWbndZwdTYTySfdxgYV?=
 =?us-ascii?Q?b3NhQlb0/eHFADTDUGB8VhWJ+BT3NrxGMfv4KyO7ZgwP6R6ZFXr39RzDru9f?=
 =?us-ascii?Q?njkFGoxTB6bihyOxg8iKKp9bF3iqd4tXOVyQOqtpveXI7b1p4UfHyscwJHXO?=
 =?us-ascii?Q?jfTO3qRMXKI3RvP8Y2XYCvoez1hpYrUIh4a7zPmBn8bhTnaMxeOG5w3e3VIa?=
 =?us-ascii?Q?971AeNkbEMT3HWqzAQRiTU2l020GiCDlPQAz++cp1e3eL13q+2eueJPaPdzn?=
 =?us-ascii?Q?BYBehtRs0uzBYjcir0/b3DIYdhbPLm5W6kM1a1rePhOgY8jXzS0yuCzSg9/q?=
 =?us-ascii?Q?7xS5u1XX7MPYtwHh34CnAbuLNT89CbxBH9330jeDkg4dLtkYqJU+XxlQBByl?=
 =?us-ascii?Q?zel7fBEH/TfbsR0LF9UBbLmhpKhUJpUmyXiqUAVxnsMOW7GlJPJ+tf1ErfDe?=
 =?us-ascii?Q?ObilKYeQMRj5iu6MVLXIJ/0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97202666-08ce-48a4-0bc4-08d9f13c42d4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:05:37.2566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEcsqVhCv/Dix9lEg/fgd62ql0Ivg84+NCI8ZbjnL6d9jwkIYthqevJSrnBHQGPc20fCRpXn+cmUtJdtr5XWyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5799

This patch added the MP_FAIL timeout testcases.
Dosen't work yet.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 01b9cc190134..abb8bc3468ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -41,6 +41,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"14,
 			       6 0 0 65535,
 			       6 0 0 0"
=20
+# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x60) ||
+#				  (ip6 && (ip6[74] & 0xf0) =3D=3D 0x60)'"
+CBPF_MPTCP_SUBOPTION_MP_FAIL=3D"14,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 3 64,
+			      48 0 0 54,
+			      84 0 0 240,
+			      21 6 7 96,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 4 96,
+			      48 0 0 74,
+			      84 0 0 240,
+			      21 0 1 96,
+			      6 0 0 65535,
+			      6 0 0 0"
+
 init_partial()
 {
 	capout=3D$(mktemp)
@@ -261,6 +279,27 @@ reset_with_fail()
 		index 100 || exit 1
 }
=20
+reset_with_fail_timeout()
+{
+	local i=3D"$1"
+	local ip=3D"${2:-4}"
+	local tables
+
+	tables=3D"iptables"
+	if [ $ip -eq 6 ]; then
+		tables=3D"ip6tables"
+	fi
+
+	reset_with_fail $i $ip
+
+	ip netns exec $ns1 sysctl -q net.mptcp.mp_fail_timeout=3D1
+	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+		-m tcp --tcp-option 30 \
+		-m bpf --bytecode \
+		"$CBPF_MPTCP_SUBOPTION_MP_FAIL" \
+		-j DROP
+}
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -2455,6 +2494,27 @@ fail_tests()
 									1 \
 									0 \
 									1
+
+	# single subflow
+	reset_with_fail_timeout 1
+	run_tests $ns1 $ns2 10.0.1.1 128
+	chk_join_nr "MP_FAIL timeout 1: $(pedit_action_pkts) corrupted pkts" 0 0 =
0 \
+									     +1 +0 \
+									     1 \
+									     0 \
+									     1
+
+	# timeout test
+	reset_with_fail_timeout 2
+	tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+	pm_nl_set_limits $ns1 0 1
+	pm_nl_set_limits $ns2 0 1
+	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 1024
+	chk_join_nr "MP_FAIL timeout 2: $(pedit_action_pkts) corrupted pkts" 1 1 =
1 \
+									     +1 +0 \
+									     1 \
+									     1
 }
=20
 all_tests()
--=20
2.34.1

