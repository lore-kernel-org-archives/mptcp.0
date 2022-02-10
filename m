Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F20B2C80
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644472835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj5HhsN4FBm6qCeTR1W9NK9GCfy0YFPY4neg9Svftjo=;
	b=Z/sMzj56VjQ7f3qLUdM3W0+54xn33kT+zNSUdZBGWDVkGcvS02OJxus+HtG7YNZEUhOSWq
	fkMKmzkNO/rDmglinLxK+WK8pJqoeSnsZBa5xaMik8p50QdJn1e4jgtqE/pR/1Wogj0Ot8
	grhdd/XomrweaFLsW7LRKOMVEURcLzc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-P6forDPmPt6XTQ0yTlFGmA-1; Thu, 10 Feb 2022 07:00:34 +0100
X-MC-Unique: P6forDPmPt6XTQ0yTlFGmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmoDsERKfVcTS5UhhhL+7PtfNXVVWF4sqJB0SGX3UDC3snRkFEknVnKyfjVS+Ceg/IEQiBpYBbaB4eUICZYvCFqV9Kk9L8ByOgJsLP1Lcd9FysLlwODz61UxBLZArOHr9yGaM7lRxMI6Owz0dpA8hfNlo8Rw2bBpzTV3EF2kgZDdpBUS5yjVWtSJQDm9dZvszuhmu65vFPsXAkE7U1m8zW7l/d+tQrFn9KmKGBE6x15Zm40yLk44sVEAacOxU2zYwoQp++2O+PR5nQkwbWGgzYoNU+vX7NIfvVImbpMkU+OlZANuArHrL9tZW7x0PrYUMvxjWxTkb/7dDkJ4/dCDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIS0iiWvzfWJ9fl7EdkrYPiYbDH2CakyGvRIkVWp/kc=;
 b=mLNyj6u6gbupFqeGH9hDvAytaQ4tRru2YiFKe/hUyg3uV5Vr7OhOsRGdMEoEDlJvcGwpiQPnnRd5IGx41gGuCghBy9Za5WLwWk87+yq7pQuTMmE0R+9lrdt+hrIKXQfjonofgmCkYyJ7qPX01aMLaICvY6WQCErikR+qGPpWXrL8g/+W2eluin7nLOXNgRUp60Kr6Y0PG4TNFjHmASvBPeDKHLX6vW0q9+NRij5m8FM9mR4RanU80koI7DaABR+dh/yj0FV4bAnN9C0o7KGLXWrCXef9iLNKwwLr2k04qAsC9K8iMN+wEzSIk/YhK2OoJmLcvQ2OqDtkfnd/XAzoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5761.eurprd04.prod.outlook.com (2603:10a6:208:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 06:00:33 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b823:3668:e8d8:beb%3]) with mapi id 15.20.4951.018; Thu, 10 Feb 2022
 06:00:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 4/7] selftests: mptcp: add the MP_RST mibs check
