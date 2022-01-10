Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142D2C9C
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 04:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641790046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4UV/dZXRCc33wGdh93hlLMmCHed4aHA7x+pXkNhBIDk=;
	b=gg/ocTZ5rOnoRmb56t5FBE+XLw2ttzF022btMRQ8tK7OMyVChFW1iudWSYPl7cI5MbeAdg
	BxbpnTicI8nEBdnZ46n+cPTfDEMcSJHgGk/pYqknV4P9YWZF2dXxpICL1kpxQnVIXWCAry
	hJRWRFoAApUMYws8ct9hiGdnPs5LQoY=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2058.outbound.protection.outlook.com [104.47.1.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-1xZULfrvOdG6pUGMvFYaxQ-1; Mon, 10 Jan 2022 05:47:25 +0100
X-MC-Unique: 1xZULfrvOdG6pUGMvFYaxQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzdxQOXfh0Al8BvO9IZR4m4ogp3PTAZIxDqV59Z1rt+SWP/4H7lGevw9XZ3Ib9akvgMgjJnYHK0bSK1qySxxCpkvqvcj81XgC2hrOkVfi4pJO6kKbLgRIewvPfIyxXLDkYRjBmaWjkpJzNx4u24c/8MF2dCVLcdSGyG4DYNgfpEg+1i+oprNp9431YXHRVy8A1k/VO+VIWZdfvAdeTsqx1sVg6K06VpEl5djrtsWGTwhlTScsZD5zw4KlATka9grBFgmCzOA1S1DdMi/BlJ6svfTn4brbcEk1CYKuStTqEFh7g0aDmFlLBPWbaH26wL/LogW2y5sYh7rqwmUjj2IRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN8YEAOhywwKOxeM1BPHKCfmTuiFbtp8qfZcZm2OyIo=;
 b=MzvGZt8925R4El+tpWQjXGLbHFIAI7BibVNEWPwOuCDTe3BItBdeQhSgTbrP3hif8HJt6mpfOaNDK+hoo+UXZ0hifF7DoEd579XnvoI2lT6E3SdxZ3hRY8uNk+YrCPZWrOVGZF2wy5zaqv0xZtrUzcv6wYriI34Qo2OiX29QkCrE375drOuNGGYKxEkBHOwfSBK/jZVXBGA/F3rNMWlubpXcPcZYhGk0Ja++Xu9VYc7ZUTlSJL5f/NP7e7cGgHJm53JA8FJcerBfEQLgsNkvSprSjYHFqHHEpJtCfxSK4YgwdH5He04OxP4IcIwyW9D+g5jCi8n/81V4e0I7ktpY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3067.eurprd04.prod.outlook.com (2603:10a6:7:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 04:47:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 04:47:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH] Squash to "selftests: mptcp: implement pm_nl_set_endpoint"
Date: Mon, 10 Jan 2022 12:47:14 +0800
Message-ID: <432145d02a7fa2c0de7ca2a1074d2a009d71380e.1641789957.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcca7ae0-c68e-4e24-a23d-08d9d3f44a08
X-MS-TrafficTypeDiagnostic: HE1PR04MB3067:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB3067C83074AA55D76907465EF8509@HE1PR04MB3067.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VC+gqLn7g3dUauRNPzBOht17ZKnnWhvgYnGaG8VdAxfsaRvTBBnmnEV+R7QQIOCy4s5841kI5H94c/DSqYFgpoIzzn1LwOhVfVBqdn7ahl666OZyTvVWTrCAJaFqsPWKrTLT7I1RF7RPvgbxm51ngUjGMIuYeyYw4PRXMporLMMSrHkP5OBhEigNd1wF9n6BgJpyEvAkZGbjMB/xeYgg8zIlI67melyBbbyUbWzBEY4JU+vDMRYumDW198sJfeI7RQlmqfQIjLShT0VsIjFIXRsyEtw2g9dhTDpVBNaqZSkDVcvpGSIjomzgnwN6GHw6Fm/vjdg5A5TQtr/be+FxrU/D+69JzSnhVKmt6DdI5diaGxvhJ7qdnOQC2Xn7zkWKAA49dq/SbrIUhRO9Fdxo4uLORzi7NwJj5HI7vPzUpdk/VqzmEFg+eeYn7Wqlwb+j3OSsPNlEAA7Hk8TQ5Fd3a8TIMOv86FgdRK7uRj/ozzwSp6/CXYe3CQ+YySP/+4e0PFIQcmDiZ6EPMl79cM862jP/Sl1Adp6YDe7q4Wp72cYzJMzQBZy8zUUP6DzJgMKrTTiS3UzYcGvIJCiG9nWTmFFBvoztqSjcMaGQOfvDyYcDXTo6Url5ltDmotonqHTeowZN3+IxD6K6Sr+L4ap3+Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(107886003)(6506007)(66476007)(44832011)(4326008)(8936002)(508600001)(8676002)(36756003)(86362001)(2906002)(26005)(6666004)(186003)(83380400001)(6486002)(6916009)(316002)(66556008)(38100700002)(6512007)(2616005)(5660300002)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZmuHrRPtbIvoP/x4TLrX8iBDJ/4J4ZSKEPWzql/CYin7KtndGlHAEYbCYgmo?=
 =?us-ascii?Q?T3lhYVxaXPJKMr8JMrTUr0HrbZAPxnhesl9N9ksZrP8KSgRSLAXZwDLLHkxk?=
 =?us-ascii?Q?vMzlSskokiTX3rVXzFHYoE6B4FOmAUHpWb3iUYVxvvr5PgJMcEG6UsYKtccI?=
 =?us-ascii?Q?bIwUqBPY7ny0XUEvh8i1HIQZYm95Ot9KnttCxel+iUyEmae+Gl+3NMg4UQjp?=
 =?us-ascii?Q?4HywGmvGnptWXrbl1s83n3OmBzHM3g5I4ngsxoNm4NGnB/ayvLdtmkNK14ad?=
 =?us-ascii?Q?tJA8Aa969JPlS2q3kj4b/fzYSu/rLyw7uq0UKt1fpBm3bsPdH+H/GtYjB3Ik?=
 =?us-ascii?Q?iiA5PRRIYZpYoHbTUgHOQUG8EcHpnaQjRMbjEsgPT3yFTyaHGWp15CiqOFJU?=
 =?us-ascii?Q?+YGpLMP11uCOPlbZMf8BNnXELrQ9+LXCBpr19n4SF56652SL4VI2KiIDLkrd?=
 =?us-ascii?Q?Bsg0ZlM4u+FI2crB6fi65BcDHO0Wr23OMTBk3ksz9qVc3rF0lEDemNONPhLc?=
 =?us-ascii?Q?f0Oh8Jdl1Zpk8OUKu1b8GBuB9l5q1x0iWSLQPr1rJVSS1s1QEhMhpfqULupf?=
 =?us-ascii?Q?ExwM18E6ywVQ4hrjd4AU/BLMXAqC5iQJ11F9Yci3/TBZsFhGdZYdvs5mixQG?=
 =?us-ascii?Q?9Hm2+vDys4qmLQnyJEnuCQt0FgxPi+wb2rIX4Muq4w01QcMtQ2y9h8NNQlKJ?=
 =?us-ascii?Q?DW6zffBVh2wCeOXIPah5Zj//6WsBBPHz5WVjnWGbfqHAPRgzaD/4dudhuK+o?=
 =?us-ascii?Q?tBg3icqzA9WdXviG21+VU+pReCQKGe9duJxkkK29MNt53/zJylkra1cpGeN9?=
 =?us-ascii?Q?+blNVBfgm+f+ISNasR43hwaz47hA4PXVQ2TTff/UFBJWguJKr1EysrnATYDd?=
 =?us-ascii?Q?tvBPQdzNHvUznO2HKHVHx/M+z7WRXJrV7CnKZQwairinWSjvR4+iYcoEY19P?=
 =?us-ascii?Q?6R+gVP/jqATyPe7cyrNRhbYVIClX5BfifDT4jjoRTIMLVKaX8Lu7ABc9ACcp?=
 =?us-ascii?Q?t/fQyXBoVnKsM7wUonf03VhD4B2ez4w8rIaRdJH07wD7wYez7R5PQM5Heaao?=
 =?us-ascii?Q?/mLCbQCV4dyOObZwSHENTcXCAXrIwXiRIMXaD1PdzO3IRrOPmk8cU8cCjoNs?=
 =?us-ascii?Q?Xu+epP/fjXYoNf2WAF5MjpLpYdUhIOLaYkAepXSO16Zd0HXO1SFD7lWyoRHR?=
 =?us-ascii?Q?0MFOnnvLy0V8dJbtg//NLxNVnX8yQGIJQ2H5nbepTzb/QH2PXIE/cn7VgMaw?=
 =?us-ascii?Q?gwGKLNTNB5Ol+bBa83zEyj9/RL+bExiklSelDlxID/RtYjPxSIKFUQWkfBXe?=
 =?us-ascii?Q?06g2AdKB9mWNG1MNz4zWSDOiIsYIxTF1fonYBYjSqW87aWD75PeY9p2H8svx?=
 =?us-ascii?Q?R7TyWIhu9063ZJppg6rd91Z6ZHg/9toWBag2Bma6Ikh/WyW0HeMa0XsFTbYl?=
 =?us-ascii?Q?QP04sETdrnviBvBojaJ8y20F1KNWRPU3q1rrx6pAiHzYLFl8ztnPQsBZpqP8?=
 =?us-ascii?Q?pBDe7IOmZAQjmvhYyha/5JYu3+lqBn6AtgCqqMLv1O+msJQcsVQlaGy6QYyj?=
 =?us-ascii?Q?AZadzchn07Oms1ikoriO3aklNUjtIql0YONWkdwCfjcoY3UHB+0mRMs1mXXn?=
 =?us-ascii?Q?WlEYkVzvKgSAW4UC8bW9Ly0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca7ae0-c68e-4e24-a23d-08d9d3f44a08
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 04:47:21.8758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn+CTP3HPINByza9eS203j9HyGasbv+VkNwmkGEIvBHLD0vrC6iFVc3rIT+KzpAxXU0s+6F4KvIUDYOkVvmAXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3067

I just noticed Davide had added support for changing the backup flag in
iproute2-next, so my patch "[PATCH iproute2-next 3/3] mptcp: add the
backup flag setting" needs to be dropped.

Furthermore, Davide's patch used 'change id $id backup' instead of 'set
$addr backup'. So this squash-to patch is needed.

pm_nl_set_endpoint is renamed to pm_nl_change_endpoint in this patch, so
please rename the subject too:

 Subject: selftests: mptcp: implement pm_nl_change_endpoint

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 7ceb8ec11f79..46f7adab802b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -374,14 +374,15 @@ pm_nl_show_endpoint()
 	fi
 }
