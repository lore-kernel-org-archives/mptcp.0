Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB13F2F21
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644334850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K54Wk5t8+XjrGKfX7bBra5//beXkmMKpyFGZPJdQfIs=;
	b=Ns/ciGvUZ0rxFsHLf2tPJkw5fMFHQzA+lDuGxkfq2wPeLyUGW3HuFkJfmbEkqYjNfMYmLP
	D9JtkNkJ404UzjwZ5FUtXpUMOi6QUMXlvP/Y/d6aVQdUVcqtV0av30+14ZoN1CCWgAwi+F
	z9V3ns0s1U4XSzrGZoftLytbC65Rq1c=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-4_GbZW4ANwao2f-5-Vva9g-1; Tue, 08 Feb 2022 16:40:48 +0100
X-MC-Unique: 4_GbZW4ANwao2f-5-Vva9g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV6RbHAkJuRQPXo2d+llWtvTpFAWbN1dUPycgv6guV45GnCLEPnWDbdmH77Ll1aWqlht7iUgF3h7Qh/Mh3fAuttSPdmGfQAdP4E/ZN8lZn5TJgDLLszfoLuMTGT5kaDvjnh6qff6gcP3gbe2ZszuirTWNWwXEGp0QpSSIH327wvLOofBvUAgf0CmI79qBgBxrcmvh7oRYvN4cizLKutAOmm6c0/4wX1CQXoPcFPMR7XK6WJZLZyGWzXtyhDw6FnbREnFQ/cbejm547WqmXs7DVs51tne/kvOI3S4b7106/fEEy61UwoQ2EOSDtRAvZkQ2WPh72OGd2VYyNnQbYxhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVDAy1x95VK0V9lTSecuQvYejDAMhg1/b6bccG6XFnE=;
 b=oWpNIKwrNWFmlx6iB9/Uy56alm9QvLbZviJZAoZYp+yFvk9TzA03AlcSOHQQTyxqT+9Pe8tyD7jWCCELc4oLK/h4CqWaBh+a01JyDaX497vve8r3fBh6BOVdzhhE7XvMN1JFNvLe+a1t+KR1EJ8Diu7YRnMMEtY0qZFdKx8CfhHBMNG3iLX7Oy8ZOzT07R5Ff38dTTPwt5Kz1onN2o9k6NRn7pzeeBov6qJ7S2G//xQsX+o2mHS9a5X8fSM4Noic3Hp3/dZku/qTvIum/wNfuA0KEqfqEdeYIbs3sBJrZ4QzPx8ah51pnf6hBBS6yH7V9KEaPcRxA4bH/9Fq7DrYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3785.eurprd04.prod.outlook.com (2603:10a6:8:f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Tue, 8 Feb
 2022 15:40:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 15:40:47 +0000
