Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94F7A
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645656940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UPcK9xduegV8VsNCeEu0Lnbu/c6aYO1aNnrjOwF2WKU=;
	b=ABQfHbrwO3uj/BOK+IcYsq1kv77s5OBcP8Dd7w1PMSOvwwrA57Olcww+QiyInBAXFMWvcl
	rByGgmuLJ/rFRf+gWOxiF6mrbZXZPNp56X6qVjcMhprS2r9hKhU8xIphNUSG3y2dyYS2P2
	Ovb7dozK9YFPsVY+FextZXb/ExkClmU=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2054.outbound.protection.outlook.com [104.47.5.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-mfA2qlSUO-iXLle10RUzZg-1; Wed, 23 Feb 2022 23:55:39 +0100
X-MC-Unique: mfA2qlSUO-iXLle10RUzZg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FML4Q8GOLroYoD0hv6xHgKCasi0aoCojXIYWvFBotG/5OyJbTfKiM1dnXuadBJK1RS35yBwS5RHIeiy4BEYtgIr6PR/ctZwe8CM3P1YKzjhXeG5dOotLGAJPcqZxTXOqqMnVOWFoyNEZ0SRh2joRem3uSiaWL/NJ4JUV6lSFShVJ7RwFZrHH7SOCUId2ddMFvty4fvfsttJdRtGWleFgIcQALSKmeEX3OZ0lEOdQ9cyEbDKuWiDzBlhCRiipD3Huk6YfnWPoSnR2sIFWw7S00e3YFBvgw5XOszSbzcGyaJNj7WT0jsqS3c9YJsOcGeVcNF3QIsUVUyYDqIQYPEJ/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPcK9xduegV8VsNCeEu0Lnbu/c6aYO1aNnrjOwF2WKU=;
 b=PklkptVHLKObiyIRbILM1mXP4CN+PrzX4lsQ4i0noFwnqW8Qn5X/HXuJz+lnOErXBCH3aEPhVqj8C2DcpkvWQHxCafN2kN6MOsuZZ+vDUh5QcJsuo5+m0WSksne40p4gLhs8yNbvdOJRtKVKhyonUAQKZcMNjbxeuo/cM14T2z9X1OLEiN5u+qWrV60zyFALCXIlXbUzJ7XK0qo2sBTMr+vqdQXYx8zmvqKIBAvbKM5+teU9eHxs/9UjbYR1Z6IGCf4Y5H6C78K78VEgH48+YgZtHnA78SmmTzytBxaVla+Vnx/iSD1jxkklcb65ORNdUBJD40S9eEUwi3YJvk4TbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0402MB2788.eurprd04.prod.outlook.com (2603:10a6:203:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.20; Wed, 23 Feb
 2022 22:55:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 23 Feb 2022
 22:55:36 +0000
Date: Thu, 24 Feb 2022 06:56:11 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v2 00/12] fclose and mp_fail testcases
Message-ID: <20220223225611.GA9540@bogon>
References: <cover.1645325178.git.geliang.tang@suse.com>
 <95c31835-f6e9-ff75-0f9b-2edb78d8e455@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c31835-f6e9-ff75-0f9b-2edb78d8e455@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0210.apcprd02.prod.outlook.com
 (2603:1096:201:20::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f243bdeb-4160-40b2-56b5-08d9f71f9af7
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2788:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0402MB278866A72F469AE751FC55ABF83C9@AM5PR0402MB2788.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hYumHj7GddgzmYf7hALsTbs3V3bcY4Ic3HPkvyb6fJepD0fTm06FOP8Okjc78VZLuEUYIkFEvsVFh2YUTecaVB3WpqxoOyVVJGEKBYlS/vUmXVrBkT7ODRGNJ0T1K9GsJl8PJb2XhE8H0LejDgyw6pFru3FnTs3zMCmowtbVDcRGvj5Oi2ZA2y+OtzXGNJ65lKUXVdyxF2esueEJTBvV3XY7sjSgCRHO82+XnkbTujmzdMmF6gnUM1SvCUabW5gtlkTd3Smf+KMvwBFvfpyxDqYap1k8+lyDY9sK53rI3kvMc8Rjtd/0l1Xzewke3GgCvEI4m9cX5Zgvdv5h5CBsc87if8yn6apTFUUJfiEdjik42SYO8ah8qX4ki42hbL7sQu7ElSOrBp0LTuCHO2uzUBRZ/dKhsiIjwhABdRXE5NqsnFXklnSChnciLAYzXaNJnMtJI/9R0VgGuGVqqKSDe8VDTmzIj9wXHipfDrBoCAdat4P9zg4OHqR+VV+hh83xJ3knLIEnIZ8b80yZurI9rjI9VxhP86RlPe6PN9P5RsUivlEoNkTdc5/8jIHVQF64vqb269hHnCXSODLRNjhLo+TS77xCJD4OG1KqtCSRsglQ5weCONUd0lc3PcGlYd4cmY8nJ3Gq68U6G8uN5XwT+qg/4hpmGJYe3gAlZlWdDUySp8K1xLkowGCbBGtpxgD3xKC1XQ6oUwSFNNrEJCrZKM56Z9Dk4alK2nD7M6GFnAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(8936002)(6486002)(110136005)(8676002)(316002)(66946007)(83380400001)(66556008)(508600001)(66476007)(4326008)(33716001)(86362001)(2906002)(9686003)(15974865002)(38100700002)(966005)(53546011)(6666004)(44832011)(33656002)(6512007)(5660300002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wThQhd+1iBezN02l23cILaY5aBuwNiYjfhj1L5upmF7zDtuVKoMGuv3DNevE?=
 =?us-ascii?Q?zpBacryC9bXKTFY2DZPH7vkp00AS6B0qm4k/gQSBFgIJGpgtMtDcOk85PFMs?=
 =?us-ascii?Q?4bPkj3vclr8vvEpxag/pVtXXg0nmQ3LbVG9QmbW9UL8lK4azIgaWMnW0Oq/Z?=
 =?us-ascii?Q?hLTGIz90M77X2iB0A+TqCz5nQWSMvF1YuATXoFg4v+Tp5qyXwx6z5QGOs3d1?=
 =?us-ascii?Q?T1FkiZRuELhybfruteer7aihRgKAR50b0AopZqDl2D5NBTjfIq9bgvBfcDrn?=
 =?us-ascii?Q?ZlIn8vsjBbvaUdp+3dy2i4xL/X9Zz13ssK6EJ5OlFUNB0CRBeniM+LFF1EbC?=
 =?us-ascii?Q?cSyJjrFJDetvd3Irot/jkQaZwlo2+LJqPDHp92CTiCkCxfGa1YKewEcT0NBw?=
 =?us-ascii?Q?nohFnusm+o4xFOiSmyzNEHegan/FZ2kx3tnFts5Z4ohvpyUHcx1rXDqDSHoK?=
 =?us-ascii?Q?SaEcFqkw9mnECsJ0s26Jy6fZDuKwyL6eICWlvAL1ikAAul3ZOBm29y29Uwhu?=
 =?us-ascii?Q?f/wj6KXeCW1etSssLGTfBB9OvHgfdDvCdMszRbo5G0ut2Rlr4HiqgO99scS7?=
 =?us-ascii?Q?sVSc3YVoGWyswtBSVxrJNY6WHOxRWPY2P6ekk0RVSW9Ur636T6u9cD8cnzHx?=
 =?us-ascii?Q?rD+eR3hwDeG0gjLeP8eRBTp5xmZ9z9jYAfwSkKWRy5S8NxxOChyNzmUS1oJN?=
 =?us-ascii?Q?X9uAstyBICTLbB5JqcEzWqq/7ryYgV4pErpf5fdig+7+1fyd91x9S62Wt9uQ?=
 =?us-ascii?Q?XvTAVdLTSLRDLrS+zpQRiqXM9K2o27uZkXnh7UYMMTuBYv6gJm+CRB0YLCz5?=
 =?us-ascii?Q?jxGwXN4pxSehITXmod0YUOT8yHZLeHpIj9i/b81IJg9bRhrsvXxtqiT0OrdR?=
 =?us-ascii?Q?MiVU/NS2tRKKyLqsmi6wiJchQuuttci8dECO3LzWfwuWacokGOimN4BOS8+r?=
 =?us-ascii?Q?ubrPX8fmAiwxfHD8oRj2Xu2ipP4H0ENgEkbuRHb5a4UpLoQHk0RoBZXWV55U?=
 =?us-ascii?Q?1bIHtR3LlX9ih8f/Aa1vSrm+Mwqwy5db0yi0b2iEbd6TDzIivcVSWKzQ4E0e?=
 =?us-ascii?Q?vAQ7wIQ8ODaMp2EBY8TAhla9jyyhez7ShgB9jq5a7RmcpPlB1yFGUks2/cGt?=
 =?us-ascii?Q?gVnJlFshWrsfJ5brjYGkXjhHL3QUh0PAWqFvwcMo6eBbadVXgbbZvx0P0EO1?=
 =?us-ascii?Q?043yYZ/OeoBDw3BKmIAkyoQsfWLbnLRaCcCJVfc6OyXHI6Y7oMiZUfLEcnjx?=
 =?us-ascii?Q?UR6kr/0qlxE646/Dh+eqKCGHUDcbiHdBEYnipjm+uf68AXdm0NJ5YMiXJu5z?=
 =?us-ascii?Q?zezA1EpS+7V9zmwNYSHb3wuwGvlrseank8vjUWHX1YHKv9iZqOLWQpd5/l38?=
 =?us-ascii?Q?IBPdpf/YU+El2SdOwFwkjV28Cy/vIeNSuRuK+aKrnLbgw566BTnK5utkRi5o?=
 =?us-ascii?Q?rNdyQkve1vakKTHC6ucYfInH8D39NvJMwlMka9h95RcRItCrtE2W6j9HjWmM?=
 =?us-ascii?Q?eSmBnyhoDe6DdbMdBLsuN9Ly/TpU3pvir3Iqrpkq7jxLsb4oin8uxQDVS17K?=
 =?us-ascii?Q?RdXhazKbkc1znXGWfXWZsPhluuMHYZLwCDKHx4A5vNv7KWzvBWpp2fv4lpfM?=
 =?us-ascii?Q?yeqvuPzRYjULlXufBVjdQcjCW8K8DAINsRqFWd7pbQt6E3rr8JgvIw+97dEk?=
 =?us-ascii?Q?6slUbDz/0smMbD+ENl61j28ULbI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f243bdeb-4160-40b2-56b5-08d9f71f9af7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 22:55:36.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DfL/NQVAcQvpJHzF2r4J5WkCGa1lrHlIoqLE1xKb729xkeRK5CgvCkEBnOGQnh3MZNeH5Reu5IZ+qOId7laBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2788

On Wed, Feb 23, 2022 at 10:01:27PM +0100, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 20/02/2022 03:59, Geliang Tang wrote:
> > v2:
> >  - keep the order of the applied patches. Drop the revert patches in v1.
> > 
> > v1:
> > Resend all my queued patches in the patchwork. The sequence of 4 applied
> > patches is adjusted and rebased. No code modified.
> > 
> > Geliang Tang (12):
> >   mptcp: add the mibs for MP_FASTCLOSE
> >   selftests: mptcp: add the MP_FASTCLOSE mibs check
> >   mptcp: add the mibs for MP_RST
> >   selftests: mptcp: add the MP_RST mibs check
> >   selftests: mptcp: add extra_args in do_transfer
> >   selftests: mptcp: reuse linkfail to make given size files
> >   selftests: mptcp: add fastclose testcase
> >   Squash to "mptcp: infinite mapping receiving"
> >   Squash to "selftests: mptcp: add infinite map mibs check"
> >   selftests: mptcp: add more arguments for chk_join_nr
> >   selftests: mptcp: add the MP_FAIL testcases
> >   selftests: mptcp: update output info of chk_rm_nr
> 
> Thank you for this patches and the reviews!
> 
> Now applied in our tree (feat. for net-next):
> 
> * Before the "infinite mapping support" series:
> 
> - ca9cbbff446b: mptcp: add the mibs for MP_FASTCLOSE
> - e9d3d6700269: selftests: mptcp: add the MP_FASTCLOSE mibs check
> - 7b6ed57c70dc: mptcp: add the mibs for MP_RST
> - b1dd7c48a10f: selftests: mptcp: add the MP_RST mibs check
> - 481e87d3e23b: selftests: mptcp: add extra_args in do_transfer
> - 6609f1c808dd: selftests: mptcp: reuse linkfail to make given size files
> - 28ac700c6369: selftests: mptcp: add fastclose testcase
> - bd4f93690fa6: conflict in t/selftests-mptcp-add-infinite-map-mibs-check
> - 4e668db2d842: conflict in
> t/selftests-mptcp-Add-tests-for-userspace-PM-type
> - 519eb3313dc7: conflict in
> t/selftests-mptcp-adjust-output-alignment-for-more-tests
> - 5b26053898fa: conflict in
> t/selftests-mptcp-add-implicit-endpoint-test-case
> - Results: d7649a6f4e25..dd86303a6117
> 
> * In the "infinite mapping support" series:
> 
> - a901b62afb52: "squashed" patch 08/12 in "mptcp: infinite mapping
> receiving"
> - ed1ec3a2223c: "squashed" (with conflicts) patch 09/12 in "selftests:
> mptcp: add infinite map mibs check"
> - Results: dd86303a6117..2198a66cca7d
> 
> * After the "infinite mapping support" series:
> 
> - 0954244ea41e: selftests: mptcp: add more arguments for chk_join_nr
> - 0c0217635548: selftests: mptcp: add the MP_FAIL testcases
> - f2b1c0bab9a7: selftests: mptcp: update output info of chk_rm_nr
> - 66fe2565137c: conflict in
> t/selftests-mptcp-Add-tests-for-userspace-PM-type
> - 725730b4cb61: conflict in t/mptcp-more-careful-RM_ADDR-generation
> - ea63fb2b5f25: conflict in
> t/selftests-mptcp-add-implicit-endpoint-test-case
> - Results: 2198a66cca7d..5d3058e05cc9
> 
> * Extra fix:
> 
> - 649d88fdc3c5: tg: fix wrong conflict resolution
> - 4ec880a22963: conflict in
> t/selftests-mptcp-add-more-arguments-for-chk_join_nr
> - Results: 5d3058e05cc9..067a741aa5fb
> 
> Hopefully everything has been applied as expected! Do not hesitate to
> double-check!


Hi Matt,

Thank you so much for applying all these patches. I have two extra
requests about the order of these patches here.

1. Move the commit "selftests: mptcp: adjust output alignment for more
tests" before "mptcp: add the mibs for MP_FASTCLOSE". Otherwise, it'll
break the output alignment. Since 'nr_blank' is defined in the former,
and used in the fastclose series.

2. Move the commit "selftests: mptcp: add infinite map mibs check" before
"selftests: mptcp: add invert check in check_transfer". Since the former
is more related to the previous commit "mptcp: add mib for infinite map
sending" than the latter.

No conflicts occurred. And the order of them all is like this:

pick 257287531bbc selftests: mptcp: adjust output alignment for more tests
pick e27d928aa4ec mptcp: add the mibs for MP_FASTCLOSE
pick ea66162e3f4f selftests: mptcp: add the MP_FASTCLOSE mibs check
pick f7e2120cec1b mptcp: add the mibs for MP_RST
pick babc72fe71a7 selftests: mptcp: add the MP_RST mibs check
pick 426f25b59edc selftests: mptcp: add extra_args in do_transfer
pick 8a48a2ceaa22 selftests: mptcp: reuse linkfail to make given size files
pick fc578f540a07 selftests: mptcp: add fastclose testcase
pick e02ad48fb24a mptcp: don't send RST for single subflow
pick f6e7701ed3f0 mptcp: add the fallback check
pick 2ec8e7687a0a mptcp: track and update contiguous data status
pick d2599198de2a mptcp: infinite mapping sending
pick ba54e60a32f6 mptcp: infinite mapping receiving
pick 8c2c5497dbf1 mptcp: add mib for infinite map sending
pick 01d891dec821 selftests: mptcp: add infinite map mibs check
pick 1cfaf9761bef selftests: mptcp: add invert check in check_transfer
pick c9217d510f58 selftests: mptcp: add more arguments for chk_join_nr
pick 99eb057ec657 selftests: mptcp: add the MP_FAIL testcases
pick abe3bb655cff selftests: mptcp: update output info of chk_rm_nr
pick 87210766b6ff mptcp: dump infinite_map field in mptcp_dump_mpext
pick 9363e0880eed mptcp: add tracepoint in mptcp_sendmsg_frag

Thanks,
-Geliang

> 
> 
> Builds and tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220223T205717
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
> 
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

