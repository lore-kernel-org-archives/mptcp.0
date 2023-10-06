Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC3E540
	for <mptcp@lists.linux.dev>; Fri,  6 Oct 2023 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J9vA+Gm2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibCAoI7lGZzBhMLbaG61LnIomDCCFAfJGC9tDub/IwUsTw8qiCepLdLhwNI3MmVW51ye2FpsDkZo+yFw9+6UBYf+fXYLWASO0q3Q/x7DCVeLN5sthlXppp1rZ1Mp6EzZC7NZs4bPjMUr9kxYTUHOhoG21fl3ByD66mwJqIToHg+cr65PBnccqYp6fWGlX2eEgf0p0Muv/VFVlrCP2Ac0PAL4Pozr1eVuxlMWzflazgFxvVWL8hoW4gi/w3CaetVOwsAU29Gj+ZtKEzfch9EfIoUwMHJ1o4SmgymSc0gKRRGLeldUn/Wqb+s5UWQAb878kjilFjKNOPxgXx/HYDmuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t++wE40/rNYbsL/yVXdO0jCHWCAqY2ksBsk4OUj8Ses=;
 b=aHvz0Fv9+HJgDkdyaDgjc7BsvfXES7shr6r0GqUkMWW6X7JzcTVT/F26aqqFi2FnOyzA+b3zUxEMhx0FKza5sUPVIhnnjDUsEUveeSsoWhZ2GlqgEvpZagawyEEN58Q9rjsoJ1ZSpg/X/3FmcdN3dPsnQ+ZniQzGZQ606bAxxoP/M4rbAEgpK05B7dxEBq0RZpvm5nWPQkOSPcZYXmjIs25UhG8Lxu/xh2wxW5jSDajms9XONbi7mphBObqLuPY2xt4FOYMvtkXZcx6UlLHhd5HDn0oF15bN8wUkud9UZ6cxO2Cmgbdc+HgEGWFoxvTPqRYXil6HHAWt6Is76Z9oRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t++wE40/rNYbsL/yVXdO0jCHWCAqY2ksBsk4OUj8Ses=;
 b=J9vA+Gm2McLpvakTr/+vkp1dFzTDqYmyGhnBnJTSHS956rwCBI8l4NfUsurxqqiaTtSi3flkJL/9oXq+GRswR6V8eQoOs5CAv1NPR7G0HqV3SZ3oT8ydkCKugh+1Z5ApL8vnFJdb0P/WttVKXuzlkTelWORWf5GSjuGzSeiamyL0e/XPaAC4i87Xg5mbD4zbW0zwT+AEPbZYp7orSCZc2wViA/6Nf7pcHmg5n2QLd3Vt5qMgZy18G1JghBz20OiQtw3Me4FfgR4pmzx+/9unvU6rnpjPpXcmWPU/0xoWubD10fNzG8borg2UGB4iiEJAgngushUM0A+w8uof/cb7zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 6 Oct
 2023 10:41:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Fri, 6 Oct 2023
 10:41:39 +0000
