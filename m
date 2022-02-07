Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A392F25
	for <mptcp@lists.linux.dev>; Mon,  7 Feb 2022 10:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644228352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=byGlWWJr4zCoKYrMZO+CXYt1YLM8sJbM1TZVH5L9nO4=;
	b=Th7Uap8k6rwRD1w+Hbaf4GtPARsjxLkse87zs8qbTR1xbWIAEfaHNo1Y2M81jrZs2i4ABn
	nMWMB2doKaiKuN570SVHE4HmNoKFAIbQ/0YzLaf/GT8A/QWORFeonULXwSgFCjiyI9yp8m
	++/okSuuN9cheA5UOBhkAlApmGKlCeo=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-dLKqIHUGO2u566zZ05YA3g-1; Mon, 07 Feb 2022 11:05:51 +0100
X-MC-Unique: dLKqIHUGO2u566zZ05YA3g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh8KNwgiIpRKXKFOY1I/YrOiMVKyFZ8ngmcHk6ApspsoeRAhBqUhdk0c7g2l6zEyntZO+zu0w/N4HWlfxajJD4FSjZouPkRwoOkV3M1N1pSXQ92dlrlE/p9pWCZxOIKqHpHVqiOrbWFAi8U3sMx4XdVfL9Ch5jr3y3ZjYkzm6o9T5YupWlNFlheiswxw/Ez/FQsexLB7IuH98hNR+4vh/OIBr3M47sRm8T1YTSBQWD31OvDXKqClkeIeEMoOg4VBF3Qee4Qyp61cPUXN+HKQkOv9DF8MPloROtjVTwXSGbu5DplZMH85KxePTHKGMmKc3wvPpZgJRBJz2rrvoXHVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABPpALYrifrtJvcbG82SZUXwan1C6AY7v6xL8F7wQi4=;
 b=JwcmiKrlP5aBVVHmXQ8JAVJk0S5k/3M3cnjxHiZUe8miMO3WnqpZAW5tuIMr2YqIbzxKiRR7/724KA2qqVsw2dfDPZmcCGzeiOHC3qu7U/62ONz3s+c7MmG9i+PT8gABM6Dgl8gGZCYRJLBo5OznG5Fh5cyXLRX95IqgS0MhLb5MdI5FvEd1bfqjBTRdFr0GucwpiT7WvJZ4LNsaHdCDjxf5d8O3vSikk5ElzzTpbuuOvvT/2rz34NapMpcDm0vdJWGbfPzXHJqg4lteyb/14cwazVcvSt+jWwDstrSdZ6fk1z5/1kIGKS+HtIwbQ0QbXnZetIL/Pc8OaPAkZnLjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8738.eurprd04.prod.outlook.com (2603:10a6:20b:42b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Mon, 7 Feb
 2022 10:05:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 10:05:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: drop unneeded type casts for hmac
Date: Mon,  7 Feb 2022 18:06:08 +0800
Message-ID: <5ea29fecc4db9bc0a9a9d5d10e0f2a61d645d46c.1644228345.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7f2013-3c23-4bab-01e7-08d9ea216ac1
X-MS-TrafficTypeDiagnostic: AS8PR04MB8738:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB87383778E71CBD4673D3D5A1F82C9@AS8PR04MB8738.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	33Z3dAzuUEXc3V4Bs0VlTQav3f2/dhHqQKa6Rqj1BtH+BZlk2M/FekQdT+a+sJlaWi/KfLKD7rnjFxYchNe13IW4duGm/30A6nCQu3wGVNwrEDjfFiKUglKtfznhTe9XQSkhC9RiS7kH/zI8St9LY5bQjfDMiSkH5QNKDbYHJnIgSFUM9lRvWoeVm2627+l1VWEA+bY5uAYPQa9txOIynUf5XnbjzT0pdLqs8A8gGc+YN04TYTa2DiSdKPpEzL1flZwIi19DpF4KEc88lfz6jCxGm5cnIW+/OkTYdNGX3LJYs2BgRy31asfl0/4/St52XLjHDejbWx3JpNi/L7caewewAvWtfuVs0PDapDkVlSyVbDNjia5aGOkvR23q2UU6/h3vQjRBkpN92FQCnaqivMGHXRt66SqM24LgSnHX7Jbs0kdfIj31XoGeY0bkGH0Dskj7zQ9Ize8Buwq+DJHX12upqMYrTtMrt93SfVWI8Jo89S6cpcp9RR1hXSV3WeLz1k1KB6PZEGNkTKNoSW3K5GUA3CqSdlg/itrTQ2tm/FqRB7NOWikY89KQUWZ2YXv7tiC25xWq1ZOrj/u5+mZX44G3A8G0a9w6XB5dnojx0pX6bhAMHIjc550ONgUslz/Q22+c4aiyET7HqPpOBDa/rA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66556008)(38100700002)(8676002)(66946007)(186003)(26005)(2616005)(66476007)(8936002)(5660300002)(55236004)(4326008)(83380400001)(86362001)(6666004)(508600001)(2906002)(6916009)(316002)(6486002)(6512007)(107886003)(36756003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GVWPs+mHRvNXlzAi3SGH8JIE4DgESAnEPypaZaXi0qFTEuPR2WUcYn6Ik0Jw?=
 =?us-ascii?Q?WuzAQ5+gEMDoe0HDiTUvWlhGdggROP8HOujCPt8WlIa6R/2RLA6yOd5jwA85?=
 =?us-ascii?Q?lWLTu/zKW2igN1WgMTMHjW75gOHiOJbN/NlREkk90NoTB7l72oMKglLtdAfP?=
 =?us-ascii?Q?w/Hv4a3nfp9cEW4NwO5ftF6vh8bRpCZzQ0h7Tm5IPRpPiP8MpDW5nKaL/ptU?=
 =?us-ascii?Q?+1dAhcQJq+bNFpbitPhUld3HIvV3nvRMia1q02BxJVZxeCt+O8keOASGH1t2?=
 =?us-ascii?Q?9weMBLlDJ6BI48igtBUInjQ/4BkCnj02mB9FixU0QT4pn0GsdF3vkz1sYw2q?=
 =?us-ascii?Q?W+F//qYwjAnnsrgg3NwdL3JxEQzAnFezFguN/biybOgdmM4eKd0b69WuL6Om?=
 =?us-ascii?Q?vKpzVPKCacwZL7oXP1KTVzk49gYVu3GbnTUv5LNSlznzpaMwdAYRlQ9Q+M2N?=
 =?us-ascii?Q?R55UupFA1B5KsPaQjZdIhUt9VwIJVMFFcN28FelbS0PuuBR+O48GsREWxoX1?=
 =?us-ascii?Q?4Q2tWa2qAV7Se87zLZ7+9KleeZ9wYS6ebAzhnhRpxq5M7EYvMxzlZVRcpbJ7?=
 =?us-ascii?Q?n3dXepYBRQxzkHW2Z50Eo7w9Dir9XeF1WvNX6k0UCEV4YwW3Xq9bd1ORep1w?=
 =?us-ascii?Q?EMeasKftfpxQQgiVyRw8yaZb1qjootnNJ/gGgEVhQvzjZIDHaBN+abtK5Z/3?=
 =?us-ascii?Q?5XhL6X972IXO8QVE7E5FJ0OQp53qTZzLePOFlWHP9E9+8suQdpCxUcIxjzcI?=
 =?us-ascii?Q?YU+t37ggqfKFIzRgr68tYDU8QdzwOTEQAJfLYaC1BnfNcrCnUNAABWzuf7I5?=
 =?us-ascii?Q?vR0JqS6nNk9QYzcvCNor8djGGljuqFnqEKo4v1N0FOxa2aoAVKa++k+I6vDi?=
 =?us-ascii?Q?g5PqtqMiluECr/41B3xT9s0dqyYWzSeSM996fPxzmN2gPUjmAK13/v1gM+6D?=
 =?us-ascii?Q?yTcZW4SGCu+g/8/GztwROyYn9MRHPWvq48qbb29DDBHsQDQwkK9iQJ3Yhola?=
 =?us-ascii?Q?9s2kR8g0HlOjFKoCyA8hFzXXlysNwUuEa10O/nP2QJo4c4UnrquI1vHxV5xm?=
 =?us-ascii?Q?p93wrV6nsSrEeTTnDly+bpeoIWiFyF8II4EiPXhRKZalIGHO3WFgOfgTFeqQ?=
 =?us-ascii?Q?VLi832/yLhddvyM63b4m6CGOhYeCYPDu52+yRTaXcaRXNROhBxaa++/qKh/B?=
 =?us-ascii?Q?NnCHZptouGxIIAyEKeGLZZUq/RaaPOttod/tmp8LXvYg/OMCNwtl+Grl2Beh?=
 =?us-ascii?Q?9KotFr837iSmFoMSMFzguo9uFCbmj82mjnKRcZDd8fJn+kGXVFm29AWA0x1i?=
 =?us-ascii?Q?2ugFjx12X2gYOMMl+Ut1R+1W4J7yMsgZug0zbiaTfla4DTcI/PWTxHPPC3gm?=
 =?us-ascii?Q?VlXaguSsRfPhhsspnj0thuNkX3stAcjBO/zKeMzi807EjIeZwccCrjBY3est?=
 =?us-ascii?Q?11EK60DniSlM8D0WdqxdRYQu3CgFeNZO+xeJdcawhOeBg9wrKG3SsZZbvLjp?=
 =?us-ascii?Q?rMDc9TmGwj/5HQ23BoNg8kFQEs2OGsiazQdr2CDpz+aaesc2JnSX3dGnkT1T?=
 =?us-ascii?Q?Zc5CH/uOQ7Gsq0t984Rh8US+pR2HUSm7eATbVmxuRIOBnC4cqtFTus8iaEe4?=
 =?us-ascii?Q?4UCHHH/am2c3GkWfJEacAhw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7f2013-3c23-4bab-01e7-08d9ea216ac1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:05:49.9708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSP1snuBydz25k9RM5kyWizBXF/WUKoGVP8MNWs/UWSXhuHobJ1U5YcJE3LhZoteomJuyqYkrSwUjyaN22pDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8738

Drop the unneeded type casts to 'unsigned long long' for printing out the
hmac values in add_addr_hmac_valid() and subflow_thmac_valid().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 3 +--
 net/mptcp/subflow.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 7b615dc10897..670364cd455f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1085,8 +1085,7 @@ static bool add_addr_hmac_valid(struct mptcp_sock *ms=
k,
 				      &mp_opt->addr);
=20
 	pr_debug("msk=3D%p, ahmac=3D%llu, mp_opt->ahmac=3D%llu\n",
-		 msk, (unsigned long long)hmac,
-		 (unsigned long long)mp_opt->ahmac);
+		 msk, hmac, mp_opt->ahmac);
=20
 	return hmac =3D=3D mp_opt->ahmac;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 88ee94adc38c..485f00dcaf84 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -344,9 +344,7 @@ static bool subflow_thmac_valid(struct mptcp_subflow_co=
ntext *subflow)
=20
 	thmac =3D get_unaligned_be64(hmac);
 	pr_debug("subflow=3D%p, token=3D%u, thmac=3D%llu, subflow->thmac=3D%llu\n=
",
-		 subflow, subflow->token,
-		 (unsigned long long)thmac,
-		 (unsigned long long)subflow->thmac);
+		 subflow, subflow->token, thmac, subflow->thmac);
=20
 	return thmac =3D=3D subflow->thmac;
 }
--=20
2.31.1

