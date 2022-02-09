Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E860B2C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 03:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644376182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vEme6YVJ3NJWzmOT16N/yiiiEDMOgN289W2pkm9Jxco=;
	b=WDrVSIFsfA8imNheg3LHQlgeb3bnjui3H2oOiaO0mvqyfRDs9RwypKM2viXChU3BWlIfOV
	nznzEx8q4ueqw379HWX7O4IO6xMZ5vOe7tPaHFvoD35JSLgCbXk/IgpKr1fjS/3jb8RLee
	L5yWzawEldw7rFAyVsSMvlK9iTytXcA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-gL3s7LM7OnqkcZ8kpUUEKQ-1; Wed, 09 Feb 2022 04:09:41 +0100
X-MC-Unique: gL3s7LM7OnqkcZ8kpUUEKQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Z3cVIxdgV9QQobyPYVfjcVJPRJDqT19RxJMTLhlPybavz07MuBDmcqrJooV9BtB0QHMUJkTStmnEBd32HiPv4OUkhJoAjcTk8vysgWZYXQnWeUhJKt7/L8ajR8wF1neGz7lamZLEUtCpYza9KqynEdYIwJXNkSHdJ/ZmT31ziaUdaWnRVpAgM2isUKoWTX2WwIq55HkMlZhkC0Ge30eptM9LJXxJI0Rmy4b3HgP5FoSBWVGfnJpTQCe0Rw2bqC5W6rBnVAUGF5zE3ahBIFMQMuvWsWML/W7s7E9emeYeNArHNoSy14Z9KOHFRP8qrVpnakmie+MyxJDvjTErpd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEme6YVJ3NJWzmOT16N/yiiiEDMOgN289W2pkm9Jxco=;
 b=AhlaAhO/hXwkPb86KqSFY72YulHKAj+b1R0JrGWyzBlEuBDInjbM7Bp5vcRuZO5H5hiZGiTNQ0EuILJdSRrZBVNNlbmoy5MeEBA3/w+N0asLebEfK31XR7eQri86K/5/d5ZJo27CjYIaoLtv7IV1/TVwH/GJgqyNp5P9NLhESnkI6cLpK2ixwnfH33Nd463G/lRpANmZe8B/UH0BEckAABjqsBQpjOHa2xmqzgTMK0+/GpvfQrOT+uaKcU2jOCBgXlAUBMI5V+guH2//sww+KLlH6xjYoVbDYdEWqnD2iCN4phN38/bf8Lva9j0BQHONlEbLFHuMUDjGcibvVXNuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5196.eurprd04.prod.outlook.com (2603:10a6:10:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 03:09:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 03:09:38 +0000
Date: Wed, 9 Feb 2022 11:10:01 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] fix mptcp bpf selftest error
Message-ID: <20220209031001.GA3406@dhcp-10-157-36-190>
References: <cover.1644300192.git.geliang.tang@suse.com>
 <3fa7c8c7-6210-35cd-d038-6e6975539ff9@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa7c8c7-6210-35cd-d038-6e6975539ff9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa7130b1-0cd5-4fba-0773-08d9eb799bc3
