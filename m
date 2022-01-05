Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031CD168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 02:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641350800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4fnw7hvJ7sO5hWsLgvY745SxzteJZy4uyIjPI41/JOw=;
	b=Ai3RkgYaf9x7yASLEHBDiLH5WTWXeAEcLyri7+6fiYymHgmqLR/cCM21t012z4ngfV1iMr
	jevcgEKvfIeV2stb/ql0ov3rZ+8MzdhSPR7JZ+r8beIXZDL0kGOJaIW1f2F7GNXEDRC3fJ
	hp+FogHvgn4UQuJdiqBP4K8XcdSr6oY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-qGhJ4fdrPoumWxwpMmFZkA-1; Wed, 05 Jan 2022 03:46:39 +0100
X-MC-Unique: qGhJ4fdrPoumWxwpMmFZkA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yasq5xJXU29HTXWD5hkdWzdToCOq9AmsGPk/uNlfrYou8lLQbtGbouPK1/NmBLnQzNOdIE8w7Lvu89VfEfb/Jp6itJSZptHWzVwo9lUS+wrUa7+H9nWnQk2kQTY6JlcTO/f1tYKP2xuTPdWn07U8B1cA04TGHPTIx1AWgSSAGTJ9OR7SzNDGPR9dbb9Uj3ZLv1pl8N34kpUGyCYrJLf0MJxeJKF19rKUvA6vgnbxnthWkbd1+CT+GPHsZ4G6ZosWcACHUsSRXX1o8fsvVsWplnH/XQd6A/tCus30WLvv7HvuxTdVD29wNy1ZAFVysKizcoY4V3hd4qBXTW8Ceqw7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fnw7hvJ7sO5hWsLgvY745SxzteJZy4uyIjPI41/JOw=;
 b=B1EF8dDttnCMZ3Z2gLSRmLcMvmVKiK4abYm8IMLkRFE722iMKYlxm2BoN3u/Nb38WAXhpfrQiMyROtAd5G585/cRGVy9pEaBPHcdpqWaqWhxOtRVXXX5n4u2j0ah+CfUSLWchdrZGA8POrx8MjS8+DjhHN8DZ3kUeoyVTYA2CvJH9n5F1WK9ykR+6qFuExj/u97L9YckFFsTZPcezXq66ZZ4XUv3DqFUtom+5fiEXlQupP7cXhzUcn+jjhHMgNRUXUjNaG1uUj50nwo5Df7vwR5K36I3f+Cadi2GLTV2fyfvGP8OlHzyHkeWkE9aI2LUNwtb6s1RMevrwTBmjAiEMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3436.eurprd04.prod.outlook.com (2603:10a6:7:82::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 02:46:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 02:46:37 +0000
Date: Wed, 5 Jan 2022 10:46:26 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] use 'ip mptcp' in selftests
Message-ID: <20220105024626.GB3356@dhcp-10-157-36-190>
References: <cover.1641290905.git.geliang.tang@suse.com>
 <1982663a-58a4-fad0-8f6f-71ad3cd761bb@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1982663a-58a4-fad0-8f6f-71ad3cd761bb@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56878126-05a4-41e1-43e2-08d9cff597d6
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3436:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3436CB5B5B3125F65C3B02FCF84B9@HE1PR0402MB3436.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JwRr2AjkO/IBZa23lX7NmwFQ06pQv7e2tvyBiGOnIc7l9KTSQdcFIUrzVzcohEaWdrnDPsXBkiFh1Hgle4MuY4EHaNi8IHz83gellHPE9gwrwIlJkQcCSWq3LPCnSCm/dJN6L5HeGtfoE/2ExhYOcY+s9wgxt6Cn+mADo7CJ0JL1IcTjhrotY85UoWAMYRFdxeHDGZIwc5YUASq7tgX4sG7rCwLKVuXhQIPX893nkVIcnr0YtKAHCMdICD76iAYz46FJwnjpABBS1Wdd4bV4SDhFeYfQcInDfsS0PhTyMLnpHLnNCj+YDX5N9e8USNmF3Z88CdFeD2tS+sehdvSQsDHfEwFFG3AxlYXQVk01kYCyBOf1EBzt0mLIjDXhCHn9UHRCJq21M3nXHvB6F4LqUnKiFGkWVkc4wzDIcsnqQUWYrBu4kVpgd9l5OWORSsfAlhAgI6DO5V9iyciaoCfOZIrrvGPq/1o2eE2K/pVUg7/2ik+KVh9WplIyR8XKMA2HXUt4ZNo/5B6iYOIzBCahg5GadCYbgIQPNOZjudPkYhTOAO0QAvrruLVzDY5C/OdI6P6hrHx2QdgjrquPCOA7giZVWGmPUE175WDafsOIggMEQmtw9Nb1xTLG0VLV1z8WkvmFtIC4dWkUg1QiNX78h9HLaPhI9oOV56t7GqjnLwBU8655OECyqfU66dI2alfAhnM4zcTR6BOyYvLzoMFI6cxqgJ2yz7V7f7OGpdg9m/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(6512007)(9686003)(33656002)(83380400001)(6506007)(508600001)(55236004)(15974865002)(38100700002)(5660300002)(1076003)(6666004)(316002)(66946007)(66476007)(66556008)(4326008)(44832011)(86362001)(26005)(186003)(53546011)(33716001)(6916009)(2906002)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TSpB2FUwmXSgBPrvapS4YFZs2MreOBfVeLonTYhJIrPh/9uzMPdlbomHBm96?=
 =?us-ascii?Q?5NB3VXIu62i4J97sTkav3AtRFjjr58gdCDNnsidOVl7+Q/kkvjY+TYdiMvhB?=
 =?us-ascii?Q?cgbkX1FgcwGjftgom5FuOVvMPf/VRE80WD7IngJvjK+8Y+RxLgj0pbvpj20m?=
 =?us-ascii?Q?Gq89Zt6H+QhBiOdDvQvCN1lMJF09vE3VG/3Um5rByNNRp72AnSI7t3Nh3xGz?=
 =?us-ascii?Q?/nKXuxJcvrlaoi0SeHZGIQtIUpY4aRWBOuHcYuUuueorYfbpXcJi4//rNfmp?=
 =?us-ascii?Q?CTZl70H0yyoUz0u/FKroVF162EXU73h7gRNUIPyM21ncTljrZJduLJCrftko?=
 =?us-ascii?Q?BIdRsDe4OESyb9BS5azYyprfpj6cFoafvJR/i48xsSXiIOUwZJNyzEotEk4J?=
 =?us-ascii?Q?Hqd4jbaG2Aph+3RFeTcGSfZdCQ4j0bfm2LO6eKdWhvFU1l14o31KcQeIaRaV?=
 =?us-ascii?Q?Ggqmp2fy5wz+VpkOhrHjvZhUOprmo33ajfD7NzZPropaKE2RHAumQRjmgWwK?=
 =?us-ascii?Q?VzaJj6wZWTfy752Vu1Imhxr0qQv2LERByucDTOU4U73JSXaL2cKM/Uqvmb7j?=
 =?us-ascii?Q?LAdgJt2iXGw/buzD/Q0XRAw5agt6gPdJiaOliSzmBtUY7AB+OL+h8cB4KCCF?=
 =?us-ascii?Q?V2WQzCJEhUi7xQxMevWWmRLwyyRTfCcqxYonBKdA+wIpRVPoUPJSOaanP5zN?=
 =?us-ascii?Q?ihKMK6XZRc84fU9rMYBiwKOaS/hoacjmQpNuAu3PY9Xl8mAOPrC/Kriv/uSX?=
 =?us-ascii?Q?h90R84MnjWQTJjWh+byQhd4OfqXBt9CzYcfSiscC6EBZtu2ZamDmn9CHPylS?=
 =?us-ascii?Q?KSmbzfX11TloRBK+dngqZL9D9UHQ0LJ2wzF9sBvsCnao6GdjXzBwAGWa9ddH?=
 =?us-ascii?Q?AgajQXSyi9aC4mnNSdvXIMEKjUVA4HcfHP3G/iddgSDMASGvX7A51qxcuwon?=
 =?us-ascii?Q?rEJdgZcsa5N3yWhwbFKpAXtbviLMQFXF4U4dn9d/8z0VClGb2SvHBgZzhuKB?=
 =?us-ascii?Q?iStaJmURsRgukGBxZ/SFSbgSmsIr9/WIEFa4qf9o3ojPvFSKjw7kN7X/oJa4?=
 =?us-ascii?Q?Mxjdfv9DAMyVyz1RvbQaazGq9VkNdwfxAOdphE97oJXmvnVtUncrbj8Gd1FQ?=
 =?us-ascii?Q?MYoUk/SKe7xeIGJ6dxD3CPtBu5NfgBXMvzeoS3qNUm43J0FSPiltBU2k7JOo?=
 =?us-ascii?Q?dI/G4yg621ltE6y0v32vuHHs6mSrqi+tBdxH8RRyIvTwz7brVF05oOlOdr1j?=
 =?us-ascii?Q?InatfubLjjCzUxK9Y7Y14wxvEOZtSLo3z6FurA5f4jsrfGzFSSpTu0vqM8OY?=
 =?us-ascii?Q?tx3iGFfOwR7AkS34Z/QSkn4urqWh5coTp/0WyJQV6LYcBBw97gvypsdL1PDu?=
 =?us-ascii?Q?yNQmKClg2dfUNvJ6tF7pjJu+3fNyqzjwDNKcBRyeDaGLEOMPraN4o/P/aMc6?=
 =?us-ascii?Q?KHhCNX0wixCOPPHfRbKWHzbHYVEvwgHGFBpyJmiSQGCJ6FCR8/OkxjmyF5Wo?=
 =?us-ascii?Q?4phzF30wJ4+yVsZGOn2A5b7RxGMW/jKgM7NtiI3iwUfTeRfI5gXmUpF2PcCT?=
 =?us-ascii?Q?8OQ08JPltBUb0mk5WxnYn3I7aF2Ju4OYAXZhlYvhnPYPlPDp7oPOqnftNgZA?=
 =?us-ascii?Q?IZPDBZdLf6eTmrKUjT5q2jc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56878126-05a4-41e1-43e2-08d9cff597d6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 02:46:37.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnPXKy60qysKU3A+0uGqSYJSu5ltiGZJhUgACKSbcvTTcvOnixjiuGq/sdMH6Rby9fta8Pk3yCCOBkXuYMAiew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3436

