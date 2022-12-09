Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBF7E8
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 03:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOQN0Fled4Hnm2tjj8gptXv4SoAsjyqRuZC4ViEUagRUPt59oZ4eVYPFTV/ykSwC9F7wFJx0ukObaVyqOICvV2dOXn7k4g1tdIn1PE4yV12AgdSizIcYd0U/xhtm9ZSfYTSpyIwqNpOHXbmWXdt9ai3FzJJF34vKPRvBlm69TfufsHMcbS0luhB1KYi+tR3H9k9MO/11TchX19TWguz/LyIJBAFxMDO/f9+mXzV+XwcDId65hE7bUV5pFpfOv7TuLjInPRhasCFoRDOafyEWeZHcGB9mJWEzK4VoNKMP45oJEaa159UdTg16JsomyrnpaCL4NZfuaf7NmFYylbZetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETS+bt15MIiFShb7FzctND6aNt+5Owy+XJTPg8shWUc=;
 b=TUES0xioZH9uhXwe1LKLOIFMaCppKjiEA9QKplZcL9GYQcSKLWTTYLJqKYb6/sRJwYNIqtqDc7cSjCWA1518kNlFjBWUQtSfJDN3D0LvKyVboHRUN9pFuuq3oPwqGNxIOHA0ouyxAO/zLW0v+clU8hj6mkFRE/4CbT08cFbLLcoSgPkVmYHSSdbH4SCgGwRg1mquSo/VQt4HU6Y/HeYXFdEcg3CJEa9Oa143Tv10dsV3AjvCdiuoEl38o361jnQVMjhOQWQfE0hXIZ0KleHFIVvpUZOq1stP3OzpZ4Pvmekh2m++Q/QsAhyiPwBgkNogOExvm1o9p3an210SfD+tjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETS+bt15MIiFShb7FzctND6aNt+5Owy+XJTPg8shWUc=;
 b=poEQlPgIiJ8rSYd1GGbK8pTGx71q4Bh2Z+GADJTD6+3NdqfYZf95+XTYG8q/Vcl3TYn3KRnIxaw93p4mn/lUpFKv6PQLYTj1qCrAVy2kCqWy3bNfn5+pu+RtxseCuFWeneS8tyldJq0NtOz6TGheGu1g5H92hvSO7Y8EYPTdj2tMN2fo3WF9yZCiVJKwoZPgrRqsoUM/fbtiqTBmH1biBV89mrFXC2O7vA04RXesKGIbXdfFlNUJwUNqg/PKnzltxQlzSOF6XSO5JGem+QtJV8xBoE/m/HVOKc2daFW69fI8/VbXyzogT6RmLmaCsroaVcGp15LBzxvqTdgaJiPUeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 9 Dec
 2022 03:55:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 03:55:46 +0000
