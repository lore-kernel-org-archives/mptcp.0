Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD591FA1
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648132867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fjcyNeg72ejzDTy0W0iSp0jS5v0bOhjo/0VX6yh1oog=;
	b=SmsgzncwSEllUABl869CRZVn0eW+kERBXrJFINcd7MD8zGvXO2lgUF2NbtJu4iZXbdj6MD
	aDRoyWn1BK0dMZjnnrHfcMWh3Jx2DGAxs7CwxDXAINiuKvlIPsgrdtFxTjgM5nLVTN1ic5
	2iz6Xup6ZuCNsV0kVUGnWJzgM+WqF/I=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-jLDNJ6VZMy-oZ14bmVUcdA-1; Thu, 24 Mar 2022 15:41:06 +0100
X-MC-Unique: jLDNJ6VZMy-oZ14bmVUcdA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc7dQAbVJB04ZI4NpYXi00EJS6OYZWrCcTBhi+2LKJO4Yly6LGXFo3sjFweASJMGxD3qlvu6J0jktBS1QJBjaTpGTEZwjgq8cz1/hPoNcQKqYxZA8CdhYKEsVq+1HPCWo9cB6CPeyo7KjdihR3YWcemvnAa4Wy115VQ0iRwHU0J3zFnokHDUzlGhHcL7XUR+a/7yUm2U0PyMNdngSgnsbeapohYAnW2BPil2y5ok45H2u9/Fo5PACHwXJVxTx7NHupc6F6lCP5eg8Z6C6R5osNZkQ557EPLMMzUSP4+CY2eMwat3xg0+nWyFAuXWjPqASjNRz55KC6PiwTS90Ka+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjcyNeg72ejzDTy0W0iSp0jS5v0bOhjo/0VX6yh1oog=;
 b=GxC5gll+pp2TW9L7Od/imn7pIuwCDGmhE1sihIRS1xI6KVZBYyFw+LK/xemSX8sqJX8N0/Sd2k6srYPxsRspnvyCJwKuWslxcr9JnMdAH9mFkpFg+Pz5wTjyuK3fEIEl4/L8j7kdUfTRwpYhWQ6UtTkwix8YGy5pkrNVJlEuGmiX2VvbMy9zMGvj+iO3ogy2VDzeRbiy7bqsf7auCCS3ymItZVOTfOKB/KTT1QCfm2QLLeuC0G/VfbmhvWXzeKmWrsDmBfjJ03sXlru7G7Ido/JGbi0o8KoGA+zyScwGhAkJY49UCL4sNmxTRxuZnF0fAlytjk9cIKAOA89b+FGbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3431.eurprd04.prod.outlook.com (2603:10a6:209:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Thu, 24 Mar
 2022 14:41:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:41:04 +0000
Date: Thu, 24 Mar 2022 22:41:10 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct
 mptcp_sched_ops
Message-ID: <20220324144110.GA15636@localhost>
References: <cover.1648130637.git.geliang.tang@suse.com>
 <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
 <20220324142753.GD24666@breakpoint.cc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324142753.GD24666@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1f47208-009e-40b7-a447-08da0da452c9
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3431:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3431783DC3145C2A6D4A51FDF8199@AM6PR0402MB3431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0o8YVn7MWhlEIhc3h2lhY5p2XvrjHrwn0q5599QyNfNxme1ABnLtkskPkdU7piEA+Yxc/6Wwr4CwQtuGnJQd8jjL/R8b8INhz05cyRjwxMv5E1CMRayQFFxBFI6l8/hQzWOH6gOM9jIye1Lat5juTYP6jEP0n1bZMWYrtO80KJCECOH2bgeZKaQcXlXM8pm2DuDFQEED95Qmf3KflWy6EHosHrRoyvnLDG6uqLYQXoV9tz2J/uDG6shjPlzHT+GWYd6oqqEvpbnQYnnybfXLLpijfurtv74VVZ8jHBZXlNnHJwBOd5tPfyPSnpO81OQDQGu3bAUyXuNOj7eiAN6Iq794y8kufcAlu31OQbfDTC1iO5ixYdb5p/1dpwQqZp9Em074YUIVmbECsjjUttHhpc6FXNv0dx8EF6bZG1cci4tF1WtI75xC5/qtqCBd8erNIHZLMamNYUX0lG4fhrvHJUsPDtg5MAmSlsX3SMftZE3lkmJw0OkHLyMprN4icjsHJ/Ufas9Q8WPccPqaJCwqZQcbG+pFT34wuCKv5ZUUH1S60ko0oTJwFkWsyrzFt5erowQpv4RfPjv5BetDJ5IQS6j4kMEwyjQn+AUS+/2C4yQq5/8wC58dH1rhOSurdd49KgPezz2FoE2a/OjyhgzJHwY0Sxo+mpo3y2G14leQu4k+XkG+FrtxrJI1kLLzCdiAAhFrM39XX6YXGh/QlqYEtGO96RwiW/2eZa4jpvm+zcdUfy4NVisHCtrcCHmydcT9qfv/mG+czaUxOl+AZh42s3JVdSG1dNbuaQdXVgIxtsw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(26005)(33656002)(38100700002)(1076003)(186003)(66476007)(6506007)(6512007)(9686003)(44832011)(6666004)(2906002)(33716001)(83380400001)(508600001)(6916009)(5660300002)(316002)(966005)(8676002)(66946007)(66556008)(4326008)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OKYw6oh081qwKhHC86ISTg+gNgISWPwzKDAb+uYtuGFoy89zKee1MLrehMGF?=
 =?us-ascii?Q?sYqMPFatHJhMnJSksH2IyitE79lsl2VWoQGZ7MjAPgzx2w6C1JvkJW/5hs7g?=
 =?us-ascii?Q?MCpTgQV5oMDndxNb8AzMWg339PkVbhs66/pZ1mLZqxy/bVcU+eCY9q4pAYg1?=
 =?us-ascii?Q?HlKbd0rExNMkVxZSy70nH60gOq+Hm2wKHfH+DrbRY8Z8MBogZsYewRVpz5IB?=
 =?us-ascii?Q?Mvdmoz37Ij8RR5Y8ZyFgxhN2OKkja2TwogNml3lKXGpyXMj1BoqBRfViEFdB?=
 =?us-ascii?Q?aEIqi51WHRynPsKzhWpjmQQWh9hIN7TNNtxMRtcACyLY16piXOwfpREAmPu5?=
 =?us-ascii?Q?3rg6N4Er43q5vX2LpKAoDlPN+KY8U0tmTlP7+yhYWMMJiJqw2UX+xhzOz9NL?=
 =?us-ascii?Q?OJWEHQKekuEH4DQkfahj9nSb2cBYe5PqjtgFt0bARIl7VtDMrS8dUo5gyMVp?=
 =?us-ascii?Q?kabJ1VNdpM1Jutm/8Oxf7sZWVKQzYvWZ19LWe7PbaJAPE6BlUCjpXEVBqO0V?=
 =?us-ascii?Q?TeArkQFrmXM358i9qcKg2VGk1ZF2PWedIR8wiPbeJpJefoaelVQIg+1hU6LI?=
 =?us-ascii?Q?q8NsTzPi85eyOB2nbq5e7vXJ+k8DlffURlt6SgXqiSp0pGv1QEmVG/rw8UM2?=
 =?us-ascii?Q?usqk7cjUzF0I0mjWJiiUB3QhgzLSFG74FcrBE1NOv9TdzZ7bP3Lu6t88sxth?=
 =?us-ascii?Q?YKJZD1fEgOWWBJUo8xzR/i0mQRSNE1NGLjmXuD8uGS4+S69AEXoO534h8dTC?=
 =?us-ascii?Q?LFOkl3xgn7p8Yi+nynWr9NxB1IOgR1aSfr6YjYglOwkYyC0Wftpa0kO3F/gr?=
 =?us-ascii?Q?waUTZ0UEibGMsvlIP13/wPizW0Qj8bQPfM86OKFvMVOXisR+GvCWa8ghUOTQ?=
 =?us-ascii?Q?upnNXvgjoJZHQN7d9vsnhjjts0zZqW2Ob4TmXazJYEMG6zF4GHZAhQQXRR7Z?=
 =?us-ascii?Q?+eUoonJmIM2USp1kGszCrjoSpw6p4lAl0j6wL9s3Zf+7L5/Xlipw+z3RrD17?=
 =?us-ascii?Q?cpCDdXCuo/V4AaOWQFCYpu1oVp8tEbzgrshoqf87qQnSZ1iF2a2cReJtdxcY?=
 =?us-ascii?Q?ZOUS9bkZFUWs9WvqO3HGMSTy7jJQGRvEoP50iByY3Li9sg7cxARM1vy9JjbZ?=
 =?us-ascii?Q?E9oaSfc8SP7uaUEIKKHpeXEqDwhwhySVDUqgVxY/XHXAxfFKQql/B4R/Ygtw?=
 =?us-ascii?Q?mujmcOKt97JGic1SjTlq4INPBGv6g+iYP2Mj7nWe9IILETnH4v5TpfpXrJrv?=
 =?us-ascii?Q?YaeJy2u3ZYzV4GSBN6ryVVbW2srWx4JXpmJ1hiHEQfB7bRceupaVLpthoRLq?=
 =?us-ascii?Q?C1bQPiqvgZel1+MJJuhNGnRosbInJXE4IXVjIcVpybgrCR94uzD5tKTF+/lX?=
 =?us-ascii?Q?KzTi5xq1WSx3k0oacwoeN20/rDixLrxo4Jxa1Q7ne25WrtNAgLU54mGgljYO?=
 =?us-ascii?Q?A1FlCE1BP/R18iVmffJsyuNaJ1zHtuEE+0Wd+o4S+S/2bPbZ0vw4Uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f47208-009e-40b7-a447-08da0da452c9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:41:04.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnenIPyhISbLX4LV4r/dRNFbFx0HSxEDHBBUO93GqxLHbAYEEkX4ETmwfuQkd0EZuaxuZSReoZsjwRHZNpusmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3431

On Thu, Mar 24, 2022 at 03:27:53PM +0100, Florian Westphal wrote:
> Geliang Tang <geliang.tang@suse.com> wrote:
> > This patch added struct mptcp_sched_ops. And define the scheduler
> > register, unregister and find functions.
> 
> ... but why are they pernet?  Makes no sense to me, so an
> explanation would help.  Or, remove the pernet ops.
> 
> All callers pass &init_net, so I don't think there is any reason
> for pernet data structures here.

v4 used global list instead of pernet list:

https://patchwork.kernel.org/project/mptcp/patch/02c1d2d2eee134713737fe5c5f73127e8c741589.1647942374.git.geliang.tang@suse.com/

Should I go back to v4?

> 
> > +struct mptcp_sched_ops *mptcp_sched_find(const struct net *net,
> > +					 const char *name)
> > +{
> > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > +	struct mptcp_sched_ops *sched, *ret = NULL;
> > +
> > +	spin_lock(&pernet->lock);
> > +	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
> > +		if (!strcmp(sched->name, name)) {
> > +			ret = sched;
> > +			break;
> > +		}
> > +	}
> > +	spin_unlock(&pernet->lock);
> > +
> 
> Locking isn't needed here if caller holds rcu read lock.
> 
> > +int mptcp_register_scheduler(const struct net *net,
> > +			     struct mptcp_sched_ops *sched)
> > +{
> > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > +
> > +	if (!sched->get_subflow)
> > +		return -EINVAL;
> > +
> > +	if (mptcp_sched_find(net, sched->name))
> > +		return -EEXIST;
> > +
> > +	spin_lock(&pernet->lock);
> > +	list_add_tail_rcu(&sched->list, &pernet->sched_list);
> > +	spin_unlock(&pernet->lock);
> 
> I would use global list/lock, not pernet registration.
> I don't see a reason why that is needed, its just duplicate info.
> 
> > +void mptcp_unregister_scheduler(const struct net *net,
> > +				struct mptcp_sched_ops *sched)
> > +{
> > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > +
> > +	spin_lock(&pernet->lock);
> > +	list_del_rcu(&sched->list);
> > +	spin_unlock(&pernet->lock);
> > +
> > +	synchronize_rcu();
> 
> Why synchronize_rcu()?  Comment please why that is needed, no freeing
> happens?
> 
> > +	struct sched_pernet *pernet = sched_get_pernet(net);
> > +	struct mptcp_sched_ops *sched;
> > +
> > +	spin_lock(&pernet->lock);
> > +	list_for_each_entry_rcu(sched, &pernet->sched_list, list)
> > +		list_del_rcu(&sched->list);
> > +	spin_unlock(&pernet->lock);
> > +
> > +	synchronize_rcu();
> 
> Same, why is it needed?
> 

