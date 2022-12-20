Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A77E
	for <mptcp@lists.linux.dev>; Tue, 20 Dec 2022 03:49:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/4obn9GwvnM/aOVAn7fYym46EWnzZ+c7K4dLsf50CGGTydgFxFAanRqCMZZVE59yK2/m0zBWskOYFKkUooS4ph0vRNaQfo9ctVmIv3uvE3rgW2MIUa7gcBRqT/EOCPY19FYoJ+joLkn3p+U9wFPHtnSm6PlXFKPkZ2LNXbLCfBSm7l+wBjcokf74u0JXJJ5oZJUf4ZcZpqHpO5sVl3V5pmLPVC1OEVlTmCYSTRFxgfRiAU1+T4DMK5JN+zZbBLLAHIH0JY9FN4bwC8tCW6cWua1OpA5O1YjaI1g4VSJjizZ/El4T9uzofQhR0+6qdJctzaNWD8ldbvCNaTaBAkwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtQulkrP4oJztdR4vn0GGi0u0tVp2hQoMKoaLrlwXBM=;
 b=i6DLaK0hs1kOQYh2kj5dz2aIG/k024/+dc3418BULJjS7f95F9tt9btvycJ/FWI0wCypAYAeoAPWoqVUqMVaFCejjK/IqKzASz9YivsayBztV5jQZrtcpU87DF9s2Rq7l6IIjFViW8fAxcwTLXqu+bPmKl4OkoO2OUOvCmwh7WWcQICxjdkgXwP9uVNNNwApJ51sK8btt8GdTW4+VTGrb9hRtUxJDby2GNgTlwjQqlfvvVi4oxjQkBlGCBUdd3i8HXjQLqTapYaX5H4K68Czo6TIc/EvS5LVqzQphzHnca08dQf+V59/+rwTbL7o7cu5O/+rVus9J3QaowLhiHe4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtQulkrP4oJztdR4vn0GGi0u0tVp2hQoMKoaLrlwXBM=;
 b=5Inb2rD3DwecJylDzGzdxaie2dQbOYUdD4Rw4rcxMYzb73BxwvrW7AcwzxV8ncX5YBwbTOm9QUmCTgyDXo3eAdimWioxXfjKzVWO71kMD54SggycVrmT3SzF44W5nVyVLAxFN78HOEBxzVAn0TSU/SupRD10Do5OshYgP6sKxRQLujopXTR1HWRZhYq6kCU84BNXsGNBPsOkviSnWhqy2BYbrXvGnWJk3z9+5Bef9DkhdTvFnbnFze9jWQTerjesjSG2vCcKTX/27S7au/qLX9nlq3LGWOYmSIZdLWdfaq4kpJFrT0qCpAvBlwZ9oSpH6GfuFX9JFhYXZJOo8u0GZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7047.eurprd04.prod.outlook.com (2603:10a6:20b:11b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 03:49:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 03:49:08 +0000
Date: Tue, 20 Dec 2022 11:49:27 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v25 0/5] BPF redundant scheduler, part 2
Message-ID: <20221220034927.GA10389@localhost>
References: <cover.1671107241.git.geliang.tang@suse.com>
 <a94575d7-c444-c011-e49f-e538a61a0481@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94575d7-c444-c011-e49f-e538a61a0481@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: da94731a-c0f3-447f-c982-08dae23d25b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Yvx0hahFifHTUk4bcYArp0mzjMvSmoivjyOJmFvAWJybAWK+8GeojKatgBmVGHWyhpCWw1IGzlyNU1YE1i/2iZyp0RLGHi9XhJuC9DSpNxGUReHbUA5cM+eyDU9ssE7ZxgPGTb89iZn3BbEC91Yji1BX77a43MyUWiizGDuHKWdnvbV6J7pLSqKlOpOh1XvxU94S7jLYRhJ/91Owgrr7rLkdUH39PDGO2Z+WFcDTFNwO4R6GjBDiG9eVR1cG8NuajmFX9uor669/jJNNWAIc2mvNtITeXQDplKhH0XSzviA4EExbIVPgdnY7jzYS23nQ/f8VTCzVbSkVUZFOWvMt34y/ZglptCroYcFsOjuQ6tn/QGegxcnFrayOwTROgCVzOY/hWXJx2STiS2p8lDBQ5Vcl+pP2XfvzHmfpFrDoo2KcYN+/TmFp5oVBpl3G/T+iWsIHLGmqsb5DPTkeqPJrtTsVj+ACf1y2I4g11oATYQ0MRe14jPFgVabS8BeToug7ICu7f2hQ1FkBKX5uCecgZShPHdjGpzjG66DLuCxZ4fvDcIl1HdVjEZUrLEVLOXGkyAKG3YVDLqvltGFX4u6+BBRMNB5+u72VbY7eg1sv61hkm0uiqLqJHR04orjdkcQlvkx34V+E3xNw+FVO2+w8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(44832011)(110136005)(38100700002)(478600001)(6486002)(2906002)(316002)(8936002)(5660300002)(66476007)(86362001)(66556008)(66946007)(8676002)(4326008)(83380400001)(41300700001)(33656002)(26005)(6506007)(33716001)(9686003)(186003)(6512007)(6666004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lGBO+VI1VPJdf37iWjf4Y3Bvx/z8NwJ+Q/UncKJD9VrUF4LkdoNxWiH//gTN?=
 =?us-ascii?Q?Dk6E0hA9g1CV0ZvIm7C+ory7y7R7R02iHfAT6gTpc+4nkQs/RdaVxvOB794T?=
 =?us-ascii?Q?He65j2KHplHfV9v+YYVQ7QSzV732ONAooXvi7meqE0aLy/1/x3Uk594YyJpN?=
 =?us-ascii?Q?72/5ITOjW4MNmeMS85TpBEyOVbfa10contKYl1qG4+dWh1kEDVCtvkS03JbL?=
 =?us-ascii?Q?wKwrtmlnYWa/wuVet9mTxU7ZDtLIhXvayosPB3HTeMRN4rtMpCIJyablwu0K?=
 =?us-ascii?Q?eoDhw1LSfyCgP1aJGMHdqUryEob9sIyfpy5xuFUBL8LufqFuUVVgBhWZEbO9?=
 =?us-ascii?Q?OyBVVXMlzJ/JYckkmUjINhEoJWCnDeNg6KBisu+odrvqTgedLJgdLzLqGciQ?=
 =?us-ascii?Q?IgzA5oG+WbZQ7f/lyCf6aVixeBfz8Qy+NHEJHAJAXfGgr84qC8RZpb17dkVe?=
 =?us-ascii?Q?st65dFwETOD/7A7OxOBVKCJMx7sjlqVkj6KSiaMc4fim9xSXtegOCkjaru77?=
 =?us-ascii?Q?CPU9WKhOYM0Q2YE7l+cQuEErqXPSSPDStv65A9tj3rJlGEVV6Vy0BJZlrw6U?=
 =?us-ascii?Q?2OF/L59OHFyLP1NuSc0KKZbP0IeS1xv02XD+3BR3psT9Ud4v4BrZkqQd8a5E?=
 =?us-ascii?Q?7I81gmT7oQCcKybVeTh1TkNu8X7lWlNZbIGEmcn7enshNgMR5T/yC74MscpI?=
 =?us-ascii?Q?CMjBAD7ZRBOw6wrZjex9UTdG3FFUWG0S0wVfY9Uowtq5DA+PcKCy90AGB27x?=
 =?us-ascii?Q?394zjRLBLXIjo1IHawoTgYb292VOaFAnEz/4KTVoMiZOI2sDmcbe4GlQFHmW?=
 =?us-ascii?Q?Hr4KO+ffr/Sfh6wi/X0OGGfxuqBaYk+pTsBJgrDOeqSOmk7SFMSJGY4KJo5h?=
 =?us-ascii?Q?74cKND1qNsOMIrHij14s1iMPH3EiaKGuJdDX5bxe1vkP2kHpaoumkVd1ynHy?=
 =?us-ascii?Q?bM+r4RSu+9JpWF5VuRTzcZTf53t0eTDIzPY9fio6e+H8oS3XrN4bg2dphyIj?=
 =?us-ascii?Q?DMzj6kSE9/koDjvcSdNqG1jlG7dQlNGKTaGbnigkJfeVPgzm5Gk5vzcbQ9es?=
 =?us-ascii?Q?4smNnoZsgx6a24IrHkDJMhxmbxHHv2Fyv27JSHTlyFFRlU7QCTAVZxhg8CHj?=
 =?us-ascii?Q?c98CXHl5k1Lk0PbM1t1NNkvUKq7VxNkac8P9PflcvnSkVjhUiK00eSKM1j7Y?=
 =?us-ascii?Q?uwf0inI6RSF1mHX6KQPf6oSRBksgoumUJ4K5n1Ltg+eurCizzHYjqYbkB0Fy?=
 =?us-ascii?Q?Uy+in4vAmuyZ1NmREoIZm2fc6UGK9kULDrm7yG/OUB9YnuUsEbUwfeNppklL?=
 =?us-ascii?Q?iEDxNX/Gbnk1MCG59JZ/U4eXIe15JeFwY+Lt8Z/TuEZbH4xQ1yVpzoEiaYbw?=
 =?us-ascii?Q?24pjFG5O/fPYB5V2Wh/3IwL9U2nYdvuFWj4tZQWQQQHrThz7jPPodugmJkPX?=
 =?us-ascii?Q?eqJL56Uh8N2wcXfetUIg7+Xb+baq8A20NZxR52ovLjs1PvbymYivbsXgSySY?=
 =?us-ascii?Q?R9O7hRACz6q1y0yUdQK11bS7BBmr9AMHixx8iqVdzpEAxp2IBHNaCu/We1Bk?=
 =?us-ascii?Q?XOf+WrzEhPhlXHxdCdXDe7FHyZM0IX1dZVIepu1HMkjqFWSvPmYl8/UOzerq?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da94731a-c0f3-447f-c982-08dae23d25b6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 03:49:08.1214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsG20HRB77Moe+QkGDn87WBft1qEnRI6kVV8Bqps4oJflT+Ngoqrj3/HnbbGEUxIMzZX4nA67QNUhXbXHki42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7047

Hi Mat, Matt,

On Mon, Dec 19, 2022 at 05:39:59PM -0800, Mat Martineau wrote:
> On Thu, 15 Dec 2022, Geliang Tang wrote:
> 
> > v25:
> > - update calls to mptcp_subflow_set_scheduled(subflow, false) in
> >  __mptcp_subflow_push_pending().
> > - rebased on "tag: export/20221215T054923"
> > 
> 
> Thanks for all the work on this Geliang. I think it's ok to add this to the
> export branch for further testing, and any fixes/updates can be squashed if
> needed.
> 
> I do have feedback on one line to delete in patch 2 (see that reply). Not
> sure if Matthieu needs a squash-to patch for that or can update when
> applying.

I just sent a squash-to patch to delete this line in ML.

> 
> Should this be applied after the bpf_rr patches, or earlier in the "features
> other trees" section of the export branch?

The first three patches should be inserted between the commits "mptcp: add
sched_data_set_contexts helper" and "bpf: Add bpf_mptcp_sched_ops". The
last two should be applied after the commit "selftests/bpf: Add bpf_rr
test".

> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> 
> - Mat
> 
> > Geliang Tang (5):
> >  mptcp: add scheduler wrappers
> >  mptcp: use get_send wrapper
> >  mptcp: use get_retrans wrapper

In addition, the commit logs of these two patches need to be updated
too since sock_owned_by_me() are now replaced by msk_owned_by_me().

The first one:

 Move sock_owned_by_me() check and fallback check into get_send() wrapper
 from mptcp_subflow_get_send().
->
 Move owned_by_me() and fallback checks into get_send() wrapper from
 mptcp_subflow_get_send().

The second:

 Move sock_owned_by_me() check and fallback check into get_retrans()
 wrapper from mptcp_subflow_get_retrans().
->
 Move owned_by_me() and fallback checks into get_retrans() wrapper from
 mptcp_subflow_get_retrans().

Thanks,
-Geliang

> >  selftests/bpf: Add bpf_red scheduler
> >  selftests/bpf: Add bpf_red test
> > 
> > net/mptcp/protocol.c                          | 187 +++++++++++-------
> > net/mptcp/protocol.h                          |   4 +
> > net/mptcp/sched.c                             |  69 +++++++
> > .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 ++++
> > .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 +++++
> > 5 files changed, 264 insertions(+), 75 deletions(-)
> > create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
> > 
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