Date: Fri, 9 Dec 2022 11:55:47 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [Weekly meetings] Change day/hour?
Message-ID: <20221209035547.GA28360@localhost.localdomain>
References: <40149ef8-5ec6-f1de-45c0-038e42245b33@tessares.net>
 <4097df42-95ce-e535-429d-502233f484e5@shytyi.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4097df42-95ce-e535-429d-502233f484e5@shytyi.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ae2b92-418a-463d-505c-08dad9993f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJitUEs3yTbmDZL7EX/FTklbMAUjBIkKWPg1MBrGzM1/2GEjR/Nv30RbMs82QolQVMOWXM9OCdvpC2O+CdtFWhE5/fZ6vJaEl4enB77wNK4V2gmHxg6RBldk+2q1bTbwSUcs1afMM0iKXOqqstxyka49Ku1A/Lh3NtqwKqTK0/O36Uk7at/Y9QaWgwc5FJSByHEN3TxNc0vOqV/bYl7sXUlablCqOrA4N78zLyXtJHgpgMODgoD33KAjOC5xDG5x91jid1LpXuEaQoUfOErZ9AVDSJ50NfUZavjut+uU9DaH66n/SYS+CYgVNnOwXe/IALUlr8fJkRQYPFuqj6FD7uq+OTn/PxFzWKL31j8ZOquqcOldfp9f8UU1GSoO7STnPRcC5fbeF7qITdyWkbfzGfojx9sspRyTkN89M/1dq9IoizjMcoqop0qrjEQK+JDIh0L/r0wIkDFRja35e7mfPwc/GjhNTvQhqwmzmpZcizRAgwE8y/RjjqYegzRyzNyWjl6RBqKSUv3gAErJBRQAcUpXgZ6SPO7l5Gguu6tDjd2wkg7UbDDzcanvp4RiC/c9IiduSPtLPoBml0nS42X9wm4j9ewFtuFlC44qGmSV4MJ3ritUzh1HmdDwzgHXu+s8rgpdEIRuTzGdvNTixziFZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(6486002)(6506007)(86362001)(26005)(33656002)(53546011)(9686003)(6512007)(316002)(4326008)(6916009)(478600001)(66556008)(186003)(66476007)(8676002)(66946007)(38100700002)(41300700001)(1076003)(2906002)(8936002)(83380400001)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w8o30YjUVehnYcGAB15lzVdFV/EocG1n9mMWOdNFyif0UnqMsHGWj+V24lpF?=
 =?us-ascii?Q?Sa0u7FL5TKnDjtbohkHTRVvWj+LsPCf4yM5Y01x0+dcucdoTz2r2eJSrhHhC?=
 =?us-ascii?Q?VhlHzQAsweekyOi5rLiEJp1kVpWRohnZphmm2mCHil5xlK5YH1gj60VMhw45?=
 =?us-ascii?Q?0EHaP+YtxP+upzb8tIQxsqYI7Rfi9U5vVWK6HKHkFWZL/T6CyhcyTnhmHQgB?=
 =?us-ascii?Q?yXU4nxN0dt4OpEA2FZWiJunuqM7hSksRnIpqjTionbb4TIWPSXaVOZQpGcOQ?=
 =?us-ascii?Q?7hqY39mZO1MbYY6ja1RQe9DQfnl3aEqNeTEfgyUHyEmFEoUYy+64BLJ/CuIw?=
 =?us-ascii?Q?QrLav2Lw63IkGF9F66iQrSwNUlV643AN5f+ymXS7j9htZghK7tmB2NZY7vza?=
 =?us-ascii?Q?FQ9wFOHCrbycneyfWhpmj2pitPkgO/i7NySSKRGxjEM1jeq3EhBILAlUHfF4?=
 =?us-ascii?Q?6E+i5QqlUsC1uN/vL6NmQ2Xep5it7uZZGSp162ouZecn+eAd/BwO+oBLXIEo?=
 =?us-ascii?Q?89OU9AgScODZihS6URDWe1UFNOq8gGkUcilI3nJR9hAzFXA5kGYJ6s6Mbgb8?=
 =?us-ascii?Q?pWJifk+yGqW1cNJNN2z6S4CsfUp34LJIYjv1Qbta5ERusokBdaSzqy+t6YWP?=
 =?us-ascii?Q?4KP/mztSoIYXeyFIpNNzt2sxrXU8CnUVo/+OyhADVDjQqxJryoMik347X5oO?=
 =?us-ascii?Q?rTagZJmNW6Wtnm0BdbHiIhXfUmpmkJ5DZ53+yMBMEwcVHEhXLCBDj/qHmGE+?=
 =?us-ascii?Q?JRYnvrHlvBCLQKblaD1dGN+SLPudn1EOD78yblY1BRm4GLE3BjA6OEJhKTA2?=
 =?us-ascii?Q?dVojtZGmRve9dw/mykWn9af6+fWetU7iEhkyqJKovSJDTtGN4B5hjhBq7SYq?=
 =?us-ascii?Q?Xh78znpbKZ6/m9dpbbzCm2uoT50pkAxzw2c06tZP7oN3lDnEWX08oou+uVhT?=
 =?us-ascii?Q?d44Ct/Gk7OpitfMWu9SUI27h5EvbgPKSoAQfJd2EzI0XPnbZQM5gyLOe1FIo?=
 =?us-ascii?Q?Vg/ScsJC53jYC5AYY8RAo5GbtOwUJFnHHSX1wI2di3nYQ5MhHowUapLOf2wn?=
 =?us-ascii?Q?BGCImwplYjLMgy11IjShiySEOueqy8XhJPciMglNVqQkfgVuZ0Hxc15VDOpo?=
 =?us-ascii?Q?c28tlriJ4VBY79rWosTgdrcCt53AU5KPaqXchy1Pl32YCQgK3qW0FG7QadGj?=
 =?us-ascii?Q?Z8cgSK4MsGJeJsDT5+uM0am7gorzYXqKnQ637Y6bxEyY9DnCIMJMQbqTnG2g?=
 =?us-ascii?Q?K/LFihFwo1w4Um6hfUxltvLcjr7aNxBeSJokc5gcrJAsd2bt1JtEmcKUKhka?=
 =?us-ascii?Q?imuUoIqLeZaaGJ8xOTEqQPvVP1NN6sBonSYpJqH0YZBgIT5yw61Z/bc0DdrV?=
 =?us-ascii?Q?vCTTJmDXqZYG7Mf5s7aXrUm/whvwWdNkih6fpyDn0p8COy1Lvq5494odYHnC?=
 =?us-ascii?Q?PlsVyxSfpqob6hjMgJU20w4zWexyfv5SIjfw3jKnOfFXHEyyBzlfbocP8R1r?=
 =?us-ascii?Q?qZxkEY0VHuOkRZJ2KKuv3L8TM6zExZgQyOjcclSAM6doebVtW8APQkIYgtxM?=
 =?us-ascii?Q?iYSN4x3kc4Wkf7E2q+dXt2rC5DU2wHGoKOYE+sr7ugSWC1NAreTPsuffIBRF?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ae2b92-418a-463d-505c-08dad9993f63
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:55:46.0542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANKA8XfiFJiO+zayvhJ/cJoGX8FX6urmmGfZzJ6/yb4mc//cSeqsO6HirwEizEvLKz6waI/JAbSNU+q4/1QXzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776

