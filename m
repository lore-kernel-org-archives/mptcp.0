Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9B1FA9
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 05:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD5nU2JsWtDlsWR4+AvTiElIu18i4CENo3OPp3hdQ5UUNvwgcQTTE73rYT5zWjLEbeiNnj168dzrUGJpzBNHl46VAVc1z2KF/2ZI61KUq6839U9l3cKXW1FQS/SViKq6hTKE+4Zl4ZSal8/QXTu1t4i442VMTnxEoTigdOh3QcW1lguIDO2tB8lGJrKTEsg4zRpCvV5aacW1/uPKCG1brOntm3O5AYDbNUUL8FlSe/v/YJkeWoXH+hSuDX73LzQ342dav9jkpk394E8PEkk+jphYQjhLd07qXj2HDsiMhe5+mSHixrBxqTb6sT6uTb8z8SCOAmy4dvmFpfnMTDyA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS3FqBrAApTXPJxrSjYzxl/DF0cv1FkzPE3/acfeCn8=;
 b=JmKzx6hXeSCeALT9FUpvIRn5go98/NehLL992Ur8kaTh3Bjj4rnNYr6APT7enGSrVVozTJW/7P5jzTtiAiOKhrJ7TsT50Hnn8P/+8y/srIC+x3MRqxMF6Re0lgPf/zXb5tZhwbvgd65I6iXCmUL+yOHx7E0l62vPc1aCgQNwWgpFZ1Pui4BgxhKWUQL+EKMGJoP+7DdtiUqH2cYTPQ5whuWdwuTuXMob+LvROeG7ioqtmWHw5gtYd8z4bOLKXK/IlBFHd+5RzWX5Q+k3Tc72zydVgwRajT0/kiiHpPZez3XWNgF5r18zWZCkHrgIfqRc8Jv8EeQDfEBh7EvGJ5zFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS3FqBrAApTXPJxrSjYzxl/DF0cv1FkzPE3/acfeCn8=;
 b=PddOuvoo/hL8HR9JyxEdM8pt2zxVj2mxKp7iuUs9LHkewea+zMRiTdz8jaYYzYyUo9nSCY1T3EUIcDuu7qlJEiaOYPjzj7X2xHSjOgnNn2UM6Ksw0GjnZ5GKgy94ShZU9mVCKd2zfzwP5sn/pDTRQSxFerVsFT0KfufjHnkTxpGx5sPTj5My9k3gzm4qaOtAINfzMjPA22U/6qaB+HzfoE+g91D4C/HJKe2D8F9H0Dj9ieYlMMt6QXmrV+6yy5wS+AR2QZZ3HBxPLdsF5fPsJPYETh9/LKLGp21J2MZ04kAQqTdvLydxR8f+Ed86qqi8rd1l9xlEHKH8ZaLJE6emKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8099.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:15:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:15:22 +0000
Date: Tue, 20 Jun 2023 13:15:24 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 03/10] selftests: mptcp: check subflow and
 addr infos
