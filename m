Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322C29CA
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 07:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642662976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qJ0OkpFM5x8hOfMy2MYWP43l4cE1VD/mLWktxLFT9gY=;
	b=Z4V9dl3cvtdWuzseYThttiX1DasNBTrwj7BAeiGmnyZ5vn89zfN8xbp3puXzdsq234SXGQ
	d6GP8yZyhD+YxLrMutc0FimrO+HMf3sbfCVl8qAkUtexJygi6DJL4xp3QStqCGiKHF/jDV
	4IG4uUouVIw4Nx3BGVMV0S2HpoEcDjE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-5hOngowfPcCq2BbyomjJdQ-1; Thu, 20 Jan 2022 08:16:15 +0100
X-MC-Unique: 5hOngowfPcCq2BbyomjJdQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsFaZBk2S3bXagz1yWPPz3mYSsgyjyPPZcItBznR4RKebkQyOHq7UQvthTUo4le/+dV0ixF05qV+pTivpVVEwKHRsWcWjFBm/e/Jc+8DuGKcI0eoENXFnvijBavh5Kpsdyqh6NSSDxnu7X3hv2NmGzSjqFWTaWsWLXquuDxAzRJUCRjS8K3eszG/nPUIxcwAhqj/yVF679Z7CCIlB3yMs/bRsnR8Vu//8VDof5m8ZFoO1ECbZkjrxAuSrD+7o8NKqwxDC/DITY2d1gYN2Jj5ZbHCTfBQ1wZYZl5NxPq8y4CmtXJ/lUnjDGxeeVvCjVP9JgMk83qjKGJmeuJz05JH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhJ5hWYgHqSX1g37seXQQDp7t2lrZkFhus+gRB4hERA=;
 b=I27q27+eoV+qujgBOTDhHlS8IHLj5W4wCCVaoqFmyFgKya3OkWWGOpotO0hIYs0W0TmuefsneyYg1GO/OlOZxH3CdGrIGpHYRj4CiGu6r8GVXyT1nHlFLr29hThl/B0Ae+UQVq7TGRkY+rQDKKXONVDA1YCQB76pKVh2s9Kkhgb9lvcJ5XGUGaOOO1v8UtdWQ+xe/BK3VsxTN0ETao0+k4XWIYOd0u7m5tZOAuPRHOvhGqmtvTfbp1sYuOlTaJ4Up1nptv3ezkXHhTBR8tnzWgqGHBeApKZI7r9B9yICTatO/ZX8pwhYMlbC5LNn7CsY8bbhcjQKDNZ7Te/Vr0F6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4834.eurprd04.prod.outlook.com (2603:10a6:208:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 07:16:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::fcd9:b39c:2b94:f13c%6]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 07:16:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: set fullmesh flag in pm_nl_ctl"
