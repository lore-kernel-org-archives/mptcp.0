Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FFA2C80
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=da77CzKdmfD+Kz2XVksynCt8W5HVZDec1w3l3OOiMkU=;
	b=koMlLxiK6/RQT+WIjcaKB0mrpoNYWks8o5aKdaEywM/qkU+TsPaZpEq/9o+SJ/mGytdv8M
	4N6Nv86CBIJoRecqYNap0JFD/qWBXxnuOu8wZKHSWI2jkY3uvMvk1QbdcK2i1b5GW2VDti
	FXNqYfFEiRcZsyceHSDt6i7R1n9ze6w=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-2MHTbHOxMMmYu_iXjv8bng-1; Fri, 14 Jan 2022 11:38:53 +0100
X-MC-Unique: 2MHTbHOxMMmYu_iXjv8bng-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo16DNBZpc2mh7yoC6jU1Uj4EbyDnSqwv5kg+1srfw2yAOlsSFF/zf06l3ExNT/fdmAJ3XhE/8NdbVboYvZrUWaQJKaU5ChX3NVnG5br9mqSV0YkC8YARVrtu8RBu9CoDxICMzGWEk1xX2G9R2wKPP37pRmcMfI6b5skYulvJX6ltEZMjb0hvqT7gstv4eSbXO28zO0egxtXmu7vGBNwH+3sPtf89iiPmRCzO+yurSU5a9i1rbBP77oUtdYkDpLUsKL0AXdZSsIT26zFsgCsz4Vy44Y4QiSlahksCIsdPq5qgURKT5VG6vhJyL4HlbGK9PR9NryczxjaFb8kefHubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=da77CzKdmfD+Kz2XVksynCt8W5HVZDec1w3l3OOiMkU=;
 b=nXiXHsNgenrCxxQ6jD5IyPKcjsVfWiucB0s2IoijUUOXQ3atT4+PprKU5GIF0sSe3otAUwC/nnANEaldmkgW1KuNX1jZQIc9CzP12uBDs7IO2jA05nU1LCvVjDWD5lwwhm45gO14fMfQoe8F5Zs2kGEcULekexqPTIS1vRmIhBKdlKgo3KdqsJ09ik9DovhvxofONGVdz0rzDgHKfhzjkTe1z6hv+Yy39YCiSfo6iUbAPoOCO0eSnaJ4nxUb5yvGTYAhJkzbXAcmaiAeMTLrUtuxkUm8Cqqdz/vwO4QCsVNaKZX6gAhwtIcmWbgK0Fkb8DmAKV4243J6F9ALLcjJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB8847.eurprd04.prod.outlook.com (2603:10a6:102:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 10:38:52 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:38:52 +0000
Date: Fri, 14 Jan 2022 18:38:55 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iproute-next v4 4/4] mptcp: add the fullmesh flag setting
 support
Message-ID: <20220114103855.GA13060@dhcp-10-157-36-190>
References: <cover.1641978967.git.geliang.tang@suse.com>
 <743abd8f6b8311bd0f5747980982b511299e3453.1641979131.git.geliang.tang@suse.com>
 <b48ac912-ec4f-5be1-b74d-552a4d704e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b48ac912-ec4f-5be1-b74d-552a4d704e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:202:2e::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b76a4403-2a8e-475f-3248-08d9d74a0ea7
