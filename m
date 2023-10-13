Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D111720
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M8nlhbBi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFpLz5keheMBhVXhtwdBpddabhxJZIwqsbfH8zmDpd+xPf84hy78dvIHS+TXdIZ+c4tfqbh32HvtE9O7/1FZs8OlUkuDYa29COqaJTPIowz8uaiOokzfns1i/DO0z7KdaKGw58Mq30E/1/s81SLK6qqsjlow9Fe5usHLWOCN+GpcXOXmf/JckAXCwnDKk811Fm9Pwjz6xATWgSzhh/GwgZLPlqMCUHUxbRlAf+gFZqVAUC9eujqUjDB8iSkRtqmidBM07vIjKLjM9DzLMQCmQcBWCJoTf06VkSuwlm+n8eHYEjee1YQvi76eLkKxkQPP8W5In0SwYo/pjB/+9Frd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cx5vtHcIA5jq1QcQbawVsVfT9UEjY1ZMvLvTV5k68Ak=;
 b=TUAlxbIha70ig9+07cxjidLllFNlGQLCNSD7zl5YLdcD0E3YOJlpjmN4GsNSUEdGbT3zbZTTP1uBvkedeK1iMHB4A/WWPbvCgbwbDoKE3+qh1hLAL2X5D+08s7DxaU4R1qN6YTLNwRMi/PbszdezqXkQe1m/77oQxbZG25a6kYVR0UbtIi2k/fY7qlt6mivOaUOOas3/bzw8RuuBTpH8PpYb0bk1zxJkBem7acLwo/AHGghAIZl1+523d/xHIYs0UZVK/7MJiZ49pAEpt7HyxahjntMKUU3NZGE7mVbwuRoWoJoEugNRrI3BKfbzCWYZYMSDzOjdnYVMQXpXm7NTgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cx5vtHcIA5jq1QcQbawVsVfT9UEjY1ZMvLvTV5k68Ak=;
 b=M8nlhbBiO4eWe2vvrfMSfUhF/CJm/AbQQ3u8Ec1ZBEWPB6xpzETZGBb9qvlBkweUjCbYWtuwPfhNy7o0OOuEV3Jrwp9D5Y2QxyExdkeUsgt+J//7rkamBhtXhkvl+tkS8Zlo/qXz8W1APoOc8p5f9cW3DtDWK35UzDyJeobrVxQEMGfD6/g7kUrcGNEYXUpXptCdLSSBsCQv4T1c8pc4QMfZe+SDHtpR3J2kxPRyZl4To2Wm9rEMtEmhb/lkWtNhN3rbUxVSu7I2UWP167spUkwDPPzW/i9eYZSbA2fDXgS3mACV+gH9xt0ML9CSfQlPOARC7ktckvBUpX5Z3strHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8806.eurprd04.prod.outlook.com (2603:10a6:10:2e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 11:28:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 11:28:49 +0000
Date: Fri, 13 Oct 2023 19:30:06 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v16 0/8] userspace pm remove id 0 subflow &
 address
