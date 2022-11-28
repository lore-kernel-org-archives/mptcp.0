Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF7364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:32:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrRFoomYu5Frjs1GrH2AuHN4aZX65HkxJ6wZSwAp/PCku0NCOZo7Qi6pYffXsymeXL0TcEqNPOY6a9pYEgFRGNj73twKaIzrQOoznqPHihQiJaWWqX146a+0WbDQywH0NLBygb+TjzYKy9Q4Tr+5eIgr7mQOxPq7c8TKho4nURBbZiaqSsHPqCkaVRYXk46QF7p3lOuKtFcbfcHFsV351fU+mLK7GM8cqm2Vqagz2zbbJzIc+A1Rvuvd6cXkwX9CU4wCg5t+7xn7q6Hx4RXMqtmvG17VeQlrWud7Z4stu1E0KTVR1HB7MwqfTCNoabyP6wOMKJUTYyYoyGtNidv9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4B+sE0udJMCfL+BhVoEszpikX3bN8qSNP86Ui0S4Jg=;
 b=PS75r8ga6orkuvO8TzB+E7UWqoiTxEb3NTSacsn76WlWxPrIPYc7dI8TI4lCnjo3r13xo8hSxlLr5U5CXhi5t849S62JtmAksCqC6KRfadcHzhBX++HCDay6N8a57YjVF/9hqtdApd7LqoZyDaO/lnuLsJEckXBoRqn7FdrcPvgM1u1agqjSwYhTLE9NuZu+Agr8OVbIKoXGkwkWw2bIrFY0lQOh8ihxyd26U4/4pYaMzj2J13Y8t4gPV9Sc/E5rHAfz7Y3fK7yhTYd/SJjarzIchMcH4R0TEgefvawHRAUqw0KoZGhNwhJJyFGkgAvcLKi3dI/7Mte+EyPTr7Hg0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4B+sE0udJMCfL+BhVoEszpikX3bN8qSNP86Ui0S4Jg=;
 b=k/5tIrY8SQpK5h7R7h5DJSRXex3UfBHIrln1XQ9Z/CZTkFxoGyoFfg2TIoMFBVS2KoOFwiwZqIKhuLkYN81YwvcSYeqUQ8bJH8Zk1mFyM9DsDjqSWhlkcaslzY0fxa3yHZ87DznGrEncGdV5VyAkEH/sip6YA5Sso5xktDl9GxTy+JcEeor+sKmdzaTavhWkKlSjB9lQ1c9i1MtDxrHDCw5KRpbpB55/Lbt0U36yuW4ZiIXJLdZiAp9aTJheXkx72qb2ppgabBYyzTeppzFWMycT5WU6h/xVspJRiinceCINCz+lQNtgFW80IiK7CoOb1NeHIML/2lJBjn37m/wIVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9693.eurprd04.prod.outlook.com (2603:10a6:10:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Mon, 28 Nov
 2022 03:32:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:32:35 +0000
Date: Mon, 28 Nov 2022 11:33:14 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 5/7] mptcp: delay updating already_sent
Message-ID: <20221128033314.GA4370@localhost>
References: <cover.1668598782.git.geliang.tang@suse.com>
 <863432f61618b8625948918365524c9bfa9f9aed.1668598782.git.geliang.tang@suse.com>
 <4bb1b7db-1410-c0d7-ea8a-f73965605ee4@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb1b7db-1410-c0d7-ea8a-f73965605ee4@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee08cd1-e580-470e-81ea-08dad0f130dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w7tKzocQLO04g5+Rm8y22RUkqtua7oIfrM13gk2MY6TzepD15IS8dZwmC7OV5omNlwWSvausUseayI0+ZDtrFa8DOoNBC8Z2XCt5dgD5HeJ8b108j7W2Y5e7ANsmPD6aTq2zX+jFSKdGhjLDH6xXm8pdDkwRinnHYM1mFqhUNB6toQYiDQZPZFadlMmRInAbvmAZgmaIQQrDG6iuMx0mhjx4kDCD33+SiJTH3ZwMjDj/d8oi8sAGDRFgf64k2wTRivNcT5vXn5FOujtnHt0QeOvi19u5oQ6PDLJNXlg6IeYquKmiujgV9scYshJNxfmgI8WeAj7IA0EY3+YA00MXpcGtz2h1TaA1uLPR3w7S5RgdTZmSOGu741lOmqv8NP5Ok3jKhTsFEbd2MGjqOwVlv0A6V91IIHjzpCftwV0Dbpgb5eMDxVTrll8SovJ/r8U7k36J03EoF9tlfSPZHFPhS9Tft7033DFVX0+1jv077EZDUE3Gd0Pd9VGC81stmE9bG7+GgrM+ItMGtsrm72yMXLuXeBDEUs/2jKspp9Xuvlkfj8jW+1AtJ88UKrKpfqlg9wLg5gBQcMoIyajlZDEPMCENoPlUe6pgOnBWzDYzcEHsn36+jNicZJViHiMTbxlq9xJFKindacq5FI3euAKemau1Jl+NPlbLVEc+ltgsmbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(9686003)(2906002)(66946007)(41300700001)(33656002)(83380400001)(66556008)(66476007)(44832011)(6916009)(316002)(4326008)(8936002)(5660300002)(6666004)(8676002)(26005)(86362001)(478600001)(6506007)(33716001)(6512007)(38100700002)(186003)(1076003)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pTQi5nDJ3HGPsinI2KZFVtaZsf4h6iIX6GxiLqpEbe/E6ScSXdmlmCO+/AKv?=
 =?us-ascii?Q?i/CfTKJD6ug1syXVXhKmYEBRLH5divufajsArF0xGja2gklVUXU6b/diARzU?=
 =?us-ascii?Q?rVNOocFk1vPj9EjOS6jwEgMWYQKguL9OwTYUooSGfYPU2w2pUnBxzOcGAM0z?=
 =?us-ascii?Q?OMXS3e8NjrdfLgPXbLnZAUYTby/8OCyoYcKYQkEWgP1z0vWycsso7dN39XC6?=
 =?us-ascii?Q?0NvCF3UO8iw+9q46oUlO02Bup0dKrUCJRj8nEIQUkJjxVRNZbyx+zc/PWqpP?=
 =?us-ascii?Q?If4ZxFiC3jmc6vrwzInB5oSH8pTf19lUlBQjnTZQNQq8DyUaqqtwEkQPjlIy?=
 =?us-ascii?Q?su8+reP69LvdfZ27PAwiSlC2N0CS+C+bgYkUD0/mbn4mqXKvQqGhgGEkNKZg?=
 =?us-ascii?Q?/7XlbQQEsnEcdod68QxgMpbSgeagijL1Y+84YX8pDcKIMPokDJl6uYeQHQDO?=
 =?us-ascii?Q?XeXECv2OLEmOa9EBOp2o8jg8WnWzxN0xpBtYa5BvRGeQCywdkrDlTkHhwU/J?=
 =?us-ascii?Q?4n49uhtVzRqJE50q/10s1yW7lwOrMNreFSdR0KECBLfxshj3MJk4+a48kGlb?=
 =?us-ascii?Q?Zd3Z8pwYfQ4T+rewaGo7YOMwCTZ2Y2pcNG9OoAVOeXZQN1jQWDVqune5oz7w?=
 =?us-ascii?Q?PubP5k7zfz7zq8LY9eJaKUW7jgsquAgTy7cTG6FcbQKhaVE18YO73EUyueBj?=
 =?us-ascii?Q?29mjRSFIfKFfJBF93j1wxg1lTUkoLRTaFiXv1nFOOfHYo9rvT+GEmsoa452A?=
 =?us-ascii?Q?++tLcX/rx9W3fUUfrtzEDjgVN9FubRwQamSDBvDG0zxf/e592U9HKeOSBHPf?=
 =?us-ascii?Q?Qcu+nGPc3346TdQuE1gcoT4aUFginJZ3pedX/oAKpWg1l4PhLIjVx4zeZGof?=
 =?us-ascii?Q?ocac76L+fsT/lc7IpbbrRd9seCrBZl0ms635L4szLbxGkwwD+ARSz+scgzG7?=
 =?us-ascii?Q?JFUew4W3EzR/go9+kISIhdeVYj6NvGbYg5fHNVnnpOoynmyAEuc8G7LBhAFW?=
 =?us-ascii?Q?eULWvIaAxR93Cp5Yi5mPs8hDa9c746BtZ4dOOkXiiyNvZMTx8AFagqjUxQzf?=
 =?us-ascii?Q?O1ExUZNncJDFQY2nTYjydXh7vaPWbIeKkv5sJb2O+mq0jSABDx8jYVww7LeT?=
 =?us-ascii?Q?4pvXCPv8YJwDcuswWZiT2+61Ki6xtdX+nXyYTThhhpoR4UUFBzmx9TroehLI?=
 =?us-ascii?Q?ikUSKL9LjfFmKOkZnlU09EvfcgDsjkTWYl9mtqlSVcq13dSEyRw4fFv6PZjC?=
 =?us-ascii?Q?LbIPoSKLSZAwnmGsLrgjrnCnWWA+Q1Am+K5eAPkEArvZ1n2SjWIOB4Q8Gjly?=
 =?us-ascii?Q?/7wm4oAD/ucMap3SAu8XOSlxcS8pNOpNgh68Uh4/R76jmW4vWFTa+4Z7EEgL?=
 =?us-ascii?Q?S+Jv5Cl0ylkFmwMyjgsxDc0kfxYlZtUDOwTmnduLeqnIYGW8cODDSnCGuxH1?=
 =?us-ascii?Q?XejVihthinPt7Dry35vcFzX+FPAfXYAyX+2bvqUPH8TJNoDpm2ZHWRDLqz+Z?=
 =?us-ascii?Q?r50I5xOqVd5Jc6M/rdaFgRcLt66Qdsax7qAx+czU7jIujwBIzSyzumiQqEKn?=
 =?us-ascii?Q?6kRleWLO3Gg1mkkY3cg5y/VinX4N/JkqHWWyxCHTefqNJL/SKbk6QjtAQxmF?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee08cd1-e580-470e-81ea-08dad0f130dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:32:35.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go7wSewsztUnMHIUBTZJA6Q79erawedaYmXKTRFm2fYAViY3npPYL5eUmu+9mxXaG6HgxrGAKufdpz5c7EQmCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9693

