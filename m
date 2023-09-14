Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56247241E4
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 12:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QBjE5rX4ClFCg7MCvUMLzGW0Fcuv/WvDWdezkKYTU2MKNlzANVMTZXU9C3QaifqtWgBmmsjYi5+P+/HJCj47mMotvx0ozlCJgxyhutPQRi7tJKA6gPZLghrRxrsYn5VnafgzaQQL+2yvLMItpkwuM89TIYM4qj7HRcVR5QGuyGJkqh3LQrgXJ5TzjSMii+jXsKMhxrRnhywjiWN0e0L7nq4SYmT3Urn4gAkesayGEkswAo71aY98Jk6wc9uEi3URKVTPFo90R9n4ExriGH42CWOfgwOmIL/Wmk+95KPlIf0IXj7Oxh65/tffUnVP+92zxcv6M4SHhrBOkY05QrU5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5q2KBvcqTkxr/y/K0MyxxeiglolIn6yf3dagJWgkfw=;
 b=SJ+dOyL0n7Gz8Vwn3eyAbLxgXX0u4E98fqTlfWejtRjA8vItWqXDRiifqQo6wNBwiAk5lPtZrVVsgVoc8EiC7ZLhmEJ4VGBz/elUwDVK3B1IlnND/Axj4GWVGa+fKD9QVtoDKPMEZnryPSdypQVt20l2sCP6tc/dpavh6aCxUIaL940Uf8WD4BBVfe9OUd2ImIJJV6ixR/PgIMOmAyECYEQY6t7BqUkddCIbkgGxGX9mht0aQVf96onKBqaC+o7o8qgxJQHztIF0M1SpgcGuFenQr1QtQyDW1tuICjnOWvo9n8K/qO+Citwbmi5HqX04kgVEPX4okTeHw7PefhNwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5q2KBvcqTkxr/y/K0MyxxeiglolIn6yf3dagJWgkfw=;
 b=WWVuX7wlNRjJ0X2iGMU+G7tEAFJHRF5jd2dgaHs1ULSKbx1mejoj2ApU5ZVLmPX57d1L3TQ5EEmxBCtjca6/0sCE3lX0gnzpl+xYv5Y0xvNmLGNC0jYAHoKJ0j37I/vdco2diYf6zRgMMjmgIP8od/WMlxBOL9vMrU61WKuCwZEi151Mi9Mu7yJpshVMzk8cXtexPwABxfrjC78vzXrPtpIB35I6IAKsTkr3WADvdQHPtGIYNkQkdCVST5TeLbRPCj6JSDeuUSy5QtAJjIkRpgw1EEkG/BB/F434p1SEF+v+31AtTcIs5JtH4+i8iUqzzTkh4rMK6P3Ea1siY1LM9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9453.eurprd04.prod.outlook.com (2603:10a6:20b:4da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 12:42:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 12:42:17 +0000
Date: Thu, 14 Sep 2023 20:43:01 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 1/8] mptcp: add NO_INITIAL_SUBFLOW flag
Message-ID: <20230914124301.GA3508@bogon>
References: <cover.1694685050.git.geliang.tang@suse.com>
 <a98118c4c5347fcc1c53909c6677d84485cb0651.1694685050.git.geliang.tang@suse.com>
 <93643f82-21ff-4a54-9c1b-3d5be689793c@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93643f82-21ff-4a54-9c1b-3d5be689793c@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbb3500-0c80-4ad3-84ed-08dbb5200714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RUf1T2EtuUeBi+xWKxt0JvKHiWKNcf8fWIcQJgVTMbhtKFbSvl1OqZ5foIWYPMCpmqQwO0UUitCmMvdhLu0jILoYJ1PyO06/vHt25cqxnvFGRVVC5v/pIc8S8cnZ+0v/gQ38HzuxxvPLauFrfsE+m07vECkygn8t78HQ6IUH0xQuhFmNTag3yvpPSadxvkf2Q55Nd8Y3dfuaweA+9b2adrIze1Z4cPG6TJtekFfatIVZ1ivchCCAGUAul9Iz08uawKLOR2QfgQ0KBIOGNu00EsnnOfVPC77wwn3CYXGQ0lEGMBaopjN/6vi7cxhADaisBEYZFTcEt6eFg0Dkl4iinhsw5EIzYfKFy8bI0z4hXSPWeIhvilaVSTHvUS0suSuIb7uc99kRSz1drtaN7zq69LY90QTtjz6YBViKvA1qEwN2oJjKMxPXynm02UA4/y11/eWHt7USRZ+4KFzGOlpPiJ7Hb6cgdZozf5eq53PitzPGyyDgI4PbtiUwqFrmDacTLK8NW8T4dNk52ToB1N7L0vIszNuRS1Rnt8BowS4tOKme6nT5gSR2Sv6Rc1rzEA/GhaU3aM7rd098bBjv6iTj8dQ0yA2FxBFmCrw1z2lgxi/to5jsqJpAy5+6il09jCO2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(41300700001)(6916009)(4326008)(316002)(86362001)(66556008)(66476007)(15974865002)(33716001)(83380400001)(5660300002)(38100700002)(66946007)(8936002)(8676002)(2906002)(478600001)(44832011)(1076003)(26005)(53546011)(6486002)(9686003)(6512007)(33656002)(6666004)(6506007)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u5aOjOqj65EB+bZA1h+aa7V5TsvSjKa4t6eQSrnYZlyd1ZzJJgnZntCgAMxd?=
 =?us-ascii?Q?cwQcXt1QYrO50SMWTPdJ+B/0rves1gj/joOgSA9pIodEuYMtvdWM+cVsuYce?=
 =?us-ascii?Q?cb9Dj/ZoYFwkKCdsUZcpdQH3aemsny9VzRss/9HPz8YlnfIBzCR9FepZGG9F?=
 =?us-ascii?Q?qgAKYM5ESrjSc6yjoBCDsD09AhPK5CUsnBMLmU9T9o+J5m/n6XwRkVFGh/13?=
 =?us-ascii?Q?Zx2uD/kcUw3mO1rFdVu/XHnMnB6gAcg6BYD2pmKLbABffsp3ZPBfcY7kRaNn?=
 =?us-ascii?Q?qo1IoFQWuRLh5BhFfG8AvJwydeixOX5ai0Mu2tjQBR2DhhP0d4B8bfqv+amr?=
 =?us-ascii?Q?e/rimI7wqG5xAQ8K4dwj15iD7ooulyN7+Wt06P/sZc3hHDV/D2N76dYo5qJR?=
 =?us-ascii?Q?xU9V3b2PfM514ypXwbsb5iFunSD3D08jUZK0pndYjB3ja+DZZKERnQz0EgGP?=
 =?us-ascii?Q?Bd6jRCIpM6/lFq2puBzaPKgP61fetyoi8XCuf7IArlnW4kncG6RUFpksY/Bc?=
 =?us-ascii?Q?+xCJfU5BYjmdOxwD6ntuYb+mvhuIQ7gy37rSJ15D4iSgczGNdRYfLC8vBX6j?=
 =?us-ascii?Q?gAmYhNUBkI1QACXrjZeDpFJ/5F1KS9io1DKqDPgk0YU6PA265fdDD7qhwVke?=
 =?us-ascii?Q?2aHE19zuKziNiAG2KcriITq15qGGEpf3MMHgr3vQ8rrqNSyzmvrKZd0RyxyZ?=
 =?us-ascii?Q?LTDvVx3XX9Kvx9eLiOF8ZHJrpmzygSN4/YHFmV/CGvpyNoAz0nI3F6v49epi?=
 =?us-ascii?Q?0lDNTzSKv9M6xTvktTtewyJaj9622S/s+mUBO22RY+tAvOJ1MPIlD82u5RLt?=
 =?us-ascii?Q?TIDi20aR1wfKmGvJE7qqipwimSKLHRdZAazoBZk224AQy+pYBRqM0VIJQWyF?=
 =?us-ascii?Q?SkPM3W21WBqwykRPjL73413u/ZEiWuOD4Y7gGdscVWCIs8S6YGA46r2shLzW?=
 =?us-ascii?Q?kke6j0b0y/nOA6wQqKEZg9iBiJLmcWvBJMlXtUiIvHVMHRZOMBDI4F0jjUsl?=
 =?us-ascii?Q?WOLqxfq9spMRpjhfZrsn0LAJDMIV3jsBMaNUgwr4+3nS4KkBLibRa+TpyygX?=
 =?us-ascii?Q?XqW4ViAMNq+73UM9teRcaaVG8+xiYeZF1UyzosQBMl3T2H7cEf5cm1wJZSed?=
 =?us-ascii?Q?Z3UZnti5/dxdflJ0sjXJR2qLngMwhdw9KqypPd+X8ge2Ve9Dre9GRISvWWAx?=
 =?us-ascii?Q?/3wfyRXMyqAcoYWrgahSTHawfRL0jNKCPQT0dDW0JwPJofDrqqaRnvDzycfG?=
 =?us-ascii?Q?w9cg8j0wgXkvWKnJY6a8ChRVQ9WGDAXCXXRyZp9JvHmcpp31NNhHZLDRIws7?=
 =?us-ascii?Q?/DhMq/73PfIofS5QZc/8GE5AI+kNHLiBDf3ZHo+6nQIBSuWIb9JP+1lcvPR1?=
 =?us-ascii?Q?HYOBqBLVyVM9CLPWKEWLhlNdQiRCkLdaA8bAmZ/Q4vDkXTTsYkyNH3DWmlzB?=
 =?us-ascii?Q?8x93fAu4We4hTeUqup0+8r4VY/heZVVGkwgxefz2sPRgpwRyfDgvRg2s9yDS?=
 =?us-ascii?Q?viRO5J5LU01Aq7briCfZSRfAN4abA9ndJM1FIxpFZQoffLLWR/nIuxd5hJn3?=
 =?us-ascii?Q?z+S+Cg6c3cAR2QaGePytEvVCG5SRz48Drg5JjGo8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbb3500-0c80-4ad3-84ed-08dbb5200714
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 12:42:17.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vjpYJLDscbxZHIhSwQA4gqfEwvyW4QaE/KVvRqdFgAOWZISLV37eNkQk6f/0FuUBiQJ+n+Mx9csoaYMa8DZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9453