Message-ID: <20230620051524.GA25272@bogon>
References: <cover.1686900596.git.geliang.tang@suse.com>
 <91c10944663b947b6ccb8b3be5b2f8581295ba73.1686900596.git.geliang.tang@suse.com>
 <bb2adfc9-640e-4c5f-ec46-87bd850e996f@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb2adfc9-640e-4c5f-ec46-87bd850e996f@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd03569-4c75-4420-3080-08db714d5870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nsx5HoxhSDTlaBoJ4ZoavdXeHkiv62Jy8vMD5UTnVsjBS1RKhzF4UE/jljWt0BwJIibl0izC8bsEmqPfPjXCNbXhqRzcMWHWvu7hBPUE1GOLDaaWACllqQEiCrKvdav2muaABsky7lA2mGP+2k0vW4nqUKpQJ2TOgeVGle7TDrhzOpD5lx1Ybiiy4ENgcSLZ683EFy2IWk8EqAJcSQUC3BeGg0Cog1dMMWmik/CPoywaGPGrN/XBlLYt5HAxijZ0pKZPULhYJa9/xhbgLdUlsUjVC7wY7LrRefZaN/jvTnomSBAkYuEOzAE0Bd9qfINHYHIc4z0MajM3yiWHkeAzDOttyWZnGXZ3d7S5qgNkluelSiSlIgOwgCBucok2+qvz2B7H2Zf3CHw2AqTu9vSgyrRPZIYB8QetKIZ3Dv4nhFGf47z3im/ZzLJvWoJEqlmCHhx2tahiqi3Ht8csPRxB60RInQX+SxPjPN6lp1seq1pLb/34Ah61QWWLX1vewzsn6k0Y+EFNwupmAL0PGPcVo8kmJ2AaMUgtaL+kmQ4vxZqS2ChntgkX+xXomZGWdJJomKAnpj+dDzdm92cJf4Gkms/erRz+ixDvss65U7j5K7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(186003)(9686003)(53546011)(6506007)(1076003)(26005)(6512007)(6486002)(83380400001)(33656002)(38100700002)(33716001)(86362001)(15974865002)(44832011)(2906002)(8936002)(316002)(8676002)(41300700001)(5660300002)(6916009)(66476007)(66556008)(4326008)(66946007)(478600001)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rI0aRiukRNOIHswmjgIQG7FmwcpnAYKRVaqve/OiXGeUuCZfhFO3ZEviOIRq?=
 =?us-ascii?Q?eEYp0S6RvczSAh53oTCAQTMWVt7Dr6a3JXlvjU0tZvRMXyipnPJ7TXBF9tLO?=
 =?us-ascii?Q?nnCEUA1ljuPn/531Nd2YgTghvPmgI3MWbFDvzaAW+/T0vT/5kkYSs0GuF5Jy?=
 =?us-ascii?Q?gXns68VI26vSo2XBe/GCRZY9Y9sO9WX7lPIYV7Ocv6W9jz62QLHS39hMQmoh?=
 =?us-ascii?Q?zxCQrg29UNK/7UOWnRT/MtN+A+WvLbDMt6cwfR38g6rHVlmScWe6QT25uYa0?=
 =?us-ascii?Q?dvuF2Qx/lxTR+ZNf5eSHkfbkAiTGmgdV/Vwy/k/hAfcboShN1hKtu9D7b6Ue?=
 =?us-ascii?Q?guHaS4kL/m++4A6gBYnDUFcbHNWSLk9z+bsTboqBUjOQ8ArkDkz8pd76HAKx?=
 =?us-ascii?Q?+vnpzjziKKAVrQyfgX+lkmLN4QaZbmabEju30RQSNYXSE6RE44W8qYJfvBLb?=
 =?us-ascii?Q?kH7dUqY8E5hdSlgVKeKaDNQJX4zqBpUC0JOda8Gubh3A8Hmb0qXXd4Se95nX?=
 =?us-ascii?Q?dgYhV6Ep/YVGDq6a18cCxsvAlYr11wupNe5+9ahNNMptwFuqQGWA50/021os?=
 =?us-ascii?Q?1DhRNMtfp9zWastrY872DYQOxNpHCRcaZEk8bBgbtWQU1q3x4O72B0waT7op?=
 =?us-ascii?Q?MnswjZFVU2AsRO+14+1N0mcNZ3Z2UvDnZQC0ybYOUfbjF1AqtT3mDvOrxiib?=
 =?us-ascii?Q?vpuucEKULM/sByODdeK5u6q3VOrbvfKBwCuG8lo10sdq835TtgfbRiay9GPq?=
 =?us-ascii?Q?mc/YbxJIt2Ktgqp6L71uIgv22huow4hMJcpvJGfhM2K2jWmLnolbs9k0Uhfv?=
 =?us-ascii?Q?qraQINSvAduPVhGNqFuM7mSW5g32ltWqCjU5RqUoq98Ropy/o4kej+ADSoGA?=
 =?us-ascii?Q?z9EVBuG1Nl4I1kXe+7rZPJ8dvSOSuvqsb83ByI4SYSyzcqJmmTKST0rwfPP/?=
 =?us-ascii?Q?DiFiFlwsrKuHBSqiDUsGyGJ18Y7Yk2wDjF1CSrLROSKMOpQxfNIt/mxAJpSJ?=
 =?us-ascii?Q?79kfrgRF6+fpl38Z8IClcYdLIFEVULflQM0z27DcCGgzZzbh/T6uWUKzeZTH?=
 =?us-ascii?Q?eFXB4+Etl41mBjR64hr4bdtX5O73IpAJt40fnJNS4NA1GFnS0E6uSqKlmzbR?=
 =?us-ascii?Q?YaYdafEK9fAMLj2N7Rn8jgjQ/nsvwJ787KdcoNyaIs1Fo8wWAO/W9D24FIV2?=
 =?us-ascii?Q?f+D8khvKB8a1yYR6tXjQMAuPPp5vObj+lwU64XBf6PfsSdSn8H3i5XA2GcL1?=
 =?us-ascii?Q?HE8IzvjX513c6JgoULHX3yIx4j32sGSVyThuxizKVtTWn4F+jKbawIZFv2RS?=
 =?us-ascii?Q?d/npUwp+EJtxsMqgwIZdvnlzWLKxTmZYvcr17uqTLemG92cJmV6nws/C6mD3?=
 =?us-ascii?Q?6JilLzEqRcEW8xr+JCb1CoiUopMDyzKrcQ5zE9rvZ88cPuWcWU7zPaVZ61G1?=
 =?us-ascii?Q?JgBFOjTeiAADBz7cTObpT2nDmvyjeo/UApOh9tHpuG/Im8dU23H5uY8NEytU?=
 =?us-ascii?Q?P9gKZTCUeY7j6nkKz34wPC+TewGZDGhZGLrFdJfX5pYceZW8QZjONxeg8xVz?=
 =?us-ascii?Q?zRdia722kcxbdEr4QN/bWtEConAPPkqM1jUiAk1U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd03569-4c75-4420-3080-08db714d5870
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 05:15:21.8290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxynxejb4qP0zSFku19JyEm33mGS4a0Z8E7CniMn6pOejEjqt0Pu1Zv4PjoWtxCp8PS1v9Y6lOl6S0PtiKBCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8099

