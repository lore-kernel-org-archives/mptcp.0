Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333182565
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 15:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652543326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1r3ikRx0jryQA2mSZCZ/eODpSaCT0FiaYUwJdJpqVfg=;
	b=iSITh6iOmn85R8d6+ld9K3HDM62vfVxdqmmiNa3oJAuyv0CY1ypb0tEqArU99cav5MbxY2
	+f+qDNhpUGVcKqSzLkvI4lSgr2Wt0lStScI9Ow8PyrgbZG3EnKsGsJxYc3CdEnQqiNsXTo
	BEqC/3VhAC2EKN7iiyFmSLwz2Tw05EQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-CPvbiK-3OPe4IdgsZAehkg-1; Sat, 14 May 2022 17:48:44 +0200
X-MC-Unique: CPvbiK-3OPe4IdgsZAehkg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUE/xkHs2dst0nOPHy8gX+kmrMsBkUEyJpTQrseJRjx3nGyBjMJbahZ8sVOWtXaygr6kPS7xwXj2ZbWirNUel1K1xTLCBRQ0k3H72eyvUr0o8MwB/5AovH98SXwxzfxHJk2E/RnhfV7Wpiz+WcK4JHL5nUXeyfGWfmVRoJQlEZVtcsyRjQIdEtkUs9Vr6mk71UoGwZRz1onIUcs6oUSDhZ/VYx2eNkLcuSDNMBfz/TptSYEkDMqt0y7wYJBaCS9TV8s9FhkR8Qnh6IU0lGdCaHKagfbtoSM7ywIS56QvusKGxTjY7T5idyIclI1srsHgHZyhd5EEoHRiz6iMf+VGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1r3ikRx0jryQA2mSZCZ/eODpSaCT0FiaYUwJdJpqVfg=;
 b=gupuIMWjkoZvcofHtiLTS1iueag+9BjeOiH7iXPtQb0j81rs5BXdPC46PlH7fwoaIikl55bP//VcFb277opsqPgMCH8N/ChindtCC64TLOIHJp8VDzwp6fJPoZBnUfkAQG/gYuaYeLRIkqmc5FEfLbotosMNw3GFYGybeAMToLPCkoF77WUW9lgqEjiJ8TCEUwjTZeFNyCuCueKGf6ny609fX0aoMocbH3Zm2xzwg8FWRTYbxpYYT7zE6v69wmjKgks4vSEbrNvA4UN3YKXUMKa10b9USQCY1KOYamb01wITjb1LtZpy5Jh6iAf83kxqCMnm5qjMKWclI0GqhB8OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4628.eurprd04.prod.outlook.com (2603:10a6:208:72::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Sat, 14 May
 2022 15:48:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.017; Sat, 14 May 2022
 15:48:42 +0000
