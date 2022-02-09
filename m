Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659072C9C
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644404101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFi5JaWU48AIYP3PEViMC0QNQuILLLXQgcOBYUYUwX0=;
	b=SEBga7Xv1Fwd2Zzb2ZFRey6WVNSoqo5ncR9xOIMhjFDkP+txw4qdRoZgYxKVbPFIgNF7Lw
	M1jf/DcT+u3Aa2YApslZEt58AqxFhjwVVdsFoyCC2TrZJJlg3xdiEACY7VijuUMY7SKiCq
	oKoKqfBUEBBAtkPKmozxNiIZWD/HF38=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-TMZGVcBgOIezvlZUfqg-kQ-1; Wed, 09 Feb 2022 11:55:00 +0100
X-MC-Unique: TMZGVcBgOIezvlZUfqg-kQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZTkp4klEXUoaf4h7gWwdWlK/5Cuozk0wXx5iEpAayBRBXl5jrT6noDLl0z0jZ8IzcnofywY2LCqxYQbm1zVJLC+WlRPg9BKJKOdSyt0OZ1+A7Dtg0wN80ON/Dt6wVfAhB0hJFtkq6bnvt/I1rNWd3TiWfe9uPysMNJGPehNGaSFI7Y926B4XjxkNOkNI5WQxrXOxd5dCrsQXgSlzQSEm87rLBKkJ0FCcoNm54OpB4cVoalhR+oIdLtcmmNVKJ8LsbzMaTt5vk5xnAHuR5EPQ6PHpTud+HiOmraqPxcDPE1vE+aRoCpqbzS44hE2CA3kkd3ZGbo3RqR6npcBVjBoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFi5JaWU48AIYP3PEViMC0QNQuILLLXQgcOBYUYUwX0=;
 b=OjsVP2+MiYYQGsfTNt8gAbUg6t1uOvngcXyAXvkqZ31T7h2ro1UNAF+ygijj3IGucS+CnwaS0/PNnZTKhMUllMUmx38TE0kxQuKMjKvP5VCGS3IfdNJfZm7wytwKdxGYx+LhaY9DlPHZdVU/tSz2DdinB95ycYMMq115iCTEQ7DKRCPPESdZQ287lLjC6mwgJJB8aGv3Tse8CwUjPKqZrk52h0x3ctyz8kK7L6HOL4Q1xMUyaDJ7DT9cekRquSdxPifGoiosT2kSnWhPPt7wm3osQO1p6bLrgC9ONwmiw75SQwrRdVRT/XhJX7o4RlO9JS35V0ylU954YGG73oQfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5386.eurprd04.prod.outlook.com (2603:10a6:10:81::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 10:54:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:54:58 +0000
Date: Wed, 9 Feb 2022 18:55:21 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 5/5] selftests: mptcp: add mp_fail testcases
Message-ID: <20220209105521.GA26714@dhcp-10-157-36-190>
References: <cover.1644396927.git.geliang.tang@suse.com>
 <7b3e19b0e0b8c3b651320897b25464e0f76806ff.1644396927.git.geliang.tang@suse.com>
 <55e50da5-25ec-3a66-6264-10d712c5ba6e@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e50da5-25ec-3a66-6264-10d712c5ba6e@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b28e059a-8901-4ec8-6345-08d9ebba9cfd