Message-ID: <20231013113006.GA29962@bogon>
References: <cover.1697175899.git.geliang.tang@suse.com>
 <8b9e4a05-7b65-4b2a-b4d9-3c5b03a894f9@kernel.org>
 <b783f33b-ae88-4509-9b9e-53736fd4dd5a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b783f33b-ae88-4509-9b9e-53736fd4dd5a@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: f8db14cd-d41f-464c-7a9d-08dbcbdf9208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cNLBBA3kEUTlluFdPrS642MuosB5WpVCRfeAjaOgTER7vI7nYwGSTeqTLDy0/L7jklwNSusaX1rtABZdwjfSZkySUuMtDPmcmvHoTshrle8GKTi2mdeR76Yi1RnxiQkcd5AOOojXjPApY1TK9p6hOwBw0lyFwKBTr4NME3tJafZb+zlIFBUmiINvQB5BoJxpazEwL8xLyxJiwwgKvvVIS7no5Tu8XkqpMOSVBQHbjep0p5nt8DcmacjBto4hDM+RS+xW1AIdI5cxPqkSUBOtA2cJU6dYTb9Hdx3hmuWCoDWzhOzdvk5qEwVbV0UtqAxuV+ayLm4ABtp2DcHAuwWOf6P+cwajfBdPqJdtmnyrc3F6TkF72P0Et3++/B+cCz/yGACL0XoL1sdpBJqdALFxiXg5O5PDiLC9axDNzTaVzhf3OELueRoUaQcmrq1rFNrbw/EawGWB+DHGPgPpl3SFhHzQUU9lB2RiyaCzjoIotAgjV+be5PysevH+47mcQ5pWfWSwJ7GMkah2p/rbWwbnY/mHpke4rN7csjl8Kp7q/3BQfCuAi5T5f9DipKC92FNPqKyrRMyFEadQTT1d55pVEaKrKBsjPDa5NrYF8NAbsDYGXOTGU0NWTsK9YpStOdyV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(376002)(366004)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(6486002)(66946007)(38100700002)(8936002)(33716001)(6916009)(316002)(66476007)(6666004)(6506007)(9686003)(6512007)(66556008)(478600001)(83380400001)(53546011)(1076003)(4326008)(8676002)(44832011)(26005)(33656002)(15974865002)(86362001)(41300700001)(5660300002)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tSVd934FCQDCY37UoQ8tPUDMvs/8IKGP9rpn4N5XYc+Uu7+5yy3UuOLrVRNH?=
 =?us-ascii?Q?5rL62lyJs8DXgvJf2at4PPi3z4RGaLHqBGps8AepAxhHy08Kk9AXSSLMXPAV?=
 =?us-ascii?Q?Hchc8Qzn1svyd7HYLmY5dK17Unlg9HGkDt0gPpV4qwT2HEI9AGOg/mzBxtvK?=
 =?us-ascii?Q?S451NzfdkkqluGNRd4L85F0n9zBrA0Kn46PEJ/nzWcVJrd96fxp9T1fGDiix?=
 =?us-ascii?Q?Be8+P9bxw/ekB0+IJbh12wHNzylv3QUGCTxTFqKiIU+IPg5lvlpFS0si5GJc?=
 =?us-ascii?Q?riT1Bh1bLibv0UAyqI6oaVn+vRzqVeYX5Cfeppdh32SXBTyUeeqR0x64TrXj?=
 =?us-ascii?Q?mIbhPYtAmkUZqaJg1evA6Rzxc6D+++l1t9N9B0x8y/QYjp94Ge0MQj/gF7WJ?=
 =?us-ascii?Q?bSOD1lScX03+IUeYKin6DAnR0tVU8XzE5mFYtM8xmsvmz8CwTghKUrUlH2vo?=
 =?us-ascii?Q?kwRgzGaR+7VNN2Jf65Qo2kjcgm9dgmIgXpGPnfMwPw3q+094+SpAbWX4Gp1O?=
 =?us-ascii?Q?8wDweioKzOqTB5HSHAmFoTgFAoG4V/Ae7zeOzCwzaG/dujtStD+jRaEsP+cW?=
 =?us-ascii?Q?pN5Oe90luQ0E/c5o1/zSlFgdRMCNwCRk6pBhbiwdqCE+gWJeij1d8EwsNEPC?=
 =?us-ascii?Q?nmeD4Gn3uXh6H2JEckaQImMuIhQserKAHKCQ7BXOFtPb6NJBrNfe0ZAJpEHK?=
 =?us-ascii?Q?ECuVaPGI0vZGMSmMEVzGf8n+Uj1YUS/MQPQ7TeFkcGPkdWcBm4brzm14WK69?=
 =?us-ascii?Q?8L0F8zgL2uUGzFe2Ve4UMAqCI1wbXW42aIxf524LH+M91CnkWaKX/hOOfXlv?=
 =?us-ascii?Q?hMKe6g2wc2FhVbugqUvbPFsPzDw1WpF4Hu1woPyy7yMrhinJtm4XbWYxDPQ2?=
 =?us-ascii?Q?lFaljHN620rF5yrJL4N+qFwPBgMDMhjXU21Qck1h67/4DBjeZvi8W8NpRL6I?=
 =?us-ascii?Q?QkPKFvZiNyHfZ6T/p8vZ0IoVUKbpexReC3YEemEIeYsYr2a5CdxVuEHNEfb8?=
 =?us-ascii?Q?NjWMHHURr2hGeyfsDTCCqtmpLjFZpUr7g6gvcNJfhgHAX+lBquAAmpOBHL1N?=
 =?us-ascii?Q?hlV20eJ1JVtMHm6phNfnQhTJdorBo7Spas0B8Rij46knCx31uwSJx8MFUEyZ?=
 =?us-ascii?Q?0nwe5aOa7iaLDsYXLpTeF9vJr0S4q91+So2ugWjLsMBObk4HUE2JSJTBad2b?=
 =?us-ascii?Q?ewgf86JJRXa5vPeZuRu4Rbve+xM7iCs2nEolwWH70Pp3J4ts83QohFkQAkAP?=
 =?us-ascii?Q?D8mE4JAE/F8aBJ9VpDTKQK7MI17AFzaPNoFZIteQBpvFVLqb6hVPaVnXedT3?=
 =?us-ascii?Q?BsIO1QjtrhEmIGQ4mob9AsU5TcLCNATL3+hvRnGQWjXMOC0b9SSaELshYlmR?=
 =?us-ascii?Q?20l3GbHGP+/FXvlfhFBl91gjvxa7pksWFo+xjm8SljaPECKvJglFm70IURvX?=
 =?us-ascii?Q?NnduA1xy0/+bVOVKTEAuEbHjbmOIydsIyP8tgngC5Wb4KsBar4nxRbpiGhZX?=
 =?us-ascii?Q?ttLu/QCRK47azVpdhFkXp/OPh6c3qMCERpuK+tnZwr9KmuoIArYwChysmOR/?=
 =?us-ascii?Q?dOVM451JgVDU4z3zp1zu7LV8/D8rdVNIgTGFLuPG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8db14cd-d41f-464c-7a9d-08dbcbdf9208
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:28:49.2972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD06z5oc/EVSVsdTKh5OhaYPSXDXi6CapT+UJ1HExPuU9zyDH6lPd1SahNhsKysxHoPe3ROayEqlLW7jpjf4/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8806