Date: Thu, 20 Jan 2022 15:14:28 +0800
Message-ID: <62353f253ecc5eb7724f0599cf1baf087e2cfa5a.1642662752.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9caf0cc2-edf5-435c-4411-08d9dbe4bd8e
X-MS-TrafficTypeDiagnostic: AM0PR04MB4834:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4834832EF8BAD333B1A88856F85A9@AM0PR04MB4834.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XF7pqCgWXYKSgTtPszTpb3yy21/DQ6QIe/5Dv7t0OZdJ66KOw08juPHHQ/dLXqVUqTAST5cPfWO3r0SK/cUDIwJPwBiZysE8Wg7exqjz7WWeplaEAe0qCKr681aqTekpagN2zzl8o/2zSiWHdEi2ffAhs1eXX2OnLZoS0TvxU2JMDxGDa2gimp4evmuGktTC+pZN2nZqtF5TXiuas0PZ5/joJgItQZebt7gJCleZTTuCB6BOCpfDgDbd/8JN8W+7aDRiO0Co2Yk+4igjct9ayJeyUI6nIxxJCbzDrri58HJq6P2KRA1zjriKJKstxSNqWjmXOGHjRBTD42vrKLGOKvSIStB8GKe3yLWDFa6YQGY1kCN4fqhFMIop9JKd53SEX1UXY7HErT6w1pAdznsD/UvC18pzTtQcpisSNxaLG8fPK17QhpOq6H9qTSvr6NTmr1BXnoCQUQsXLRFYejkNlsG27McMUaUAJymBDqZKf2F6ZiUh6lB0eJs7x01qdgO5jESbrKuxayLXV7YYF4L/ydXlvD/+Ib3srtYFJ6X63kYCW8ue+pjWmOT+ytShsfeqeV2JpdSIP+pCWO7vmnUoMmdH7YFk0Mv0gkLDvkvrx7jEq9WL6xGQ+JOXEOqHq06kkWkqxdizhgzAXtUD1D7B3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(66946007)(6486002)(83380400001)(44832011)(186003)(26005)(6916009)(55236004)(8936002)(8676002)(6506007)(2906002)(6666004)(86362001)(66476007)(2616005)(508600001)(38100700002)(4326008)(107886003)(4744005)(36756003)(5660300002)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BuDveIXGCFx9DsaLk+DY5KBgJdKb8mmpmwgAm093lYYm7HtShMzLlwSD8ms6?=
 =?us-ascii?Q?7u89ftnRr5WYF4yJ55Ek8sJh7gWqY+MS7JmFTVm4LLJlJzkoM/64QTJeiVcG?=
 =?us-ascii?Q?XCsVkNxuHMpgzdUxzLOya7ahJsJC0fHQNjxCdKjfWC9pv5eOSaBx4wDkrEA7?=
 =?us-ascii?Q?cV+V+SHzjS35uQWNiU1JXM5UMZDM0ddnxWRDdo/DagJ/s5Pbt0bA5LHSJ0Dm?=
 =?us-ascii?Q?nAswNC0Q+OSrHfDVq+G64jsL2Y1zu7Y47f41AeeArWEog3BKehHlgQOuHhGc?=
 =?us-ascii?Q?Fbum9k8aNqLNUSh5m2do3KcRjIKD5P8qTGylXnWk5fsw+MmT4TRV30brVjiw?=
 =?us-ascii?Q?taIVMceIvlRVY9xdp96gKP7jnRzGTKGenwW2uMH9+dLXZPRi+br2YZ5PEcOD?=
 =?us-ascii?Q?cI4seLrV8U964ulRI1lq+Ys+0CkwThEXZu4XZy9AEXZCJuerYTeHe2O3Ry2R?=
 =?us-ascii?Q?tqkcjjxXXJy2IXozztY0DSdzZFm9xei/eveuo66nANA8brQqnDXftiPaxFye?=
 =?us-ascii?Q?zb4bYd0zaQ35AnkNVDHe4z6fca/TQDAWs792opFEPxl/KoQizphQwdbyw7Vq?=
 =?us-ascii?Q?rujmwWQL8mxVjI0dKNgHai1vGDsC2MWpzKnH8VAq7JX2mPNeJ5a85NnKTaEz?=
 =?us-ascii?Q?bqcPA/HWSt7osa3sMMAj/iGZmEp/dsPOE4aeLPZskcuQVJfbvN0RXPlj+KQY?=
 =?us-ascii?Q?PSggjf3MZ9K5UVJ9KcHlUWNI+/2/mTVigbgg0Ch9z2HPBS8z9THsePLf/ySo?=
 =?us-ascii?Q?tI4KsUO7XoyNFILLek/TQRkbUPXt0JQ+5gGgRXQRY3ERWNrd6FQv1T12yGxF?=
 =?us-ascii?Q?XC9XkEA9xTOVQuItwM6uAEokHiww6Oi/fHy+ASSGjH7p65YZ2wAckx3xZND/?=
 =?us-ascii?Q?Hg41PTNKsvpuSC+e5HEe5v0AAR9QND0CtJ7HJ3G4/cdCbewigv76ItHecbaC?=
 =?us-ascii?Q?0ZtZ6iUwvM26bfdYozrpMjpYdATxLex/8mxQ0pB6gytmRjGu4lF9SDlKZDQw?=
 =?us-ascii?Q?hSak/sw9R3I7XiZ435sW1D0sQ88qGqj04its/2zxHoYXTrUnLRSsznpWCdnr?=
 =?us-ascii?Q?3nBE/E+Kw/cxcqJD9yZQK4FsGKJA/1sw5sz2y8S3UyHtCqo9MsiodS8jUx1I?=
 =?us-ascii?Q?feBQdS+P8zXMVVBYh0pWaf1cjlHkF3F0fzBy3tsyITfhHYMOWSgofB9gAl34?=
 =?us-ascii?Q?qk3Jc8htvfFZDqfIhao6olezfKblxfXmN9zzYNdMiGwhOW6UE2G60Oc/AY2s?=
 =?us-ascii?Q?lk/wrvhZDu3qnudiaLMWopoaWWzrt/90C/FwnSIPp5lF4M3uYXgy0nWjnuYA?=
 =?us-ascii?Q?jSJZD4JfF55anrwm39oXEJjSYEwlrFsvmfYmN7khUhaQG2lkxDpwuJA7/nbW?=
 =?us-ascii?Q?ANJzyTtuzEz2przGZBWGqwDPMAmau52svee8PdfC+WsfCBEfWQlz7FQxckgk?=
 =?us-ascii?Q?m1ApgIyrYrlwcbNB3DCSJr2asmWOjMK/8ZZ5dOhqENScQlIq2qO/4mRAx2XW?=
 =?us-ascii?Q?mJOaWVlmaxSBC+yxNpfEkrSCnM2nA4giXd6SZhDDLIJrtKhs22EUQ3/4BuFP?=
 =?us-ascii?Q?6MRRfwVxUhbwcooqnv9ZKIPWTQ+K2Z1Ul212yCCDCx4EdqasjDodhhKYPGqs?=
 =?us-ascii?Q?1BNORCJXDswsJ0iCELwdmXg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9caf0cc2-edf5-435c-4411-08d9dbe4bd8e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 07:16:13.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xq1jzLCwTerWSzsR+uoXmlmKt3fikboASiAu+wjCljrBkqivfJZL5sB853LUvmc6Tk8sKsYl3TALYirn++/LMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4834

Drop this mismatched comment.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/=
selftests/net/mptcp/pm_nl_ctl.c
index 9b6db9d77223..152b84e44d69 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -704,7 +704,6 @@ int set_flags(int fd, int pm_family, int argc, char *ar=
gv[])
 			if (++arg >=3D argc)
 				error(1, 0, " missing flags value");
=20
-			/* do not support flag list yet */
 			for (str =3D argv[arg]; (tok =3D strtok(str, ","));
 			     str =3D NULL) {
 				if (!strcmp(tok, "backup"))
--=20
2.31.1

