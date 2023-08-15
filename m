Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA9101F2
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 10:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPveg744dIADWu+1dy2UsFy90QOTVtWiGSmkIa2mK4pNMQBN0+V4ApzuvQnCTqBERDCCnfCc/MK/6QlW52ZKZ5eFPy36RzZKMk6DPhnQyy1SNZwsUV+3qMmaFzWDp2H9JtfHT8ol2COW8Nt6B7FoE7fmtYockCpuyktoXMqPIE9oFk6cFpQh2gKogEoo9/9D08twcQP5zLLDy07yh1RkHveKbSKfLPygXogPqvAMlEce+/Xj8bSp9SEs3QK33M6eraBOUm8njcO1WGM7bawcGVfdg/CgHUEQFQoHmnzbQzZgJLZI3jFOvUpfTaRXtURXHPRGCmPViMGYGQXkfRDRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4OBGE9hyMh11A3FnbTCGbczY2wulc4Np6WXyVk5Jrk=;
 b=KlxK7lnA9/AfGe6GnfNCF7kZ8X0adoTCUWON4Rayqt5NZyTuXmAEect28Rv7H4vuUTkT6laBewToPSaPjf/R8p3ULzDerPaXnMKhdgZ9pnV+u4/GpDhezkJrdrAEQR9m8cFasQVYpJwvkh9Ohyf5YDhFdl5hTUyu2O7OQfKRIzuUFwQ+psWBQv4jolo9HiUOLerqrESV8nMlpFKyWPRXzDNjRWGgI4OQ9XFwfHTPJcoZitpicicgMz6vjlII7Kad6f86qG2pDQxSJC2M2KRhVaaxAOsRENKc4bSt84w/LfK6p4iDOQDaEMN2pIZe/3SdA0S98KgBwBJCPQNsRguZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4OBGE9hyMh11A3FnbTCGbczY2wulc4Np6WXyVk5Jrk=;
 b=wK1/mMggptPJ72KMR+C+omminFVISyaTIBzi6vsZxiOhrZK17Vdd6VNEo/T5yyZ7sMJsI2I/PLtrN7pbd9qzvCKjrFRY2UFnayMCcu+rpU4TmpvWddaOCXHtoSTlS7eB9c10DzyDuZ7zyNySDsMD/VOAjhfuA/uWu4XF8GJbDQJoC7s5NjzATdS6FcjbWDkt+Zf/JpISKWC5WtWIEXzaWwd0yXrCAudSNZLYFcPC07JKEx1841DmLBhy8nP7fEesk/6i7dZFKfQu4t9xqAw6uqZXsTrQ16bGlgzuVzwfCrlKyDvqu1hDwt/AZbCTFBUdPkIY0Xs6bSc92rQ4yBl/cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 10:18:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 10:18:27 +0000
