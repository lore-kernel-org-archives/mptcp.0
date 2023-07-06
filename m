Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C209B7E6
	for <mptcp@lists.linux.dev>; Thu,  6 Jul 2023 08:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dylfFXYlfYtBBArTGZAUAj8LnFZtx4FIfZKuVYCVh/OU+XM9gHIo6Ys9vPZXWc2Xclbp/VCJEgDBuJd91YP3nT2fsn8LEmP3irALK1E356MwGhARFp1DHA76k0DPfJ09SitCO80zsaPP26Z3gnS3nc+sEnShniv8VU1oJsZbO3ZiYGStr7rdmmQzn8Zkg/Gy17WK/y6LVkznUcgAiG2TNxnFwhBvTQgN/jobgv67hwAZP+DWyPGtpoNdFntmGXvPksOgG9JnRJ98qLWFeEZKrRxqoIWQWETKP5Wi+WuDs+jlKf6JES2iEN2WCQPo+FVbtXn9dktvT/MtR2gX1sc7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH2UZ7O75l9ALQccRrGxt4jm+TnZhthPipty6sINT5s=;
 b=lRugTqElJvT3zyl3aoekgiiSEKiZwfh6ck93wQ+6+vaqC0X/YNf+VQyWFt5Df7pt2T4GUhX5dW3d2l2dxwIudIIMivJhgfcrFJkR1NdBlhL4qOJ23YoKbR26DQTDEU/yHdoc9czuh2sGdr70GqFWmEAhL0+LtkgyEwPgFmdZRtWFCf4ce6D5ftR1oxvzHArGvFDmBvJIfM+WM7+RT7lMxaPeOqenZwz3NR9YL1YAhxQwIwLJvy6R+9OWu8+IOYrYrWr5jLMfqewbYJIx23Kc1/BTbmbhw7Q1BaJt8zAlIDZ+jmjHLUs/OnN82/6HOPbZeJGKeamEjvCUPCuPEY09rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH2UZ7O75l9ALQccRrGxt4jm+TnZhthPipty6sINT5s=;
 b=ecLKGJG65GnLwKYYE9aF7vFhJtsn6k+/+mvIOyzllIQw3TRdgwEHMA18jaOUPwkwRo65TJLLfXoazg+kQ7VoWgLf6saQ7odq6JQqvZghjGnPRgWGFiyIpHA6xo0FJUpX4c1NdHjCRxiLfzpgZIUJRPy3TadrgDEsZTM80Mj3kzP2LOYMXMwkOm+CoJTzsCGMGUnI7lw2a2P/1DauUQpzqrf2JLQri36uNFABNBQfQjZ4zEdbB9LACwkOHWz9pY0xqAY2jPgHj27T/Pr9d6sfLi3lzgIxU8UPICqImVsFhggzzOlJ/J8V19j9w4xDjsB+N8zNeFBXuB1gc1qLDbkpjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7739.eurprd04.prod.outlook.com (2603:10a6:10:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:49:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:49:10 +0000
Date: Thu, 6 Jul 2023 16:49:21 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 00/11] BPF packet scheduler updates part 1
Message-ID: <20230706084921.GA15572@bogon>
References: <cover.1687827857.git.geliang.tang@suse.com>
 <0e153aab-5f76-c75e-677d-8a59ca4bc331@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e153aab-5f76-c75e-677d-8a59ca4bc331@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf07688-7d44-406a-fb88-08db7dfddd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DPXnOAxgrVoKgb0rVj1npparOjJ/lm38I7sAsHaCvi6YONmv7H/3TNS6vDFsc/Grokgjyul1G5GewLokl6P3gbqBq9/Sitj+8ex1e451U1ILTkUFBVDNUhgfGwbpzMT8ye4wDkg6XBN6C+fYWtFCiGOBjes0WepJb7z6VY5mFH5XF0fDnw6C/es/rNBadEeKwSG6iZu9HrItAIP+PlMlUFczvyR1YZIw0SdR/Gy52ncJmDA9pTmrTVz1FGR6xqUdbCIgVcZZ0ga7eT9zWf19BA6/gNUh8h88N55R8d9as2/1pX8f9iughrd3vPYHXVn8a2/VDIcX/N4n/icnb9OIO2ybIM36s0adoQm9Zj2eTKtxoLDz2jhEz1I8kagzYnziU8VsAyfbtw3SUCuN2UsrSMVUiCiPuYYpT4x9/6i68iaZ0UgOo5fAdF1+blfKoJoYD2/jY7QU9SvnYFa0U9Jz/m69ZbYHnzCXI+A/jVlKGLOr7gl5r/RP6FFiLkuwrL1vbjYtBeDuAQkPGHuwNeRTEym091vaICV6xkI2jCsYeIAJw9NCzo7gce+MQRCKVCfVIDA+25GS7FWViAfLB0TXhNjBrMVG4qhGmexgDi2mgh9ONrDjmWAmHdJAKVqBrZvM6XEg8xKISRYdzuxlqohUA9FcVX4IpHSDx6+PDxUihHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66556008)(8936002)(41300700001)(6666004)(66946007)(4326008)(6916009)(8676002)(316002)(66476007)(38100700002)(478600001)(83380400001)(186003)(966005)(6512007)(26005)(9686003)(1076003)(6486002)(53546011)(6506007)(33656002)(15974865002)(86362001)(5660300002)(2906002)(33716001)(44832011)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkLcj7x/9Sy2kFEzo8HL2fU3fIYOQGcOTYqyJJjVHCXIc5WpE9Sbw3rHLoIH?=
 =?us-ascii?Q?GDeKnNz/DnXNwCcf6q78IYVHXd9YepLuXup0zNEb/N5wk60ApcUx1Zb5IKbK?=
 =?us-ascii?Q?zbr2eb5CBw7u+jqvbnxJdjhVeJ8+/3sc2ApbD0/dpsG50Tv3z7C7m4Q8Fif7?=
 =?us-ascii?Q?JvGERB1VkjfAyXqxpHB+Ui2ske9ZlBy87j7kSrozgwHDillp3A6RxnvdYO6G?=
 =?us-ascii?Q?12Yi06PLiGiE1bAAQi0LP+rVTNPm8fm6X6BXni/UFK+TiWtUN/6LhYZgY/gy?=
 =?us-ascii?Q?Ehh66vSKHkDwfxY4zZzhJrWYvzrkg8Pfa92AAWslWJvFl4G78+lrk1P9LboG?=
 =?us-ascii?Q?q1iBkYHGSVhOdZqICtCOFs7lt+9Oi0dCKOntFnZuOG0uZ43DkYPdRafCXfIU?=
 =?us-ascii?Q?Dpb54Bx6ziqJWaAgsVHdA3FSMkv2MkoVM90059IwxdmAAwFRGtLNQeWHP8kE?=
 =?us-ascii?Q?AT+EdOy+iqqVmL6urIs57A43hbTttZp+scvY9DIG5tqRsj9fn1GMq7UQCHwL?=
 =?us-ascii?Q?HIl+dJ1EscSC7TEudBW3nJXeD7fWFWl+9cf2TkLtAdExKojzEUqNeyOeeG8L?=
 =?us-ascii?Q?Spvti1A6tPUWBjip+jelgZ5tXU/ey/A6mHi7gi1D7NupDek6NturbZEr+/lf?=
 =?us-ascii?Q?X2VmuppFesCWFGvKBjZUhyGswfw9y3C4LKtK2m+6iZdmQCStdwPPRTXY78rg?=
 =?us-ascii?Q?Ri4nJ+LvVcarvurY3gviheEW9Zhn1xPbXe2wddmNWbiuE2pUlYTXiW20DTN/?=
 =?us-ascii?Q?rSz07c4rK7P54EB9UDh1FcxL+qEXexSF1Cnt/OqkjmyDohCcyCtHupgBeM4t?=
 =?us-ascii?Q?axmd5xzyrlg3ZV8bZYK9WDjVwH5nl3Dfd3QAZMZMlqLv2gLw7OSCiYZjxFui?=
 =?us-ascii?Q?z4QhKOBXr8Cs+3Xb+LaLvjM5YDyqPzuYGwf+Ze5mQd9NMMjnAEE/HGFObpSf?=
 =?us-ascii?Q?iGJkCNlIXLnmU3Oyhu7RqTXVU07FpxlyKY59SKZVbHhOOJYuUjE4YZcoonVk?=
 =?us-ascii?Q?e7qtxI+lbeS1KE9FVghP3dUb1JPwv/2YRHiciQi2DycHx7BP7BH5GLuqpWaU?=
 =?us-ascii?Q?dWdzxu6Y9vOyL38EITlDu5simQcgmdIiJkoEukMHPPD7ZEfXve2Y58pFCV8R?=
 =?us-ascii?Q?uH5Eu/ODhGMqN0loCK1STMmqzmaKPhYPLxlKXYTc6ByToym2NYeEfjh5C4ML?=
 =?us-ascii?Q?RYIzZDPkdZBhEx1KvSdSTl0BQOE/Q5PazENRFxkMKEfXZTXTf7AklZ5R5Y0U?=
 =?us-ascii?Q?0zclRyKIqGLjrsi5yc4smrJ1tZc8zTi7qneS+7oQPc9j9oWidq1kfAKBPEez?=
 =?us-ascii?Q?BTgF9st7umLSxhuc1eJ1XhHRyr1My+tB+qznws9KawTUjzGlLs/bssUmkkB2?=
 =?us-ascii?Q?9gAKB8g95+or2PKVzvfJueHvux+Cxf6VWsOvj5zbC6dgQC5LmHDPeoTigxYy?=
 =?us-ascii?Q?8t25PkAQOsstpm05aEQNjLOUFUmZBzskKliJUZQbjh3mvI7S9773FJYvW29K?=
 =?us-ascii?Q?bCejxPeV3xuKxzfEzNSb+BDsywSDr4KysIlEN8qppirZovcl6rG/MDXQzPhx?=
 =?us-ascii?Q?KaCms4zNgynwVjQvvDKPTpOtx84y5S66f52Qoiow?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf07688-7d44-406a-fb88-08db7dfddd42
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:49:09.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szf4EcvYDd9mMxVMaEv3UzMn+8ifk50hv/fgePInsbvIyVETzlBkHhfiQJtLygvL/SMyvGekJJx5IkhokbdUbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7739

