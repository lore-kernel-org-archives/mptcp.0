Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C363180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOtYqMYN1U/8sR6VDIy59ocEvLvBYao90BtfC/kW4WY=;
	b=C50E3S9QQRsL2YtEmva0wMxzrwtJPBsCGTvbm1VbfwZjxmvceZSCNXpbStdm2yDlqmOTUI
	4RW8N0sToyVsCPlLOszRaXw1uwd3yhqwGsNKFNVZ8Weqx0o7pdpWZ/DL41Q2VNA2ML1A4e
	GGKPPC/A5UVVg1lCiAtsFfP6uy8P8Nw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-yX-9H9WXNm2Ua6i_b2x8lQ-1; Sun, 20 Feb 2022 03:59:21 +0100
X-MC-Unique: yX-9H9WXNm2Ua6i_b2x8lQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLB7hMpPfkETJGuVj2iqfHxQM+09bu67XJ0bUCZqmQT1LHKCQS9K98yAw0HnI1VKyz936pjJPy8Z/f1MTnU0cx0cFWFyE5OEoCOiYttHOeodjNzZPS3zJkEKhZT/QoV4Er4WBlyM4uaEcqoysIDi7Qt98kY+Gk/sxFzfqyCPlRbbFhrN8cjijdFLUWPjGlM2O1W1eAzrWOyIdO3YO14Uwql7ke52AlNPUpFXsi5HaNEt/H+gjDF4q490ToiCoe44x9fWiVgaLOS1VQ5cRCpRGRft0AYDJjnRb0dMwsyon82pPMcc9x40UCGCYAe1QK41qX1WpJj/23u8Qnq/5PnAMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl4bqr+Nt+7QbpHlOryjXKJ1w3owT5gfGTQ+leE1HiY=;
 b=GwlZKFMCgb3Wc4b7Yfdi7Zu/oWwFwJ2CEfHDRB/B/kQweFFxZN6+6X7VNEq7y8oLlggYySntyhz7cwUR+hGcAfo+4zaBnnDpodJzVXR6xphB0G7DiOPML/2aXSl/WFg4KoUqjBick/gZULKkoSpFgnJNMfpW3o9HZ/UzLTSGr/sfPAXtIVZeVOQE2OvfZEoGM5q/9bVKeeugsgoO8DIiTblTkcuyQxdwJ76gjwi/EUIBm1ALS02gaAxzEXbXw3L5Jy6rgsaNrWbFLtY0ibmzFrgM+nRZbCwXjyVgvch9+rKBpguiMNCxziRLLOWCBW9ThVBB2YySwT37ewy+8ymdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 02/12] selftests: mptcp: add the MP_FASTCLOSE mibs check