Date: Thu, 10 Feb 2022 14:00:28 +0800
Message-ID: <3884c70570fe577fb08f31037643f638c659e0a3.1644466571.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644466570.git.geliang.tang@suse.com>
References: <cover.1644466570.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2138d9f4-ee3f-438c-41ef-08d9ec5aa6ac
X-MS-TrafficTypeDiagnostic: AM0PR04MB5761:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB57611348B2611F2605A05C9FF82F9@AM0PR04MB5761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OPRH3/jk+KhFE/msu10nDfwyXnPPVdtrrXiNeJ8Uz2/rabBvFJF/PG6oFWVhsfuGoPsewxTUzhzD4OYkOwEB4reqsEMeGHAqFhVd917etpnWROU7Z9VX7NAVST2PDCDGFtscrr8yQ+Gr3rf62SVARQHUKPLHEc5eXhasQiAtjsdjhyzI7m12IEYUdIiBx6VOtsDAeQ5oDHckSpJekidoYOyD6MXEYONuR6IEINKXnDvhbK/x9oXYt2sCyu8Za2EgGWq2TM6MD3t7KdrE9HIIlXglt3OjC0BW0uyllvJ/p0UZF8g7BIfttHoI2QWAQ6IuPghyluRm6tG9vFnDUDRiOVPeCG8e2nN5eT3himcHVPZKVi5lGHcVvOd5TSVMVNSkiqaRzpIGCLCvqhcf2hrxFk3mKAX6cryRItfTfEP8meuwjzR2a/yHaUxoARf8737FGndmSMhEJYXOdVfR9d2HD0nmxzdBv0pv543zL71GmunMrqXHjzvrY90u5VszB+vFuThaEKLmXU5pvnoZ3G3v7O6JEW/quXQZZGeUpObywE1YQuvv8oLcYDyXb2mGvZuTgIatgTT/7JWkr5rkHb5m9Lz/KcEG2sA/2LIlwBWtq4btDL5cH+1ysnZWV/nwTLUo8jMzMcfcYUq+dKOruJCXCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(36756003)(86362001)(55236004)(66946007)(6512007)(6916009)(66476007)(66556008)(6506007)(8936002)(6666004)(8676002)(44832011)(4326008)(2906002)(508600001)(2616005)(26005)(5660300002)(38100700002)(6486002)(107886003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLQq3TpjPzrGHSurSvua05U7Ehc8cMHcQWfj9hkEVNsGQEyq/q6ulidHA9en?=
 =?us-ascii?Q?26gk8GnuCRL1bfFLBJnaD7ZfA613F5joGqvjM1bu0D/5QtBY+R/Og5Qc0/+4?=
 =?us-ascii?Q?qqd6p+q2Yft/6N9PsujPM192viz9jVsR/L1QOpgIlsACM9i3zOPoQhuEeF1n?=
 =?us-ascii?Q?CArFVOPuFH/2KqkPxlQj85cCShFv94rHYqElWsOZ97FgPeSJl+TJe+mIckbS?=
 =?us-ascii?Q?M0rmxMBP4DvrOx/3gJIbNK3OricXfuGWnaCeb8QOuZPvlrN8f9ec8EChbw/O?=
 =?us-ascii?Q?GEbP2ErlDFL71wK2mx1lqEX9XRGAzpmmdAbfNI6VN93OaotyrynfUlmPurO9?=
 =?us-ascii?Q?UdQ0/GK0sSAod+yM+Huh5Eaxmd4EQhpdaP9inZKRlWwkwcIE2Jju5GisubbV?=
 =?us-ascii?Q?oRH1euOww2zxENAYea5cTe+y890i+O0rIkVTWe3tc1wd/yZ3Etua0vreo0Th?=
 =?us-ascii?Q?aMyejrGTjhiYKYJ+6vhTP5+IK5WCXkwOUrDJ5DOdSpX1DWtQ+4lOW2Ln8gsO?=
 =?us-ascii?Q?tdukZVVZdV5XL7aDQJ9k4CXzqUIVP95grcPL2D9icjbfDmTUTRyngGox3gjw?=
 =?us-ascii?Q?MVdYybSiqnSviySF7860r/ouLKsf5eAQa/do64vebtpnfBsVz9QJ1SDndrss?=
 =?us-ascii?Q?9VWi3sjXDBW2Pl6I3admD9qZvJFI0FZHemoh1DAYjJqrLu5uTMoVOrUCOWj5?=
 =?us-ascii?Q?E5NJFwUc3dO3cHAhyYG/duEbzaZL4QyGWuGPVX/P75mfW/0YARetOIcx9Q41?=
 =?us-ascii?Q?Fmqdtoe7uZWD2fvMuX7aARYXLcMWArMWoEvAdl2HAw2CezchIPdBgrEnOaSZ?=
 =?us-ascii?Q?/4uMlvaqSEPbXBeNY+VmHsVKStMbv55CyHIlQcCHFBUxjxbKAUcHzl8kbviJ?=
 =?us-ascii?Q?kbsINfn3WNObGlt5Bo0cbmQ5tv+e03peOhW2sJGhe9Xb+jX2srwfXionF43i?=
 =?us-ascii?Q?6XT31l3NK9hENsFBcXImIZhUrWksY3Q4LyfuGNuNSEpk1l8YS8C3ZcB0tQJo?=
 =?us-ascii?Q?IY1LVNGvSK7vR3TdXuNkToU51c+e0a1S6iNW/OEqcOXQwqlBqvWFuO8SIeD5?=
 =?us-ascii?Q?HmhPUHdSjiDSJcNtctTHxncztCcFJcavzUHgFK7BuIo87RX7UMnpLc9xndSC?=
 =?us-ascii?Q?TE9FtP4Gw2cCKqlCCAK/He7ZIl8PBwZ6grN3URmLr9q1mttNDndl6yDPFQG3?=
 =?us-ascii?Q?x5vo13rO6P5NDk+ZbEPjqsSiKVl5S28sQcBC67GJnQ0F4JEmClJECkuqwZOQ?=
 =?us-ascii?Q?/thAf68iJKjWZJwjfqFTBTEbgk5jYjCVKT5ZfGLtcB6E94sPEriq4SJuN07t?=
 =?us-ascii?Q?Q87q/X3jfqZtcw8sMfumP8iWvDd2kL3Zzadg3SDAkffKBTfxV6TKVlTmzu/3?=
 =?us-ascii?Q?145VfDMjYNm0RZBdtk9NedQ8dXk2QiZWZI3UHJF2nU2rZc02ADQRt3y5vAvp?=
 =?us-ascii?Q?vvTQj8OvIAFeMJY/ar4Q7VfVEP0uuKwq15CiDZqBBD8ExPSlm2H3wRYWX01h?=
 =?us-ascii?Q?4q/AKDvSSo7E8ZLHhsNsUukzCLKV+V9UyLpuGxGrg04DQh6USjbwT1JpC0mZ?=
 =?us-ascii?Q?SmKyMD+GvQVahF40Aep1Syd+kq3Aau+SUO57gmi+deCOTl57OwAEKub2g/7R?=
 =?us-ascii?Q?NqpbkKztcS1/gBOsFGJiPNM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2138d9f4-ee3f-438c-41ef-08d9ec5aa6ac
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:00:33.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yw/0rNbntLHxu7JVsC0fNYX3SwD0bDg/Q7sc46L7faF5UJlJtYw0FdLpUUgbgcBPurpcLQu8NSp4z+TL5T5i4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5761

This patch added a function chk_rst_nr() to check the numbers of the
MP_RST mibs for sending and receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3577716cd5e6..95d61c97ccad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -782,6 +782,38 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPRstTx | awk '{prin=
t $2}'`
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
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPRstRx | awk '{prin=
t $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_infi_nr()
 {
 	local infi_tx=3D$1
@@ -859,6 +891,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

