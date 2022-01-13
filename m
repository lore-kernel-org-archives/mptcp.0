Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0002CA1
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642070142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8JhkO4M6jPlS0TTa8U6pzDddsarDQ8RqXNcm4+CDsM=;
	b=D+UlUFHLpCrSp+O9R65hXwwKrUHSzTPT4ItFUDGuxhcztIvTRAy7BtYxOk1fI3liFdhn0o
	TMbTPUq8FlbzusTWF+oHJ23rbRv1rCu0a2Ui1TXr76Cl020iaYnaJ3QFN/d4duDCgKQq3j
	vXQTbVPk8znj18ewwoS3CuhGJcSsfpE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-Coh-n1NnNVan5eFG6hN-rA-1; Thu, 13 Jan 2022 11:35:41 +0100
X-MC-Unique: Coh-n1NnNVan5eFG6hN-rA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ndv/sgYdnWjK/6ppVtmRspUgSxRfCR0DT5jb/+391A3bi5bNIiitD/tRFSLt2CXLsrWwMfLSiaBtFhDlnyBXTNUb47E7xjMqLetGIctvElOdmIF7ut4I6kVI4GsvxkMSfVD55523WTI8XEaFAeJF8QYFZh9Oi6SPfIEQK+GsvghacIXUsbyj22vExLWxGNdCltw/SjvVQWG2qcjYF+1q/e8RFGjLcV5/bXgZQ42Pt9YhhGwuZBlKh+ssE5Ynfh2bjhdll5FjT2xreUqXiEjWQhC+HOtD/acp/+CndA9EyDGBRUNsOhNO+y45AuRCUZ9JpqR88vjppJx4mOnMQTLYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8JhkO4M6jPlS0TTa8U6pzDddsarDQ8RqXNcm4+CDsM=;
 b=h0Q0PAzQ4tk86L6C3MO/EPOGibQw+QUN+Tj5fCYsaMGY+htwFXh0VQ7eSxuttAvz0CT35JwR0W1OP/qTvq16a/0KF/Wrr6/ggXB9lQtIznifq8jOsKXcQleKvPGvd4OKOH8VXeuSVGJd77fmZQAsEIavnaPDJslELmTyrwsmCTFc4y5ocO1h300cXR/vbrHAQFDKn5b+FxZ0Pw+ABJAT5SY7IMfn5ysuUf3yzR7PepSLhLs0GPsaRyy2IMT9ly6CyXPZhUOSQEWlcospsVrGKzOKdN2o+PegocLddcFVmLz9H/tDBbnFOZQJ2+e6BllFEJ6WrjV67sDW5FdCOvLHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3621.eurprd04.prod.outlook.com (2603:10a6:209:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 10:35:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 10:35:38 +0000
Date: Thu, 13 Jan 2022 18:35:34 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join
 tests-cases"
Message-ID: <20220113103534.GA16094@dhcp-10-157-36-190>
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
 <263f77b0221bee6a9b99245e8c23f5ebafbe9137.camel@redhat.com>
 <20220111034543.GA11026@dhcp-10-157-36-190>
 <868181f675d5372fb202b4b81be690a8572988ec.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868181f675d5372fb202b4b81be690a8572988ec.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 447ad82e-54fc-4222-84a2-08d9d6807078
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3621:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3621C109D72E852D1031D0E1F8539@AM6PR0402MB3621.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wVlpw6xysmPi+YFt2zl1eScf4ZZlNm9UTbf6ZI7nsxVKYjTrH/x4VfnFdqGuBMZwgC3e9eDQF65nGj69ZZvXAFcXsXY/VcAA5bw9ZNXqfMSzMshk3Mpol2ADGUuIkIvEm51EX5JR57HRECaTv9VlNkzinRBI/rF82Xj4pQlVRDj3E6jw5GIgpLGZyK/b0ZlQg4H4bJmm8eh6Vdpw+XuwFZGOhuDP1zLtLz5Nk9QIF++eOknnhVMYVaakB08m0xUbezz7ECkfCyCdt3O3nNICXPJK5UNkbBNpVFFBXNNKPtWE6ZvnTdh4bxjJG0pxgx8leN46lOc1cRa9aO0ObqpR7b0Rm9CQpw/DUOuMEj8zjLwfCpZbqkT6OuMXV3eOFcjmZJ83uLe2jzhQrGSCQhBcJnyon4Iwywqgij9zpZjfjGe07zLV276nRfa3bIX9Fqg8z65QnqABJOpIfJYMvUCdxHKOuWCvbN3IaYlL0rCcSrGT9dEdkcPO+zIGNAl0jnHQYI/DtiIdC7x4b3E/Xk9SIpkx8fBu5br3egg40YuEqrq2s9GwgqTTMDGvBNHlQI+NA/s+1Aabtxu29u4mRiLYRmwR03qX4qBhoDR1nror38gvDi4Ai0Fs4IkTCEJaStHWHc27cBJvBA1ea1sbw0MSkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(508600001)(6486002)(4326008)(83380400001)(38100700002)(66556008)(5660300002)(9686003)(33716001)(6512007)(66476007)(66946007)(6506007)(26005)(6916009)(86362001)(2906002)(6666004)(44832011)(55236004)(8676002)(8936002)(1076003)(316002)(33656002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTWdZQVQ/ft0V9gJ6yFRHPjnYJIiEku7n3se1ZSxb2BwPdsOUAwmui96nW34?=
 =?us-ascii?Q?STPco2bYUc/6jFOBQcXQ1WlD5qrjWaMhrOMYJtkgBrp1dpnvi8VB/4Ks8fOM?=
 =?us-ascii?Q?7Sx9p04h7P48EzcMiDSRWqNOo4cPVGLbxj9wwF4WXtfZmx9scNOM6hIGnRqW?=
 =?us-ascii?Q?GAS7Z+aWffaUijuClx87/z5A95kg87O7Li9+VezcZOsy1DazddTssB5VGeAc?=
 =?us-ascii?Q?I0knlAD9H7aopXWj2vP7RFsr4bCfYtdei3rmOA/wEmlK4xkrykEXz3XRT8Ar?=
 =?us-ascii?Q?7YILKlXQh934AlVO/NBpzfe2q+4bRXIbF5iZpzsIVUJObxsqyc/NMpJZp0Dq?=
 =?us-ascii?Q?QJLTHfZ79kkOw2exFwI8R4RTSIx8Le1xvl+MfxrFdXxZ4DNR/gTjOlP0nPOe?=
 =?us-ascii?Q?vMXfX1EP9sMWEZPpSJdaWGb64a8+soTYcNRrHeV9L9X2srKS/wB8RP58fO53?=
 =?us-ascii?Q?XZ0lb4sQtrEfLV2wmuqUSFXkKnYRYXXYjAi6gTY7C1t9OL93Mc+63bP4l01M?=
 =?us-ascii?Q?20NbQe6IsAoOrHDO0cpz6OZtqqmtqqrIYmXjbdVBQU06yAFTOdbO455UvSM6?=
 =?us-ascii?Q?x/3VSWeVraeEVbSTsPyPLMjcfarwPyifhsGjP0rLV+TMFbYrG8EtDRWhj6EV?=
 =?us-ascii?Q?H+db3ZlqYyqn8W8lOX1m17WdCkAb/BTbwT4O3MHcTMSqu85gn9Qw8ot/KC9o?=
 =?us-ascii?Q?prNyDct9Yz+ogVlCU2ezWpuY9YPt1WkioUGkcGvgYNO8l07UsYTZsqY2xQAY?=
 =?us-ascii?Q?ZfVoT6N7siN35KBQXigL3mEzQFPwzuBLosq/IQs8nDOQXcmr7ab14k3X3EXr?=
 =?us-ascii?Q?Ft4efLsCOr/+7QVJgbxQkm5nrTXOJqeBPw9CYHxfbDNCVy/8/9zZl+PBRkbV?=
 =?us-ascii?Q?01oR1VOe8671NmABQ38UYklim/NyFI9CYqH254sBde3lJggy7YvoDRLHOP4E?=
 =?us-ascii?Q?gkLoEZUcaBJIF5Hrjq3A3eWqwtchCp/l3Ew0G+GNDMyXQE1qrQHJRqOYHcvZ?=
 =?us-ascii?Q?KViGZVePJYFja1niqnonP7NnRLmvTbrjZ9QhPV54VJPpfytBn60baaBRzYXo?=
 =?us-ascii?Q?Jxj/o5kOxCkyeM0A18R5LWvPpAi+WvKePFDdMVV0C2UUkaqhJ7v2QyusGQWg?=
 =?us-ascii?Q?Kwb332NAT9HaabUzJa4TlB3Wk6DjqDQKXvDU1dEdk10CmlNDWgMVrxcSC7iE?=
 =?us-ascii?Q?bbes6Cn6nsYqCsKARlc5B9s3xcRdub2MBOtKzQWY1I9z0qosi5PemXrzoIjk?=
 =?us-ascii?Q?A8TmI7r0ZmKTujmNpPIOFhvsiEWokam840jJ4Snt0HrMAko4j/hdjviktuZE?=
 =?us-ascii?Q?a4mZDzN/52uRCGByvw7/cSEoO7kVjJ2PzCX2PpuQqTQ8sNwCjAUU7eC3taOI?=
 =?us-ascii?Q?Prvo4zkrK0sAO2QvnSIMwrQiw7v7SoSEuRwvw16Ku5T1ao8qVWonWbwfNPHw?=
 =?us-ascii?Q?5/k69SWuKyRXjXqR6EMxh0ABemKhaZlMGx3RKS51U5MOznD7n4GsvZF5BvXE?=
 =?us-ascii?Q?rk0MMR09mdQjQ+0jdyMf7KODmCOQHtSZspjv+DQ/msKxXEe3AGoK6slbtl3E?=
 =?us-ascii?Q?TXCIFTxfOSjh4gPKyTxyJ9B11qhqIZTRlzMRhAuyBmvzBZ3gxWQNg70LWhj/?=
 =?us-ascii?Q?4uhAMbxKEm0U9m7KPnag15c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447ad82e-54fc-4222-84a2-08d9d6807078
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 10:35:38.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5Ulq+cjequSxagWApreWXo7WauNnaEB0YfEV3NMtldJFarO4VnDbb9htCh41bgq6G1tFocla9hhmv/JJpckMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3621

On Tue, Jan 11, 2022 at 01:02:15PM +0100, Paolo Abeni wrote:
> On Tue, 2022-01-11 at 11:45 +0800, Geliang Tang wrote:
> > Hi Paolo,
> > 
> > On Mon, Jan 10, 2022 at 12:11:38PM +0100, Paolo Abeni wrote:
> > > Hello,
> > > 
> > > On Fri, 2022-01-07 at 17:51 +0800, Geliang Tang wrote:
> > > > IPv6 removing test failed on my test every time, this patch fixed it.
> > > > 
> > > > 12 remove subflow and signal IPv6       syn[ ok ] - synack[fail] got 1 JOIN[s] synack expected 2
> > > >  - ack[fail] got 1 JOIN[s] ack expected 2
> > > > Server ns stats
> > > > TcpPassiveOpens                 2                  0.0
> > > > TcpAttemptFails                 1                  0.0
> > > > TcpInSegs                       54                 0.0
> > > > TcpOutSegs                      58                 0.0
> > > > TcpRetransSegs                  2                  0.0
> > > > TcpExtEmbryonicRsts             1                  0.0
> > > > TcpExtDelayedACKs               15                 0.0
> > > > TcpExtTCPPureAcks               23                 0.0
> > > > TcpExtTCPTimeouts               1                  0.0
> > > > TcpExtTCPSynRetrans             2                  0.0
> > > > TcpExtTCPOrigDataSent           24                 0.0
> > > > TcpExtTCPDelivered              24                 0.0
> > > > MPTcpExtMPCapableSYNRX          1                  0.0
> > > > MPTcpExtMPCapableACKRX          1                  0.0
> > > > MPTcpExtMPJoinSynRx             2                  0.0
> > > > MPTcpExtMPJoinAckRx             1                  0.0
> > > > MPTcpExtEchoAdd                 1                  0.0
> > > > MPTcpExtRmSubflow               1                  0.0
> > > > Client ns stats
> > > > TcpActiveOpens                  3                  0.0
> > > > TcpInSegs                       58                 0.0
> > > > TcpOutSegs                      53                 0.0
> > > > TcpRetransSegs                  1                  0.0
> > > > TcpOutRsts                      3                  0.0
> > > > TcpExtDelayedACKs               3                  0.0
> > > > TcpExtTCPPureAcks               29                 0.0
> > > > TcpExtTCPTimeouts               1                  0.0
> > > > TcpExtTCPSynRetrans             1                  0.0
> > > > TcpExtTCPOrigDataSent           24                 0.0
> > > > TcpExtTCPDelivered              26                 0.0
> > > > TcpExtTcpTimeoutRehash          1                  0.0
> > > > MPTcpExtMPCapableSYNTX          1                  0.0
> > > > MPTcpExtMPCapableSYNACKRX       1                  0.0
> > > > MPTcpExtMPJoinSynAckRx          1                  0.0
> > > > MPTcpExtAddAddr                 1                  0.0
> > > > MPTcpExtRmAddr                  1                  0.0
> > > > MPTcpExtRmSubflow               1                  0.0
> > > >                                         add[ ok ] - echo  [ ok ]
> > > >                                         rm [fail] got 0 RM_ADDR[s] expected 1
> > > >  - sf    [ ok ]
> > > > Server ns stats
> > > > TcpPassiveOpens                 2                  0.0
> > > > TcpAttemptFails                 1                  0.0
> > > > TcpInSegs                       54                 0.0
> > > > TcpOutSegs                      58                 0.0
> > > > TcpRetransSegs                  2                  0.0
> > > > TcpExtEmbryonicRsts             1                  0.0
> > > > 
> > > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > > ---
> > > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > index e48ce23d2386..41a2510e2f97 100755
> > > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > @@ -393,8 +393,8 @@ do_transfer()
> > > >  				do
> > > >  					id=${dump[$pos]}
> > > >  					rm_addr=$(rm_addr_count ${connector_ns})
> > > > -					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > > >  					wait_rm_addr ${connector_ns} ${rm_addr}
> > > > +					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > > >  					let counter+=1
> > > >  					let pos+=5
> > > 
> > > Uhmm.... this is equivalent to replacing 'wait_rm_addr()' with 'sleep
> > > 1'. It defeats the purpouse of wait_rm_addr itself: reducing the delay
> > > required for 'del address' related operation. Additionally, an
> > > unconditional 'sleep 1' could impact negatively in other test-cases.
> > > 
> > > Possibly some alike:
> > > 
> > > ---
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index e48ce23d2386..b209a303d1fe 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -366,7 +366,7 @@ do_transfer()
> > >  
> > >         # let the mptcp subflow be established in background before
> > >         # do endpoint manipulation
> > > -       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
> > > +       [ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 2
> > >  
> > >         if [ $addr_nr_ns1 -gt 0 ]; then
> > >                 let add_nr_ns1=addr_nr_ns1
> > > ---
> > 
> > This patch doesn't work on my test either. I changed it to "sleep 2",
> > the "remove subflow and signal IPv6" test still failed.
> > 
> > > 
> > > could be more appropriate, but 2secs to complete MPC + 2 MPJ HS looks
> > > really too much...
> > > 
> > > Can you please capture a pcap trace with the failing test?
> > 
> > The pcap is attached.
> 
> Thank you! 
> 
> I'm really fail to understand why that happens, but the server replies
> to the subflow endpoint MPJ syn with more than 1s delay, and that
> causes the failure.
> 
> The interesting part is that the ipv6 routing configuration is actually
> broken, as we lack an ipv6 route for the server on each link. The
> following addresses the issue here, but I don't see how things were
> somewhat working so far...
> 
> ---
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e48ce23d2386..cdfb7da47384 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -76,6 +76,7 @@ init()
>  
>  		# let $ns2 reach any $ns1 address from any interface
>  		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
> +		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i metric 10$i
>  	done
>  }
>  
> @@ -1545,7 +1546,7 @@ ipv6_tests()
>  	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>  	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
>  	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> -	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags subflow
>  	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
>  	chk_join_nr "remove subflow and signal IPv6" 2 2 2
>  	chk_add_nr 1 1
> ---

Hi Paolo,

This patch works on my test. Should we change this "single subflow IPv6" test too?

---

@@ -1654,7 +1655,7 @@ ipv6_tests()
        reset
        pm_nl_set_limits $ns1 0 1
        pm_nl_set_limits $ns2 0 1
-       pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
+       pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflow
        run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
        chk_join_nr "single subflow IPv6" 1 1 1

---

This "single subflow IPv6" test passes every time with or without this
change, but the "remove subflow and signal IPv6" test fails. What's the
difference between the two tests?

Thanks,
-Geliang

> /P
> 