Date: Sun, 20 Feb 2022 10:59:28 +0800
Message-ID: <3983f4bffdf46f58bf0dab252c62a654354da94e.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b50ba612-22ec-4507-83b5-08d9f41cfdd7
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414F36EB1589A597D85F717F8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oyMvtMdIZAWJ3BZfDzTBvw6r+qBorhui+GTMhVvGSrKlk7wjxFdyE79ZGHQPRMNrhpkyjlHiOEggiCj01yGTEEUwejrGMbg3/32FC8+zkXiGGpu5g+4g1SZ/FYyZpjq1tZyw0a3o8z32+tPmmWYX2iCYCX09hZ30c9QqsinibWQv32PCo8UbXCePhARVbGBvyBb+lA3P39DyH2WcbIY36ovnQKQ45idbr7hGq17vUe1EbFtAAL33Liavsc6LznaikzRaA5VYgFbVzxwtSPK0XT+f8dzMrybAKz059L4cM7AHhBOeNRUE/Q9xmDykRDuUQW5s1PyM+ggHC+hIKCQmnnaxVzwwVcxqLWgN1E1sGF237sesPRe1744JEC5uXA6B62S5IS96rcQf9kz6mdyej9K8ZCtmF/ROI5E/u3MnBIKk8filaLsnTgB8uyMNAOWMDC1FymdsVeYKGRRsjo99WwA/uKag8ohfFEFIwUxQbY4tVaKXM19G22SxND0nyh5kz3+rvYbo5jDPqlIcdBh2yFTiqmfMBf4ME5JnvKFUDeRKg7h9380IBqPL+OEMzAy9UAixmqy5x2+W2J+8EDZODtIXgoHY44oogYJPUBc2NYrYvhyvf7s1Tse9Vdu44mC2Y5x2+1bqzspQHHzqdZQ5lA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y4TGsRuZyP1riAhxdMaVuxLYvbVJl2RvnPyvp5/t0TNwM2qYAO1L8ERG7F5o?=
 =?us-ascii?Q?M6+DQgxLtCrSv71NbYkt1lHl/wRCuCH8FdsdMPgUyCBxEIHHx4IHAJCG4Ilx?=
 =?us-ascii?Q?qqSdFQ09khwFS7UFmn/zM3EGQEKryhqOg+8Nj/kj5j7LZd0pHvTHntxCr3m+?=
 =?us-ascii?Q?p3Fu+t9/W8zMNgF5q+V3DvLtBrxOzbFMfUjyAFRite/PoTkN4B7hK66LbyV2?=
 =?us-ascii?Q?s1FwK5tSVuFFma6K80DRv4uiGjadNX8aUUJV2u8ptP+KdT00fpJ5wssEtpyL?=
 =?us-ascii?Q?IMOVLyCKdPyOWpj33Fx9lx7+M7euxoMqlwwPcFrRkXMPA7ZW7od0hJV3IcsV?=
 =?us-ascii?Q?bBpcWHigTg9CKD8Ss+JfsZa1DKiHzEpy2ku4JPsvSixUpMfAtB6AvJ8WPp79?=
 =?us-ascii?Q?O7t0G7h+NT7iHk6hxdqfhvPg/2J7MO5o3wAuJyHBUGRzoALpT5T4gswEVLzJ?=
 =?us-ascii?Q?biCPvY9wfBMamda/BJ/JTBkoqXw7jkWmgB2NRMp3udDY1cQtrQKxYWi4zqtn?=
 =?us-ascii?Q?INnLlEVYZc1y3dbyClbnY2Jt8BtkzMwcG5MOooetOhQUZHoGu3o7vdUz+maL?=
 =?us-ascii?Q?cZ3rV6AEqsWZdKXiF1p0zpZ0YHISdTM8NQx6pcB8mVhuD7aItgCuXPZwXgXf?=
 =?us-ascii?Q?NUtclebQWmBsZSfpGdi231/Wn6X1TyChkkBfEcuXBG5CJ+uihIr3yKWd21U4?=
 =?us-ascii?Q?HYcrfXWZ0tI8g/Uh/gmsBtGYIQ/jqiwoDJO8HKXRuLpjRmIg9rxi2a9twQ9/?=
 =?us-ascii?Q?Ci+yHDsNkReRaljgGUDvd3j59+Ealk0GbXb+Xdj9ZPKw6HF9dt+/5rCeQS7r?=
 =?us-ascii?Q?bSAqeGQ8KHWURgsY1ulcKBjhoxjvAJL/HqI0mCzmr3GId239rnwyJc5bIQBX?=
 =?us-ascii?Q?BJMxD1fHaBCGBqI7v6jHKASXR3NrnZTdAHnzwECBrLNL0o8jW6H12y10UeIe?=
 =?us-ascii?Q?wZerE3t/PSWNRoi7CCVGmWkSFOv/N2Nou0bGzCF2SaGpuHGF/60Q/aRVi9jI?=
 =?us-ascii?Q?TACfx7fnU7ipUq/1IsO2ib4XZd+w8AoSUMyT0SXUaGqecGEDBPbGFTwSHeQD?=
 =?us-ascii?Q?xwchc7Ep1+Q1jdjKLI6aKsObVKc02l1kJOZzer4qHJ/hNrTx1CzMFfD6zQ3O?=
 =?us-ascii?Q?lp0YnPyKiUTA6y59DfXPR9Q7u1mCp4dUXZtfLERBkGXX++o6TNZZvU6yEQIa?=
 =?us-ascii?Q?bdcWJ4ACpOM31i3TRSISuAUOB8uOXhsjVtJ/Rr7mFvi4ztmPRu9v1AEBcFl+?=
 =?us-ascii?Q?nHyAwts7E3+1F0KPHWKwSjbxOQth+SGEwhLl9hd7XH4RVsq3kfGglizj8U38?=
 =?us-ascii?Q?+yi82Ltc0iyqEdJ4UNUBWiD+z15NU6skvuAVyKlS7oItBQpASLLfjNUUDgE8?=
 =?us-ascii?Q?htNq1G2DLsUaEvruzhGp5jiCa6+jWipPnErkaWAAYb9aXM/X3uSjbqqkDPoM?=
 =?us-ascii?Q?EnTPgu8wLC1kEGPwOyDKKXfnlt5JNJZyhMrOg5Rgo1FbQJW8o2DxJsWVBy0a?=
 =?us-ascii?Q?iAYcOdjiLvE8kwO5qSPnfdyqYbgqpogwmkQIuPnk+pgO4ISBZzdbGLO3o1qC?=
 =?us-ascii?Q?Yl7cSLm2xbBpSIO2DJ5nkcs+av0Pl7dKMvi7HidcrtvdyHKWcx6LhiAGKBLF?=
 =?us-ascii?Q?x9iHQxmuheK1ZIu+Whm1s2OutghxHsDPY9AAShO8GJVnI0qu37plf1hqOQJ/?=
 =?us-ascii?Q?kiJHAlvrxrbycrQIwVwMKK18t5U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50ba612-22ec-4507-83b5-08d9f41cfdd7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:20.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKgm3a/rw1bL44EB5cqfzVPSn1yOsGnQ6qOBeCbZlrTU2HsSpn3VFdjlDt32AI9tQPcPgDGps7eVpaLA46QXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch added a new function chk_fclose_nr() to check the numbers
of the MP_FASTCLOSE sending and receiving mibs.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8e6a5292175a..8f81ec0b7552 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -904,6 +904,38 @@ chk_infi_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_fclose_nr()
+{
+	local fclose_tx=3D$1
+	local fclose_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "ctx"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_tx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - fclzrx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFastcloseRx | awk =
'{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$fclose_rx" ]; then
+		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
--=20
2.34.1

