Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBE2CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641982119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeL4rjwxFg4vjBItoLKYUo0RKQzQskXB18382KdpCSs=;
	b=LkZaJy2TGStM5BXbBvSeN6cNSjH3NnxGBVnvtRJDBWI8kCGG4HE5ySE+REqLqCzAmlZ9Xh
	LVM/C730nlHUKihcCNP8+apjYmifWJFFvEOosSRCBpOko5TwOR2+9SDSP6DinLPJTjh6+C
	FVrVdvYgiYR7Q/ftqsa7Bfqo89rQe64=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-zggHsw5dOlyBzEC3tR_aVw-1; Wed, 12 Jan 2022 11:08:38 +0100
X-MC-Unique: zggHsw5dOlyBzEC3tR_aVw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgosspHoXHX3kQhDpBg5LUkZVDwczEQ8jte3vcqvPJnZokXAzGxyh4xaKcbopLSg2FvYAG9w5PjDCwwxPAqCx9KdHT9KY38qOSnd4ZBaTvRiftI4xSEX9r6n/m6JuxoRzSYASqpcSMxCt4lhbW2vOFa8JVsa2X+ZJPVAZfg37WsWQ3fmgya9YAWJ1yh70xOfWxCLE79JDDvClpBg7WjIVrzeLUG0dgw9qTtUiW8tmFrn4IBZoASjrKrmd9YuwPSFk1gx6i6fml4TmbejGeIFcmOXD7/83vUMZEXeL0FSEtLeBvo2HcDSvgfwyl0tcqBtLoxqyebqWF03zO/GT4u7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vASscAK7qYvQDGzulm9oZkGSWQQp5my/lsYZd1AZL0k=;
 b=awSvO3p0VL8xeJSGgWZOeTWNeLqEaudMe/F+z2RikrjZWLwc4Cey5cA6J6H8y05WEpEY9wWUvp9zQb1UB1UG7qKP+1SSugWrPPSDn3NjeMKFNN9ntQyxSnpGku22VrOlCbw+k1P5R8G+mTCY0qIEj3dEswCxs3UWPqQqQfpqNqC3pPa336HaDk6ZwRbyE0QO9bZ/6x1oYDkXCR2DwrCkDlmrsZ21+TwlYbjNFGWvEtlOlifcuxpZvYzCCuorbNFe4qa5UA0NjowdGmVhvIqmJLtZuq9LIvt0MEIlZc86ubAqTx5fC8b0dorMp0gtya8r86QoHoPkUe6r1LyrQC1AmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5373.eurprd04.prod.outlook.com (2603:10a6:803:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 10:08:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:08:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 6/6] selftests: mptcp: set ip_mptcp in command line
