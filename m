Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25461FA1
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648137984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eta4Vsa76KYzpSGfKduIedtKstYrGV1LSn7ZVOcGdK0=;
	b=IvrTXdGvGtFkaH0BPMY5nCUEWeVU3A4NrrZ7029CKwz2svY5X9lzZxNC77wsSMTGQK0I1p
	QkGrHbfajdXu+6eTyS2+8uA5TVx/XLt+cLU/QlL1XX0JeYqGAWzkddTa9+PK5FUgXF5UQD
	sacs/H/DeiVuljOQ8Z04WHC/kxt/D9I=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-Owp8R09pN4KF4o10KlzfZg-1; Thu, 24 Mar 2022 17:06:23 +0100
X-MC-Unique: Owp8R09pN4KF4o10KlzfZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldfNIjx01Y7vB2XmSno49OFoo9KKHDLQ3P3uUZW4BqvlzcEnvEZuhIzErJ71bvY2YwZllisnKqTshZZC3orpPHv69VcWDw/pQaxJTBzGeVhboQMu0a0C/NAniPPpk1Hh6b4kq6UCUiVBZDKQtCODMdj9zIiG9fTzSjkESUWuNNSF98Ayjk9WAHS0XF8rNEBXWHaNUR+v7frklhfA1nRxicZLbdJkhYWnuUn4V9r3+ZT+Bvc8u3bPutSJCJ8G0hqPs9BtMUpt8/1iGaP5vkQwBzIpkUqEp572gFXL/2kJjmVZOmyxcqdAm5W1W7kxevfF/fpWyp/Z9X2k/Q4vgnHE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eta4Vsa76KYzpSGfKduIedtKstYrGV1LSn7ZVOcGdK0=;
 b=cAVKCjI6Mr69G9rhJgIgrYaAO4gFsOf0Lm/y7xhNjGmnkOg6S7DbUya+hvj043PDfQX2ianZfTtQ2hp3p2JeklN1dJ+Ss/70aO1wEMpUc1v/rtaX8Yi/zJw5agwF//IOHinQoM//tIFCJFXkcRO5NdsNt5KkbMxQO4dQnu/o3oB9WGMHWo3ma8Q9K+vKKGQRBk8LOyvswuBPfQHiE38DyWZemOaKlD0icgC2OT75Qx8ipmHtcEM8e81IinUMT266RUk8o69RC+pZ73bFy0Fk45HKGY30VdZvrhYKC6Ufdc0wCVFPu2CGSytrEJN8298Dt4cxFOQPHqBH1OgKMbdcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4353.eurprd04.prod.outlook.com (2603:10a6:208:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 16:06:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 16:06:21 +0000
Date: Fri, 25 Mar 2022 00:06:27 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct
 mptcp_sched_ops
Message-ID: <20220324160627.GA17230@localhost>
References: <cover.1648130637.git.geliang.tang@suse.com>
 <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
 <20220324142753.GD24666@breakpoint.cc>
 <20220324144110.GA15636@localhost>
 <20220324150327.GE24666@breakpoint.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324150327.GE24666@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a55b697d-5fba-4d06-8513-08da0db03c80
