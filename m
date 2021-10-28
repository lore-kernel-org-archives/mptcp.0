Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1F72
	for <mptcp@lists.linux.dev>; Thu, 28 Oct 2021 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635413021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iet7SeFIppa77J/rPYTegL+6JXlJMyZr7fGAJZya8qc=;
	b=YrVud5aN6T7Imqxw9EQ2YlH2scucxUDOydwMhbeGzFoRo1Rk9/q5MuD2GJHSgOYB+McRIm
	c437CL69xHs4yZ0jNLN5N1gFncJK9xGZHlEhaYkMCK77V7LqXlq7DQfsOnw3AiNhUlA0ly
	kF8ddKAQCVlwoirOiUXJDD0IvD0zecs=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29--lOU-lU3Ndm6KVaOgOGvMw-1; Thu, 28 Oct 2021 11:23:40 +0200
X-MC-Unique: -lOU-lU3Ndm6KVaOgOGvMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VucfmgXLM+IIdhq5TGE4gbmH7EgRudL1fWHDvY7Ka6uiod0kHXPEbb9ncsyTP0iGkUMjdQ3Cz472ihw9PUJaezMeYLOO16Dfu0fM03bxU9SovJhWZyS08fmTK10ErMF/S1fWr8vG14KwBVic+MK3pFRUfmnQ/azCEv9QPCFU997DqT+/fWev3PFauPnC4sEK6HrFmKUKlemrlmSeJQ5jfDZ+lkyXIOSJ7+sueP+iXOVuC1f42jJGLl36fnE7vRGaAI2x5P0NbRviNc1gmcfpK9V8NXsQCosU5dj+RUKj/gvX7q6wkjo8kaxYngwmG463iJuPYvZTlyUM0LV23IvMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iet7SeFIppa77J/rPYTegL+6JXlJMyZr7fGAJZya8qc=;
 b=d+KB//C8sDvdFvCnCFS9BGyq2+qx7qdlN8oo3R0R3oyI3tKiERQlX2GtLzagFi2E7yFUaOlq7rSOHXTTYl7S2rMgLD1gRlDmLBEAWLg+o0ovMrSqrZu6xZ6yKNchY/SkTpIjK9KX1Nxh4dg+R9Ea1bCLVntbbCIMLeA9b0fNX34wMDVuPplUIZXCwK0EBrGtwikmlBEzWAjVyeBar1TBttz0eCoj+2WqEWepA5hz7AIHSHGIZjbL1pH+ZODQzD7j809RSkPgjDptFN1lhjMPteNzn0lJJrfKtBmx3R9qPTUJRa+V82KxTka2IA5uAfbxchPmZluafZI+4ys9OEydBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB2954.eurprd04.prod.outlook.com (2603:10a6:7:1d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 09:23:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 09:23:38 +0000
