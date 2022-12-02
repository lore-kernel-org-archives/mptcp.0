Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F157B
	for <mptcp@lists.linux.dev>; Fri,  2 Dec 2022 05:37:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjVgfn67w6oMMgEhEFzDrxQm903FO6Ik97QUZoHfX8KRjSUBo+OKWHIgzDI4jg/osmvHW2e3mNdiaan91CTJFFAftIglB+ojIXUI2EGAmvPQAist84QQRiYDhCnGOVCA+ciWUJ5MpeNxBPOND9qTrLoQk+7J56sd5kgTiDD18n+Byg5Xfkm5j/YhxzXqSKuHT3swBbIpYfx9WBM4JJSGHuGej+sMX6QONMNWOXSN4UmmBiwDLNxgBAmEC7RHbbK7QmWuOuQnKqa0+JkeKfaG73tUpJ5g7WfWGry8zfl+ftrRUMn3DnuprVbw1lgJcYCFBfIoLB8VW1dsMehHmt6Yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntVWIjDdo+qNP/pkfn5ev26FeT0OMTtvRYx3uWyGyXk=;
 b=Q/uj3X96QyWiZRkP9WRHbNrD+n2qhlElGYAwmgNRoQk1xVIdCqaGFPhVItgkXR+09Vb3vgK1owKzqGytdXzwtnLvDC1/0PaKovNQ6rY3Oygftjmc0yD4soev5Q1m/Ha4KQuPTzOz2v49o4a7LNjYwI+mVpaEHjxyVPJo7WnKZa4pQVQE9Li+oxcwZqZ5Qhdz0reexWozuFrsmYm1H0CgmAfqmXvYLyMGKtaNEZi5l+38mNUSZi/l3EAZGyWX8bEBQDW9GENTKZcKocpZC2zemxmfebtyNrB9oNnyWjNz0OlLG2MwTCVMnq0iqxzdCE80bIGk46qxcCcJe5D1OXdRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntVWIjDdo+qNP/pkfn5ev26FeT0OMTtvRYx3uWyGyXk=;
 b=ukAaRITVRVOMUy5F6uAWM6cubyhn2fx/gUjJZfuPg5LUxhBbLG+Sq98LTgALxsPI4bj42ht1qYyXuREOXnvaHt1iycuORjnWbfHTQMuVR+dyyyShTu7zad7O88D8e0MVCC2ARA1cES9ORIkhhYcGY6mikuU2YQTgATaQrHsH9coYUsCvolX6trP63DS9muH6mFMiziKmi5TSEHRewXblmYQEoqX4vbl98yOinnTYVS4sTT98x3UN1Or7OWRrczcZXdVHF5x76smvTrSr5sP8TtPMuCxn+hwRPMqjoyXEihnwB/fjsVyNODW5kWVS7/IR5+fodIx706jqqmQ2F3eiIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 05:37:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f933:8754:731f:f6ac%3]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 05:37:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mptcp-next] mptcp: use nlmsg_free instead of kfree_skb
