Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A0158E
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644943116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ymyJFBrhdZIxUHztzUNS4Fg7XlHyd4F64HCcUvOadM=;
	b=OTzROg2Y3EnstL43uPHaAmWRdIA2gt0es4k7rQLWhsnclFHJ/G8FgHOs0yZK9iLeT4CU+R
	omDWCz6iTnjf+HFiPixtuwM4qu5thcD4XhpdOtUZd9SBuijtSD70aCdAc3LwPlz2h9mvEv
	LP7zwwQ4brR8XzikxTwfXOZfAkhiI2Q=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-Wu1FiCacP7qJU4CTwpJ1Wg-1; Tue, 15 Feb 2022 17:38:35 +0100
X-MC-Unique: Wu1FiCacP7qJU4CTwpJ1Wg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqdsU8cLVA2280348D/9ZVU7cGFK5OD3SdVD/EBjaaQmNZmngclcKS7qXuvEy4Nh+rpNkn5s6P+ZpzFJqpp6P/IACK1Ls6pH1jlbi5YBd42BL2k38J7nH9tZilIvATw3GkYSB1cBazghNBqk0y3CNhe4DrrLH1JbathYVaX9mkqJiQqLGvaWhS7lbPTsiEymWWPFB1gcKHJOuNtDLkRrsvxEglsvhxzwwv6WaKxPVagNqi+rHx7kSBmXhD8U9/76Cq+Iec+xqFszISJoLlU1fw+BsmR+Gpma0jGvUGgXyqGArt/YpQB2SkqQ8e3L0LliuAly1FJeBLBos05dy/pMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfXWomNjSlm+rljFO6qG5m9uhHK7ga/6ZKFQnYukckk=;
 b=cQDCWE8rLBljEHPE+/yWFHPYegaCCUhnk1TpllTJmDczXAkJofAsb+c7tkqPUMT9vH6JE+NFf1uCWHQzJ7wo3XNM1xJAHTqa/HO2QebjCwqO46MfzLiVc38sOZyku/4ds+yVS50zmvBlCMAe+E1B6/PiUbZv3UT1eiJZpW7Mxcv06y8gq7dA/6uFX1k8LPhYLxfcqgLo/QRYawWMXxvBuJgxBYKGPU73m62b9ZRNa44ufCUkeCVGODHgh+lSTK67dwPq7FM/grmbJcO4cTExCq7w6/8wgSuzwE/2rBhUhjgzrajeQYerDd7hLVQwIe2TEJVbqmYUM7fvKiGh2pvc0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6118.eurprd04.prod.outlook.com (2603:10a6:20b:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Tue, 15 Feb
 2022 16:38:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 16:38:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add the MP_RST mibs check v3"
Date: Wed, 16 Feb 2022 00:38:58 +0800
Message-ID: <b7b9be123617f380bc1f99df7656ca60978ec723.1644943112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:202:16::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d42d42b7-8b32-4d72-76b6-08d9f0a19b8f
X-MS-TrafficTypeDiagnostic: AM6PR04MB6118:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB61188D1B43964462FA5F1A3EF8349@AM6PR04MB6118.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LuZmV5mCaBvmE7t1DGVQ2PT6UsAAII9P+9DrfDG+6r/wz9VyVoXifiGCMDAfUMZppCAnvHdcozefzCxwp/LTTS2VDG1QLSEb9JHLVNQstpwzl9NHBhjfxEvpL2QjicF0jPBY8NcR8JySozbp3Z71nw7r1lcVwZaeCFEp9K+Qome/px+n1epUEb+ud02FXduF3I8tOkfcLqIu40Y6u8szGX1fRF/I96M+sRZHTU1JefneSwoa4hNgPWggmqoVWh0kY8HntBQF5RFHJdILyHbeQy4U/B7nwH3OU+5C8UsAWnzNeGPuYKEfZpf9B5fjhS1wOzubJJqSSWyjTdYBZP4Xk4WyNCtOR81V+HYEbOd84cj/fbOdZVl7S5JrQNKuSHE5QDViCii0rwyXz+I7pq6PzHWYMz2VscnqrI+sY7oCstF48OvlGcR567BHSzBi6ffQ1oFk1rwUUW61jokzoPCg7+tzJmvIpqSxhagE7pOxlP6N4It1oKDHRX1CKZ+y967r0z6yA2a8p8+CfpgOx6dWiYHzQG1pWGe/POQAeHHWiEWiDVFL6stbALQVs1M+MunkGohfywtb74Mc9E5yxgjrxgiF/a60kAp7wqVYp5Fz86WdeL9jIyHZ/gMS5ZmWUmdev6JYBR9nex8ToF1tbLxg5g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(107886003)(36756003)(6666004)(83380400001)(8936002)(66946007)(6512007)(6486002)(2616005)(6506007)(38100700002)(508600001)(66476007)(8676002)(186003)(66556008)(86362001)(2906002)(4326008)(316002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qwxNN3z4ubdfAMwowYdcyo0xB5gPqWSt6FBEdhAXwK9enhkCtNofK6nrj5s?=
 =?us-ascii?Q?l0sMmKurx37Vh5sjbjS6JQrtWR+5qKd1VyZTJ96YSp4xQWRb7ZODbMSGtUHL?=
 =?us-ascii?Q?i8TTpw/bptWH4bvJgBDuWPqA7evbd/CmzpCjau3gXOmUjjSkWqLDx7+3v7f/?=
 =?us-ascii?Q?E3o5GtEWB9gl6zOXJTwNQPfov9+6c7UpKx7ZRY6GmzuEeIsUzrIY8buicr2R?=
 =?us-ascii?Q?aApxsyEMRbPKvvgPXt5ax5guS127jXosXkf+yRmKr0FS8d0+i4mfTt4LM8Ke?=
 =?us-ascii?Q?QB4UoYa7d1q5osPBuR0ntSGtqofwsMUZzt9/ZwNvGw2euhtJtNpdTWLXP/fW?=
 =?us-ascii?Q?9kqeideC1iukYwjM7yfh4vpMOJFNr/MzDcTnIk+F9fXBGfzedTNxDbxGgG94?=
 =?us-ascii?Q?FAShHgFgX2/rpNSmCnun8jbHpqibMZLUUADvswX6YcIL9pNhvd2NP44/6I5U?=
 =?us-ascii?Q?Oj+nH+SX3eNCOpuMZ9zqTICOtZ5lfmPZqXdHx4X4Rm6HYVy5rhsuO1isZXff?=
 =?us-ascii?Q?muTAj6siMqIV+lEDC1ty7L2BmLZMnxg3Wzcyqa2RkcHERNupja2eUVv0fJRt?=
 =?us-ascii?Q?85f+s3xzgjQKwiGJtVRvCJXalA2KMzkDRZ2/uicsvJVNlmsTGqlWqsHjvVhu?=
 =?us-ascii?Q?6zNiiZVhX+NIBsRW7rh/93blz/FcGY1OUbTiCjG4PZqPhgfeITHWdYIWZDBU?=
 =?us-ascii?Q?yuiA5kdXo4EwHBuL6YjeNG87CxiEqgQDmbBy4f+O1C7FXrcetgyaCnGCGEbd?=
 =?us-ascii?Q?btjQdYDVE1sKuF9pRmNqBied2KJjOSXWlf2VE0YmiyihIAAtBA5fDNQRBhem?=
 =?us-ascii?Q?9fsRqJhOlTzvN0SkJ9lxoWqxiVvTA0V6DHpMco53PgstiAnI/WAdW6yFoTsM?=
 =?us-ascii?Q?TVJ1Zgs4WH0kCIz7IXdM8vYX2I9mc89DcmBOP0GXK5UCP8e4CEP9VdNm0oaW?=
 =?us-ascii?Q?ZrzmO6aNZNzJl7YLe/wGWOxVPI6POHRn/z+/1JqD4iXXRZHHYRBYp9kf1/GQ?=
 =?us-ascii?Q?Si4Lm2k3i+gYKI5ZgYsqlxSV97bQnfp2PvJBEuNo4RnLhoaJr6vdRaYxUZc0?=
 =?us-ascii?Q?XqW7BajiPdxgmtYLRpL0dNe0aoE8rErBm4X+MCEh3kiLbciesZB/OGe9XCqQ?=
 =?us-ascii?Q?fE1+UlQEnZHf+8P7AA31HoVsnrHzy2aXdvni8bW+sptB8luj4waEUhe6oDuC?=
 =?us-ascii?Q?txJi2rjD8rdwu4SbyEFMdVhZk8aHtLtlZbLNTQiZTu1mm6yBcSiWwQhOJCfh?=
 =?us-ascii?Q?Cw3f282OLPZZn+XEZwt3DSC9ORrpDqZnsaTAKhFyScWrab4+4PATJC5aqxGr?=
 =?us-ascii?Q?eJa2sL8emNBFet7AEQ1nVUDtvnNe6ACNl5gU8pmXTjN2hq9hKF2xlZDPMDqs?=
 =?us-ascii?Q?8qDFZRbPkrQrrOLQPXEnr3P7opPV68m1fV39WEse+BNt0UDEPimnofO5WLJt?=
 =?us-ascii?Q?VMk90h6iZDmYrjMr2o0tHvmCDzwn+/4rt88z4cO7r+/xvZAMRtPRE/5FU0zO?=
 =?us-ascii?Q?Vz3/KDUdxdIF73WuYChdBrLBXwzC2bRx7lHGV/ic4V83f6yUZcTDPit8qWv2?=
 =?us-ascii?Q?ugtQL2obgbkN9c13W1qUlXkMVu+BJ958LPtdN1M/vUh0lFS9ljqapEIu+tWz?=
 =?us-ascii?Q?Mm7pPN+rJ2ebr44udqjjTz3s64HIXwO4IcWoCbPNKuaMCnKhv9gcVqVzHuz9?=
 =?us-ascii?Q?iNG3SYNQReM9I6IbKV2j2FfiwUY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42d42b7-8b32-4d72-76b6-08d9f0a19b8f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 16:38:34.1313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjVRRNj1ra3TPT+oWC9NJE2mtNWBgSBAIZRCW9PyIKt0hQHFiqWp7AJeJXHUbPREWeC6HZmKrTYvHCaV+Or1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6118

Reflect the ns_invert.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3252865352f3..5a9b351a5bdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -809,11 +809,10 @@ chk_rst_nr()
 	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
=20
-	if [ -z $ns_invert ]; then
-		ns_tx=3D$ns1
-		ns_rx=3D$ns2
-	elif [ $ns_invert =3D "invert" ]; then
+	if [[ $ns_invert =3D "invert" ]]; then
 		ns_tx=3D$ns2
 		ns_rx=3D$ns1
 	fi
@@ -837,15 +836,13 @@ chk_rst_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		if [ -z $ns_invert ]; then
-			echo "[ ok ]"
-		elif [ $ns_invert =3D "invert" ]; then
-			echo -n "[ ok ]"
-		fi
+		echo -n "[ ok ]"
 	fi
=20
-	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
+	if [[ $ns_invert =3D "invert" ]]; then
 		echo " - invert"
+	else
+		echo ""
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
--=20
2.34.1