Date: Fri, 6 Oct 2023 18:42:53 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 00/29] userspace pm enhancements
Message-ID: <20231006104253.GA14749@localhost.localdomain>
References: <cover.1695631132.git.geliang.tang@suse.com>
 <4faab698-f464-43b4-91aa-19177a0ee77b@tessares.net>
 <be43e409-389f-466f-a77f-0b24e29cb4f3@tessares.net>
 <be741cdb-340e-403d-9cd4-e9b8f5e5dd6f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be741cdb-340e-403d-9cd4-e9b8f5e5dd6f@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0238.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2bf433-1713-4b0c-1a29-08dbc658d175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rR1Et8VHBr5BYSvzzHnX6ChagAhExInKjBhbYZijexPwtoZbHXHmcAIKJ5QL0jcELYnW1ZZN5buriZ3nqXkPXvoYCIDZy6wCqBzIk1xmWT2fxDVY31WEHBrp0WWqiwHrEm1HDmBkb9s+rBcajmyLUiZYT/uKE+8WqAY/sfgnulb/WovCwRbUV3NGg4NAsUiLC59K2eS+7HGMTLzRNzLrZ6hQWmqpgEKVzDk9A5lLxHEktE4sFDnzW2XeCBm4tEGb166Iz8sxXUSeieYptQWx1K4IBYHA1s4kvGX10xa54AMl+SRjm9uW7DWi4+kxJwu6HykVd0Fa5/iS4FNFDjUP+ZaAHnGfnhi1NthWoAaaKeYdd3e93GHYPbrUZyewKlKBRvQ2XfqeGVRAglo4uy2HKr2mFmIMsiJUh7fVlArNmYQApP+dltM0KAqQCmZgV+y0iFTt/GUhXMWIqi4kNZ4mTgJVs8CitR+baXzgBIYe7jZsyuJ200YDlz19KOOK2S0SQqTFzG7uu+d1z371eI+GjRb5KL5IMkunuq0ygA1jhUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(6512007)(6486002)(966005)(9686003)(53546011)(6666004)(6506007)(478600001)(86362001)(83380400001)(2906002)(38100700002)(44832011)(1076003)(316002)(66946007)(8676002)(33656002)(66476007)(5660300002)(4326008)(66556008)(6916009)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1bWIKi3GZFixeyGC/7hfUhOA2+xeS+hdoGwbY2UgkFiBSsN/UFGYnd8HU2kd?=
 =?us-ascii?Q?tBi/Xr1nJZ2xTCvgxF/Fg/lK/BIhyNFutnUDZZgwHrtmM/VnmBNV28+mHSLi?=
 =?us-ascii?Q?9qMZ88NF1TRTHZ9YxAtQLp0ssEKt6KCO4wb8aaM5dRc5ebUIESzvPmgo+X7j?=
 =?us-ascii?Q?Ed27kRUqfN600gL9292ry+W6GCyFBlQhkzdRz4AFb52y5vbTue4easXthyPb?=
 =?us-ascii?Q?uK5BZ7YGBOgy0znUigxp2dKP7bX5KA7KSqO8H+yZOVMR2zeJAd3X6ZsDdiog?=
 =?us-ascii?Q?qMlN9VFRyc43ixaeQNlqZzfRpmEom0QXf+kVoPlCCAaTmYJ00npRaBkNVqcR?=
 =?us-ascii?Q?ZxwrW7oQLbawZ6gFYXjhVeMGILMFDBPFerybe2eTK91dygR2UQSkgYGkJS3T?=
 =?us-ascii?Q?zSAzBdl63w2kbm2QXd/QPrqqHcHjtyPxbjbiOU+YP5wopyfyZgrBs2NfhJcl?=
 =?us-ascii?Q?yzUeiFBR39EgpLIjjZpFXf48A2iP8ZE1UXCofmqe/mowRVKAIEzrcr4PmXfn?=
 =?us-ascii?Q?Wk0soQBEU4wGWtIyDyInV/fvNTyVqoTyiPgq/umuC45G3d19exmx1SGd0078?=
 =?us-ascii?Q?R5ROPzgzyfMP+iIEmwYUIhoapve1VcFaUp+IuMonDfxkPUJOv2bVCXgX4gr+?=
 =?us-ascii?Q?TxsWs/vsS4xIIEbdhKpy+iwfcq+73UQQQnta4KEmyICFzeD4wjNBOCK9rcCQ?=
 =?us-ascii?Q?msyZ6hv9TNxhhbCeI/HuynOxmN7eSKh8CiWgORYCLYi/cFRiRIfaPtufIxlq?=
 =?us-ascii?Q?INxO6RD/BqqykfaAq7Mze4x6MlB/hLs2JjIojv/LjrkAApEnCFZefDL+Eq/Z?=
 =?us-ascii?Q?LUpq3DTC2DAv3zRB3xarXtg28FvUwc9OVmjS5507bcWukIDgr7tHeV7UHbOA?=
 =?us-ascii?Q?uewHxqXDY1iDgT3VaWusl8jTAnI8fdt3SImwnjuWt+5+3itYCcisLxmg0j/2?=
 =?us-ascii?Q?gGV8GSq5f0Jl78hhpweYyp8Sh+hEHQWGiT7xPnbiV++7GrmDXAkmEMDwddp+?=
 =?us-ascii?Q?uEsya1QAj33idBXxi4OpKUxqXpk7N3X+DuY0yjnnJQt0kr1sh6z6Ufwugk3s?=
 =?us-ascii?Q?+1iKxyYn7j18dTaRoE2padWSsSx89TDMIgPoWFOl+0RBKxATH0M7awUvs76d?=
 =?us-ascii?Q?CKMl6kNOWMHi3ZbSK5EUpvUKcdUPYM6aRkIVCkSgv5Tv6YrvMIkuT4Nqbx5u?=
 =?us-ascii?Q?CyRX/yvSF5CiMW90cix1Qb9xk+/2q8WMvtorl4Ay+sSekNS4bXHC1IFJ7zx6?=
 =?us-ascii?Q?RakTGTRQtp/9bndHBiYEL19txbOcDwzaZf9GZ3knqh/5bz9UR+FmdkfilR00?=
 =?us-ascii?Q?tv48BedKSTjxgChbr85U3bBy80b3v9wpBuIEVGRBdAEVJlnQ/PAW23vtKWwj?=
 =?us-ascii?Q?cSWye4irF29cOcxBXI/V8Zyjd6690Alw4P3yVkbXu4T9Kf++0lzH1+aF7M2b?=
 =?us-ascii?Q?Gt+14P/rX1UCFzoWdkXwlwi5gPB8jC/l7PO11s6GDBbvsYbLqAS9bomo56H5?=
 =?us-ascii?Q?43UnInLzy+T7wiJuKeflWxZO4+O/Pudp8OeQucj3a8A8oJfa7gCrxgr/fm++?=
 =?us-ascii?Q?8vK5gni7bGkQAcQBprfAW5WFEZHHPVSncoMxjeX2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2bf433-1713-4b0c-1a29-08dbc658d175
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:41:38.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCf9pmqjDeyu9MvimcyGqZoMWXr5cvOm/Rr0oIDyiL1m6JUEl4712/X3E/+89dU909AZPFdrXJ3c7WVag6Iodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7173

