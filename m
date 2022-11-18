Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D5D51B
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 22:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0kcd/SFQm1jn//l4MAz877nNFQ2sS7LrAArWHvFXa1WQlTMYbtTt9F3l6kRJufoAMYqXx9U93fUIECEdYNf8UVOD5xQUElsupckoJJ6ty+Kji+Y0iVI0JyBRcgqDOy77X8eQccqFzzAJU+gsiJl5IfmqcgDoPsrZi37EsgA7UWVah8fJN5Q6P46tlWM5grZ4rxa3/lsyw7V8YU+gZxCIVMcOFHwrBp2Hx2c7IHzpYzut8tPPbn2QFBZdell1PVQqsic8jpxl+8Ho4hyO2bBmlXVIC1oJknA1DiaQN+9oupq40M3d1tydD3YbUbiVZi29Ob0jegKVE6yHlDa8lPBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg1g4jlCt+Zm81KPy6l0bfyQpPtuF5JAGpZ+A4XRi6U=;
 b=G4KNJLOu8i4HU9aSy2C1MyIbBRTnLOLNffAP353/D18dDcJ69bq1fRUk05tbQGXRi9mkPrmICUtr47Py1K722nAFVYhRz3Xf1WTWBM1FU3KqcBHAob6u5fc3G03amz6bP6RM7O8/pQ0KgEcfbUlvjNGSYvSU/AlR04QBfMocj0+mhvJ1GsZaT5Xrv6asyw+6weM6kw6hg6r+3lvTlIJPq7zg6D6q+NbJhhOiaJH6ibmdDGJZi6tCIAgFVDUwywj24s92jK0o3WMmsSqT2BTAZnyNxcJednx39oayvOb8wUkmqrPeBYRHX1NmAFfZdQxZSCZve9WqrxyN1cLCpUx2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg1g4jlCt+Zm81KPy6l0bfyQpPtuF5JAGpZ+A4XRi6U=;
 b=Jxdz7YPWhGLOfYMHs+MfgKAZh3DHmUIcvguv9bmXREKg/Xvb+bt+dA50IaweQzRGVumCEIRPzpgAzIxqV0cVYtHZ1IaYp2zEfsoW2oiz0/GnFYtMtvoMW/O+4uIPLkWKyIbnSSjp6Ic83+uBjR8jyASWELbNrPPl0BDh/EVP24QNT8hONvyjOOviKma8x49yNJrljQNFtQ+538rxL+6V60chp4YqWhtc+k8hEDMfTPNOmMUfXC2VrvDhZT+5MAqh0kfoD0wU0tVHHMiUEOblN/uFbOr3lj7ykYWLQ/1ZNCiwC+OdIiMKdiZreyDr00VsVjiCXRoCMfSkKQjL+S/CBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 18 Nov
 2022 22:14:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 22:14:47 +0000
Date: Sat, 19 Nov 2022 06:15:10 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v19 3/9] mptcp: add sched_data_set_contexts
 helper