Date: Sat, 14 May 2022 23:48:45 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export branch
Message-ID: <20220514154845.GA4189@bogon.HOST>
References: <cover.1652255615.git.geliang.tang@suse.com>
 <8f2755bc-4c52-9837-c0db-2b620d7a3b22@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f2755bc-4c52-9837-c0db-2b620d7a3b22@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0058.apcprd04.prod.outlook.com
 (2603:1096:202:14::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a679ed-135c-4012-34b6-08da35c13853
X-MS-TrafficTypeDiagnostic: AM0PR04MB4628:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB462890387F6A9060CFC9960DF8CD9@AM0PR04MB4628.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tzoqvc0UHXt9UECWoPsyPyBPWZAVqq9583/0TRdg+1iU4ECJpaKtTR77Cz1WlJIYL9mbhT2obnv3gQZockDkUZ3C2b25M0g5faZwKhaosovHFJgTcn3DyYH3uIB7YuXTOzDs6u2qbSdWWZ4fFtR2EB+lpJASH1YW82dGn8erxizAJYBwiDDX9xA3Z7G1/W8T93YGNI39ChJRoZPMRfQRPXWmmpqOPxz48m/sVJQLjsR3wZwM3NFHw9GOkfGEJWwgXyuUYJIZSt7WGZ1/2SsjURauzzmtfOi/cFw187lJ6rp5wCby7/WkArSZhb6xJm264Tj7eMc+djR6AKof1T/z6DewoiU5VMnXtuxVCi6Mim6b+I7W9eOohYKe9zFw6ulqUw5F5z/eJif8Nu3BSbEfalLeF7oPt+yuMymCR05ce0M/rE4lVKGQcjeMDFnFjmUzt7m4qMn9iGWxw+RI8wdLhJEpdC5Y+i5Gbvxu0p8B7o2FRD4YZhqtwuHKBnQwhb2HEoZIw3pzBj7wFJ/+g7GimKc425HGTOhmYnwMh7PBrewNn/vXT26hpVOkjvTYLnR7G5iTRPuTxDXuIamFQRYQRI8Q5CFFHsnp8cO+pV8s8XJv5TRLBj4mLEj8ZnP6OoVPVb120m3WFqxyqVV7r8M65ivGCjWhacr8BQY3ywlq4wvNLAav/ua7oFk+ZmmyhVLMCgz0C5T8wh81eK1Vqe54tyBXJeqPhf/1vSRYus7+eOb1hlsiCWPetX0YOaKMp6bsm+b7P7TZu9XdXqyXsJk1OQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(15974865002)(2906002)(508600001)(8936002)(33656002)(5660300002)(4326008)(8676002)(1076003)(66476007)(6506007)(9686003)(26005)(36756003)(66946007)(66556008)(38100700002)(186003)(83380400001)(86362001)(966005)(53546011)(15650500001)(6486002)(6512007)(44832011)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bNRwcRA8Gd3GYtfnBTH2fyaAP7wA9uuP9gBczzpyA0Tni7YQstYnqxBAHdA3?=
 =?us-ascii?Q?vZ22nAZcGO4Sr1hhnvh69dlqVShPsTKgZeeZ4ZHPWIs9n9sAF8cPva7dG8vG?=
 =?us-ascii?Q?bwjUT0FzUhpI5/U91yceVuyjpFn0nfeUtZ9hrP3Jea92PGjbhCGYAoZ2Dw7+?=
 =?us-ascii?Q?fcj32liLxR/7vKHZAajDKUdQWVhesmTlgEBcxwU8MN7ZRCNuwzEPlxizEoht?=
 =?us-ascii?Q?29QKrNH0U2o5kt2xS/NZRiWN5DV5Pldgklqak4uDbrceT9bninsmTq65QRlB?=
 =?us-ascii?Q?5U9d1u/pVlwR52z39o9Tfq7UicCn72Wm9tDHpLHL95BffBYuP2SO2AwoLnHc?=
 =?us-ascii?Q?W/sDb/pSomh9FmxpAt+3eUkO20TcHWMVkYzJLvZRI4d6SGjj2xNcUpNy7iX6?=
 =?us-ascii?Q?ix10En1LJJp/9qLGRNNklMmppjQPWBfqZEjViV6So+uWXvWFUn2vCEXcpZDM?=
 =?us-ascii?Q?DvjK9FseAIz7wmTeyc1skDTjWxBp4t6sIxYjXxQ3v2Uhsw8wnUqG6Pm+erWN?=
 =?us-ascii?Q?zf8gIq3bdMCMXYS9LFaoVKuWViiq/wosHdnxgVuvM+5o6/bwihAtfSft6AAu?=
 =?us-ascii?Q?eVyhaB4uQuaM5ceA7zYe0oJozUXeOwJh24a91rPNVSG01kGtjcyBjvFi4DZp?=
 =?us-ascii?Q?dqJ7ePnCmuwqtI3rYDUsOYK6wefNHHe/xvWsN86nS4eYyKUOrsXd1z0H8aEv?=
 =?us-ascii?Q?At3r3RXLsmyUj33zzsKb/PBrqijCTNe/Sy31hm9AAxZ8QNDqDnwhYaYUx5ZU?=
 =?us-ascii?Q?j+4Y7l57gcUhaXIJ45DXagE3chc2MayxptbXp2K538eyEF0Mr/Y9qHi+CyZ1?=
 =?us-ascii?Q?kwu9Tidj7apWzv3QEK/C259lSsCwEuwH1KCpVLemjl85C4u5IyHSrMrhyquU?=
 =?us-ascii?Q?XnUk3fitVZL6KBmRwsrP+hQFGa5OnvADTnGBnbbAOYNacM0pJHhnXxi6vRhj?=
 =?us-ascii?Q?CSSWAkDg+f+/A4KiIK8rgtFlwMisPZbWUCDRMam38DA5LoeH3dV4/JjAa94g?=
 =?us-ascii?Q?laXypb/dlVgQ8wTvOHbyU8oqIfIZ6uJRvzDanBUerWM2zhXdCWsm0jmd3wsY?=
 =?us-ascii?Q?j8c7u8FldhohkHJpyy8hWiAtQU1XJLxajj226IQ4uLf0gLmVWCopRO/ZuUve?=
 =?us-ascii?Q?j/6TSsrQh/0XFykoJnt3VlZVEhSWLavHDWOrMxl8jKKGzUBskhWf3FadxaZb?=
 =?us-ascii?Q?EXmN37AEpyqT9TaqUnT/3af0o+JtxecUFf5aAen/zjaQEVbDVRpEu80rhLGg?=
 =?us-ascii?Q?NovGrZJAbIyPSw0JyXWa2c6wd9NtxPuHrE4bYtk2eoJ9+9SdjaK1DV5jw6bi?=
 =?us-ascii?Q?CNjsA0g3irmd2bH+gszHRP519+uUIgA2FxHXfV8JcKjjhP3yP60M8fudlRrP?=
 =?us-ascii?Q?5OTbuXrjf5QYvAW+uQlU42GqUFZbrHOyU4I+fLh5qnUTSP4RwW3TE6tOsQaH?=
 =?us-ascii?Q?EaEC3XlNWW665oyZnw596WR8tCLG3fMEU64rm+5A3zP8Ibb8hqN1WWrL1XCv?=
 =?us-ascii?Q?1feCBi7+k/o/DFP8wAKoS5/7X3f4ST4SbrvNGdPEqDkVa7y0p7njCvNYE/tw?=
 =?us-ascii?Q?Bm9qaiNCbnYQocUDUxyuc8HHLq4BVlCHZACTtKENDObfj9ESZ1IVNwF5bc1j?=
 =?us-ascii?Q?MvabMmCTThxcnCyTf00CU0GaOfDHy7gNjUMfdYehOyB/4XpukhCoMq+jBs40?=
 =?us-ascii?Q?oFkiAQCW8LBcp1n01fgRxOg+ZB9BGflg1Rvxx5KoCCePOTPlN1lKO2SjQQtX?=
 =?us-ascii?Q?yduZnfuFizykhAd114SK+X1Ncii36vM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a679ed-135c-4012-34b6-08da35c13853
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 15:48:42.0502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjLJc1WQWV8nqaUiV6L3cwf7Xwp+h0Jy9DYFDhoR6RBAmF1AV2vigZBCTxquJUGFpq5lzUwFsCoH5FFXv73rJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4628

On Sat, May 14, 2022 at 01:25:35PM +0200, Matthieu Baerts wrote:
> Hi Geliang, Mat
> 
> On 11/05/2022 09:56, Geliang Tang wrote:
> > v2:
> >  - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andrii)
> >  - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & Andrii)
> > 
> > base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
> > net-next-next") on export/20220510T054929
> > 
> > v1:
> >  - drop bpf_mptcp_helpers.h (Andrii)
> >  - patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat)
> 
> Thank you for the patches.
> 
> I *think* everything is now sync in our tree but feel free to check
> because I had to "manually" compare patches with what was in our tree.
> 
> But in theory, our tree is now ready for a v5.