Hi Matt,

On Thu, Sep 14, 2023 at 12:19:01PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 14/09/2023 12:03, Geliang Tang wrote:
> > If the initial subflow has been removed, we cannot know without checking
> > other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
> > getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
> > of course) and then check mptcp_subflow_data->num_subflows to get the
> > total amount of subflows.
> > 
> > This patch adds a new flag NO_INITIAL_SUBFLOW in mptcpi_flags to know if
> > the initial subflow has been removed. With this bit, we can then compute
> > the total amount of subflows from mptcp_info by doing something like:
> > 
> >   if (mptcpi_flags & MPTCP_INFO_FLAG_HAS_INITIAL_SUBFLOW)
> > 	  mptcpi_subflows += 1;
> 
> Thank you for looking at that!
> 
> (...)
> 
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index 8260202c0066..aebf692543a5 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -919,6 +919,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
> >  		flags |= MPTCP_INFO_FLAG_FALLBACK;
> >  	if (READ_ONCE(msk->can_ack))
> >  		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
> > +	if (__mptcp_check_no_initial_subflow(msk))
> > +		flags |= MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW;
> 
> I had a very brief look but can we not just check if msk->first == NULL
> instead?

msk->first is not NULL in this case.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, it goes to:

        if (!dispose_it) {
                /* The MPTCP code never wait on the subflow sockets, TCP-level
                 * disconnect should never fail
                 */
                WARN_ON_ONCE(tcp_disconnect(ssk, 0));
                mptcp_subflow_ctx_reset(subflow);
                release_sock(ssk);

                goto out;
        }

... ...

        if (ssk == msk->first)
                WRITE_ONCE(msk->first, NULL);

out:
        if (need_push)
                __mptcp_push_pending(sk, 0);

"WRITE_ONCE(msk->first, NULL)" is skipped in this case.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
