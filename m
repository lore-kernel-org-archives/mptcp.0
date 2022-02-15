Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B61388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zbZFV/erLYI6QZrHQHjEqwm/DI9E91hhlD7Enj/b8k=;
	b=bty7BfmYgcL86pyjqFaNs4T6f5ppPf6LaGxQjbjU8p6vVaAuqqbFOvh5tNrDf4QNtNzbSz
	sKDhTj1U6OIVyiGWVbnwNH6BVNOQA8M03jKfKCkQ0a0Tf2M9Cmnhdkvv+xVdYFcyYlfDgP
	MX8tMccxM+5VKElc/nBP333DbmbgBDk=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2055.outbound.protection.outlook.com [104.47.10.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-uksufHY9OuyhC2Yjl-6keg-1; Tue, 15 Feb 2022 12:12:31 +0100
X-MC-Unique: uksufHY9OuyhC2Yjl-6keg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZR8yKy3F81cGk+xQ0JdmEthqGY4v6ONwY7KMi0ZwnF+8/4zhywiOqYlhC4re9Yb1/x3KJTJ6UKDO7zkei+MPRjQpOMxKBnMi3gOPntP2YEJ8Bd4HJuTA8xq4fKVP9ksQZXuGSyxn0XPZVs9WMd4X6CtBkinI/l0nxx43SWW6GaCqGYYU6YeMTwJpahuQTTW4JQonS80B9HQINBuS2oVplD7sU1O5r5VAZ+VWSpMDQnkpcbwszBA5SliwTMFx/s0wSNFWyyTSYTz8yc7lzyflgCVS4Lxq2x789LXsWubd+caU4g/IeudIbkn8nOIcqnF9uxGMC28U8mNwtTK8bGxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm2GbnOAbqmzQOzeV3zeYIaN7LymOIzug7wHvGhUnIo=;
 b=mcjT2ib3IjFCdfi+5d4DmS175hC2k2lPVXupXBz196Ng+RFU5alCwpYA80hSwijYmw0asj7J+g6sMf9jrGKkuvTkEvBmeFsCmdf+2qweY6pjiQQQy9h4pS0Uu4ky0ZHwR/KNO6M/zK8mY8SwF/h/GI5IhHCamfMotHmMJlRbX+F5ea19YSPc9ADjE5McW1sP+mOgh7hBs0LaRs9eE3RLudwlZQRarm0ktNT64VMoQAzrUTqNh1RYumMwXQeE+Zo1RCx6dSdaXnpQz3SEQQGTTES0iXlqwJgDc7oqqDDdGrt1fZSVXQYMeg3IzL/CC4r8MI9nXDFdkoC2FuP76rcuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/7] selftests: mptcp: add the MP_RST mibs check