Message-ID: <20221118221510.GA3222@localhost>
References: <cover.1668151131.git.geliang.tang@suse.com>
 <5ad9715e09a2acc245c7a504b086d6ff33b40a7e.1668151131.git.geliang.tang@suse.com>
 <cb2a531a-02bf-9c80-5385-e02d9e61c368@tessares.net>
 <1d505549-92ba-6b80-0a10-95d26d18fcb4@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d505549-92ba-6b80-0a10-95d26d18fcb4@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0130.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a49f8a-78e3-4d35-06fc-08dac9b24d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	spDuUGCeW9JDa4sRd4U+5FyDXcmvEb5G0ZVOAtQ+JxmeHUiAXrPVxikUEIP35JYD22gMkLyIfsWx8Acr/U5ZFoV3APNdFTAMNCVINUIkuWvTuprug/ghGm0rk/mjm7qztr60GjxD8hx8gSo1q4gKJ3D3pa+m6a0D1jYewKng/di7x1KqfkGKultLGVTD1nI1/v868wWshtDOmhD8ndQfgABlfBqYahcyskqfFwh71eRJKKplaA6/APP03i6vyRyKf2/GIAjxSdEToLt3TU7OXg+NLCly9BZz9EbLAc86KSmWT+BZNqQFZtwXmuyKQAXmGoLG7bx0ICiyttfKhcFg1l42ZhwEOaKIfG9W918tbhn2RWvJMIgnOgKjkWh16jOQEgCR9gQ12qXhDuUMPR03n0f2U+Uo4tlk43lVtyOBS5BCKLjMAzP7FvaZgB2HRC4cEeKAmL56eHCyYuCEOkNdhMueI2tOSr6ltxj3YhLeBIdS5mUweZnV67shzWitBar5aUBGD8iyfG9M8MSj7DfbaC697N62aiZ4EyzhkuuCoyLr6zyAVCtO3TutmcvzHaPTynLBljQEYHmY8J3YvXkNdmuaXAqSRgW7brxPppnGykpfG+VF8J/5f9Y3oppZnSJq/FU0OOXQaAnysMVmwiid/w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(5660300002)(44832011)(2906002)(41300700001)(8676002)(66476007)(4326008)(66556008)(316002)(110136005)(6486002)(66946007)(53546011)(6666004)(33716001)(9686003)(186003)(83380400001)(86362001)(6512007)(26005)(478600001)(1076003)(6506007)(38100700002)(8936002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/suVWQq6s6iebmVaAXXnUif92snGXRKrOrbQeyGjzDkjiDexMFoClXHKg191?=
 =?us-ascii?Q?bUoq00TQIPBIzjZCdeFX5zcvb4ayqMAC7ybS4tDhI67623smQqxtLz/6hNS/?=
 =?us-ascii?Q?jWWe301JkytIBW7iNJ8Gt4socxCckP2D6yFsLOpJqcUEPJDaGAigxm2vmqET?=
 =?us-ascii?Q?/p/It9grpw+YL5UufbtQCHCXw1bWz/tYAN1LeHPI8X1/zWSYLabwzp6ZHsbI?=
 =?us-ascii?Q?JTQS1hMs7jifvmNARZZPXMUmVUd8erMiAS58znPiFFi32a7fAeH5yQnNwSs9?=
 =?us-ascii?Q?S0/eF6pqQFUc67+GodleXN/Om1SRvZBhaXD1ITHC1e5L7VTHAaub++xvfHv+?=
 =?us-ascii?Q?VD22nMdp3TZTzAm9GaBjsIMzqRlBkLRaYmboqJoZWo4HttdUttFTBotXqbwL?=
 =?us-ascii?Q?KRLF1dKihY09relLXhGssZVudBrx5Vgm6srbY40jnIs11k/o04/N24VRlGYv?=
 =?us-ascii?Q?GY5YWHSIQxObitEcWGhahDCeH7Xxi0sh3FkSHeiqM8lHLbVORWB09u3yVscZ?=
 =?us-ascii?Q?GQ2aAhg1E+W/tvHzA+Pgi3caNzuucf0gcrAFIe80Ggn6vVbAJA+HkIwIblvN?=
 =?us-ascii?Q?QnbpMj4whu8lxjOmf5vQ39OtD+QLdFTR9cYt7LDQLMKVec/2lCWhHeIjR6GA?=
 =?us-ascii?Q?d6ejFEbyvXuNJKy/yJjijCz9lPAluopxRbdU6F4qWFL2c8n813oLZ3sdY0uc?=
 =?us-ascii?Q?5WD7KSyNm20KqDuS4cFpgX7Wz1cI0QZ5TJuuEEU0RX9cBEWIeJmsYv8A7bYz?=
 =?us-ascii?Q?0idWRVkvhnLl4lPV7mrquYPbjjiO+xwsYmORQVhZeIXMZAEfDT6xtP1+2eUX?=
 =?us-ascii?Q?JFT/mCxJAQ0eWAZodlgWWlBmTQZ0SWhg/kT4yldGILw65PFH1Mth6hV9PMSP?=
 =?us-ascii?Q?+XSLc3wgdGabAd1XZ448YSfbRnotMfYFOw5pRRFQqQ/8aSOI4t/mb23FizKG?=
 =?us-ascii?Q?XT5e04vYZCPhpQXZwyER7QnjjDKgu8cinf5KeGHij72lp4+dySIOll7KpaWF?=
 =?us-ascii?Q?Q4phMhDWwGLg/MSbOBzu5bFevxDPHbqGL6mEFHe3CgQ9VyuP9BLXp3DiC2BV?=
 =?us-ascii?Q?zip/t5rEv2/uJzXJu6o+yMzNtD5X8dMLfZa+9KUJ4DQdocxLHc7cOSynUGN+?=
 =?us-ascii?Q?+ZdL0lwk5gZP3MMIMsngGNi7jzoEDMQ6mHS529xl40TGtOxIoQ3LMlBMiwdy?=
 =?us-ascii?Q?1SgIxzylkQlEVuuYdT91OtTr3taLVZHJfGppOG8SRPSDjugL7x/Nw37/X6W8?=
 =?us-ascii?Q?JGm/fh25UVlUwGYAbJAdELGdMIToJnACyKsmp96zgBQ1ilSvc6wr/84koG33?=
 =?us-ascii?Q?TWDtAbwzd0S+HTeuqGdg20nwt+hgpCaes7cB/VDRlY3S0E0RjZiR3fVSGUWc?=
 =?us-ascii?Q?diNiMtsYMVCW0V56J+QvEufSuRsXGcg6ohA1NxCBh2xWwq4ERzckBjd4TkGC?=
 =?us-ascii?Q?i0lFg93KUKrBrvswhEK1h00rt7ExJufZP1QgHK6c3OhZZx0DhC+Ls49pmdfE?=
 =?us-ascii?Q?RXkHRnRdfKPInP0CMB/bJhY7o1h0aF2WZdj4TNghRSEb0dTTMCN7cPR78arb?=
 =?us-ascii?Q?gfsylnBoXQr08xRKzsFMRXs+l3apqg5c+dl+Vk5aKhLJRQTyCkClyyDeF/Hq?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a49f8a-78e3-4d35-06fc-08dac9b24d9f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 22:14:47.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VGS5swETHQvLrkSBUMU38G+tFjjWqWSOFlu16gCPcO+kWQIR94nv6F+M+MBzd6sitfd5EyGbUZtjjdnt/PsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625

On Fri, Nov 18, 2022 at 10:26:01AM -0800, Mat Martineau wrote:
> On Fri, 18 Nov 2022, Matthieu Baerts wrote:
> 
> > Hi Geliang, Mat,
> > 
> > On 11/11/2022 08:47, Geliang Tang wrote:
> > > Add a new helper mptcp_sched_data_set_contexts() to set the subflow
> > > pointers array in struct mptcp_sched_data. It will be invoked by the
> > > BPF schedulers to export the subflow pointers to the BPF contexts.
> > 
> > I have an issue with the CI and this commit: it adds a new helper which
> > is not used before before "selftests/bpf: Add mptcp sched structs" commit.
> > 
> > We then have this warning when compiling with W=1:
> > 
> >  $ make W=1 net/mptcp/sched.o
> >  net/mptcp/sched.c:97:6: warning: symbol
> > 'mptcp_sched_data_set_contexts' was not declared. Should it be static?
> > 
> > I'm not sure what to do:
> > - modify the script to parse error and ignore it (I would prefer to
> > avoid case per case)
> > - move the commit after "selftests/bpf: Add mptcp sched structs" and
> > directly use it (extern + kfunc)
> > - squash it elsewhere?
> > - add a patch like that:
> > 
> > ------------------- 8< -------------------
> > diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> > index 0d7c73e9562e..e9b1ff932a3b 100644
> > --- a/net/mptcp/sched.c
> > +++ b/net/mptcp/sched.c
> > @@ -94,6 +94,8 @@ void mptcp_subflow_set_scheduled(struct
> > mptcp_subflow_context *subflow,
> >        WRITE_ONCE(subflow->scheduled, scheduled);
> > }
> > 
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wmissing-prototypes"
> > void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
> >                                   struct mptcp_sched_data *data)
> > {
> > @@ -112,3 +114,4 @@ void mptcp_sched_data_set_contexts(const struct
> > mptcp_sock *msk,
> >        for (; i < MPTCP_SUBFLOWS_MAX; i++)
> >                data->contexts[i] = NULL;
> > }
> > +#pragma GCC diagnostic pop
> > ------------------- 8< -------------------
> 
> One more option:
> 
> Add a declaration in net/mptcp/protocol.h
> 
> 
> > 
> > But well... :-)
> > 
> > I suggest to apply this patch for the moment to avoid errors with all
> > new patches and check later which solution to use.
> 
> This is fine with me, if you'd rather wait for a squash-to patch.

Hi Mat, Matt,

I just sent a squash-to patch to fix this.

Thanks,
-Geliang


> 
> --
> Mat Martineau
> Intel
