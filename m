Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD097E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOLz9qxRWj+w4vtXRV5qNR6qndClNH0P9Q5geqlAt+A=;
	b=X/ae1mfVCVZ/MBsVDUFnGE8W1R4yyWU6wOxKDC8IkxJstki3KhMV9W4XcjoPub+yRrG1Oq
	C3+isUzgTpg+yT9mUs3m4r6YQoP7kJDOoKLi8eX1DAqwnORGjzIoWlYnRZ/hRtUHcszH0p
	HjyFKywcYUXZusvLgaAlNihWJItMS3I=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2053.outbound.protection.outlook.com [104.47.5.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-QvenGo2hPGqRYKwjTohzDQ-2; Fri, 20 May 2022 10:05:13 +0200
X-MC-Unique: QvenGo2hPGqRYKwjTohzDQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9LymA2aLsK/8L+fqSE9BthwdabzHws/Bpy7AO8LMEPYFi+PVOXftEbNx8pS9zkk95j3srmMdm5HpKJswrjtOyWGCJlyluyEx0pD+Butabh3OV0Qu9P8St1k/V4A2AqK+NJW8f8ypQBlIFj4zwZAoLyjZC7x+gEKHkihEwS7Xppbw2L4zB7BLkCW5Bmhp6n3CVmni+HVqSTU1UomaTmoyzCpEc9NsibZNU9vSkWKnHnuYWazzZ6EKYcO4BVk4WZKvpFSIDTjHcRR8tT1lev+gpe49n577zYTjzDmxV1y/lwV9er90xledwhp2WICix9Q4PmLWDzxy1YerRYBgRUe0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL1hypKQ2SDKz5u2hfz2a9/Qcx4V4t18rJaOOb7KE90=;
 b=DOgqBfZbyy3Sq+Qp+CDrnxKZfrVc3l+/99jANQNcr1Z1RpvDNnxC34CO5ZEgwKZCKfqhzdbOiS6uIfB+pTpiY0SjpZvAfOJJ5EjRjT3ZH8zuYJNnb0NSG1l1ffX/7Nnh4MmtNivvFKRH661G1ghgQ1J30wPgB2KnozbekC+D/GX50Y4kxFCCWyjWfgj2QsJWoKPa+n8hG+KhfxJIW6wFtYgUU0kLPQ+D/OdTCGnwzUWLSRxQz61j/e3wENoc3HAEeRJqkLCISzQ7jTEPxYZKvkDXCTxMrwwxiDgBU9TOqYFxQ15Y8Utw4lYXaAriymy+KaJICeeUk3v3umQwCy08ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:05:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 02/10] mptcp: reflect first flag in subflow_push_pending
