Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97182F21
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 05:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644385655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dqfEsbvJOFNqbSDpVBjx4d/BNRQqtE6ezFftEDQlRzo=;
	b=cQuP6yr9/qOFEBBHTuhYrDBAroB7QCMfgaPnQBZFtVmG5HfLTDN8A+Q7LEm2GUVQ/M5l87
	UxcgTnS/Q9NcrePApTSu5RFMfR5yt038OwhqlPy9h+aOBXxfnZCmbe2fSrCL3fA+kUQU/1
	s/MqTNe2q/Z8sATMdoXXEfJfLzQsf+U=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-QYjp52tqP1SwSmlFDqxaJA-1; Wed, 09 Feb 2022 06:47:34 +0100
X-MC-Unique: QYjp52tqP1SwSmlFDqxaJA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwXd/PaQ7WeyCQFXtcZ2wxPc06ha+0Wsx8hDZ+fBkDnskUG7YbgHlyH5B5nxB9pZwd7GsWOU/XI4rxbm9iRk9wGpvT2/yOQKDPS84Mcs0opD+H5FQy5wcKEwrjzLQ9piMWJ8dY8kFTcn1jXTGOAaIEltuTKeAMUxwgmfbe8aMBX6K5Kt88jsn+jQU5P5Z2aK+1yt0Ukg1Mp9cTFY8gfWQkgidfF6Se9MfCHU/yqo+V7z4Y4lwQFfLhZPMlES6VQewYlUs2Sz5jx8+GTrJNFP6cNnvKZsVTkbhxC0H6JEjYxSizZQQWAz8WKBFyDzrGZuvX9bbiMiBh0r73Rvgb+JGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqfEsbvJOFNqbSDpVBjx4d/BNRQqtE6ezFftEDQlRzo=;
 b=g3E8m1r9h7/iyGGM7F3ZNuR8kZZnDdlOEwQSHOnC54sUncQRI94/MYmF+UzeeuZLq5UhehNfOtRvpmRqYwnW7KRx0pYaC8M3pCeVqy5PKY1ru/aH9cWRb4/YQCmdOw0LHA8pV3pp7/Bl7U2MYQfsl8C/E2dgSpqbdUlro6To35LYaKuJjGOX1w/9mUIpqpD4y7Ra7GgrB65CRMo+Nk/GsrkxF4HiFlXxyQotTYzgwCK3dNXi10nCH15MUTVz+dnej30mCJxPA86xZeF+WdcHeKMzlA0K1QJ88haXLcDcV3e7i7j7Mqri+vy056tIJNoGxjcSzhlaqMjv9bex98HryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5534.eurprd04.prod.outlook.com (2603:10a6:803:d2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 05:47:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 05:47:31 +0000
Date: Wed, 9 Feb 2022 13:47:58 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: add mp_fail testcases
Message-ID: <20220209054758.GA29565@dhcp-10-157-36-190>
References: <cover.1644364562.git.geliang.tang@suse.com>
 <846d7cac1f134fe9d3b6e8ac2b0c0ab47defc341.1644364562.git.geliang.tang@suse.com>
 <358eb7b4-84fe-d8e5-c0fa-e172c8deb7@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358eb7b4-84fe-d8e5-c0fa-e172c8deb7@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR04CA0080.apcprd04.prod.outlook.com
 (2603:1096:202:15::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0427467e-65c5-4b35-3053-08d9eb8fa9ce
X-MS-TrafficTypeDiagnostic: VI1PR04MB5534:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB55344464FCE0012CBE76C458F82E9@VI1PR04MB5534.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KF+EV2luuqAwpByBpoLwa/hRbyFqOhs/mra7wnaSAAF7nv5g0laB7oMbse6VZ4aHdWWGeKqV9ucGEb/ZSL6fI+dMPtnICaAVswT3NDl5VoNRFFUbTqireHEN6dFbsyqncLIE5AuIqnikitH0qqnkj15/+QsxnBI9b9oXAOHpw7c1PdAAtcOU/uOgYMiZ7E+MDdXQcuQuxHPKok4puqWwhxlX9xEp4BpL0xNYPl6ZlkPKuazGzSJhCY1bIZ0NaEQmMm9A7FSY8stho0dKEFQ0c3kY3Uyr6eGwjCy0WfVRZEeJbz0UM3Oosf9FpNvflrvPh0n7Y/GaikXmww8WCaf8tGOn0iCtPwvbDQICk034EI+BvJBUkL/yCp2j30RzJ9HPWmc4V9WkNqYd6n7EzL6qM/14hiQbO4yAd8STXWnVqvDA/6+6dGTfYpbrVSyrR7dsw3wpli9jLQzgNHto/Lf77NoXdwCF4yCGPbh4erAdySVnK5nciCJ/yqBVBLdTNOCC7btIxYFbsG2a2ZCt1hDcP7u2SMIptnkkWXonpiU7EHDl7Ftwph2dvB7qB4I0NbkWdPxhXzF+yvolXsbrfebL4mMt5aDc/83vUdQp61nD8zHcDyjaY1tdOZuZoMpAv2/QnfRQDzlPIPbFj6fpoa1cMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(83380400001)(33716001)(1076003)(26005)(186003)(30864003)(5660300002)(316002)(8936002)(33656002)(9686003)(19627235002)(44832011)(86362001)(38100700002)(66556008)(508600001)(2906002)(66574015)(4326008)(6486002)(6666004)(55236004)(6506007)(66476007)(8676002)(6512007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naJsKBGecIms7YzBVvyz9NBHgZlWVjdYiGuu7pzm/cXtM+MQ0qPOZaTBRRRy?=
 =?us-ascii?Q?jRidZWfgrRnBww5B0C9RMC8K6Tp4XprwKz/f5qtvzQKJ6DCKEYBKB5U1TrAX?=
 =?us-ascii?Q?xtdRlDNnHv5UsyhVdAqyM1nEjFf9RYLFQaUVNX9IothQxQGQifu5nvrwPVIa?=
 =?us-ascii?Q?XFP80A9/wYeFaiYwoDZr5qTF2YObnvCtrzvSrKoCUe1FkC7quMFgoy8s4kGN?=
 =?us-ascii?Q?675nZ+Lspw7W84po69UjoQk60AHhlhI3k8I1tmhJAuPKnePhm5adgqRf7Az8?=
 =?us-ascii?Q?xs2lbLStpQjfdqhnLBNuceCTgAOm1SjLxfMdCUPu+anyx1O2BZtC3C+N//ut?=
 =?us-ascii?Q?aGABA/Nk2RDAoEse2OekGv9VZQ023aUNwN0swo2k4Eg9bl28xHLoAsKmAiPV?=
 =?us-ascii?Q?cqRrIYciVNGKUftngm9DCCSRLu6gn8WGX5N8ixkoyHJQ11hvuxDSuaFqrsMs?=
 =?us-ascii?Q?RTLgyMZ58t4xLKJm3sxbzpl+IEyt/gfs537DsBjUvKJLd871+dfemVL5SwFo?=
 =?us-ascii?Q?fSnlq7fISnElCntIPs9eLxdmghLmmhecU4CiGmyryY4UakJt9CImusn4m5cM?=
 =?us-ascii?Q?x4eY7jKv79vji7ykbaoVunsdzaFTQcSDfimMbgtX9bIYKfQkITuJMvMogKHI?=
 =?us-ascii?Q?iN9ZQ2ynD3EaCv7VcdpYhfW/llbLqBzGOr8YTSfHV549YGy45J2ol+nBpX5h?=
 =?us-ascii?Q?m7R9a9pr8FNuKZhk4tSVNSUgrOA4yi7LQqMNAHexmje0C4MPncDSiNuvXDcB?=
 =?us-ascii?Q?VhAQ81mDEsfUl5rzHSOSsqtAp83B7snX9ojR/s7rbb3+caKXX0DosxULsnfm?=
 =?us-ascii?Q?agZm2qOcUNIIb4BbzjquFOA0DbWT7t3mhtEVLdqalZ/ogzlu0diQmTpldPYM?=
 =?us-ascii?Q?PcjH9ND+tfCvnp961UaLQ4oHSeHajBFbYwpAA7Cip3QmgKHfe9YOxXESBCIy?=
 =?us-ascii?Q?CpAmgi02643yzj9XfpEaSfQDog2jwkGa/V4XB1a/TKtYdy7nrBUtwZibWIh/?=
 =?us-ascii?Q?SXRjH6J51V9KQPFW3tD/NBud7d8Atm6swzO0RilgZin2haUgNtLOKpBhYNqG?=
 =?us-ascii?Q?w0p5qO4c10cp/BUvdmNAhmApejychhQVYLfebbaYqpaDD2ZLM4MEVHeQ8b02?=
 =?us-ascii?Q?i8KRS0a8yLnJjZML+nv+K2wGQSOBKSSOlqy0f2lG0qHO3csaeEBuvB+57E3R?=
 =?us-ascii?Q?PW6QCyZlA7Jt1VuM8Ptrtz7B/Xz7bWc4/0vMvh+oSzE9LWhMiw4jASoFhLWf?=
 =?us-ascii?Q?/maWfBmXnba4ijyXEVyIBeQTrQj7kIAo9rivrYNv5FRN6NVmFCGURp78IcmH?=
 =?us-ascii?Q?kiKjK73kk7J1uK2UjciO+AKA9AQIsuhsNbFCwDykS0U83qH8fM+19f+Inw6N?=
 =?us-ascii?Q?0YRNvS0EPB8KyZAmDgKcHtpkvtQ7E8Han/xCYwd9zhiIfWRacX5QpFxOXwwX?=
 =?us-ascii?Q?LUWlgA2onlz3zRaKapkVgElFTVmtzPYFk+ocQkHyu3MWBDQhvx5FTtRXGGJe?=
 =?us-ascii?Q?h61mhf/oieJjM334+Rh/9yONCP7bdL0NExq8sGXkZzqMWY0Z4ZdeB4Sg+JZ3?=
 =?us-ascii?Q?HuPgIqXNf1KIFNG8OyzLxilV2C2RMJOAlEPCosxPfZhr37UYzPAzb7I+giWa?=
 =?us-ascii?Q?RaXiQl7koS59Zc0uYGyjq2M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0427467e-65c5-4b35-3053-08d9eb8fa9ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 05:47:31.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QkV1c+w/GyFk7BdzFVhfYHOgh8jo5+faxx6U6ZwbSBxMClIpdINmBD8Zt6+o2qj5ESO23L+ztx5s0z+/fmZR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5534

Hi Mat,

Thanks for your review.

On Tue, Feb 08, 2022 at 06:10:20PM -0800, Mat Martineau wrote:
> On Wed, 9 Feb 2022, Geliang Tang wrote:
> 
> > Added the test cases for MP_FAIL, the multiple subflows test for MP_RST
> > and the single subflow test for the infinite mapping, use 'tc' commands
> > to trigger the checksum failures.
> > 
> > Suggested-by: Davide Caratti <dcaratti@redhat.com>
> > Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> Once I built a correctly configured kernel, this worked great! Thanks
> Geliang and Matthieu.
> 
> Before I fixed my configuration, I ran in to a couple of issues, see below.
> 
> > ---
> > tools/testing/selftests/net/mptcp/config      |   8 +
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 142 ++++++++++++++++--
> > 2 files changed, 136 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > index d36b7da5082a..38021a0dd527 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -12,6 +12,9 @@ CONFIG_NF_TABLES=m
> > CONFIG_NFT_COMPAT=m
> > CONFIG_NETFILTER_XTABLES=m
> > CONFIG_NETFILTER_XT_MATCH_BPF=m
> > +CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> > +CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> > +CONFIG_NETFILTER_XT_TARGET_MARK=m
> > CONFIG_NF_TABLES_INET=y
> > CONFIG_NFT_TPROXY=m
> > CONFIG_NFT_SOCKET=m
> > @@ -19,3 +22,8 @@ CONFIG_IP_ADVANCED_ROUTER=y
> > CONFIG_IP_MULTIPLE_TABLES=y
> > CONFIG_IP_NF_TARGET_REJECT=m
> > CONFIG_IPV6_MULTIPLE_TABLES=y
> > +CONFIG_NET_ACT_CSUM=m
> > +CONFIG_NET_ACT_PEDIT=m
> > +CONFIG_NET_CLS_ACT=y
> > +CONFIG_NET_CLS_FW=m
> > +CONFIG_NET_SCH_INGRESS=m
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 90a6adc36490..686c54276ea9 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -17,6 +17,8 @@ capture=0
> > checksum=0
> > ip_mptcp=0
> > check_invert=0
> > +validate_checksum=0
> > +nr_mp_fail=0
> > do_all_tests=1
> > 
> > TEST_COUNT=0
> > @@ -62,6 +64,7 @@ init()
> > 	done
> > 
> > 	check_invert=0
> > +	validate_checksum=$checksum
> > 
> > 	#  ns1              ns2
> > 	# ns1eth1    ns2eth1
> > @@ -167,6 +170,52 @@ reset_with_allow_join_id0()
> > 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
> > }
> > 
> > +# Modify TCP payload without corrupting the TCP packet
> > +#
> > +# This rule inverts a 8-bit word at byte offset 148 for the 2nd TCP ACK packets
> > +# carrying enough data.
> > +# Once it is done, the TCP Checksum field is updated so the packet is still
> > +# considered as valid at the TCP level.
> > +# Because the MPTCP checksum, covering the TCP options and data, has not been
> > +# updated, the modification will be detected and an MP_FAIL will be emitted:
> > +# what we want to validate here without corrupting "random" MPTCP options.
> > +#
> > +# To avoid having tc producing this pr_info() message for each TCP ACK packets
> > +# not carrying enough data:
> > +#
> > +#     tc action pedit offset 162 out of bounds
> > +#
> > +# Netfilter is used to mark packets with enough data.
> > +reset_with_fail()
> > +{
> > +	reset
> > +
> > +	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
> > +	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
> > +
> > +	check_invert=1
> > +	validate_checksum=1
> > +	nr_mp_fail=0
> > +	local i="$1"
> > +
> > +	ip netns exec $ns2 iptables \
> > +		-t mangle \
> > +		-A OUTPUT \
> > +		-o ns2eth$i \
> > +		-p tcp \
> > +		-m length --length 150:9999 \
> > +		-m statistic --mode nth --packet 1 --every 99999 \
> > +		-j MARK --set-mark 42
> > +
> 
> I think it would help to check the exit code of iptables here, my first
> attempt was with a misconfigured kernel and it would help to fail in a more
> informative way:
> 
> $ sudo ./mptcp_join.sh -F
> Created /tmp/tmp.P4AWbNYGQ5 (size 1 KB) containing data sent by client
> Created /tmp/tmp.ny1Q9MWo85 (size 1 KB) containing data sent by server
> iptables v1.8.7 (legacy): Couldn't load match `length':No such file or directory
> Try `iptables -h' or 'iptables --help' for more information.
> Error: TC classifier not found.
> We have an error talking to the kernel
> 

Done in v3.

> 
> > +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> > +	tc -n $ns2 filter add dev ns2eth$i egress \
> > +		protocol ip prio 1000 \
> > +		handle 42 fw \
> > +		action pedit munge offset 148 u8 invert \
> > +		pipe csum tcp \
> > +		index 100
> > +}
> > +
> > ip -Version > /dev/null 2>&1
> > if [ $? -ne 0 ];then
> > 	echo "SKIP: Could not run test without ip tool"
> > @@ -185,6 +234,12 @@ if [ $? -ne 0 ];then
> > 	exit $ksft_skip
> > fi
> > 
> > +jq -V > /dev/null 2>&1
> > +if [ $? -ne 0 ];then
> > +	echo "SKIP: Could not run all tests without jq tool"
> > +	exit $ksft_skip
> > +fi
> > +
> > print_file_err()
> > {
> > 	ls -l "$1" 1>&2
> > @@ -245,6 +300,19 @@ link_failure()
> > 	done
> > }
> > 
> > +get_nr_mp_fail()
> > +{
> > +	i="$1"
> > +
> > +	local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> > +	local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> > +
> > +	if [ $packets -gt 0 ]; then
> 
> This triggered a bash parsing error when I did not have the added netfilter
> kernel config options:
> 
> $ sudo ./mptcp_join.sh -F
> Created /tmp/tmp.P4AWbNYGQ5 (size 1 KB) containing data sent by client
> Created /tmp/tmp.ny1Q9MWo85 (size 1 KB) containing data sent by server
> iptables v1.8.7 (legacy): Couldn't load match `length':No such file or directory
> Try `iptables -h' or 'iptables --help' for more information.
> Error: TC classifier not found.
> We have an error talking to the kernel
> Created /tmp/tmp.CvX8qnG1gC (size 512 KB) containing data sent by client
> Created /tmp/tmp.wenxUAgsj8 (size 512 KB) containing data sent by server
> ./mptcp_join.sh: line 310: [: null: integer expression expected
> 001 0 MP_FAIL, multiple subflows, MP_RST syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          sum[ ok ] - csum  [ ok ]
>                                          ftx[ ok ] - frx   [ ok ]
>                                          itx[ ok ] - irx   [ ok ]
> 

Done in v3.

> 
> 
> > +		nr_mp_fail=1
> > +	fi
> > +	tc -n $ns2 qdisc del dev ns2eth$i clsact
> > +}
> > +
> > # $1: IP address
> > is_v6()
> > {
> > @@ -446,7 +514,7 @@ do_transfer()
> > 		local_addr="0.0.0.0"
> > 	fi
> > 
> > -	if [ "$test_link_fail" -eq 2 ];then
> > +	if [ "$test_link_fail" -gt 1 ];then
> > 		timeout ${timeout_test} \
> > 			ip netns exec ${listener_ns} \
> > 				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> > @@ -466,13 +534,19 @@ do_transfer()
> > 			ip netns exec ${connector_ns} \
> > 				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> > 					$connect_addr < "$cin" > "$cout" &
> > -	else
> > +	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
> > 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
> > 			tee "$cinsent" | \
> > 			timeout ${timeout_test} \
> > 				ip netns exec ${connector_ns} \
> > 					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> > 						$connect_addr > "$cout" &
> > +	else
> > +		cat "$cinfail" | tee "$cinsent" | \
> > +		timeout ${timeout_test} \
> > +			ip netns exec ${connector_ns} \
> > +				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
> > +					$connect_addr > "$cout" &
> > 	fi
> > 	cpid=$!
> > 
> > @@ -632,7 +706,7 @@ do_transfer()
> > 		return 1
> > 	fi
> > 
> > -	if [ "$test_link_fail" -eq 2 ];then
> > +	if [ "$test_link_fail" -gt 1 ];then
> > 		check_transfer $sinfail $cout "file received by client"
> > 	else
> > 		check_transfer $sin $cout "file received by client"
> > @@ -681,7 +755,12 @@ run_tests()
> > 
> > 	# create the input file for the failure test when
> > 	# the first failure test run
> > -	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> > +	if [ "$test_linkfail" -eq 3 ]; then
> > +		if [ -z "$cinfail" ]; then
> > +			cinfail=$(mktemp)
> > +		fi
> > +		make_file "$cinfail" "client" 512
> > +	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
> > 		# the client file must be considerably larger
> > 		# of the maximum expected cwin value, or the
> > 		# link utilization will be not predicable
> > @@ -694,7 +773,12 @@ run_tests()
> > 		make_file "$cinfail" "client" $size
> > 	fi
> > 
> > -	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> > +	if [ "$test_linkfail" -eq 3 ]; then
> > +		if [ -z "$sinfail" ]; then
> > +			sinfail=$(mktemp)
> > +		fi
> > +		make_file "$sinfail" "server" 512
> > +	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
> > 		size=$((RANDOM%16))
> > 		size=$((size+1))
> > 		size=$((size*2048))
> > @@ -719,6 +803,8 @@ dump_stats()
> > chk_csum_nr()
> > {
> > 	local msg=${1:-""}
> > +	local csum_ns1=${2:-0}
> > +	local csum_ns2=${3:-0}
> > 	local count
> > 	local dump_stats
> > 
> > @@ -730,8 +816,8 @@ chk_csum_nr()
> > 	printf " %-36s %s" "$msg" "sum"
> > 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> > 	[ -z "$count" ] && count=0
> > -	if [ "$count" != 0 ]; then
> > -		echo "[fail] got $count data checksum error[s] expected 0"
> > +	if [ "$count" != $csum_ns1 ]; then
> > +		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
> > 		ret=1
> > 		dump_stats=1
> > 	else
> > @@ -740,8 +826,8 @@ chk_csum_nr()
> > 	echo -n " - csum  "
> > 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
> > 	[ -z "$count" ] && count=0
> > -	if [ "$count" != 0 ]; then
> > -		echo "[fail] got $count data checksum error[s] expected 0"
> > +	if [ "$count" != $csum_ns2 ]; then
> > +		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
> > 		ret=1
> > 		dump_stats=1
> > 	else
> > @@ -820,6 +906,8 @@ chk_join_nr()
> > 	local syn_nr=$2
> > 	local syn_ack_nr=$3
> > 	local ack_nr=$4
> > +	local fail_nr=${5:-0}
> > +	local infi_nr=${6:-0}
> > 	local count
> > 	local dump_stats
> > 
> > @@ -856,10 +944,10 @@ chk_join_nr()
> > 		echo "[ ok ]"
> > 	fi
> > 	[ "${dump_stats}" = 1 ] && dump_stats
> > -	if [ $checksum -eq 1 ]; then
> > -		chk_csum_nr
> > -		chk_fail_nr 0 0
> > -		chk_infi_nr 0 0
> > +	if [ $validate_checksum -eq 1 ]; then
> > +		chk_csum_nr "" $fail_nr
> > +		chk_fail_nr $fail_nr $fail_nr
> > +		chk_infi_nr $infi_nr $infi_nr
> > 	fi
> > }
> > 
> > @@ -2164,6 +2252,27 @@ userspace_tests()
> > 	chk_rm_nr 0 0
> > }
> > 
> > +fail_tests()
> > +{
> > +	# multiple subflows
> > +	reset_with_fail 2
> > +	pm_nl_set_limits $ns1 0 2
> > +	pm_nl_set_limits $ns2 0 2
> > +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
> > +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> > +	run_tests $ns1 $ns2 10.0.1.1 3
> > +	get_nr_mp_fail 2
> > +	chk_join_nr "$nr_mp_fail MP_FAIL, multiple subflows, MP_RST" 2 2 2 $nr_mp_fail
> 
> Is the first $nr_mp_fail supposed to be in the test description? It's not
> clear what it means in the test output.

I renamed nr_mp_fail to pedit_action and get_nr_mp_fail to
pedit_action_happened in v3. And updated the test descriptions like
this:
001 MP_FAIL MP_RST: 1 pedit action       syn[ ok ] - synack[ ok ] - ack[ ok ]
002 MP_FAIL infinite map: 1 pedit action syn[ ok ] - synack[ ok ] - ack[ ok ]

I put the variable pedit_action in the test description to distinguish
between the following two cases:

1
Created /tmp/tmp.vizRgvd6NM (size 512 KB) containing data sent by client
Created /tmp/tmp.UZqbnNdWAK (size 512 KB) containing data sent by server
001 MP_FAIL MP_RST: 0 pedit action       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - frx   [ ok ]
                                         itx[ ok ] - irx   [ ok ]

All checks passed, and no inverted byte received. In this case, no
checksum failure happened.

2
Created /tmp/tmp.vizRgvd6NM (size 512 KB) containing data sent by client
Created /tmp/tmp.UZqbnNdWAK (size 512 KB) containing data sent by server
001 MP_FAIL MP_RST: 1 pedit action       syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - frx   [ ok ]
                                         itx[ ok ] - irx   [ ok ]

All checks passed, and no inverted byte received. In this case, the bad
data is dropped correctly.

If no pedit_action showed in the test description, the outputs of these
two cases will be the same.

Thanks,
-Geliang

> 
> > +
> > +	# single subflow
> > +	reset_with_fail 1
> > +	pm_nl_set_limits $ns1 0 2
> > +	pm_nl_set_limits $ns2 0 2
> > +	run_tests $ns1 $ns2 10.0.1.1 3
> > +	get_nr_mp_fail 1
> > +	chk_join_nr "$nr_mp_fail MP_FAIL, single subflow, infinite" 0 0 0 $nr_mp_fail $nr_mp_fail
> 
>                      ^^^^^^^^^^^ same question
> 
> > +}
> > +
> > all_tests()
> > {
> > 	subflows_tests
> > @@ -2182,6 +2291,7 @@ all_tests()
> > 	deny_join_id0_tests
> > 	fullmesh_tests
> > 	userspace_tests
> > +	fail_tests
> > }
> > 
> > usage()
> > @@ -2203,6 +2313,7 @@ usage()
> > 	echo "  -d deny_join_id0_tests"
> > 	echo "  -m fullmesh_tests"
> > 	echo "  -u userspace_tests"
> > +	echo "  -F fail_tests"
> > 	echo "  -c capture pcap files"
> > 	echo "  -C enable data checksum"
> > 	echo "  -i use ip mptcp"
> > @@ -2242,7 +2353,7 @@ if [ $do_all_tests -eq 1 ]; then
> > 	exit $ret
> > fi
> > 
> > -while getopts 'fesltra64bpkdmuchCSi' opt; do
> > +while getopts 'fesltra64bpkdmuchCSFi' opt; do
> > 	case $opt in
> > 		f)
> > 			subflows_tests
> > @@ -2292,6 +2403,9 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
> > 		u)
> > 			userspace_tests
> > 			;;
> > +		F)
> > +			fail_tests
> > +			;;
> > 		c)
> > 			;;
> > 		C)
> > -- 
> > 2.34.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