On Mon, Jun 19, 2023 at 05:01:46PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 16/06/2023 09:30, Geliang Tang wrote:
> > This patch adds more arguments for chk_mptcp_info() to check subflows,
> > add_addr_signal and add_addr_accepted infos of different namespaces. And
> > invokes chk_mptcp_info() to check subflows infos of userspace PM tests
> > and endpoint tests.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 48 +++++++++++--------
> >  1 file changed, 28 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 3baa6ac3b03e..3811a6c3dc5d 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -1832,31 +1832,32 @@ chk_subflow_nr()
> >  
> >  chk_mptcp_info()
> >  {
> > -	local nr_info=$1
> > -	local info
> > +	local info1=$1
> > +	local nr1=$2
> > +	local info2=$3
> > +	local nr2=$4
> >  	local cnt1
> >  	local cnt2
> >  	local dump_stats
> >  
> > -	if [[ $nr_info = "subflows_"* ]]; then
> > -		info="subflows"
> > -		nr_info=${nr_info:9}
> > -	else
> > -		echo "[fail] unsupported argument: $nr_info"
> > -		fail_test
> > -		return 1
> > -	fi
> > +	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info1:$info2=$nr1:$nr2"
> >  
> > -	printf "%-${nr_blank}s %-30s" " " "mptcp_info $info=$nr_info"
> > +	cnt1="$(ss -N $ns1 -inmHM)"
> > +	cnt2="$(ss -N $ns2 -inmHM)"
> 
> (I don't think we need "-m" but it was already there before)
> 
> > +	if [ -z "${cnt1}" ] || [ -z "${cnt2}" ]; then
> > +		mptcp_lib_fail_if_expected_feature "$info1:$info2 SS counter"
> > +		echo "[skip]"
> > +		return
> 
> If I'm not mistaken, here, we are going to skip the check if:
> - "ss -M" is not supported
> - there is no (more) active MPTCP connection
> 
> I think that's not correct to skip the checks here because some features
> are missing for these reasons:
> 
> - For "ss -M" support, it is probably best to do that in check_tools()
> function, similar to what is done in diag.sh:
> 
>   if ! ss -h | grep -q MPTCP; then (...)
> 
> - if there is no more active MPTCP connection, we should then assume the
> counter is 0 and not skip the check because maybe we have an issue if we
> expect to have active connections.
> 
> In both cases, it is not linked to the info we are trying to grab and
> the printed message that expected features are missing is confusing (and
> wrong).
> 
> => So I think it would be better to:
>   - add a new patch checking if 'ss' supports MPTCP (can be done in
> another series)
>   - here: just assume the counter is 0 if 'ss' output is empty
> 
> Also, I just remembered 'ss' will only display the counters that are
> different from 0... That's a nice thing to do to reduce the number of
> info displayed by ss but it means we cannot use 'ss' to know if the
> counter is supported by old kernels... On the other hand, all the
> counters you are getting for the moment (subflow, add_addr_signal +
> accepted) are present since kernel v5.9 so before the first LTS version
> with MPTCP support so we are good. If one day we want to get new
> counters, we will first need to check if the running kernel supports
> such counters. We can do that later. So no need to skip the tests here
> if it looks like features are missing.
> 
> => In other words, sorry for the confusion but I think it would be
> better to go back to what you were doing before: without the 'if' and by
> retrieving info in one step:
> 
>   cnt1=$(ss -N $ns1 -inmHM | grep "$info1:" |
>          sed -n 's/.*\('"$info1"':\)\([[:digit:]]*\).*$/\2/p;q')
>   # 'ss' only display active connections and counters that are not 0.
>   [ -z "$cnt1" ] && cnt1=0
> 
> If there is no other modifications in this v20, I can do the
> modification myself if that's OK for you. Or I can apply a Squash-to
> patch if you prefer.

Thanks Matt, please update this for me when merging it.

-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
