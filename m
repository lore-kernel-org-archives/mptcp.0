Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113232C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gx3rvTZa8oQMCuYZJwaqi/mID0CKRYkYi+dF5S+vwwE=;
	b=RhT29Ou68Cn0SY4+z58xze+8bcJKUR4T5pf900j0Y6zXUD6vbuJJ4aaIgrziq61Gz2c5+4
	otALfwpzKY5R8fmmpXtmYkMq/Isp/IOgMG7ZFGWtUUyoCv4LS/7CAQJiZNGGvB8LV6tmVi
	FI52+vYCtsciYy/Hd7jS8EMV7nx4W+8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-mjfyXcnHONWuXycT8qTZ-Q-1; Fri, 07 Jan 2022 06:51:59 +0100
X-MC-Unique: mjfyXcnHONWuXycT8qTZ-Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzfOlx9dF863+cRItoymaPgFXoZN975W4BCcgKgdFulzd3/aGab0NeL0rLLCx0ckczUNx8KuMRf3KbGc04p7MyaWcdAgDgn+QxP1u6hIUGUyQJtr47s7D9KcdzUbyCLRtpdvSZPGvdxgmljaaBrXsqhuSlm+Af19oVnFOKk/Jyh31aATLvML87VSZUFg0BbM3016Vuu/wrXWQXlPfViaScMFPx17eV+ls2KIuXgX5D/HvE7fC+muGc4pIFL2YNJUuFU2jH6a9DyFF7YOBKUzzwx8iEDUCvtZ8hDYNzzBgTJJoQ7ar9m6BqOt+VVGdkiDJMnCPJdEtcYeAkjyyPcfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoDTP6gRBoFZGVfrVo8CmWJav7H7k2kWMmqDo0O0THM=;
 b=eNbJG3uu8gIssYXSxmSXUjee/LayRLz4BGnpc03Bm7f0lS3us7nD+v1NIYKOaoJo7vsCkUbFvgSiT99OtRuKrTnrLwqtxMf56CFnfqEgWn6JdH5SSO8YokuBV6q/d1K6whar9VqHjlD1JCz/IdbSOSMGZcGVE+VazgT97mIVVuhRbjL68CzYMZrlc06fV4udVWB7qb3Sbk8NRPUzcCIFnXuBiKWneuo+cUjsGeyKp/ZnfpvgNo/yerduIdg+fWt9HwJPcfLPqcMvsmXcTCdRNT3CFz6k9KJLJ3Wala8obARsqmi988i8Qdq8nWDvtv9/MvwNDNXXDLdvWDg5/Ty0zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:51:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:51:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/9] use 'ip mptcp' in selftests
