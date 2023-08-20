Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E473E525D
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czKEzxVF4X4duzwLfsegA+z59a93z8Zw5ZK13LLeb7aRAbFLRq3VmpK8KzpiU0MrclVNuzLMC0UWji6Atnuz2qDwt6vftkrt3ARaYZEIvATmoO3vSysZSuNLu/G2M23wmuRb0mzYV3Wv/h9VB15Ox6unYERcwcfowG0Vy6VxLkGD3MzrzUbaW5S8Ny7K1p+YdpzjIKrrPM+mxpVA9/OJ+kLxz/uv/RYeANFnAsQZ43jcV00LnQs9FVIojqmWhf8KVgk8qUQZkUUl1XEawvSamlcXvdc+bfe+IJ6kGzsvnCQau6Tx78gm1sn5YTw9bnLOErCtmjv76pAeCNUq24p4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJi6uSQQSFhgJaPUZk6DYzBKRVmMCZ/jAyu+VmaALnc=;
 b=GarBv6xWgBRvNyjc2brGbd3Wh1RIRtyC4EpCeHnDrSbFhCxIjt4oCskdUryDtEXBL4fk0BoeEhTbqGZW+UwvP//VO8UYupQ2RuTPSJxciD+9s2w/ddfnSOZhY0R0yu1wqxqYeLZKsmNVEoLWvjGi5q6aoVxdpNiKoLKRbw3cdc7+D+/JqeA2WVqaoX1KC77j8yDXY2CMolJb0363D1sAfuroQRp6kuVb59L5X6USOyVXl/ek3D877Wrs7zr9d50O3688mI5B64buQZswOvoVFArdX/9HeMRWE5mq6fuJqMKXj9syj6dQB6aULXOlDqV8UprvdHYCp0Z3vdgDdqkHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJi6uSQQSFhgJaPUZk6DYzBKRVmMCZ/jAyu+VmaALnc=;
 b=YdxPqH684Ozy85gJ/Gr7txqrOET/MpDXSa33BmTlCFmCdqtclx/M+y5KhknXDI1NXUvXD8Yls61ia6FxjJa26nvMSLwMZr/7vvNIwzulQKHU+HLxnnVetzuFRx9i8Qzsbyflmk9A0LfReMMZdbg2yJq5yfM/b65Ay/uuL9AponqDvsdmuIQGqfpm+1PB/U64zDpcUhx1YK0k29aCfwaFXpVUmZPU3xuRhdOHz2iPIIAZVELFJzY0CEwQjm2gVMTodEy1nhzKzKgNXAluIGR0ygGjggQ1wvNH0MJW75GhjLRJWFv0nz81N+WxTDw3QZzVCq0nl4sjOw9JWJWnB2dAyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8349.eurprd04.prod.outlook.com (2603:10a6:102:1bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:23:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:23:14 +0000
Date: Sun, 20 Aug 2023 20:23:44 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 6/6] selftests: mptcp: userspace pm remove
 id 0 address
