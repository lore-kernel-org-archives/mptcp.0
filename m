Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9E43FFA
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 07:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd/ktmbEnljIHva0w3W0Kn9PpWDvK2Q6+/0HTmVtNw8gYkTjWed3Nr72pETeTUt33uHueeYLFcOMU53aYrdX/UEEIXRbepkAksWyDZ7lJWQvVi5GYMX1w4QT+ZVcAjVEY4Ng2uwjZWIimbSsGlvwqJvnDjAm6qaW0qXrvAnFBu30LR+VT8Kg/nbYimSATEYG6HpAbIU4MA6b2oXoz631Bzg6PlGsorxJkkIHjHoaUGWkFJLWo1mipj/Tgir0Zs6S9Pk9OmnKU4oovDs7RCX/g++AJpZsAD3xXABS4yGn0iUrkvVffNuBjsv8ONMoGnpgkIxjjWnKLEUOOFTDmD8DEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbxgBQM5RVhgLIDwjok/fCOeqdr6tSWc9AnaWYF8MAo=;
 b=NddHDmBSGwpH7iv3kydH4Nfy4++YziddVXOfcpPrNWAMPZQxFYIRYN+hV8UB8907H77HaHKGvo+x5pVDdibFBSDxJAJqCijiaovnzK8gfD0dZijYfRXZvk1zbwQiJGWFsYJdg0M52F+T1T6V9eSYv5Mcouz1vOQ2U0Jg7lR++QPNE07aRmknClmYDYxcqwOiW2ixCggoW7L/fd/ndEUN6gWg+dONVfwxaiAPBZjKbZsB4yPXhYcdwO/Z72WwV8DuNzRQlNaf8Ea9i+WvEofgdJMIID/+SBgYZacoceuEw3uju82erI1JG0idJ+/8iB6n4ADKGkQj0rF0mZQuJRm92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbxgBQM5RVhgLIDwjok/fCOeqdr6tSWc9AnaWYF8MAo=;
 b=RWCgVOguXbHwF3FL9hjJNZBHWRVuoleyupsMGAP9wW9zfsmPMS8F1tWuzSXw+p98IQy1umjGzp4CzCct/WjvrbQf+2mQXHt4jne5ZXxhF6CS58PNKmTE2KhWEgoGAA+i1mmS0HxH0qi2gYJCsFee2DmaObbeNf3br43kwmBKSpYLKgv33w7kIZQh2ITb4wDOIIoG6W/dtaxfx9Fl69f16k3Bnn8aNdDFmvQLX+lLM+Gw7jfQGzGyUfes99hmDOKVGBvgK2UtmJDfn2OWZdkJtlrZrJyYDNyuv3o0C8VWk6CECtiMAYfOOl5ZsHpTSzXrySag6aN+OICw1StvxipGfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8703.eurprd04.prod.outlook.com (2603:10a6:102:21e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 07:38:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 07:38:49 +0000
Date: Wed, 14 Jun 2023 15:38:36 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 16/19] selftests/bpf: Add bpf_burst test
Message-ID: <20230614073836.GA9545@bogon>
References: <cover.1686127032.git.geliang.tang@suse.com>
 <2dfff62f24fc147fd736d452b72977c90406dca9.1686127032.git.geliang.tang@suse.com>
 <f18a8bad95754fae7a9c0cae48583279c62b78b3.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18a8bad95754fae7a9c0cae48583279c62b78b3.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8116e3-4632-48a3-b3fe-08db6caa6484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/G6kl8TPZ8MJMrUA8esQ+UPsbpYeaW3EyCRZME3WuiQTAruI0IlTBOtlpVV7HxNCSlBCFuwTEPw9z8eD7KU1+/rXRM7bcP5dtgNn89gx5wdJp+1jA450Dn3f2/Wdpc8KLg5OiSDzVns/CqhRLhMRHcOeZ9CZJbeodFdfkaLE1numPDguEFEqOgGTLHC3NCFjQT58QhF5JvJA8q4b+Q7NkEObqAsTHfIMgV/o26CZa4LG7lCuP3y+irBA1K3QX/T0kcPvsECH4dMegqwDf5iZyDI/NiakslpP/CwV+OSHucv36TIoNNC2AbBayuat0PTkE3k6Ina3iddPOKWvKMtwisC2dmbDH37+MFqrn2J1egqe8/WhEh5GaelMqcFKWwtGWuFqYJjmPz75dECeOcSZbh/pQTv6DsgiPVu9R26OXiLEOJKeY7tVSIhPrObi+pxCQ+IQVjYlSFUh9LfGjj40psvesBJBMZUGZOB0qbh+Akn9WSWQ3lHLKusPfznjrf/HVPenzFBtzw7jau9zPFAD1dRjbJk5ekzra1WTpGYhk2zLs1gCumM0IXWSpymcf9Q2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(6916009)(66946007)(4326008)(66556008)(186003)(478600001)(2906002)(66476007)(33716001)(8676002)(6666004)(316002)(41300700001)(86362001)(6486002)(6506007)(33656002)(1076003)(8936002)(44832011)(9686003)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pKVFU+o6KzJ894bkDuvkHZI5wxZB6ADaPL/P1MB10Nyiy3vmT0532sEpH911?=
 =?us-ascii?Q?3w7ZXOj6s1xKctAOyKv3OjZIn/npa40BnGq8UYjNf3k3qKEEUgfxIlivq50a?=
 =?us-ascii?Q?zk/HWPY6u6/yWM2XptKpcK1mAVzR30BWQV2GeMUMLMvYmZs4XywGcuRJMIjM?=
 =?us-ascii?Q?OyClLUnffaM6HYBh/oMjjMbtqXN5Cn1YymuzbbN2xVDAmU9IAwqayYP2Rgl0?=
 =?us-ascii?Q?WxhpBsxsU4Y6soga5OLWzxNCX62ya1lzBULB0+wAfiCMtTb521uG9Gsh+xZ/?=
 =?us-ascii?Q?U71XB7b+EkMuw7IYf2xJR4S1lzUM6VeMgYxiLAam7/OuULeFsljVQg+Ed1Em?=
 =?us-ascii?Q?SF3T+kQK+8FU6vqWD7kZ67XLnsaN6vMiXX+IjGQMdrEAwApmcZwHiLppQe0r?=
 =?us-ascii?Q?6Got654kTcW4eFLM2HpLvsF5HjROM3R3SCp8hXLc4BmOOvePef7TVXuglItt?=
 =?us-ascii?Q?+tJKWo1M1Vx+XP1WZ1WwwaFrGLTK28OKZvC9BXlMn1w+Bb0cTYSFyLwBv+MM?=
 =?us-ascii?Q?mATy5ehgtQwLAG6PcE2YtCtgALNno3GX79/qFUw+kEamugvhQltULbpmIA2O?=
 =?us-ascii?Q?ASb7Z+RZfrZKlM0wSlVvh3GqfjeMNH7kGkyD/aGRswuHtU7vlGpl03MEYCXs?=
 =?us-ascii?Q?4ESJ1iaBOPmB9N9rJbCeb8E1qqIztiHMre7/AbeLe7gM7RhRDivCtCwcgp5Q?=
 =?us-ascii?Q?gdCi/+FjWleJRLdPn3+nHbidzes/SnoWQDTvSqvMf9FT7qtoNW51ieGGEYtu?=
 =?us-ascii?Q?0+Jhfr/IOHTgcGbxjTUKZFQm7MP4ZcEa+Y7y+S6Jp60aOicOE/4SCQcqA2/a?=
 =?us-ascii?Q?DEnUNWL+QQ4MT9Z+NiHXri8c1N2hrpZjiEEs1NDdUceLhYMoajEap8qZQN8o?=
 =?us-ascii?Q?z/Guzbvh5K2er+ZyrTUTpjgDOLU019Bfpc4LUkm54lx5uqPvJ8+G72jbDPw1?=
 =?us-ascii?Q?xd7u9Xurc76sfzYZHZmUxx5s0FKKysMwKTds/LI9kx9ilzWHhlNlOeBhWs1n?=
 =?us-ascii?Q?AcIKqmQgBiq4XiaH23yRpr2vxB4FA20vLYzkqyWDdzELm5YXycMN/SKmk4j+?=
 =?us-ascii?Q?pE1g0/6qmLhO1bmAkhO3Wfr9PlX2YP02YcnB3KNAlDT5ElFHeofNhur5y90E?=
 =?us-ascii?Q?h9rLxaHezi/ZNHQTX7ZOyxScwndGP/A/7gk6tEGbyna0qv1n3LosXyfrV4tP?=
 =?us-ascii?Q?o/W6+r7ehklyuJ8XO5+ayb3/9ckcyGFclYOBjAMKrCR36lqEDmlzsVCIjzEz?=
 =?us-ascii?Q?KhiIbdELfj/FYopdj/5amiyy14pDhnYNURV7y+Wtm3a033LI3jyYUCnyd1IM?=
 =?us-ascii?Q?J4k6yk4Ww16c7I9uoueE3wnlwpvnLtfVw6XFsHD9Gzyi9t8JhAW5RR1DZ6Cr?=
 =?us-ascii?Q?2vxk26ekJN6urKJeBzv3Zxy2+dhwk6CkpXKXheCiGOUkwYdeVmIS46xolLxU?=
 =?us-ascii?Q?d2UAzuZT0l9nfHduzPorFgc30LTHEL2ueLIKRZ1cDFor5bO5IJaTldc/zFCF?=
 =?us-ascii?Q?FvlwSNNsAcicZNUWkRAhgiPmSuRXQBW4C0G+tdJowgnBCyf4ZyLgya5d4hAf?=
 =?us-ascii?Q?3AQglFJ5b47wT0L3b8j1WsmQKDzmBgKBvKIrXhwY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8116e3-4632-48a3-b3fe-08db6caa6484
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:38:49.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/Vq7DOanIDy+jHC9EzJl2QD9NiIms2bcZr24agbkF9cKIRbtmeb6RR28+02G29PGJsEpKd5U3pPkUSm/0DSrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8703