Date: Tue, 8 Feb 2022 23:41:10 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
CC: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Message-ID: <20220208154110.GA28531@localhost>
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
 <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
 <20220207140854.GA2916@localhost>
 <63c6dc9c-fa32-cf8b-2f5d-4fc5c51447b2@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <63c6dc9c-fa32-cf8b-2f5d-4fc5c51447b2@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e96a9ae-a0da-43e8-77c4-08d9eb19601e
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3785:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB3785A232AAC41F8AD0BF0EB2F82D9@DB3PR0402MB3785.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Git7Au6FVLYgzT44Tzxgwrdq5i4YLr6m6PdcVbQJ6o1sh09OzJ1wbtZ9mljtWb494C/dY9E/UPG8dpTHmjdaV7I5fRkLnEk7ZeFKwjtZZyfpdrVuPRrO8bG5URZTPcJBAVD7Ehbxw3dkvfo5UUoeCZXai2vh52ALX+8w6OHsX5NGecMAxLRs65FfdOm0lYKvbIWy/+dCHc98/KjIb04BbQG2Z7JZFV6uPxzVFPm4Duxyr2/2BPR4T/C+gfhQDzDFtW5TbJo9Z60uKfoh5wPKYT8NTStGY5/7gvAFiuH74ZiBugN4vKrkn/BpkmevBIQWs7JbJxKiNhIGAy6HIXMj/H+OUKLMnnkeVHwFtXTWq2jI87XXMIhL4DuqNEoj3FV9vQsL7VkVSSHnL5to+YMlPF4Rc0OyNt9oIHxztisxmqyFC7bTh+gzCY7WaU3xLkOqJKSpbRKV2VNmJMRVthDqjJg2jUwNmbarnWhCW7KxQLOPipXvdv5J94/LUQnv5koTPleW2sqEMw1gTknGEP2S+zUD9TfnfeF5wyimEZ487BqHrXuBzXxNC0N5JcRxOzycPWXI+vSrJ/c1lMs6FE8rlQZ1efx0iBU5FAAGvKBehuTN8/EsofFJcKr6Q6tw6fmFMkAvyiVP16UWupEkwbKYbwXDW7uMf78UEZF7Dqt+JTayfQHXIkQhp0XFJUNyAqftbtOlk6eiECY20t/g6tUt+sDPYgQ7EkUcHDIrMKNZlT4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(84040400005)(6506007)(86362001)(15974865002)(508600001)(33716001)(6486002)(19627235002)(316002)(53546011)(966005)(8676002)(4326008)(6666004)(8936002)(33656002)(66476007)(66556008)(66946007)(110136005)(38100700002)(83380400001)(6512007)(9686003)(5660300002)(44832011)(1076003)(186003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4eqQPKCZcqeU8XYJjpAoB2/8gs6c2ayeXn3iBv0K+R4QmMqOFEkGu5RMcJk+?=
 =?us-ascii?Q?UVQYDEsvUFUBCYDVoVZdPC5mYE0ZW9bFmd6aHy5D/m0b7nUtdKMEjxI/BS3Z?=
 =?us-ascii?Q?LrbI4EsLCAwEARyA9vnVkMcpuKMjhUrn8m+pYP7FNi8Y7hQYZPSEzO5ZreYS?=
 =?us-ascii?Q?Yeig8A42Vz+ARdmJhrr46mOeGFNachs9iNUHTjzKn4OEbyuoF72MKBUKRoqG?=
 =?us-ascii?Q?RJEgASGwzTGjzp6FxyxbMiaPIurFd+R9e4VelYzHjoqGA8PPFXbaQHA9EjFL?=
 =?us-ascii?Q?sTSgMyGHb2BwQE1jlIc2XSO5hpXlUeVYhZJIRkeuvzMh1pKLSv48TVYN7f6h?=
 =?us-ascii?Q?HGwGp/xCnd6flDibeUfCrtx54Z5j7nbfX6gSzKCyx08xjN53Y2cRMQEoY3r4?=
 =?us-ascii?Q?36eyedYfZESc98y0XQRPfy7iw6D+i3H8/JdqIpAd25v44qLWaVQZq6QMYt4T?=
 =?us-ascii?Q?apOuIplQPpI2BeJBJhXboyNoCMxIPLeRor8yyzr+ZA/UOSWooGwiXqG63JAS?=
 =?us-ascii?Q?E4CsiYJdVvi43sMAyzm5Z+XII7RJkmeGjZRsx27TbbkgyqXtTTkyKdgfytB0?=
 =?us-ascii?Q?Wr8a3eRJRxTIFhLIkQUW8Pk6PqAPBhATMe37MzkUlTQ/lAYdDeU1vjZem7PG?=
 =?us-ascii?Q?RouE9A3CU+V0EuW5GCIFDxqm3WXXR8Kt7u5vTKByDLbJJu69XiqM3d7Uuxg+?=
 =?us-ascii?Q?rbLaDCcrB65c9jCamF/D66VGjrC+9wze4EExajRM6Rqhvv8jel1AVjCrYAcN?=
 =?us-ascii?Q?hyX3X/Gj43haB75zMjzRTFBKMWI64WqZCaCQtMVy+wxBkloKapQvTToAzZsx?=
 =?us-ascii?Q?kxMVnx4qK/cJQM7+84HwpF3z31z5Me5QPbsi78nv69weW8xr37LVLfKfUdqS?=
 =?us-ascii?Q?8p14rZaUt4K0ScCzqltR9rDtbTPoqs131glRPKBHnKiGkYp6Vhxho6z6cAZl?=
 =?us-ascii?Q?pdtZmKQ6UZ8OFLVxgFrt0M8U5CDmqYkCk9vNvvbtDHZHqfH8e4QBKppii80d?=
 =?us-ascii?Q?3WTsB9gCPJkzaOY2OP716c8yPTR3UJB5Bm7GGX82tWBzQbvsuxcu0rw454X/?=
 =?us-ascii?Q?Mjs0poqsCwCxofJrp6nu7gjpDHAm+h731cyLCNRSa1bk3nyWCX4r3haoJz7r?=
 =?us-ascii?Q?633m5/sbBdg9tfsxi+R4Wk5Du26j8CEAIW82PpwpxJ3M0V4msUlXt8BPuG4P?=
 =?us-ascii?Q?E/1VHpUW0TTNPV05nkAzPJuXs0lNEpccA5PEl7UAn4K1EO204J5KD0ov5WoX?=
 =?us-ascii?Q?Fi8H5CmyKYCDQre84ELhcwoJNlD+IsqiaYNZY4yoAGyrtPm8ArtASjITglbi?=
 =?us-ascii?Q?Sp/rpIMRNgfCftKeXw2dkc4U2OH3Vbz9V4BYjoUagOgENTe0d/sOMNzimM01?=
 =?us-ascii?Q?2EJLOEruhgg8XOQw1VMHMaRW0yx/TbJ3+PNvHlujLalheMVC7KuMn5mZ/kMc?=
 =?us-ascii?Q?GUWPlZyve29mCLsMBdyXXHiFecV1llsphCIqXmh9mrHelAzt+rvz66ZxhuYN?=
 =?us-ascii?Q?h59RgZ6BjPSCBZq6I42+njhWIFmFq/OLiEU4JU774vXVnGCEhrGqEEMB1lOw?=
 =?us-ascii?Q?Wq6VwK7Hj7KhJv0OS+ungdHTyJ/zBLk1DHJASCAVSA5KLiOwtx5tHL9H10a5?=
 =?us-ascii?Q?vtFj7/62RsGYxhJ0wfViQTNaCsidN87chRbAE1GWupQp8HzbXHED5egFZajF?=
 =?us-ascii?Q?QHl3QTAHXYkCZu1pleatWl5LlKo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e96a9ae-a0da-43e8-77c4-08d9eb19601e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 15:40:47.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFIMMHeAQArxGwYuG8SsbyphS0Qyeux/jBCfFxtJnxezhq3TqKn9TM3B0yPX1NAiV+AspZ4kKqOaPJMisE7XdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785

Hi Matt, Mat,

On Tue, Feb 08, 2022 at 01:26:10PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 07/02/2022 15:08, Geliang Tang wrote:
> > On Mon, Feb 07, 2022 at 11:32:05AM +0100, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 07/02/2022 05:13, Geliang Tang wrote:
> >>> Hi Matt,
> >>>
> >>> Matthieu Baerts <matthieu.baerts@tessares.net> =E4=BA=8E2022=E5=B9=B4=
1=E6=9C=8829=E6=97=A5=E5=91=A8=E5=85=AD 01:04=E5=86=99=E9=81=93=EF=BC=9A
> >>>>
> >>>> Hi Mat, Geliang,
> >>>>
> >>>> On 27/01/2022 01:07, Mat Martineau wrote:
> >>>>> On Tue, 25 Jan 2022, Geliang Tang wrote:
> >>>>>
> >>>>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
> >>>>>> checksum failures.
> >>>>>>
> >>>>>
> >>>>> This patch is working well with the inverted byte detection, thanks=
!
> >>>>
> >>>> The public CI seems quite happy with the new version, good work :)
> >>>>
> >>>> Here is its report:
> >>>>
> >>>> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> >>>> Our CI did some validations and here is its report:
> >>>>
> >>>> - KVM Validation: normal:
> >>>>   - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
> >>>>   - Task: https://cirrus-ci.com/task/4993794666921984
> >>>>   - Summary:
> >>>> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/=
summary.txt
> >>>>
> >>>> - KVM Validation: debug:
> >>>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join =
=F0=9F=94=B4:
> >>>>   - Task: https://cirrus-ci.com/task/4682233209421824
> >>>>   - Summary:
> >>>> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/=
summary.txt
> >>>>
> >>>> Initiator: Patchew Applier
> >>>> Commits:
> >>>> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
> >>>> =3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D
> >>>>
> >>>> But if you look at the logs [1], there are probably 3 last things to
> >>>> improve:
> >>>>
> >>>> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
> >>>>
> >>>> This line is repeated 90+ times:
> >>>>
> >>>>   tc action pedit offset 162 out of bounds
> >>>>
> >>>> (we talked about this one at the last meeting with ideas on how to
> >>>> reduce/get rid of them)
> >>>>
> >>>
> >>> Dose 'tc + iptables' work for our case?
> >>>
> >>> Use iptables to select the packets with enough data. Then use tc to
> >>> edit the selected packets only. (I don't know how to do it yet.)
> >>>
> >>> Here's a link about this:
> >>>
> >>> https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_=
iptables
> >>> .
> >>> '''
> >>> Using tc + iptables
> >>>
> >>> Iptables has a method called fwmark that can be used to mark packets
> >>> across interfaces.
> >>>
> >>> First, this makes packets marked with 6, to be processed by the 1:30 =
class
> >>>
> >>> # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flo=
wid 1:30
> >>>
> >>> This sets that mark 6, using iptables
> >>>
> >>> # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
> >>>
> >>> You can then use iptables normally to match packets and then mark the=
m
> >>> with fwmark.
> >>> '''
> >>
> >> Good idea, probably simpler!
> >>
> >> I guess we can mark some packets in POSTROUTING and modify the egress =
TC
> >> rule.
> >>
> >> Do you need a hand for that?
> >>
> >=20
> > Thanks, Matt, I really need your help :)
>=20
> Sure.
> May you try the attached patch if you don't mind?

