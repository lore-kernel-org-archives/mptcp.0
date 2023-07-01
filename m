Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CCBAD45
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 13:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ak2PaUeUKMUwlt+vZXyy0nxhqrOM9+oeI5mk7Rm/pX1QLxTvXrrGW1WGXO6/hVy/I0hJ0oQUnnNx6DQB8xOlSQdzp2D8vriokP5Tf0syCDrdUhGswKQpctHxHpYhjFiR791j3bRjGOrw61+wqCPxBaZYoIc0mf6UZpleg6A6ZqSOUDwnQAAjg/7QbfZrAMK99mQlnCesbZm2lbp3Y2KAv4vbwymT6GM0hYVy+YqLTEQKf7FFbuvvtc8NJ5FpGmuefyaZfsqdanLeG8SH3o1LD2MzSkZLtgf3Ax2FMjRuFCj+omYaqgK8sQR88pPhiKkEq8EB3PDCQZzewHutkmqRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VN1FakrjZhqgNLi4K0jQhxUdQMvTqRMCqdPAy65sJNI=;
 b=khN+IZ3f9UAxltEPdnkgzbHjY2/HbPlDJOeItfScNoPbGYmi3695t6Jz7X0DaCWdfxtNVDBlNPIJkFnDbLMhAcMSYgpxOPvr24N5Vc0PAJrqHHi3kHoYMtx5ZWjFq3IW3tgGnAgTAEg1u9xB4eyyOAxCUmYliJsxlxBIsrXFtCM5mUHq4BKf/LGVd4Wk5182QzQ23250CGKaUnP6EdAqnbg9LzCnHlad28lB4iYvbecN2qcBY9HCq9x6T51p5bfar537Z81QhUsbc433vEJNeK9aCM1LGtCGCT20r+O8l3fOb71KgAfLqVtRj2XjaEa2XkRNOHzfax2CsS9biIY4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN1FakrjZhqgNLi4K0jQhxUdQMvTqRMCqdPAy65sJNI=;
 b=4Tji+g9dzdyIEcptmOtTGDJ6qr26Yp04YvrocU9r9YKQ5vU+rK4YwPhQZtte0jCq+QtNe7vqxoSYtOSGLHZC9CuDUWYTaOi8OvJtv8ZoY0YeIBE8pPNLP9foSjLS/WsSbossC6FmN7G+SfRGqQWrf9qV351S9X/q9CnfrwWdmw74OEzI52XmS1JfuS/oZbvNS3Iz/oIkRqm+OI1GFaR3El0GqY+ibomKfVrLUI881Z9st0H+yIfG7N40gYdfDzk93gXWRRhQjsy6TkGBF7xgGz4M3LNIXU6WGtf31w57uSb2yMKJ9KaFJuv/XWb79X3lDFVnuWAeJEt6tY1tHjQMwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7008.eurprd04.prod.outlook.com (2603:10a6:803:13b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sat, 1 Jul
 2023 13:08:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 13:08:00 +0000
Date: Sat, 1 Jul 2023 21:08:08 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/4] bpf: Add bpf_mptcpify helper
Message-ID: <20230701130808.GA22404@bogon>
References: <cover.1688004307.git.geliang.tang@suse.com>
 <53359d2572fdd676206c35d29e823e9dffd5e9f6.1688004307.git.geliang.tang@suse.com>
 <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72dce095-9e4e-b9e2-0ce8-dfcfe58f7ed2@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9e7ee8-a97f-436a-1be4-08db7a343221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5LUy9gOjmPGWVIAxWbwsHtxIfJbxVGXCkLCHG3UKkNM0DubQFztbXboBpxcpOXdn5FdMQ6B+qhUaHlxxIrM1+HOsuJPG8rWgPc2X8/ZSXaM+uhV+qf6Zze+3K02Rq3sFZLxn7xLXDSKsTnOryl2GvIVkRswOtmKJ+PtahQISdeDtxGIP98Ra61f8XAd+SFE/QeDDZ+bhQktSEA9zRFYUXajTukxESWjIWA57sseyodMkuqrTZPkf8ITYs53uanylTvHsD15VT8vZmYDWiiGoqCwgHrjhbGtqJuhoOTSWYUXWQdBAg+Wk6Yzp4vot/M2hlUnTnnR2I49Jdjp6y2nX81xkP9oYqgNNEuevtl5p2PrtSfK6cUGXeQKlYeK+jKwktVgqC06k263+ECzmy8IZWs097eINJOYMTH+q5x55fU6gRgzxsjrPsqGKIYyl5c9ghe4uLmUW7mSGD5pZNPjnkMf9drOHlNEq1TEJ715G1A82mlFKw+iuk4A+Sraaydhkr+39X3hglgpHmvnRrCCfNo8OFqK3H7ExZtTjaG0xksSNlK++yF9EJtBT3S0FQqsY6GIFmUroIC0SuzC6Pv0X1cMss5ulVvKblrJ7riX6g/8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(346002)(376002)(39850400004)(366004)(451199021)(186003)(2906002)(66476007)(5660300002)(33716001)(26005)(15974865002)(33656002)(316002)(6916009)(86362001)(6486002)(478600001)(8676002)(4326008)(1076003)(9686003)(38100700002)(66946007)(44832011)(66556008)(41300700001)(83380400001)(8936002)(6512007)(6506007)(53546011)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gTjc1XPDBsBQm1XO4b1AoNpJKlVGca8ENgSIN2hLfdlPlNUCW8i5nirX//6F?=
 =?us-ascii?Q?YNsfPfwS/1fBC/Zia/nqOUARNsqRToCD0mOVspAo0d+WAblqI36vfir1OM9A?=
 =?us-ascii?Q?qIMI1Eei9WYbxsark70jmHUPfNU4TIgORdE2lvCT4aX3VgMsxRMkQccyoPLp?=
 =?us-ascii?Q?e4pL+x0MuLqACqjgLipx1EsYOmQEN9pVBoB2cYyOvpYc9LHH7/nqU46gc6nY?=
 =?us-ascii?Q?rG/Dqh2Ri+c38kTyAASHdlVcBY1wNG3f54sNP6Gq4XlP5cJTdlSGZcgbWtZ8?=
 =?us-ascii?Q?yQtmpOuR/I9XxzSxIdZHGwc7cu1iXD+layq2D9HK80vzeLPeUTZA+acZ40ES?=
 =?us-ascii?Q?HPZX8fryNiiH20okBJYQ3PNutN4cdX/Qu2joMYsQFb/Yw2XwAmSHJvro5JQz?=
 =?us-ascii?Q?+pk+ED13ihtjzicMJRoB4MmRKSHr2tup/s6YLyBGch3ua9rl20fhYWfP+Afa?=
 =?us-ascii?Q?cB3AuoknOY+VCmMFRPWz/K2hPyMAguxDXji7xrHsXzxfgXuE3icE/5KLCoqv?=
 =?us-ascii?Q?gWtA1ns6mOiteE8kewFpnsRTt4s2MIMuupuGVNosz5q+NS7P+7nh+tSOKc4V?=
 =?us-ascii?Q?rPjbBilj1bTv+6YXSyulnkAiQuo7T2fZUKlqGT0FMBXeWgvebgHYYG1PvNDz?=
 =?us-ascii?Q?u95KTkECjR/fAGmLGHnJ/ypXZ26ECt7J0SLYZ8qg22aq7fdCzn1ErG3zoZG8?=
 =?us-ascii?Q?phYObo5o5ax3DGg94hy/l7Z2mZqGhK9rYzUjzq5pDmonhZM+gygdC2YKJPzO?=
 =?us-ascii?Q?niusLOcxF6H2POw2/46Kl9JxCzXK1IF1JafzxzOm8oqgVRRqI+pectJ/WgSb?=
 =?us-ascii?Q?HBzXVzPNeBVgaAzx8GJQu3/j3cdib3gABqtlGRvb6JO4wmtfrg0caUKCPIBV?=
 =?us-ascii?Q?pnulRUfCclHB+GztFoapUkQvroUg+fcHyvP4VOrn53/eKtsu3nbKJNx3tsWs?=
 =?us-ascii?Q?R9xLHOu7T32y7rzA6BP5XRMDjUD+POh0DDjETtxF7fWv+53vDtm/pIPACGR4?=
 =?us-ascii?Q?pZYpYnhfUJe1r/Dt6wop0Caixjc7pg+OT+xQHyWLwBnW7Y+68bT2dCMo69Si?=
 =?us-ascii?Q?2qFRWyGmUGQEFqyqmASw72DUtSs+fZyiaaNauin9pmTn1hBjg418GMhUjX9/?=
 =?us-ascii?Q?HBqJFPgFxX+AdIYZkO2uYioTbkJ7tCzo4b+Wa7583tzSJyYX9iqxvpqdvqGG?=
 =?us-ascii?Q?EsIHzayGaSXo4bmHlYqX3FLqM2k01Zu7PvLfZzXko36zsWyAukikUYdzrywu?=
 =?us-ascii?Q?LkjSvPskt8K0FDtbTAmxIJAL7MGZQnlG1cQwyGiCazkNMMYYDGyPfO++8SEQ?=
 =?us-ascii?Q?SzvcThiSwRkP/oY5Ep1zsIbXPmrDVPB3pMoG+I4NV748mkEv35RfAKN8GKZP?=
 =?us-ascii?Q?x0P1g2Iu3AQ295WyAUGdL5y2tQXrIbzaffg2AxRRcGOijOd9MZ591XEAwXov?=
 =?us-ascii?Q?L7rZQpGGvP7C0qZYv+ITnhTaS+u8J0Ffr/b83xJBImJl+Ie/bg88oRm1kb1i?=
 =?us-ascii?Q?C3pbF99fqxVfDJtiaebcrTHIoV46DEg98C6fSwHJv96jcgm8+K/KMOVFC/o1?=
 =?us-ascii?Q?EEgWT4geQEqMEmYwcWMIHRXrHgTNC4fbBT26gW2t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9e7ee8-a97f-436a-1be4-08db7a343221
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 13:08:00.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPFaib41sk6lzbyCg3gj8cIh9l9KBSc6SY28Co9GM/xylUOQax42JU1AZw3D3W9oVPrg/FlanKP4urFi9IRnMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7008