X-MS-TrafficTypeDiagnostic: PAXPR04MB8847:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB8847770295035696F7F12532F8549@PAXPR04MB8847.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	St+3fqboC1tG8H7uXatve/BetJH5LSLwKSSaS4oagoVG/noC2PxYwr+fa+5N6gybRtn8331vdV4j5D1XJ04QaHBkpeobCwuerIIrfOP1315837cVWowyGrxk4lQCZoSSaVqeB5CuEdc+0j2thq3OtAhvOAKEnwpPy1ljPZRxu312SnBQlbWo0WAhX0vFDtYIXLLrTvjKZrO1dmEHGGPHQP0pDxK93X9Kywo0MGYJg5gRhjMWB1+uej4pqhxrdwC4MTa1eSpYA8NjRiRB7ZUfVgu5MazvTUHzfd/z3yP8xde4QA0DMSuzAleFrklR5G0FtLtEvMtfyFBQcCtp+u4pNEJSIChVXJYwCDawlSJgndYKWpbOjsBn9sugvxexhuSdVAkd+vYgO9OYTco1/qbT0KlwJw5EuUjI5CXpVG0AHjb7BhgWNDd0zU7Y/MgsROdE8EsJWvMPAR2HNtuexTSaJAbrg9NJYr9UfxlkpICbkZUbH12QuuklEs8oEflsHfIJxaXgeEQXGROSPAqa+Jlwb+DQNAqrBcZFzo4A2ckasjuJcIkOrbUkIuqfwk0KG4n1CZxAca9bayp6FA+YDwxkLJ7BCeHsG00KpJCFdhI6y48amcsN3erzxUj/gJFXC+28NAIYXsnX0jH8cXiwKwt73A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8676002)(5660300002)(44832011)(55236004)(26005)(8936002)(2906002)(6486002)(508600001)(4326008)(33716001)(186003)(1076003)(66476007)(66946007)(316002)(33656002)(9686003)(6512007)(86362001)(6916009)(6506007)(83380400001)(38100700002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vk8ISy1HIY1Gf7fK2VQMg++yPRSPz6BO1aWUpAXiojnbK9DkZXkylMYRbeWK?=
 =?us-ascii?Q?X3AspNE9JthiXnRgRlm1CTMYr22dS5wquZN5KOMqojHPPtXlsEG3z175FuVo?=
 =?us-ascii?Q?8U+WlLAmE56KorA66Psnha6Fx9ugAwdhn0FL1peT8pUcilp+E1LdYA+yjfwU?=
 =?us-ascii?Q?/xA37PGytLaKkQ25qhmBb+FjmgeT4HST4q5/VrE7dPfE0x8Swe4Jfq59LUGv?=
 =?us-ascii?Q?aunKG+a0UZc3wva4s8MFa591EG/4UMpOjtHU+eoL4WeaRrOncOMTilGY5oKb?=
 =?us-ascii?Q?5Cvw28HXzToDHrgrxT4FsZpIEWqc8Y3EItND98Az/LXOKHZWlttha8jHuCFo?=
 =?us-ascii?Q?i+OvT4zKpNznftgGJXwuZPF7Cgo6wwXdLoYlDT0oZ5mj2l/FKbLkZg2u+ltm?=
 =?us-ascii?Q?gz1EkVA3s4AvURqDSZzZ87y/pMLNjDtil2q6nduwZMlYEM0Srv77oUn9Ok6o?=
 =?us-ascii?Q?njq9rChshmDEBFbzxMLHJVtpPz0OwG48WyQv1x3LCKWvO1ys7rCjXyOc5cxh?=
 =?us-ascii?Q?q/SzriE0Zp9tMsyYHqIrAPIaATXkFtkvvP1WA7UZ9O7ljRm0f4YaID8Q8Q6o?=
 =?us-ascii?Q?5uQl8joAUiMkSfBDFEskegCbqr7QwHwEByOAOR0l5vzd+7NMYALNMEoarJnC?=
 =?us-ascii?Q?xBlA3qpJLgJFmS7M5VqigZFDq2NkEVnZJID4XuqrIq6Mow31iQqjY0DYoqLk?=
 =?us-ascii?Q?YPz3d8+71n7TTjjPF88OPsOzW0kHzlBZviF0gsjML9LBBHc+RrOFxNT6GFFh?=
 =?us-ascii?Q?tyjWRCmlqKjx2nLHqEugcrt/qw7wmKX7eFdLE1B464GBAwRkM3JOZ6YoHjsb?=
 =?us-ascii?Q?To/rZ3m/A+jf7bSX9deP2d4lHd9T1ijvdlh0jbVKWbx/9DES+xJJH3/aBnen?=
 =?us-ascii?Q?sLF+F+qa/JPO+0qRv5BN1k0hjqDv/4K5tcBlkhlANwwnbn0O0m3uHqD2NMr8?=
 =?us-ascii?Q?ZseGDQrN/GXezCpbOf+KFIy94+6j2F0lc6E4CrC8dZ0XwX7FTJ8VSnLvKHgE?=
 =?us-ascii?Q?xKYT23aVKqlmPonuMjMWQoXGUowzNrzaqTbJhm/64vB7789Z2cS2FRbQ0FB5?=
 =?us-ascii?Q?NbjaUcYRNG6VE77v1/gur7AXkEjNTDmnP90JaEJO8T/yR8HLEtoLGXC57SuB?=
 =?us-ascii?Q?ZwSNxUJDidye7OKkWg97RrOxGgSM0oUQt/I80zRfUFUUgHDwvozRUSpvLlJs?=
 =?us-ascii?Q?wHFoqNXRC9kEHjUh2ZQhD9euP72p/5CLxDfuUs+SToq/qgEcesNt59UUQoIa?=
 =?us-ascii?Q?4fFcbdPxp7Y3B/+xXPi5yaCpgANuW95nAFqv3LdNVYXmbPCE89xwZfHd7lZF?=
 =?us-ascii?Q?0CrS5vWw+GJ/s3ieldM/B3bOftaYWzLF1E5Up4AUbACu5QeyLFMyY131/eF3?=
 =?us-ascii?Q?mJLRlggtSnE96M/1sWwxSHKSKdNm9vkLOD260oqZgbywBm0Oq1QYYpC4cjGW?=
 =?us-ascii?Q?CbGwRGOtSIH80RlV7aOvNIKiom2tMrk2wAFNAwJhpSJaP5LANQhIQ5X2Op7/?=
 =?us-ascii?Q?+bJZFpmfNuuh8ZlOQBhlW0Rz1A7qfYEBfRyTiC3vy9h9UQbje13qWUZ7SFgr?=
 =?us-ascii?Q?LNRBQot4zodpdpVOgnwQsRTkTNmKSLcFRTfmSKPDXtHuTKL4AH9+IxyD/aLn?=
 =?us-ascii?Q?wBdWvBZ1qJBVhUAygPx/FEM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76a4403-2a8e-475f-3248-08d9d74a0ea7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:38:52.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHhQjMhRNwNlr1rqIHcV6ai9NHqveW/GB0etps/6rdK434jn8rdVWz6qcGG79jQ8gb/mqR0TZZFApXmuuxnvVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8847

On Thu, Jan 13, 2022 at 03:44:42PM -0800, Mat Martineau wrote:
> On Wed, 12 Jan 2022, Geliang Tang wrote:
> 
> > This patch added the fullmesh flag setting support.
> > 
> > ip mptcp endpoint change id 1 fullmesh
> > ip mptcp endpoint change id 1 nofullmesh
> > 
> > Added the fullmesh flag check for the adding address too.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > v4:
> > - put into 'fullmesh flag setting support' serirs.
> > - No code changed.
> > 
> 
> The patch looks good to me:
> 
> Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Hi Mat,

This patch is updated for support to set backup and fullmesh flags
together. I just sent out a v5.

> 
> 
> For future patches that might involve more than one repository, it is
> helpful to group them in a separate series for each repository (for example,
> posting separately for this patch and the previous 3 mptcp-next patches).
> Noting the dependencies in the cover letters or notes section of the commit
> message is very helpful, thanks for doing that. Keeping the series separated
> helps with using tools like patchew and b4.
> 
> Thanks!
> 
> -Mat
> 
> > v2:
> > - drop MPTCP_PM_ADDR_FLAG_NOFULLMESH.
> > - rename MPTCP_PM_ADDR_FLAG_NOBACKUP to MPTCP_PM_ADDR_FLAG_NONE.
> > - Needs to apply the patch "mptcp: add id check for deleting address"
> > first.
> > ---
> > ip/ipmptcp.c        | 16 ++++++++++++----
> > man/man8/ip-mptcp.8 |  8 ++++++--
> > 2 files changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
> > index f85c49a8..564500a8 100644
> > --- a/ip/ipmptcp.c
> > +++ b/ip/ipmptcp.c
> > @@ -25,7 +25,8 @@ static void usage(void)
> > 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
> > 		"				      [ port NR ] [ FLAG-LIST ]\n"
> > 		"	ip mptcp endpoint delete id ID [ ADDRESS ]\n"
> > -		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
> > +		"	ip mptcp endpoint change id ID [ backup | nobackup |\n"
> > +		"					 fullmesh | nofullmesh ]\n"
> > 		"	ip mptcp endpoint show [ id ID ]\n"
> > 		"	ip mptcp endpoint flush\n"
> > 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
> > @@ -46,7 +47,7 @@ static int genl_family = -1;
> > 	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
> > 		     MPTCP_PM_VER, _cmd, _flags)
> > 
> > -#define MPTCP_PM_ADDR_FLAG_NOBACKUP 0x0
> > +#define MPTCP_PM_ADDR_FLAG_NONE 0x0
> > 
> > /* Mapping from argument to address flag mask */
> > static const struct {
> > @@ -57,7 +58,8 @@ static const struct {
> > 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
> > 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
> > 	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
> > -	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP }
> > +	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NONE },
> > +	{ "nofullmesh",		MPTCP_PM_ADDR_FLAG_NONE }
> > };
> > 
> > static void print_mptcp_addr_flags(unsigned int flags)
> > @@ -116,9 +118,15 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
> > 	ll_init_map(&rth);
> > 	while (argc > 0) {
> > 		if (get_flags(*argv, &flags) == 0) {
> > +			if (adding &&
> > +			    (flags & MPTCP_PM_ADDR_FLAG_SIGNAL) &&
> > +			    (flags & MPTCP_PM_ADDR_FLAG_FULLMESH))
> > +				invarg("invalid flags\n", *argv);
> > +
> > 			/* allow changing the 'backup' flag only */

Update this comment to:

	/* allow changing the 'backup' and 'fullmesh' flags only */

> > 			if (cmd == MPTCP_PM_CMD_SET_FLAGS &&
> > -			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
> > +			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP) &&
> > +			    (flags & ~MPTCP_PM_ADDR_FLAG_FULLMESH))

This two line change to:

	(flags & ~MPTCP_PM_ADDR_FLAG_BACKUP & ~MPTCP_PM_ADDR_FLAG_FULLMESH))

Thanks,
-Geliang

> > 				invarg("invalid flags\n", *argv);
> > 
> > 		} else if (matches(*argv, "id") == 0) {
> > diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> > index 0e789225..bddbff3c 100644
> > --- a/man/man8/ip-mptcp.8
> > +++ b/man/man8/ip-mptcp.8
> > @@ -41,7 +41,7 @@ ip-mptcp \- MPTCP path manager configuration
> > .BR "ip mptcp endpoint change id "
> > .I ID
> > .RB "[ "
> > -.I BACKUP-OPT
> > +.I CHANGE-OPT
> > .RB "] "
> > 
> > .ti -8
> > @@ -68,10 +68,14 @@ ip-mptcp \- MPTCP path manager configuration
> > .RB  "]"
> > 
> > .ti -8
> > -.IR BACKUP-OPT " := ["
> > +.IR CHANGE-OPT " := ["
> > .B backup
> > .RB "|"
> > .B nobackup
> > +.RB "|"
> > +.B fullmesh
> > +.RB "|"
> > +.B nofullmesh
> > .RB  "]"
> > 
> > .ti -8
> > -- 
> > 2.31.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

