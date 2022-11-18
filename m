Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FE2F43
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 15:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSAcqkRFCiUN7A80+4ovQd+bDbq+5CAQsEkmtTnZYUN2LEvslpuiAc7yejohoQWVKPU/hACE+xcSvFYMzSlX9mpIRuIBtpBrefofgRCJ0AswUytFmHmujjPnnFuwizveFVw09IDaT8zu/KcGUf6shuX8mjR7HzNzQLaliYqrLrpD8YmswV26LOmJUqgk21iOXB1E7Zb1vFYbIlXrIM0i+pADxuqmhjdIGVoiZw32+su/+zZ4ZK4fXQPpVPhXmb2ig6jSYuZrlhLnfFdssr9/3BHPzTD4v+Wj5sbC63g09rzrZwFCdf79kUv6doY2fQBhM7L+01jPW0u/WL9/ccJ33A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xGQF5MMkyzJ2Te68z5bZnLJqwXokhSI4ByxqkoBa4s=;
 b=TNRXAOcMYGzP57Dbgr62rA67Hbv/65ZfXwcaqdPIXvzNhs9gdirmkpWp0vRHD800GkXF6HNnGwjgoch50zxC4tc79XkawtLEJTMBdY0EySol4ARwG2fLJY0l6NcXPPCSaXUHNmENsR4xkD5SEb0/FOzEEb0gOTFkfGHW436S2mqiNtKcKLX98ZsCLoOXJ+Hno9w5PN3p24AaKns+m029E3D/LLEn6Vw63kPickGy22YGcSxqAoTR+O/Mmbcj/tnppDN9zqGn71eXATZ+SswJZKI5ipYWiahDLT3c7gXcSaIYDOdFe+FffYY/ONuy1bZorCcw6LDeZpWYp6xwpjVy8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xGQF5MMkyzJ2Te68z5bZnLJqwXokhSI4ByxqkoBa4s=;
 b=oPXelCDnhWulY9Np/SKZB0BlRrogyZv7XpZkTBA3rc3pT3zSDIXrM5HLPD+uaMfkmpyq6PJuBI/bXzHlNpqvzM5PZ3D3/zMc2qh5v+D1YZRc7NZtLxLrAzHAgWPaYcfPEqHfz9NFTCwvMr9imF7AFz1tybK1zsnPNvZaRGYb+ZxC4RbtUQIGGFBZRrcdlEnpHeEBtgEeyCBFP8KYTGKwYXKJhJdb67pOPSIxVdM42bvuGaZRgGY4uFhlarDuGPLSJ28LlLbOuZ9rQHTJs8fLzP/q5oUYeAl6V7Eppp8ThsW6DFzS9tWCI062fJA1Tl8Xv0gxLKmQ/qlZK891w333gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Fri, 18 Nov
 2022 15:12:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 15:12:33 +0000
