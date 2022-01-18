Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045AA173
	for <mptcp@lists.linux.dev>; Tue, 18 Jan 2022 14:28:53 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ICQwIg012113;
	Tue, 18 Jan 2022 14:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=yPv+jvtW1x2joM0U9xXa5tWmGvqrt95wQmXvfT29G/s=;
 b=oalmvDXl81MZyDWNwDhLzLgS6g35YOmdALk6THMOgf1aFPzanEVWAttMeveElNLYq9NI
 bEnTNVo8/SngRQVsxOzcJLTLH3wri0Ner8y/GA8DEOad9jJNbQSXvvyng+Asr40Iz/lR
 MB31bJ3iejdH453O+SGHBw3elV/zPFyoY7TF5aXqEiA5oh4P6KDrW87PSXveXrE0cro8
 FrAa7AVg/h0etznYrHeybCsjLhZzlN6uNSD0q+2Of8kXdECi0kSLKk61pjHUECtlAZyZ
 jlukkF4Xd4mcdqF841ngr+xLJcEzCGPyDltcdRzs2fA1cNPsJU2IS8ssXxvSHKmZmfZS jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by mx0b-00069f02.pphosted.com with ESMTP id 3dnc4q22ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jan 2022 14:28:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IEGq8L039574;
	Tue, 18 Jan 2022 14:28:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by aserp3030.oracle.com with ESMTP id 3dkmac1pd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jan 2022 14:28:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKO69zmYuV+tGwMBysAHmzQtH3pKUo0YqCjAOI0JAQlot23Bozt33tA/DTyPvIbwnmUPuJEfdyReHzfcG/N8Au+8ZZzDNlOllZq9o6FM30TBQm5DU4eGB4NuMGmwjTD4eZWkX9JSGUd+typpB+PFvOdR1XuSFx0TuqtH/3NKrrIJKQNkX+/RGxUrlXz6UcxPPWCiQGNYPNOYlmnWsG/nG2BeEQCquIDIpCLKL2JZhCKymcjHFqBGTh1oFmxrU+oYh+6lkrXlfIyuhtcVMo+wW7hktw5Phpsv7xJ73IXR02XoCEc6H8ppt8kE1/9GkosNz7P1k0yg7ic474Xf+Q0FOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPv+jvtW1x2joM0U9xXa5tWmGvqrt95wQmXvfT29G/s=;
 b=LuQLGmW7iVjemWuXPyCqJbunsUq01t1Meb/VMviknbsehv5McaEIF0dcdHHbgs1Wp+8AZcoBr3yC2AndYGxQr8W+39zZBcCAlwy/j6L9K/SwMTy+w025hJ6CxHYWvPo1eyuGowFRB8KtAl6t11sEbge3P9bleY6vOwJ9XQEyxqAbLtQGb7aLRiTe6vJmNyjt7w1+OokhhnJNUgaxHyGtjbYlzKLwVvIvEEhWpy9Pn1K7DL2Q8pSlRoUZMRZnMvuFTxoNHAt1Y6o9dGFidnupwI1kFxhteI98MqL6zo0qJTJQowY3tZM6WfdCBjXECgleED4pA5vcshwzhI8QXaOnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPv+jvtW1x2joM0U9xXa5tWmGvqrt95wQmXvfT29G/s=;
 b=tzx5MAZRfdI32P3F2YoT5Jcq0MkHkL4tf+IHM9jcBavtFdjjFD+rYBjHsc5zf1tukcZbJgzR3g3oFRS8ht5LREk1CP86sHEEoeV0FovSS2MAtMi5kTSyWzQ3JEn3YuI3uS6RTflK7B1RmiHGDSC1zqQ3DDOZ2r78FT4K8Gv+MO0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1788.namprd10.prod.outlook.com
 (2603:10b6:4:8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 14:28:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%5]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 14:28:46 +0000
Date: Tue, 18 Jan 2022 17:28:28 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@lists.01.org, Dmytro SHYTYI <dmytro@shytyi.net>,
        mptcp@lists.linux.dev