Date: Thu, 28 Oct 2021 17:23:38 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Davide Caratti <dcaratti@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: add mp_fail testcases
Message-ID: <20211028092338.GA6915@dhcp-10-157-36-190>
References: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfa01f99cbb0479029ad284b020dbb250d19b941.1635390811.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR0302CA0021.apcprd03.prod.outlook.com (2603:1096:202::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.10 via Frontend Transport; Thu, 28 Oct 2021 09:23:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e3df7a-987c-41a3-5062-08d999f49fb1
X-MS-TrafficTypeDiagnostic: HE1PR04MB2954:
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB295434C2B9BBE8199CE88614F8869@HE1PR04MB2954.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DuMScgfA78SGq2IbJpjfghnVJao4riNRa86Nllq5qS87Ardy9AL7/CbTGAYDp5NvA6nK8+upWdD7ReWRhxF/KriwvnR/0pfUTtfm3rYMHItLydYXIrpsqDdIsJhrpyLbb3bqFaC3rBz9FD2sCTvhTLovkMcqbxErT2o6GTtMGqRaldT4HPZS+Uhm+IInExGKYWK3oW3/oa4Z7Rvt0bZksxsXHmbd1HLUfVWP40b1E43aaKRc16mIoQhtMwY1BHn7tdS16VewjwullOdVENblMItXYgu0mhjJ2c6cKmE2B1ClPIOYfQ0gDk0sRtHD3G9x4RWyC4NJxWm2JzJWqB5uXUMoUf3fnIQSG3p9fJB/YArsKUXHU7yq1IsG4vLoX9Lp1u/B0jtfclbQrQ6lfBcFqEJBLOYE/aziPvYG97anbpGzLIFbY3kNMb1xI768DfWZfVTYqCEfnTaa5vxo21P63/MzgH6YXh7BYU9h49owSbkZzsG4gEkz4IdnhBSDhd2vUdJTgBgwp7tR9LO2NZ5jcLaDKGLc7qByq1w0eaRuHxuOO6Wg/K1+HS7PbVSjFSt2fJoQmeHFzNmQsExaCrnbVwlprlSX3UARlNlDcU7JKcgqdPo2R75WtTP2NduDXPNMLU2nrRrQwCmkC4WxJ7vlTg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66476007)(66556008)(6486002)(186003)(956004)(66946007)(55236004)(33656002)(8676002)(8936002)(1076003)(26005)(6916009)(33716001)(83380400001)(4326008)(9686003)(316002)(508600001)(54906003)(6496006)(44832011)(2906002)(38100700002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jSEQeznh4PqqOAk6QNMSaNpIA5JRBUIrrtjDsuGCiSU/zu+anZ+nU/zjrbd/?=
 =?us-ascii?Q?vrWoCPexyuGmYKXsU1oyldQg5uPQHmYnf8+XE9GpNDiXSnF44x4s0elN0oKl?=
 =?us-ascii?Q?uytRhq3/OIwcvT5EM7oOcvsOSj8EkwXV4USQgTZSYwEkOszwHJ3JZhND2jIB?=
 =?us-ascii?Q?h329q9DmLL3raKztEj0IXpPPM8DPiJ4RAobcoxGIGKmXBtWfFiaAqmJ44GFM?=
 =?us-ascii?Q?5OlPhirk+tsp/6eegLVfUYGO58TW6qR3n4qD/ng26EjBLGjs/GzAO+EK3nbW?=
 =?us-ascii?Q?3XhrC/hKg86OMh3J8c6dfhduiTjmkfbJtZ/vPaoOjNFpeQa3KpeOsmu+0WO3?=
 =?us-ascii?Q?NDa6gmR18obIjCrOFgP9gtU9my//UvmcNtqcjv6Z4hhAJovWJbvwhsHJWwQ5?=
 =?us-ascii?Q?WZlrhWzpQhXfu0WGcnwvxCM6zFJI4QmOBIk7wmQgchmVuE4nnMeNgwxx1bBt?=
 =?us-ascii?Q?aLgCAr4JBfKswFAtCcqLZ6Xsi9x162CnDm0Uj46Ks01UdkQGV0bsXVlG/KcI?=
 =?us-ascii?Q?uqN7J20ijqmsjKCOKw/eR79oz4hb472NJ4IWHs0dpMTgRYMoPPQ9Sy9a6DpB?=
 =?us-ascii?Q?QWJDxmNnlnsYAcsgkm3nkEBe37hDKr0k640MVJ0yiV4+eyGm2Tu+EzUUIjh2?=
 =?us-ascii?Q?HnUa+o/qu5ol4M5F4Nwkg8cniFszir3LcvROwbBWbkQpG81dFjb+odom1Hla?=
 =?us-ascii?Q?GFh+57sELRbq10NvZ7zwWUwi6ynDA7esl2Oj4qJ7Xqzh3UkMi3a3K4Ep2qh5?=
 =?us-ascii?Q?laErwcHfTfkqprauLCCjZq4DvpBhVw2I56KZFsx6qBNB8u3X/5XOWO1tX0fu?=
 =?us-ascii?Q?ma4nIw+smisHMsn7lmAyA7zplYseKuZRfcRvuRaC9WAECI5IdKaOQGoEnkAH?=
 =?us-ascii?Q?Ut5mmgk/jyFxP61yQJqXzwS7cwJ3cRycrjNHUZ6fyOIxru45aNiwR/kWWGHW?=
 =?us-ascii?Q?hM3nUA/0jm5LlfzPIxBOYFNkXn2atDpTJMfOzyhBTSuKjQE1tjmz2IXQn2dJ?=
 =?us-ascii?Q?650WVapX9YROp4JEu64B5zPlg9piP/33zuaoqagJVRoPP5gu5NbsddCJYHSH?=
 =?us-ascii?Q?zYT+J5a4OkzL7tKWF8QWtEz2CBSi7FJlmTc5Wkqh3jwZt9d3R2IWqIi7NhSC?=
 =?us-ascii?Q?uQnVXhLGa5cfYNtwrY9mimUI56ag2YbfaW2X8oby+14hNiPrttooqwIlbKQs?=
 =?us-ascii?Q?c5G7M4gCM1nYRk/IpTw9j/9fzHqbU7G3aJgZ8PgkIJepdiZ3Cw1jun0v0pCA?=
 =?us-ascii?Q?uiBJGYiv/rqZKysvMZLjVI4gvWubmSUUnr1/oHjCVbEYXfqjvGzDuJeQp7FY?=
 =?us-ascii?Q?gDbUhEtHZDEOnmMxBKPA+M7qjyz6QzobLxQ/OwK71yQlhWJ27dT4rJxVE0dF?=
 =?us-ascii?Q?Wx+WGALdlOf6Xsl3D5Ox9khksYTbmpWeBCC8td+Yh51ADiAzWINnqGmpmNGt?=
 =?us-ascii?Q?S4JQxbUd4LIeH3XYN0/TwmeD/rt68+o9u99jsWJR+degQtloHeChUBZfYDfr?=
 =?us-ascii?Q?O3Ha4W7NpxBFlX1LhMz6NIZRcsaSTJAKIoZbwnCwHpA5hf1gQkU73nNFRIR8?=
 =?us-ascii?Q?HWISsykSVi83k4r29WNyEZ5//fi5ibIkfltyUJKzPdDF1ueNw2IYyx8IK7ms?=
 =?us-ascii?Q?ebCfPoSyRJqR+3KVwoEVtnE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e3df7a-987c-41a3-5062-08d999f49fb1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 09:23:38.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVmrjrNGfUpZfrdUkZEvoz221PGpry3mBzxhW2FnSqEHzoRx7la+ZuMpHup2wRwprI/g2ghraJ7aYYpcqrFHXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2954

On Thu, Oct 28, 2021 at 11:16:12AM +0800, Geliang Tang wrote:
> Added the test cases for MP_FAIL, use 'tc' command to trigger the
> checksum failure.
> 
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/config      |  5 ++
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 60 ++++++++++++++++---
>  2 files changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 0faaccd21447..f522288b2204 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -15,3 +15,8 @@ CONFIG_NETFILTER_XTABLES=m
>  CONFIG_NETFILTER_XT_MATCH_BPF=m
>  CONFIG_NF_TABLES_IPV4=y
>  CONFIG_NF_TABLES_IPV6=y
> +CONFIG_NET_ACT_CSUM=m
> +CONFIG_NET_ACT_PEDIT=m
> +CONFIG_NET_CLS_ACT=m
> +CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_SCH_INGRESS=m
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 7ef639a9d4a6..95bac447f857 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -232,6 +232,29 @@ link_failure()
>  	done
>  }
>  
> +checksum_failure()
> +{
> +	i="$1"
> +
> +	tc -n $ns2 qdisc add dev ns2eth$i clsact
> +	tc -n $ns2 filter add dev ns2eth$i egress \
> +		protocol ip prio 1000 \
> +		flower ip_proto tcp \
> +		action pedit munge offset 148 u32 invert \
> +		pipe csum tcp \
> +		index 100
> +
> +	while true; do
> +		local pkt=`tc -n $ns2 -j -s action show action csum index 100 | \
> +			awk -F ',' '{ print $12 }' | \
> +			awk -F ':' '{ print $2 }'`
> +		if [ $pkt -gt 0 ]; then
> +			tc -n $ns2 qdisc del dev ns2eth$i clsact
> +			break
> +		fi
> +	done
> +}