=20
-pm_nl_set_endpoint()
+pm_nl_change_endpoint()
 {
 	local ns=3D$1
 	local addr=3D$2
-	local bkup=3D$3
+	local id=3D$3
+	local bkup=3D$4
=20
 	if [ $ip_mptcp -eq 1 ]; then
-		ip -n $ns mptcp endpoint set $addr $bkup
+		ip -n $ns mptcp endpoint change id $id $bkup
 	else
 		ip netns exec $ns ./pm_nl_ctl set $addr flags $bkup
 	fi
@@ -586,6 +587,10 @@ do_transfer()
 		for netns in "$ns1" "$ns2"; do
 			pm_nl_show_endpoint $netns | while read line; do
 				local arr=3D($line)
+				local nr=3D0
+				local addr
+				local id
+
 				# 'pm_nl_ctl' shows the address at the end
 				let pos=3D${#arr[@]}-1
=20
@@ -594,7 +599,14 @@ do_transfer()
 					pos=3D0
 				fi
 				addr=3D${arr[$pos]}
-				pm_nl_set_endpoint $netns $addr $bkup
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						id=3D${arr[$nr+1]}
+					fi
+					let nr+=3D1
+				done
+				pm_nl_change_endpoint $netns $addr $id $bkup
 			done
 		done
 	fi
--=20
2.31.1

