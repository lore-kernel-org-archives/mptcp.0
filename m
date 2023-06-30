Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EF51FB8
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 08:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXxttrcvctkk8ifi2+2e5PumGCUa4AUaTmV1fU7zi1JmQ32vUELfW9JAjJuqUZyJq5yOGg1QUb/FS9n+plPq7BoMnaYIvfWYVmt8rE+Hdz/FVNn8Vo32y+fDUxeNdSwgfj5w40ftzTWPFkLaIOnghssBmUN8W19oJtjQ1zXsYGHOKQHNqAOvSRiVu21M3LHI3/rMmjk/uwlY5pqHonQKD5HcIDxGSzhl2cSi3AVYQUjExzhGRJrr21D+SOaHZKvlyGTMCynmltan31WA9lAYdK5xD0DgokDoEuUWc8oMDCG/oWSGI6ZT2QP+33/CJK/LJFFaWBo2ggvtWMgXLYEkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoQdcCy8kjAz0fRLGKf8xuX5zmkHQmm5ubDxaBt/vNs=;
 b=LZo8pKq6ApOGAB69vxUA88uew72U/NdShHbZJ7CB1vL6GaUNXgEnPkd36qta7spM1vnmOoJqUCfEiSeCehglragGoeMXs329RPAXmSGTTUExF7s/Ccny4IwPQJnW/9J0Q+DrxUSLw4F8hX8vVKYRe+bNTDSMxgxo6BSZJg9Atx4zcNWhC8bM6gYDU6TYzWC9djEWMGh7pF8D+/ovK5Cd+WmA+nSOlRz26TDUWoYMcnA5ClZlPRhZyazhexCXOrJ8dMLMi12FAjp3qWBzUgTkIGm0egc+6jrz8dvXTa5BBt8R2I+KcQnQ5i35sF4TlwA/Orc2hJ90eUTOvfr71a6UWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoQdcCy8kjAz0fRLGKf8xuX5zmkHQmm5ubDxaBt/vNs=;
 b=5ZjXR3YmCVeZzQsZ0qVcmXhvBJWLlUTEpuXaLYyxWUGAQp2//7Mg8mJ6jFDCbRCDgZ5Hcr/hMSoO9TiNrCzbguSjUqFuYKzmCIvg9aenuAg07PAkTAFuYfyCFE0Abc1Y3GqJL8rgI4DlukrEh6QLRkY6l7+aGnTGvpPdcRZsyhcxhElZX9wTDgqO/hnRTlJyTkk/8yV2LvIbClNJ4kFnmHO+aFk/zYIAd6oWXd1L5NHGiMXhK+njdhcqLAbf6l4zofxbuBzOfe06gdjo9z4h1qZy5pSZA3jvkR6xiEW/0QYIRB36NK+ZlWxR8lolTVMyScpkahkHTTB1eOAbOW+7xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8979.eurprd04.prod.outlook.com (2603:10a6:20b:42e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 08:59:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 08:59:23 +0000
Date: Fri, 30 Jun 2023 16:59:28 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/4] selftests: mptcp: set all env vars as
 local ones