X-MS-TrafficTypeDiagnostic: AM0PR04MB4353:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4353AD6B0A96DF3117E3537AF8199@AM0PR04MB4353.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vnRH9YXvUa58ch1hDnBf9K4PhZrqD/VFfLrP2l1RrFu5/4p2emWksgAns+ieAV+RrEpoGy2t1RyzzFs4H77G0F8xmRUlLTXPSRIxhe7D94QaLOfPo5pRThB+JJxObr5W+5GLhf4OBGps5234GWREs+YzEeW86oVbdbTLjcIpXcSGLJ2ov/XTtdDT10O3Oli7tIPiq4Ozvde2K5m1O0fcTsDpMVzrPqZASaym/liQb0xCd3tX7anUUD6v3TvE1Cw9FQ//3BzxKmy8TpqnL0cAz4g3SuuCgD5H0ABi5NAvLX3cVs4vnnEa7W/EsiCcZf7RmAVcZ4VJD9KuHmqywHnySTaQbkZHbI49q78BBPKL6yS7s2jyKvfPx9Ag00bbCoaqMicf7LjQX0VQKlkL5hlUB6tV3NtkU7z/dZhoFE0cJOPl4mgLmnyxFaihfHYhx7qlRugdnZ5nTA5DqS+C0u9W07p6Dzr+uvsC/gTGU6lCe+QhDsUkSAmsgm8yA+hFQy1Hwqqtcq8vY2ZnzBtN0imViRsa3QEQmViq+qgaF0xtkJW1SKOIRI3zJKkM6UkWeFnfNugp86oQZMo4hWfqfzb44k9Qvz9Mb1bKK2p+lk8E3dozW9ALI8mVkUON5DglDyv1x4v5ZPVOrW8E7elz/isuYenMNYLIKBOsngLTeon1R1U7gxFlvcBASBeyZ4k4c1Y5suPxD/0jb6iGkhUz/BMUOegKyRo4iTQhEyNvOiDe5B1JWaPd+HptYCVRjvzjzQHbybjDdgZRzTCWhAhuSWgi4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(508600001)(33656002)(33716001)(966005)(6486002)(4326008)(6512007)(5660300002)(316002)(86362001)(8676002)(6916009)(2906002)(66946007)(38100700002)(44832011)(83380400001)(66476007)(26005)(186003)(9686003)(1076003)(8936002)(6506007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I58wTplwWzpwRlgvb265rbn+8S/7xvUY3tJlfgnqj+yPYm2uZmeohZY1nfo2?=
 =?us-ascii?Q?5IA+7n4EbzWFDW1p6KqJX1zYeG+3mWSF0orLDaL0oLG7afTi8kmj5wm7hqli?=
 =?us-ascii?Q?eN2hqRBkUTpaaB45MXpoS7XqXjBsu8TM2KzfKZ8bQaaPS7VrFuHUNQJ1fIXx?=
 =?us-ascii?Q?+JpakIzDe7FZ5oaUZiChEHBqbFIKU3rJBaN12DbDYfuMAJAb2giLi2cpQbOy?=
 =?us-ascii?Q?fhWcKCG3+2I2o3a7citRn0CbbaNDHcpYW7NpAP+vMPkEj4j0qstF/8zIZ5iB?=
 =?us-ascii?Q?K9YSfnfZAClOYvBJOYQZCSMmJzfJvPBb/WYE+ybNWudnUiIi8WSxRmqmsCAM?=
 =?us-ascii?Q?kxlNkdN+SOtD7i9uJST1/xexFmgvAQTU8iRbN/zW+p+SZrVZ4ADHdpP1ON0O?=
 =?us-ascii?Q?wdVddnvc9CyfZzedOXjDzEXAXGgYcnBhvoldLeGhUEpLqpGqpTMfCsJhssNS?=
 =?us-ascii?Q?ZlFWZ6rJvUp10rmMvwu5U84p0j6JJps2zDHX/cXvDEBPtGJWwP+GMYqbjexd?=
 =?us-ascii?Q?9tXPPgpNebdmQ6AsFievFEVFuILof52S7UyPEJg4r/yXyEY0TBOqtKtgGq1S?=
 =?us-ascii?Q?zSFsQVtUCVfTNAg705AF6FBDMfF7a7ydJxqBYj4NM0arnBUR1rJ5qdZcHJsX?=
 =?us-ascii?Q?W5XaGCdygGxuNlrRnSs2GoFXa2b7TDgVLH8zuqQe6ayiNzK0bXh/6ix0nF0v?=
 =?us-ascii?Q?qQKC44QJmBR+cFG2aWjHxSETT5rcc23oRG/9oAl3K/RVuSbTLSqmR4uyN64N?=
 =?us-ascii?Q?jbzy3fDAx/Yoh3QfBznANM+AZUm8VvLrQW5mb2+lLZEZlS8qWlgUxoafvcjF?=
 =?us-ascii?Q?TznqBgGn/MfttHfovbP1nDiMCdiFCnJOj/7Hazv2SdMrOVXozVNBtbT+Tb+u?=
 =?us-ascii?Q?kFN5k0lCDEvn9luoujO1T7XkBfoCDFFFz2a01ztW9gNsih3iq/TxPzxhlsg/?=
 =?us-ascii?Q?upa6kp/dTRVXMfpyFM1i33Bt2gaMeZZOJEmjOPLiHBn5DR9X5D0Zwfrg+Y7T?=
 =?us-ascii?Q?NqfVqU6F0VYhgj+dNrkyiRqTw9yjoRMed9SVvkRxcHDWVuGurLVV07ecVcHd?=
 =?us-ascii?Q?7XjJtYHCzKd+xeLUQVeWSxwgNu8j5na+FQmb6mbfxtZr3zoNxs2/oOejldtf?=
 =?us-ascii?Q?W9zhqh3L9RpRIReZB04Y9qSYW9ED+elCJD02izpHETRLBuC0ou9CJBNi070Y?=
 =?us-ascii?Q?SsJ5CsioZkRHGMQQdmuOJ7lheEGMvKT6Q+50ivrVxc0CVvW/vJhj7cYW4a1v?=
 =?us-ascii?Q?/XVDTppdnefHCVNOmhZHrZVqxnZ1X5QhTh8AkuvkGsd+kHh14tgxT+ExJ83/?=
 =?us-ascii?Q?wBShOtc+R9HbvBrTLwLC+F5d6+1DruTOwef9hZ5FQa6fisUYH6qkQEWiHNaG?=
 =?us-ascii?Q?fEPTg14SDKKvukqYiePEwwkLaiZvfH7AyONLQEQm0BjJk8Z+22QuMJtEIo+V?=
 =?us-ascii?Q?IjzlW8I88f/F7HsuvHhnkFgl/rHgfBrJsm+JwdEZuCnMNGMcaYuo3M1AFXdS?=
 =?us-ascii?Q?qSbfcNghTT9q9yc2/yrLV1Vch9NkdN7G9KST3d2Fmjn24EksBVbtndVz2SJ1?=
 =?us-ascii?Q?FJdD0ipwcBI/BH3ZJehEQKvgJjJVKI4lYCYT/B7K48JWMEgzyIkskSEaEJzA?=
 =?us-ascii?Q?cxk1YZVUpVxgEWA8zZTiHlZVNpfQXoidPJoVWopPFOHK4GZwpuX8Ncuvn5fH?=
 =?us-ascii?Q?EifnE8S4hyY1x13cqdzYpnjB/3SQOYNt4BYIKck4eMGWrpSuJYcKrRTOvhNc?=
 =?us-ascii?Q?l7nYEjJlOc5fSEjeauzFSBpMBoi0qvg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55b697d-5fba-4d06-8513-08da0db03c80
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 16:06:21.0244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJ4feVDRQI/BNA2k5OAvI75NkaDdDot+5GaHPS8QH32vxPY71j01abtSnB3Xbdj6DvtPHwVSQFxC33AH4KGEug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4353

