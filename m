Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432BF1388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qENQgcBJVymYHDxiEsVzyDKSgZRD99NlXClgcelEjhQ=;
	b=UrdlQyUU65izhGs5e9FqTmfE8+iROVyimMx05XNAS1fhMCYndCQpRkDeBSTPVnQLc2fROq
	xwh5Mn7EKjxDdSzsrZGtu+XgK2xxOMgX0Be7JEDu6HdRTWtPyEJPJxIXwuHeFLjQ7P8WPj
	EMAf+TxwbZhP+QKLse1n2BAD4szkieA=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-wUe1FITCPHOXf-pai0vO0Q-1; Tue, 15 Feb 2022 12:12:51 +0100
X-MC-Unique: wUe1FITCPHOXf-pai0vO0Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1N/QYdFddfx8TvZ/BFoBFd+zAOCMKP+QBGqaxRvcNk9Ois7hUDsdslUNbvDRu9xFX6I7kEvuVMDbMU2OSYi7GWqJ2/7RmPeGmJ+SzorhMx4JLlM6nSbwYBvADLD5KdpxOzCBfhOt7ZDuJ9D0o3UTgmzuznIdtb7JjrjIaBS+MAMdpQPmkGwMS29NVC14bajAu8HQaSasJTM2+3TurD5INLMN8An49CATKURfqhSqzs985PCNhYZnmt02j/uy/xX3K1yU7Ykv65fkfzhTYcOUUEZ6C7eQ35QouVotJcnLqSpguYiv49obw87BMgpJIVosjtgJQAJLaad1TGVqIBKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVovz8PKcYuHJPHhUDKRp/hv3gu7gP/cda3u0dABnqY=;
 b=l/C4zdjxEb++bXzIL4qXLzXBHTsMbbjXJShrQiLAeVIAkCWKaWN5/1rMOMkG6n7lApU7plIxnndr5SfLa4MNaUSytMj5+kKC2nP1xzl25Qh0z3K2CNAOvYGW5kuwCKbCicGTw1dY0XW9JMWS6YH3uZeQxLVRNUEvZcR9h3SysO7Azat7j8QBPLU58MVc357GQcACqckTz2eDAcEbfFDsfQGMdQ9Ck7mZpQ2gMNdxb8hV6KtqvHKtqy2+oHn0oq5M6xGq9PL4cjDeS4h318Waxk8XGJFfGbtzO55A0S+yCbnE8ATLRG3iRCxyhB/HFqdhOZ+Gm2/OCwqiTLmsyts3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 7/7] selftests: mptcp: fastclose check in mptcp_connect