Message-ID: <20230630085928.GA12853@bogon>
References: <cover.1688092826.git.geliang.tang@suse.com>
 <0c0c8ee5bd9c49c17565d018e4bd6985901ac7d8.1688092826.git.geliang.tang@suse.com>
 <ee5e8149-7c4f-31e5-d5cd-d17e30f8ba43@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee5e8149-7c4f-31e5-d5cd-d17e30f8ba43@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0168.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e6a5bd-f23f-4040-33ff-08db79484bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wp7zEWMANKcljg+kXT2gnjKVyUhhTXt+ufbdJSZ8BQjI7mloFYFJSgiPKiVxwLwOch2IYL+gpwf8+yXI2bcemqaBHX5q9Oo5rhIoEaoBKC5dl3jXZo8Xu769YSFp9nDDHJ4/2i+Tj6RVzxGsHaiPwgS9uPMGKBaJQohIGwHVkoPYeRCyVBN25WFGoMCs0UIiNDmstko21L0E64Sx6d56w1pcWSJsnvgvKImuKLEf0eSS88ax4vHKwqR//vIHstXJUD/t8Pc1KiDvgtmF429SvHvZ/EAKhc9GGzcYQj2ANV10Dqs9aC22cpszS19HKGYx+KlEsv3X/eu7VpCBCQxrB1jcgaaRN9Ri35Ip5HTuz6wEilysZcC52CPeoU3zMioZ+qv6XvREOvZ2jYklZYvwFGc7asyN4HpTEHbn7mIYDy6cUWxs+lX6IKrKMO4ywm0A9Ypgik7uh3HuGYoxgXowFgHvnvfkfKSJo58DSdj4g5/mupUowRKJP6qruAuDL/hq6k7lJq0KU3bBCff2oXCoR1wP4GlTXKdJPg1y4ChNgS5JFjtj/f4ZGAVf+RGXIBD5DDr7nZrFXhn3LSVM0JIqv8tHR1kWARC1+xXiHq8GQrUfc7jIHDZqZoePKEpu9tMr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199021)(33656002)(5660300002)(44832011)(33716001)(41300700001)(6916009)(8676002)(8936002)(66476007)(66556008)(316002)(86362001)(4326008)(66946007)(38100700002)(15974865002)(1076003)(6506007)(53546011)(9686003)(26005)(6512007)(2906002)(186003)(6486002)(478600001)(83380400001)(21314003)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?neo0eQ7B1E6R2WQTkSZfqsK9nbswq2+FPFqZLW8Fb284QX/BVq7e0I3QIc/8?=
 =?us-ascii?Q?/sZnrmjdyxvEkDsWA1yxbcHEBUBHwJI7nf8CEiZ4jT5ULDMR7lJujZNYyp09?=
 =?us-ascii?Q?dJdVHEHQ3RVqOBwER7Xw4f0tgezLnVpJa3/KTLtkLfwqWtuINETr/ZgzyVNd?=
 =?us-ascii?Q?liRX4bfudZZ2Q2ojvf32z8UogivP5OJg7Gx/7sUiA5GUesPMX+ghLRUxMHS8?=
 =?us-ascii?Q?O3lXetFu44pmTRdeyEJkSQwXn8kJOlsyFrmUY2AG9dRIebAIGfg/2RTpdhxy?=
 =?us-ascii?Q?oFkMCRDoQtSLomZjE/LyNwk0yUWSwcj2aUeLvgYmdGqH0V1AWrhzc7LKZLaA?=
 =?us-ascii?Q?o87twfXv1jtyUAVyk+mDohd68vRH8W44HsYdFTbb8ixJDmpPxtNbKBlzolwf?=
 =?us-ascii?Q?5oDU+0isBz0W5yAq/CHNzw3Dmgsuj5X508WRv4YgP3oEackrYgSzWauATlw+?=
 =?us-ascii?Q?E7wqXpfn6ebagLq/8bVJoR8vJu84rCEkiuIW1GSuc6f6k2Hia5M8U8Cz3cYN?=
 =?us-ascii?Q?K+VPku33/3N1BDvYVXZZba50+1udiRsIiE3v4Q91a8UwzZC8pZg1wSp6SgpA?=
 =?us-ascii?Q?meAHFRazWpX5U+VkzjA7NuNyZEelevLD2bLbJrnIBwL078Zr2/bbklmqu8ub?=
 =?us-ascii?Q?9GfMGhUzOPsMLXM6AcMWAC0+EMMEDPc1mEhjakc7bgPxkXG/sN5CjLNE/rFS?=
 =?us-ascii?Q?WA/9fMcLvhOHN2JnqFh1N64cYjp+afQcIVSDO6KC4Y85aMP3XXgguczxTe3+?=
 =?us-ascii?Q?sIPQ8j2KlByV45RKFcBNaRlUGp0uZWHZRUvl0NE3IFsRlSwINs7/lPzhKFiy?=
 =?us-ascii?Q?buGNQRZRxFerwKXrby0hWlWICE47qXHF+Q2mnKKE8WK6jT9l5RT87OJLondw?=
 =?us-ascii?Q?ZlGwvivrw2t5U5e2WkI0Ni2tgWeOag/Cmrq6PAUS/zIVBJUDhgHvHJtPWSUE?=
 =?us-ascii?Q?qkjGUDnJumALDt9ksNjUnMtJt+JWhciiCTP/qDNdyzd125DhyU6Z71jDYkRA?=
 =?us-ascii?Q?+Hk2fUOg8PpX0e+JGccKSSGdZcimQg/ESPLfxovJ7jui5gagDMpWT620rRun?=
 =?us-ascii?Q?7206dBgzeiqhSqJeZX9JwqT6yMi84rwf2Fxu/lm6zGlaHxutGbqq94BVC4WW?=
 =?us-ascii?Q?wAgYTjVLg2XPoBuYR6iNBp9pv5hHS35Yc78YgJR+QRF+VmiaQ4zHsj5Ashdi?=
 =?us-ascii?Q?MYiWiqKORNtCsfZZQs3SXlFArKWWAH9/IdtucnkaGkx2t0upx6T7wYE0dx8W?=
 =?us-ascii?Q?xir41E78a6p7Yd5W/ZKueQiJb4XHz6vxoM8dwBbQcv9MbrUsWbtjwG4ncIMt?=
 =?us-ascii?Q?3yzQ63A+APgJleuelpeToaupfNadHOUdenFudNCXchiQ4q75fgBeBFQFCv4Z?=
 =?us-ascii?Q?BJVcd/p8WRlTg2SdI98VCwr/A3oyuaciRPblHpJxHxYvwlVFTn2LEtXkZr/o?=
 =?us-ascii?Q?vjKzk6JQi5fmzphlk0DssPfLg4K5cJ1Oe51nV6CHrvywmbSoJToS2j3csGy2?=
 =?us-ascii?Q?YiiQ9dKSZlJFPKV+sGAcC6zwqIoacdV+LI2gtRzQU6jFMWSpYGr5Nq7MvmiA?=
 =?us-ascii?Q?sau6vKHy/l0Szm1r3JT/YSQduX4MjsSzob3DMobo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e6a5bd-f23f-4040-33ff-08db79484bf8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 08:59:22.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODpPSc5Y3tLMhb2e1yVcWiE+pHgXHJNmoy1ZCou+wmkpJr9skaJRHpgtdTee7ie35uV4QywgJ8IzwGQAA89TdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8979