On Thu, Mar 24, 2022 at 04:03:27PM +0100, Florian Westphal wrote:
> Geliang Tang <geliang.tang@suse.com> wrote:
> > On Thu, Mar 24, 2022 at 03:27:53PM +0100, Florian Westphal wrote:
> > > Geliang Tang <geliang.tang@suse.com> wrote:
> > > > This patch added struct mptcp_sched_ops. And define the scheduler
> > > > register, unregister and find functions.
> > > 
> > > ... but why are they pernet?  Makes no sense to me, so an
> > > explanation would help.  Or, remove the pernet ops.
> > > 
> > > All callers pass &init_net, so I don't think there is any reason
> > > for pernet data structures here.
> > 
> > v4 used global list instead of pernet list:
> > 
> > https://patchwork.kernel.org/project/mptcp/patch/02c1d2d2eee134713737fe5c5f73127e8c741589.1647942374.git.geliang.tang@suse.com/

Florian, should I remove synchronize_rcu() in v4 too?

> > 
> > Should I go back to v4?
> 
> Mhh.  Mat, why the pernet thing? AFAICS all net namespaces would contain the
> same (albeit we'd have to kmemdup first to get unique list_heads....) info,
> so I don't understand why thats a good idea?
> 
> A single/global lock is fine if its not taken in the normal (per packet) case.
> 

