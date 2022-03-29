Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15620FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 08:18:28 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T67rdn010504;
	Tue, 29 Mar 2022 08:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=WMnJxk/s+lJFq50gj25B4JrSC6TxISP9fJ3Ep459HcI=;
 b=d7WSEN5gbq7c76WuDmYsZWsT1DXwb7W8wS9ctB4rWIHmkWpkLdUQi5Shq0/KTsAuEixi
 mvqoay6XfhTX/3sch0u0JKgBkgl0mobXbZkzUH/RinlwifP5j8/DItmeA1nQbx5SRqc9
 NKdUiXP40I8EDW7hxjRkNrIwasA7Ww4rgxNIRoeHT/bQf0VaCeaOZNT+r7kEnaj0JAQL
 nENh2qF1Nezhk2aC1yflQOsWj4mzCJRRZ8Aoj0Z2lU9Y6HZ/PTLGjkt0dVTmH8R4sr2O
 y5J3nkybnuE7gLQLD69jpEV47kBIsXyyuC/PuMiyKcgALz2HRBtK7yMEdXX4MX/FhZQ/ 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0dwa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Mar 2022 08:18:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22T8HCCt054623;
	Tue, 29 Mar 2022 08:18:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by aserp3020.oracle.com with ESMTP id 3f1tmyjnd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Mar 2022 08:18:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9TnMKhVd4e7eB6bv5HZ/ZMASv3bsCAoDnN5hj1eK/zexoKfZOWIrUCSJhzwiVMmuyFJcot+NSuQad5slT8L6/kqFJnq7YHkh3RVZSnr67tlhxg0ohOcHTaEih7EY8sUfnO8FM0JN7gcL7RI4QvpSCvLYLdonMmupVR6xBTmPJagB7Mcel8uWg+O4iennwtfqzn8NG6Fvxsi5fNoj0GcG4MwkuffYcl7AmT70r0wEjyjyqLis1DXt1gNVcgvhhu4DIAmGclIlv+Zj+hsHRMXorWYz3L8z24HqqawaAkYqhKOS7a+gd/swH0rlY8am+Vx4Avu3Fxl+y0CbXzEHDRvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMnJxk/s+lJFq50gj25B4JrSC6TxISP9fJ3Ep459HcI=;
 b=NzIh6MfD5oIwjfQRt4q7jnKK8/qOG39Z4C8SJMZH2ZE3R2kbLc2YC/X62hYwFlCZ1eY1iXqbEeNBISKrzuaOIPDFu8531sydZFml7kPmid86qbc2HbIlp6AeMKhxf+xwoydy6fWMS6LpVhS2yvxLr+Z7zx7Ftr0iQjvV5xkVxaa+UGD6D8nn4ZgeIT/rYY1qr8Otu4exsR+1C/DWVpeIF811ylQk+79T0HyUBrlgkm0b7E45mQdusYieEVgyBWuF1gJxrBe71bgwnWXkIG1JGSrKPLeI0lh1IGuJw52jxjoYs+B68qZBssO65uRA88BdyQejyYXEA5+0MZnKm68y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMnJxk/s+lJFq50gj25B4JrSC6TxISP9fJ3Ep459HcI=;
 b=pucLbV1+WRL7Cuz1be2iWpXBulRxVTPV2jFK2VtSWWLxJcQBQHfA1Grefp7t4JBWjiiBf0PDIb7SyxRfzlkLZ489yLLrPTMQLW7IlVa6dXTAfsEiW8WaLq5MRXkDCUnGykAZhl9CwF4Hjykwrzhx5uC11HCml1Of4Il16/BXGbg=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB2956.namprd10.prod.outlook.com
 (2603:10b6:5:69::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Tue, 29 Mar
 2022 08:18:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 08:18:23 +0000
Date: Tue, 29 Mar 2022 11:18:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, Florian Westphal <fw@strlen.de>,
        mptcp@lists.linux.dev
Cc: lkp@intel.com, kbuild-all@lists.01.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: listen diag dump support
Message-ID: <202203290401.iBK94uHx-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328124913.29768-4-fw@strlen.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0015.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::27)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7dcf8c3-a7a6-412b-c89f-08da115cb0f6
X-MS-TrafficTypeDiagnostic: DM6PR10MB2956:EE_
X-Microsoft-Antispam-PRVS: 
	<DM6PR10MB29568D4C72F18EB32970B6298E1E9@DM6PR10MB2956.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	s4OxY6KDCGSziD7FJlQXeoeUdl7lsGH1xWtMhVj2nNY1oEZLgj48SAyJhrvJhQLFz+EUt0ocH1i0Z+z69cVXWUZj+7sPTfK8phK059rxz7KJMQG/ePKs+TaKIvxpIAetW92GxOwggRbO2zdzRmcxJzfqNVp/JjB5A1d9DKWV2d+y2X6vNF485wHgYCVTx14Kcf1vX/B+s0/Y7FuN77MaTTJSRzfzNpz5P3Nd11ffmXPXdU032uduKPx4V/yZ5SCFglQOIQnKYWU24yXAMeeqa+UfZ/yGvNpQokLFb8a8grKyHTewcAuOTMomlXfqY7V4R84y7ENlZX/R+lIxuqXgci8vT/R5RLt+vfF+QMZR1ITj+lkD0qczNG4DZCoYTIV2cmvzh6Smp7YI5rqeznYtTllbSE9H+q0W8Ta5ExnEZFLPeuTBsSnt/WFwG5DMvT3IWLckVf64p+w9RmYBLSDw6Qhlu6tE6/LcMbMFycw47QqLxMRjjc6hStexW55/i0DViIxFSrbx2zTmkiew77XvcabAoqgBkdprfL6NmYHmIzdwx4rdkvJ4nn/8jjHjK+e1cIiVh5Hyb7ARjkKB8zLOMhrqi94Zc1GjDQVWFJIs7/yneCf6ImnvyepgO+yAPW1GZfD/8RLSULOdI00KilO0urbUUGFFss9mypVZszs4aig1GepFefxm37FFefWDLK9X3n56FOJHXkd1XycO5YzXQ03qfgK6nsbzUnga8uDPH+1ns308brVWXDRsS3OUy5jr4Yotw7lMEGyh6p6ad+AZNLEfJjR/4Vv+DiRlliXPWHQ2vYywdSlJUzMD2xO9bDqUoqhsB4JEJs7F+4Hw6t7p1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(966005)(6666004)(6486002)(2906002)(8676002)(4326008)(66476007)(36756003)(6512007)(38100700002)(9686003)(38350700002)(26005)(186003)(86362001)(508600001)(316002)(44832011)(5660300002)(83380400001)(8936002)(6506007)(52116002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CkAtEhomA7sIoiisDqh1b1Pa58QXUumuKDE7gcfVsvh2ctlIH8/gKhB5P3nS?=
 =?us-ascii?Q?Zt3k5ZQvgPX2NmRLJY1D/jH3YYWoioci21YRsaNnhCFbZyCxngqgpeRbOP2e?=
 =?us-ascii?Q?HpRf4sqTrAmg8QJAdhlugj2jX9oHnMZ3yP1G1toIcPmaIWHCjnTooPaVAcnF?=
 =?us-ascii?Q?Sle7596UB9r4bDXcCynyWK9djuIFvGXWQHqEWPD6MwlfbJTUgBGUC+nSBWip?=
 =?us-ascii?Q?UoxHbLdg3n43PrSCuy6HgESJ4tBy95MjjbN53btt2+aM91tjoC8JgcokpDoh?=
 =?us-ascii?Q?NeJBHhHbY/4lMp1nhlNmgkrkYpeSjPcGITcILfdXlhlHBPyS2ps6qo4J698G?=
 =?us-ascii?Q?G3nsZxx4j1+LduOQ3BjVYK/AkfEli6yocKTAX7rY60rKcsro4Z3QevbNtIZS?=
 =?us-ascii?Q?lMBPeTLWJ7cG23n/LdoCCjJVbrNi7Q2st6+xACkGSpHKbyDZOupzLXA5MPql?=
 =?us-ascii?Q?TDPm7HT16pDIQ8inR1IB1czIII6M2vqoIZoGF+TIW5+G1SB3zF9Q23FgeMnQ?=
 =?us-ascii?Q?mVOb9yc33htCL5tgj9oA24NCro3pp/HFt3EByCpgGePKJwqrKU+RM4z9fcXW?=
 =?us-ascii?Q?Jx0kzd5tN0UyVcyNBNwSvX485EIsFbZ4PfbH+KGPPA2iL3Yc8c+bbLjYTSvA?=
 =?us-ascii?Q?g0TOHpH5NGDYEDEUO6VxiRls0J4MquDXL3y44l2sVOZ8zteMG3/Nw41DJUEa?=
 =?us-ascii?Q?gy0kl20cV0Qnskxln2M4+nt2XD2jRpuYkRvHExDcXv+kbW3DHDfITqrt77oN?=
 =?us-ascii?Q?8Zw9UTR9IxQBFnT6Z132NP6Q3VDBNilsDGgJ2bz3wxOZPKsqlVP5O2Iq41Nd?=
 =?us-ascii?Q?8svO+jn4aXhyCnuRHL3hFa4O5bfBh8WQ4kZoUKT5qtuIV8hrwuJ9eH00RhYo?=
 =?us-ascii?Q?xK633DxpQLBqipkPpKnfnmmrOBmLDodLKQ2U/fp1Drxof8z5+BLPSwI71uD9?=
 =?us-ascii?Q?Qpc4YPM09sL8e+wVUQhUXYFUcxPdGHAm/jtj/dhWE4QHGMs5N7JLn0jFXyie?=
 =?us-ascii?Q?1h9fGkVW0RATk9ru+caSNnZRzXpav9fxA5pLvo0cCDGaim53kaJZnAimndb6?=
 =?us-ascii?Q?SLuaXntcvbOPh9zjraNTyw+vzz2snOYh/ssD5BlnLdgDLRnRZm3eINHaVgM9?=
 =?us-ascii?Q?MOFO0gNfAU+i6TNF+0CsOdvT36nR3wnfsr0kg2BgiQTVvWBdQNfqUfqXoAIK?=
 =?us-ascii?Q?ObvDTnYPDOGqBgoDHcY12gAZozGadCgp29XlAJaa7VgDJLDyReQBuYtDMzbl?=
 =?us-ascii?Q?CmWrqbzbXwRNRDOZZuNlnt7vDwhOfZ1I8gGS1KOGZ/C39ubmPDL1XUuLh4QS?=
 =?us-ascii?Q?SPwgg1xUKQJtoqFgVWHmJ2hIl6YNl5Zx2crfWBsMPIABpU5Y4ZgUFNTunN+d?=
 =?us-ascii?Q?kSuuSxyYqC+t8B8Qf7xQdZn7kh+adLl9qWNnvr5mnTnp8SkLOUswl9PisevK?=
 =?us-ascii?Q?TGw27VrPlCKS1DB+3K2gUY2WguOb4qBts6kpJRKJ84BwyHMLXlmAtO0DFyEh?=
 =?us-ascii?Q?8VaFPWnVpvaX4/0KS7jtehRsW0eU/DE0Uwdf+o+ICQ1ZTEsSBpgd+mqAN1bV?=
 =?us-ascii?Q?dbiEl/AXISGBnhJPIRqDXa3iIrGhtDfKhI7TH+n9J0/hYdOvos3/D03bJl3n?=
 =?us-ascii?Q?x+Nz9euKFlAI/Bn3Igmyv2C9baQ7AtXyypmiPuAyYvqLX0y5p8RomJ/nP0dQ?=
 =?us-ascii?Q?1h+422Pk4FP0LKoCN1MC+dPgjJEIsrZwi08FBCNPL5MzBb2KtpQdQfx8iQXk?=
 =?us-ascii?Q?JwD5vshYA6A7yNijEv3bc/Dpf3owNbg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dcf8c3-a7a6-412b-c89f-08da115cb0f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 08:18:23.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvokYrRVPMpEHCMc3rU0fJW50iJ3Er9PavQh/5mLuObYldCPVIePGVAwIr00r8ztX4NsPyOAg2eOF7JsuXudYFOZnpUq3+Jn1llN1Y1cGI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2956
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290049
X-Proofpoint-ORIG-GUID: EuEBkgkncIkCbpb9O2jvmOY9g0tjVXHE
X-Proofpoint-GUID: EuEBkgkncIkCbpb9O2jvmOY9g0tjVXHE

Hi Florian,

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Westphal/mptcp-inet-diag-listen-dump-support/20220328-205028
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: i386-randconfig-m021-20220328 (https://download.01.org/0day-ci/archive/20220329/202203290401.iBK94uHx-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/mptcp/mptcp_diag.c:121 mptcp_diag_dump_listeners() error: uninitialized symbol 'bc'.
net/mptcp/mptcp_diag.c:122 mptcp_diag_dump_listeners() warn: inconsistent indenting

vim +/bc +121 net/mptcp/mptcp_diag.c

6ef1c5326220cf Florian Westphal 2022-03-28   76  static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callback *cb,
6ef1c5326220cf Florian Westphal 2022-03-28   77  				      const struct inet_diag_req_v2 *r,
6ef1c5326220cf Florian Westphal 2022-03-28   78  				      bool net_admin)
6ef1c5326220cf Florian Westphal 2022-03-28   79  {
6ef1c5326220cf Florian Westphal 2022-03-28   80  	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
6ef1c5326220cf Florian Westphal 2022-03-28   81  	struct net *net = sock_net(skb->sk);
6ef1c5326220cf Florian Westphal 2022-03-28   82  	struct nlattr *bc;
6ef1c5326220cf Florian Westphal 2022-03-28   83  	int i;
6ef1c5326220cf Florian Westphal 2022-03-28   84  
6ef1c5326220cf Florian Westphal 2022-03-28   85  	for (i = diag_ctx->l_slot; i < INET_LHTABLE_SIZE; i++) {
6ef1c5326220cf Florian Westphal 2022-03-28   86  		struct inet_listen_hashbucket *ilb;
6ef1c5326220cf Florian Westphal 2022-03-28   87  		struct hlist_nulls_node *node;
6ef1c5326220cf Florian Westphal 2022-03-28   88  		struct sock *sk;
6ef1c5326220cf Florian Westphal 2022-03-28   89  		int num = 0;
6ef1c5326220cf Florian Westphal 2022-03-28   90  
6ef1c5326220cf Florian Westphal 2022-03-28   91  		ilb = &tcp_hashinfo.listening_hash[i];
6ef1c5326220cf Florian Westphal 2022-03-28   92  
6ef1c5326220cf Florian Westphal 2022-03-28   93  		rcu_read_lock();
6ef1c5326220cf Florian Westphal 2022-03-28   94  		spin_lock(&ilb->lock);
6ef1c5326220cf Florian Westphal 2022-03-28   95  		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
6ef1c5326220cf Florian Westphal 2022-03-28   96  			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
6ef1c5326220cf Florian Westphal 2022-03-28   97  			struct inet_sock *inet = inet_sk(sk);
6ef1c5326220cf Florian Westphal 2022-03-28   98  			int ret;
6ef1c5326220cf Florian Westphal 2022-03-28   99  
6ef1c5326220cf Florian Westphal 2022-03-28  100  			if (num < diag_ctx->l_num)
6ef1c5326220cf Florian Westphal 2022-03-28  101  				goto next_listen;
6ef1c5326220cf Florian Westphal 2022-03-28  102  
6ef1c5326220cf Florian Westphal 2022-03-28  103  			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
6ef1c5326220cf Florian Westphal 2022-03-28  104  				goto next_listen;
6ef1c5326220cf Florian Westphal 2022-03-28  105  
6ef1c5326220cf Florian Westphal 2022-03-28  106  			sk = ctx->conn;
6ef1c5326220cf Florian Westphal 2022-03-28  107  			if (!sk || !net_eq(sock_net(sk), net))
6ef1c5326220cf Florian Westphal 2022-03-28  108  				goto next_listen;
6ef1c5326220cf Florian Westphal 2022-03-28  109  
6ef1c5326220cf Florian Westphal 2022-03-28  110  			if (r->sdiag_family != AF_UNSPEC &&
6ef1c5326220cf Florian Westphal 2022-03-28  111  			    sk->sk_family != r->sdiag_family)
6ef1c5326220cf Florian Westphal 2022-03-28  112  				goto next_listen;
6ef1c5326220cf Florian Westphal 2022-03-28  113  
6ef1c5326220cf Florian Westphal 2022-03-28  114  			if (r->id.idiag_sport != inet->inet_sport &&
6ef1c5326220cf Florian Westphal 2022-03-28  115  			    r->id.idiag_sport)
6ef1c5326220cf Florian Westphal 2022-03-28  116  				goto next_listen;
6ef1c5326220cf Florian Westphal 2022-03-28  117  
6ef1c5326220cf Florian Westphal 2022-03-28  118  			if (!refcount_inc_not_zero(&sk->sk_refcnt))
6ef1c5326220cf Florian Westphal 2022-03-28  119  				goto next_listen;
6ef1c5326220cf Florian Westphal 2022-03-28  120  
6ef1c5326220cf Florian Westphal 2022-03-28 @121  			ret = sk_diag_dump(sk, skb, cb, r, bc, net_admin);
6ef1c5326220cf Florian Westphal 2022-03-28 @122  					   sock_put(sk);

"bc" is never initialized and the sock_put() is indented too far.
Part of the commit is missing?

6ef1c5326220cf Florian Westphal 2022-03-28  123  			if (ret < 0) {
6ef1c5326220cf Florian Westphal 2022-03-28  124  				spin_unlock(&ilb->lock);
6ef1c5326220cf Florian Westphal 2022-03-28  125  				rcu_read_unlock();
6ef1c5326220cf Florian Westphal 2022-03-28  126  				diag_ctx->l_slot = i;
6ef1c5326220cf Florian Westphal 2022-03-28  127  				diag_ctx->l_num = num;
6ef1c5326220cf Florian Westphal 2022-03-28  128  				return;
6ef1c5326220cf Florian Westphal 2022-03-28  129  			}
6ef1c5326220cf Florian Westphal 2022-03-28  130  			diag_ctx->l_num = num + 1;
6ef1c5326220cf Florian Westphal 2022-03-28  131  			num = 0;
6ef1c5326220cf Florian Westphal 2022-03-28  132  next_listen:
6ef1c5326220cf Florian Westphal 2022-03-28  133  			++num;
6ef1c5326220cf Florian Westphal 2022-03-28  134  		}
6ef1c5326220cf Florian Westphal 2022-03-28  135  		spin_unlock(&ilb->lock);
6ef1c5326220cf Florian Westphal 2022-03-28  136  		rcu_read_unlock();
6ef1c5326220cf Florian Westphal 2022-03-28  137  
6ef1c5326220cf Florian Westphal 2022-03-28  138  		cond_resched();
6ef1c5326220cf Florian Westphal 2022-03-28  139  		diag_ctx->l_num = 0;
6ef1c5326220cf Florian Westphal 2022-03-28  140  	}
6ef1c5326220cf Florian Westphal 2022-03-28  141  
6ef1c5326220cf Florian Westphal 2022-03-28  142  	diag_ctx->l_num = 0;
6ef1c5326220cf Florian Westphal 2022-03-28  143  	diag_ctx->l_slot = i;
6ef1c5326220cf Florian Westphal 2022-03-28  144  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

