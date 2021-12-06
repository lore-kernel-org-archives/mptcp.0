Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81D2C9D
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 04:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638765210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b73MIFB50t0DF+ly4YJDNa0cAvxScj+VCIiJ923hQcg=;
	b=F9Cy3z77Ah2ySIH3sieo5cMntSHdJwMbdVFmC5bQUnlSKCmBhti8GY+srGfMsmIB1zooB0
	6nE7qWIZUzqxT5qucXtbiKQs6slZYRfYJdVREFb3v4WF2w4ub+VelT2s2diexGmUDa71Uz
	Hgv+uGtNRm1SPPehVzKZRPRh/QVBwz4=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-1aD-XQzRO6CzC9CpoYAquQ-1; Mon, 06 Dec 2021 05:33:29 +0100
X-MC-Unique: 1aD-XQzRO6CzC9CpoYAquQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLOrALfOZerU7lP7dEG0JhBMUaBHKVuTVH0DiZo8W9OvrzzYCUAYbnuHp8kKmzfpBFoiBNLq8adhxyPCBpWejQD8O8A60gT5oWVyN59e7YZQtmev5rK4y36PKyeN8ptqAyXScVy9CuwVylQJQN2g7oOKa54u61IrN/PSGeC/7oI3ZZlyCI/Uj43o9blvAC95urmvTj7dLHAUV63rUfuLx8k/2mwmw2iCjYJHc3NVUmR7t68K7wLLsdVVlxfro/l1Y+zu6HGCfe8hQl/Fj9EWARe5t+uPS3OZSEIMVmEhc7dlOV0QMLNx9yueePX/V3XRKgfJ/vg34/hQ6BU131XQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b73MIFB50t0DF+ly4YJDNa0cAvxScj+VCIiJ923hQcg=;
 b=ZAe/3r44tvKtiWBXPUdDpJXTaCy1UD5TSneWnFn+A2Jmvzx87lGJx3xG71u9GTkYQzd2BUQ5pdxSRMZJfGqW+OEkM7SfpwwYzexg8fYFrcS6bJEwtf7wD7p1ia8cxgT4VzjUKNi77C0tVsGA9Mps/T32e/HI8kTCKbjc3QGRxcbfuEkS5rb+o5Km0wokXtBLskiEfdneobNkMg6r97YaCeldHirXQWWUt5HCmGQewJLB2tX/1bLaRtYx6Gb+muVecs2sAyLa8DtGkYdWOhC7Md6KbGEgeeX9ZZ/adOZ0iX+fWb+GQkObRM1tAVoD8nkc/gQkz1JGDl5l7tALJ4KW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3225.eurprd04.prod.outlook.com (2603:10a6:7:24::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 04:33:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 04:33:15 +0000
Date: Mon, 6 Dec 2021 12:33:05 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] selftests: mptcp: add mp_fail testcases
Message-ID: <20211206043305.GA8840@dhcp-10-157-36-190>
References: <4dd1a9febb11730329ef3486c6dcb1eac3b68d9c.1638443671.git.geliang.tang@suse.com>
 <eb9275dc-b9bd-2299-c4aa-1b537a82b57@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9275dc-b9bd-2299-c4aa-1b537a82b57@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0172.apcprd02.prod.outlook.com
 (2603:1096:201:1f::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0172.apcprd02.prod.outlook.com (2603:1096:201:1f::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Mon, 6 Dec 2021 04:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd5db162-d219-46b7-1de1-08d9b871849f
X-MS-TrafficTypeDiagnostic: HE1PR04MB3225:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB322523816E3F19905B22A12EF86D9@HE1PR04MB3225.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69I6anoDbyJTIIAg5ZYFQXr4ICTx75dPPsHC/8zYK1lr1Gh15An1wolKYcQuIzkMU9vwNhnIbtwXtZSt25wYu8GpXH5TDVB9k/8m1EZp62lYBJrco5ZsCYJY9HOo3u9U8EfIgxm7BWQP8GcJG59dUjfbPWz6cIvV8kxbPkjDBs7gEhNqqRRGocnRiV7svIiLqrvAEBgd2leqr5AVvEHJA4z0Jrvp9xzruaOl1LjO7GYNXVXWW5UezHeirV+s+lcVgekpjt9P687cq5PMR8OxcJ4HFgijlhRABjAESGIVLRsndjt3Vnbey0uzhZFdwdrSBgXDT9D1M5X3juqHxD/c4xs25C/2zzmqg9s+FjOJyp2T3yEUgNh+c7mSxZ97IuLA9OEZb8T568S2j2mQ3Mi+Q6/NIVxAPyOjkkZVVGiBRFK2twl6qFsVp74EGKW/3DqJIJMJAy3KxkZCJ2XXoApZvV7tNRfHTv90Bw/xn3/fVr9RZRCN/BW0EqNNf5qgefUFAFN63SGSa1quWdLcgOgHqaFcg8sJFxAIgeQ2xWUU53BGFIc83NlJDCv1pmiUEkyFDgBhZNNZg1gVj2uIl7Z+nURHcLibqBcQ+sKASqZLdbf+RaNpaX0gKA19u2EN62lxXDKYBg1UW0n125HJTbHDwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(8936002)(6496006)(1076003)(33656002)(956004)(186003)(44832011)(316002)(6666004)(4326008)(5660300002)(8676002)(26005)(55236004)(6916009)(508600001)(33716001)(6486002)(86362001)(66574015)(2906002)(38100700002)(66476007)(66946007)(9686003)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dh5Xe+6EgrmtDooJ9lngEZIFSlZao4dy7il5cCvn5fyedvu+tpwxngf4qoZ2?=
 =?us-ascii?Q?06F5Mz8+8XZOnawpC9KYBZ0gdbihQ1s7Rva5kw4XsTQUYiwt6S4GeAwsG6H2?=
 =?us-ascii?Q?J5dPN/h47EtRwEn1AYszvf5gpnuy23tzqrXr0iY0HE3TpZBthISLWbQoqud/?=
 =?us-ascii?Q?0xpjJ6/ZCAcNNXVXfZ6n4Fw4UYReGaOWMFrZZZxmTyH8uf8yV3GDaoOi1ETn?=
 =?us-ascii?Q?FXZiK2DxkNuBo8xAdRE32XDVt7DaHuUrAaVu4vL41jBDu89wLJVDih+EtLMQ?=
 =?us-ascii?Q?eFzZ1VEglxMAD2fxuCBdSEcLhkBRCCgsKXAtCZ7UnswgXhKWJDfw357VkRpp?=
 =?us-ascii?Q?59vNke39ZHZRWhpCpP+TpybidznUeZKf83PbnN2gLQhDWhXYef3ptv/8i3Zd?=
 =?us-ascii?Q?jsth9OViHsjNNmQyr2lDPoGSONTSmCTrdjX/4LCafJEfps0tZoS/P3rj+DrL?=
 =?us-ascii?Q?Ssx75HCbBwyJpeDEoectYQTuMsD/BfsNF7lVnbwOZrPgi6uHhL4z2DwLt8i9?=
 =?us-ascii?Q?YUCn6laGlH9C9CmzF+R1j4MX7S1d5lpNh+3GFBUjJbTY7GzFrmL1yNSyB8C4?=
 =?us-ascii?Q?2mWEG7AP3zPvL2muf1j795cZDyOI9UD9ZaoAAi5aqANYfhfGz5xYfyA+hWnw?=
 =?us-ascii?Q?PnjPJLjVeRg4oK5EjwlxPoI0OBXn7UwbRFfSWjFzAV/G7wpD/Gr9ABGSpIqI?=
 =?us-ascii?Q?z9ijEcdkeOd+rUyq8Kmf5Ojd9RWF+bH8PQQxrVJhVgneKsPqknh30eBvUpcU?=
 =?us-ascii?Q?h3GhxJoX/rCrUZM8j+964YOLearHDMWXcapxv2165RsSXz42tiHsO45TMAnl?=
 =?us-ascii?Q?ck1biWwRt6KFMwGAFTvjOrbUBOkBW2XDYmK9lhxTsEUSh/SIS6c+/a//t8rX?=
 =?us-ascii?Q?w2Y4K8L3dSmJJFpVKwv5jAlbcF8K8LTeiTojYxD7AClcBTVMkP0z738hkrPR?=
 =?us-ascii?Q?MlI5zc0aFidZDP/p01dQw/AGTko+HoRE+31g0qFzFckPvnI9jOeVCkSJIs8l?=
 =?us-ascii?Q?K4qgdZwG1OgQ3kM26M0TrUV6VwWhpoP2fkUYs2X0FKcV1ZzEwWPjAeMma3OU?=
 =?us-ascii?Q?i8XJd7s4VQnG49D6RKYRv5gutocBV/Uf7abJSL8TXIk54sgoSwGZelmm9C8p?=
 =?us-ascii?Q?2l1XKzz1LJmMbZZ0T9yultRgLZ/rIfoog+Oa71I2KxPt4JczRRiQDynk8pBE?=
 =?us-ascii?Q?BFr0BlHKUQ9fxk4V1foFnXTfLKtXyXRWJJHdoriCjXJWyHqTHpemKsqPLG+5?=
 =?us-ascii?Q?vbiAblTwMRMn3DPvcB0h8YpUFw/etb7xBK+F3hI/5ZUwv81L2COmrj577cl5?=
 =?us-ascii?Q?m2pLemGGmvcMzni0B+bJvOeomU0YMb6yZaO6w39t8cxYPs8t8mLX4kZt+Otu?=
 =?us-ascii?Q?9ysD2/kzWqh7B0hmzBHPUnWai1d0iW87byFAH7qdGbe3B3sW0fyS/yKoFiA/?=
 =?us-ascii?Q?APDYbSlZmEQFrn7zpKmr7Tm6sIfbHH/9GhGOCMGAKZVR0y+EnlXbwH84CUBA?=
 =?us-ascii?Q?DhoimUJxmCaUoxNa/h5U/sWMkeoR6iCMk+PsNVO+3s4cGc9HGTHJeVK3VUOQ?=
 =?us-ascii?Q?pVVrVzi9Co+LKReVWmTeaVwr9ND+0oEBoyne1cKOVZUwyEj8Lx0Vrxulrlwf?=
 =?us-ascii?Q?MjOoJu7R7ap0RY0R8NwlxPA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5db162-d219-46b7-1de1-08d9b871849f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 04:33:14.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWJC23b7kHz5zKueChQg6gOXAKCvJYumTHstkrtOda+Vg4l2M4mfZ7a0cPqDEnr6IaDagJtvVLkoUACUCdZm8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3225

Hi Mat,

On Thu, Dec 02, 2021 at 05:20:16PM -0800, Mat Martineau wrote:
> On Thu, 2 Dec 2021, Geliang Tang wrote:
> 
> > Added the test cases for MP_FAIL, use 'tc' command to trigger the
> > checksum failure.
> > 
> > Suggested-by: Davide Caratti <dcaratti@redhat.com>
> > Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > v3:
> >  - "file received by server does not match" still there.
> 
> Other than the "does not match" errors in the files, the tests are passing
> for me and the wireshark captures show a single MP_FAIL in each test.
> 
> I would expect the file mismatch on the single subflow test, since it falls
> back to TCP and the packets are still altered after fallback. For this test,
> the script could just confirm the file lengths match. Or, better yet, have a
> custom check that confirms that the bytes in each file either match or are
> inverses.

I'll add this check as a squash-to patch.

> 
> But with the multiple subflow test, I would expect the checksum mismatch on
> one subflow to reset that subflow and throw away the data with the bad
> checksum. Then the remaining subflow would have unaltered data, so the files
> should match. (And if the remaining subflow had a checksum error, the data
> would be discarded and that subflow would be reset). Seems like the file
> mismatch here is indicating that corrupted data is not being discarded as it
> should be - do you agree?

Yes, the corrupted data is not being discarded. I've tried to solve this
problem for weeks, but I haven't solved it yet.

We use "sk_eat_skb" to discard all the data on the receive queue like
this:

1170                 if (subflow->send_mp_fail) {
1171                         if (mptcp_has_another_subflow(ssk) ||
1172                             !READ_ONCE(msk->allow_infinite_fallback)) {
1173                                 ssk->sk_err = EBADMSG;
1174                                 tcp_set_state(ssk, TCP_CLOSE);
1175                                 subflow->reset_transient = 0;
1176                                 subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
1177                                 tcp_send_active_reset(ssk, GFP_ATOMIC);
1178                                 while ((skb = skb_peek(&ssk->sk_receive_queue)))
1179                                         sk_eat_skb(ssk, skb);
1180                         }
1181                         WRITE_ONCE(subflow->data_avail, 0);
1182                         return true;
1183                 }

But it doesn't work. The corrupted data is still on msk->receive_queue, so
the corrupted data will still be received in __mptcp_recvmsg_mskq().

I tried to add this code to purge the receiving queue and the out_of_order
queue of msk too:

        __skb_queue_purge(&sk->sk_receive_queue);
        skb_rbtree_purge(&msk->out_of_order_queue);

Still doesn't work.

Please give me some help about this.

Thanks,
-Geliang

> 
> 
> 
> > ---
> > tools/testing/selftests/net/mptcp/config      |   5 +
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++++++++++++++++--
> > 2 files changed, 105 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> > index 419e71560fd1..37124a6891b7 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -19,3 +19,8 @@ CONFIG_NFT_SOCKET=m
> > CONFIG_IP_ADVANCED_ROUTER=y
> > CONFIG_IP_MULTIPLE_TABLES=y
> > CONFIG_IPV6_MULTIPLE_TABLES=y
> > +CONFIG_NET_ACT_CSUM=m
> > +CONFIG_NET_ACT_PEDIT=m
> > +CONFIG_NET_CLS_ACT=y
> > +CONFIG_NET_CLS_FLOWER=m
> > +CONFIG_NET_SCH_INGRESS=m
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 2684ef9c0d42..6de026689eff 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -160,6 +160,43 @@ reset_with_allow_join_id0()
> > 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
> > }
> > 
> > +# Modify TCP payload without corrupting the TCP packet
> > +#
> > +# This rule inverts a 32-bit word at byte offset 148 for all TCP ACK
> > +# packets carrying enough data.
> > +# Once it is done, the TCP Checksum field is updated so the packet
> > +# is still considered as valid at the TCP level.
> > +# But because the MPTCP checksum, covering the TCP options and data,
> > +# has not been updated, we will detect the modification and emit an
> > +# MP_FAIL: what we want to validate here.
> > +#
> > +# Please note that this rule will produce this pr_info() message for
> > +# each TCP ACK packets not carrying enough data:
> > +#
> > +#     tc action pedit offset 162 out of bounds
> > +#
> > +# But this should be limited to a very few numbers of packets as we
> > +# restrict this rule to outgoing TCP traffic with only the ACK flag
> > +# + except the 3rd ACK, only packets carrying data should be seen in
> > +# this direction.
> > +reset_with_fail()
> > +{
> > +	reset
> > +
> > +	make_file "$cin" "client" 20480
> > +	make_file "$sin" "server" 20480
> > +
> > +	i="$1"
> > +
> 
> Suggest adding:
> 
> ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
> 
> here so these fail tests always run with checksums enabled. Since MP_FAIL is
> not sent when checksums are off, it doesn't make sense to run without
> checksums.
> 
> > +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> > +	tc -n $ns2 filter add dev ns2eth$i egress \
> > +		protocol ip prio 1000 \
> > +		flower ip_proto tcp tcp_flags 0x10/0xff \
> > +		action pedit munge offset 148 u32 invert \
> > +		pipe csum tcp \
> > +		index 100
> > +}
> > +
> > ip -Version > /dev/null 2>&1
> > if [ $? -ne 0 ];then
> > 	echo "SKIP: Could not run test without ip tool"
> > @@ -178,6 +215,12 @@ if [ $? -ne 0 ];then
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
> > @@ -232,6 +275,24 @@ link_failure()
> > 	done
> > }
> > 
> > +mp_fail_del_dev()
> > +{
> > +	i="$1"
> > +
> > +	for n in `seq 1 100`; do
> > +		local action=$(tc -n $ns2 -j -s action show action pedit index 100)
> > +		local packets=$(echo $action | jq '.[1].actions[0].stats.packets')
> > +		local overlimits=$(echo $action | jq '.[1].actions[0].stats.overlimits')
> > +
> > +		let pkt=$packets-$overlimits
> > +		if [ $pkt -gt 0 ]; then
> > +			sleep .1
> > +			tc -n $ns2 qdisc del dev ns2eth$i clsact
> > +			break
> > +		fi
> > +	done
> > +}
> > +
> > # $1: IP address
> > is_v6()
> > {
> > @@ -371,6 +432,9 @@ do_transfer()
> > 	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
> > 		flags="${flags},fullmesh"
> > 		addr_nr_ns2=${addr_nr_ns2:9}
> > +	elif [[ "${addr_nr_ns2}" = "fail_"* ]]; then
> > +		mp_fail_del_dev ${addr_nr_ns2:5}
> > +		addr_nr_ns2=0
> > 	fi
> > 
> > 	if [ $addr_nr_ns2 -gt 0 ]; then
> > @@ -542,6 +606,8 @@ run_tests()
> > chk_csum_nr()
> > {
> > 	local msg=${1:-""}
> > +	local csum_ns1=${2:-0}
> > +	local csum_ns2=${3:-0}
> > 	local count
> > 	local dump_stats
> > 
> > @@ -553,8 +619,8 @@ chk_csum_nr()
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
> > @@ -563,8 +629,8 @@ chk_csum_nr()
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
> > @@ -658,6 +724,8 @@ chk_join_nr()
> > 	local syn_nr=$2
> > 	local syn_ack_nr=$3
> > 	local ack_nr=$4
> > +	local fail_nr=${5:-0}
> > +	local infi_nr=${6:-0}
> > 	local count
> > 	local dump_stats
> > 
> > @@ -700,9 +768,9 @@ chk_join_nr()
> > 		ip netns exec $ns2 nstat -as | grep MPTcp
> > 	fi
> > 	if [ $checksum -eq 1 ]; then
> > -		chk_csum_nr
> > -		chk_fail_nr 0 0
> > -		chk_infi_nr 0 0
> > +		chk_csum_nr "" $fail_nr
> > +		chk_fail_nr $fail_nr $fail_nr
> > +		chk_infi_nr $infi_nr $infi_nr
> 
> My suggested change in reset_with_fail would break this, so the conditional
> here would need to be updated.
> 
> > 	fi
> > }
> > 
> > @@ -1837,6 +1905,25 @@ fullmesh_tests()
> > 	chk_add_nr 1 1
> > }
> > 
> > +fail_tests()
> > +{
> > +	# multiple subflows
> > +	reset_with_fail 2
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
> > +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_2"
> > +	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> > +
> > +	# single subflow
> > +	reset_with_fail 1
> > +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +	run_tests $ns1 $ns2 10.0.1.1 0 0 "fail_1"
> > +	chk_join_nr "MP_FAIL test, single subflow" 0 0 0 1 1
> > +}
> > +
> > all_tests()
> > {
> > 	subflows_tests
> > @@ -1853,6 +1940,7 @@ all_tests()
> > 	checksum_tests
> > 	deny_join_id0_tests
> > 	fullmesh_tests
> > +	fail_tests
> > }
> > 
> > usage()
> > @@ -1872,6 +1960,7 @@ usage()
> > 	echo "  -S checksum_tests"
> > 	echo "  -d deny_join_id0_tests"
> > 	echo "  -m fullmesh_tests"
> > +	echo "  -F fail_tests"
> > 	echo "  -c capture pcap files"
> > 	echo "  -C enable data checksum"
> > 	echo "  -h help"
> > @@ -1907,7 +1996,7 @@ if [ $do_all_tests -eq 1 ]; then
> > 	exit $ret
> > fi
> > 
> > -while getopts 'fsltra64bpkdmchCS' opt; do
> > +while getopts 'fsltra64bpkdmchCSF' opt; do
> > 	case $opt in
> > 		f)
> > 			subflows_tests
> > @@ -1951,6 +2040,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
> > 		m)
> > 			fullmesh_tests
> > 			;;
> > +		F)
> > +			fail_tests
> > +			;;
> > 		c)
> > 			;;
> > 		C)
> > -- 
> > 2.31.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

