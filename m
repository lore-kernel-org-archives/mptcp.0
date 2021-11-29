Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB372
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 04:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638159156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BSYvfvQPknIHCpqx/B1XvY6M54/5TZPpuzMtLAch57M=;
	b=XeKXeVn3z5r8eZ3jjX3VZoxEzYR9VP/WVG7rVH0fBCNlPMQyfwvBH1CydNX3p7tKBxMacl
	S43GE38+8BnEzK5LsHt5HBXcsuCubz3MTvOPGPjOdTT3iqTk8ZokoC7GP0wwsamE0Bd78W
	0qR7vLg+ZkeMfvG5Fc7TIE+tH60quNI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-U8XVNayOPnaSPUKma9R1uw-1; Mon, 29 Nov 2021 05:12:34 +0100
X-MC-Unique: U8XVNayOPnaSPUKma9R1uw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA/WcQo6Hz7hQsmGVv/UW5SN3SaUTzR7wjXvmWw3a0h4mFJGOsRNVl/XuM+OEUkF79X8+CxySjLJziKn08rExkeF8SWF3j1HMmn1pDbecXR4NNDNg4Hk6bY0tsDTtWrSADPXsjN0FjCcZq+u/VRbsx4S3Lw0/rS98DPRE1ikBpsKns7WfPafLXVD6KFmyTzHfwbNhNCjCM6BdVchlA5QrpEBlIgCx30iz0oDt4Qs/xibD4O+MjBjrRX6qLuQBnpSbCxASXKeT4mWRzSKHSdUVRYS0NyI6GhNW/L06+lPMYISR8myE8bExa8H/IbH4TPAixHmOSr3jxPblxOq6K0aaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSYvfvQPknIHCpqx/B1XvY6M54/5TZPpuzMtLAch57M=;
 b=KF2dbgG8+ZbInVIDuQCeYqMpvZpKxSyZXfl2UaGIfQP73g2rKQBTEIcZ2PCIZLuw1Dec6j4vRUbaESLgBbJTKM7XCa0Nl67TGnfbY4kVLCG2xLjHR2iBBRTQLoXaQfL96eP+9N9lLPfPGcLA2NGzwcx/WjpILgvsNbbfZJstKvjUupm5hRxXHNLzUb+0NMonpPa2H/mjEaIo0zMb1FQgjDXMAhupsBWO78h0yve4Zl+5ozwB0Lfqi+Pl/aDWMi3EC0v11rzmU6oJqbIJaiKLBwJ+a5l8ri+etyJFChGSrIQWqStii5ULWdVbq+JlJhg2gBBe/sfprTeibAtaHUHFPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2537.eurprd04.prod.outlook.com (2603:10a6:3:83::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Mon, 29 Nov
 2021 04:12:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 04:12:32 +0000
Date: Mon, 29 Nov 2021 12:12:09 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: send MP_FAIL with MP_RST
Message-ID: <20211129041209.GA23777@dhcp-10-157-36-190>
References: <cover.1637630218.git.geliang.tang@suse.com>
 <2ba9856233bd45ffe99f01566c2772b0dd12a501.1637630218.git.geliang.tang@suse.com>
 <cd39b3ab-b491-ee1d-9ba2-e47799d61e1f@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd39b3ab-b491-ee1d-9ba2-e47799d61e1f@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0215.apcprd02.prod.outlook.com (2603:1096:201:20::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 04:12:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1012536-5c98-429a-1c2b-08d9b2ee76e7
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2537:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB253762107522644B724B07D6F8669@HE1PR0401MB2537.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CjB32cBrS+URZiCb9rZFCT7qzOp5Ulg1LK5B8SZz8s6kGoGL13jn2neC/u9OMlCBPto/OV/upRnST+8rP/k39zjQkQBgNgyDLtTR7d7zfHCSr8JO7Iv/UivajPrKc6PDinDspXOXY8N0KU02HSSIEe02iGKZuHlxRoUkaCfEbSwy98jgv2Kc/s33vN8z1EqzsaRYN1J0zbL94jxX1UPp8mj0gLuafvMzyaivY49MZ3eRuY7klIsXUK2hL2fy0NgyC/RKB/GpSD0W6eoYu6dKuvkn/RlyHiMOzb6PiylD+H0j/CD166f2Jqz/VV9HG1zfAVr4L+mzD8O5pbnSQf/5Y8SjafzmaDcSUHcAAVyqSSdTwQBf+UEwVz3Z6ALyB3KTl1eXkToIO0RChBsfS1SYxJ+vbVfj9LxDbDlPW6jRE9Fvx9rQsHOGMSwbiKYxiZiN6UIEboLCMgH67qaOXWkASZA7TOAAgcyZaNB5VEqTrQpk2fNSQ5b6c5aImwuXa5snbcGYwDaJR1uAop+sxWsYQkr7PGtggv8Qc4U9LlkRuJi+lOZVegeyepL64tyEIDFag3Gp5oUg4XFyyOMM+lNfkTg1sDKgsFQxAypIiQL3wvm44tPsdOFODudadCtJ/YlO4Gx9l1Rncxe5gTP2IrjmXMhP1pGgjHJo9+LSIOh9jkO63rDuAvipDY3TyyHNeBD5LQcGib9/B38oVZFH22fRTNUCN8rrgCEH1Xi/iqAa9GU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(66946007)(4326008)(6666004)(83380400001)(316002)(44832011)(38100700002)(9686003)(15974865002)(86362001)(8676002)(55236004)(8936002)(53546011)(6496006)(33656002)(66556008)(66476007)(26005)(186003)(33716001)(1076003)(508600001)(5660300002)(6916009)(956004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C0FxVHueP/lsmUZN5/KSjq3esfpRdvvZ8osguLWGr4FBy8mF1r/IvE91S2SB?=
 =?us-ascii?Q?lIdjLvDitAiRUYhVCEJto9Nh8E7bHTaWvHl+k5uqvKxLO1VjF+Sa9JAESBMn?=
 =?us-ascii?Q?WrBJ10eqdXTeVsVGVEW5YhxL2N8MC30OrXS9bS7AQt+Klwf2Yoo77pdOOPje?=
 =?us-ascii?Q?kFXekbwi8VZ9Mrbv6YVQyEC4QLmQjdy0+yxGEXu5lx/kg+nlwLEPpI3aPU+8?=
 =?us-ascii?Q?4kaT++0ci5nhtlvJmLBgxm995Hw7InfItObJOvxYf+3LNfrhzwC+vNX4CZ8D?=
 =?us-ascii?Q?uE3QfJCzUhHIRrcyKD2LQuqfech5pkV6aHjlKfLSmeUhBxMmZkgFAoE0D0Uv?=
 =?us-ascii?Q?9NaJ5bwFKCE13oTOq7KLsKxZIrABwMAIax28Ml+up2Bl4TYnKwTH512CTKrK?=
 =?us-ascii?Q?KM/8Tj6kOe2iBx7Q2NFto7/NRSE9yBzm9fa7NVm1/sw8G0xbId2GnTAAEYjd?=
 =?us-ascii?Q?ZILGAN0fsLAe90qC8IhW/iJzzrrVxoU30vHeUpqGd4FOuXlnBvGmF1jiW2kQ?=
 =?us-ascii?Q?MttUqct9Y8gc9e+bPjl/Uq5xU6g3BhTzxHpNqIfmoZltHm6QTSJKorftcWEU?=
 =?us-ascii?Q?Als8TwuyJoLIgQYUC/SGsVWidnP1GajoHBfY8FMcZdYdwLu2/Sn5X/RX/JvP?=
 =?us-ascii?Q?Fk/8/gRmvUI6VUcLLhjB85FZJ25dnthQq8QPpFohVup2Yln7j8ER1TMcpUiv?=
 =?us-ascii?Q?cP0UHqg1FW73UOpJFfzwzU/ktKGDnLyeUpOml7eRwFM6wanK3QQfiwjAYIMG?=
 =?us-ascii?Q?Trdbw+Ws1m0lqQwK+aKULgBH6Kq85hVYQxi5kTI82OtZJWFFAXXZYnTDopPU?=
 =?us-ascii?Q?lkNDJaacZ4GPxCi07+/fQnsS3iI92VdoTWeVJ0EKZEvVk9TeJzCQEzKuq/xA?=
 =?us-ascii?Q?IK1eUPmUNISn77MDqsUDP8q8mYCX5osmqMsy8qz+OW08Vuwd2Iqsoet9yr10?=
 =?us-ascii?Q?o41EsYBExH9PqqxJFuTgIgB/AWM+WfO3MRyrW2f67/t6cly4lDy+7BxJR8Ks?=
 =?us-ascii?Q?ayI8Z52/ePQ37wd73aQk7l88OSkIsFIedJkAM+G8gaTlyFs/JXc8GbO2LA4h?=
 =?us-ascii?Q?7/2V9qeDfznSROPU1u78neFAiVIBLMgUeWX19BxeeDw8OCGVN0r3JpQRG7sd?=
 =?us-ascii?Q?yOpGVCG1p7v2Ppe/RNC0VrNouMnJSgANAT+XtQbOAnlrbTmJozH2YFb1mAwG?=
 =?us-ascii?Q?E2Vlg2keihN9cbCHJ8joXPoJXfWfZGCkxbpSQyh6WCoa4V8M3e/7SADrqo8f?=
 =?us-ascii?Q?4y3K5j3vVt8WNEvzeuTmj0uPaLaJNIG8JbQUjsYXyPAyjg3SrJdmB5B0BWJw?=
 =?us-ascii?Q?S4z/ka5lRxsRI6rADldGocXFL3uSJkORkWomr+qVirFmt0arXoASZs10P1y8?=
 =?us-ascii?Q?75Teb32LDe3N0ULUFL+pJGv7OTjxMuN/3kmL7B3TuTExfakcf5LUCK6R204j?=
 =?us-ascii?Q?ktkJIH4+w5Lbw+4S/9QuQcSVkPSOzKeqPGBRa5Aa5Iz5YLOUhVf7q1XkrpmW?=
 =?us-ascii?Q?6iGjYVN6FQ5wqHBBasV+7HGfZKZUHD95YDjOBRjLrjceMGfC1T+hBAnnVMON?=
 =?us-ascii?Q?FOiGt66gYXBUW5bvY1v+9Jb+o4JckqhSbarufVsZVwlOP8wX29DgCsl//ODQ?=
 =?us-ascii?Q?NM68Y0jiixzbSZcnYQrt6do=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1012536-5c98-429a-1c2b-08d9b2ee76e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 04:12:31.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMWZqEEtOGvkHU+YY35LkHax+k3X2nj6+0hUR8cZ686ErAxVHPFATYv8zhwGLWXa+mZoed06q7LppZT47sU7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2537

On Sat, Nov 27, 2021 at 11:03:50AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> +cc: Paolo
> 
> On 23/11/2021 02:23, Geliang Tang wrote:
> > As described in RFC8684, 3.7 Fallback:
> > 
> > '''
> > Therefore, it is not possible to recover the subflow, and the affected
> > subflow must be immediately closed with a RST that includes an MP_FAIL
> > option (Figure 16), which defines the data sequence number at the start
> > of the segment (defined by the Data Sequence Mapping) that had the
> > checksum failure.
> > '''
> > 
> > MP_FAIL could be sent with MP_RST at the same time.
> > 
> > This patch fixed it.
> > 
> > Fixes: c3b546f7292ac ("mptcp: implement fastclose xmit path")
> 
> I bugged a bit when looking at your patch because I was not able to see
> the issue on -net nor net-next. But then I noticed this patch is in fact
> a Squash-to patch :)
> 
> Then good catch to have seen that before upstreaming these patches!

Updated in v2 as a squash-to patch.

> 
> But then, I'm not sure this modification is enough: in
> mptcp_write_options(), it looks like MP_FASTCLOSE and MP_RST are
> mutually exclusive, no?

MP_FAIL can be sent with MP_RST in mptcp_write_options(). So no need to
modify the code in mptcp_write_options().

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