Date: Fri, 20 May 2022 16:04:47 +0800
Message-ID: <0cc3ee67ddd49c3f6973a8c417b5551b8416fc47.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e01ffa8-1dc9-461f-bf56-08da3a377727
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9149C1EA4EA12447ED82DFE6F8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eOYuBvy65tf2Mphq0sgsRjtJIGHhzDn6cUQCllR1W93uJz/PH4M70kj4PIFJjEtPE1Sq9Aj3I8Pi3FdDeddIscE1//t8EJJlG+vT++JKWNUYV7SQ9DYZNd0IPlTZ7XXvKVdJqIl+4YPR/LRfC5PvLDa90j4tGOH48vbCejmAFX2Xn9Aco3+EoZVeYeIpKYEZ9or7FQKRNMlnZC3Q5TaKd3yAkrEkZT/bLhSbn04fH6Mjjs2y4R4msrtOEwgQM456zjZcwuF6wzTK6kynkiKNHmabVKomg9odDoyTeAQifTO6edYvzTHYQY2BKxocwwV1TSXK5Cdp+Ztus57BsXjNauscJB7hZLFL6aayicvTZeA7FNWOKeizrX8BgzKkwjOZrtCO+kxY+bivDWIS1h2qnTwT1mddat1Qxjj6qz17xG7cMl4+mMGVbmeUCURY0zbM7oJwKHNjfwm27qF1NyAgFXP01rCaSuqouQGYgO2tYI0zMt2cQ00pMjzK7LGqXYtENQdumhlMfsrOzxRA9wIPxZ9cqHksQashifTxVjFKRxD2mta/Jzdn5WsBk0JOdBclqMRGloZP83ra+5Ky4IJkpKAXE8jvqsUVIN3ktVsz67/TijFP+BdBCn3kFHSgGGscfSFx10VMnILTZKSaYcHZCQQoWwdeZua8Y3GlbQntkSRCa4nUBRO2CD2QjRudHHr82ySNFU6udcq5LgCWRBu4Pw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(2616005)(26005)(5660300002)(83380400001)(86362001)(6512007)(316002)(186003)(66476007)(4326008)(508600001)(36756003)(8676002)(66556008)(38100700002)(6666004)(66946007)(2906002)(6916009)(6506007)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NzkLqew1/onpbqgXGPrK9eOL8FVQxGLdf6hw4h1GzgXf4zP6rIjh5L4QWKzQ?=
 =?us-ascii?Q?06jwqxx3RUeM0yw2dc0dAsjdeGhJjPvwFHO8y6hNBuqYi0bDmp6kjbm2bWdF?=
 =?us-ascii?Q?L39GNVgknB84VFSd41reK1mvq8FGPpbX4XZDtSxtkGbb2dkKdi0VtI4rvBNn?=
 =?us-ascii?Q?bMUX8wN0URgjzworDZdS9RZw7gIwwN1W7HUaoO+3G+DQTv4GbQPJqyla62u/?=
 =?us-ascii?Q?RnjN06aiSsaByir5DSeLYEwE0G6zkSxOheIq5hnT2hxsdVNHm225dXAbnGPK?=
 =?us-ascii?Q?Kcha0k5CPovTzQrCk+BiTXwgMY4wFU3LZyLnN16u37t8CwDxDGuSNhFds5Zd?=
 =?us-ascii?Q?rbB44BTUVfH4A+J2+UOny9vmcaEX2B256ssqSRdzDyBq4w91YWtIwkac0KWG?=
 =?us-ascii?Q?zSpW10pB6LEAqqhyc4DDwQbp/6cxBIqBRdqk5oKjATfE0HJp8nU+RL2nSYn+?=
 =?us-ascii?Q?W4rsCdUehaHg6wQCDZ146DILIAALHPKl3eVadXRvtgeSYxZ+MZcxEA2Vc3T0?=
 =?us-ascii?Q?zqPOv2mFQwLT/A2lvMAFAntASPYpjs4K3k70MK6A6O+KTmfAQ8ANZtSl4e/2?=
 =?us-ascii?Q?PFG6a46/acswgwjABTF2BY4o8JyCcmFINCfjr5vD2T0oJQ5GLhauoGlmAS6P?=
 =?us-ascii?Q?eoGApsPqxUk4EQTm2YwEo6Sfzrt/mHcorvigOpmA/0GzOzEi3nZZGYOvi/ox?=
 =?us-ascii?Q?a2C9V1mvek7/c5UA+Jaa50C81FGMlxpgfxruGCVFjy6V+w9PislN3yEDZDwT?=
 =?us-ascii?Q?2PJN9hGyI17+o/28a6IhmsX/WP57AtL/jjknI8F2lyeVuJg6cGMS1rSCQUjz?=
 =?us-ascii?Q?H/G0GbzZ8W0zKLi0mF6rF/Nw7jkXOK1s8xWeonSfJS/jxORslbl9wwKyQDoL?=
 =?us-ascii?Q?S6w7ex297zyEYxaQ8J5jZAcZSKvtGek/K8o32vOTtioVUyNIFmYXMkXqwI9t?=
 =?us-ascii?Q?rnweZo3llEiJxYGjxXtrEl/Rkrxr3QF6szdYSH+7GnNXLZZQUNJOOIuop1xO?=
 =?us-ascii?Q?QbbKTfACSnlstCporvHSjAYJjiKbiNeL/gAhl22l4VbjToXgLEg2fo2r0b6Z?=
 =?us-ascii?Q?w7Q49vhlQCFf/nSqFgost1Bxq5YSs1rW358YvOhHb6a3b4HggugAnFcZ1nYe?=
 =?us-ascii?Q?AVnNiOikfqoXpDnPfLbBlZ4VWv01Gqd0HVRFIEJsRiZZMcBFKB/AtMviM95S?=
 =?us-ascii?Q?UUCxU9Aq+CJaC2IgzY9NA8kSjrnRyQLyS9+dbi3w5alHXraKalzrtWsJjxkN?=
 =?us-ascii?Q?IjlQ1D5JpPFVUUYEvPYA8N3D1Fpjw5hQ9kvEl/R6HqHrlntPFvnBs1tTbnBS?=
 =?us-ascii?Q?dsZpf1/vCg57Z3lSz7Vx+GFLGtHPvAykddmXT8rRasBAZp71eJgrm8cnuhsc?=
 =?us-ascii?Q?wNVr9Uu0GNjqndTomWWZnGGMRitgAZwJwa5l29OAaXCOm8Sqpow8iSYBYquv?=
 =?us-ascii?Q?ncX5MypZUJ8MWK63JghTw6AYBpBzQ2aUjEA+qT9pBs6Evg61ul9Ahtfg7tNn?=
 =?us-ascii?Q?xAlwmgOaPmoc0VwjdSbYNiGnExzikZQNDOxnkG0zAkhMEhBLDeY0oVg7t/9Y?=
 =?us-ascii?Q?9NP+LjhxZ2VOsFexTwSjQ85nXk4Cenxp5mgOU4fEKfEk0Q+4iIrMiDK5wD9o?=
 =?us-ascii?Q?GaNmZHwu+3ey4q+qkgsYtVCN2NeKcvgpTJfU25+mgdY2uU52j+aI0Va9BvMc?=
 =?us-ascii?Q?Fe2/QKywN0v++KhaF+ZImUUGUUaMeWAdryOh7LIHHEV4IkhNP3rEMlEP2+uk?=
 =?us-ascii?Q?9geU0jhTS4P599ElA9hk07Svx2ssUSs=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e01ffa8-1dc9-461f-bf56-08da3a377727
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:12.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YISOtv4zoBDsi6ItrHAMXhofCnj01cST1hw+Af/nxZIrfQ/0Cf2m8a6Ml6yZv0owRygtupysz8f1SIHun5vAVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

