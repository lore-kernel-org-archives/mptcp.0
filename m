Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA62180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645325982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nBdKGG/qVGwELWxhk58GfmKXQLzua3y0N/+hQKWfa8A=;
	b=G0KfkDSfVXAYxjATTVRNJzAF0wHhSn5MIMIYPJFBvLUvBAG1LAXkDIrvtKeKzEFcxCQ4nG
	RFTd+0CuxIweDVngWbIzeISam+iTfu5HBj5Q010AG4Ww6uKhb+B1LK6PSmQPHOo927/kNz
	Vtv+6Ls+LR97AX21aF45bW7VoGTbK4o=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2054.outbound.protection.outlook.com [104.47.5.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-CCrz5tu0OseBmBgIuRub_Q-1; Sun, 20 Feb 2022 03:59:41 +0100
X-MC-Unique: CCrz5tu0OseBmBgIuRub_Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYrTzACKT9LANlKiRl+WLRjbNOT5Wg28m4wPgl+VwrwFGwFUiL42AAcfA4Is5rU2EHC842jxGAFFlTiQxdwfX8p9Mc4auWyoTN1gzavEOgIqaTMwC6RF+mXXGxTKwQMosfJYVtPFzdJNya2yyZUUp0wqenk0jt9c7iqETcKo85405p+unxMGLn88MweE9msuuJkX4DQUI22gUn92OAXt6oVsR/C0nL4JarsgB4qhft4s/uDUv/8aftXhU8tMHwJcBZDZBm8bbkqbtuc4H0wn2iNhu+IYVPy53ZzwhpaTaulG9cqUljNVc32YlUgh7xOzWNGdpsATeyUYn/0bPlBXVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrYRbEYi7ykkLsTLm6JMD6XtCt6hQ/6vQrRtWn7cosY=;
 b=VdILw8aZk2NvtkXU+Q0RdFal2XqLxEGR4JUCvFQFODnZfuYsfxGAMyM32hd9UcrC8nK9PUVgI33xi4JhREfKIaLjkiPm6DxP6krZhlTQmFgTmytQ81d7ATCDFtVFyOoEMcWxl7GDyaR/tqB1jEVCSB0Y4BzQ3pCyVHd4dZCPHDZ+jSmQXBaX0UiswRgzdZRp+9YQvowBgIclS8Odw1E+QUK98aQc+nxCsfNJjje0EhDWSpngxhwX/U2glK5Si4U4oxm+lCHA9L4n2wrarFaU0EWtFEbx/MDO8kEmRTOSo1XJS7yoMaqRTikejmY7l8W8PMekrjADs+J8vJQyWLV1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 02:59:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 02:59:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 04/12] selftests: mptcp: add the MP_RST mibs check