Cc: lkp@intel.com, kbuild-all@lists.01.org, Dmytro SHYTYI <dmytro@shytyi.net>
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
Message-ID: <202201170247.BMTU5XYy-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116001259.203319-1-dmytro@shytyi.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b72561b2-8e70-4b8a-4c02-08d9da8ed5f6
X-MS-TrafficTypeDiagnostic: DM5PR10MB1788:EE_
X-Microsoft-Antispam-PRVS: 
	<DM5PR10MB178878B19194CFC51023E1988E589@DM5PR10MB1788.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ixxHlk++XiBj6AuF80OLRH+6e9xcVmcz3iQze1/w+qzuUKSf6IwXVNedqytM0MqX4nxzYxwiZn9PJ6AqSPzS4JENNUAehIK6jbYKFJU4uc+52qo22xRudDql9MyJtFA1xPDSr/H7HzK9R9IzCCqN/9XhNl0HySZDOvN6Mfa6jXPrZuhrdTnQhOtSf1kWnIAqsZn7qntmWMOBQcp6hVsfW6g3oLZzIuM/3ZYZJvJMXr1YuH/hHgf+sJbKwU4UC3M+NevbwesD+m4ICgryw+lDQHOrFaLfxT7lE7f2wFhS1RBUcebgtLrHhTEUPkxGNooJ3m0YbqQj9gTBw+ftVGxvloaJi0r2NqO/mPpqIMT9PgMQsCbmU6UKny1yGlJcJhWrRnN545R9/QoVAqNrlNTHeZVOXeiLPD+U/gdSn+scikAxB58+KggukplObyZSDmzIafUWRWVA0P92bUBtEdkBFOwq1Mw5nfeb4BlalmA05VXPwfV/iNiaaC9qN3EXN6thnhPRyQDNGdRgx7TsrL4iHaIR38fXQK7aaXX9mYWufCnzgBe2BOpKPUA/ALdhlWvBUW3o68MyTjJx97/Bx/Go0oUq3Ae0USNMAzUVfCzZbWT/+uA/OklHoo7w02++qPBdfFPOwS2lT+K4ghf4y0mePp6hLXBZlp/GXJwPdo12w3yeuP6hAswY2t+cLH74hV+9HNvE0M7hPtDRIC3ujjLbEtzxQuVvHXx8htXYMecSJPuvqYmrsRt8lK9IIFERwav/nzAK4m9TEE10zoA/J0J8yVBkgFId/eDeAZQ0mCxjwSMLu3ZO0sAGiJpXsAY+g3mit4VI/5QVVjg9rIZ5VUbS+w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(38100700002)(38350700002)(66476007)(52116002)(44832011)(6506007)(5660300002)(6666004)(1076003)(2906002)(9686003)(6512007)(8936002)(26005)(316002)(36756003)(86362001)(508600001)(8676002)(83380400001)(6486002)(966005)(186003)(66946007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Vy1WuUhXWIguYlAKhkK3XWrR9HlVdtjYpXrzp46bVlwoG4J+iHQhEv4VF1Kv?=
 =?us-ascii?Q?8H+ThVaEvW+sWe0qRjFG5ynWyMKAVod6FooqhPmwb0GYqYgxChkpM/liPcpU?=
 =?us-ascii?Q?4P+3NUj2U5jmibSZdUhRRh3pKXpDWEs9Q9/4y8TZJZwNW3neujnt75HAxUZH?=
 =?us-ascii?Q?oX3AGMJ0NnQn2O6D7hM5I3Be3/7erTVdGniWAwapyn5FwYcAJ97fL4EBMrhU?=
 =?us-ascii?Q?LPFbuL8dWGtj8BvCBdbce64KBv2/DG+JCZ1ah3JHHNegMxjHIm7NopZaJPF6?=
 =?us-ascii?Q?FrCdKLLi47jcc+URYsdKurmNUzlkpSej+YLkFWXMrqBsxlh/viIV+oYWFBJL?=
 =?us-ascii?Q?Bz+CiRPhFVYU+R+xYjyH9aF1ISXv3VSwGzmx2NP0iy0OhEdalxo5NW7thUiQ?=
 =?us-ascii?Q?PPoArMYj0MRpIRfi8lApfaBqMBVSmiCgzxlGw4H/d2bK1bGw1ost7sXlSZC0?=
 =?us-ascii?Q?tzsy4S0pdT8zYoSX0rvpXi00V9vffduk4y/sO4pQmF9p3q6nKcjesye3biSF?=
 =?us-ascii?Q?6KbDABTvV0vxL9nuPleiyFEHaK3fm2j/RUzqCIX/E5H+EPrnv7+8HrTrDuc1?=
 =?us-ascii?Q?5TlWelS+n4+sNA7QdZpK7VFexX8AOh30Xvq0R1hhDdI4WwNmLKos7Ic+GKs2?=
 =?us-ascii?Q?L8i1FFe3ttrxSOZo0oYuwPtQXtsGxk161lOBtOEsAaBgdx4154vBOq0x48gn?=
 =?us-ascii?Q?sNwKNnKuuLgn+64W3M5aBvjckwDU5CkmmUhihj6aBNJ2XhAM0Isiv+ScGCz0?=
 =?us-ascii?Q?pOTw6dQE47s72yhv10eX+ADUxd6SRWwoXwEQQxfiopG/HZLKOHUhUmlhOs5/?=
 =?us-ascii?Q?6H80JNjlOsFjyqJGQnOOUzUpXyuOGFuwReAOyj7kAh9b+7kDdoXLdF44Xfyg?=
 =?us-ascii?Q?6QengrWlyTP1ASWlGv1NVxOd97+d5J0rOvbcfzbWHHYk+ah645yJlmty6Tvb?=
 =?us-ascii?Q?/7XCNTvhV0r0Vry4/ckVUwzMFxFQG1uQ5Ag+QCmzYKvh1Ly8WG+xHGvs14f8?=
 =?us-ascii?Q?Qj8wVEXzrtYeyx5sjwZFml7+BnxNywUtifWu0/6RQlT5claSNfhpsombYPih?=
 =?us-ascii?Q?kzuodLJvuFUxWEj9NiCspii4NN5c5i65fsD8EnkKl/ckEL6y8UlDpR+CjgdT?=
 =?us-ascii?Q?7vCKL4kBK71n0iqxPkKxLDt0+AA5Rod4lxF1bR+RLq1iMbHVCOlLi6P1gsYp?=
 =?us-ascii?Q?p0+CMiN2Lp9TcWtpPiaQ2aijtmNIAepjDJ9qVoHXYUeVbonNx67/EwTAYPzk?=
 =?us-ascii?Q?Ry6Wvm0p+PW9MNSfiu15YqmmkvQMy/qzIkGjxbfqQROsMUMIoQv5KsJhTB76?=
 =?us-ascii?Q?E4ZlNX9kbO2c/YNeywU8d/2lnszESOY6Lexn2SecxlKDva08tE1N6a02VqUz?=
 =?us-ascii?Q?+3py69cZix8INXyJ13kynS6QtfrsHXaJY9SN/AGm5BuISFCKSZoRlkzkykzt?=
 =?us-ascii?Q?1vxvvWHhU2J2AyZOePmCX1FejUyYIyLu5MyQHNsGvQRK5DDWThF3FOxTW6Ta?=
 =?us-ascii?Q?4aCnBJyhwz6p61Q0lWAN+xSuvXKjCzIyZsQFPULCYLU2rM7xjODFfnXmr8Cv?=
 =?us-ascii?Q?J3vhvryDLRIKueljCcZ5IzFyjTKB3+geMq1Y7W8W9wDqgogoz+/4280UnxVw?=
 =?us-ascii?Q?cKwSyDy48UwX+6m1tEsVBH6ZFvFO5u0RkbtTSuqoCLiEjdAJ6sCQMSIM0BA2?=
 =?us-ascii?Q?2Tj3Gw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72561b2-8e70-4b8a-4c02-08d9da8ed5f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 14:28:46.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjkKsypIZXgmkgbhFx70D6WffvdIP+oCkBCEhFpXGm/17CUoQNKpDZAGA34Bj6rLG7n+h7JBabzE9X3oqrsGKLlpVp42w7Avoe7PMWa9knY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1788
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180088
X-Proofpoint-GUID: -BE1CVaJyxh-BkJeoZGxyYlKTs3cl1JK
X-Proofpoint-ORIG-GUID: -BE1CVaJyxh-BkJeoZGxyYlKTs3cl1JK

Hi Dmytro,

url:    https://github.com/0day-ci/linux/commits/Dmytro-SHYTYI/net-mptcp-Fast-Open-Mechanism/20220116-081430
base:    df0cc57e057f18e44dac8e6c18aba47ab53202f9
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220117/202201170247.BMTU5XYy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/ipv4/tcp_input.c:6960 tcp_conn_request() warn: ignoring unreachable code.

vim +6960 net/ipv4/tcp_input.c

9caad864151e52 Eric Dumazet          2016-04-01  6951  		if (want_cookie) {
9caad864151e52 Eric Dumazet          2016-04-01  6952  			reqsk_free(req);
9caad864151e52 Eric Dumazet          2016-04-01  6953  			return 0;
9caad864151e52 Eric Dumazet          2016-04-01  6954  		}
1fb6f159fd21c6 Octavian Purdila      2014-06-25  6955  	}
ca6fb06518836e Eric Dumazet          2015-10-02  6956  	reqsk_put(req);
1fb6f159fd21c6 Octavian Purdila      2014-06-25  6957  	return 0;
                                                        ^^^^^^^^

1fb6f159fd21c6 Octavian Purdila      2014-06-25  6958  
52c7bf82e2e91e Dmytro SHYTYI         2022-01-16  6959  //drop_and_release:
1fb6f159fd21c6 Octavian Purdila      2014-06-25 @6960  	dst_release(dst);
                                                        ^^^^^^^^^^^^^^^^
Unreachable code.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