On Wed, Jul 05, 2023 at 11:11:24AM +0200, Matthieu Baerts wrote:
> Hi Geliang, Paolo,
> 
> On 27/06/2023 03:06, Geliang Tang wrote:
> > v11:
> >  - use sk_storage instead of mptcp_storage.
> >  - drop mptcp_storage.
> 
> Thank you for the patches and the reviews!
> > https://patchwork.kernel.org/project/mptcp/cover/cover.1665753926.git.geliang.tang@suse.com/ [1]
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/342
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/349
> 
> Does this first part still close these two tickets?

This first part can close the ticket #342 only. #349 will be closed by
part 2.

Thanks,
-Geliang

> 
> Now in our tree (feat. for other trees) + one extra patch and a squash
> of a squash. Please don't hesitate to check if everything has been done
> properly because there were quite a few manipulations to do :)
> 
> - 8efabdbcaa2c: "squashed" patch 1/11 (with conflicts) in "mptcp: drop
> last_snd and MPTCP_RESET_SCHEDULER"
> - b0f6d5c5ae25: "squashed" patch 1/11 (with conflicts) in "mptcp: use
> get_send wrapper"
> - 9de04aa46c59: "squashed" patch 1/11 in "mptcp: use get_retrans wrapper"
> - Results: e77e1cb5a372..3fcf166a9c7e (export)
> 
> - 6e930aa67c6e: "squashed" patch 2/11 in "mptcp: add struct mptcp_sched_ops"
> - Results: 3fcf166a9c7e..437c8b684629 (export)
> 
> - f7e28c2443da: "squashed" patch 3/11 (with conflicts) in "mptcp: add
> sched_data_set_contexts helper"
> - 9dc7c0042a01: conflict in t/mptcp-add-scheduler-wrappers
> - Results: 437c8b684629..504bc1f2d42d (export)
> 
> - Applied patch 4/11 with Paolo's ACK just before "bpf: Add
> bpf_mptcp_sched_ops"
> - 7f44744d88c6: mptcp: register default scheduler
> - Results: 504bc1f2d42d..d45b69d4109b (export)
> 
> - 0c323c5cc341: "squashed" patch 5/11 in "bpf: Add bpf_mptcp_sched_ops"
> - Results: d45b69d4109b..1b64ad359430 (export)
> 
> - 9ffacd26fad5: "squashed" patch 6/11 in "bpf: Add
> bpf_mptcp_sched_kfunc_set"
> - Results: 1b64ad359430..f95ddf57fd7e (export)
> 
> - 8f050b24bd4d: "squashed" patch 7/11 in "selftests/bpf: Add mptcp sched
> structs"
> - Results: f95ddf57fd7e..b1bfdcd53258 (export)
> 
> - a3eacd00bfb7: "squashed" patch 8/11 in "selftests/bpf: Add bpf_first
> scheduler"
> - Results: b1bfdcd53258..b80981f0543b (export)
> 
> - bc7512c33473: "squashed" patch 9/11 in "selftests/bpf: Add bpf_bkup
> scheduler"
> - Results: b80981f0543b..e1dbf174936b (export)
> 
> - 506feec3a419: "squashed" patch 10/11 in "selftests/bpf: Add bpf_rr
> scheduler"
> - Results: e1dbf174936b..c6edb7e5168c (export)
> 
> - 151a85fd02ab: "squashed" patch 11/11 in "selftests/bpf: Add bpf_red
> scheduler"
> - Results: c6edb7e5168c..679a4538b06c (export)
> 
> - 064c5746a0d9: "squashed" patch 12/11 (squash squash) in
> "selftests/bpf: Add bpf_rr scheduler"
> - Results: 679a4538b06c..255b06daaf0d (export)
> 
> - cebedb75ff65: "squashed" patch 6/7 from BPF 'force to MPTCP' v4 series
> in "selftests/bpf: add two mptcp netns helpers"
> - Results: 255b06daaf0d..cde4fa6a0a5e (export)
> 
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230705T090903
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
