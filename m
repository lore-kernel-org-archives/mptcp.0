Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491072
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXuITHNdZ2wu5hnxCr9eDUHnR5m+cdpaMRm8nya8zA8=;
	b=GaB4H8Lex4Qtn1jV7NT9+jGF/3ubKQ+Aspsgzj0vJtmWmt14Lou3N66NFRc8Ra3AMsW/A8
	xvoTPUrP+9RMb7YLuvK4kN199xjFPcu0LaAp1MNhu6t8WRdla6fXw9piP44g5l8M5dB5Iq
	pXJSuaMuoC2ozzxbCu33qPiFmoJavsQ=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-6-lMS9JjenMiadQJclNow6ww-1; Fri, 29 Oct 2021 06:41:28 +0200
X-MC-Unique: lMS9JjenMiadQJclNow6ww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi0eWXy/xRQerHM4oO+56TunThRPfmajs+O4uyaAwig9NnMiEb6olthbT6CQAH6j2oud7GemT2/NRCESNeBG+w/tnziCKB9jZORVncn7lOXTMmVFedcecrqH7H0WIoQ5prrxHn9du48VvQOpjFlzQibngxiftmFbziHBJQ3TnXxvvonjA6IE17L7GWjp9fOQJdhdSQHfl3eUS2NeBQzLizA3szefpsSlDj6ozBAR2Fv4BqlbvHDja43xPY6efruMcw5QeqyDB8/SF0Yy4etsAE7AkA04WKXl0pZ840IAczmGpo/gEi+wRr39GZLcHAa0XV3LZsqTWgtPKRYvS2OZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/3dzJWU9K6mhMU9fPxycNxZeWEAFwpgrKqNHPG9+YY=;
 b=hIY2ErfchwEinsayvI9GhgntjrK0r5RC36cI7oaMGWe5f172HJsQey9ApeMLfJXHdnAzF0RjGtJ8Ft8K2KcZgV1OXYcYQqbW3JOyYxXBiT5OomIGHL2XwgEhh5EvS5BHu8z/RF0kv/N1y3lkctTcu5JyjGmKP/jhofIRonnO20fQSlFI1XLH/0tQE221CcbXdY4FAUSqJ0vxr55Bizf4IuPUSJ+7Y6BTBnBalM6oXhpvS44o0m4/yIyll/9USRjIvAj+yrOSEGuIScsSnDQ5kouePEnW9Ah2WXnIJcgxzoVdq07I/zlWgiCvee0aNR9GHQCj10ffkC2Db0s6FuoTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:41:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:41:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 7/8] selftests: mptcp: add infinite map mibs check