X-MS-TrafficTypeDiagnostic: DB7PR04MB5386:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5386A31CD29BC6E32254AD50F82E9@DB7PR04MB5386.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P24QCo9GmW4JIt9tEY80dJ6lzUHqAwQz2I0vajDpO1T/wgs7zD9c2SYF37FnkOh9ICdgsl/1USVjYSDWdOsR0fW+uwzyTVQFA2CiQIjCPqA/A+cbdQeG0SP6ba7goq2n/AL6TDgwwB3FpCoqh1jPosT0mBN1mAqHViismL0hkViv0dFAvSvss31xKJXKG71g4W6LXzXO1LRL43JHkaSSQJLg7VvW8PB7T2olYCZ5w/j0+EZuSNRu9ZDrwOKZuwhzEi2W5yLJe3qUZxXpcKt13HsMR8Ov2hKJjy0j3u6Gbl5rDHyvAL4TtpU9P/EtgqAbl7lIEdGMeSfZb8UcJZzP+4RjiOulYkLRrQfuDfjLkQCsDQhc+65UN+UScS6oG6A4LsoYBVoOQSmA3UGP0CO44+onhUnEReLehYOtYvcX+dgY7SObWKA4l+2PWZmtYYz77uZKxX58GDR86ZFNoVY6kvggLbwxvrbZamWagEygqOEEfSUUbnFojsGxrNy5x0R4IJSUqYBh0qoDX0CozreS737SBMlHakQ8VXjItVHSTtcUDU1xJUqQvIaqWa3RiTvH06wwV6Edh1tXK14YL2f5GHqFibQV5xkvjKZBT7zOrJ7wOR0Ge81b6sR94nvsJv1xHHJcKhX5zaZxgVJY7rOLK1w/Ku4T8GkWZThydxACQKpAR3n34YcZoKKKRsx+A1fdLqclUwAc/BG30waN/10XrVp4Aks8Md4U/wrkHhRyRVw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(1076003)(316002)(2906002)(44832011)(6666004)(66556008)(86362001)(55236004)(53546011)(38100700002)(66946007)(8676002)(508600001)(33716001)(6486002)(8936002)(4326008)(6916009)(15974865002)(26005)(186003)(9686003)(33656002)(83380400001)(5660300002)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t4js1kGxx/q4lurG658MnEzJgtdyNEsFXSBRCcF4OB79zk9MFCjt+Oa8QYQJ?=
 =?us-ascii?Q?4EKp2UpsB5Gr8Qe2YV+DzAj99fiK+COD7oRxF5BjrU8rYi5uDX1HTT2jc5KL?=
 =?us-ascii?Q?zxV6HSGDXsFw9jOwHg7IAVh/DFPNu4AB5GHMGIs4iRBPNmLMjjGfgff7/QmV?=
 =?us-ascii?Q?0L/9G58Z5okYE1rT7+vNq7WITqcW6YTh74KFSg+WhiGOe42CSFPfJbgVPTXr?=
 =?us-ascii?Q?acL/yG6hxlZJDKdsVXp4E2DhZbpFRjpSE9BOGbVhjH4f4dhO7NH59ISpU9+L?=
 =?us-ascii?Q?v3E5u/J6MnYssplckVDNREp9Xh+wA9h8ff+lrCaKagmVD85imEv2BY4YWrDG?=
 =?us-ascii?Q?5zZje10Wbi5ZMxb05Pe5wtzgYo+j4+8WykHqC03FlAw+GQ84NEhFHaYo/kfl?=
 =?us-ascii?Q?cdDqNSHJdSJVnU0FyGDw98rCp9L3dwQu7LlrqKMNhpOsH4AgK55MLSJ8O169?=
 =?us-ascii?Q?/CUxLTFf+TOZbEzQOlq4DkJ/Js4A718JEFMICivAHX8ZVTK4nAgyX1sGzW70?=
 =?us-ascii?Q?65Jxv0UigNePEpOredhaiCC7VWT4xM7eV5oVwFxC2j2UNujxP3qA/xiL+/qS?=
 =?us-ascii?Q?fmmCeo4iPmL96uCKy3Ojn7Rv3ljwfRHz0QegFKFYMEfq8FXcVSGstPrkKSS7?=
 =?us-ascii?Q?9KSY3s83DDFn7uGi3Oyv430KlshXLHYyvHGbyTSjsiUruNA/x0rSlZncZZXu?=
 =?us-ascii?Q?poSDW6yNUlDf1Ab1PlrcFZHknNsLLSyETh4v/wy6P+dsWyjwhzFYAon2T2Gi?=
 =?us-ascii?Q?fzayNPnpLwXG6sOeea7/82OSa+GK2zy8EFp+VADIXhIhkaKfpMoLf3vYXDXh?=
 =?us-ascii?Q?Bm/Tt0JCynznswhavDqnhnxEf+w1Enj0WdSFu0HqFFpdPsjgu67xYs+DNfBl?=
 =?us-ascii?Q?2/RZWX4SvkiFWGuYL0s4tBpe8ZCwDkwvkRNkk4Luvct9WzSg33PuJHWN50ip?=
 =?us-ascii?Q?A5GYs5ECU/6sVXkVVq67BpZtD+y158ed4fHJgWyjxyOCqLFl2QjGUpi0wUg7?=
 =?us-ascii?Q?LNjOePu4g2nMR1AKBQrYbxvW0qUsxRNaaHmJNaK6C4NB0dU3DKyWVDY4PB+J?=
 =?us-ascii?Q?PJSY9fzIwgSqbx5j+5OmHHhcAaR5CD7XdGY6A7N+Dxq41L+M0NawaLS5fjkV?=
 =?us-ascii?Q?9LIo6Z37UomKoNOB6tk2GkYrEhdQ3RHlL/b2Y/YZxzzK8XafxUwboQxswV5v?=
 =?us-ascii?Q?8idvrMHA3DEtiKV9dNAdQMNU7QU5s2yOA+/qU6dqBC7PzcPgBjtgRCcknZFj?=
 =?us-ascii?Q?DpzaAu+lbMGiJGDgHxFCYopDUmmEtl1lq+MqEhU8NpSZwJCYk/9oYPbFDU3W?=
 =?us-ascii?Q?a94eBqIQWRZVrTtIa0RZvQYY9w7J6VrYFKTMDPTRNZCljABjiuehVklNvz2x?=
 =?us-ascii?Q?2MdWEaE6YmvdA+6s4dMbCZ+dgMpahImztpWQ4TY1R4TiuYyVB6j6LQ07MeBl?=
 =?us-ascii?Q?sXwzhfja5GuAbQc4O/TDQqYGkwU3A6GMzaLYBBSR/vFhF318Y9v7I8HxUu/e?=
 =?us-ascii?Q?+YYO/EbkwLlntwEUAm91WwVU7H6i8MqRSKPCyPeYMKVMlEu1YRzPkdK/rPvs?=
 =?us-ascii?Q?b4LxtuXC3Iea23xd1nDDkcRdk3pt4N7t7/A9ihwVUEmWNxYUZH/wR4NA+bJn?=
 =?us-ascii?Q?Yte2dLiYOThGNkQqqmdNCB8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28e059a-8901-4ec8-6345-08d9ebba9cfd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 10:54:58.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwFX9h4SzDJ1NYP1pBca7+EbO15/H2r2QOSh0dO8CmSs7YtQSqHFeqQAmAmt0e1YdXkLDVb0qWaPEURsxVxucA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5386