I got this log in the dmesg output:

[ 2495.182631] tc action pedit offset 162 out of bounds

It looks like something wrong with tc.

How can I fix this?

Thanks,
-Geliang

> +
>  # $1: IP address
>  is_v6()
>  {
> @@ -371,6 +394,9 @@ do_transfer()
>  	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
>  		flags="${flags},fullmesh"
>  		addr_nr_ns2=${addr_nr_ns2:9}
> +	elif [[ "${addr_nr_ns2}" = "fail_"* ]]; then
> +		checksum_failure ${addr_nr_ns2:5}
> +		addr_nr_ns2=0
>  	fi
>  
>  	if [ $addr_nr_ns2 -gt 0 ]; then
> @@ -542,6 +568,8 @@ run_tests()
>  chk_csum_nr()
>  {
>  	local msg=${1:-""}
> +	local csum_ns1=${2:-0}
> +	local csum_ns2=${3:-0}
>  	local count
>  	local dump_stats
>  
> @@ -553,8 +581,8 @@ chk_csum_nr()
>  	printf " %-36s %s" "$msg" "sum"
>  	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
>  	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" != $csum_ns1 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
>  		ret=1
>  		dump_stats=1
>  	else
> @@ -563,8 +591,8 @@ chk_csum_nr()
>  	echo -n " - csum  "
>  	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
>  	[ -z "$count" ] && count=0
> -	if [ "$count" != 0 ]; then
> -		echo "[fail] got $count data checksum error[s] expected 0"
> +	if [ "$count" != $csum_ns2 ]; then
> +		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
>  		ret=1
>  		dump_stats=1
>  	else
> @@ -621,6 +649,7 @@ chk_join_nr()
>  	local syn_nr=$2
>  	local syn_ack_nr=$3
>  	local ack_nr=$4
> +	local fail_nr=${5:-0}
>  	local count
>  	local dump_stats
>  
> @@ -663,8 +692,8 @@ chk_join_nr()
>  		ip netns exec $ns2 nstat -as | grep MPTcp
>  	fi
>  	if [ $checksum -eq 1 ]; then
> -		chk_csum_nr
> -		chk_fail_nr 0 0
> +		chk_csum_nr "" $fail_nr
> +		chk_fail_nr $fail_nr $fail_nr
>  	fi
>  }
>  
> @@ -1799,6 +1828,18 @@ fullmesh_tests()
>  	chk_add_nr 1 1
>  }
>  
> +fail_tests()
> +{
> +	# multiple subflows
> +	reset
> +	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
> +	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags subflow
> +	run_tests $ns1 $ns2 10.0.1.1 2 0 "fail_2" fast
> +	chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> +}
> +
>  all_tests()
>  {
>  	subflows_tests
> @@ -1815,6 +1856,7 @@ all_tests()
>  	checksum_tests
>  	deny_join_id0_tests
>  	fullmesh_tests
> +	fail_tests
>  }
>  
>  usage()
> @@ -1834,6 +1876,7 @@ usage()
>  	echo "  -S checksum_tests"
>  	echo "  -d deny_join_id0_tests"
>  	echo "  -m fullmesh_tests"
> +	echo "  -F fail_tests"
>  	echo "  -c capture pcap files"
>  	echo "  -C enable data checksum"
>  	echo "  -h help"
> @@ -1869,7 +1912,7 @@ if [ $do_all_tests -eq 1 ]; then
>  	exit $ret
>  fi
>  
> -while getopts 'fsltra64bpkdmchCS' opt; do
> +while getopts 'fsltra64bpkdmchCSF' opt; do
>  	case $opt in
>  		f)
>  			subflows_tests
> @@ -1913,6 +1956,9 @@ while getopts 'fsltra64bpkdmchCS' opt; do
>  		m)
>  			fullmesh_tests
>  			;;
> +		F)
> +			fail_tests
> +			;;
>  		c)
>  			;;
>  		C)
> -- 
> 2.26.2
> 