Great! Thanks Matt. I just tested your patch, the single subflow test
("002 1 MP_FAIL, single subflow") works well. And very stable. The two
issues that I mentioned in the cover letter of this series didn't happen
when running this new selftest. So the first two squash-to patches in
this series can be dropped.

Mat, it looks like no need to analyse my attached pcaps any more. Thanks
for your help.

>=20
> I now have this output:
>=20
> 001 0 MP_FAIL, multiple subflows         syn[ ok ] - synack[ ok ] - ack[
> ok ]
>                                          sum[ ok ] - csum  [ ok ]
>                                          ftx[ ok ] - frx   [ ok ]
>                                          itx[ ok ] - irx   [ ok ]

But the multiple subflows test ("001 0 MP_FAIL, multiple subflows") doesn't
work. I'll try to fix it tomorrow. I think it's easy to fix.

Thanks,
-Geliang

> Created /tmp/tmp.SNhvH7ucj9 (size 512 KB) containing data sent by client
> Created /tmp/tmp.RFEqEXi0bl (size 512 KB) containing data sent by server
> file received by server has inverted byte at 69
> file received by server has inverted byte at 70
> file received by server has inverted byte at 71
> file received by server has inverted byte at 72
> 002 1 MP_FAIL, single subflow            syn[ ok ] - synack[ ok ] - ack[
> ok ]
>                                          sum[ ok ] - csum  [ ok ]
>                                          ftx[ ok ] - frx   [ ok ]
>                                          itx[ ok ] - irx   [ ok ]
>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net

> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/sel=
ftests/net/mptcp/config
> index 26955abe49f0..38021a0dd527 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -12,6 +12,9 @@ CONFIG_NF_TABLES=3Dm
>  CONFIG_NFT_COMPAT=3Dm
>  CONFIG_NETFILTER_XTABLES=3Dm
>  CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> +CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> +CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> +CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
>  CONFIG_NF_TABLES_INET=3Dy
>  CONFIG_NFT_TPROXY=3Dm
>  CONFIG_NFT_SOCKET=3Dm
> @@ -22,5 +25,5 @@ CONFIG_IPV6_MULTIPLE_TABLES=3Dy
>  CONFIG_NET_ACT_CSUM=3Dm
>  CONFIG_NET_ACT_PEDIT=3Dm
>  CONFIG_NET_CLS_ACT=3Dy
> -CONFIG_NET_CLS_FLOWER=3Dm
> +CONFIG_NET_CLS_FW=3Dm
>  CONFIG_NET_SCH_INGRESS=3Dm
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index a51b0915b7b1..52a0f3df3b2e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -180,15 +180,12 @@ reset_with_allow_join_id0()
>  # has not been updated, we will detect the modification and emit an
>  # MP_FAIL: what we want to validate here.
>  #
> -# Please note that this rule will produce this pr_info() message for
> -# each TCP ACK packets not carrying enough data:
> +# To avoid having tc producing this pr_info() message for each TCP ACK p=
ackets
> +# not carrying enough data:
>  #
>  #     tc action pedit offset 162 out of bounds
>  #
> -# But this should be limited to a very few numbers of packets as we
> -# restrict this rule to outgoing TCP traffic with only the ACK flag
> -# + except the 3rd ACK, only packets carrying data should be seen in
> -# this direction.
> +# Netfilter is used to mark packets with enough data.
>  reset_with_fail()
>  {
>  	reset
> @@ -199,12 +196,20 @@ reset_with_fail()
>  	check_invert=3D1
>  	validate_checksum=3D1
>  	nr_fail=3D0
> -	i=3D"$1"
> +	local i=3D"$1"
> +
> +	ip netns exec $ns2 iptables \
> +		-t mangle \
> +		-A OUTPUT \
> +		-p tcp \
> +		-m length --length 150:9999 \
> +		-m statistic --mode nth --packet 0 --every 9999 \
> +		-j MARK --set-mark 42
> =20
>  	tc -n $ns2 qdisc add dev ns2eth$i clsact
>  	tc -n $ns2 filter add dev ns2eth$i egress \
>  		protocol ip prio 1000 \
> -		flower ip_proto tcp tcp_flags 0x10/0xff \
> +		handle 42 fw \
>  		action pedit munge offset 148 u32 invert \
>  		pipe csum tcp \
>  		index 100
> @@ -296,14 +301,12 @@ link_failure()
> =20
>  get_nr_fail()
>  {
> -	i=3D"$1"
> +	local i=3D"$1"
> =20
>  	local action=3D$(tc -n $ns2 -j -s action show action pedit index 100)
>  	local packets=3D$(echo $action | jq '.[1].actions[0].stats.packets')
> -	local overlimits=3D$(echo $action | jq '.[1].actions[0].stats.overlimit=
s')
> =20
> -	let pkt=3D$packets-$overlimits
> -	if [ $pkt -gt 0 ]; then
> +	if [ $packets -gt 0 ]; then
>  		nr_fail=3D1
>  	fi
>  	tc -n $ns2 qdisc del dev ns2eth$i clsact