Hi Matt,

On Tue, Jan 04, 2022 at 05:47:35PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 04/01/2022 11:11, Geliang Tang wrote:
> > This patchset replaced all the pm_nl_ctl commands in selftests with the
> > 'ip mptcp' commands.
> 
> Thank you for looking at that, that's a good idea!
> 
> I see that you are using features that are not in iproute2 yet. This
> depends on your "more patches from pm_nl_ctl" series, right?

Only ./mptcp_join.sh -b (backup) and ./mptcp_join.sh -m (fullmesh) depend
on the "more patches from pm_nl_ctl" series.

> 
> We can easily modify the environment of our CI but not the other ones.
> To continue having these other CIs validating MPTCP selftests, I think
> we should do two things:
> 
> - check IPRoute2 version and skip the tests with a clear message if a
> too old version is used. I guess these CI uses at least the last stable
> version of IPRoute2.
> 
> - wait for patches to be at least in "iproute2-next" before applying
> patches in our "export" branch: it means we can already apply the
> modifications that doesn't needs your patches for iproute2.
> 
> (if it helps, we can also have an mptcp-iproute2-next repo, e.g. if we
> see we have too many IPRoute2 patches waiting to be applied upstream)
> 
> WDYT?

Maybe it's better to use both pm_nl_ctl and 'ip mptcp'. Add some code to
check IPRoute2 version in mptcp_join.sh to decide which one to use.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

