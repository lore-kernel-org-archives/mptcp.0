Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727D57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=geooSBKcKNlbZRAlykuOr3kWdEtfzQeHdmvsIJ5Zj/Q=;
	b=Yrg/mJ32JAg7Lw3guH5XVgtNWkvBa7X2+74LrY1kwmpUgsJPNXgjHMo5EZ4rwxEEzWu8r5
	aXFHZsXTlftD8xVTB/BUKsQYK8Z9TpbTopnRegsbHHQGC8ddE1Ptq3ZhqV5dp0Gt0+z0ub
	vTMXlbbxtzSpqBIhJlJ8pPRb+WR5Odo=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-S1BTcxOiNcWaVATWgmw7KA-1; Sun, 20 Feb 2022 00:17:48 +0100
X-MC-Unique: S1BTcxOiNcWaVATWgmw7KA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyBxkqPXXrgfZ9pEUQS5xVvWXsbHp8vUNZ00KpPmvfwDs6D/I5x1Y/mQWiIoohE544anXBAt8P3qxG+vZdpFxy6C9XaY+m06/gVWukJoishEuxpSEiqSk8rNbfXd3O5BgJ7K4KwPlwTPHUk4I2Wcby6zt8DpG7wkj851xXcXawOBmsYG/cTfRCHYAoj8tToZRXvBJlnlAUipvPFFz15BHG0THB5bO3NJh18dEqz8+aeQIUQxz5/yDtB4pgAk3rbD5J86VyHz2iQo6QOw3GHJv1lQgI/m9OLxP14Noru+NOpm7h1rlFSNhGc89bdzG44ho4mrTG5fnErrmseRYOSDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjwH0b9VndBZ8HPsz4t/g8VFGRWKbIbuszQiKcmRdIg=;
 b=QSe8EAupoI7kWaeP082aUDPnj4OLUU8CL+CF7PSL6Bz/i/q32f7Erv/+ELywaZOVIpiqOhBGOOX+krurbfx+jPZrsGpIFXSTxAeP+A72jYQYS5Q1Z8cJm4Nu0LbKd/QhKe6XvJ1F+rDkvO994DAGO7ePhgYd98sSgG9ksDszvyQa3T4iWyYoyzBix5bA8VmjsxXrKU/TrYxCniQzUBKESFLzz2ay9y3fmNupjwA2EudMAv+1Xx6YsUtWsL65UGGLiW72taY5tjlv/dhGimSXw+1/TTkaE7t95oyRpXSW3HbsMY2AF5RrEL1NqBm/ymu837sEY/Piqnp0vUBI5+Sn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:17:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:17:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next 03/19] Revert "selftests: mptcp: add invert check in check_transfer"
