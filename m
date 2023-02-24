Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2085.outbound.protection.outlook.com [40.107.13.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50115A5
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 01:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDzrDfjfHAXZmuwb7QrO/60rJTnyd8JEaCE7W1zqwHZJP1nsVIcOC5u5hz+YOB3HSEgfS+auqRLnwbe2wElcrh+1v250kGpKfzE8dznzztw359WEBdnYgbwwcil0AdC66VUx1u9zaXxrDPSArcqpF6uXK+h7LbrcebrYBT+Oo9C1p4z7JeHNALL9QEE3xWQq9s5/6+Nvn6zoc3BJtxKZQgNLyIWPxVlFJk/rQZbivwhP45oJyWlhxOD5CBMAcbbi9HPK0qzZwaIUxfw4VOTwphnGB5TmDauKrpP3QSpT2aqQs4oKmZN6AtuWIGQr8NyAMZcusJP3g6ZRaAbfsdnUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LazlL4zMbYdDnRIGVkmaNPglJyz8Q6gohP4F8Mfgob4=;
 b=BRBhEUQDaooHXWBfGO8fV8Ad0bbaIvzZkjlZ1Yhv/i1mVD3/VC4bxQV4KulnjNb7Sw48FrD1B5215uitO2Xa5EYaC0QEwqMaRxDJMeQh8K31PD2GpNDCk78hOoImkYAbSYHm8GziovPeaf9nVQzyctO0gKy7t2+nhd8aER0gcB7Pk9zk3+RGI1aEqxB1/S7JOLRpo5Mim39+N+ZLZpuGchXJXXuWDI2JDRoyRukdlb4xl0nhNn+p4mentoMhWI9FSGKb5WXvivnzJX2YgJvjDD/5/JswISLMTwx7DHfAKUutDFf+n43kO01OFIGONSAaYIZTUsyj5bM0wG7MOZdI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LazlL4zMbYdDnRIGVkmaNPglJyz8Q6gohP4F8Mfgob4=;
 b=Iexya2ZzIu9u4VAJR/k5ecbuIsslZ6PdUSYr4cWOCcR7si/HJJJB7IE8uJSOSC+CuNeXM6KkJxgULbKJllWkAKQdRJyKrabgSPXCwIUOZHDp7bfKc58v1d7o/iuXhG5k4zsunslAKtGZI6a/Fv2qiIKEV9UCds1lBJh8JRaDLF+WyePyi9YNwDSmLVQGAjEM+jao6JdQD2G07kMHg19aQAxKJpkSs0YivjcqHeZQST1MAX3nnJbxLmLUgVm/wSKIpSrPlIty7gHQ7WdUQHV8/3tKIzaR1MQmzyH0BXx7e0Db8P/B4De2MXSnxotItCOn6rNw8lBC8StqRHL7ZzkR/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9144.eurprd04.prod.outlook.com (2603:10a6:20b:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.20; Fri, 24 Feb
 2023 01:28:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%6]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 01:28:21 +0000
Date: Fri, 24 Feb 2023 09:29:20 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: add ro_after_init for
 tcp{,v6}_prot_override
Message-ID: <20230224012920.GA2968@bogon>
References: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
 <4ff31862-96a4-53d2-37ce-9fd69c38c7ae@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff31862-96a4-53d2-37ce-9fd69c38c7ae@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f9ccfca-0404-423a-a40d-08db1606699d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+4Aemf08uF3dkKxJTPWON9Sb+AATCTijE+vYONfh5ph7vJ4ATnkMB/U55x8ioFK6DqLb0YxqlKWwg6PhqvsF6pHxCy5tBxEFxM0lGvhsuFI3ryFCJtZcFfMYBX9pcYTDLnOmphSQLCB9SrEVoQDLnyHPM1pu0XFisPiahf7+90DFfv8F6LLWdmvQRB6atmJznm0ZYrYwYboZ7Brf30+bQBwZeVcgEfLyh1gzNm8kzkQ6r8t1tzTr3MpnPv+GZ/xM3fmrQPJJlnLzDh/GjjPQ2OL7Tvna1ifmcBKWATIh65ikD5a0VwR1/lPhiy3L6W4WQxfPZxZ/AxqyRXhA87BzWjcxLjDgcTEIYafsdfpnYmUzLgwFLzJ+ID2TbYqqS0orRNDE/HGporbBdbZPGeUwjhck8C0f7ZhfcvULL3Chr21Xoaq84lD8QOhNeMkPPiqDdZlN+itXxhds1/RzcrK/lvEsAxYd1tQypCrBNzS4fPRPEjJH6BSuDaN92JKiT3x1eg7ldtgOkerjGLcFIwjMdigIJG6aJvIikdG9J9Ph5YWGt0miDpWejPttFW+HyLWDTywXgqdxm2L4jOB7kILoTXYoMhHIcLi/W9fuGRUzTCLbOVXd5PVVVCOlOzcRFRBzWp3+tcA3kHKuf8PTNR6fjp+imWZpWV8lSppST8Mvk6XWbEK+3ydHiHIsSuQFra2yQx81fgzxASVEz+LFfAWizg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199018)(44832011)(5660300002)(38100700002)(8676002)(66946007)(66556008)(66476007)(4326008)(6916009)(41300700001)(1076003)(6512007)(6506007)(26005)(15974865002)(186003)(33656002)(8936002)(83380400001)(2906002)(6486002)(966005)(33716001)(478600001)(86362001)(316002)(9686003)(53546011)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eSGQuOypR5utWUX1YazzAhgExi2VnRGwGgU7m9fmZLmOE06sTDeTwbat+9RR?=
 =?us-ascii?Q?HELl6DrSbdfolDyMH8vQDc+f/Uknmhv3eB2PuXd/toz2X5K2jLuGwY52Aeco?=
 =?us-ascii?Q?boAi4sW9pPTa9x1IKU2xdcvmBNDpkfWgVMfZlryG800Yk/qSyN9AJcK+30zb?=
 =?us-ascii?Q?y2sqtYiOZH22Bu/QLJlxJDJcvUjDO5OiCWo/eB5zrD4r0fzv/LUJVbP6Tk6K?=
 =?us-ascii?Q?xa3jNpYGNFTXtpiZUaebzbBIwflOWSdSjZ4YoLH6nPqfno1sC6LznlPrngZH?=
 =?us-ascii?Q?rJlaSePMd/9emh60Q9SS/2bivINOgqkowMS+Onc8IYRO6dpE8MC+nES8jlx1?=
 =?us-ascii?Q?MEuk/VO1YgMZAeqGE9V0EMKD0ituKh4H1vTHFMocpvP4EsN6TOIy8sAtG1ue?=
 =?us-ascii?Q?T9Ryz4a5XD63Nn3wFC7Q62TWDTwTFFTnLCqFygHLIMk3gSnrGNs1SQn27qRX?=
 =?us-ascii?Q?16N5xx6zJNalX9QB7X+tvpZz8ZlrU6aMXOofJOgzKQsuu/y2aBLfbzhrt6ir?=
 =?us-ascii?Q?YGxECCvOtSjyXgNx2AjBbcdHWCwLQbzwoYdTaNmFU/r6BXRbkJ3s4SQkdacV?=
 =?us-ascii?Q?y9O3ir5tskO/mpbEJ0rWObG633dyR7JyvAHXLgyF9EwtHD8ql4tI8tXVi1t1?=
 =?us-ascii?Q?D6h1daopHu8dBUAH/g4BFYglD9RXTH1nRTeZ43FniG26fazzpKFmDSOSQq4Y?=
 =?us-ascii?Q?DswE048fycfrWqob+gmrz1VPUUZzB2Zyt+ro/4XDwaS6ZQB07oYGVNYdhv4Z?=
 =?us-ascii?Q?SyWs2+SdNJqDm5H4zdzAP6DX2VyhC1TFHoJcvB/v6kAfyAemjIhB8nG2rZR7?=
 =?us-ascii?Q?+jbOR8rNaioeLZVWfby+LizJmcR9f6m8oY53IMUByPiQBOwPpI+070EIaULK?=
 =?us-ascii?Q?vCGkiBVQGHeMJFEFcrmrxtiMlx/0x12DnQBnxpib0x/zji7aiRyfNZ+eqDix?=
 =?us-ascii?Q?lxf9B+QVgVcF5zS/YU3e/w0VeSCzUy1/J/0E6WBYkvh5fY9GjW890h2ty3ZY?=
 =?us-ascii?Q?7LAk3MxDIB8q4fNY8IMKWehQ/tzZGU6PCP7LmZQoMrhhA58HPnwt/9+lgQ40?=
 =?us-ascii?Q?FO2XMJZI70I223DjGinLfdpt2+tm17R5w7IAgWLCGtNgsNLM+GjQVpEfp+h3?=
 =?us-ascii?Q?+ZNSSnpGaGjet1oVaMyPQ/QA78c5nTFJDc85hUNf9j65KxD2UKlTIAL/fsg1?=
 =?us-ascii?Q?NaCWNFGdb27g7CJ6L153o0hAUXT0Mt5Xss3Os/KPL6gRuBeX/ZNdZvdYIJkD?=
 =?us-ascii?Q?IXtV3wzILlNiriU6vSdvWkXgMH+kkAAWBesme0t+3oDvd/Nfmixq9qg6HfrU?=
 =?us-ascii?Q?r2pgeJEozo5m0a8ZHkU3aJvIJKKIkxsVPfOscia+Pj1Nk06iue/jkAyczPmU?=
 =?us-ascii?Q?JXZ3DDcJjcIpahZPOkTKWtOCLMgUPzG1De4oLCMYLpjQrou66XkRzmWtimZe?=
 =?us-ascii?Q?vhglJ3lm+W3l/xQf0cECUsxWWZnpxDqkc/HyCke5wCg3xQv/7TMLKcS7jkEp?=
 =?us-ascii?Q?Un77g5XzLIYPSp4lowiNkX8PzkBV7zAmWRfk684s6pgOvMYLFA3o61lGZEEa?=
 =?us-ascii?Q?CbChY4vo396ysDriZvpRp6sMWsvPhFDmL+2G0RpUOJf2c13bu+nkE5bpAdWw?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9ccfca-0404-423a-a40d-08db1606699d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 01:28:20.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHLB+EI/YdGluGg7vCbIW6QprAWsWbndTHEUWn44hxtkaur69g09GXNfjt7izag6bdffoK8grxoeN2MuBHLlfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9144

On Thu, Feb 23, 2023 at 02:57:35PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/02/2023 04:37, Geliang Tang wrote:
> > Add __ro_after_init labels for the variables tcp_prot_override and
> > tcpv6_prot_override, just like other variables adjacent to them, to
> > indicate that they are initialised from the init hoos and no writes
> > occur afterwards.
> 
> Thank you for the patch!
> 
> Now in our tree (fix for -net):
> 
> New patches for t/upstream-net and t/upstream:
> - 14b7f49f8c61: mptcp: add ro_after_init for tcp{,v6}_prot_override
> - Results: 32f1046d667c..2d0e2918d1a9 (export-net)
> - Results: 7264bacd3544..e438a165544f (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230223T135546
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230223T135546

Matt, you forgot to help me change 'hoos' to 'hooks' in the commit log.
:)

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