Hi Paolo,

On Wed, Jun 07, 2023 at 07:08:59PM +0200, Paolo Abeni wrote:
> On Wed, 2023-06-07 at 16:38 +0800, Geliang Tang wrote:
> > This patch adds the burst BPF MPTCP scheduler test: test_burst(). Use
> > sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
> > devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
> > command to add the new endpoint ADDR_2 to PM netlink. Send data and check
> > bytes_sent of 'ss' output after it to make sure the data has been sent
> > on both net devices.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index a968641cc94a..b9f6dcf995fd 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -10,6 +10,7 @@
> >  #include "mptcp_bpf_bkup.skel.h"
> >  #include "mptcp_bpf_rr.skel.h"
> >  #include "mptcp_bpf_red.skel.h"
> > +#include "mptcp_bpf_burst.skel.h"
> >  
> >  char NS_TEST[32];
> >  
> > @@ -455,6 +456,41 @@ static void test_red(void)
> >  	mptcp_bpf_red__destroy(red_skel);
> >  }
> >  
> > +static void test_burst(void)
> > +{
> > +	struct mptcp_bpf_burst *burst_skel;
> > +	int server_fd, client_fd;
> > +	struct nstoken *nstoken;
> > +	struct bpf_link *link;
> > +
> > +	burst_skel = mptcp_bpf_burst__open_and_load();
> > +	if (!ASSERT_OK_PTR(burst_skel, "bpf_burst__open_and_load"))
> > +		return;
> > +
> > +	link = bpf_map__attach_struct_ops(burst_skel->maps.burst);
> > +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> > +		mptcp_bpf_burst__destroy(burst_skel);
> > +		return;
> > +	}
> > +
> > +	nstoken = sched_init("subflow", "bpf_burst");
> > +	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_burst"))
> > +		goto fail;
> > +	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
> > +	client_fd = connect_to_fd(server_fd, 0);
> > +
> > +	send_data(server_fd, client_fd);
> > +	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
> > +	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
> > +
> > +	close(client_fd);
> > +	close(server_fd);
> > +fail:
> > +	cleanup_netns(nstoken);
> > +	bpf_link__destroy(link);
> > +	mptcp_bpf_burst__destroy(burst_skel);
> > +}
> > +
> >  void test_mptcp(void)
> >  {
> >  	if (test__start_subtest("base"))
> > @@ -467,4 +503,6 @@ void test_mptcp(void)
> >  		test_rr();
> >  	if (test__start_subtest("red"))
> >  		test_red();
> > +	if (test__start_subtest("burst"))
> > +		test_burst();
> >  }
> 
> I would be curious to see how the ebpf scheduler compare with the
> build-in one performance wise (max tput on 2 fast links with a subflow
> on each of them). The link should be fast enough so that the tput will
> be CPU bound.

I just sent a patch in ML to add time metrics for BPF tests to compare
the performance of each schedulers, named "selftests: bpf: Add time
metrics for sched tests".

> sudo ./test_progs -t mptcp -v | grep " ms"  
default: 178 ms
bpf_first: 6 ms
bpf_bkup: 6 ms
bpf_rr: 24 ms
bpf_red: 9 ms
bpf_burst: 179 ms
bpf_stale: 8 ms

From this result, it can be seen that bpf_burst and default in-kernel
scheduler performance are basically the same.

Thanks,
-Geliang

> 
> /P
> 
