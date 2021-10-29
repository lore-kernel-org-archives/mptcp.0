Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490E72
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635483231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yMLlvTpjw6GiqcUuXIw6a+juFUX39Hptosfn5c6IFTQ=;
	b=JVx+P+G3uFVxZwayCLxlwsBmDGegBpts0cvA7i3qc8uk4hVX67izKhGRxN4T1wM356Hz1W
	xHroqzhNA/Thzz9bKg7BV+m99i7d3e/W1h+vATEByQQIDMDrqm5jCVQ7XRzfIcGWRlfKwj
	PUjj0B8SBYKH2n9JT0+KqcT9dp5Nf28=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2053.outbound.protection.outlook.com [104.47.9.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-s1jNfYtJPpuhe2yyR0Z_qw-1; Fri, 29 Oct 2021 06:53:50 +0200
X-MC-Unique: s1jNfYtJPpuhe2yyR0Z_qw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUjSDfHpMSFnsWeMHPvre8UhV2XKhBycXra5n3SHmh1qsLWqRozdDphCQDXf2XRhYkP1+ldD6ySCLi90O5TEWtGqCIhmpG4JHDT8lU/OxSCqxRNGGwUTs2Iudg52fOdm0xgf0ftfOtpwMZEe832HZyhuCgfxWvax5hCj1Q0kCWBSKmtRo/9lNveD91TI+MLSC3fGx6Ww1I1kFkufTUzlJ95Zs+neh3DMoituZ9MDbnbJVtmC32EWQjX82Pa5mqmbL6AX0+1uC1V5IaOiyib6vqmW7IwUk01Fp+NJgldKYhltHsOYdbcKHVRIBXQxya3r/azz5fb20wq5hruTIP7URA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMLlvTpjw6GiqcUuXIw6a+juFUX39Hptosfn5c6IFTQ=;
 b=P/duRKbtGbhHz4x8MchcDhRt9aKhSwGS5KjPDAhzocqR4Iy0Ju7FU+tC7SYT9HW7qAIViSdH8EdxJUH0rvnfsHRGsDygNeRIe2HrGpoYgYKf762AtlE/2FVurzQtYWYTuiIm3tWWnJlOPdq9qHOkIr/VSlK5T+wJEltaTAJBqTqfcLMgGVxmE/stBs43X2N9Jsvh6qdOMpmCXoG+BgW8ww2hqn9sybCkfUUOXdKlMtC4M3w1KQE2KLkbKiK2ecmsDyvhVUs5aMfW8xEXAV3RrgoG+5Ykf/Ucp416fxS/+4nz016/1mgj8362wZnNTZA9yNEv4NbcqBYyn2m6QcxNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2345.eurprd04.prod.outlook.com (2603:10a6:3:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 04:53:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:53:47 +0000
Date: Fri, 29 Oct 2021 12:53:47 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
Message-ID: <20211029045347.GA4583@localhost.localdomain>
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
 <20211028092338.GA6915@dhcp-10-157-36-190>
 <CAKa-r6srprPPPhUCXW3YnsQEL0ewFBptQFvUo_9mwtw_mD7DOQ@mail.gmail.com>
 <de15a4e9-0140-2b18-7a5a-c010980eedc2@tessares.net>
 <CAKa-r6t_ajhpvO2PnGyL2E-0FuV+r9D1i31vO9J71M8XiajnkQ@mail.gmail.com>
 <0ea55f5c-df3a-2848-a9f4-a830cba876c1@tessares.net>
 <cd55aaac-ea6f-e09c-489d-34112e3ceb39@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd55aaac-ea6f-e09c-489d-34112e3ceb39@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR04CA0052.apcprd04.prod.outlook.com (2603:1096:202:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 04:53:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d5883fe-d892-4f6c-396e-08d99a9817c6
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2345:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB23455AF642AB4BAA2A4A31FEF8879@HE1PR0401MB2345.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ah0dtJhaZHDIterZb8U/BnpIDyZ7S18QSTyntweKig+k8I0E4I7nWZch6nl+Eb9+36LWHZS1PEFZbEzMO4wGQj3nZmad4Hojz2sDyeEnoCycCIt2rn/ceAcN5TT24CV3nzs/LhdJ5r4WaHuLm1pHrkcKrI+t0uzAplMukDedC9uQnrDsvG6umHBSvIqc1qVq4rVp7nyE3vAullmEvljEdA7+EN93Ylb9sRo3pX/kjM1fGCKQTkp9jLP5BCCkA/GGSTSlnQDKiGQbD4F7S9zI+bL65T5KWfVn1I1HQXtGIBGRemzLlRzoBDmt+XGsilC5ynnmjLY8IzcaP5E7wKfk5HFmkfgiFNwtuF2qpOOBAY0uZmqiYZbys4yoE79xrYbGLpDsnsIyS8ZI7oNDEAH3muKtpdcyVeXLojg2qc7XOnlPQ5wylQzOWlnfNI4feGdTRYd5RAItRW5OsGOTj1JOeoD11HnOC8KbC8ymdYbH0q3yAhjVgAqIq0GfIsefxem3b1ZKLdNjJG6iagISsINh+m+HZLwExbzN2HGNZQP98EnVa5ZoDQKu4MJKBCY0taIWNDt/5gjba1yR5if5fZ5vqPfHkZIi7UxMwH/5cJaTZhUc2vgHD6rEpCM6DEiWJSihrFoMRp3zm8Z3gpYmSP5+9SLNbFzlcA8Q8Spd2okHD+7P+4gt3ElEdg6vxHCbU0IMjf72wbJrQagFNQBYavfa47HNxaQ+1aSiZJ7v4iS7k80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(26005)(44832011)(186003)(66946007)(508600001)(1076003)(66556008)(66476007)(6916009)(83380400001)(6486002)(8676002)(55236004)(5660300002)(33656002)(15974865002)(956004)(6496006)(9686003)(8936002)(38100700002)(86362001)(53546011)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GsLRTFWHONwwUBvDWO8l9UOIRJoLfLCGzd54LQ3kIwEG/NONtzz32R/l0db9?=
 =?us-ascii?Q?tE9fjru8H2JyTp7oPhEVhCb8ezel4DIcEDds/vULV4u19dqJWFdfzDSYUJdc?=
 =?us-ascii?Q?dF8DRVNN3otEVF5KKFaRmv5+Qzc84GzN2VZ5wc8SZtxfp3TeafDacrQgS5jT?=
 =?us-ascii?Q?8oI4bh8scd1SO2MJdhxK89A/hwX1rtXj9wsdrSgSye2WTACo5F4Z3YyjwEVs?=
 =?us-ascii?Q?IUXuTjzk63BVrSxe3R+C9RtTy0LarTlORRoS0caURga8rUFk1Th0dko8x0LV?=
 =?us-ascii?Q?zR8Ozw7MUUdu/bKbLf5BGJQ3BQ6u+3TEO3RyrSlrOIGkx+LyrKfMVFoCXGxP?=
 =?us-ascii?Q?+jDS6YQ18WUyEqkY94yMnla+HerhWNfjBvYPnIj+1YKqOX/6Ykiz5QKJjdp6?=
 =?us-ascii?Q?N5gNcHDrPskgzugoZ4kTQocvkTYL58ss14PLj0vot/WrllLBcPXwD1f+zxhU?=
 =?us-ascii?Q?vFJlGdmUTtHCXelaYUjitXhwZS4lQxNMUtxPRSGBP04yFFmyBCXM/I+F6EQ1?=
 =?us-ascii?Q?M0A/pJf2adnMP07VoeazVFWMUo6XOCQ3losBBWh7pok1lPNgTBScigepVSkm?=
 =?us-ascii?Q?Y2l3TuzdPsJT19lMsNpJpf2VUrvTSTu1b9m82pUX1Y1V7Yoky2I0nzmFmER4?=
 =?us-ascii?Q?Mgec+ycvLv+8I3U1rjvR10U4TAO4xJjBx6oCUw6QBuHwL515trbkiyga8H7z?=
 =?us-ascii?Q?jLxWKSfMTIixVpF0kJm9vmXtS3UGF8UBiT+fySazdMpiWXWF8k+RGO/j+BHj?=
 =?us-ascii?Q?/ck17rRe2xLVcP2KfRpUCOP0OsHQhAX25sctSVcHIruT5Oi364/tm6vVnIxE?=
 =?us-ascii?Q?RyA4BAxLoBV346qyaPIvQW+o4I2zwcI+223PBh0gPEhavFeZUnQNcDKta/OB?=
 =?us-ascii?Q?nD1v/ZArQf1kuo930mk5jk4tJ+K6UbeeltG6y4ZoE4oq0zsBXSZsoJxl8x9F?=
 =?us-ascii?Q?nu0LjRdUUXSF8Xx80tFzzN1e+wQTDUhXGgBg0MvRFz1waxx6tKL2FEKiFhCQ?=
 =?us-ascii?Q?0zI/G2Eg6lvJqAPY2NBwGXf6NwFa8pggRM0W+zWSNVgZDLSt++nKBb9IbzmS?=
 =?us-ascii?Q?TQppxDAvPOXF0soYbLuNyy2llxLFfHuuXsCF4t179xXAbfoWZgu0kD23jwfv?=
 =?us-ascii?Q?BOZZQe/lOg4llF8BdNumvVMD3NbynLFBbyTDaoPmcON194eolW9CBNjL5yDi?=
 =?us-ascii?Q?pYbEkI+Hdg3S8ioOw4F9rXyLQONvr75dD6CTaK00a27QAJrtMxkIaVRoXvD9?=
 =?us-ascii?Q?7qZKWEL3rvj1yFFeAqt1alqjezvRtklKSPfOdBmcjO7QCMpmV4e//uQrFRK+?=
 =?us-ascii?Q?OkCzreLCP9iJR4DaY3auff69mxojnKYfDVug7ymtCBmw/p3E+FxXDiiYmUaY?=
 =?us-ascii?Q?TWOMAHfwy/pMeusMinqX1qC83ThQM8tLCsG0rPT1afR4qmstppK7T65/jBVp?=
 =?us-ascii?Q?RUnIZybtob0EQZPIfWmOSledwcuoX6OzWdW2O9Hvbq9XxmuOkdWY8em2Zgvo?=
 =?us-ascii?Q?mN6CPPvBLUKghEBmM8ZFxi0JGWJIJRNFDoSUAOI9s2MmwB24IRCgKAKfNlY7?=
 =?us-ascii?Q?rsAl4jDf3qx4GkJvH5Ke7/R7pV21HkGBV/IUUzxNBFUnMGKPlnxuGiw3D+sX?=
 =?us-ascii?Q?vihou9SJniz6iOkKFQJVCaQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5883fe-d892-4f6c-396e-08d99a9817c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:53:47.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrPo7e7OyYJ2m2+nwmls62IKXSco1pztae7aB8XF4R4K5qgb6pZlDYLdjtekBZFJHP8fsqb5RG/oDrV8aM0qug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2345

Hi Matt, Davide,

V3 of this patch was put into the infinite map series v8.

On Thu, Oct 28, 2021 at 06:46:52PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 28/10/2021 15:21, Matthieu Baerts wrote:
> > Hi Davide,
> > 
> > On 28/10/2021 14:24, Davide Caratti wrote:
> >> On Thu, Oct 28, 2021 at 1:21 PM Matthieu Baerts
> >> <matthieu.baerts@tessares.net> wrote:
> >>>
> >>> Hi Davide, Geliang,
> >>>
> >>> On 28/10/2021 13:01, Davide Caratti wrote:
> >>>> On Thu, Oct 28, 2021 at 11:23 AM Geliang Tang <geliang.tang@suse.com> wrote:
> >>>>>
> >>>>> On Thu, Oct 28, 2021 at 11:16:12AM +0800, Geliang Tang wrote:
> >>>>>> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> >>>>>> checksum failure.
> >>>>>>
> >>>>>> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> >>>>>> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> >>>>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> >>>
> >>> Thank you for the new version!
> >>>
> >>>>>> ---
> >>>>>>  tools/testing/selftests/net/mptcp/config      |  5 ++
> >>>>>>  .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
> >>>>>>  2 files changed, 58 insertions(+), 7 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> >>>>>> index 0faaccd21447..f522288b2204 100644
> >>>>>> --- a/tools/testing/selftests/net/mptcp/config
> >>>>>> +++ b/tools/testing/selftests/net/mptcp/config
> >>>>>> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
> >>>>>>  CONFIG_NETFILTER_XT_MATCH_BPF=m
> >>>>>>  CONFIG_NF_TABLES_IPV4=y
> >>>>>>  CONFIG_NF_TABLES_IPV6=y
> >>>>>> +CONFIG_NET_ACT_CSUM=m
> >>>>>> +CONFIG_NET_ACT_PEDIT=m
> >>>>>> +CONFIG_NET_CLS_ACT=m
> >>>>>> +CONFIG_NET_CLS_FLOWER=m
> >>>>>> +CONFIG_NET_SCH_INGRESS=m
> >>>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>>>> index 7ef639a9d4a6..95bac447f857 100755
> >>>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> >>>>>> @@ -232,6 +232,29 @@ link_failure()
> >>>>>>       done
> >>>>>>  }
> >>>>>>
> >>>>>> +checksum_failure()
> >>>>>> +{
> >>>>>> +     i="$1"
> >>>>>> +
> >>>>>> +     tc -n $ns2 qdisc add dev ns2eth$i clsact
> >>>>>> +     tc -n $ns2 filter add dev ns2eth$i egress \
> >>>>>> +             protocol ip prio 1000 \
> >>>>>> +             flower ip_proto tcp \
> >>>>>> +             action pedit munge offset 148 u32 invert \
> >>>>>> +             pipe csum tcp \
> >>>>>> +             index 100
> >>>>>> +
> >>>>>> +     while true; do
> >>>>>> +             local pkt=`tc -n $ns2 -j -s action show action csum index 100 | \
> >>>>>> +                     awk -F ',' '{ print $12 }' | \
> >>>>>> +                     awk -F ':' '{ print $2 }'`
> >>>
> >>> (small detail if you have to send a new version: it is often recommended
> >>> to use "$(cmd)" form instead of `cmd`: more visible, allow nested
> >>> commands, quotes, etc.)

Updated.

> >>
> >> also, please consider using jq rather than awk. Specially if you are
> >> planning to use more than one counter. For reference, see [1]
> > 
> > Good idea, I didn't know jq was used in other selftests. But then we
> > would need to check if 'jq' is installed. *Maybe* if we only need once
> > to retrieve 2 counters, it would be "easier" to use awk?

I used jq in the new version, since awk will get wrong values
sometimes.

> > 
> >> [...]
> >>>>
> >>>>> How can I fix this?
> >>>> is that a problem? maybe we can just ignore it.
> >>>
> >>> Do you have this message once or one for each packet?
> >>> Does it increment the counter you are monitoring when the warning is
> >>> printed?
> >>>
> >>> If I understand the code, it might print that once per packet and once
> >>> but also increment the counter which is not good for us. But another
> >>> counter -- "overlimits" -- seems to be incremented too, maybe we can use
> >>> the two counters.
> >>>
> >>>> Otherwise, a possibility is to add a more narrow filter (e.g. flower),
> >>>>  to only mangle packets that have the ack flag but not the syn or
> >>>> push. We might also try corrupting the TCP payload to a smaller
> >>>> offset, so that more packets are impacted.
> >>>
> >>> Yes, maybe good to narrow a bit the filter by using:
> >>>
> >>>   flower ip_proto tcp tcp_flags 0x10/0xff

This dosen't work in my test, so I didn't include it in the new
version.

Thanks,
-Geliang

> >>>
> >>> Or is there another filter to specify a minimum size?
> >>
> >> unfortunately we can't do that with TC filters (unless using the eBPF
> >> classifier for this (and I'm still not 100% the verifier would be
> >> happy _ but that's still in my long-term todo list :) ). I know there
> >> are ongoing efforts to introduce a "check_pkt_larger" (because this
> >> check is actually a possible openflow action) , but that won't happen
> >> in the short period.
> > 
> > That's a shame but then better to restrict to ACK flag to omit a few
> > packets.
> 
> As discussed at the last meeting, we should reduce the number of kernel
> message (pr_info for each packet not matched by the pedit action). For that:
> - best to restrict to TCP packets with ACK flag only:
> 
>     flower ip_proto tcp tcp_flags 0x10/0xff
> 
> - and send only in one direction to reduce the chance to have "pure ACKs".
> 
> Having a few pr_info message is OK but plenty messages in dmesg/serial
> will likely cause other issues (flooding logs, slowing down stuff, etc.)
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

