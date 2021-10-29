Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5A2C83
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635506129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AW16nfsvmAFgRcje31xRH7rcJKpKCOwpWDWC2L8RumM=;
	b=hh8f+UGgadBbxmAInEvtT92b1Vd1RAKQqyamRFt59Bul7Asx83u7NOkgTnQW77drCqQD7f
	jgsPytBxr0xfiixQu3AEeCWZLRlR4/mGPht1aQP9VlecV//InZS9i1199on14M1nKYUUVI
	lr813pOASLMYJ6v8W9OZ2u8roLQ/9a8=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2051.outbound.protection.outlook.com [104.47.1.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-f9kO9ce8OZeTqIJS8llQEw-1; Fri, 29 Oct 2021 13:15:28 +0200
X-MC-Unique: f9kO9ce8OZeTqIJS8llQEw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nosn93U/EGlOx5/nPG3fqbAwBv96zrWyvxbohoZZMicbXCLqL5W2UHPp81U4YuoPy4ieS1LdV/+e/Wxszidlv4T9cuD/mrdWVxiSwPZT4uwr3tJmD4W9bL25ffiMSd/pgjsSO4vTYrOxMHujxFG+hsf217DqWNL6yIvJK26iSMsITc6P/xLfqA/E/miXkrRmEQZjdo0vbUs6bUbGrrolLx5IM/gmlaBMs7B2ATmTR6mk8HmXOisZpwFHvjTpJHkpEr5+mlckCsr7E8OUMPMMdP/QJodjg9foxrHTpepAAimrEvEAsu/M+Y4gJyPxRKB0LtrRi7XrP4+dkTfOmnfyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8kga/ALvaTvG7A7ZO90PiW1HqyInu/oB6sERbi6afg=;
 b=CM6GsONg4zAvzWlXFdJctvinIWm9Eaonlts8bHlDlk0cOboVm2UzAdbD5XwiPxhvVHwNsPBQsf/x+FFohcaVZjDBtq8mYbWWP3mGIWficESX1GHYO/8EbeKmaqkWsW38apq758f+hUUHefL2CSz+qvOH/XkThDDwGX4Q3JRysdg2UG+E4manJ+Hg09MO/QXY3B5xDDx2FksplA8rm+ffy7p0SYhWwyLvIqojhIB8zoJIO6qyPQQCOCTqrwkfG25prQ/wOV8O+aE24OSKtANlwb6LKIJDzf3B8Zu5w3GzGU0J3xf9OllT7lRONSRMpmhBBqEKBXoWMEjFq7VXPLkcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2857.eurprd04.prod.outlook.com (2603:10a6:3:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 29 Oct
 2021 11:15:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 11:15:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mp_fail testcases"
Date: Fri, 29 Oct 2021 19:15:24 +0800
Message-ID: <8634c68b78546255b889f050a32d81ed36dc7f17.1635506026.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:202:2::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:202:2::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 11:15:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 106fd56f-c2ab-4815-a39c-08d99acd688c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2857:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB285793AA870FED2C121D49D9F8879@HE1PR0402MB2857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8aSysGmH7gkq9DSDyPAaJINd5rT2ZwIVz0uF5fLQGs2mu1jXa/I12PrcwlNPukJ7pFqNHCt9ugVKsxPGz7aVkVqsSXNYTZiWdOvFv3KIShfIekjIB6yIl5Gmpud5g4BkLb3a36HmpglwmCmdtiEhBJuy3E7zjoy5CWcSEMkz+hrKMJ9s8T6hLK4FnEMQPqd+Zks9gSbBS/qALg+/qjK/dkhee5IeGPJDdQtjl0E2PxqwJFz6z6c51Ux94pe4ZoPSqbMOyiTREMdnGt6uX1NQK96ab/pnGk6NT2IrzTGS1Wb88TcvgaZDdbuD8MPoFC5zDwkiczPg3FJDyLYk/2OsD/4sHKOdi1Gxer8ANGqmOIX9RExxxbkpMWWjPL9jHHLcq26dN1+UcU3rYe/SxAQJpT8iFPNESUeNuVlzsn0Nh4UNXKBV8OjSB1s8KRLv4REZixrCSzFRfJS+BP7Hf1T0tNCXKax1c6UxApSzhI0ppD6o0SdzO7jZU4jMvqtKdJtYkgo4vcsDjitJZr6OMctQVHRM5RKM9vWneRrMUtv5Ta9DM/68l/AGxcBr+R2SBKBBzMwcvIVoZ/cOQnI1GaMOuym7++9cw7xf5fUcFwm2BY0H3l01CnLH6jSkTT0/FNQg4k+p16J1j6dsasPvM1ihWg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(26005)(38100700002)(956004)(36756003)(6916009)(8936002)(2616005)(4326008)(5660300002)(66946007)(316002)(83380400001)(66556008)(55236004)(8676002)(186003)(6496006)(508600001)(86362001)(107886003)(66476007)(44832011)(4744005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FA4K2UUJqvZCsKPyi5JUeHB75YB1Zyxa+3f+aTi2yIzr5N+5UPllEt3J3CCn?=
 =?us-ascii?Q?WVozCdI1FZfOAsLM7usNwbsaJuNnwp021/w1qK5CIFskPbQCNFcKe4LObm92?=
 =?us-ascii?Q?kqgoYGGwPwEqi9wXlXEwmzN8tZ1GExd8PKd8I9RmmZ3f+y392e5EdhGPs67r?=
 =?us-ascii?Q?R6Lv7RmkOKFZqpwCi5G8H2pWEGZlVNuoUrn0hGUlbkaHz0l5YgNMBLi/3v5y?=
 =?us-ascii?Q?MkQGZItPi8C9PVBNQUFgIHgS06bTWp5a8VlaU8b64ekNjF7a15g7b2zgoJC5?=
 =?us-ascii?Q?ErqAWo0cm3maSyt9tpYO4HNaubnTwJ4t8mQe1dVXkTJMNR2qvHzHLt+ux3mk?=
 =?us-ascii?Q?D9qBAV4B9k3mpfAsLvCdAEautHoBg7Fc+DlwGQe8281VzYfJE0CHpUwMy+d7?=
 =?us-ascii?Q?oE+obgrK7U7/Av2rd70g39DT/a8EcWwh41HOsvMt2rvspqA7rVOhUy6ahO4J?=
 =?us-ascii?Q?OED48HJ4tkszOF2CMVmZSj1EUUkTsvNzc0bI5jD/zGifUAZAjCi3XPiPSjAG?=
 =?us-ascii?Q?uX/dQKXAQdSA8B+A2yHWPrl1HHKb6IJmqYAtqWuJFRId2Ofd9f7mC1CZ+aNH?=
 =?us-ascii?Q?OfI1ndR0OhF9dzD3tzrl8Kn0EWE2nrPA49Slt8sghpU9o1PESrG32cCZ4bHC?=
 =?us-ascii?Q?37wTMLCXG5VdoRLd39iXLf8K4m1tFhSELXj3Q8lOLteQMieclDoQ5hYxgOsV?=
 =?us-ascii?Q?5iAJ2hI1l6dCSpUEnJB42nIBCWOP3dhc9RMaRAQEHa0Fs0UAa/XwaZQoaznB?=
 =?us-ascii?Q?7HErfV/5fA12CLG8uYvv3s8+QIcwaP66sm9yGgZbW//D1b2ge25dK6cXJy4Q?=
 =?us-ascii?Q?sOSzJmrISAGkReSKwVsL9x1IXo4yiFgq4BdhHv+vuTMsYRH53bfcJHg05Ol5?=
 =?us-ascii?Q?j32HLAHk0aGDl1K4JtVqj6VlulxeD9e9+ffGx8kwgLfe1Qr+CG4ISCYvLNNc?=
 =?us-ascii?Q?w4DGMvTaWIMB8TqH3rxrfO9Dc39BdrIhCcgej7lVeNeKGHZU3EXNFO8SSOE/?=
 =?us-ascii?Q?/am/wSNutUkKF6WdUSRTZtpOSpTa3tCk7FTWpF9/qe6SPIjlCiT0rxrdim/X?=
 =?us-ascii?Q?K+pXkuhciP3Pr+wdTALk405Txr+Xvokd6Rfx4e++A4NlLqrFb3DG1D3jaZcg?=
 =?us-ascii?Q?ydFkLDD53Z1wi07yBx/a9WAgb1dxxNHtlPm+ug0vnEO8PFi+9AF8G3hszj9u?=
 =?us-ascii?Q?3NHZyOeBDlXaJXKkwAuZuxyzupHcI3hqTyoCnBV+sSN40O6AsZHLe8V61+55?=
 =?us-ascii?Q?EvlAVvQ+1wsTcx2XKaiLUhkcEHnlQX/ywGk5Ekd0TB/kv/YdECK7Iydm2C2C?=
 =?us-ascii?Q?Gdqh2P2suXmM48b0wd+SrbUpCoo7z4xejEasdTiGsknDQcRURj4lKtpVLcIH?=
 =?us-ascii?Q?4IYFATY7JDgMVbH/qPBvu5ujpAS5xWTlejV+2wR9+6VMq+ZPZv34UoI24QRy?=
 =?us-ascii?Q?LvSkV5UkgFfXB6EQP+LnxxT5KVF2O5TrWve2uTiYfPNX4kpdkXYENHJz/qIT?=
 =?us-ascii?Q?YEZ6CupxuvC3UBW8B9vjzwyCpT/QXJmoa8Xs4JtKCOPSdaHjBoJKcbZ1YgZd?=
 =?us-ascii?Q?/q/HBqEgTi1voWIKeE+/uvC8a1D4aByeQRb3Kmo1HQG7YOF6LSxHOHe5/iFz?=
 =?us-ascii?Q?7jifztIIZdiYTcaKI4qq6MY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106fd56f-c2ab-4815-a39c-08d99acd688c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 11:15:26.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6u1rRBmx1FRms4TlgRc5ovobnDM50KCXHwXNXuN9GlNuwjzQijt+jMmhCM2Hs8BEAV9Jy2CEXKws6zWDJddrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2857

Abort if one of the tc command fails.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index d33cb5ce0ff3..1a11ec690f79 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -253,7 +253,10 @@ checksum_failure()
 	while true; do
 		local pkt=3D$(tc -n $ns2 -j -s action show action csum index 100 |
 				jq '.[1].actions[0].stats.packets')
-		if [ $pkt -gt 0 ]; then
+		if [ $pkt =3D "null" ]; then
+			echo "tc show action csum failed"
+			break
+		elif [ $pkt -gt 0 ]; then
 			tc -n $ns2 qdisc del dev ns2eth$i clsact
 			break
 		fi
--=20
2.26.2