Date: Fri, 29 Oct 2021 12:40:17 +0800
Message-ID: <a46322c9e64a7128817befa494911042127ed392.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1635481641.git.geliang.tang@suse.com>
References: <cover.1635481641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.2 via Frontend Transport; Fri, 29 Oct 2021 04:41:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdebe253-ef5f-41ca-c515-08d99a965ed6
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2652F1DA59E53CCF10C79829F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/XlFtQj/Jdt2Pv3Xf6KQgTLIpkN6GPxmfHSVFgffhi8KgXmoWfXZZOnXyODZclCmmmjC80wtKP7sWWrahuX/zQi+q5lZMnzuBPRiYTshWqYdZKfEdaX+4E49d/VZUjRwn2ukcOa+15zc5WWTPc+C5ylSF1MIrHgXBVo7/NKtsFL4cVNq1ZNbmtCy+o5tWwXV++ogNMQc49sdh7Z7wctAW4cN4D/MwFKc+j4uVpG4w4zmYdVurIACvZG5Vx+S5dFy6PtNRuYbKdvgbg1ZH7UxvAknrcFU6om6c7ilTyJT1nMxIelBBSlJ/nqF4FI/dP3s51TI/HHdV7w3P3hg6N6zvli7EAm4ZEjFdaj3UrhCu2MpkyZ0L8gAuK4L2DNJo0/zAUBUz8GwYX3bQan16DpNS4hno84/WTDkSsLeO8dqR66NwcLgvQrf2fjP91iEcawpzsLQIX4Fghot2pSAj56e1AmfyruLWUsfQW/S6MYOxW6lpqakVy5IqPjvasxLeQolT35/U000FnEly2xVqkLMvm0Wjjb3JsMm2gMDhy2MRhKeMRVqNu3zmBj+RMhkSCukc0OHU3mXiuQVkZ3ukKVP9Qgx9bBGx3/NcVoCi7C3I5wr2Muukl5NxzjCFDiqp6aOCQE2nwBPsu0jr0KWlecb3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(4326008)(66946007)(316002)(6496006)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(107886003)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/HcrHOCZQ3GulgIeQGF+ZgbaZaRjMc1JuTmiCyLthcrlLUGrECqqLBCWk0D?=
 =?us-ascii?Q?FZA2Wqlebgdw7uxndgalaJCC2eJV4l3cXwuiDz7XyUIiRPSW2QlD2o3Ip2Uj?=
 =?us-ascii?Q?MWdnRTJghEo2JBeXnTsn5NwRp/YmhLsOt2Bv/Idx2CTjL0Rs6rNCS7cHg38O?=
 =?us-ascii?Q?ymJC3OB5sCMj/QMskLnomAn2b67aRoRRKAV3az7reXL3Dha5NnuqaAmwN/x3?=
 =?us-ascii?Q?43j1f0algd8E2tRMm2UVVJyuviaXWgFhR3VGaGXd5DgPnzVE89F6RP2qoLnz?=
 =?us-ascii?Q?6Lf3/9mET7MUpxtIcaV5ntKHeTb9/FdPmpN7ysCXd7tIT2eAv0Jo+4K+4Vtf?=
 =?us-ascii?Q?+PCY0FKzyEoDhbsDeC+R0uC92VYU+v0HaaEAwGiNSMv4gu767zmeSdFEZcsD?=
 =?us-ascii?Q?1TjNjY/rQTP63rMgxDDxwztlqh2lNOAjzvkigEJXh6kxolIBHGlHRE3Emako?=
 =?us-ascii?Q?kbNZFs213Fh0a5ViTHuWVwSuDHgylaASKdlQ/JvsVil4FAXd91UEgJ1OqBwS?=
 =?us-ascii?Q?4Fnbk1ueu0RwENkZECy4CZ5MsTu9u8hkPOg8nxfIrdPfn/tLMdIo5dxfEJNU?=
 =?us-ascii?Q?xN+deCuRRSq+WwPHhiCfIbT3oqJDu4SvKziuc2epH3UD6RUq1eRJDWzFqAhE?=
 =?us-ascii?Q?1yy6XiHtYy52Vvrgd8XcMdzgCI0chFJNahJzKfjXkFVeWi8NNsjA9fwxdAi6?=
 =?us-ascii?Q?l8q6Abgy/g1GwlDVWOe6qy4gq1MaLvGLqxodpH8OVit+OOBWQ1nj9aeDujgF?=
 =?us-ascii?Q?xlbooJDypF+tDK6OcgU50wa6BSkBhgsck0AQ3I4WrTmF2k3ec8mgPBvmq9Zw?=
 =?us-ascii?Q?FxTVG/aF++SmeN1XOlFQMyi0hhkv80bdpRiSPl5JFuVYjMVwN0m3SQP5vnDe?=
 =?us-ascii?Q?6/0dFQ+YyXCzHckAWEvEGCAmn0c5fuxlxCzftrNnvmUfZW467pKOhM+TPINu?=
 =?us-ascii?Q?0gJD/MAjT62yylS9zHGdP9Ya837S33oXtVvQJGWq+0Z9+yFmVdJmqF1mfoo8?=
 =?us-ascii?Q?2zOeGxBNCsvLR0skXj9cHd/ULrS3lpHXdTsGLEVVMSE7NP3xhNTtPcfbw0eS?=
 =?us-ascii?Q?AbFnN1PmMYHn6/p4w0B1R9tfCtQAxkqM2tGkswKkYV8UbosjUYz1Zx8DeeWZ?=
 =?us-ascii?Q?cZzUYXLiV2MzZ38WclgtR96Um1a1ecUACfULSBfzL8RH/LG24RXQwh6Rup2e?=
 =?us-ascii?Q?+w2f1UhSk3B2rn5qbB+slJm63agS/3YvWMl8GiOXJfA1Sv23ZLACoaDLAo/o?=
 =?us-ascii?Q?0TR/dl31m9UXm3GzoNMv02XW/AK+GdjStmYDTLD7+tJtXME8p4A/2eqq/awl?=
 =?us-ascii?Q?PhO5DJLig25ZGBQgPRrHF7V0sDrzydiMlcta5UyyCsXKwXfC2QE4mlow7C1C?=
 =?us-ascii?Q?HoVh7YOqa9YHpLallI5ntjHzpUjVK3acLlslxq7RvCbkzYhHRxllik4aMXPt?=
 =?us-ascii?Q?X7CiY6AaPE4LNazT1nGwxrf7k+lPzSgUkDiTSt4RYiSO1wPlY+sVFQo2NE+5?=
 =?us-ascii?Q?G/hkd3PnVG/dKYlV3l1TOmwaSQRi/r1zdSIHO++gFVdQy7eEInuMbWHQuOq/?=
 =?us-ascii?Q?TOx4MDQbcvCoKM09G9o/R7GKfHZ1o1LHX7FcONGXVefwFqwtGjP6a70MO2s3?=
 =?us-ascii?Q?2dcsNdNFxm+qZ+hW4dkjCRw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdebe253-ef5f-41ca-c515-08d99a965ed6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:41:27.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Flx6jbRrxwbMScVFomAsRMmzccEaEQXi3TeEuSevGLnjaS1a0Nyv+tAYjzoVM54MdYbMkacePZxrZpC+IYp9TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

This patch added a function chk_infi_nr() to check the mibs for the
infinite mapping.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7ef639a9d4a6..2684ef9c0d42 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -615,6 +615,43 @@ chk_fail_nr()
 	fi
 }
=20
+chk_infi_nr()
+{
+	local mp_infi_nr_tx=3D$1
+	local mp_infi_nr_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "itx"
+	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - irx   "
+	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" =3D 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
@@ -665,6 +702,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_infi_nr 0 0
 	fi
 }
=20
--=20
2.26.2