Date: Fri,  2 Dec 2022 13:37:36 +0800
Message-Id: <20221202053736.2980-1-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe74efa-9b07-4c07-3443-08dad4275790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DuKjeY/5fS+EGRWIX1cEA7pa0kkOGg3a8oe5cNXqbiey3WTW/0S+bkvMIKOMhT2l8Tk8ohe+dm0UOPga8BoeCip6xTFSOUpV+A7o8Ry0GM9bufG/sS/wrK1AIDNTl8aMDD4sdHaY+i2U4Kuuqt/bzT29iVhQa95SpYMboEo7C0e6bHSsHX2daZsojjGkYTiSlTDkk2Sqgig8Kw8jGix075J4NpuCZOl0FK8jYPV2vjyEzwnN33Sx+c9MLoGxjJscqACLieXdNNroaXcZH8QNOQ3TNQTStr+IVJnraJC2f+mldTKY8/Fnv6o6VF96QHj1FDgZlyYnnXOBpDrJGukNFr2fn52CbdUnFiW3oi/8yu8YGC2DXuum+bgEM1tp7GvqHqt5D+FWwavQHxEwMSd4tzP7XZ+LrcKLAYIIaSx2VF8iEgzA49l32uJDlCeSltg6qHHSKirJ54XT24QdoymtyW66G/CtmKohAXWJD6opEsgZ8Gcl0k3WG34bGI6QrN0wYKP/TG8yNgzrnuPP7vkdRZOufl+xHrD7rykLGJZ8XVcuoIiMEUlvXAGVBj3WjqMn6hgShP+nctbrsjhXFey/cuuPqYa/Nv6Ah1u+NYIHrJBJnWE/IQTmXQkTzz082fJI/FRRFTwmhLQgVPxAOKM1jA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199015)(83380400001)(2906002)(41300700001)(2616005)(5660300002)(44832011)(1076003)(8936002)(36756003)(38100700002)(86362001)(316002)(26005)(6512007)(186003)(54906003)(6916009)(478600001)(6506007)(6666004)(6486002)(66556008)(66946007)(4326008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zDsapuxt/P5geptatDKfv/UOwZzBPSt1FciDOsNntVcPVGo24of/EZqxewGR?=
 =?us-ascii?Q?Xnr3ayJ8sjVgssW261uJqIEcn0uNui8f9bOepAbAu3BtXhBWJpjGlLxbGRPD?=
 =?us-ascii?Q?NZtGOx8kS6vpuNafNoogGI3fsr2As8deml51InOSiF9/r+zau+wa+4s5zCCK?=
 =?us-ascii?Q?lnT0xzZKVy5eL3T0hZRpTZLcuOwLhA7t8Kk1dEBjdyA+HiTTUrxMqK+hHylT?=
 =?us-ascii?Q?Cz1PR+onzNCJemISfyQyzV1lHismaLuYiRqLQjpIK+K4nG2CXgk2fMrCN7td?=
 =?us-ascii?Q?3YWZwz7Wzsgkj/lCAnSwGeSHvCRY0h/WmdttUdRNlM8ObByh4B/SpDBJmRIM?=
 =?us-ascii?Q?ewtCMsx0zVR+JmqflekNk5T50/ZJbiphdqqtxkZwXaQwv6YoUU4YcAvBp0fo?=
 =?us-ascii?Q?X3IKvIWo17MxDkFc2/u1CDxQtR6u++s3uP3sL/cwHjZ23N/48EVTwZhOmwWf?=
 =?us-ascii?Q?cKOqCFQT6wsQX6pHNGb4913urajXoSvgZMlYHOAQSW+np6R2Bhj8kRGp45Gx?=
 =?us-ascii?Q?HaFsB7g0yaUjeMECFjLjOU0pn1+9wBu2LGY2r99XvfvT+zzvH+JT55jdTzhL?=
 =?us-ascii?Q?wcryLQ+Gv78q29DcIU10BBOrOoAqUqkx1H7eqIVG0uZnyR0YrwFyytxnKyKD?=
 =?us-ascii?Q?650PkT2CaS0XxM9RDxWnLu1PH2Sypl+gaGzFZhVwDt4uRF6iL3N98XCe3dCL?=
 =?us-ascii?Q?k7OGAklcTz39/YmPj3uGdG2NX4MIscfovMLAnWahTdm6dpcycMyoQXlSDgtj?=
 =?us-ascii?Q?lic37pwsHab/OCBtJ8WUGbh9jeFow6KN2RqE+a0YehN4I/fddoZqxCn3HKIC?=
 =?us-ascii?Q?LSjoumqEiFGc9/V8T12im/7GW11gLxvMA4neWmqS6AW49JQh/hDyK38q7Rcm?=
 =?us-ascii?Q?3Pxk7Cz5L+5X9K7jFRse7LwtCWIj+n13UpBCflsiz6KIySPOLs7XJ4VK6oNY?=
 =?us-ascii?Q?Kv14m0pHO+gbh5xSm0GQxWNuPDZPBMsEB0CX+llQscPOmgqZ6xvxKS4tQGrZ?=
 =?us-ascii?Q?mKMjzTjh/LKckW6pYwRkHjmpFZv1w9X2HUBdap7om3mP3uwsIYWO90bToQX1?=
 =?us-ascii?Q?1SvncLDWu6uNt+/GDzx7DJx3II1MxpvWjKKZ9jCTy059eJbV92YSaj6PQVIi?=
 =?us-ascii?Q?RDeR5WhQQbrdvuybuVYJduvlTWuwCq4HxRtJv1O9A34Cko9vgLKQ+p07JPhD?=
 =?us-ascii?Q?zRikDB/1js9jmitIg4bXJKLc3Nq/SucCHp50HIxwINkK1oMkfw6h+O8Uptlb?=
 =?us-ascii?Q?vpUG1nmvQpa8sYAd+K77daqN1pl365lIwJKVt3fsNgdksnqApUiY+6kMYv49?=
 =?us-ascii?Q?QprGrv74sK8ur/Utiph6foILhiINY57Fi+qnAKtm312C0za90HLdYhsOQ4Gv?=
 =?us-ascii?Q?TEojRidB2JgB32gqFWrmjwInWUu45PxygwiWKzOLI9aztJHgbY/RoIefAFCJ?=
 =?us-ascii?Q?mrK9P7QQfdTStW2HIdiyO2A+Cra5HYOwLY7bF6dkrzSCrpzLJY1hjOHBmt+D?=
 =?us-ascii?Q?3PS2PvvY25+MBKTADtYzimvuL5Si+8pdQrkwBSlSDdE2CvRWqM3uHqTd6hp5?=
 =?us-ascii?Q?/gMsYjVG9yh/4p1+1cBn0s480Is+bzaYG0COznTuGd02ANu37FgnhwA/9FJa?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe74efa-9b07-4c07-3443-08dad4275790
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 05:37:46.5321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vP6iGWytnN30DIDx7BCqp72o/Xqml6Z6Oyv06GLxoX1KTUmZi4cS20OJA25F7Aj9UillWybBA9NkVTBF+BUQ9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825

Use nlmsg_free() instead of kfree_skb() in pm_netlink.c.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 93ae0fc892df..39b0f054f39f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2091,7 +2091,7 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 void mptcp_event_addr_announced(const struct sock *ssk,
@@ -2148,7 +2148,7 @@ void mptcp_event_addr_announced(const struct sock *ssk,
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 void mptcp_event_pm_listener(const struct sock *ssk,
@@ -2200,7 +2200,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
@@ -2258,7 +2258,7 @@ void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 	return;
 
 nla_put_failure:
-	kfree_skb(skb);
+	nlmsg_free(skb);
 }
 
 static const struct genl_small_ops mptcp_pm_ops[] = {
-- 
2.35.3