Date: Sun, 20 Feb 2022 10:59:30 +0800
Message-ID: <9ef3ef866cc8a67ff0dc174f762f103c132aab1f.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f62bb9e-5c36-49e9-465e-08d9f41d0961
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3414F7C07BFB633CBB8BF1ACF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QOyMEwjgclmjEiLzVvik4r++/onjWCuAHZpJP7whu0xw3NCMHhOiJX/o62oPAzZeMZVyFeG3RU0VE3bguzUKiIYmHED8+tA5TmzwpmxG22cz9oJf8aY/8mz2bNA8krJGLNmOCQiWKeSZc3nE5YZRXx7Dpwdh9+EP8F6nuO0SIZvxBbToiP+IHZLz3cRrsi8O2ZpSkPPk3egFQ9J6DPFIdLBMiJIuK4nJR/WVWVKrl6jdpW34odqqaBtwyyOwCKSWds3a6rqTd2UHZACmHnAp+n3VyI9ToH1xMmrb3SkjZ6CXMULhhtBRH+lUyq8UU7jZ8gZDHc0W6JgBrc0P1T6f+VB/yVghDrmcDBg6xXK6Cjcb37KX//AhRHB347cg4FPDj69Jz4A13Dlkgy4SZFcIOJMxRuVTsdgw1YoNvxdIHhPW30jsREPGqB8H4bBVLvR0S0JmtoMud5Gxptv2LVkAf/sXHv6dDGzRKr3vjj52W6eFgNWxIc811zw9odQOc8DC/zOltuTlRyZel8BKryt8wSDogDJf8NCpgYndZMUTmclh9pqItRpmgsnusvDNSFWJePnjkLW3hNimIJKeiVnwLc1K7TZwY6fFQ2vvK+3kYqSAT0FQElxcg6Y43jgq3T/FpslnXnL0y1Z1xwySB0JtBQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzXOmPEq0E57Ul4XHFpBq686yCQU7eLOtSJcbahcTsN5wI6WmFEtmtErdVbO?=
 =?us-ascii?Q?WC7HTVs6R9O4YqjTzYKKwLj5H4KBBeeosEPEeYrZo8YIRm0Jkc0LhS+KqKdz?=
 =?us-ascii?Q?ZPPCF4AMxRZR+62AGHep+08SVoqWKhaDzvkz8pSopAyleV1Ws7nDCUqeICgg?=
 =?us-ascii?Q?BN1FyGQCaQpXxo4uZqx85VdFHYnnR4z0y8mSCGCLjleezQRdfnDCwR+pVoVe?=
 =?us-ascii?Q?2gHh9nf7dtn2QOq9CQNQXXSByp4kRVfUjzUeCcdkn9DKSp3FsZEchgLHOfpP?=
 =?us-ascii?Q?KrmZxQ7/sybokDGABDnPYhyrIRdh0c9Wkqxbwc4DdNnoCP3SLMgaWsuR6jSS?=
 =?us-ascii?Q?QRe3xlmq+YeodYOd7qjYFmyBYZol4akP30GmusfamHd2B5kk2dn3p1HR3r5O?=
 =?us-ascii?Q?n3HOm7dx07uc1ODoC6NaSJ10Yz3zwCXNyAtbzGMOHBERCzkGcOhxg8Hgo/iZ?=
 =?us-ascii?Q?ugeACR7qT38vmyS3KLv5cjz9CbUiybsih/W3kJ44deu5rIE5M1ZeYBRICKz2?=
 =?us-ascii?Q?B4VT181FbVFU9j5c49Ilo+w/vesm36yxLGNvT0QwbLHWMQV5+2+HFiyvkN31?=
 =?us-ascii?Q?vB+JMysV/lMT/rKMeYIgrUe2PFt+OajSqfWK+jIELp4ICD4FMT2AzhaGfuJB?=
 =?us-ascii?Q?ktcPDMi5ZnOkDxfgvOwbyYxjEl+fhf0c3Qf3PC6j06NR8n7A60ihjP/xUYzd?=
 =?us-ascii?Q?uMWw4047flWZd95qiaBgx49gMglbhuB3x+5uGDMrJ2EqA+Gmcgs5Cm1mfQvS?=
 =?us-ascii?Q?vznsStEvP3XkcBrpVAJSqIzgnMluRp2rh5mgdT5cCsmsaK6Cj92CD4G+U7Xb?=
 =?us-ascii?Q?7uOn05VBzyZculOgwXzlYs5V3CZZX/PChx018rTpO07V050WwsN6Y8Hh+uGc?=
 =?us-ascii?Q?zcS0JGmglV3Ugwqn/fA46TWMllPO+FyKk4qhgi0fZqGtGaVFERZuowNQPrud?=
 =?us-ascii?Q?CWlVebGQZGhlWEGDjWHnuC6fGyu5CM+Z820u4NWNlV6HIfNApPFAifMkxiju?=
 =?us-ascii?Q?HMBCwXvqv03wPbHqOsDyfh4xjJijXDetir7kV6kErNtuB+AgAUe2IWWbeRYL?=
 =?us-ascii?Q?jBhiMRpme3KaWCQx0wFaXxlHsvNUpJOLP37qXrzxEOuwy/iWUg8rZs3S27Ap?=
 =?us-ascii?Q?aH0d0KnkT8O3Qf1hJJ1TzllpCBBz3qTiAI9+gTXkWVgIlwUV5YnI1pGyxoPB?=
 =?us-ascii?Q?+X56GEfLC/Xmp1caBJi1y1QzP0P8MRjNggGsgAX16ctaMbqmyxALOSQoT7tW?=
 =?us-ascii?Q?ahdieOOhXfUfz/Ojri+o7+u9HxNPqve52C0Yi7V/Ld/7WnqTaB6T7Vd4Xc58?=
 =?us-ascii?Q?sZBsFk2bRdYSG5oAT9t/gWZH/Bdb5Sf7uwCPI6Sqi3KjefZae7BWIagAzVRI?=
 =?us-ascii?Q?JV+ldnIFVlweswk0UUg8ZXq9Kh1SBaIPXdud/6JnUTPu6M8hALD6FiSz++rs?=
 =?us-ascii?Q?WmKO76nmF8oVZge71t3MqVd6TTKGPW5L0PJv+wpWbaZ3Lo9/iVjm9xg53TTt?=
 =?us-ascii?Q?6rxSDQvo34kPRn2TqRLV4CxgHUOn9MJcFf/FuUduE2q5wIZR6haywXubHL7i?=
 =?us-ascii?Q?odgYbFVbO2gFfpL2acyKW9nOYGywg1eNVcyTZ3MZ/dDL7TKiJT3VUOCMO7aq?=
 =?us-ascii?Q?nkdAaww1bLf3S4gwSEIGDszk934BcaL6Jk4YEfDMBp0vWxjMrtPAIxNSpTV8?=
 =?us-ascii?Q?enyxMWso25ROK9Xyt4hBoMTKUAo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62bb9e-5c36-49e9-465e-08d9f41d0961
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 02:59:40.1828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbs2uKajfQaDpUunGTTeTFqcwXS8R03edV4s64uSuAYmeIMLpqOuFdRNpzC4Pn4nxdg64eVFB1ak3goTgBC4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Showed in the output whether the inverted namespaces check order is used.
Since if we pass -Cz to mptcp_join.sh, the MP_RST information is showed
twice.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8f81ec0b7552..ed4b35652ab5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -872,6 +872,50 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local ns_invert=3D${3:-""}
+	local count
+	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
+
+	if [[ $ns_invert =3D "invert" ]]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+		extra_msg=3D"   invert"
+	fi
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=3D`ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
+}
+
 chk_infi_nr()
 {
 	local mp_infi_nr_tx=3D$1
@@ -990,6 +1034,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