On Fri, Jun 30, 2023 at 10:42:47AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/06/2023 04:42, Geliang Tang wrote:
> > It would be better to move the declaration of all the env variables to
> > do_transfer(), run_tests(), or pm_nl_set_endpoint() as local variables,
> > instead of exporting them globally at the beginning of the file.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index e6c9d5451c5b..ad0717cb0d7e 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -49,11 +49,11 @@ TEST_COUNT=0
> >  TEST_NAME=""
> >  nr_blank=40
> >  
> > -export FAILING_LINKS=""
> > -export test_linkfail=0
> > -export addr_nr_ns1=0
> > -export addr_nr_ns2=0
> > -export sflags=""
> > +FAILING_LINKS=""
> > +test_linkfail=0
> > +addr_nr_ns1=0
> > +addr_nr_ns2=0
> > +sflags=""
> 
> Ah yes, you still need to make sure they are not already set before
> using them later and that's why you set their default value here, right?
> 
> But then, I see you are setting the default values twice: here and in
> the different functions where you declared the local variables. To avoid
> that, I would suggest to either:
> 
> - "unset" the variables here and keep the default values below
> - declare the default value only here at the top of the file and in the
> different functions, only do:
> 
>    local XXX=${XXX}
> 
> I *think* it might be clearer to do the unset (+ a comment) and keep the
> rest as it is:
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index b89077510080..9fc5a78c6063 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -49,14 +49,15 @@ TEST_COUNT=0
> >  TEST_NAME=""
> >  nr_blank=40
> >  
> > -FAILING_LINKS=""
> > -test_linkfail=0
> > -addr_nr_ns1=0
> > -addr_nr_ns2=0
> > -sflags=""
> > -fastclose=""
> > -fullmesh=""
> > -speed="fast"
> > +# These var are used only in some tests, make sure they are not already set
> > +unset FAILING_LINKS
> > +unset test_linkfail
> > +unset addr_nr_ns1
> > +unset addr_nr_ns2
> > +unset sflags
> > +unset fastclose
> > +unset fullmesh
> > +unset speed
> >  
> >  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
> >  #                                (ip6 && (ip6[74] & 0xf0) == 0x30)'"
> 
> WDYT?
> 
> I can do the modifications when applying the patches if it is easier.

Sure, I agree. Please modify it for me, thanks very much.

-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