Thanks Matt, but three patches still need to be updated:

Patch #4, selftests/bpf: test bpf_skc_to_mptcp_sock

if (!tcp_sk->is_mptcp) {

->

if (!is_mptcp) {

Patch #10, mptcp: add sched in mptcp_sock

 struct mptcp_sock {
 	struct inet_connection_sock	sk;
 
-	__u32		token;
-	struct sock	*first;
-	char		ca_name[TCP_CA_NAME_MAX];
+	__u32			token;
+	struct sock		*first;
+	struct mptcp_sched_ops	*sched;
+	char			ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
->

 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_ops *sched;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 

Patch #13, selftests/bpf: add bpf_first scheduler

bpf_mptcp_helpers.h

->

bpf_tcp_helpers.h

Thanks,
-Geliang

> 
> - 82041505ae27: tg:msg: changelog v4
> - a59272c197c5: selftests/bpf: add MPTCP test base
> - e30677603c0a: Squash to "selftests/bpf: add MPTCP test base"
> - 79399587d58f: tg:msg: changelog v4
> - b0d947191559: selftests/bpf: verify token of struct mptcp_sock
> - d84ab981b155: conflict in
> t/selftests-bpf-verify-first-of-struct-mptcp_sock
> - 0c8b3a796796: conflict in t/selftests-bpf-test-bpf_skc_to_mptcp_sock
> - Results: 7809acd805cf..a4159e050cd2 (export)
> 
> Builds and tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220514T112122
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

