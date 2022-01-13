Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD82C80
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642086561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lHGgMQ9SPUrupz+obZGy1NDzEASvprhL7FIQCHrS/yk=;
	b=e5+hSdknK0jss+YupyBczCX8+NqOzZQ7M2RCLA0C3Y8ipcaCbM33fPWL7iD/Cnta69NYAk
	gwCrNGtnKSeejilvIb7Z4FmLDkshFa0GcUtfLwACEPUxeFMLQihm8g8tVUobReHRa5BzN8
	qZN8YgXylz1c2+oDJsivEIKtk4bPRCc=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-yxXbGt7ROs2S3XEiuQzB-A-1; Thu, 13 Jan 2022 16:09:20 +0100
X-MC-Unique: yxXbGt7ROs2S3XEiuQzB-A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWmIZ35X7U3eApGb6r+htUk7oM7KsZafJtbYFCyqf+EPe8PCe/hXQBrPDJmKTrurWIJWEpsNuE8K/P274lo9IJLbB2oTBsw+sm2gsOKtWg0f4C+UY0s4xw/czenK7Llg2JV2IDMcSNKRQw+vVtIfFhRGwtrPc9nMH5hqQf74GbNoYHwhe6o6m3dvdUCmk1I+Vf+VL8clqa21ZWrtFQQiA8nvQw+loXYkfaLk5EvC4kiETD3B5y1xh0E67tY6wS1zTfnat6EsWHBzz2NrsSyskGbOjkD5+0/Gpw8pSya4umM+GKuspj5rId8lW8rTiAfIfCNIfqq5BgS4Rjcn+HBqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FwwkOeZ4nXyhXMsfEN9LqLysOafh5F9iSxz7KyT/Ls=;
 b=IlOCDvbp5rLxSHNVqEJa6qcLtVnUTRXXT38DmoMW12NuLrwKkSW7zYNVXIPNt8IOokFDiXT+hNIB5lc/x7D8vvk7p+hIUpasE3g6eOzguahbngXzDhzXOJoTGQfLlJHgnD2kp/kJ1PLcQRnywJt/GWOVARh3WhNVospGAwKa51K9SwspRE0RKddiDLehk5Dsy8vRiEQnGOofoH0QJkfEz+DLkhyabBXInSeIKmBzz5xmn020jcr4W6ahrHIGUjeUHP3LWP10NxJcufurLW1MSUl70uYoMRxc4cy6l38EJahKeKOP4eWFOPvUrm1Rsk1iySUVPRGEaol9ZTZ/hRBr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2489.eurprd04.prod.outlook.com (2603:10a6:3:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 13 Jan
 2022 15:09:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 15:09:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: add backup with port testcase
Date: Thu, 13 Jan 2022 23:08:33 +0800
Message-ID: <7472cf13c155c5d37e6faba42d00dfa8ea4fe08b.1642085750.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642085750.git.geliang.tang@suse.com>
References: <cover.1642085750.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c450dd5a-4588-48df-e61b-08d9d6a6ac7b
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2489:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB24891C237345A2F72AD603FCF8539@HE1PR0401MB2489.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mmv1p7mWs4nOtGSEk0+XJADp9B42BOokgwphje2AQdWfzRASX++krUqKXGQWBQCocqPtSD+hIHjes8X2bFKSFnorbfsuDCO1Lo+BYoS5g6E4Zvv0m81gxZYeSKPwIHeDXwphnyuxBYoQfv08j1XmiR7qf1jN7JK7U7ZRxqwFSTDTJxDEs4DTDcaX0yEd9TEKk21m0CPvxPbw5xneNVpf1/VA/BbMHsQ44DwfxxUJzcHwh/5rO7bF+fZwxLCzjTpT6eGqNK0ZToaQkvameR2pRttEE+XDSGZcu6Yg9y9SJXtlqaL7UEpjTpVsCX15cOr3FKHlmc6jfpZxE7wWZRP1swN9R73GF85t78rlwESlCVQmP8ReIS5wO6mDo/jK5k4FNrAuuCW3eF2kfqJ6s/LsMrasvkFQ9gaiO/gxBpQr62T8MsG63N0rSCl/2p8yXmZW8MovRfn/pFqvHsR/YfhPDFT+40gpZeZxlgEcJ6WpPdXrxAUnZfXiGYQI+DHp1xEKXdtY3emiE8NUOIKoJZZIUrO4HEWrHE24L9xp7ab7MVuhoNXhVevjOXYk897osn+2ar/fL1qT43xwfkv62sF7l9z7F0h7F041xysnym+GzvXMqGYUpFMxKoXvHNy57vFWQPU+iaFq5MmNzvf85uRbxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8936002)(2906002)(6666004)(2616005)(86362001)(44832011)(186003)(4326008)(36756003)(66946007)(316002)(83380400001)(6916009)(66556008)(508600001)(5660300002)(8676002)(107886003)(6512007)(38100700002)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xwgCyMIqOPnD2/r+oFXrwRBgD7CC0PjcejcfCGcXprfb8/KpIp+dTGiBKIma?=
 =?us-ascii?Q?bMGVVyOO7+wnL2bJBebmGbkXtT0Uo1DcN9mHMWSWp91j2IyuRS9Bmzz72ygg?=
 =?us-ascii?Q?Jd0cRQGd4WcrjcE/AvH5i4H8Vv24ngl/E8UI0OWxhjF9DeRdKvmWtdVM1Eyj?=
 =?us-ascii?Q?xUraliacH3isM6pdnG06YsVGKHnSZRcAFst9KU0VJ8nfsgktt5eoV4Us4mpY?=
 =?us-ascii?Q?/UcQ3QWIdqz+v5xMYI92sfFlCQnhJIESf2jQkEpPdyJW/JNuH8j/98hyTM0L?=
 =?us-ascii?Q?kEQ9Zbrp29VPZUUjpiwUF0UO8XXTdLY81oPnPxLSizkzElqmTuw1kQCMQC5j?=
 =?us-ascii?Q?LduW8lwrOZGEa+o0xwQ8I/Vu/GHqfEBYanSDn0KRjk6bl0D7CLKa8Cv3vAr0?=
 =?us-ascii?Q?fJsbIwPIsTVHkpkO2KOAD9F9Xq+CQ3WSozG+ba4Rukf6tm8jj+s499QAMy4E?=
 =?us-ascii?Q?Al3EoDwiNCPm9fS9GTDUcfj2G82aZdQT0aU1e1CyY9JZiMqODuzvhKNhbpcE?=
 =?us-ascii?Q?rL/1WTm0nRzHncr/Qb3HzfaclgOMv8YABAuutslbpAMot7R2kYyDzUC8ivak?=
 =?us-ascii?Q?vUYXYTJ8S4tYQyjQeQDterZUbd4sJaAwRCA89d6X6N6E3oD9fNfzpCyrQ19g?=
 =?us-ascii?Q?qbOTwhDqSMoUGTEWnJIWLIV+QIoF4eFbYfu/UyzHWis16S2fmnK3JyAqknjV?=
 =?us-ascii?Q?+h7k3NLmWEmMKxWC+rV9seRrKjZg9ZUXiKESwVfmnJZSclWYXk5ZFm9FI6Fz?=
 =?us-ascii?Q?s6zqGv8gOCN4dlrT15PQF6hYQSGcVbpoOq4LQ4hUuEnCzKq8s20kMoqXLhhN?=
 =?us-ascii?Q?451Pc63dhehqs/3ViAZ8/WmGvfAZKNgNVClamu8N4yrJkJ2JaNCGm/8NIPWF?=
 =?us-ascii?Q?gZ/6+PBs1xk2APS2Wafd9Wc/ltHf3HGy5dhJpbIS4+uyUAJngjF8XE3EkUlA?=
 =?us-ascii?Q?IAdc+h/FQyxlfCJp27e5zH6D6GVVKpAkHPg5Ogd9tE/A46/LR8txEpfZZ3KD?=
 =?us-ascii?Q?3MhBWpZLeaGyA3957Dw58BoVAi7oTn2ZpMckSMrWwglwWjiAJ2DL0zFvG4ff?=
 =?us-ascii?Q?b2xUlzdk32JocQQq360bNzzT4oH1pm8trCySx9wKOHBK/GDtCXCq2ZNAfIqx?=
 =?us-ascii?Q?cNxsxA7UaSftHSposUYLHI6b+Y8BCLdacpR1e+h6DVBnemIPlMdYBk9mn60F?=
 =?us-ascii?Q?dCUtmoosBUlWFgESU6TiARFGvBaSeG3VHnccOByqgCdoxBzPgntElQwLv3X4?=
 =?us-ascii?Q?EceO6JVs3xUfEFcuQy4lhQZpw/QKZkvX17nTIuGrBHTimzDyy6tizY8t3eNN?=
 =?us-ascii?Q?5POYzl8lc/xZHG4T0t0qQZnKFOVKc9qbXwOKc97SlbuGtCYqC3+8XpL3z5+T?=
 =?us-ascii?Q?wtDu78q3gK+FnUF1U+mBYx0Ut/O/i4p2OLx/Rs2BxQ3LaVaXZvKNzGG0JBQ4?=
 =?us-ascii?Q?u9ux7BqGxFauqpFX1pIaavdG7vBKUZ+gvCN/QH4DdSwKQL5VTlqN3MbiJwa8?=
 =?us-ascii?Q?RXmvVERaPWWwJ6m9hQPyvVPC2ZghoW5s4/rVTKxr2qUqxf7RPPEjy2uQgViz?=
 =?us-ascii?Q?RhIUAZN4cbxOKT89wTBRU77HIhEp8geYut8Bhi4HWNvzKIlKcIKo/keG/F0d?=
 =?us-ascii?Q?FZbY6qykc1fQgZtuKK+AJntbAg3edatm2v17pFQ7W3oGWDX0giTtKsbc1xf2?=
 =?us-ascii?Q?nIZQFGRm6rcsbTYgMPbl97IzD4M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c450dd5a-4588-48df-e61b-08d9d6a6ac7b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 15:09:19.9633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kArdaiRe/sber12tGPPOdMbneSIPCi1VMNab+WnJh0quQHOjJs7LP4PiMFcygu6jCEwC+zAnTanKbNDzFd9e6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2489

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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 46 +++++++++++++++++--
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 25725be98342..39dffde68ae2 100755
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
@@ -464,11 +474,27 @@ do_transfer()
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
+				local _port=3D""
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
@@ -1651,6 +1677,16 @@ backup_tests()
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