On Fri, Oct 13, 2023 at 11:36:36AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 13/10/2023 10:31, Matthieu Baerts wrote:
> > Hi Geliang, Paolo,
> > 
> > On 13/10/2023 07:46, Geliang Tang wrote:
> >> v16:
> >>  - address Matt's comments in v15.
> > 
> > Thank you for the new version! It looks good to me!
> > 
> > Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
> 
> Mmh, I missed the errors reported by the CI:
> 
> not ok 112 - mptcp_join: userspace pm add & remove address
> not ok 113 - mptcp_join: userspace pm create destroy subflow
> not ok 115 - mptcp_join: userspace pm remove initial subflow
> not ok 116 - mptcp_join: userspace pm send RM_ADDR for ID 0
> 
> Do you mind looking at that, please?

I can't reproduce these errors. All tests passed on my side.

I run this command on my Thinkpad laptop:

docker run \
	-e INPUT_BUILD_SKIP_PERF=1 \
	-e INPUT_BUILD_SKIP_PACKETDRILL=1 \
	-v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
	auto-debug

And this is my .virtme-exec-run:

  run_selftest_one ./mptcp_join.sh -u

Every tests passed.

Is there a difference between my test environment and CI?

Thanks,
-Geliang

> 
> I wonder if I should not revert some patches (for the moment) or disable
> some checks: these errors are visible on other builds, and we are
> missing real issues.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