Date: Tue, 15 Feb 2022 19:12:23 +0800
Message-ID: <e615c1a86cdae8f021ef4990a25ada1518b5a448.1644923075.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0045.apcprd03.prod.outlook.com
 (2603:1096:202:17::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34bf659d-a2fd-4b5e-d0f3-08d9f0741ac8
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2921566499B0374096604261F8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YGNaPSqakTtwoMp47PreXFqRflJAkWac3vaVnM+SAV71BEy8zd/m73eOfgdmvKjEWZZ6BCj2TFbBWeG4CtznPUxU9vg+AZe3Ep3tVveMW/cww6o0Nh+3Tufux81n33zOcru2yGq9JRFeEAgclAGgHU1m3WKXwBE2Gm9C4/51v2zLrbZ541UwG6r9WLMRk2c0ACpQCBQIxZyoKIoZwMHYIcRD/WxOQ3drrb60CFXAlGJee8N0WwYADAcC4DudW7vl44Ro5QnYB3IOo5qPrOr8U4b8dH6KanDwQHcSkQfqugDhG3cfkqU0WDJ1h+yV2Ip50TfWTV16roByOyky0NzC3eGdnOT4DoIZqfmS3IBl9j7/Kt42BC7KaHNb1lHXWLhw+k5PoGdQlW7XIAH4nbex8/TQK3QR8+7SOH9dzZNf7YPwq3HcYECOVWIR/atdAhbJAsSFGIt0iznPBVVmTKFBVmK2R4rufPKqJJfLiY2CpUHwERKvAZY1VTldgZlxvO1G6EVAotagnEzduUWNTA0ZX4UN8Jy07z3BEy2zfluj5EhX+B3lsShwjcbvk2siECs8Bg8mOdNTRbZ8yGjcDp1waSDULF7c+y5XoMYy98/t7+Rs5cEQKkScJvNd1ykSohBhM7euS1z9Ch5XUkMOsMr7zA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6666004)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i3c9Yo9s/qSKi6n0x44jevnt55qEpfoJoREWHrOMYY3ILGtj2OlWQzsX8XGi?=
 =?us-ascii?Q?6R7PlfjjOSLBO0YSiHUScevksmY9SOJVOelz052WeTdhVAqd29JWJYpAKck9?=
 =?us-ascii?Q?K2quOtZcPvSRqePRUURFNcL+8s6bGgyRIBIF4YVc8h6nXOGi7nI3jlgHrvSx?=
 =?us-ascii?Q?QTQxbek8BI950ztX4n1cr50CuIPUdfAhTHDpRwWuV63pT593lx0WhwKHaV4r?=
 =?us-ascii?Q?K1fsT/r7PnyRT1ZhUlyPGsDQBB4Kc8l4SweGtmNKVqTOMzIxMDDtK4zMBcz3?=
 =?us-ascii?Q?5VxhMq4WDnCBXYczLKBsE+n4wDbgOuFE4oTTBE3TmxsGSaBhXj8FDks7z9pX?=
 =?us-ascii?Q?HStutLNvSVoyKbDSUykiGFm5FKhGPyBQlofRjrz8ug+OnL/p1vLoLss16Ns3?=
 =?us-ascii?Q?JlVFfu7tbqoxQ/rxCDK4nS1j3LnCZdDy/DHHPPmwSomznDcMZ+nL8Z66JVkf?=
 =?us-ascii?Q?bKDuvmkpGSVPzsaDspSidkUQtgOQse1CXEhOGjMcpXHIOpCe5KcUwoxmCMa9?=
 =?us-ascii?Q?yLcswxbZte0EyN1MICXuS9XThkMar8iUolAbMy4t5bAmw1qZDKDIMz73qXXQ?=
 =?us-ascii?Q?53eFMuTxuRqe0vwSK8eFiUx4Xy1pAxqcVvN4dYFaLPO7QyeiNPoG0A8RZYUV?=
 =?us-ascii?Q?ZAq4DyXGv8oxf8R/euPH8+92EfypcCPrddIYXMbjYc0j/BzdViI0miC6tEGl?=
 =?us-ascii?Q?2W+1ilFE1QdbiHFQWuWup1VCzli5wD3NhfU3WU1tLH+jvM9whCy/mSQmRVuv?=
 =?us-ascii?Q?qDNnE9EbPuaRcu2A3uamhHLncSU6DBrVrrc+3MJLZAft8XqemLEoXg4zhe9O?=
 =?us-ascii?Q?wLYhC8wNGdznwoZjZO7miDI/Nbl0guTky5DPP1s4HjrelMOPCt2HXopbzzBb?=
 =?us-ascii?Q?Dr57QNKNKAnwL22AJcFt5fUTStIkkUJumKF3OtfNta3UzTPynKyOKjccdCGa?=
 =?us-ascii?Q?381mcJygNq1jdmliByZIn3vgFNuloDDBLx/xojmjRI7lzPlbjs8vNIs8rATP?=
 =?us-ascii?Q?kdoC4RQjhfUfJLMn3Ox8vy3A+DJF4SwPIpG85wGRj0x7v+fdyZAip7s/Dlvv?=
 =?us-ascii?Q?v92M/J/vMAS7O0+mGhe7NMUnT57QfhnO76dTS9o9vXDo1fDFQeoTil/VPzQz?=
 =?us-ascii?Q?Z7BHk/lR7x8ROe3vDFWjPClbNjfg8c7TQVWHkmwf1dws7Bs3HHkpXr90jjFv?=
 =?us-ascii?Q?GQwdyWSRUH1NEfpvYhI26Vfo1f6s7o+qCxOrL5aqZlZ9QzMLnWvUINxjYo2Q?=
 =?us-ascii?Q?X8gepxe258ywICdj2CgeO0bCywdYV6skIjjUiP3jTR+h6Gv8LqmU3lBcfgPg?=
 =?us-ascii?Q?Ja14aVYmwKB+CNORNZ8RaiT+pjE0s/gJu05tcii3SFl04CE1eYBcd4TCOwTt?=
 =?us-ascii?Q?6RC8ZdYAzUGFQLzB8iGkxnpQwKfVendDEKqjBhWoNOnGdb7LHMqor7MJTGI5?=
 =?us-ascii?Q?X14hgofjzjLH5ETPpvjJCcrKmkAU2ChTP5eTkozUXgqf0jvvy+GsRGYUmi0g?=
 =?us-ascii?Q?PG61kb2pUx+We+U4we9aQodaTc2k+GsEI2MI/O0Rn5Lql9C8NDWOf/etnZuV?=
 =?us-ascii?Q?eKU8Rj6FWDFtKOkXn1AZ+m6l+LNK2+56WLOgtguMSCltrI5tx1p//wK7JY+I?=
 =?us-ascii?Q?A74DsOXN39KnwAcOZawNo84=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bf659d-a2fd-4b5e-d0f3-08d9f0741ac8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:50.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLBMtPkmVxig+fDrCWxsbTv6oZiDtgP8e7zxcAEV6QRWjGTRXpPAzTVcvKPhjIV2g7tSsbKa0go4HdSlUrTQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

