Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF192C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 06:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641536295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gCBiVMtkBvcRr/u2RQomgj7ZbF31csL0J5PCdPL2CN0=;
	b=b/3hZzLcRuti4h5DITS9hiFd2wPuBeCKfFYg4SLABPv7L/LrAubQTpVGdQ1ucVDLOl7kWY
	Ok7xMexPw3DICeu5OnAi0Y88a4IfuIVdOoRu/RLdGL0FlB8miPLxO/VC+JRH85vO8DSsaG
	lRzNkWmqtM6LubWQ43WSGgj7Nw8M6uU=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-bYl5kFz0PIKd4kxz0NW0Ug-2; Fri, 07 Jan 2022 07:18:14 +0100
X-MC-Unique: bYl5kFz0PIKd4kxz0NW0Ug-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os6f+daGJEFDSmrEvW/L1K2XnYCvuLY/K7OEnSJD9PZ7gSz8EJFBPY8p9A1lUrq+qBK8W0CmzyVdD6cBGr7kA0hK7qddZBFE8SJ47iuDesqDxIpR2wnzCWUII8DOwcrP9C8Ypp+dZ01z5+yVuiOJGX6GEMQsIumY0swne8dUczpIvAdCq6gkzk9EqhZfdKNLzHn4z0WMAPLUWCNvqNqldanF0LsrfpKqo0ZCG4+8eXh1GTvK8vN2iTVscOEho+Gi5Xwx8BUgFlAaNpnMeBo+w7HPnHeR7lUKiYHYPOWDdSDTJx0NVOO8laBVOYErIDOez2FPN+I8CjGVeld88CI7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4QdS9Pbzh2AD/ZE1TDdoQXRZgE4cXYaWmu++ZQardE=;
 b=QU2VfetMbBVN0/iWRV2gsseaGIymg73M06dV8qTpbzCJeRwldi/wZaBDYPucR7q3Izxpxn3hyIL3LsWblZvD51KsM+tUdAbWc/u0AkHdbGd7iXnuGrP9D53dh2FGvmWozmvkCTrB1M1PIn2slerTkeWq+MphgnSmxMr9iJ8+gFI4Q8UuYnjrQChM61mgXYsnaZr7V0Q+3YPzx/sxNi2PKjoX6NddaCNgQVoCGOG1lNmYeQKR3rp8SzrwT5/7mlmF8N/mYA2mt/kVxHyP8tvBVZz0ZUhbA8x6JWceislUx+Syn2FrmN8oAfEa9ARgdDGYCLyYkzYDXXWuFpyOyV4TOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2540.eurprd04.prod.outlook.com (2603:10a6:3:84::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 06:18:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 06:18:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v2 9/9] selftests: mptcp: set ip_mptcp in command line