X-MS-TrafficTypeDiagnostic: DB7PR04MB5196:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB519646D54E71912BF6B2075EF82E9@DB7PR04MB5196.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ytb+YTF+R5uNhsxht6JsdD8lkQf1jPkKKvMLTVp903CGA0rAYXdlg6rNPCWPSorPfGursuqafjRbrmxdTE/bDFvD4s3A4lV8BcxdcOdIRTk8dzBS127tgHhFSZKoFrvSMlojE5Bt6qj2L7xl3vwyFXjVW2TiRNQBBD5PbZkz5V2ppN055RWeQlqEosqLXYSKJl244CvzqU2UAbCtjg0Onrh4NQtKZuT7ksbIR4A7V9ItJugBNXG2q4UogF8rBG7I8E9dpjvzdrzFyuZjH6zDUATQg17t9/0Brc8/Zz3/hnVzWLoqtpRDEG8HFR0TyXpPiox3uEO1uMjsS/axxOl9HDArBklFwV6vRi1jlCvmlbW4QdYcNlpcTXiJWd6bYySt+/WVjhBomYnpKVZuW1NIw+gjCFzKMxYrQ8rGr/ZYbzUfc8EzV4fTxjPqPoaE4baH181MN0GMFSQoo0DGbZP4yjsss7s/O999X47eIFyLW739bxLcrHMlc+lcPUJ+vBm/Xuu01awjRd+ZtN3T9TclJ76YcNChzrGh/BFa3Rr2uSvWYyJbRg57hEC7sqW4p1rsUF7tGVzJajCw5iPRAfTyliPjGJ/uMinRg75ayTP0Up53f0ccSXKGZHOJFzRsJpdZpNBRmhLtxyYU2sX2wV12BUZs7gTLfTD4OLpGIy7uIQwoYWAuEr/2Oxvv3jesafL+0BCOTBvzkEh3CH+v4cAW3bMwDrSWhm0DBDTXojD+Jh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(8676002)(55236004)(66556008)(6916009)(316002)(6666004)(508600001)(33656002)(83380400001)(66476007)(6506007)(44832011)(66946007)(2906002)(186003)(26005)(5660300002)(6486002)(9686003)(6512007)(966005)(33716001)(86362001)(38100700002)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i/x5XkAVkAFPe3BggNGahaLICJ8As9J+p/hKwjL2ZO9wTI43L1+kBX3bhf1+?=
 =?us-ascii?Q?tRh1XIrb/oqWEq/5kuQ+oDsNULeyBvMZG8jjvSiMvggWGVYPTylHYxfD3sRQ?=
 =?us-ascii?Q?ATUxcQV7UhbNswxgWsKepcAMufD92CZR0qXoMB6uDVWULQ0OV8tfENKK7uXj?=
 =?us-ascii?Q?fp0Ii9JSFs5gt0Gnqd94o7JllG3Zz0xiVs0ebEd2JJhwk9HE3gBFwutQQArz?=
 =?us-ascii?Q?kALTn3Uy3oDg5tka6vL0DrcXczu/uBBZdFNe5sN62G/Akhu/n3OxIolgTC0l?=
 =?us-ascii?Q?jYB2OmwnvuC0We38LA+kU4T0cJ+mdoTMgHxHFF4Ul1pxYZMlH0yKV3MlpwNg?=
 =?us-ascii?Q?xEsEFifT8Xe7Z0E0xVHuQqeoqp69tkxCEUMgS0dsCZPIAC5PI5XFvRs6yjan?=
 =?us-ascii?Q?vx/LS22dUdlbeXziVJzWoAQniy77rtfCbqUjAXXAdF6Vs/2IqhW8pqeePF3k?=
 =?us-ascii?Q?TFwJFP9dpegdx21tBqFsd/iWp7P757A42Cmj3AfkqgfPKtNH/ffEskLRFCdt?=
 =?us-ascii?Q?jFuPVq3becNYVjE/416QmytbUEHCxT/KCVOOjkVGZjv2h+5ehaudkoTCK3WC?=
 =?us-ascii?Q?e+wMp8bVc0woVxAeO9wcKSqrJBeB+V/feiXB6hBwWROeTTUs+YMgeONhdcvR?=
 =?us-ascii?Q?ZOnsDMTHBK9qXFRzFdtgiPZ7YiKvPhMVMXZhIJBmQuBmtnunvURTKxvYMctb?=
 =?us-ascii?Q?MeFkq0aftaU6gVNrz21QRNMopbN6wU4lYJRjOa+C1rlYsIo1KhD+Dm2e/tik?=
 =?us-ascii?Q?SEaIdmaH5hNp//szWS50zH+ORdIw2krlG7gwRE0ysUo/aY1rMEGfuD9z/D6g?=
 =?us-ascii?Q?kohT9oHuksgoQWcktibII4bFGu4A0EWrfQKrRVEH5Oa9i6Ssvv6SrkK8deHH?=
 =?us-ascii?Q?VBgyqlYaLfUZH4nb8XelBqFsKwcbW7Cn0ZUrcfYnpFDF4UA2gaGR8y00ioaz?=
 =?us-ascii?Q?KL2uUb8M+m0r+kVTVf1p94LSJUPQDaQJ1ioUhW+ugC98ar4GPS3HXTgVxHOj?=
 =?us-ascii?Q?q5KJ65xSKw/z07WGQA47vXnOCFosEmw9rFfY0dvzDp+1rW9se8iflxDRMwLI?=
 =?us-ascii?Q?qHVrwF3nEwSKky9hvzAseWhK3EY9Ud9h5Kyn711bk/+hiqhpnh95/coylTh0?=
 =?us-ascii?Q?pvwaWNJPjamRJoB9dI6H/FM2Ppd1ziE5sBvTt+YuJ4WzkDL8q/PMs5Ovw3cG?=
 =?us-ascii?Q?4/JBC5pT5eqyrY5YQkQhe/mKh6JF0M+aZ5DOJj53B+QR9DjX2Nn4jr7nrLtG?=
 =?us-ascii?Q?SNzLz/tkFP3yZ8Rx3/lblzWmNfRTT7P8tPOsX/Y+BbJ9+LbKSzlMsIAUS50h?=
 =?us-ascii?Q?Cc3VYCdeMeAu+Bm4W/mPbyewGrZSqODetScReqqqJ7L4tx58N11k+Ts3qgOc?=
 =?us-ascii?Q?xXXzZu51mKYmPcIW/wQlvPSlFMbOqC9FvvaukLQaHmramlFUbLhJFUg4eu+K?=
 =?us-ascii?Q?fPRleaz6QXDo7ZGIqKiokK1goFvRaYt1ALNXfdKLE7+0yitbbud6JyYJ/oEq?=
 =?us-ascii?Q?RgkpMgPt/LV5oXHO3CZ522+aO5gPjEU12Hnvpx/YmXIDhLDSOdRLrF0x8p1R?=
 =?us-ascii?Q?6Y/rZkag3X4XzrNbHoVvGIpKnX2SxsFfmTIsW6suUhiyjikRFJuBeTnk7NBM?=
 =?us-ascii?Q?kuneEEwMW1zU0dpETcV6OKY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7130b1-0cd5-4fba-0773-08d9eb799bc3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 03:09:38.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxVvO2YTI6OFMFqxlxsMmPZ2ctBAThLxCPc9L6hTGIhdMKM5w6ml+730h8UaUnUEGMN2fUtrgzsgIJNP6T9shQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5196