Date: Wed, 12 Jan 2022 18:07:35 +0800
Message-ID: <0b0265472485d647c31c699eaa12482b26240a58.1641981669.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641981669.git.geliang.tang@suse.com>
References: <cover.1641981669.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b356e51-9cb0-4c53-6122-08d9d5b37fdc
X-MS-TrafficTypeDiagnostic: VI1PR04MB5373:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB5373D78E81309764CAC12385F8529@VI1PR04MB5373.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sgOMWKeIPDdGwAYtNkLdKHmD0ubQaajpcZUOn4LGcI1SFF4RY5n9Lek7B2rQ+SKOtdjHE3PEM5prEhyQS06nNMBzA4VKVb4KBqyNwBWisot8OUE6fHbLci6joyVOKc+o5KP5kQj7mjK7rMpnicYH5B9Po+LEcqS6C4FJ36PN+aA9w+5p8pd+e2yJYBxdId4DwD1ptaDrk8rbFLlNzRafTSfiIJDdEox3IfDyP7RMPa/xYrm3+EE7NoxNVlSgsiUynUUgyqnOYzqtIgzAn455TuBbwEzPJEjkvH5HM/0fykoVWifs1DHB3XnFGEzm8RdwYB9adw21oYSZpUmjwLRVJYMdUiGgg8QUTfK4JGGBLfqrpa81mHkNspp12Q/Uq8offZPidve63sVcffMZEihc2zLUqiK0JHY0QVtP8d6NjhhGdCMmrtFG4aMLz45CR9j5HP0i3sikHsEqOqMNLk1DxE1yb7WvX6CkZdKlpmqHzUymgpWenEDlGeEBp1GnjnqCT+ab54bOCpt0UDFgQOEprDAAkhqT+4r6XKYIwbJ+Ir26waHkuVNj7MR3UvtRzOj38z8sm94qK4ulRKeqNHI79qZ7KfVmAVQi+FZ+JzWGL0/EBYbA0H0ubkzdkRc2qZJfNA+ZYAZIYeyW8nDAghrElg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(83380400001)(66946007)(6512007)(66556008)(38100700002)(6506007)(508600001)(8936002)(66476007)(2906002)(36756003)(8676002)(316002)(107886003)(5660300002)(6916009)(26005)(55236004)(86362001)(186003)(2616005)(44832011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zm6YQVrX08x/lK6cinBFAcSo+mmafcZ6b84nvhT7NxAuW5jlJBYHCbJ/AakD?=
 =?us-ascii?Q?1lMGrHRix73v4ZIg3zTmlW2r6j4C/EBkLpW56jFVMQMBSGXM1Siafd45wapp?=
 =?us-ascii?Q?l/Wyw1lb1fZVJRWeswIqYZY5Denadt7sgRNjPs/qelVNZH5m179Vpq8eHbQ+?=
 =?us-ascii?Q?4PZzrUY81by+jlZ7H4VPeKmrpxULkQ7QLvVily3lE6tTIcW6WeRtQxtlgTka?=
 =?us-ascii?Q?/C1NTLIkiVuggotucoLyvv+htW7QemFfFwocQEc2xV2sxC6hfNK7f2kBYYlt?=
 =?us-ascii?Q?q81h620Ckyg1PNB009AtFO6+6MgrrpQPwD2uCrPgFR4QkozZTQR/ehMLZABi?=
 =?us-ascii?Q?PGaAo1/k5sCoU8Vq/Z6QXGnc2hHSAwTNo+61V6OYD+yepNXJIfL3o53Xb26n?=
 =?us-ascii?Q?U8Kz+NDUeaMJjK3/9hYpko97bkUVybe1MEjcRYsiOcmZvIDir5ojZ0/GgLQU?=
 =?us-ascii?Q?uEfwUeCvUD9GtX9UZtP2P0VCXKQUfx9jjmRnXqz6sgzK4dt+wfZzpLTPv4mY?=
 =?us-ascii?Q?yXhCCOQyrYsL9hJgf1RGKAEmAZEbf1WdEwUJWUrv3mvWjWlHPIKQdReC656k?=
 =?us-ascii?Q?Evn7bcXXkGkjLAamur+HaL2JbgicDfx90OOryknrp4QaB8m0Ury9/m1s4Uz4?=
 =?us-ascii?Q?8DhjV2shxnF6NyMbfX7DqYKp+8xVVgLaoQv2Q5I66NraTscVNEKokA+zwVsl?=
 =?us-ascii?Q?+dYGpuKprN663SL1alWkvpg8eJsNB0eWLDlzpgau+/l3DN1CsqW45aHS5V7d?=
 =?us-ascii?Q?viYXDoH5WVp1StHkPxUqIhDcOHxG3m2OFsHuc3MXjniseufResRhlcgzb65z?=
 =?us-ascii?Q?whUIOe01N/DPl/811kg9HiaNMbHGw7c5XXa2UCuvrO+iMTrvHI7hi5VJBUuB?=
 =?us-ascii?Q?VE4OUzPbsHPLJrFyP9vcoMcLRJNVG8C0nMBDZHvhZcxKUuIGgJC5eGVNuNOp?=
 =?us-ascii?Q?WhW47gSAUt83YPkuan2q/jq7vN7cDu1wg3oDF1nOm1PbSLO97o6ONeXFZLbU?=
 =?us-ascii?Q?LjibA0xlSKAOoX4IJAxLOYpCO3nTCBvp0k8AvfBjGMSV1xiUbmFf0DaWEkQK?=
 =?us-ascii?Q?mI2l+2BwcXfECU6ZbLQET1FS0TCmjpT4KbTvX5pMkR8hSKDS8Xnpe+rnLl3F?=
 =?us-ascii?Q?X+ExE4YfHTN9VneZli5RG7gYO2eyl+CW+EP0+/x4byrt89ATRSbAWRpZC9K8?=
 =?us-ascii?Q?s9ls581CY/ssaCAWQ2KsXYPZzcIiMFMaT+5neMoGKANlPiEAeXD7HvC77V7k?=
 =?us-ascii?Q?RiEgYsKO5PdHcEF6f1UligwRtmTUZE0iIQf4wov39rDVjKJBUgDPp4otu7SC?=
 =?us-ascii?Q?fTRXSTI4vhQFzYA8YP9QSt6hs8DQP0ohhYpUV16T24ODjpyQRf/tr/Ovt6g+?=
 =?us-ascii?Q?9SUms1/SUQkkHgswbDtEto/775qoOc/y2W9l+GD+9RIgSDLYIfUC/YkHyOCd?=
 =?us-ascii?Q?EvQqnIQO5WPKmV6cFlaNneRSBty22LggIB5xd2/VtCsge/K2rb0ze14QmjxK?=
 =?us-ascii?Q?I0FGJHJtCFtMSzzL7ewXEnwWF9/ezulX0hpcA2DF8x1xJBNJkxsyA/qshomn?=
 =?us-ascii?Q?raoCxxT4OAIryYt6jaVZ1iT11UjY8iF/v/pts/XeFT3sS1QYmGxakAz/Dv7+?=
 =?us-ascii?Q?xdBHGwBLMA4CB6YGkdLxEiQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b356e51-9cb0-4c53-6122-08d9d5b37fdc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:08:37.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5NTHhfPXcSImGu5UPn/V2RlLDvNvF9ecO5iin5RQwVWH9P4dAD8CdpL7wDkTx15HSg/G7qic5D6fnfNQZAttQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5373

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 866f88b27dbe..7fc229ff541f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2180,6 +2180,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2201,9 +2202,12 @@ for arg in "$@"; do
 	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"C"[0-9a-zA-Z]*$ ]]; then
 		checksum=3D1
 	fi
+	if [[ "${arg}" =3D~ ^"-"[0-9a-zA-Z]*"i"[0-9a-zA-Z]*$ ]]; then
+		ip_mptcp=3D1
+	fi
=20
-	# exception for the capture/checksum options, the rest means: a part of t=
he tests
-	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ]; then
+	# exception for the capture/checksum/ip_mptcp options, the rest means: a =
part of the tests
+	if [ "${arg}" !=3D "-c" ] && [ "${arg}" !=3D "-C" ] && [ "${arg}" !=3D "-=
i" ]; then
 		do_all_tests=3D0
 	fi
 done
@@ -2213,7 +2217,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2267,6 +2271,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
 			;;
 		C)
 			;;
+		i)
+			;;
 		h | *)
 			usage
 			;;
--=20
2.31.1