Message-ID: <20230820122344.GB13838@localhost>
References: <cover.1692342519.git.geliang.tang@suse.com>
 <f59ec3473deb3ebdd2a3e34bdab23ba79086b747.1692342519.git.geliang.tang@suse.com>
 <db9abb06-d74c-4e4f-bb39-380bce0b009f@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9abb06-d74c-4e4f-bb39-380bce0b009f@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cf0c93-de18-4e52-e6d8-08dba1783a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tZh1Um/Ll+4a+w1L3aW2G9kv4focumt3iYNgwHfAc4z9lr29nDHvluP2StJnIVoxh77dUk6x/7bN+GhMoZtfCtGucdwNVMoPH3vvenA1v1cYQuhpcyRXg0pIgOJOletzHygRVuGI2MXLrksaMgKYABCEqrj0iZ/zTcFnBpHYucXj69cW3fa2mUlKDCTKUs5e5ziPfrANieHEgNFBqn/j+OXv9iYkqTL4YQqckdMv41s/WQN4EN8SlfkAXahG3m4kExMyxRq3YUS8yqktpYq1PXelALhOc/5fmFzDDX6ktPL6i9ascqm+iJcdUCQWd+aSp3VFGY5ydrfIf9Dfx3FckJwfJxXVUeYNlePchVIsK7ZvVlbHw/ftyMF0c1wYst5wkrHqwrXHSe4aSi+wAH4plT3n97qHnz/uYPfYkgePsyx93nuZatYxykGOd//EJeprmAwUoofRAXMIq6gIBRI17Bo5pkU93e+tryqcsEFjbzduosqH3RkcYX+dLr3cOLorQYDMm7HsnevgIUEUUlol+yVd8dm3fP+qdlEf54lqSgwuaMOIAQYSKA3mTxWvFtfv09Mca6TWZuTTvgw3ih+3Qm23NNNxk1JySlp/AQngnOiUU64prg1MUiBpNM4MK80N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(366004)(346002)(376002)(396003)(451199024)(1800799009)(186009)(33656002)(316002)(66476007)(66946007)(66556008)(6916009)(2906002)(44832011)(4326008)(5660300002)(8936002)(8676002)(478600001)(1076003)(26005)(6666004)(9686003)(53546011)(6506007)(6486002)(6512007)(83380400001)(15974865002)(41300700001)(38100700002)(33716001)(86362001)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlJsuaeCjX5tGIky1FgjPLW1sh9pHVZioG29SnUjTRjjRayqsvTeTn+NgkED?=
 =?us-ascii?Q?klr9vmyGjRw/JIWkJDi53/gTJGVBGZVwBlF1zuXtnml74RWQuiHwCu4VI+zu?=
 =?us-ascii?Q?hdWlxyV2jbwSABcr0wiNkDcCvJqVP3d5m93/nDBtG/0fCMhjrlaoJrBeSQc5?=
 =?us-ascii?Q?WxArxdj6GSIde3VD3bq9yjtA6TJXMxLBtsC0KnKuSlg4TfoAQNEuZBjRq5Ys?=
 =?us-ascii?Q?PSvoxWK0QDLeQs/cS2DeHUx2gwF9Zm5O0m7zFrMHPP6talZ7f/TsMsbz6tNe?=
 =?us-ascii?Q?wLKS8RyRKPu9fT6IoprRDyJRg/WIoEeR4mvwEuhiU03B5R3N+z8e14xIlTpy?=
 =?us-ascii?Q?ByVN+L7r43zms+rIPmjsToQcOexkFUtBTKX4yr+ugNuEX7yATvOvg2tjfhod?=
 =?us-ascii?Q?i09U1S55NiGGi96eTVtXOerUtAB0FKNEIskZJldxwRedfcIDQOyduaKULGoI?=
 =?us-ascii?Q?yvwxxdblaqwtR8RHdHYJ6pr0w18izdC5EnJf8yaErx0WxEntAlf0rdj+cS1m?=
 =?us-ascii?Q?YYZ8Dzgb5MdTRRAK51iLRaMBUQCOjClAoNA/7sMNRd9oAxHoDdNl8KJC6ltI?=
 =?us-ascii?Q?nF3f60u2uJNLoHajrcQGnvyS9mVVj8lEcJE+rffs+0pGaBu9tAv5YSy/4HlL?=
 =?us-ascii?Q?h6VlyfbysM5irwqFO30v+Jw4xtlJmH7ZkEKphavsIVQ1kQHAH38hAuzA0r8j?=
 =?us-ascii?Q?rWENrzvhQi/S1Wp/hwJOQonNd7GULQb9bYit0YmJr5itwP4CRFKUK3AlT+0o?=
 =?us-ascii?Q?HiFGb2kC9vNeH5idtr/+207CJc/JvIlLiTPENNdEz++i2ZNMMuAsVb85C//b?=
 =?us-ascii?Q?yGSqRMLDGvEHIA7JXwkjbPTlsFbDEcSE/q0YRquF59M77HU65yvxUQTwMfml?=
 =?us-ascii?Q?mV/DMKflLdWMl5TgpWxMCy0ebolsues+pPVuNHKJgNhXT4PZyK4e3U98MYxV?=
 =?us-ascii?Q?Pp2EmDCx6PIJyPy9vhQwGUiVAdhhzHk/ozZPTA9fHslh82puilCcNCnlklDJ?=
 =?us-ascii?Q?lZb6E+btBbJQfDqet4Hfl1f372BLB/3oi8EEhjWTh4Og4eBJ4OCPbMkcSRAP?=
 =?us-ascii?Q?V3XYWz/+56qAwnnWqhaY0wCyBoPO7CID8okIyujfZsA4mN3twInPvnDPjHT6?=
 =?us-ascii?Q?+Yx7KFhAywlmTJ1/xKOjVosagbm0yr1FMA6R1MzNHwLPadcRlfo8qxexjZDJ?=
 =?us-ascii?Q?Mn2LvGysY5F5S7QfUOjVXaLTOgfaNxaWi3cOCwmQkQ0ciDhFRoTYlRYdAOph?=
 =?us-ascii?Q?DeWx3DAVjkkAo5aNYZ2fuCFMW0mi43eYK9qlvzU7UXunbgAyeF09va8O3p5P?=
 =?us-ascii?Q?3KAoDJK5irpEcVEf5aU37qRFCvUvtFYtltfeMEh3YdPhpkYxpCfxKn4NzWD7?=
 =?us-ascii?Q?e3MpzXxSRm9axBQX0vW0CrEQO7t3hODuZGnMtUe0L7OtrEy/ArK+BEo5xyZ6?=
 =?us-ascii?Q?bFiNIh1rzF2GJcrgQhR4b35bqEhVzqiUrZOdpSDYEde/Je7sY0gMuCor6Sd0?=
 =?us-ascii?Q?r4Rylg43VbupgRX+C9NrqgtQs94CiZ8w2Ba1LesYEBs/1PR7X0eVr7FxiQqq?=
 =?us-ascii?Q?vM0/rl97Dg63z9rOq2Vi6Yo93z+p7yMeGqyzNzXn57EcWANsNQnd52w4hViw?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cf0c93-de18-4e52-e6d8-08dba1783a1a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:23:14.8869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4C1O6Fqi1bQaFVm/dz8bcho1sji3wnVMj+/yZQ27fK1n5Bktliag08xEqstyumC0yHK5PttS/v5GxGVQnPidw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8349

