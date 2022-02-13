Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712B27A
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 02:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644720914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AQkAhFOPnhUb9kitouk/e6xf8vEDNTx0PsQS+01Mwjc=;
	b=d74x9SItYGobg3ldqTLWL49rmEag6ULK3K5vDJ5VgXlgnKTTy8n1TGHWqUBRTkr/ac9Yua
	dB4e6DdSkj8DLmIt22F1NlY4DuVSAV7d4xlCeDZOTC5WE8y7+DQ/NEgTq5aUL3JQT5pY5h
	leTbfbVp1TSY/NCZDgiVOkOs3ppZP/o=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-v7yQ-4_bM2-J3IOoPsQaNA-1; Sun, 13 Feb 2022 03:55:13 +0100
X-MC-Unique: v7yQ-4_bM2-J3IOoPsQaNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YW3nOYRfSBmYmGHiEcveyDDK5CkWKIKk5sr80ID4ayuvjuiVz1SBvaui2jgx02Yq9WAhIthlGuILGyH5x55kplBkKnLPH2PtbYchhWw8DlF6wsnn48fEQJ3XQwjWp36ZVN8F6Q4lo1LqOwICojOkzfHPoRyxIFy7e1PtzTLrj8wUJqktDDAV7SupbAOo0uHkPStmWeMCms/LZ+wW84S+4Wu0lgK/PzYFhdonwaDr0+vlPx4wDNVdgSeqlZrmCKV9EzZjlBYCVMQ82wIj3q9mx2pDn/ibVJznZih5GQTZ4R6zJmwOCsF/7275xj9ZseRwXyPUmVuo9Bhv+87ofeK08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k39K22oPjSNloEFM8yQ03YaZKxlB2K1OuRP6FZpbuAQ=;
 b=aZ43kQj+Fuqrpe9O+xNHhuEHWid1zL1b3LLA6FWgJiveIUHSlwjDLRQIGoPOX8ATeATU5vY4IREXRZQj2AAX80cE+FR2TjCimZuaL7KNLE3zZgoWMFvjoV0t/3SqqouX/UeEhjEdCD0MMjOJ1cRuAmsTz/fdA9l2FRIcOGkfmhpV5uGda7PxhV7Lj18LBzdXqPF3r/225YGkJiGZ4JkLP8aIaZnTlfya5lXnxWejo3/Yk8MqTrHkhOmNvHKgeTEu/ozwHkZYdKVrqJR8y5JjbNT/ptDINUw8ZWIppcKo1aDloAD67D51l7sQYmZG54wbvYa9ItXbckRTVfSaN1RzCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (10.167.126.14) by
 AS8PR04MB8756.eurprd04.prod.outlook.com (10.141.158.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.19; Sun, 13 Feb 2022 02:55:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 02:55:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: add csum mib check for mptcp_connect
Date: Sun, 13 Feb 2022 10:55:37 +0800
Message-ID: <fdd9c6ef7ba7c360832acd349927871fbbee495b.1644720920.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c511a5c-338e-4549-475e-08d9ee9c3faa
X-MS-TrafficTypeDiagnostic: AS8PR04MB8756:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB8756A55D90B8B6920027D093F8329@AS8PR04MB8756.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2MClgJ34ao19BYCKDtoUGl6p8R4y4Wa/jyU/klee/NvKrXADQ6jy3/wLF74k/CS+s6dsmATDI5b7f8tDknzJcJl2wre9fb1pVdUk20oIT3GaCP4vTTTiNdtjj2sQZ0zQTQBgWgv1cmNOmgBJ9aMXqmwhWyACNPstRQrOn+CziP5bYVFOSxy5X2quUXXgN4lFxzAQqNxtYfRsWez8WIGA2GgaS95gtU2l2BKMFMFJqjtG74K3y/dOzqdfdI7l9P8AoL/uDM7Bue1vbQxyGNjpQJHYMjQjj0xPMivchDKHZbJLxInRi2eA5FTZn898e9m22JGZ8gE9GvbHAP6bn2t4XPiLCKnUqIBiiQ/6yJMyXNpvFq4mDEFoX8ek648MioYLwZRy+p/zOlpyBQMjXqI6yc+dY/24Bn0TqSU9vNB0zDJrbfpYu4szuVRfUmVWp8vR/Dra5op+xBxj/AB5H99oAhAO/maLZzORE15eQwMr74A99Z4KrkAQn4tCp0/R2oGiwK9bsZ3zvEQBp2dYQuemzOhw4gaTjABBI2gAgBD4xNqVRl7JHid/I/4wcuTptDmiHqhXfVNqpDfaAV7EdjSZBVX9cr6AwLkZtA8cO4np67eJAgMW5bpTV5VTTH6P8KgKJt2oOuQlEhtral+5YkdBJEyyFdmuRR3daS6Ni7QT63PMm6DJ//IXqHkmvkWTBftCSp5W/a21zCN7uQMdTYKPoBdkDdBt5px22pNfV1hWlkrHQKK+ueah89Ca2KC4SfteEkxeR6WXXum+3dPV/qJ1Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(86362001)(6916009)(508600001)(36756003)(66476007)(6486002)(6512007)(6506007)(6666004)(966005)(2906002)(38100700002)(66556008)(4326008)(83380400001)(107886003)(8936002)(186003)(2616005)(44832011)(8676002)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xUI6A2dmiPMfuLYLL799Z3zRFoiF92IZ0NEUIpsu3hEUYxfmYQrlcdYqXDMr?=
 =?us-ascii?Q?zulUxy2Qg2KS6+I52e+b2RWHwtJioinvYoCBTm3KbQXhE0bpRtvCJzJeH8II?=
 =?us-ascii?Q?borLRBH4MS3zdj0q0KxTCGM8YFGuQzgv58DG/nAkVzKJ/UAVym/Z0+5B7Sa3?=
 =?us-ascii?Q?VTVz8yhgDXi6CBnwlPf2XCkSMF6UHlh1+b1zoBYAWIfn2eQHIsPLHdHVIi3c?=
 =?us-ascii?Q?OZTdZkAVeQ/yTHJOs/VJT1mO0leQsiatVZhqq+/GIj19cO5+GauTmUdqos1f?=
 =?us-ascii?Q?5plP6Jcma4Rh0O6p08PkjNGbv2i80b2nsOh1MSCoPltd0XVSZCgKPvKsrJ/c?=
 =?us-ascii?Q?56kg5fJSgSvgfgQ9G4/7hTC3g57waqA+Lsd2pxlP89lbyXxKgPabfA6IrDfD?=
 =?us-ascii?Q?KKgm6hKQng8E3MmMrKuNIr7Y9U77a28BDAr+vsxvYZMt3aVshTgpGvPRWqiU?=
 =?us-ascii?Q?WEQ5hDemdp7wpsvC6waZv6jeuol8vdZ1JerTZgYjJvxSQz9pn5udOFq5YzQL?=
 =?us-ascii?Q?8dRmmGCD8WDH2WcVYj+fbCahYKEy/yWRIMaaoV7w2h1ajRI59H3jAighUdsN?=
 =?us-ascii?Q?vLcoawWYsNBOkJDPX2NDBuLNYDPkIVmtWnlqJk92gRnO2M0y0LEhhl5WtBrg?=
 =?us-ascii?Q?+WQc5NvTu9YtT8oFJ7GAgxUnhYYMRRbcssrCVscf9KpbQLxiQbRUTKkXGFv4?=
 =?us-ascii?Q?pl6rNF7vkrOBT+VWQgRFC7IsExwFNtYlIi5Qh2Q6h4pgrPnmzGxWi2Wtwo5o?=
 =?us-ascii?Q?YecwME4Dn97U/5IxUh8gVTaMIig+AI4MqKFEUZPe3kQ2lv12o+4+gq6DwVWJ?=
 =?us-ascii?Q?yEle3Qnl9jt0baOLBN8XGr0fkSCW52uvCtAfGpVhHQ1NZ7DCa/FnFe5Uv8Gw?=
 =?us-ascii?Q?OwsAh+zsLPchoyQQK2kABF8TZS6PM0GS/hi/pZ3cTT1KuFXK8EQ2uEamqHxp?=
 =?us-ascii?Q?H5//cB6IBmrHXFmZxa14xUlvHKiQgK58iABYO71bh40ONsH3ZdJ0p8DCRAkm?=
 =?us-ascii?Q?Wq7f+ON2gWSyMRDrV52v1BZvwEIVtFGjOQ7AGMKkJtbdl7++aEJQTu3D2Gv3?=
 =?us-ascii?Q?rsI3WQQJvQKoL61s7WgfWU16OwWRvVSZAw3hU983xOouebVfQ2qvpO66zCyn?=
 =?us-ascii?Q?ZAL7NtBXJg790vTDnfEQkhTayqzux+mQIjG3xTMSGwjoIvHKDZGUDbBlwKyc?=
 =?us-ascii?Q?s5j6bo4Czj2kZHtgQ4exrAkFYW0wSaU5eTwBwKTSeLP7Nd/CPlne2iqXGDXo?=
 =?us-ascii?Q?SrhAaSSsyU51oFTqlLNA/hKHxbyaqFwTa3ylb811k7lnSsKLSL609KIDW5o1?=
 =?us-ascii?Q?DPo+W+mmVwF4emVt2XusWAOmHMbNWJdJ2Ny2AVliuloOmLPj+F9jz/elEQGz?=
 =?us-ascii?Q?RsKa3tnqoaWXz6RPmjjiZOTOTID1yfJie+TNQgulU4/4zDdPExu8lXEqCrrE?=
 =?us-ascii?Q?kOgBPXNo72v/xhy61owPhEHyiv371qGqCfqNR9TCtPVK05NIot1duWyBZ0T8?=
 =?us-ascii?Q?fsg/VieY6bURsHMniyfGIDzNM7mgqFSh4NaB8NqhQ4ekXl2A5nTi6LbzpIWt?=
 =?us-ascii?Q?m3ppQN8kmIziouxjN+8Dn3y7lrJ98rB48hJmbsZ/lnHf38zP4TCOjjFSqT2A?=
 =?us-ascii?Q?mGE+80cQtyg4FrzVXFH1eO4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c511a5c-338e-4549-475e-08d9ee9c3faa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 02:55:10.3974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3kpoeU+iAG3ljp/V3VnNgUQJGFuTDoGIvGmlux6LD5vPHoYA2WHLarwclQfQWDwU7BQNAnHWW4WY12c/C4sog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8756

This patch added the data checksum error mib counter check for the
script mptcp_connect.sh when the data checksum is enabled.

The output looks like this:

ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP   (duration    81ms) [ FAIL ]
client got 1 data checksum error[s]
ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP   (duration    64ms) [ FAIL ]
server got 1 data checksum error[s]

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/255
Fixes: 94d66ba1d8e48 ("selftests: mptcp: enable checksum in mptcp_connect.s=
h")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index cb5809b89081..4332debc9967 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -524,6 +524,20 @@ do_transfer()
 		fi
 	fi
=20
+	if $checksum; then
+		local csum_err_s=3D$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumE=
rr")
+		local csum_err_c=3D$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsum=
Err")
+
+		if [ $csum_err_s -gt 0 ]; then
+			printf "[ FAIL ]\nserver got $csum_err_s data checksum error[s]"
+			rets=3D1
+		fi
+		if [ $csum_err_c -gt 0 ]; then
+			printf "[ FAIL ]\nclient got $csum_err_c data checksum error[s]"
+			retc=3D1
+		fi
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
 	fi
--=20
2.34.1