On Fri, Nov 18, 2022 at 02:15:30PM -0800, Mat Martineau wrote:
> On Wed, 16 Nov 2022, Geliang Tang wrote:
> 
> > This patch adds a new member sent in struct mptcp_data_frag, save
> > info->sent in it, to support delay updating already_sent of dfrags
> > until all data is sent.
> > 
> 
> I think this patch is likely the cause of the DSS issues you mentioned in
> https://lore.kernel.org/mptcp/20221022125610.GA28495@bogon/
> 
> Looking at the code some more, __mptcp_clean_una() accesses and modifies
> dfrag->already_sent. If data is sent on one subflow, it can be acked at any
> time - even while the redundant sends are still happening on other subflows.
> So I don't think delaying dfrag->already_sent updates is a design that can
> work.
> 
> This makes me think that redundant sends need to work more like the MPTCP
> retransmit code path. When the scheduler selects multiple subflows, the
> first subflow to send is a "normal" transmit, and any other subflows would
> act like a retransmit when accessing the dfrags.

Hi Mat,

I changed the redundant sends on the retransmit code path in v21, but
the DSS issues still exist.

Thanks,
-Geliang

> 
> 
> - Mat
> 
> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > net/mptcp/protocol.c | 18 ++++++++++++++++--
> > net/mptcp/protocol.h |  1 +
> > 2 files changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 4c249d1b9ec6..a1007751bd4d 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1099,6 +1099,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
> > 	dfrag->data_seq = msk->write_seq;
> > 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
> > 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
> > +	dfrag->sent = 0;
> > 	dfrag->already_sent = 0;
> > 	dfrag->page = pfrag->page;
> > 
> > @@ -1484,11 +1485,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
> > {
> > 	u64 snd_nxt_new = dfrag->data_seq;
> > 
> > -	dfrag->already_sent += sent;
> > +	dfrag->sent += sent;
> > 
> > 	msk->snd_burst -= sent;
> > 
> > -	snd_nxt_new += dfrag->already_sent;
> > +	snd_nxt_new += dfrag->sent;
> > 
> > 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
> > 	 * is recovering after a failover. In that event, this re-sends
> > @@ -1513,6 +1514,18 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
> > 
> > static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
> > {
> > +	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
> > +
> > +	if (!dfrag)
> > +		return;
> > +
> > +	do {
> > +		if (dfrag->sent) {
> > +			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
> > +			dfrag->sent = 0;
> > +		}
> > +	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
> > +
> > 	mptcp_update_first_pending(sk, info);
> > }
> > 
> > @@ -1539,6 +1552,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> > 		info->sent = dfrag->already_sent;
> > 		info->limit = dfrag->data_len;
> > 		len = dfrag->data_len - dfrag->already_sent;
> > +		dfrag->sent = info->sent;
> > 		while (len > 0) {
> > 			int ret = 0;
> > 
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index cdce0c092c3c..cdadb39a03da 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -250,6 +250,7 @@ struct mptcp_data_frag {
> > 	u16 data_len;
> > 	u16 offset;
> > 	u16 overhead;
> > +	u16 sent;
> > 	u16 already_sent;
> > 	struct page *page;
> > };
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