On Thu, Dec 08, 2022 at 06:54:11PM +0100, Dmytro Shytyi wrote:
> Hello,
> 
> 
> It is okay for me to changing the meeting day to Tuesday.

It's fine for me too.

Thanks,
-Geliang

> 
> Thanks.
> 
> 
> Dmytro.
> 
> 
> On 12/8/2022 6:51 PM, Matthieu Baerts wrote:
> > Hello,
> > 
> > At the last meeting, we discussed the idea of re-scheduling the weekly
> > meetings we have because some people might not be able to join or prefer
> > another moment.
> > 
> > But because we were exceptionally only 3 today because of the feast of
> > the Immaculate Conception, we didn't take any decision. Instead, we
> > would then like to hear from people who want to participate to know what
> > they think about eventually:
> > 
> > - Changing the day to Tuesday?
> >    - It might be better to avoid Monday (morning) and Friday (evening).
> >    - Wednesday was not OK for today's participants
> > 
> > - Changing the time to have it one hour later?
> >    - It means 17:00 UTC (9am PST, 6pm CET, 1am CST)
> >    - This is late for people in China but midnight is late anyway
> >    - Maybe we can also schedule less frequent meetings at a different
> > time (or on request), e.g. morning in Europe, afternoon in China?
> >    - (the BPF weekly meetings are on Thursdays at 17:00 UTC)
> > 
> > What would be OK or not OK for you? Tuesday or Thursday, same time or
> > one hour later?
> > 
> > Thanks,
> > Matt
