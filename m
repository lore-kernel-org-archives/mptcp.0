Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05D168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 02:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641350173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4IgwNOJNNzXNZLhbcib6C80Y5o6341GdaraoEhcmp8=;
	b=gGA3IUoHi9bgrtfjisVD3g3t/b4wiedCWhq+fqKxk0LdvlFBUHABfHvd7PRMzsmDbymESn
	FMJNZFGrj0I0AbLoTaaifQ6BcdgABAEtrgjVe8edkvqmlbZcetcXp8YWsDgQDnS+vbEYDm
	QAfDjl0NWTR3KcJVOwwmEC/pCM4ALY8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-2fUMvIr2O0aarSwVQMue8A-1; Wed, 05 Jan 2022 03:36:12 +0100
X-MC-Unique: 2fUMvIr2O0aarSwVQMue8A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBdhagly/Z2GuwgrYnqt6TwDHHlJU1+MYKFxx3VRnQ92sst2EBIzXfXvAzHveJhR17OZYW0Mcr8SDyhmsjITDxbwl9ood/AV3CkH2HXPRH1VA1P/oAgg3J7rJNAmf44x/27KgcLGRSfvd8KgS4IvvPD+Eh4H7C/C4PHLNgrJz4rnqFPAAQ8ubGyAE5kXi7TBmAsIqQ4GacitPS9NjPsD5rN/j+vqZGidI57VotJMPXPpWsDQHAM+TFZWklClVJ9ZLkKfDonRc4tsiQPMF4tsUsYhB56vea59Bd+5S5yti1Ua3rhGCCvyc/NTm0R0zYI+lFDv3ss7Biip0edotjK8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4IgwNOJNNzXNZLhbcib6C80Y5o6341GdaraoEhcmp8=;
 b=gAwIuK1qOmE4TSK7Gq/2fii6rUJlkExd6SLNbp14aNq0RegICnN0fhNc1Z4DUbqoYzYtQoy+jX621a+T71oZ/2T4rkAyituXy7kc2Sd1jn9VrhnnA6QTtc6M+B7+B9frvyK/WyHEonVLme4/U4P/t4uEufV3kNUuxM4AHIwTUN4F5rqwaorWREZU84B1qJ68IG5cwDEBYkOPsS852knLSs0NgNqHha9ybqeJlTpR8lKyaMtjvuNppqzfBGSeQyTG3XL7p3zKsqaoOoSRJGPewYWpyUZ08ovOLwUdG5yaf35ZwhTOWc5CNjnMDfjT+hJv2Ut7LJdBvOMMRQ7SpdbX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3018.eurprd04.prod.outlook.com (2603:10a6:7:1f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 02:36:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 02:36:10 +0000
Date: Wed, 5 Jan 2022 10:35:56 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] use 'ip mptcp' in selftests
Message-ID: <20220105023556.GA3356@dhcp-10-157-36-190>
References: <cover.1641290905.git.geliang.tang@suse.com>
 <e0bd41a6-9147-e9c-5bc9-c541282127d7@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0bd41a6-9147-e9c-5bc9-c541282127d7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0178.apcprd06.prod.outlook.com
 (2603:1096:1:1e::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a8a9189-7e91-4cc5-1da6-08d9cff4227b
X-MS-TrafficTypeDiagnostic: HE1PR04MB3018:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB301846F89E4380A0FE345248F84B9@HE1PR04MB3018.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S3cJWnw1uH/4+1LxeoYCk0W282fVZRLuNwGfbksWX65ThU4nQi4g2B8RZtaCU3R+yHL+jIn1W2bKh93QNc4o9JiYPayak18pDzB8gZIeDCF3C4wg5H+4apnkBAflNXTW1PDrB16ccZ+yK6uysO1hoS2CURRwbEnx2EMYBZUzzNOmDrtzUu0F+huGbDYoB6++bbE7UYTD8oFtQ4GeR27N5rzUyjvpBboM98vDvNCVIeXUK8QJky5f4IDhpzZidGmkvBXeYkqYVtkAQ4E0z3t8ink+EI0rihHmIm8vQp41Vt5z41HZ1uhiRDCH65QHViOvC1xWH2Kz5r5LPgNbKYFLLIhtyO6taYgLiC81pvqsWQ4A4cDr7FYhmSx8KFn9yZ6qGqW81pXejwkVdD5l36A9mNhvmzmfzYki3fRCutYLo9wQKYOsErnJy4MMb9AQ3RQhdC/YOh1LbR3TaUmzZkUCaBCcyBk8A7EWH/aYC0+8eta14TuHV0DSjiWGxpCJzdhCu7tC1SMdzL7h2Wwbl9Qpe7Zp42AdFVFtUM8nb0odg7mZVLfxQclDJj3YVl4se0bn+91FZCdJVZ9hCxf0QZR2f6AMDgQqxKuBlW48h23Hkk6wRzHaVTHUC6Aw9fLextRT/iDtm/92vo7WyzWG7XPyLQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(5660300002)(38100700002)(55236004)(508600001)(6486002)(83380400001)(86362001)(6666004)(1076003)(316002)(6506007)(33656002)(66476007)(26005)(6512007)(186003)(44832011)(8676002)(8936002)(33716001)(9686003)(6916009)(2906002)(4326008)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uVGNAw9AVtLFZhCXxzpfJmddzJnGNPc/rxt5jM30T4u1namKROlIY3WZ6+7N?=
 =?us-ascii?Q?NaxY6QBtolsvXm/jLXkD5UT5+e5v/R4r0EHPRYoNy0HulS7plg/cZPAur+Qj?=
 =?us-ascii?Q?nDLuFDng+gyGhy9+7QssIHdS9YPS7V8cr0NoLodvb0GAg+Y5IfMFAA9SLhIp?=
 =?us-ascii?Q?2fXt67GKB2fqggQNqNCKWeu/n9TEt7yegT8iF4RQ1U7KRE5EiWQkuwU42GEV?=
 =?us-ascii?Q?Ay6STymjsJPzc8mcVdRLIG8GQSOSDc+H32hGBJhf7M1sNEkWN53Qdetzrj23?=
 =?us-ascii?Q?EIFoHeIQQNCs219dQM8QrLoCjnjPI2CzdDAMam26U4h2lRLZsGQ9J9GlsZ20?=
 =?us-ascii?Q?Ag6upaZhM9lPnZkvze+oilmjqyXOu5SkaJ1QlQE8lncHqEnli6IILUEnnlBW?=
 =?us-ascii?Q?XzdMgod3LkQp3NsRv6zgn1jQFbDThCyXxq2XcffF+3r0AOFW0eh210kdrTVH?=
 =?us-ascii?Q?VFt04c7Xo8bxGMQ5FAZ6tVI3cTWDtjoRVCJG2WCLXv2tp/CJqz7O5HW/7/7e?=
 =?us-ascii?Q?2GYA0SFmQ4uDMj4YCUgvrqQTewQTgJjQ2OjYw3lQXoplUgFyYWGFVPxot7jx?=
 =?us-ascii?Q?JvF0aS11JCijMIk8jXKUqiobSmUC7JA5r4D90uZ4WQEqyLOSrBS8rFp1wtQx?=
 =?us-ascii?Q?01QS4985elPzm0A6SzWPilPlCVwP5YlIeYYX9CKk38VCi+jWOtjNIwt8ZYfH?=
 =?us-ascii?Q?hO4xCKjm/PI5W6AS63Lwk5yCLTH05YXg/y3O00QmaJyBuYcOvt2WvhpMKDiv?=
 =?us-ascii?Q?XVU0F76EII8P2rlwQMadqi1swsM/+b8Ffop01R2iGVLPWAmF831ND7DXJ14r?=
 =?us-ascii?Q?HjxmETtW4cT+xRTN7kioFIaMO+Ig3gKqpKO/F4rJN/dwQPka0Al1O1uSVLxF?=
 =?us-ascii?Q?6db602Q3YsSOo8fl+QSNrnXWu2/iT026zvo71RFFFT43aVTZXa7kPpGlsvX0?=
 =?us-ascii?Q?v2npTLz2xxfmPHxkBTmZ7KmBwCGH5Uvf9VSMVk3LJ+VriW51QPcEFnZeKTxQ?=
 =?us-ascii?Q?Hl7Ud9BMlM7tceCACeewe6VAF8uf7oDZLl67oIERe2z/gbs1goZEu3BRisSi?=
 =?us-ascii?Q?FPBUJAUDA67CynDWb5+6CaBpwA7cAi+iEJlnR7pirm+ATZ5qVVqg2P1gMBww?=
 =?us-ascii?Q?VFDhZWL/1cT8PZbcANHfYg7pkCq3wyWzY7BONtq0kkYde6kloAbZHc85sLee?=
 =?us-ascii?Q?kiEUvxOW0Uadf1yGSVfegMpLuv+Tbmhp8u5qgQq7VDLI3nadER5yFaiubzxQ?=
 =?us-ascii?Q?uW+mnqcdJKG7bsatasG6tUtzWLrHSb2yQPv7TMB9cQ4gtmr8RxtQ0xD65xn1?=
 =?us-ascii?Q?s6Vet+xl+cWX6Gsd06+qlZMiGL6s5oy4OwGVLr/Ucc+UuOGnb28yoSUNYe+u?=
 =?us-ascii?Q?7haNNWe6ERs+CGnF6FGqAXopZNki1/tKSTaGpzpbwAalTKXIBPoU7CTkigyU?=
 =?us-ascii?Q?KoYRCi1sScvS6Ck49+txgijWWXuj1HJqA5uGzinXWuT0AZf4XVsQxJFKX6Tv?=
 =?us-ascii?Q?EkFlnySfwgL4aF5wu44JnBoW9xa+TdKOkv0BMZ76NzSs1gepXMjwFzRInBf+?=
 =?us-ascii?Q?s17Ia6BD0sFlPqIaZesGhPRX2fLRNITaiQe01UiTVsQz92/hbdm+QwQTSDRL?=
 =?us-ascii?Q?oNNsL9TddHhLq+vqdHGSJJM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a9189-7e91-4cc5-1da6-08d9cff4227b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 02:36:10.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZWNkKrvJI22pZXC5HogA9TzqsjPO7xSgS1WBH1h/0kMPn9krP07p//E2u3E53JWXIxuS7bfKalPJfCbbelFBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3018

On Tue, Jan 04, 2022 at 05:41:21PM -0800, Mat Martineau wrote:
> On Tue, 4 Jan 2022, Geliang Tang wrote:
> 
> > This patchset replaced all the pm_nl_ctl commands in selftests with the
> > 'ip mptcp' commands.
> > 
> > Geliang Tang (4):
> >  selftests: mptcp: use 'ip mptcp' in mptcp_join.sh
> >  selftests: mptcp: use 'ip mptcp' in mptcp_sockopt.sh
> >  selftests: mptcp: use 'ip mptcp' in pm_netlink.sh
> >  selftests: mptcp: use 'ip mptcp' in simult_flows.sh
> > 
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 686 +++++++++---------
> > .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +-
> > .../testing/selftests/net/mptcp/pm_netlink.sh | 164 ++---
> > .../selftests/net/mptcp/simult_flows.sh       |   6 +-
> > 4 files changed, 432 insertions(+), 436 deletions(-)
> > 
> > -- 
> > 2.31.1
> 
> Hi Geliang -
> 
> I think we had been using pm_nl_ctl to avoid possible problems with varying
> 'ip' command versions on host systems, and to make sure we are checking for
> kernel regressions rather than 'ip' regressions, and to be able to check the
> netlink API in ways that might not make sense for the 'ip mptcp' command.
> 
> Could you comment on the reasons to move away from pm_nl_ctl?
> 

Hi Mat,

How about using both pm_nl_ctl and 'ip mptcp' in the selftests? Add an
argument to choose which one to use. Or add the 'ip' command version check
to decide which one to use.

My intention to add these patches was to check whether all the changes in
pm_nl_ctl have been merged into 'ip mptcp'. I hesitated to use both
pm_nl_ctl and 'ip mptcp' or replace pm_nl_ctl with 'ip mptcp'. The latter
is easier to implement, so I chose the latter. Now I think maybe using both
of them is much better.

Thanks,
-Geliang

> 
> Thanks,
> 
> --
> Mat Martineau
> Intel
> 