On Thu, Oct 05, 2023 at 05:53:13PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/09/2023 23:37, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 28/09/2023 22:54, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 25/09/2023 10:41, Geliang Tang wrote:
> >>> v3:
> >>>  - drop patch 4 in v2
> >>>  - invert patch 10 and 11 in v2
> >>>  - rebased
> >>
> >> Thank you for the v3! And again, sorry for the delays!
> >>
> >> I think patches 1-11 + 13-14 are OK to be applied (with two small
> >> modifications for patch 7 and 11 that I can do when applying these patches):
> >>
> >> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >>
> >> Please note that patch 13 will go to "Fixes for -net". Patch 14 can stay
> >> in "Features for net-next" due to other dependences.
> > 
> > I just did that:
> > 
> > New patches for t/upstream-net and t/upstream:
> > - 505a33d76a32: mptcp: userspace pm allow creating id 0 subflow
> > - Results: 05758f924fe3..999b9f7e47a5 (export-net)
> > 
> > New patches for t/upstream:
> > - 1cb016e94837: mptcp: drop useless ssk in pm_subflow_check_next
> > - 450deaf6dd71: mptcp: use mptcp_check_fallback helper
> > - 6df74a0ced73: mptcp: use mptcp_get_ext helper
> > - 03649553fd68: mptcp: move sk assignment statement ahead
> > - 6bc1e5144525: mptcp: define more local variables sk
> > - b7e3cc69d9fe: selftests: mptcp: sockopt: drop mptcp_connect var
> > - 14c099dbd7a7: selftests: mptcp: display simult in extra_msg
> > - 7d9e508e1117: mptcp: add mptcpi_subflows_total counter
> > - af6ed0819599: selftests: mptcp: add evts_get_info helper
> > - 9177dc0b474c: selftests: mptcp: add chk_subflows_total helper
> > - bc1edd827cfa: selftests: mptcp: update userspace pm test helpers
> > - 0dd61d4e14e8: selftests: mptcp: userspace pm create id 0 subflow
> > - Results: 3be1c8ce544a..516baae7a220 (export)
> 
> I think these patches are introducing regressions because these tests
> are now regularly failing on the public CI:
> 
>   - 112 - mptcp_join: userspace pm add & remove address
>   - 113 - mptcp_join: userspace pm create destroy subflow
> 
> I didn't check in more details but I see they are failing since
> export/20230928T213439 and only when running with a debug kconfig (slow
> environment), e.g.:
> 
>   - https://cirrus-ci.com/task/5444189572300800
>   -
> https://api.cirrus-ci.com/v1/artifact/task/5444189572300800/summary/summary.txt
> 
> Do you mind having a look?

Sure, I'll look at it.

-Geliang

> 
> Maybe the connection has been closed when looking at the number of subflows?
> Also, it looks like the helper looking at 'subflows_total' with older
> versions ss is producing a lot of debug output that can be muted.
> 
> Cheers,
> Matt