This patch added the MP_FASTCLOSE mibs and the MP_RST mibs check for
the disconnect tests in mptcp_connect.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index 5b7a40d73253..b27e2c884523 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -434,6 +434,10 @@ do_transfer()
 	local stat_cookierx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesRecv")
 	local stat_csum_err_s=3D$(get_mib_counter "${listener_ns}" "MPTcpExtDataC=
sumErr")
 	local stat_csum_err_c=3D$(get_mib_counter "${connector_ns}" "MPTcpExtData=
CsumErr")
+	local stat_fclose_tx=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPFast=
closeTx")
+	local stat_fclose_rx=3D$(get_mib_counter "${connector_ns}" "MPTcpExtMPFas=
tcloseRx")
+	local stat_rst_tx=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPRstTx")
+	local stat_rst_rx=3D$(get_mib_counter "${connector_ns}" "MPTcpExtMPRstRx"=
)
=20
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -543,6 +547,39 @@ do_transfer()
 		fi
 	fi
=20
+	local disconnect=3D$(echo $extra_args | grep "\-I\ 3")
+	if [[ $disconnect !=3D "" ]] && [ $cl_proto =3D "MPTCP" ] && [ $srv_proto=
 =3D "MPTCP" ]; then
+		local fclose_tx=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPFastclos=
eTx")
+		local fclose_rx=3D$(get_mib_counter "${connector_ns}" "MPTcpExtMPFastclo=
seRx")
+
+		local fclose_tx_nr=3D$((fclose_tx - stat_fclose_tx))
+		if [ $fclose_tx_nr -ne 2 ]; then
+			printf "[ FAIL ]\nserver got $fclose_tx_nr mp_fastclose[s]"
+			rets=3D1
+		fi
+
+		local fclose_rx_nr=3D$((fclose_rx - stat_fclose_rx))
+		if [ $fclose_rx_nr -ne 2 ]; then
+			printf "[ FAIL ]\nclient got $fclose_rx_nr mp_fastclose[s]"
+			retc=3D1
+		fi
+
+		local rst_tx=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPRstTx")
+		local rst_rx=3D$(get_mib_counter "${connector_ns}" "MPTcpExtMPRstRx")
+
+		local rst_tx_nr=3D$((rst_tx - stat_rst_tx))
+		if [ $rst_tx_nr -ne 2 ]; then
+			printf "[ FAIL ]\nserver got $rst_tx_nr mp_rst[s]"
+			rets=3D1
+		fi
+
+		local rst_rx_nr=3D$((rst_rx - stat_rst_rx))
+		if [ $rst_rx_nr -ne 2 ]; then
+			printf "[ FAIL ]\nclient got $rst_rx_nr mp_rst[s]"
+			retc=3D1
+		fi
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
 	fi
--=20
2.34.1