Date: Fri, 18 Nov 2022 23:12:58 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
Message-ID: <20221118151258.GA12972@localhost>
References: <cover.1668151131.git.geliang.tang@suse.com>
 <ae42a5ff-8d1b-e4ce-6702-eb3b3045cfec@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae42a5ff-8d1b-e4ce-6702-eb3b3045cfec@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0d24e3-1646-4855-6851-08dac977511a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AMPwVX7Vll0sUE5RapAnRFJDI903I9ytYbWSx/+3tFePWU/w9nJOHHfsSOJG3NdCKAWSvSMtRBB99zR2xAgTGn9QE8AcoaEdBJ7AkL59l1hZWKmFze4ZoDyMQf5Pq//3FFHSpBwSC66kJ0pP/07/5Kq4/0k1TMJotSW/ARgCn+d8oEZk7xgVtU8eNBzCfuoCbxUfxfxOjicwT6uPmclTQqUv0WlwPKrCWZStecVy3PiKRmW0YA/kA2klhx65hEGE7zPUb0nSEfvYRyppODw2iNLH695WSyFIi/ZvqM/tNdOYJBLYK/BZBwP22/y11t7n2LqRofSRyt0sQ9dBncBburAAWpvvvI5tIA9RZlKB9/q/ROKrkggw4fc4VcQUoyKbsnnrW7FbFuqK9po+ek6DVGaTtmxpeAeCM7sFmsbx23Oy9WEtKlouW3VC5NYfgUvp/qlR3WGeo7KS5kNPdBdpG3Yl6z490GZnddU2OLFH9dHdgcXwjOnvZaZIxB+QIdkokV8JzpuF28Uh2P3I5aZPIPgE5nvr7pxC2jt618PLR/kj9lZMioSyMKdbzshyTaoh7+Oad00Reg+ZTALUythxZidrmLGshtlTC9sLvIHSVdQdgRYqoiKvZxkwmnteAYH3EoJm9vqEo/dLCikbn8nR+IP6QTOkvICmIeGllyRrMsjeVmARpjfQoS59OWRptCbP9xq64ZKsD3/fLtWaIbrbZv7h6Eu6at/H3kxyJJX71yw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(33656002)(15974865002)(86362001)(8936002)(2906002)(38100700002)(4326008)(83380400001)(66556008)(66476007)(316002)(6916009)(478600001)(186003)(966005)(6486002)(8676002)(1076003)(41300700001)(33716001)(5660300002)(44832011)(26005)(6512007)(9686003)(66946007)(53546011)(6666004)(6506007)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlgShccX7W5e/fDUQ++89MDKQfG6N8bwFc6irc31K/9MDBdyxfJ1fp5dpfv3?=
 =?us-ascii?Q?/GTO5fZ2vl8rND5drAH39zzhKAQoAL49Ry6ebpPWDJgKx4A68dksuI5qpnCe?=
 =?us-ascii?Q?QoGN3XhC8NtA/xCvUvSTUk3wkBpjROEkbL5AmLWZhVTJM9Bf0TH+bgadKG/y?=
 =?us-ascii?Q?WIqJWYXoN7bRybBF77+A9IEyca8oc4qr+ED5lskeQiS2FKu1HTzxvA2w4CCh?=
 =?us-ascii?Q?rVhtoxlLmypXzJn3FGcWrdLjZrl3vavBODSSPcFQV3e1eXNyszTeTM0QmNj7?=
 =?us-ascii?Q?6w9GSRU0sjka8paq55RWgq+bszAAD3Ljb9NEsppLQx3LKoO/H1LR6pm6rnAU?=
 =?us-ascii?Q?uyDpfHB9ecgd4+gKL4C6nu+1pQFyaKepz74hGzp0DAmLv+9wy+eQB2VWX6M7?=
 =?us-ascii?Q?XiwoLhSQMqp3gVM/md/BD0MhEoLUgAfEl/4auUo4fEfneVSzYnX4d+HHtEfv?=
 =?us-ascii?Q?XjxDf6TNPKtHpNtNtp4uxUGAOZpobmdz5N9BxFG9LO+CXx4h2wxFfQdj+1jh?=
 =?us-ascii?Q?RFUh1Uawx4qYHXlB0ftnJnuLI8z5Gl+K+dynL08D3Ww1v14AMWg8SQl7kS/Q?=
 =?us-ascii?Q?C8Dq0X/6eBXcmuS4lqili1HWf9+8XAeHCouiZQ+/pbbu5FA3DO49GyYqqCAY?=
 =?us-ascii?Q?eCZh/GXvQREc2NfpRgrgbmpbEDoY1I/4fXS4IAW4nP6GYoel2F0fE0hV5qvd?=
 =?us-ascii?Q?KDVxZu3ICQxgzruzUB1h9Z9g40fIi677CBp3vjG8dDYuSz2/j3p5B84ybmCy?=
 =?us-ascii?Q?2BrsW58rF6kv1Q1K/L0nek33KqLbn/cGWw+5ix/FdsFOgjXI1C2odSJQe8VV?=
 =?us-ascii?Q?68424hMs1SGfEx0OigI8EgOvc96/rGYJ2vr8wwtDkmg8g3uKtFcNnwD/xCSo?=
 =?us-ascii?Q?HdTv4807g8PFe2GnbP5PaBy9YQS36ZS5eAJH8iYssXPGWjIDICkOpulATn8t?=
 =?us-ascii?Q?OJwsHizuKnQ78wGpcPHiSA2uRPeMn/zRxrT6R9ZA5Zj+3RB884vMzujiJWk4?=
 =?us-ascii?Q?0v85ChTqUQwJRj7Gk5oOHgIux2s5F39wYyPHUzov5O+HXuEqOpRs0BAMslNM?=
 =?us-ascii?Q?QcxQsJZ0aZO56HFg96EE4xd+CrjD9njWUsAVM8jnLymEU3mMYWskAQ9Txl6I?=
 =?us-ascii?Q?KiGDTU+EjtrH3Zkhy9RtFwMM0I9VLSW4QBbL3RbD+eTl8p3uSTSaoMz5bSbA?=
 =?us-ascii?Q?yZAKmxIpouPdCgjEL+wYbdxvMlKxBcYSWTf/yzHFChOT8+ZoipauhV9u5xJq?=
 =?us-ascii?Q?YPt1OXvkgSQ9+fpeFnly3ZYelcWdK7TyJiVqZ3H7Wkx3tLDiINq0kHSU0Vnc?=
 =?us-ascii?Q?2YyhqvHG0s4l2Zd0IIUWEdrYi+Khzm5MbBKGCa3rgUvqUIgfVoKYix8bV211?=
 =?us-ascii?Q?O4OYtPXvjbyEwrK+YuAzWp+Xoyxqp5M1hasa3J8IpniHBq8DmVaBAB76rRKu?=
 =?us-ascii?Q?VHOw4lsLN6xjVRo/iNk2YOv4OIxpKY1u1zaElcvmEyOIR6Na4LG8FvKjAS3L?=
 =?us-ascii?Q?UNCEobYktNun6cxYN76HWNxj1IgnKCrBMWjJj+9PbFCu/bTV7tP0yqWK+/mK?=
 =?us-ascii?Q?DMjxYijFN19mqPz4DLcLQcLdCjy/d/ar8wpW6KH/3jAowF1KkLArIap8B4Om?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0d24e3-1646-4855-6851-08dac977511a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 15:12:32.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti4HdYo+f06Z05NPp2UNpJtVHYrjPWK/RX1E1g8PV0powZ4QM79yqFt+29JyNkZsjTb+F5MAHSqasjQSBDnbVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305