Date: Fri,  7 Jan 2022 13:51:42 +0800
Message-ID: <cover.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70c4a376-86da-47bb-2eb4-08d9d1a1d141
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB27318C5D846FCB2F4603F5C6F84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M3U6H3yqLbFIH64XTxMNCLw9gnPBrlHAZ+lkwCWaQnD3CxpFyTAiTzc1GuP2XylR2Z4NAlSz1WMIpaZLzPnUijJoqH4ynjVAjKp6WRDIqWTwM/6D77c10wthKLwWJUTSDJjdRW/y2HSzhRsKGlHTBzTiuxTyNoFTtrpmggiQH/5eUbczPJ4RwGK7BhAjt7DfJksrNeiLjUCovQFNAt3gkl82RcJ7yxTKlQ9E9UvnOmGFhz0q9DS4dzyghIQtPJySnsncEh/5eJ0dwVMUyWKezFEoJP9LZiBZn2sf3wxk06LUgICrjhdUQkyA2KiTeNvR+nwcclw8kumwwTb1Pl0SpSIXOy+TqhKfJicGAzlslM8iXSh1+fYAtyiZ8aCC8FV+13FGk9yswhEdbav/9zFCjKIkBkRLhkh0X3CDJKS2negFx+UDLEEAIUu1WQ1TCDAbDQ4OerF2kMJSgSccNNEeV7A1hpDp68psZO8cP5GQHUmIlBkz8wx3wnrdny4Y1j7xpghuuDZqNnFE/4oVs92dcIRdL6Z4fyYvcLNAq1sYOikVlqvjgDQzIWSEVQb1TaXRK8UZJxPHGLns3M9ov50p5Q0zOn7WMIeI+skrSkTsAYtXURTGL1pjzn/2iXJMx8kneLW6eXiHO5YZpxxRzCqaNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(4744005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(6666004)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80hOb2v/2v1XbdqfA6bToDMXhprlK1e5uNI01PeenzuzSUz/2nU+hlVw0C55?=
 =?us-ascii?Q?cUjGhZb6vJCQKIPrBMRMsoa70zKVPzM/beH5R/wX+41GIFN3Mmt3aTi3FuJW?=
 =?us-ascii?Q?rL+Zp9maagi//IQSolq3BuWTmm8B1mBqw5uFsLINSGlIgTJwcXfL2JVCFDIC?=
 =?us-ascii?Q?OCn2RixO8f+Ms/Nebf86+/EAnRtmILie1oJiAIy0Hl419CBf42v5qk9t4JKx?=
 =?us-ascii?Q?cWPSMsnWIF96nfVueTHCZk93Vx+ka5cn0jVYLN0QNbdfxxOk3O24qIpsvEFB?=
 =?us-ascii?Q?cvYO5OxOTkJGkBNsJ00950SwJobwsGiQRpPM2EH31cWNfrjsKzyVt5huvbKo?=
 =?us-ascii?Q?bdfVJMqhx9JuWz8syXM40TaQZTHiDS7VrPflclqrsJvwVF6HywDJBrGs5JcM?=
 =?us-ascii?Q?uYG7F6YWbq+cZbtSHFwBZV9YnjpuzWs2ee31iXYrmH35H/W0OmXFZr9gmPUx?=
 =?us-ascii?Q?8R37FEF9h3LrNFwkLIjK8pxvzy3PWQKsk5CtJB45BYvmHAZBvdV1kXfCYOLl?=
 =?us-ascii?Q?Xuf+XrSqh9WftXE3o4TWkxqIh4mTVYNpwkXCprdmET3GP35OgFIX4aCYDA1k?=
 =?us-ascii?Q?L/WydIyoDT2hFMrSqFjJNjDsXr+padVYA/YTI7CZ25lZFjIsAJlgljwRxK6R?=
 =?us-ascii?Q?dq5US5tbAd7eMNLR518OzE+NvJ3D1JZbRSB+Z9rx7mA6F+MwqGzpZq5+K0IL?=
 =?us-ascii?Q?WxVYP216ARtBhYRbc7xs56NFo5fp7U9UCpn/FD7INxEgl0bZR1a98iY1rv9F?=
 =?us-ascii?Q?hXmm6R0jU3wo5Z59QECGo5CLm/1Ey4HxK5OSEywGGoS0iIQysfKletLBHOOu?=
 =?us-ascii?Q?BUKh5tiqvSO6LmOVVIveVB9T5yfD0VRZc6b3FO3owN9daJODpmZtqjFZdwdo?=
 =?us-ascii?Q?uM9e/qMNmsRn2ZBE/UYSe6kex2CowWPP8egZFGUmWdg1bFpE734e0MuN+PoV?=
 =?us-ascii?Q?W9LNk+Jg99dLpqnEDTBuRM0notOVNJHPsy09oH5JELl6VKHIxF4vqybLNa6X?=
 =?us-ascii?Q?94nx+D2AcKzjz8entHmEk5OTUd2wzEexlaTfh7sX2ZLGPJwPnfkF1O+GzXmo?=
 =?us-ascii?Q?ZOcqTgpKsI7mc7Lq1j8xiAROVpf3digIepZi5DDbAbpU8NSIGdUlj428EtCt?=
 =?us-ascii?Q?L9/NuzC6sqvCYSHr4gRi0Gbjr3TebKo0Pec1mT3BpjxxZTvPzxisz4Rbt9og?=
 =?us-ascii?Q?Cbzp9cn7FF/bHpCqjadF3vxgtsOT2dJNQYg0jByf3t0tfNx0U7THWqT582EI?=
 =?us-ascii?Q?FryFSmZzHPh0LxdmkmkWQPC3ZVWP2Bf8BophHbORWDKu1skGUbSKUR4P0vvN?=
 =?us-ascii?Q?gID68G2Fd8UvFSyOViy/ap0nG1gbu7Fv78BbK95bqtCLJ18c3sBudQFp08ZD?=
 =?us-ascii?Q?JOV01NG9DOxZJx0ZiHsZQ2M6rVVciyyNEZvEnjS/5crr+3AKHU6otED6OWgc?=
 =?us-ascii?Q?JllP/xUkG9/Ek3F8OeAy/BWktvSvOg1FgMdf2yK/TvYZb5WJx6Y0Z7adn1wb?=
 =?us-ascii?Q?Bd0Xlar64R3370FwMbmBfLHwD2xMHsKY0LAMSGr/rUO7h3gAwQ2Aa1c3oeFF?=
 =?us-ascii?Q?Mr0hnamSQpdD0vQQs3/35TWNM8PgLiO8uRJsZPw4nM1rSgQfhJZmXeBMjPj4?=
 =?us-ascii?Q?zeOsOmsSCtZgzV9Aoeg0MEc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c4a376-86da-47bb-2eb4-08d9d1a1d141
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:51:58.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnZNUiXASZxUgenNm+rynmyIvssUMIGLBJpUxc6BgM4li3qFdxqAvp2HXafcVaZkHQASL+WhqcOn847K/3Th+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

v2:
 - use both ip_mptcp and pm_nl_ctl in mptcp_join.sh, instead of
   replaceing pm_nl_ctl in v1.
 - drop last thress patches in v1, keep using pm_nl_ctl in mptcp_sockopt.sh=
,
   pm_netlink.sh and simult_flows.sh

This patchset replaced all the pm_nl_ctl commands in selftests with the
'ip mptcp' commands.

Geliang Tang (9):
  selftests: mptcp: rewrite removing tests
  selftests: mptcp: rewrite backup tests
  selftests: mptcp: implement pm_nl_set_limits
  selftests: mptcp: implement pm_nl_add_endpoint
  selftests: mptcp: implement pm_nl_del_endpoint
  selftests: mptcp: implement pm_nl_flush_endpoint
  selftests: mptcp: implement pm_nl_show_endpoint
  selftests: mptcp: implement pm_nl_set_endpoint
  selftests: mptcp: set ip_mptcp in command line

 .../testing/selftests/net/mptcp/mptcp_join.sh | 865 ++++++++++--------
 1 file changed, 498 insertions(+), 367 deletions(-)

--=20
2.31.1