Date: Fri,  7 Jan 2022 14:17:01 +0800
Message-ID: <e97e4048894719903c2478eca6126c25199c4ccc.1641535880.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641535880.git.geliang.tang@suse.com>
References: <cover.1641535880.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0160.apcprd02.prod.outlook.com
 (2603:1096:201:1f::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5ffc04c-eb70-4bff-da2d-08d9d1a57bcd
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2540:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB254006F1032D7C7C7D3A3DB2F84D9@HE1PR0401MB2540.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mzzgm2zP7zFlKMGMNxkFgOCHJKdi7dCcprrYE5SLVG+27mqn6BxDtIgiVOlPc+Sdv8AeCPy/Uqu6Wm7BCV24P+ZZb381iPhu9zKzdsE764My9WtwczMYwkho9No3t8+Q0fVju/K20eSeo0QAFd/+RTl9aTeslJpeUqF7Y34GEBzsDlBdzG+8RPtmkze1DSVKH+5fkC9Kt8HhGzPhpwgPnmMvjB7Kks/6FMbClEwowDralmfu2jp0jIgcWnb/cgXoScvkVWB+VZSZkvpUTMn2zOM1CdAy75iVv3sogzOPN+VNtlDg3Gg3Nz2NwjtM/JGpBBXCBLMVGyzXVi/8QWMartQHM9GrElL6bE0ZqaE+wNUlBFFYFqweQ1QxwsgMPOSt3P28gnv3vGGH0FNQt8Fn7WmphEXZQVA6+6Kyrb5RZ62tQVoF/NvopQ1jNGusVB+Ho4y7K/EpiCGJbHL657GirR4MtjHCbQ6D4PLvBBiPnezndxIczlo8DhihlEfCwcC3Mn3kPE+s1LmVH3UgfxTQ8CuV+Pd7HUvpEAvtbnC8YKJdcIaKZWtIYDbg8JuNDouAZ29UDP5khhI5DBM43saHpytLjY1GL2Ls4biTAfYzdny5S1uKezC9hSCzWd7+l/yUlq47QZ045FFRlUYAx4+CTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(4326008)(66556008)(2616005)(107886003)(55236004)(38100700002)(8936002)(44832011)(66476007)(66946007)(316002)(83380400001)(6916009)(5660300002)(8676002)(508600001)(186003)(6512007)(86362001)(2906002)(26005)(36756003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fWZZ6UxTD4UfSvvCGSm1N44XUabMxbfaBBnW10eeouw0QkaIc/c8fiuCilyK?=
 =?us-ascii?Q?Ynmc4eyJe5lTDxSLtSUKMCDNqcyh5mdODhukymj9+FSNI2krINoKm9+qsIUo?=
 =?us-ascii?Q?3SMaLgX6w20K26HGr75OerH7IeelYlTEO9TRxv2J/BtaqRjaxuJFV3hiWtWT?=
 =?us-ascii?Q?DWki/rf4CFDA69K4kbDxc6Iz5wEYyR6RCxCowN7HYr0vAA8xV5orY3M+96F2?=
 =?us-ascii?Q?BNslpucjWawmmHFK5TDvMU6O1g3iMfvD8UHNv64b75gl1TsH3Ff0CexikjN6?=
 =?us-ascii?Q?JTV8BMWArbwTF00X+qXCRnHEUYP+dD7pd5B6i57WB6TDigtHu9TiBUqyl6/x?=
 =?us-ascii?Q?IxI8+2grVpzsyaeygSgVhPUNKgBjFEJMin4kYfH64T0NZsbupbNWInjfoKO/?=
 =?us-ascii?Q?zLQ5NY3yEGRY8PwEkmtPeC9CoA4++uHDTawuPl26xqCjLj+kWNe4tZhpqSGF?=
 =?us-ascii?Q?mBtAaoSLtgfrlLqDgZzYXE1XgsPNINxdhhahHjo4UQR/UFF3HmQ2LHpP+FAP?=
 =?us-ascii?Q?iUUlbFchfu8UOyeOmoZs6bEUz5632TixbDUr1J4rO0QxgKiHacJ86ol+Nktg?=
 =?us-ascii?Q?6x2wsZCjRbFjGrQHRb0/V7DNp+wFZDnQ4fgbmzWy/u8FHHwNAOZSeQYkhi5F?=
 =?us-ascii?Q?DdDfQuQWGX1c5cgJXDkYh5cDn7wkDCFs1OGSyTBTS07OGw7iouYQ09m0dXpS?=
 =?us-ascii?Q?ITjsy5+8MocXy+UMXNsqMTYsLluAC/423oV7SEJxU4gu2TGKTLRNvJ4qeYV1?=
 =?us-ascii?Q?i4g21B1VnOEEIqgvPG1bAeJXbToBOtPwF/+QOMUtKBcLIZqK3+1Q1+tc8jLN?=
 =?us-ascii?Q?joLkbuVSKY+cSZh00LtCXLcw0e48urfA3JZ8UinN5MRxg6dnN+gtWKzCJ0cI?=
 =?us-ascii?Q?gFVXKkHvL3na6PUSlllJxnOng7GNDe8LCFP3Kc79gOHRuEYGFI/dn7DUa+Gj?=
 =?us-ascii?Q?ZIgbz3r95M0/GziMgMFwRFzgNFl8QEVUgNsrYlMdLpNKULzp6KQ/lEtIlU4H?=
 =?us-ascii?Q?/DQ+G69H0UHHQwTrHPQjcnWD1qYGhHm/fpV/9ep7+Rz6e7e7HIbBi6Suf9dI?=
 =?us-ascii?Q?TAqSIHmPOQhUXev+76zpXAqsMFpBt9u1oYXq5vERAobo/O19iDluT3KsV1jw?=
 =?us-ascii?Q?t8EmOOIMgBKKx8Oavqn1p3PBnVEFEVfqjiMu4pslFwptXDyTQaw6RN44eWrD?=
 =?us-ascii?Q?TJZj6k7zheO9G6/UxTvcYa684/vMjXnE8DA31++pJaX0rP9P8DM5kLW6KSTm?=
 =?us-ascii?Q?lx4kCEE+t5AieZYAGzK4sL5ETdeWcqSR1So7ZivKLp90GK1RbT6UgnsnVM4a?=
 =?us-ascii?Q?EGiMPfiRteqAEYsEDp+hKUPKou5JLlKSzNFBeElLVR5QsokZ+LEV1Kdsz7Sy?=
 =?us-ascii?Q?fzGeJR1PvtYkQ15GGhwxjZrNCluXV0dw8OuVakqs94zdG/6fExpi2qxIYwOI?=
 =?us-ascii?Q?/4cSJR8P4CS6oQdMoIyH7VX8ccR+Hkt3+nut1dBD+GfrxSM7sL8SnSjBFkfL?=
 =?us-ascii?Q?yKc7ZdW59AsT6r3WhqNK2+u1zdOVLSVM9pE64gRZ460bNmZB1yLGcM39Xv6s?=
 =?us-ascii?Q?2B1UcleaLMUp5iCu11BNerCmCKw+hZmFHoyM33sByhyiTnE25dQIWQRwvbie?=
 =?us-ascii?Q?lbQnRMbCiIFp4r+GGIVcf6Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ffc04c-eb70-4bff-da2d-08d9d1a57bcd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 06:18:12.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3rKpku7yn5+AIzFGokCqffYsKNMqcrlUBG+kHv3/n7u8BPcKjkEgZaQuuhqb2NnMXcDggSdoACf1vZBFPLBqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2540

This patch added a command line option '-i' for mptcp_join.sh to use
'ip mptcp' commands instead of using 'pm_nl_ctl' commands to deal with
PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 8202c5750c33..7ceb8ec11f79 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2152,6 +2152,7 @@ usage()
 	echo "  -u userspace_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
+	echo "  -i use ip mptcp"
 	echo "  -h help"
 }
=20
@@ -2173,9 +2174,12 @@ for arg in "$@"; do
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
@@ -2185,7 +2189,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
=20
-while getopts 'fesltra64bpkdmuchCS' opt; do
+while getopts 'fesltra64bpkdmuchCSi' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -2239,6 +2243,8 @@ while getopts 'fesltra64bpkdmuchCS' opt; do
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