Date: Tue, 15 Aug 2023 18:18:49 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: Scheduler refactor commits: code questions
Message-ID: <20230815101849.GB24858@bogon>
References: <973390df-fe63-229e-9987-392d57074728@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <973390df-fe63-229e-9987-392d57074728@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 5925c1a9-aa9a-4b0e-2a71-08db9d78f75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	taqhiOsY9U9EJmGb04QM42SsPdouyvVAbcalcGmFvSLdiLUg2SwrfEQ9F4p56w3WzlQIr7IjMOLYFUO0Grd3Il6V4gJ7zMiX236antSoJw5YVC21ftsvIgoJsPqnoQIjQBlF5SciVV5rSuiK9Vh1o5VOtqJ1C2xK4/sW9mhkfHqUGCa5kih+lEZA1pjRVAr9HpC/p7k6ykteIY5iuqa1Yy+yhZlpBgV5iJQOYWB5WZOkPUdvl8GUrmeWWprtEQrECnxdfInDWqm+gW9Dp0LkAARQRCjycUkTnPWMGSvqO14L+Oo+XnwpsfDgWIoVr1Jk5ch1ruT7vIg3RYVpqHxOLfjn1JEbsygF30d6fmmSNr77wvz5YZEbXf7VpmvgPZu5+zrfPv5eKKi3J+oFMaFWhX0EX0fZeVh4Q3Fxp9sj3jyVBZAYABXbcvsJkHGwEYGgql3xG56CxZ6CJX/ZpYd6OKgF3Sc7+H9liv9mGFgVH3bvuCrG3GxVWGgGEWXtjOjYHDheG2VGwdqF0XPv48AUYfEQwPjIRwpaNo+6lZ0o6Gai8PucYoRz1QsQ6zIRSQkOa1knjQuyTkve/TSII5Kh05Oq1Ys0Pkr1lsqGAY/bmiI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(33656002)(33716001)(86362001)(41300700001)(9686003)(478600001)(66946007)(66556008)(6512007)(316002)(66476007)(6916009)(8676002)(8936002)(5660300002)(4326008)(44832011)(26005)(6486002)(6506007)(6666004)(2906002)(38100700002)(1076003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17Nn3Q/9ZbNpKf3XNAhBCvyOLLI7xVNiJggabt3qKCRQgJcpZE5uN2RE9yYh?=
 =?us-ascii?Q?H4V62kLxEupS5IeI7IxV7VY5md2RlYScYeJSak9v8GfzLn/nI0xg+NKPFUEt?=
 =?us-ascii?Q?iAb2RnZF1JacOazTtN2OmkbZ1UzYPIiYuXQYY7xtucxdSk0xKKjKV6NBUJDF?=
 =?us-ascii?Q?tOkm+qqxg3Jdcm/D1mrxXH2n//VeV7Gjtw+1n1ZawUSK9m8WC/sqOhutVaY3?=
 =?us-ascii?Q?mGRZfg86nWejHw9RVbzf5tRlFEzM/8qdOKohaEBvOVLcSsI3cU+P7lQ0gaz2?=
 =?us-ascii?Q?D7A8pdPVjg1pwDumtT6GDmXyuLx1wvTFNQBWJqFwZ5KF4+MqkAKRdT9AfDMF?=
 =?us-ascii?Q?t8anrnzceyxGwb8a0W8APQluThoAi3HtU2ieieeXrToYS2FfcxitYOnY3OW7?=
 =?us-ascii?Q?mH+MISlgGq0vIV+LoywSDum3pq51k0WeLwzkAkl7GA2x83ySpItGlcpIYsiy?=
 =?us-ascii?Q?HdsdaE5HHyAaPCtNvlSZSBZ/4sYUW0HbDbFOwJwxEm8R1vgjDCxRv9EhMnvM?=
 =?us-ascii?Q?6OB69i87tkfT01fAe8mOLne7m8J7VuG/7nxyPsWjHbQnx674lLObBz7nc5Rn?=
 =?us-ascii?Q?qYJSiWz29tVNfPxZFGfC/6mZ4ClE3HeZD6iEc69ozgk0TsZ+SgQF/ypA854A?=
 =?us-ascii?Q?ERtw9fsWiqndj1PVMJualTHbN9V4ZwydRxtXO3/x4Dg58EEyY+gWxzX8djEM?=
 =?us-ascii?Q?TW0LEkGzaVLRHRBAL9g/rXE+d1SlHOZddqQ4uR8xy5/qxmloqYNrQahOdjg1?=
 =?us-ascii?Q?iQ2/0qSr+pnvtG9S1BA7cdJ77pjVvG1ZZA6OaIbQpBoZDcKp3zxvmmViGLTU?=
 =?us-ascii?Q?1h2kw+BbalUR7wCm2Zlgt+V7A//WqbOX0nj2/AfS7+Oyh3qiH8vBP9AkMADl?=
 =?us-ascii?Q?MeRE/AU0shpBOcojkRPHp1I+4oFgtYo17fjKoPHgleAm9ZxFC1BFcmHK5Uyn?=
 =?us-ascii?Q?MPz2QDd8IEbrjyHDqSIByCOTFP63VEOvo3O2p77qaEB778htAD4qfzPRGl90?=
 =?us-ascii?Q?V4NsQNpirfGRUOJScRN1aypHvwDFBKPHDaTImFWNipKXpeZi5TQbCH+ff/QC?=
 =?us-ascii?Q?1ETSO3sSeiyM3aZdVje7XGwuBiwdCiElsd6hnHwqDeBw7vhg/5zJQIRkokTg?=
 =?us-ascii?Q?3K24pzM84QA1pbGSCq+CRLIRLmrfmzj9JvEP/BYAUyGby+M+dK6+IDHDPHje?=
 =?us-ascii?Q?M2YL28sLLDcNikR8RZCViOewwa3gTJEfyrr3WHSgfyf+kWLobTIbsoBPRHAF?=
 =?us-ascii?Q?LEdiKqLqRQcmiqgsGa6iFWUVSUSozYSUvrHrnWVVWbuVwg8PYMCIeaIwXq+b?=
 =?us-ascii?Q?b9Y8wt1RAojFEextp3pq2/qACN4oGI7wuZzl/q+vfD/lmgAbOHFMWkXMeZFb?=
 =?us-ascii?Q?GsFhxPMmIrs+DY8pnyT9ohU63NSdnM5EpUYcIbYMUIttwNEJyX+B1e5NTbVA?=
 =?us-ascii?Q?o0vnbK+fCT4E/t0oIsmO6QJmjmhm8FY1reaJCTWgDA1UeptQvFnxJ3LEGwQn?=
 =?us-ascii?Q?/tssvBKLk0MrmAD6YTDNxxjgpqle4tArvIqvGiPaCRtKn21JBr0OszcZW+6n?=
 =?us-ascii?Q?9iK8nb/oMjzXNi88kT2/edDfKf6SGfkohokrsaVv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5925c1a9-aa9a-4b0e-2a71-08db9d78f75e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:18:27.7188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DfyTC+6TWggizOl8DN8XpvsCII9qYhyi7HcTr0cD46A5HYTpus5eLeRjSGVsfz9shPzRdW0rxHuXGCYSgilog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

On Mon, Aug 14, 2023 at 06:02:45PM -0700, Mat Martineau wrote:
> 
> Hi Geliang -
> 
> I was looking at the scheduler refactor commits for upstreaming to netdev:
> 
> b3eda17b9f4e mptcp: refactor push_pending logic
> 8a826e0f4298 mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> 2f1da15cd21e mptcp: add struct mptcp_sched_ops
> ff4770e3fee6 mptcp: add a new sysctl scheduler
> 71187ddaa425 mptcp: add sched in mptcp_sock
> 78c8f8a71068 mptcp: add scheduled in mptcp_subflow_context
> 077f054fad53 mptcp: add scheduler wrappers
> ac4613e3e9db mptcp: use get_send wrapper
> 4c58a0581cff mptcp: use get_retrans wrapper
> 5570526ef063 mptcp: register default scheduler
> 
> 
> and I have a couple of questions before sending these patches.
> 
> 
> 1. Do you remember why "mptcp: add struct mptcp_sched_ops" has two function
> pointers (data_init and get_subflow)? They take the same parameters, and are

We initially used the only get_subflow interface, but later added the
data_init one, resulting in two pointers because they were not added at
the same time.

> always called together. What do you think about eliminating the data_init
> pointer and combining all of the data_init() and get_subflow()
> implementations for all the schedulers? It gets rid of an indirect function
> call for the default scheduler, and eliminates the overhead of a BPF call
> for BPF schedulers.

We can drop data_init pointer, I fully agree with it.

> 
> 
> 2. After "mptcp: register default scheduler", the faster direct call code
> paths ("if (!msk->sched) ...") in mptcp_sched_get_send() and
> mptcp_sched_get_retrans() are no longer used for the default scheduler. If
> that condition also checked for the default scheduler, it could directly
> call mptcp_sched_default_get_subflow() to make a direct function call and
> eliminate some duplicate code:
> 
> 	data.reinject = false;
> 	if (msk->sched == mptcp_sched_default || !msk->sched)
> 		return mptcp_sched_default_get_subflow(msk, &data);
> 	else
> 		return msk->sched->get_subflow(msk, &data);

I sent some squash-to patches to ML to fix all these issues this morning.

Thanks,
-Geliang

> 
> 
> Thanks,
> 
> Mat