This patch reflects the first flag in __mptcp_subflow_push_pending.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d6aef4b13b8a..96cf1620348b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1634,23 +1634,34 @@ static void __mptcp_subflow_push_pending(struct soc=
k *sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_sched_get_send(mptcp_sk(sk));
-			if (!xmit_ssk)
-				goto out;
-			if (xmit_ssk !=3D ssk) {
-				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
-						       MPTCP_DELEGATE_SEND);
-				goto out;
+			if (first) {
+				xmit_ssk =3D ssk;
+
+				if (!xmit_ssk)
+					goto out;
+				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <=3D 0)
+					goto out;
+				first =3D false;
+			} else {
+				xmit_ssk =3D mptcp_sched_get_send(mptcp_sk(sk));
+
+				if (!xmit_ssk)
+					goto out;
+				if (xmit_ssk !=3D ssk) {
+					mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
+							       MPTCP_DELEGATE_SEND);
+					goto out;
+				}
+
+				ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
+				if (ret <=3D 0)
+					goto out;
 			}
=20
-			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
-			if (ret <=3D 0)
-				goto out;
-
 			info.sent +=3D ret;
 			copied +=3D ret;
 			len -=3D ret;
-			first =3D false;
=20
 			mptcp_update_post_push(msk, dfrag, ret);
 		}
--=20
2.34.1