On Fri, Aug 18, 2023 at 11:34:00AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 18/08/2023 09:12, Geliang Tang wrote:
> > This patch adds a selftest for userpsace PM to remove id 0 address.
> > 
> > A new helper userspace_pm_rm_id_0_address_ns2() is added, in it use
> > 
> >         ./pm_nl_ctl rem token $tk id 0
> > 
> > to remove id 0 address.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 322adac0cb1b..1c5c0bbae38f 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -3336,6 +3336,14 @@ userspace_pm_rm_id_0_subflow_ns2()
> >  	wait_rm_sf $ns2 1
> >  }
> >  
> > +userspace_pm_rm_id_0_address_ns2()
> > +{
> > +	local tk=$(evts_get_info token "$evts_ns2")
> > +
> > +	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id 0
> > +	wait_rm_addr $ns2 1
> > +}
> > +
> >  # $1: subflows in ns1 ; $2: subflows in ns2
> >  chk_subflows()
> >  {
> > @@ -3514,6 +3522,27 @@ userspace_tests()
> >  		kill_events_pids
> >  		wait $tests_pid
> >  	fi
> > +
> > +	# userspace pm remove id 0 address
> > +	if reset_with_events "userspace pm remove id 0 address" &&
> > +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> > +		set_userspace_pm $ns2
> > +		pm_nl_set_limits $ns1 0 1
> > +		speed=10 \
> > +			run_tests $ns1 $ns2 10.0.1.1 &
> > +		local tests_pid=$!
> > +		wait_mpj $ns2
> > +		userspace_pm_add_sf 10.0.3.2 20
> > +		chk_join_nr 1 1 1
> > +		chk_mptcp_info subflows 1 subflows 1
> > +		chk_subflows 2 2
> > +		userspace_pm_rm_id_0_address_ns2
> > +		chk_rm_nr 1 0
> > +		chk_mptcp_info subflows 1 subflows 1
> > +		chk_subflows 1 1
> 
> When we only send a REMOVE_ADDR, why do we have one subflow that is
> being removed? Is it because the other peer disconnected the subflow
> linked to ID=0?

Yes. And remove id 0 subflow test got this "chk_subflows 1 1" too.

When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
false, then tcp_disconnect is invoked. This will send a MP_RST to close
a subflow on the peer too. So chk_subflows after closing the initial
subflow is '1 1', not '2 1'.

In v5, chk_rst_nr() is added in these tests.

Thanks,
-Geliang

> 
> Do you mind checking this please?
> Because the remove address command should not result in a host sending
> both a REMOVE_ADDR and a FIN. That's up to the other host to take an
> action when the REMOVE_ADDR is received, no?
> 
> Cheers,
> Matt
> 
> > +		kill_events_pids
> > +		wait $tests_pid
> > +	fi
> >  }
> >  
> >  endpoint_tests()
> 
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