On Fri, Nov 18, 2022 at 03:52:38PM +0100, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 11/11/2022 08:47, Geliang Tang wrote:
> > v19:
> >  - update patch 1.
> >  - split "BPF redundant scheduler" into two parts.
> >  - rebased on "export/20221111T055536".
> > 
> > Geliang Tang (9):
> >   mptcp: refactor push_pending logic
> >   mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> >   mptcp: add sched_data_set_contexts helper
> >   Squash to "mptcp: add struct mptcp_sched_ops"
> >   Squash to "bpf: Add bpf_mptcp_sched_ops"
> >   Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
> >   Squash to "selftests/bpf: Add bpf_first scheduler"
> >   Squash to "selftests/bpf: Add bpf_bkup scheduler"
> >   Squash to "selftests/bpf: Add bpf_rr scheduler"
> 
> Thank you for the patches and the reviews!
> 
> I just applied them (+ an additional squash-to patch) in our tree (feat.
> for other trees (bpf)) with Mat's RvB tag.
> 
> Patches 1/9 and 2/9 have been added at the beginning. Patch 3/9 depends
> on "mptcp: add struct mptcp_sched_ops" and it has been applied just
> before "bpf: Add bpf_mptcp_sched_ops" as mentioned by Geliang.
> 
> Please also note that patch 5/9 has been squashed in "selftests/bpf: Add
> mptcp sched structs" instead of "bpf: Add bpf_mptcp_sched_ops. Do not
> hesitate to tell me if something is not OK!

Yes, it should be squashed in "selftests/bpf: Add mptcp sched structs".
Thanks for fix this.

-Geliang

> 
> New patches for t/upstream:
> - 602fba0955d1: mptcp: refactor push_pending logic
> - 343f8eed9abb: mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> - Results: 69720c6cd168..ac857086fdb8 (export)
> 
> - 65e9504361f6: mptcp: add sched_data_set_contexts helper
> - Results: ac857086fdb8..ae9c4d4cf58f (export)
> 
> - 82721c73112e: "squashed" patch 4/9 in "mptcp: add struct mptcp_sched_ops"
> - a7c2367dd1d2: "squashed" patch 5/9 in "selftests/bpf: Add mptcp sched
> structs"
> - ee74ff707e4b: "squashed" patch 6/9 in "bpf: Add bpf_mptcp_sched_kfunc_set"
> - 813537758eb5: "squashed" patch 7/9 in "selftests/bpf: Add bpf_first
> scheduler"
> - 762c5b194975: "squashed" patch 8/9 in "selftests/bpf: Add bpf_bkup
> scheduler"
> - 5db53c2d3ef6: "squashed" patch 9/9 in "selftests/bpf: Add bpf_rr
> scheduler"
> - Results: ae9c4d4cf58f..0814e9ff0a94 (export)
> 
> - 7b3058027867: "squashed" in "mptcp: refactor push_pending logic"
> - Results: 0814e9ff0a94..d98411bcedd1 (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221118T145003
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
