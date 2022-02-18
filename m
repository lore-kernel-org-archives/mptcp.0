Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050F3237
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 07:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645168591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/1edKaJb/+VTZWR7atbt9hGEkAjMCBJFJx6t0Zcszc=;
	b=cJ5DpaHC1WPBC3c2m/baul6F20lfKvHKp8uu9GLwbC4pYAgtasuot8plOL/kFIe4MRrSM6
	3u8tZ02wiT5mcNLS5cWojW/m6nnJpjTMUczU1Woan4WZpgm1eoV4adLa0/mC+bv45Pe9za
	iiJ19OhcRLX8fZw1+NFIDJJPeVQV7vI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-VMvc9hwSPQWDGoG-18Wgbw-1; Fri, 18 Feb 2022 08:16:30 +0100
X-MC-Unique: VMvc9hwSPQWDGoG-18Wgbw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYNCg3ly3KCaEX5tZORrSOzQb4w2aNs55kjigEtzm6Uu9jTSWuanNn6wVZeh0qEZrH0jjCjBg29AnRhxfy+F5Vx/x5mAa21mE12uF9F8Q628qDU2dat/EhGR3ca40ku8yb9w7CYdI+90AaOJYORpD7BjBMMF+b+89ih+/n72BilKTUIJsgdddbM8jlDctpJxHW/pHZM1gAa7265iCIIUZrceFw/kWeDs1+jNbAaLRQAfT4/QHDIJB6ATqiSB+dDz4eGBTaTiewLCBhRIagGpw9PPHpFuU6SRL1t6Pp4UHcOSaxxnPSc4L6FHa7aZUb9XOFqa9N89hGxX7zkokbvMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/1edKaJb/+VTZWR7atbt9hGEkAjMCBJFJx6t0Zcszc=;
 b=bL/BJPUvc9z8ycOK/c3XLkcA+C+o8zib9L7rjsno6LeYXdDkh4rv0WJuAIPMih6OLkWPVzhAl9x3cV0lSwKWXxkaOii/0AcgntolIgwY5J5IVo+41UP/A2kAMwaxZeteX1t3Yu/lCnQL3se2oquHbyzeEDY8xRe6o1W1/bTHwcWRz8gEWPUfnM7U7PpjVRn8TGyPpmuXyFijhVT7SnCXww+8PSLSQvqeALABxNfbsHm77zgJc5cBDxccCJWZyzj26ciZ/UXm81yJd591vC+3uDqV6pIlaknnwU9kdbFhZGd2hbAGb5ZKPIGElwP7uEiSkW5zehI+5yP3VH5rOK7cXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5418.eurprd04.prod.outlook.com (2603:10a6:10:83::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.22; Fri, 18 Feb
 2022 07:16:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 18 Feb 2022
 07:16:26 +0000
Date: Fri, 18 Feb 2022 15:16:59 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/7] add fastclose testcases
Message-ID: <20220218071659.GA18159@dhcp-10-157-36-190>
References: <cover.1644923074.git.geliang.tang@suse.com>
 <4267dfb9-224b-228a-83c0-6d2da77fd8e1@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4267dfb9-224b-228a-83c0-6d2da77fd8e1@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR03CA0105.apcprd03.prod.outlook.com
 (2603:1096:203:b0::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f214d1-2462-4fc1-6cb5-08d9f2ae93ab
X-MS-TrafficTypeDiagnostic: DB7PR04MB5418:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5418D8B89A0ED26BB59C92B2F8379@DB7PR04MB5418.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6Ap/HbhFul2mQ8L0xcZfNLAFeuDldamKW8DhFdxjkaHL1Y/oawYew3IM6obZnirXUGAPdUXH5BgbrlAs6s1mNMuZwGPAbwZR15gFmqe7Sd4vJc6+p7VQTdSf+prqnHDdtdRhsFBFnm8HKatUZc9aO9LeeSmP72KGL28tdCaFHDC0ZVs3AP590wjDd6BzKwL8luVsNBPbloI2wKBlEWsAFbqIblhxXen+R4OdARen3317nOdI4ygDy+Hw7lQDlnHnC5XTN2iX/cAzsZHkVOjCXyT0O4r6edeqF+NU8M7GJdCvdau+60P7zQ+SxQ28wg/Tz0mAzOgU3soKYLqK0uGF8mM8VqP7XpxJHScFRKj128KgbdfaZfQKbEyj9k15XJyO3qDOQQofX6imz8SNEJiKDkVYriJERyRIk4z91cb/CSU4ODaM9G74ARIGHlfHcnc9iXO+UbZOZWDjZvgIoAoRGNVkakPCVQe47fYC5mAvIaL9K9lwWMOIqlUBbmIsIRlXZyPoLRSt5/u+LUKe7Ox7PO7mcFRQtllFGb8NeaKW+cB2I+aEJplXfpmL2A/yyghAQcPHZmn+wi/hiki05nyA+P/oohPIMz9Yo5g63yQNrZHK7EcIhY4gOQahKNA9Vx/5bNP7MeLQFAibNjKJTpSHCeal+XcUAAR8C8KEBfcWsu+XY0ftVv9vrCLOdrXpejOcypDduCcqg9no8lo1S//avf2uJbh4ZnpRbsCXPuRy4zo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(8676002)(66946007)(66556008)(1076003)(44832011)(86362001)(9686003)(6512007)(186003)(6666004)(55236004)(26005)(8936002)(5660300002)(6506007)(4326008)(83380400001)(6916009)(508600001)(966005)(6486002)(38100700002)(2906002)(33716001)(316002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XykewqmrT3XaRbYMEMZ0V9A9Hi6qKRdmLDQAV8sV7ARjTrjF3ELFB3PbV1Qu?=
 =?us-ascii?Q?7Is3Z+xICoFJR/r2DDnD38cr3cdmEpsj/ENI6aOABBQXOrPoL4/f9rDVkX8/?=
 =?us-ascii?Q?U8cm4ZdRNyPAcioYVUEt160b3pmq9LSNDF7MomPsUIqcp1Cl78wsp88oETip?=
 =?us-ascii?Q?+OiizRI8bk9AExF9onO5CZuqPbjfT/4LrBqqH4+X+Bek2H11CoIyYj014bmJ?=
 =?us-ascii?Q?3qlgBopikpEO5ruCRvV4cUr4mLGepTn24oaeEzYsMqPDvvn2JpV3oN3lDO1U?=
 =?us-ascii?Q?OjPIg8zNCqfQvv41pgCAVM+RehpBdmDD/uMoLqZq0k8bflWB3wLOF2L53IRu?=
 =?us-ascii?Q?26TixpqnCBl9rUK93HhanF2gO6BSxs+9KGi/DKqyOpOxbuko/nn05s7+uFAn?=
 =?us-ascii?Q?NUp65cwfKDdiyOL94BkQVGQB6yOtYN/W7zTdcnb+4VyEEE3Dy/Cw4mWWiMcy?=
 =?us-ascii?Q?p7wJFqYnZS8JG2bFNeAKIYyFalKHcpniDjnpSVeVtQ+ZapLwJag8tyDV9VOi?=
 =?us-ascii?Q?7QxDxqPca1TI2hycHv57TMcCzLcHZb4L60Awmpx2CJ3Z2hj+gM3iRPGl5JEH?=
 =?us-ascii?Q?dbfZhDR5/mhUKIzzq4tSMlGFOW44PT91b8Fsx0MZKnxhECFolXfikcNYxIEV?=
 =?us-ascii?Q?B+Z+l9OLhXsUX/EFayJldy36bVInyxNXlhQM2PbjS/82ctovWoQveZ1+i3Qr?=
 =?us-ascii?Q?hV2BawIUFKQVfi/+4UQS6grkBlt1lnJo3/Wi2Z82RIHqyOKpwRqNBcodfyxM?=
 =?us-ascii?Q?pwbQP7/+KR4NKuAjnFGIMjycAMDkP9P8s2z9pMQrBSq0LdVa/ODCVgW43X0/?=
 =?us-ascii?Q?py6bQEHsog3Wtk5NrjCzVFzPR+5Zx/np1eLUZyVAmpEms1E6tVUGxSZDGOKC?=
 =?us-ascii?Q?pevugb1Hfrn/9yEJIjPQPjUr6boBtgPfOfW9CtC/Mtbkc8bRv6skP6yqEIXt?=
 =?us-ascii?Q?k4QWLqauK6uiCVzA4YWsOaqdCb8E6IzXcpngRmQ9CI8sBTWNKBy3hCHCZHlP?=
 =?us-ascii?Q?R/Yly3RHr0R7Q3IZqLmQR0mQnlRTNevwGDhpf4mHez2t5h5RCo/lSl1/hnaD?=
 =?us-ascii?Q?pOmK+zum7bUzM859yuP9B8bz/dwNitIxDWS/lQChAIJ++bHpXizhTLNJVZPv?=
 =?us-ascii?Q?QSYdypIqKQlbOSS1jt6XyYO+Gdh6u3WbJhrPC62be2IUMvgumaQJXQe8PzuN?=
 =?us-ascii?Q?zQ60oWZ9N9q1oLb8NvHM91vmO/eQznaD9YZCGUwvIgaU/82WhT4rLvOE0rzF?=
 =?us-ascii?Q?ZI1QCpFYpRVU2jjqcqJ3Weam+Q5h/ivouMx9PCPiwDjYk1iE/eOgzt2StHAm?=
 =?us-ascii?Q?Qa3Zv4wis5I7N8Cjqn+8fpEXPOdPEuv4bX/V9SSj4jVkZXn6CbkSCLwkMX/Y?=
 =?us-ascii?Q?UlnuJqSAiQm8dBN04WRpCI3w8OIVGgSVpGF/G0sc4xHu4cBsSDFk2hskylS7?=
 =?us-ascii?Q?MnyckjpDy7ATAUArCcsjfhCjsQkC1XN/IfCCTgE3vq4fV0yxWYCwcDJMVqI5?=
 =?us-ascii?Q?wN6500hGH5okmBDqO0UEa+Ft9xc3+ObzmzL5lZ6Et9nDpsmaOjoorFVtqYG+?=
 =?us-ascii?Q?XCVjghuApaKmG/NSyVCtGz/v8cl1Vugfa9tgUAT7KNaSvAZtqRnglRWqinw4?=
 =?us-ascii?Q?Eg1YRZEaLxMjxr0nMY9KPsk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f214d1-2462-4fc1-6cb5-08d9f2ae93ab
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 07:16:26.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ImJrXXbGTOwQVB7PUHqrXJw65jmeDH0/Mzf4CUB6MhiVQFL9sr9jEKR7TWMGNEYz9pPPZhVxGA9RONLCGUUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5418

On Tue, Feb 15, 2022 at 05:17:16PM -0800, Mat Martineau wrote:
> On Tue, 15 Feb 2022, Geliang Tang wrote:
> 
> > v3:
> > - merge the squash-to patch ("Squash to "selftests: mptcp: add
> > fastclose testcases v2") into v3.
> > - add a new patch to check fastclose in mptcp_connect.sh
> > 
> > base-commit: 9dff76d953f7a0fe2b27818f2aa93031c9a617cf
> > 
> > v2:
> > - merge the squash-to patch ("Squash to "selftests: mptcp: add the
> > MP_RST mibs check") into v2.
> > - update the commit logs.
> > 
> > This patchset is related to issue #48 and issue #197. The two MP_RST
> > patches are moved from the "add mp_fail testcases" series.
> > 
> 
> Hi Geliang -
> 
> The code changes and the squash-to patch look good in terms of code review.
> When I run the 'mptcp_join.sh -z' test I get intermittent failures with
> "fastclose test 2":
> 
> 002 fastclose test 2                     syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          ctx[ ok ] - fclzrx[fail] got 1 MP_FASTCLOSE[s] RX expected 2
>                                          rtx[ ok ] - rstrx [fail] got 1 MP_RST[s] RX expected 2   invert
> 
> (removed MIB dump)
> 
> I was able to reproduce while capturing, and the capture in the failed test
> does have 2 MP_FASTCLOSE and 2 MP_RST. Maybe there's a timing issue reading
> the MIBs?
> 
> I attached the pcaps, one for passing and one for failing.

Sorry Mat, I didn't see this email until now.

This morning, I saw in the minutes of this week's meeting that the
fastclose test failed. So I tested it and got the failures. I found that
"fastclose test 1" will also fail, but the probability is less. I also
found that increasing the sizes of the test files can fix these failures.

I had sent a squash-to patch to the mail list a few hours ago:

https://patchwork.kernel.org/project/mptcp/patch/22588887e5e516015f7f7b9d09112efc679fecf7.1645159759.git.geliang.tang@suse.com/

In it, drop "fastclose test 2" and increase the test files size to 1024K.
With this patch, no failures occurred any more in my test.

Thanks,
-Geliang

> 
> -Mat
> 
> 
> > Geliang Tang (7):
> >  mptcp: add the mibs for MP_FASTCLOSE
> >  selftests: mptcp: add the MP_FASTCLOSE mibs check
> >  mptcp: add the mibs for MP_RST
> >  selftests: mptcp: add the MP_RST mibs check
> >  selftests: mptcp: add extra_args in do_transfer
> >  selftests: mptcp: add fastclose testcases
> >  selftests: mptcp: fastclose check in mptcp_connect
> > 
> > net/mptcp/mib.c                               |   4 +
> > net/mptcp/mib.h                               |   4 +
> > net/mptcp/options.c                           |   5 +
> > .../selftests/net/mptcp/mptcp_connect.sh      |  37 +++++
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 134 ++++++++++++++++--
> > 5 files changed, 171 insertions(+), 13 deletions(-)
> > 
> > -- 
> > 2.34.1
> 
> --
> Mat Martineau
> Intel


