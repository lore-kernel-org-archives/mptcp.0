Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D9270
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 09:26:12 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16E8ZZF3001674;
	Wed, 14 Jul 2021 08:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=HU/o2BQK2+0Efe9M33hYUX5Tp6lXZAhM7H1ruD0Ta3I=;
 b=CDuzN46Oh4q0OHvq/rDzqvGQ0rlWkWfUO2zqMU3ORRl4kDx44QKiQnA05Cp6Rsmoqxh7
 l4ZLXqmAJ/sei9XiBOMY8PYtDE2sEDc0wUsVWv7ohRb7SQu1dLZMSRGP8YzhkXbyP1ZW
 Y0rDY2nxoY8/MRvA/yrAzQm46rHrE+5Xmmlw2a0/jd9hxBD6q/dB4rUhdGFHOjpnZ+UC
 qAQFpABWB+SQ/8yS0d45Ly9OqQUvZ12uSIKHElGBnNxc9VnBvUFki0H8IIaHlZ/JqB5t
 uPBKjZ2wrWtSgDrtthejMLvxXpZb03Y5Ky7ZRZSR2wsMccC/CybchIN32wjxS+Y13ZZn jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by mx0b-00069f02.pphosted.com with ESMTP id 39rnxdmbxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jul 2021 08:36:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16E8UxRH196023;
	Wed, 14 Jul 2021 08:36:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
	by userp3020.oracle.com with ESMTP id 39qnb2pu50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jul 2021 08:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1g0N3dmdEA8jSvkWxHqsnFtBzAaVnkXsyQcmA4ITqjqdsCQmIuGv/MxAOzGlC4vbIEIwGmyZJZBaV1nSL/TA4vRzi7pJH/0575Nzoh4HWyeskq8ErR6NW8nx7usVkF3qF5Ljm1hrEHmTSMdnTLfB7JFH+giy+TS7FHgXrnAJF5UnBNzyc4GJMdOOmce+oTM78F4VjV4WF36JD4+L+215NtjL39C0UjWyHVeFBTlRjN2l3Yn/2MwnBqqFo0IBk8oYulsJqVM5/wL30qpUJWnxZ+Ie4RwVHalGq+BNRctvDbn5H4RPYnK4rocC8tW0OydeQINZNKmaauMUVjgduLjMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU/o2BQK2+0Efe9M33hYUX5Tp6lXZAhM7H1ruD0Ta3I=;
 b=lGaHNDsnfL8KBTzVe3D7yUe0nP3M19ti1CZ1pcsR/LyBoByh1WI8EoJ+r7V4H8t+088hwa0szJ+K7KPBwxSNAXRccxwCg+l9QK0+zHKnxnAvfzYILwA6UZU1bZkddKsFy9Ykutf7cpSbAqSLF14/9UTeRGnk4UmfkuTkFbMIWjJbIRar804c4Blttayfjb+8dqo7sOY0ZYVnZ66HqEpq5uz7A7+tlgDBigCXtCUQ2nKAkwO7Nr9cN6eEges7sP4ZAO/aVKryJ1CLFo/24CY3kK5OfM21IfdvEI9kj5ohH2NtXRFjlmXoAOq2TtRYn8qus4v0mksPYqRnqM6paP0C6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU/o2BQK2+0Efe9M33hYUX5Tp6lXZAhM7H1ruD0Ta3I=;
 b=z5hVz205CyFoQXt1a8sJj++FqPHOTZISnxuYb/HN5UG9r76BNFX4W9609M5dm6jvyd/IapNipqr5IWDK2GKp+j5wTFw7w0sFb/O1ZRtCPeBZ0UT9MuANGIkL1ANw7/46CN8OeCwfzlxKqUrYVMcpX8wIxFs9thyI1JutMd1T1Y4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5412.namprd10.prod.outlook.com
 (2603:10b6:303:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 14 Jul
 2021 08:36:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:36:43 +0000
Date: Wed, 14 Jul 2021 11:36:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, Paolo Abeni <pabeni@redhat.com>,
        mptcp@lists.linux.dev
Cc: lkp@intel.com, kbuild-all@lists.01.org
Subject: Re: [PATCH v2 mptcp-next 5/8] mptcp: faster active backup recovery
Message-ID: <202107141117.6wB0621n-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f5c7f52467c1bee161388688305b8911aaa8d8a.1626210682.git.pabeni@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:36:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85a7713b-2237-428b-29b7-08d946a2822a
X-MS-TrafficTypeDiagnostic: CO6PR10MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CO6PR10MB5412604FAB2C03D5E94253FB8E139@CO6PR10MB5412.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HtlX1VPf4Fe9q4BH++wM0LmxGgxagqCvfVPVcg8wSLHAEz6HA1Jeg82T+kTBb3Z/LCDE1kRb/Vz0VITil0MOVA8PRwCHVKPGl4PuNLcZUCacvVRXAjYPA4oN/U1fdVw6d8SWlpgrMXbMoLOCRWIKEENTuLDqMs2zsb0aaR+YQWr7DEEnmqXJjR4hzOHn5MOmvDYxRfcguJWucdefsdLdDupkUSPqi1xiOBMWDVyeFiik4NNa9Nv4voOZgcVWF31Ios70GYC3Fl0o9tKcCg9Dyrqy8GoWSF1c6kDkQzvDXw+KHkWXIJ8ugCzutBvoFa/6PKQumIlL0bkwQQf7nuHPSlx+Wk5uUtgoSjlaqYF5CUFCi+LDxPaXmxIZ8tIE9GcVMcAqupF6LmPLfmAy+/iP6OzOurTxZeCONX0qxnzmxeq8zcco5j6N72Jsa0c7UJONex7AjTJsv92OIb9ofgMiqKv4JtMDvd9T/l6pT89T0bSg+y4WnEAcKmaW9rgPjgalctKG+EB/pzUBrMWzFenWqIGb+r8e//wyJbdr2S5mDBiHl0rDRDS3lLvB5H05gDoe3lJM8/enBR0SsnMMU1+bIpkOi8dFkTLVE5ia63CBvsirNHcz39v3H7E+7CbYrmRbKB7jat6CycDGsWJOHAkHm+KwtUkjzjQE8sCm1A4P/zPXt/WJOcnNjbwgBXHRfTlxiVepvmR5uL9lmTQRGrEwLWmUnWeuhB8vmhA6HTMJdzaK91JoPacucUOX2y8C8lTf6DEjixKVtpCfznsAsCaim0C/K3wTQDQuN7g+Zu8lNXpVlKHAIzmhM+4fQFA8f2jY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(136003)(396003)(346002)(38350700002)(44832011)(38100700002)(316002)(36756003)(6486002)(478600001)(5660300002)(956004)(9686003)(8676002)(966005)(4326008)(1076003)(8936002)(83380400001)(66556008)(66476007)(86362001)(52116002)(26005)(186003)(6496006)(2906002)(66946007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pW82a/3oBX9F7YQffqvvAL8+t2v3brvm/SQ0ixnnTlbLWjZi22wj1JzCwdMT?=
 =?us-ascii?Q?vY5VFURGjC4RG6JrQx7IHoSVbwZuLzjBwNvP6878IXVA6bqgrXv7f+eZ2lrD?=
 =?us-ascii?Q?83AV6G9SZZc9475oOcy+UBNO4iK/2Yu+NOU2kztFwtGM94iZVvqjLUvvOkNT?=
 =?us-ascii?Q?SiW8gi8DkG+Z8fuYWe0RU1TMWhtZySFgrshHNx7WG9mFo5fR9VP8zOhZrmOd?=
 =?us-ascii?Q?HhrxZET/8M7+Rdai9I3uLrkp6mo+DpkzJ5lrtdsUE3ED/92hI7FIG6fg/xHz?=
 =?us-ascii?Q?oTmGoBPjKf1zTfTdmoqJ8MBG+otYd9yf8+TtsjfxdBIQvbhhxEz7Auf5wPcO?=
 =?us-ascii?Q?rSja2f2rSIuVdVQfzvONqwoHIQDbMStkR61KPGflaXcmwvyc+eVAcgxWaDiX?=
 =?us-ascii?Q?nFa1nec8//56BOyiIchgAsIxPPve3NA/Z8qthw7A37tKpgH9mC5d2hhSpkQw?=
 =?us-ascii?Q?ytCcAYPTrqunZ5OP6MDbX06yDYUDifsIIK08hHsH4eHMYrIY1rrpWiuwrdKQ?=
 =?us-ascii?Q?10g+URkZtEokq7emHXtFsOOTROmWez+Eq3j+V93qXONweNZ5lviU7fRJq/EK?=
 =?us-ascii?Q?w2o0JMKSNdbHmJBepMNvpf5xV1xLY7NcoZSf3lHj72cv0LfhzcGf0rqTAfcJ?=
 =?us-ascii?Q?XJSYJ8LjvWcpkvFvRlQ75OX+i5R1tlBtdRO4NxxiN3CGmHd/68dKQdn2JHU9?=
 =?us-ascii?Q?1SuZd7LkEkecXuhcdKRV4q+/l/hUrOosDOptHfFckq8e4hbWJNqJWg38P2lF?=
 =?us-ascii?Q?qlplhV42jWNEIAr/H4Baff9GC+LEGeQ2XonjAWoJD2OUJ+KTAhBdpoKeHxAW?=
 =?us-ascii?Q?APuxMLAU0ZHDKQgdCKTlCfXbB34jFHSb+mm8sdyHKEaYD/Un6d7BWw0JpFiy?=
 =?us-ascii?Q?T+uazA9bsx/cNwE2K+6JZcroHG1pxtvxGb8I6wTx1iD61cY4XqtFeG2YNhUr?=
 =?us-ascii?Q?mWTKopkFnV+OljgIsoAqrRCx73TYGBKd8seL7YKHY+QWHEKX+CYdGU4epUP6?=
 =?us-ascii?Q?e6sjtRUkNlpJiZAWxSYv/AfegTyc3h3hqW3lzMg5w/nTQKZyJnuNwVjeQmjF?=
 =?us-ascii?Q?KUGMKwhfUB+Vw0OkLi22psyvt1Y0DF3ydJ8IWqd7MYW7xvRqeTyN+/7QOe10?=
 =?us-ascii?Q?SrOsPb1RxapdIDMJO8+1aqKuS5TbTVM5tnrzkvkOEavfj4m/pzj7FUsqhDXa?=
 =?us-ascii?Q?/rZ12YIaGYrYNoKxfclEnUUmWICOTCb2UDGzTgdfOIsZGjfQMsH2TJSStTS7?=
 =?us-ascii?Q?IXgwU1bB4+FJ6doLZZUmimKljvm8qaMktCbB4EVZRqs1by+p1fSn4D86MdDf?=
 =?us-ascii?Q?BOMin3aWLrrjdPi3dzZ66NAI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a7713b-2237-428b-29b7-08d946a2822a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:36:43.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPaOt6JJ4xuLC2Dw0ou1IiFOG1RWeTy6L1i2H+zj3AKqqV6drVhQZmfiUzZWmMQSDD0jwgyx1lA6I9cNvv617l7RfTrI79pKY1F+raDvLF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5412
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10044 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107140055
X-Proofpoint-GUID: zu2XzILchw68OwloS3B2GrEJjoR5LlwX
X-Proofpoint-ORIG-GUID: zu2XzILchw68OwloS3B2GrEJjoR5LlwX

Hi Paolo,

url:    https://github.com/0day-ci/linux/commits/Paolo-Abeni/mptcp-refactor-active-backup/20210714-051541
base:   https://github.com/multipath-tcp/mptcp_net-next.git export
config: x86_64-randconfig-m001-20210713 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/mptcp/pm_netlink.c:931 mptcp_pm_nl_subflow_chk_stale() error: uninitialized symbol 'push'.

vim +/push +931 net/mptcp/pm_netlink.c

bc57ec20ec19b4d Paolo Abeni 2021-07-13  904  void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
bc57ec20ec19b4d Paolo Abeni 2021-07-13  905  {
bc57ec20ec19b4d Paolo Abeni 2021-07-13  906  	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  907  	struct sock *sk = (struct sock *)msk;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  908  	unsigned int active_max_loss_cnt;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  909  	struct net *net = sock_net(sk);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  910  	unsigned int stale_loss_cnt;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  911  	bool slow, push;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  912  
bc57ec20ec19b4d Paolo Abeni 2021-07-13  913  	stale_loss_cnt = mptcp_stale_loss_cnt(net);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  914  	if (subflow->stale || !stale_loss_cnt || subflow->stale_count <= stale_loss_cnt)
bc57ec20ec19b4d Paolo Abeni 2021-07-13  915  		return;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  916  
bc57ec20ec19b4d Paolo Abeni 2021-07-13  917  	/* look for another available subflow not in loss state */
bc57ec20ec19b4d Paolo Abeni 2021-07-13  918  	active_max_loss_cnt = max_t(int, stale_loss_cnt - 1, 1);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  919  	mptcp_for_each_subflow(msk, iter) {
bc57ec20ec19b4d Paolo Abeni 2021-07-13  920  		if (iter != subflow && mptcp_subflow_active(iter) &&
bc57ec20ec19b4d Paolo Abeni 2021-07-13  921  		    iter->stale_count < active_max_loss_cnt) {
bc57ec20ec19b4d Paolo Abeni 2021-07-13  922  			/* we have some alteratives, try to mark this subflow as idle ...*/
bc57ec20ec19b4d Paolo Abeni 2021-07-13  923  			slow = lock_sock_fast(ssk);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  924  			if (!tcp_rtx_and_write_queues_empty(ssk)) {
bc57ec20ec19b4d Paolo Abeni 2021-07-13  925  				subflow->stale = 1;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  926  				push = __mptcp_retransmit_pending_data(sk);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  927  			}

"push" uninitialized on else path.

bc57ec20ec19b4d Paolo Abeni 2021-07-13  928  			unlock_sock_fast(ssk, slow);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  929  
bc57ec20ec19b4d Paolo Abeni 2021-07-13  930  			/* pending data on the idle subflow: retransmit */
bc57ec20ec19b4d Paolo Abeni 2021-07-13 @931  			if (push)
bc57ec20ec19b4d Paolo Abeni 2021-07-13  932  				__mptcp_push_pending(sk, 0);
bc57ec20ec19b4d Paolo Abeni 2021-07-13  933  			return;
bc57ec20ec19b4d Paolo Abeni 2021-07-13  934  		}
bc57ec20ec19b4d Paolo Abeni 2021-07-13  935  	}
bc57ec20ec19b4d Paolo Abeni 2021-07-13  936  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