On Thu, Jun 29, 2023 at 07:43:50PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/06/2023 04:12, Geliang Tang wrote:
> > This patch implements a new struct bpf_func_proto bpf_mptcpify_proto. And
> > define a new helper bpf_mptcpify() to mptcpify a TCP socket dynamically as
> > an MPTCP one.
> 
> Nice feature, thank you for working on that!
> 
> Is it linked to what Nicolas Rybowski looked at a few years ago? I think
> he put info in a Github ticket. Was there not an issue with this
> technique? Did you see it and fix it?

Yes, this series addresses issue #79 "allow 'force to MPTCP' mode: BPF".
Nicolas looked at it before. I assigned it to myself a few days ago.

> 
> I didn't look at the patchset in detail but I have one question, please
> see below:
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 968139f4a1ac..e439f8b5f203 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -11587,6 +11587,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
> >  	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
> >  };
> >  
> > +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> > +{
> > +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> > +		sk->sk_protocol = IPPROTO_MPTCP;
> > +		return (unsigned long)sk;
> > +	}
> 
> How do we ensure such modifications are done at the right moment? I
> mean: we can only change the protocol ID in very few places, before even
> creating the socket (__sock_create()?). If we change it after, we will
> break stuff: tcp ops, security labels, etc.

This will be hooked in BPF_CGROUP_RUN_PROG_INET_SOCK() in inet_create().
See v2, a better version.

> 
> I thought it was not possible to hook at the right place when Nicolas
> looked at that and/or ensure the restriction was done but I might be
> mistaken and the situation has probably changed.

The selftest works, proving its ability to convert TCP to MPTCP.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