Hi Matt,

On Wed, Feb 09, 2022 at 10:23:52AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/02/2022 09:57, Geliang Tang wrote:
> > Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
> > case and the single subflow one for the infinite mapping case.
> 
> Thank you for the new version!
> 
> > These tests used the new test_linkfail value 3 to make 512KB test files for
> > both the client and server.
> > 
> > Added a new function reset_with_fail(), in it use 'iptables' and 'tc
> > action pedit' commands to trigger the checksum failures.
> > 
> > Added a new global variable pedit_action to trace whether the tc pedit
> > action happened during the test. Check and set it in the new function
> > pedit_action_happened(). Show it in the test description and pass it to
> > chk_join_nr() to check the numbers of the checksum failures, MP_FAIL
> 
> Related to my comment in the v2: I don't think it is a good idea to pass
> it to chk_join_nr(): we expect an MP_FAIL, we should not ignore it if it
> was not there.
> 
> (...)
> 
> > +	ip netns exec $ns2 $tables \
> > +		-t mangle \
> > +		-A OUTPUT \
> > +		-o ns2eth$i \
> > +		-p tcp \
> > +		-m length --length 150:9999 \
> > +		-m statistic --mode nth --packet 1 --every 99999 \
> > +		-j MARK --set-mark 42
> > +	if [ $? -ne 0 ];then
> > +		echo "SKIP: Couldn not add the $tables rule"
> > +		exit $ksft_skip
> > +	fi
> 
> Related to my comment in the v2: I think we should exit with an error if
> the IPTables command fails.
> 
>   (...)
>   -j MARK --set-mark 42 || exit 1
> 
> The error message from IPTables should be enough I think.
> 
> In Mat's case, it was confusing because the test continued and even
> succeeded!
> 
> > +
> > +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> > +	tc -n $ns2 filter add dev ns2eth$i egress \
> > +		protocol ip prio 1000 \
> > +		handle 42 fw \
> > +		action pedit munge offset 148 u8 invert \
> > +		pipe csum tcp \
> > +		index 100
> 
> Same for these two tc commands, we can add "|| exit 1".
> 
> (...)
> 
> > +pedit_action_happened()
> > +{
> > +	local i="$1"
> > +
> > +	local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> > +	local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> > +
> > +	if [ $packets != "null" ] && [ $packets -gt 0 ]; then
> > +		pedit_action=1
> > +	fi
> > +	tc -n $ns2 qdisc del dev ns2eth$i clsact
> 
> It is a good idea to keep this just in case there was an issue with TC.
> But then, I think we should print the number of packets, that's enough no?
> 
> (also we don't need to delete the clsact, it will be removed when the NS
> will be removed)
> 
> So it would be enough to have:
> 
> --------
> pedit_action_pkt()
> {
>     tc -n $ns2 -j -s action show action pedit index 100 | \
>         jq '.[1].actions[0].stats.packets'
> }
> 
> (...)
> 
> chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkt) corrupted pkt" 2 2 2 1 1
> --------
> 
> We can even remove the dependence to 'jq' for this simple command:
> 
>     tc -n $ns2 -j -s action show action pedit index 100 | \
>         sed 's/.*"packets":\([0-9]\+\),.*/\1/'
> 
> WDYT?
> 
> > +fail_tests()
> > +{
> > +	# multiple subflows
> > +	reset_with_fail 2
> > +	pm_nl_set_limits $ns1 0 2
> > +	pm_nl_set_limits $ns2 0 2
> > +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> > +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> > +	run_tests $ns1 $ns2 10.0.1.1 3
> > +	pedit_action_happened 2
> > +	chk_join_nr "MP_FAIL MP_RST: $pedit_action pedit action" 2 2 2 \
> > +		$pedit_action $pedit_action
> 
> Related to my comment in the v2: we should not use $pedit_action in the
> args we need to verify I think. Instead we should probably then have:
> 
>   chk_join_nr "(...)" 2 2 2 1 1

Thanks for your review and suggestions. I updated them in v5.

We will get this failure in v5 in rare cases, about one percent
probability:

Created /tmp/tmp.e4nE5Q14mj (size 1024 KB) containing data sent by client
Created /tmp/tmp.QwpQYClFnm (size 1024 KB) containing data sent by server
001 MP_FAIL MP_RST: 0 corrupted pkts     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[fail] got 0 data checksum error[s] expected 1
 - csum  [ ok ]
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpInSegs                       311                0.0
TcpOutSegs                      937                0.0
TcpExtTCPPureAcks               155                0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpInSegs                       305                0.0
TcpOutSegs                      943                0.0
TcpExtTW                        3                  0.0
TcpExtTCPPureAcks               147                0.0
TcpExtTCPOrigDataSent           785                0.0
TcpExtTCPDelivered              788                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
                                         ftx[fail] got 0 MP_FAIL[s] TX expected 1
 - failrx[fail] got 0 MP_FAIL[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpInSegs                       311                0.0
TcpOutSegs                      937                0.0
TcpExtTCPPureAcks               155                0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpInSegs                       305                0.0
TcpOutSegs                      943                0.0
TcpExtTW                        3                  0.0
TcpExtTCPPureAcks               147                0.0
TcpExtTCPOrigDataSent           785                0.0
TcpExtTCPDelivered              788                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
                                         rtx[fail] got 0 MP_RST[s] TX expected 1
 - rstrx [fail] got 0 MP_RST[s] RX expected 1
Server ns stats
TcpPassiveOpens                 3                  0.0
TcpInSegs                       311                0.0
TcpOutSegs                      937                0.0
TcpExtTCPPureAcks               155                0.0
TcpExtTCPOrigDataSent           787                0.0
TcpExtTCPDelivered              787                0.0
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
Client ns stats
TcpActiveOpens                  3                  0.0
TcpInSegs                       305                0.0
TcpOutSegs                      943                0.0
TcpExtTW                        3                  0.0
TcpExtTCPPureAcks               147                0.0
TcpExtTCPOrigDataSent           785                0.0
TcpExtTCPDelivered              788                0.0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
                                         itx[ ok ] - infirx[ ok ]

Thanks,
-Geliang

> 
> > +
> > +	# single subflow
> > +	reset_with_fail 1
> > +	pm_nl_set_limits $ns1 0 2
> > +	pm_nl_set_limits $ns2 0 2
> > +	run_tests $ns1 $ns2 10.0.1.1 3
> > +	pedit_action_happened 1
> > +	chk_join_nr "MP_FAIL infinite map: $pedit_action pedit action" 0 0 0 \
> > +		$pedit_action 0 $pedit_action
> 
> Same here:
> 
>   chk_join_nr "(...)" 0 0 0 1 0 1
> 
> No?
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