Date: Sun, 20 Feb 2022 07:17:47 +0800
Message-ID: <795d36d5f54a9237dbc9ce6827511cc7eb4e5fe0.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ffcd215-316f-4063-6918-08d9f3fe0ac0
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8812F0BD0342440EE2A45012F8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PKIQAk2skkVNPehC6p/LOkXYhq0IQc9KJaiNF83HOvVN94oTo/UfsOcA+K2AEIfiIEkiNhrQ3UQ7Tx0bgF9ocH4WhIWCnHIfAKmEbMgRZVflVvO3Hzyh6kke4M24AKoipLW3zDYRRPCfWWyURoT33cWAyP7WrvMPKbQuZv+BD6kWDrZGntqUyY8VIJUz70yz1xvp6x3TD5xpbZqaQmsq3PC6lwLFKFXFjAviUUB8wtqXhz1b30p3qkwKG34RyPFOLyJ+1OAcj6mw6UOlw/7NWjLkqxlLDRN+UQXKVy8ezCX2Kvwbwe3x+hCumIMq7XAQ6aP+V9gUdEaloEIEi5Yr9JGVCkFWMzQ7Fk9TxSW/lgNCt69KOeVHTAx826O12+E6s6xUSHm/3bEPAUJOrPmHsTRuVxPn+NykaCe/BnxsAVKcfWY8I5O8UoYCqrDQSL/OmJRRlbmtE6Bzp7FtrhY6a1hN6u+FYR2t/V2MxZUu8M8uIXUWl0AFuWIWwTk+P0OI4J7eAsCIgiH/JG69fN3cghbU2gGO9iR7/q65fuxMuBQxrz3K/4wfHK6OM6/nrVJDNK1WSC1BT2iQXygK2SaxPimA6op16e8SGegfjWs0SDWEzSXgsEbO3HgOQzKL60Gw1j7kUjB+f4h04M0ha6kQgg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(186003)(8936002)(508600001)(107886003)(2616005)(38100700002)(6916009)(36756003)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LqIn5Fbf8h8epGeRdL5TfWETxbbXmrNDA8OuSfJ8HO9BPebPw5rRaWImHrEy?=
 =?us-ascii?Q?SHJfE6PTH7VtAnXdy7LwyVbKng6ysMX69GaFbBJ6rAMB42zUoiqQI+jc6NU7?=
 =?us-ascii?Q?BMq2zhxFTMvutWoOeTh3VmYSubxRwA85o3Kl++Mt+ZiePFGCmlEZCMGc+pP6?=
 =?us-ascii?Q?qtOSDmybcRawIp5uknwka6zuI9mT4C2B8fEEbvpN00fO6CskHFbrxxvg7rJe?=
 =?us-ascii?Q?2WfhbOmSNhwVZFucekc3sZkChzjS/HpoXJ9OPSQUWAD4IxeVtEShIfaJDBH8?=
 =?us-ascii?Q?SbInbY/malw4xDgs30naBhn/cqJUJ0Ta+Qig4XRXl9R/RT2MGfN1zUrEM64p?=
 =?us-ascii?Q?aCxTlTD1Be4DOSqFfTCz2KqasIeMGmPz52A6qhG+XnThkPMATaIDLvIT7xly?=
 =?us-ascii?Q?zHH8DSrXn43AIrROZsw+zDLIYnfvz8Xu9FdOmWxRelO0kGhnrrBcIF5mMA0s?=
 =?us-ascii?Q?xynAcS7qbzYa92vXk09Par2avhRD3CtdVE1W47oc1dN2AVPB90K5NWkQDsZD?=
 =?us-ascii?Q?GxkWrELLGHhAYav3xTOzKWC2Po4EhaDbcgqRtowIF36Cd6rY8oWdzOdizWZj?=
 =?us-ascii?Q?IAGvVRSey1+LeDxd2nn8IYndon2TI+fFesbuJ7kZBU8wwRgT0aklBnj9+XsZ?=
 =?us-ascii?Q?Q47S3Lk8/mpuMFt08iCQ/rbe8KAJtyyfLo0y34jCgNDSb4lPaeLhDJIaIfLy?=
 =?us-ascii?Q?B+Z8wA71letBhpCDThW77pcBpsUiIwVvAwO2yT6+luUpTxTnudsMYQCX5TiX?=
 =?us-ascii?Q?0hU3brqSqX002w0O9DZNtFzHyU8nmxc3ybHYQiHYMtSHFwYTdjh0RF1TV8ZI?=
 =?us-ascii?Q?77/OIqytWv1n5IlZy2pk896gCyM6eVKARhmNOB1vgVOvNzJjpqPldIFYaa90?=
 =?us-ascii?Q?WwQe4ZSy6PAoAp3XWAKsf3qBk3lVR4CPzcs4tmi1HcMRI8hMa8MbGQVngCUL?=
 =?us-ascii?Q?7jB4LHiEhuYYZkwg6KR78MHWk1S0W751Jt79DkSr0iDfXHuSoYR9Fl1KpCrX?=
 =?us-ascii?Q?8ax82y/KmdtaSmYZVix5elIBV0NJsglmXKGnAD/jyDmEhS1XN03XAIUJ3Lhq?=
 =?us-ascii?Q?Sfty1pJbwlx4FsgytcfnbQv62tOTUnzENnWeKSRtQixzBLgC3C25PaXDwP1X?=
 =?us-ascii?Q?QJAHVWYwtc5EHtMnKKMTY+K5j6WOFNVhCR78fJ0XRl3dLR1+ThvLpI6ksLyD?=
 =?us-ascii?Q?MbH+jvq+FDiKTgNP1KGqrj+cMO3G1pKlbE/kIwIDXDn77M/MY7ZWsawt54K9?=
 =?us-ascii?Q?6UjiX2/H3AcM2NbiJMKrQihrofzfuIjrh2vImhRXxW9PhrV3TWMkr663Zp/X?=
 =?us-ascii?Q?eRzsbASqvU9B8IZFW4B8Rji07hOlxMoTi4qs87rz7swIljTREXHDPRGZ0Js/?=
 =?us-ascii?Q?kU4h1khQdVrbPuTha5ynhA4EtXS/UZTCR4FMfsmBJFY0S4indJ0B3ZbCnUJq?=
 =?us-ascii?Q?WjO3MU6rbfHqNW52OfGw8wq/HlrwNPcTCW+6zJvypD+09nw6y+jbS6Q3UI1E?=
 =?us-ascii?Q?g/HflhQtqKBMj8hQi/syVZEwAHHWTfn3bCMTXUF6naz2yRL6Fz1+SUOnTJPX?=
 =?us-ascii?Q?IEBbtm5IJYU3APS49vId2ie+/J2AbtT4POib2gnypTNzWa9ZzYp+JAK0v/sZ?=
 =?us-ascii?Q?E/AGf7XXZyTsZ3xiN+V3TCtE7+v6Xv6wKVSwxXtomGJVUjSuGM0FxGYozuM0?=
 =?us-ascii?Q?uoS8l2dDiFUO/+3eFwSYnMRbdWg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffcd215-316f-4063-6918-08d9f3fe0ac0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:17:47.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJJsc/QX1mrcnpPpwQGPaMjFG4dQtqz1P5veV2KeZ1MnDrgEtAwQQLGsJVElsr5a5NN5bDbza3G3unYc+SAwSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This reverts commit adde1b7ffc4d70608d04be74d8a0f3e5e9b55ab6.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++-------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 519178dacae0..46fe7d135e30 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -16,7 +16,6 @@ mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 ip_mptcp=3D0
-check_invert=3D0
 do_all_tests=3D1
 init=3D0
=20
@@ -61,8 +60,6 @@ init_partial()
 		fi
 	done
=20
-	check_invert=3D0
-
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -220,21 +217,15 @@ check_transfer()
 	out=3D$2
 	what=3D$3
=20
-	cmp -l "$in" "$out" | while read line; do
-		local arr=3D($line)
-
-		let sum=3D0${arr[1]}+0${arr[2]}
-		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
-			echo "[ FAIL ] $what does not match (in, out):"
-			print_file_err "$in"
-			print_file_err "$out"
-			ret=3D1
+	cmp "$in" "$out" > /dev/null 2>&1
+	if [ $? -ne 0 ] ;then
+		echo "[ FAIL ] $what does not match (in, out):"
+		print_file_err "$in"
+		print_file_err "$out"
+		ret=3D1
=20
-			return 1
-		else
-			echo "$what has inverted byte at ${arr[0]}"
-		fi
-	done
+		return 1
+	fi
=20
 	return 0
 }
--=20
2.34.1

