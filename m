Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE418D
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648464489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GSL0zvIJAI1SUfhwR/NIsW+A+eGdvTismxpeILkywf8=;
	b=nfyfxJ0pJsesJ3SHI4vElO9DMIqoLpY39bhhLrySFKg3fkRBUnJAEF3oKGi2lEgnRMdk57
	eigDqp2u4wu+PXMAblqWIIpSrEDWKADOy76awRNydudvBZEina4X8aY1ox7lrz0a2wfPa+
	tQX+r3q9ZICABtk4MJC6gov8yIZaKEk=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-QlKUKlcJNcmoOkqfM8b2cg-1; Mon, 28 Mar 2022 12:48:08 +0200
X-MC-Unique: QlKUKlcJNcmoOkqfM8b2cg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USp8IRgEjnzixnUPMldJCpc4NLKlrgm3jY06No9qJB2H+SOTRHBqMgzNQ4Tf9bGxSr08WdI/yrRosyKKhloX22Ny6qy9ZnuudvLJf41x0Sar5nruYMhlB/PCKRRYyJYroaQ7y0O1+FRLUp7XvcB2nQBJ47cUkigAAL6asK2H8/suupZAClGUCCwT2q9nx40BbzTRBRLaUgrOb4ylvHlQ7G5VV1jWBWKIwO2z8QhNZSRMiJr8gg9HHyp4vCurRgnrMKQZS6d9dTl0UOVNkxSObsSm3+YwMGX/Twlpy21m9soR3L40wt2iMtPXz0/WnzZiwcZlNUX2pEOeK4bCJEX8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ShxFcBIQwld0j608NPbrTTWrtkQaSOGSw3/cDnVVdU=;
 b=AJZ0lEY+u0pwSTdFShATUuB8M8v+todJQ7H51MUBH4mLv7TpBo+V8RZB3h/urj7wf/cydyOZWi8H7NhPo47KiG7MlN5R1Ae1iT+iosTqsq+VvdTRZXePWZPR3pAubZOHGbDSET+GRA81obOdstUp8TbGWxB2fdjMRAJKUethL8LKVVFWCp0190vIUY/a6GD/WLLFectL49XkxpbnyM5Wl9tACNV3A7SGzgjAqfSuS1WCWavFjz65+B7tJzm/sJpO0J38rP4m7OGGDGHum8NKt97cfLNMP+TIlQdvKie6wANE+7czuDO769frCT7FYaGF/fNLnuu9R5Y9+g0Ei6kRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB3956.eurprd04.prod.outlook.com (2603:10a6:208:5d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 10:48:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 10:48:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add sched in mptcp_sock"
Date: Mon, 28 Mar 2022 18:48:12 +0800
Message-ID: <090c58246a1c18430c27653ded9b3aa9281483ee.1648464465.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97d9ae42-70e1-46c3-fd2c-08da10a87101
X-MS-TrafficTypeDiagnostic: AM0PR04MB3956:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB3956B59D500A7A52B1C8CD6DF81D9@AM0PR04MB3956.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mXFgdM8DTjZ1zjT7Riyz8d2GHb2DjwBW7g47o2OJYdU3jhR7H6LEuB3m0KGOulG2jBiU3L4Wz9AFiFZ99dxAzojY3UVwZwryCQisrkeYNdIU4dpnePJKNO03U4hQ2EGDHYxmrVSkix2Pqunv0siWjknb2l6y34U4MgVuPTTWdgpeTn+JWwOEgTnvfgHpK9FmT+UYNlHL/PHB2XH2uNp1oTmBlJ3Lgq5+FTbWbx1fs1XDzD+cvWq1r0suQdVPGkyXzcUM60RQSenFGjpVITMaBanqmiknRhka3QvnoZVjM9QC3vl8kJ8/zrmYXT7qM/t059MeBhxxAaqsQIHhdQIQoojFa+s+GbgRfx2pcqxWFBhTVoEfqM0jjIXeKkgGvSyVeILn3jwxKdXNUKHDHykfJn8MmpNdwdUWi5KD+OiXpSdCstZ/yu1qkyc8zlwnY+FTZtupKhT2QtXMWiUpN0vX8nY697P7pBQwrM2Plv8Aby3taRnUX0w7VWBVK4KpZ7VId6DdHaN7OK3mB4QuuFP4Js/EZthPbqTXnkuEBQbvGl/a1bCHKKT5zWL95XeekSTj0I8yFl5LIDqHNbS5gVI0tNXE5Udk8RsqDGA+DFE+NlxbHLrpCWbQmOFWQOhdFzJKwMgahJY9OX7RF10BD0Gmt9GuF92bpoZPmAk8FJ6B8FgBn/3mYLeA2/pvOOkzvBzSvvu/nEZr4ptUv7md9lPNbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(6506007)(6916009)(8936002)(2616005)(508600001)(2906002)(316002)(86362001)(66946007)(8676002)(36756003)(66476007)(66556008)(6486002)(26005)(6666004)(5660300002)(186003)(38100700002)(4326008)(44832011)(6512007)(4744005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8YR/HuWB43eiCMBKhTUTHOEHJc9h8MwNFeL6DTZQHb8dm6KQRhZxIghp32FY?=
 =?us-ascii?Q?b5iO3eZwBL80QLmPWfZcQcAyYyXxJZvd/wXK8h6N8+cbM4lu7kkEvZVywci1?=
 =?us-ascii?Q?dbYkVTqX9AzMcVSgzl7LPj2Wm7DVm73I7WUDmDTtI+7eBVUWVo4NeqWhMdfa?=
 =?us-ascii?Q?vy5am4ePXdcwn1EKI6hibHVR70HdRqVa3n2j1Zz44NVGmd5yrcNAQXRQlCjo?=
 =?us-ascii?Q?1imVKybCAmA0WJpVoGKCQs3blz7t8EVvF2Q5JT0gtIoXi7Ap476VUYEWprr7?=
 =?us-ascii?Q?Zx1SlZ2fRdTP2FZU1H/NVxUeBpu1jhCruIRY0U4jFi6bFkOMUDyv0OgXKbdV?=
 =?us-ascii?Q?SuvY+b8DCn5HMfo+HpWWtvL7+XaYVV47f4naoNjg6AOt37ydKd5LUqJY2Xfr?=
 =?us-ascii?Q?s+QrSShn+fIiog6wlKonGj0CE8NOppZ2bR3rrcUQp9Z/OlOrn2WGlpat+1wi?=
 =?us-ascii?Q?zEMcL1L3PsbcG7ZMgyo71pzIrgXpUMkRoneg/pCDyrTHQvLRFWJdqm2p9UiT?=
 =?us-ascii?Q?nPVsj3I8M8y/+/SWogSCSW8ldoWC/UTJj54HGwDIujqj4T9GuUUPa4SPOM1f?=
 =?us-ascii?Q?BdGclIVjh/ZyP7TC9S8rLGci+4fzkK7Soru2bhq7acIzoOaupbNeB0BYAoNJ?=
 =?us-ascii?Q?GCsWiFlSkScyU0YOvsODZLge+9mpaoHbILJ9B/9Hz9oGfKXNj6Xh/bmiDvWC?=
 =?us-ascii?Q?M9o6XZcIZikQICW4rFoBvqBWefZBPItYr0V1jEdp66mIa3pioMUJEorcREYJ?=
 =?us-ascii?Q?KYD41RkqHtmBQkhjuqrmjkB792j0icKpGwpKV+H3gV9emTmLIbbgFh+3rJwl?=
 =?us-ascii?Q?gz5WrZxUfqd0MpYz8t5EyBi45b4rkDQCN/FqT+yzGcItuld6e5MKrIETSguI?=
 =?us-ascii?Q?Dbrxc3tyk9rNsjYdpHubuhKgndcP+FeGJmJRrYYOT+zCjyT9dCnYzR5j+ocx?=
 =?us-ascii?Q?oAriXsQIaOTauFSdz131bAICPou//4qzteqGNo7toBKpGt7c+Rfbw9O0zcLb?=
 =?us-ascii?Q?kmT4E0m9aMzyyti+j/ZL/Tv+IMxH9LvjBS8lNnc83b/kQ+dgSLeuaMTdnpsH?=
 =?us-ascii?Q?5TzVIyvmYFP+xj/Z7M6H6LhYgg9+EoKsZPJDY9n78+CZtNsk44lR9Q2idvQW?=
 =?us-ascii?Q?v/7uZDp5SmmdqX9yr+1cVjy1R15iaqU6aL2L84ncBjoKrNe22Ee5dFdpLb4M?=
 =?us-ascii?Q?d9hnm9sYGMWId+t7ksreSiAOZcMEULwArqRsfRU2s2KUquspXR8Tm/5UCM9V?=
 =?us-ascii?Q?U06CfXAeRJHtRRw6ToyQXSGRXUd6VTvYV3vIpSvhtCPCyPitjzsubi3S9iLs?=
 =?us-ascii?Q?9GfLziuzaIZ88X/fzHt8KjwF3JTYknk0kS/UfZuC6XR9j9eM6Bzz3dYW/UwT?=
 =?us-ascii?Q?eLwF183NhdMd+InNEXqjVCc+46dATV8tIqISxZE2KT6YvnvunwM1ri3Nc/oC?=
 =?us-ascii?Q?EnQ/OzzCCCHtmqQjmecuL4mxuCgQnBPkh5/WVasLhjtIQDP4MEo9yHtGQl49?=
 =?us-ascii?Q?cxC1KiBhP91xtQDo+EinfKj5+1Tv9w/08PrswOrXaP7YuCGl/1+rHgF1Tof2?=
 =?us-ascii?Q?JosBcRTyrulPPXMkJUTdWfn/3ODI+p3/lQohkWMI0hF5EWAujhmVfksTv+xd?=
 =?us-ascii?Q?juPnJhrE92716JnXGXcYt69UzAI9s2fQcMkEyyajqySZpVmhv70RiVXwKpk6?=
 =?us-ascii?Q?EWqeDoWhOWtn3Z6K93fSnpimq3Dn9ZHOVa34OJvzHNwN8yXZezqED2x7D3O9?=
 =?us-ascii?Q?cabYCkQ814/EDUnKidDo3+kSGqXBuBI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d9ae42-70e1-46c3-fd2c-08da10a87101
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 10:48:06.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJR5zfCSmjFPDhcoVc55svlcoqMIpbKv9Or0s94ga3Qo80iFD7Gwh+En5+OhfneH23iOxHrhpp86wtjUli31BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956

Do nothing when msk->sched is NULL in mptcp_release_sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9b3a3157111d..3ce045a8739e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -147,7 +147,10 @@ int mptcp_init_sched(struct mptcp_sock *msk,
=20
 void mptcp_release_sched(struct mptcp_sock *msk)
 {
-	if (msk->sched && msk->sched->release)
+	if (!msk->sched)
+		return;
+
+	if (msk->sched->release)
 		msk->sched->release(msk);
 	bpf_module_put(msk->sched, msk->sched->owner);
 	msk->sched =3D NULL;
--=20
2.34.1

