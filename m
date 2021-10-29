Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424F92C81
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635513720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=amecmnDVg0BZZAwd10iuO1yNQyo6EpMEDR7vUqQy/K8=;
	b=Qvis2+/oc02I0P3Off6YPV2MeFARyTXMHHCuRV0m81LMGvLNUwnJNcD5pOyyRiLBSdRC71
	cDJcQVguFtc4jkRbz07EqH11Qz2lFXlGcNgdo1TrSfJ5Ze5srzbBfOZSFgzmz17nn1hTxD
	Ds7ppJ/+acObFaT54D5q1mf3L6sdtNs=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-hj9IIRoaNAKqVhDMFjgltA-1;
 Fri, 29 Oct 2021 15:21:59 +0200
X-MC-Unique: hj9IIRoaNAKqVhDMFjgltA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ruz7Y8gEtCinKNn/PRZX0+touEV40PLyjy2r3eiU4fD62zrdaOZBZEaknWrAlua2xlw7y2/QbJplZXFluzGjJLxhdxrFlrlsPxhsuHjUp4SHTpA0R3K1hxPFe69cYJSpUehBkWdbiDt9yc339oTvXrK16OZgjx68TV4PACS9p4nN8Fy1yXHPSlwRkkxUVQpCq1gxK5dp9Q8y1NvtEALi9ChhgmFHtqUCDOKSBgATizjjdRYh5MebCcqEg8PzCoDw2iABNlfh/Q9quA0ZxmvpNblE3UdwsjMLJBTTvBQ/dnrbgl5sIjq34Exvy0+vgA7zhLLB+tj6Hm4LBPa0/VaTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amecmnDVg0BZZAwd10iuO1yNQyo6EpMEDR7vUqQy/K8=;
 b=SGoRO0olIegrIqgGL+QgTADByfdR7EGpFdbthNdjLjhCtWkelcTBPD2T/nC3bdK4E3uQb3qetvrZmMiRVMZ9kqQcrQmvFN2NRHjv6ql7o4jXwKiKprGr3cQ0We5qigZ7/SobIIKWwzoT7JPsw4Q3JQoEbx/HXHAA5BzZkHKzIoM2+qEmD0R9S8QB0AZ3xZGvzx3TSJjZjbwcbdqCcfko90eOvIjrpjSvsgbKHUeMfH/eXEiVogSY9kCZA2ytf8sConllG0dZPljx5g6EqD8NCZp/5ElwrPAwnTKhg4wMwO/otqVyGo05m2TIkNKzu1yFF3dbHO1yDoIBlmQMazR1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: tessares.net; dkim=none (message not signed)
 header.d=none;tessares.net; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3482.eurprd04.prod.outlook.com (2603:10a6:7:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.26; Fri, 29 Oct
 2021 13:21:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 13:21:57 +0000
Date: Fri, 29 Oct 2021 21:21:55 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 8/8] selftests: mptcp: add mp_fail testcases
Message-ID: <20211029132155.GA4144@bogon>
References: <cover.1635481641.git.geliang.tang@suse.com>
 <ff613391540609e31cf4aff5abefaa03fbd63278.1635481641.git.geliang.tang@suse.com>
 <04774993-d824-0f62-c55d-bd21e46b99fb@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04774993-d824-0f62-c55d-bd21e46b99fb@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR0401CA0015.apcprd04.prod.outlook.com
 (2603:1096:202:2::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:c652:b659:7170:192c) by HK2PR0401CA0015.apcprd04.prod.outlook.com (2603:1096:202:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 13:21:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da87c558-74f0-4f0d-f310-08d99adf14e3
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3482:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB34820A182CF81FD755685C85F8879@HE1PR0402MB3482.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LTO6F4fGTJ4dxBqk6UQsm2rukIPzTGvc8SWSzpvdFWkdTL0vgK+mr3mAoLUt7VkIfrN20NcVLD0ATGi9F6Y3tp620+1rVLOpTX2TrJnTs/6G0vHNausfph7Yz3nb9tkWJO3+l10LSuxSDSB+llfPVIwiCaRJ31j3sY6cY4bqgO2uqXwIL0aaYYziTzUoBURF616W8X5k/rqlD5Aei0IyUn1sWmMc8Pf1tP2hUSGHCRd7VmtQv/xSLE3HB9blJOihGB5OzR2sA01cNXoGrPI9jM5mPpwUL7sJ5N8Phb/1P4OiPiOiFj9N01qv7RvGtGPiPedmHEyb0X7ERF/KYn4mCOhAcbz2HdPxPrpwbPpVOHQVvyRPwwGDaW1jEDwAuTcDQRDIXxV7vazp771mWANvBMju2Vz9/1WIN5x+1Ru9zWz46UvfQ7uZGvvIQcgAdZ75BTyGcUlyL789ZQ53dzxa6xMOOFD3qrIq+FWYzITg8JAR0hgr1/EIasnEpiSX8I6KG0UZMCWqr+iaFjAjoIA+FQnxTWBUa07rJ7xFBFHSZ1PBSn3mHQTfLQf/QdKVp6Id3PJMcr6dGrycjrMnDk5njF1E6RttzCvNapB+FO5MRL0JacoHIGgyDr5nvk6O5Lz4IDsS6heHlrwZiXgRyt5b4QE8nNLzq105OiP79V9SsixS1Q+GFazxcJ8RFIgtzHKBIc9srwG0c56FqH/ke04YFg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(316002)(1076003)(15974865002)(44832011)(6486002)(83380400001)(966005)(66476007)(33656002)(2906002)(186003)(5660300002)(6916009)(53546011)(9686003)(6496006)(38100700002)(33716001)(4326008)(8676002)(508600001)(66946007)(86362001)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8rEGyj51d5YPwDD58dRlf0wc4pbUYW9mvwmOJ6lzUX9OyARmyD2TBau50Gz+?=
 =?us-ascii?Q?Lj+TctE3KfK0TIVNlJqVs7ffSRv19nxdev+jjq79jKBet4KgDXE9zuIX6E/E?=
 =?us-ascii?Q?UdvPD+RJcmNPqT0KU3R44J14sv9ern3Z4EOVsz6qu/O9nDNiqe78fWHwhuEf?=
 =?us-ascii?Q?dKrVxvV/xukgmPMF26TRXZCzBlVV+hfnmFNoyEXaM/DypY6AVze0MP0fKZlx?=
 =?us-ascii?Q?ZibDRwQuLdoLaG5VGQq0aSb0O/IoND0LrxiSrDLHDfhhgVwOKxisjdVPqfak?=
 =?us-ascii?Q?pVLxY+EE/1JwVrM65MdxyaxqfWrARF4sDdF5iZZfcSO60bUV+Mmn9O1HCkIq?=
 =?us-ascii?Q?7b9qxUro15F0cvJWbQwJJ+u4pHCGV+ZaoiijqBy6oYVIucTcX6xBXtQOZYL8?=
 =?us-ascii?Q?7dD9oMUe0mHqlIUAKfCm1LJ912v3ZZm6TvqZ0qAQkQAsNwPxqUeRpWhTAN1X?=
 =?us-ascii?Q?LZjwgcaKhVqK+x1bD4G+14lMSJFdznwuZHsE07xshQf2LFoDlDPqo50rDdDT?=
 =?us-ascii?Q?O4Ri2ScyWdVJliJ6uUOfuQVy2sBckyzR9jkto64szoS3NSySq8QiXEBTob6l?=
 =?us-ascii?Q?oGAMDIXTNO84rB/V2faKIBpgJqPemeGo9RDlUe6rM59TjchJPHwdzxrfRm51?=
 =?us-ascii?Q?N0YwJNuTx4L7ONbPKYf+c83CMjHG+eWUpMUG5EA6ItkS0Ep6xeYKevLsH6MA?=
 =?us-ascii?Q?zDHeo/a/0ND+EGYxhsZdL49lTIYT6S5jvRgMiFaG/O7r8i1pkErg1NzkOaqk?=
 =?us-ascii?Q?0VDqOTgbWqTN82G1o/dTWDCLZn2W3bymk7k44v0qGD1101kL8PWPWk3ogDZw?=
 =?us-ascii?Q?j5fM+iMgQa9qEpaH2NUU1TxZtZ595LfSbQt6M/i6hkSXCbcoMeXA1cWZn/tY?=
 =?us-ascii?Q?g3oq0RA1//UfRP53W9ZNopymND8B+tv6fm8bUZeQfNB11cVnXs+FDti6kvLo?=
 =?us-ascii?Q?QLdR72f4GZtLeUVVqykpetRllHfHSBJ2Qq4b030E7b2e6T1umf3Uwhrp5E5K?=
 =?us-ascii?Q?G5a6BwU+7vAAUzduv7fDMotVU7IVUP9ur2LPpg9d7lBuXIvC4XwLrDYk/18s?=
 =?us-ascii?Q?MHOM2Cnqm2iq+fJf4DcshaWorcbfTOz83iHRTmEabDWQ6fZEwTBAFc/f+S3f?=
 =?us-ascii?Q?jbF4Jk+o+uQphA1P47/2BYddj3Kk9+sB9kCTrZkd+ApQ0uvjEvb/PYSFlNSS?=
 =?us-ascii?Q?Yz+AeIgkPwDV58Y2j56QKN0vI11LNgMURnlGcPvhb8Hn7dmMDTqSp6sA058D?=
 =?us-ascii?Q?86CCZemsD8vxqOBHfftlcURHko4pW3MNjanqGSmLkH1a8b6obkWbXv4zoh4Q?=
 =?us-ascii?Q?z4LmDbOLw9+AQx5nviuZvCGPgz7t8NZhB/vjI0NhGSMdtiusQ4jmtNLqSkj9?=
 =?us-ascii?Q?IRElxSon9pPwwjRgQLwPBBBbKa0q?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da87c558-74f0-4f0d-f310-08d99adf14e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 13:21:57.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2pKzQssI81FJwmOTlx10CdzMEAZOdwslo07xaQTQAId6xdpIRF0IdosytfHHDgC4HTqVI3TAEEgRoYRUPjVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3482

Hi Matt,

On Fri, Oct 29, 2021 at 12:02:47PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the new version.
> 
> On 29/10/2021 06:40, Geliang Tang wrote:
> > Added the test cases for MP_FAIL, use 'tc' command to trigger the
> > checksum failure.
> > 
> > Suggested-by: Davide Caratti <dcaratti@redhat.com>
> > Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/net/mptcp/config      |  5 ++
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 75 +++++++++++++++++--
> >  2 files changed, 72 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > index 0faaccd21447..f522288b2204 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
> >  CONFIG_NETFILTER_XT_MATCH_BPF=m
> >  CONFIG_NF_TABLES_IPV4=y
> >  CONFIG_NF_TABLES_IPV6=y
> > +CONFIG_NET_ACT_CSUM=m
> > +CONFIG_NET_ACT_PEDIT=m
> > +CONFIG_NET_CLS_ACT=m
> > +CONFIG_NET_CLS_FLOWER=m
> > +CONFIG_NET_SCH_INGRESS=m
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 2684ef9c0d42..d33cb5ce0ff3 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -178,6 +178,12 @@ if [ $? -ne 0 ];then
> >  	exit $ksft_skip
> >  fi
> >  
> > +jq -V > /dev/null 2>&1
> > +if [ $? -ne 0 ];then
> > +	echo "SKIP: Could not run all tests without jq tool"
> > +	exit $ksft_skip
> > +fi
> > +
> >  print_file_err()
> >  {
> >  	ls -l "$1" 1>&2
> > @@ -232,6 +238,28 @@ link_failure()
> >  	done
> >  }
> >  
> > +checksum_failure()
> > +{
> > +	i="$1"
> > +
> > +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> > +	tc -n $ns2 filter add dev ns2eth$i egress \
> > +		protocol ip prio 1000 \
> > +		flower ip_proto tcp \
> > +		action pedit munge offset 148 u32 invert \
> > +		pipe csum tcp \
> > +		index 100
> > +
> > +	while true; do
> > +		local pkt=$(tc -n $ns2 -j -s action show action csum index 100 |
> > +				jq '.[1].actions[0].stats.packets')
> > +		if [ $pkt -gt 0 ]; then
> The CI [1] is complaining about that line:
> 
> [09:34:44.063] # RTNETLINK answers: Operation not supported
> [09:34:44.107] # ./mptcp_join.sh: line 256: [: null: integer expression
> expected
> [09:34:44.267] # RTNETLINK answers: Operation not supported
> [09:34:44.332] # ./mptcp_join.sh: line 256: [: null: integer expression
> expected
> (...)
> 
> This is displayed in a loop as it is a "while true".
> 
> But just before the first one, we had this:
> 
> [09:34:43.859] # Error: Cannot find ingress queue for specified device.
> [09:34:43.955] # Error: Parent Qdisc doesn't exists.
> [09:34:43.959] # We have an error talking to the kernel
> 
> I guess the previous "tc" command failed and I also guess you don't have
> that on your side, right?

Yes, it works on my side.

> 
> Maybe a missing kconfig?

I think so. How can I get the kconfig of the CI?

> 
> I guess it is "safer" to abort if one of the tc command fails.

I just sent a squash-to patch to fix this.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> 
> [1] https://cirrus-ci.com/task/6502115922149376
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