On Tue, Feb 08, 2022 at 04:21:04PM -0800, Mat Martineau wrote:
> On Tue, 8 Feb 2022, Geliang Tang wrote:
> 
> > Fix the mptcp bpf selftest build break.
> > 
> > Geliang Tang (2):
> >  Squash to "bpf:selftests: add MPTCP test base"
> >  mptcp: add SNDTIMEO setsockopt support
> > 
> > net/mptcp/sockopt.c                            | 2 ++
> > tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
> > 2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.34.1
> 
> These look good for the export branch.
> 
> We did talk about SO_SNDTIMEO about a year ago:
> https://lore.kernel.org/mptcp/5e465bd5f4b3f7e883e09e3f4bc5a566edba045f.camel@redhat.com/
> 
> But Paolo's concern there no longer applies, because the socket option
> changes since then will apply the sndtimeo value to the msk instead of the
> first subflow.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 

Hi Matt,

When you merge the squash-to patch, could you please help me to rename the
subject of the original patch from
	"bpf:selftests: add MPTCP test base"
to
	"bpf: selftests: add MPTCP test base"
I think it seems a little strange that there is no space after the colon.
And the subject of another patch "bpf:selftests: add bpf_mptcp_sock()
verifier tests" needs to be renamed too.

In addition, I want to know why these four BPF patches have stayed on the
export branch for so long. Are there any functions that have not been
completed yet? I wonder if I can help.

Thanks,
-Geliang

> --
> Mat Martineau
> Intel
> 