Date: Tue, 15 Feb 2022 19:12:20 +0800
Message-ID: <fc3da2c8bcbc8ce8844a2d626c255ff97b1435e0.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ff63ab2-b853-4c4b-2ada-08d9f0740e98
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2921026608E7D8C63B64C7E7F8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KfHwhLKHPl6+V+1MubejtdzqUGY44Y/k4tGKk5LeCoev2j4qxsr/W5NfdaEZqDxAGWdDPsaAcid+d180ZRdb/i1fMXH54e2vJ/Zu0sUE+bjRK8YWTl3I0Kq5F+mOGdrIJAcrcFCMGakldI2tIv/OxETyuHD/EVwGwGujeBH2U/TWoSwPFQB7jy0Xum1AAv6+Kjp6B9SSuh9D4nIKGkF1h6AQQIkZ4mmbLUj7wFSdkf1mtsR14J29jCcZ69TgsErIp7CZcvdXEnaEVWwMs6BYEKYqCYseGAduCgQGisQyS+JJsNMro4DrKuhm7ix/8DZ0uUSatZSk3GLseZ6xGSRrgUvw9V3Wi2etNQyp6+pcYmlAZueGFm7a7yywL7dYmJv7S8Z5kzHRPT/SYWo0uTngrYuKxVRm12C6ALs+fIKQBFMLGHeYUVcvdmr5Xl/+0yQfN1hRRkoYda2vZaWbzhYDd0I37HxEillcpVi041q2gN0HY9Vpms2QuhHIJknKUTAxlYgklp5USH5fbH2qi/0z4rLr9oaWDpsMF9WxpK3L+uVGRA5X1z2cAa00TI1WqR7p+QgUaEbFB53lMRxkmjqLln9qfMfMA+G9FkD9ho1RaxsJT/VNyFRZ7tV3M3wI030Mu6+FTh1p1edPbIfhOjJOFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6666004)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jbs4XLbqtMQ4Cy5/X0YNm5f3auqgDKY16hffUHPRWzrxt9CSpjSLmARcgnD5?=
 =?us-ascii?Q?QoMxo0Wfv47oZmE/PrO2cOKsKAda3fR67Yz2USDnQKPRxnzggVwtfDFz9uel?=
 =?us-ascii?Q?+gYd/SzaHsGP1JKpybgQSQWknZu3VmzQ2t+YpCyWT/fi4jxiCYX4+ALjHVlA?=
 =?us-ascii?Q?90Ba0Ogml+s3MN01k4CreO9TLShiPEsczk7oCJ8scC0e2ZgGMCZuCSnrxX5w?=
 =?us-ascii?Q?RTN0Cjx71CvP2fNRdllpUjIPoQ6p6cHIlbigitlqcBSc0Ye0/dvusDMA5ZfJ?=
 =?us-ascii?Q?EqTAu1fq4aJuSYPbl+fzUcQ85I0q94CCnwHhrQpO24PE7E5ULSHRKqPpyQw+?=
 =?us-ascii?Q?i9zBBGBhwAg1pxizdWlDLP0rUNLfTczuhLivbB4dnnFteZUWFrGRTgW1Sy7B?=
 =?us-ascii?Q?Fms3i+7amQRHwb/1t3xODqsaLuMS9vImdeNML3IWOpBgFFIwMsVVIk/AJKe1?=
 =?us-ascii?Q?NE29e9AcbnA+Porlbeer7WJc3GYgm06sbmHO0pFps9juLRI+/VC+oLn510Ha?=
 =?us-ascii?Q?/1EwLULAcyqCHHtgQotFd4LFEIZTXzckw20pVEgG6le8iC4kd6Yze2UlmTeh?=
 =?us-ascii?Q?bXFAUVlpkV9PyHeBYxkn8vrDiVP4wife16rBlxHrBdfdG7M8oOhkOSO8tj6w?=
 =?us-ascii?Q?q7c8k6DTJQMf90UfuLGH/1tSZxousEuOWWNnz/q9NFV+5R9QnikM//K3oI/f?=
 =?us-ascii?Q?Mwj62DGVXJJYph7xfT4GvUPxQb2R3jelB0ayeWBpi2vtzTMIGvDk+WgiqMC8?=
 =?us-ascii?Q?Hia21hU44iWZpjXVZEqeNrpMip6/BK884FaEf2i4xkKTN9sH9nHrky0p0LN6?=
 =?us-ascii?Q?8DBN9a/mSkMkb2eEfcm835/2t1owG+ivw7+tN3F0LFi4KkiagjkJ95oB4ojR?=
 =?us-ascii?Q?MYrwpcQfUVfIFkMVVBf8p6LCod1IkWoUOjx+a1RU5oHge+MXB/K7hStuDI9K?=
 =?us-ascii?Q?MhXAM9QLc8vJ44PzhrOmhwhaYmAv1OnjA/jkkXF66DYLeOZ8bQ5UIDWmeuxp?=
 =?us-ascii?Q?IqMCsi//wLCxsHmOHFSRVLfzMzb/d0uVPb1yA/q8rlPKnbfV1WvhZrzU4HTa?=
 =?us-ascii?Q?x5vhVBNFG9aaePMy9Q8M1WlIOJmaCe8shK3pHVkPxZbDSEFAiHjY/VbEGx6m?=
 =?us-ascii?Q?wm6IDzgB2qk7ZvlZD+DHdBiH5yyHNN/3diVbCwN71RLQR6ZkBw7ALXXfFgH1?=
 =?us-ascii?Q?UYce8FtfT6PMIaTP4KfLpMqjadsEgBMmxxeEwX4ffJrznSTbJXR0UcFogbz1?=
 =?us-ascii?Q?MLOOGbLGil/+090owc8kVOfDlU07kLx7oiqANHtVcCUjkbayHGMnXD2ppBPI?=
 =?us-ascii?Q?lqOSu8KLWpXx/mgMPtsDNpQFAPLot+OVa7NDwDiX+BKuN3BQckAaXKqqvWls?=
 =?us-ascii?Q?Usgi+75fsRjnBHhYEq6lauBvdwQN8L5pUtQk8oBbyazg/AT+y9pk6cm3wkEq?=
 =?us-ascii?Q?ZHxok0HWqyatvySCePNQ5umfHFUAlwTQs2sXNO6Xp66dGJMqC3110RhU/ctb?=
 =?us-ascii?Q?FnYpwAIPFjFp035DAOGKIjlnALarVcyWdXqRWpVojkgTSxJCp1uRuk36ilBu?=
 =?us-ascii?Q?2JAw4MMSUqAOnPDFcO+MuLskzZi9RCrE8ZMa79piNEZmSKpOiq6enOY6l3MV?=
 =?us-ascii?Q?EJ3zGGWtrm68Cm5LLG1xvZY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff63ab2-b853-4c4b-2ada-08d9f0740e98
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:30.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SQNZu0jzaH3qTAHpHsOjHG534v8R/mZA0Vg0ZhT0ab6Q3meE8FTy9wlOi66o6h2ZuV0R9oPeFXLXSzs0ioPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Showed in the output whether the inverted namespaces check order is used.
Since if we pass -Cz to mptcp_join.sh, the MP_RST information is showed
twice.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f71494b87d5e..3252865352f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -802,6 +802,55 @@ chk_fail_nr()
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
+
+	if [ -z $ns_invert ]; then
+		ns_tx=3D$ns1
+		ns_rx=3D$ns2
+	elif [ $ns_invert =3D "invert" ]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
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
+		if [ -z $ns_invert ]; then
+			echo "[ ok ]"
+		elif [ $ns_invert =3D "invert" ]; then
+			echo -n "[ ok ]"
+		fi
+	fi
+
+	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
+		echo " - invert"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_infi_nr()
 {
 	local mp_infi_nr_tx=3D$1
@@ -920,6 +969,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

