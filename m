Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D062104
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 09:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/zPYjHz05xtwup5uCeADh2YRShwSsmW7MqLOtLtef36VIvZMbLbBnq249s0D6B6NdsdEbn+jWeG6Blr8NGJq4yUMvb1V5cUuaEYJL2CHaWlpTBw60IveFlGSUex1LaZDvsl/odNySXqZvdHCMbYiDWVUHBmr8Xwm8E9jFHCERpvqP9BbuUmQeT7aaZJHn3kIZgehCrFFlkAQQoLYEQyqY2w0LJa6kzyjnSaDbSJGrr9h19SVHQ7+O0pvpIdhXsloqccbNyEdTQOEU/UjHird/9g3z/+ari6UoXyyD68IJRGiZlAkJK1jAksarkvLoNypo0Cz9BhsC5z8NqhE1pMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b/M6xsGikdrxJDzzBl4hLLC9Ip25LoHpTgtn99dDgM=;
 b=ALfmjOYj40Q6xPSTdDhfSSIxWhHpLO1hvFPtT6h1Wd12l5PVO/2Jf8EeZ/2A6tEcmPn+p9MQMtftcvmNegrPXn4t7zTX9h31PQ5AE+8h6KOwMAx9t1xnYDcxKDYNmQSqNHgTsnWQ7GjtqL66lNPU6nqZXctARB7YR6rbQVBdwHz3+zaWOBXh92C2a2H6WyaB32CHWsYHQOtj63Vbrmw79pcSEIycPTAOo8Kw/Sb1RSvVhJ1ASzIpHyi7cNYF8pMiHF5B2YeHkZMy32L2v94z8wfrDKqgy9IkyAP3/akHpCLBg3b5s2QZpTZAcANKoKAf5n18pL/32LyPRmvDXgBNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b/M6xsGikdrxJDzzBl4hLLC9Ip25LoHpTgtn99dDgM=;
 b=O3Y73af0QbArAI8Lun4Coxjce73NtXY5UBTNHY+xhtJxQzVJRUUxdHQnCda/G8tUG1OAC0bbg0dJqgSyZM579+6iHs58O/QqR9pTcNK9vyuDnyrLl2xV8V9dL0F6wb4OW6UR7aVz2nQas25FaeTgMeyoeMyMJD323aCVs1twgcDp/dOhjzi37V5hs2XLeJHtqfaa91snEc0Mq9gKEQcQkpuUDLviPsxbLLf8Pgmp1GhWaozdPHrJ8x2YlvIvC/xsF87eushor5DmCp8dRmEUSBxErO7StS0yaFEWnZTZKGW8weXzPqTwxlymEVcBio9Bt4oVdn4YZ6SXblTdc6M2Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Mon, 28 Nov
 2022 09:05:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 09:05:40 +0000
Date: Mon, 28 Nov 2022 17:06:19 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 1/4] selftests: mptcp: make evts global in
 userspace_pm
Message-ID: <20221128090619.GA16009@localhost>
References: <cover.1669383374.git.geliang.tang@suse.com>
 <7b755941b11aeb74e443e3178c07c143986a5227.1669383374.git.geliang.tang@suse.com>
 <e1f32a3438e563718778e393394fd5ae036444cb.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1f32a3438e563718778e393394fd5ae036444cb.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a58627-3bf3-4b4f-3046-08dad11fb8b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WEsmdvcagKL94MQUZi1aVikwMWCIbeDeAehY5orIiGZRoTgCHxFV7uZSceyiXE6VbiY0J9kPafgGHRmQoDE0wqAyJoOaprL0nYSCIFcSn5oluiVhFuZ8eGEajJPL9hO2q5+AoAwMtSv1GdarxcUYnSrH4vnawmO1gJ/8+ppD0C/QFc45U3BG0N6FhufOiZW6LEbyfjXMryGJUng+uOC4Tn+sfZDMtchtxcM2Yvod4P6wKLS/6exfVyBiojwLX/bu5+Dfg52lE9kwjP1+NU1g77bHn4WQT+/j5L3tQzT/C9bhBWMGb0D6jA1WQp6pk85Z4UPKkO2y7NVWHP1E8ZkUS6bG6gT1fcuRCc9hOJZRjULyJ8MKu3362EobRvoDloLPzwzuc/i/LCMzoZh3XAU4L9r/MYEGt3ruSXPTzJVIZdQhJ0ZYCBc0I4zh1QxiQGyaudxg0fSf3nCgPJvGv+9BSlCQSG6j/RD+I7yytgJ3ux2+HTOBowlKYOkBiGSe8t3s1NwFs1AahVb+WG1fT4KMq3Ni0BmMJZrlIlYriYvdFT8iTtvfKn06cmmuEXsk2bAzRFrbsCWWmn5gVQpGF4Y6tXGmsLvB6jH8qwbV7e8di/O9lK2laWBEnKPJS+ZY+yhx7TVeQiLKZsJLvcnr7Jybxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(6916009)(6666004)(9686003)(6506007)(33656002)(6486002)(6512007)(86362001)(38100700002)(26005)(186003)(1076003)(33716001)(5660300002)(8936002)(44832011)(478600001)(8676002)(66476007)(66946007)(66556008)(41300700001)(316002)(4326008)(4001150100001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixajtyPpm2LisyOaCahYAlCZ2gtA2m0ODddZe86k7jWZC141EVBV1q7vsmVO?=
 =?us-ascii?Q?1mYHaIgB2mhs6VkvgWgl3JhYYCDWKwbb/uA3J14JrcBUkwQS/x85PrS5Rtfb?=
 =?us-ascii?Q?grrKMCcWN9uRtHR1q1V+MEhvrNxe3J6l4hWDMgCiFaOZR2ivwcS3Lqv6pRoT?=
 =?us-ascii?Q?ZVquNHLGcSEaeLwaxiQ3nKRRQE5Q1+FVYG3A4F1dy/KDzu43fy0jCkGTbObT?=
 =?us-ascii?Q?JnRA7ucX3poL3cYskFfRsTGNcugP2CEbzPMiwcr5rjeKzF0bcscb13Y9eSlP?=
 =?us-ascii?Q?5NHv29nEjZqLEq3EMAxN9UyhXq/SbIqRIGuDC1yaN4lscoL1vrDI+XriJMFh?=
 =?us-ascii?Q?w1iX7fCP93CpWU9gK8nnDdVgyUasjru5DIrUpntALXsLaDNHf/f0XAVBIj6i?=
 =?us-ascii?Q?5FC9CnJmFiTskY3pH9q7rnrNN2JDvFPykNRkVlpnTtldM2Uc+rZafci6LHoS?=
 =?us-ascii?Q?wbo9R5Qe/NV8mCAg6yQBEPtxA+mLEpkinUY24wCiKXYqtdKjoBNTrF4NK7sd?=
 =?us-ascii?Q?r1QbGslu8zkyOapAoZEyDVeFMsS/xKOJXPMOdNOMYebyX2DdVWD5Vs9dcDhN?=
 =?us-ascii?Q?917euf0JP6xZwiF7ZlvETmRZwPnEqBM8+d51vxCP+HUhSbmiz3nAZIn0THFu?=
 =?us-ascii?Q?P1bMXi3+xfFDVu91G3fHX4hsNIPS/ZyhYeIDrLROV0fSeR2oxhy+T9tWYWWy?=
 =?us-ascii?Q?zecOg8cq+e7DWgtAeYnPLxpF1HAiSX+4+L00VxCB+UL4XfygdIdkik0TKWEu?=
 =?us-ascii?Q?g6LWcm6wYrTm4ckrGud2OIrYiQc3kQccOmsqJr7ZW1DCFKCTk2IwgO23SyIS?=
 =?us-ascii?Q?gFcDQko6cXZju77YWPByC2k4gm3LghkfOlreW3cAGc21/z0DPI6gXA1F9S7u?=
 =?us-ascii?Q?KRJaDMrWHsp/BXArom3PrL8xkAtLSIz1qZ8mphbMG6PbvQKGy0pvKZ2ZXUh/?=
 =?us-ascii?Q?jxKFS+UHgCfx/i60ff+4QtcvprH+6SlMQH0ookKJRPbkeIV+lvuA0KlpdPXe?=
 =?us-ascii?Q?v10jDDCJvvhRH+T7KmOes32bU16CzrDaqEKnzWE58AfOAHmCgyNZ26rSbwoe?=
 =?us-ascii?Q?2WF3ievJIAwE68u4t8NPoiVNzMwhEd+xhHk1Wcq53GQ+5MAgnND0AHfaS0nq?=
 =?us-ascii?Q?gwM2VMHaB7XHA0uyZ5mifD1r7lkYnR/QAXuxxa/VM9gHIQ1u2xc2B2HPfj5j?=
 =?us-ascii?Q?RkqxI8T96dVqMQsQLyaPg6/dQOosfyq+EZMNPvwNd3RkKOFjIvzT2+Q5eEYp?=
 =?us-ascii?Q?zCbY6GhqDhls31UKhnbnrXQk60cWuTVIx7l6dn9QawVna7fN29P+lBZkkFyu?=
 =?us-ascii?Q?ooaPAq7VvNPFsCgL34ctY9KagHlqUIuGgdBarvaxBFpBYLKYpdNVZ35fc80D?=
 =?us-ascii?Q?70P6FPVkR10eujjCWjO2jvXdAHiuKVy68jRicZs5w+l2GDpzP3d+ZJ1ACAkw?=
 =?us-ascii?Q?A30MONLnNn9HsVJYnYGk3jcSnoVreA7AcY9f02AHmTh80peePuxmwAoh9VTL?=
 =?us-ascii?Q?bOMoi9YPfeAQCCGL4avz7Aqx8dqCmiUuKC478aJMQPHBlNkqaKDW2X5ftdfZ?=
 =?us-ascii?Q?sDAjauQd4y7mw8zyzxwhXtJR1Yhmu5VoD1wqclbrUxxIzN5gkU1ccuJCmVIu?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a58627-3bf3-4b4f-3046-08dad11fb8b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 09:05:40.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN4WUVOGs9ZxyOEkYedu0v/otyZ/Il2xQRYhbUWcR5rc9g1hAC3I74oUYW5uhHOl7M9hMaY6pDxkSoG81R8Ybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609

On Mon, Nov 28, 2022 at 09:04:44AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On Fri, 2022-11-25 at 21:40 +0800, Geliang Tang wrote:
> > @@ -134,18 +140,25 @@ make_connection()
> >  
> >  	# Capture netlink events over the two network namespaces running
> >  	# the MPTCP client and server
> > -	local client_evts
> > -	client_evts=$(mktemp)
> > +	if [ -z "$client_evts" ]; then
> > +		client_evts=$(mktemp)
> > +	fi
> >  	:>"$client_evts"
> > +	if [ $client_evts_pid -ne 0 ]; then
> > +		kill_wait $client_evts_pid
> > +	fi
> >  	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
> > -	local client_evts_pid=$!
> > -	local server_evts
> > -	server_evts=$(mktemp)
> > +	client_evts_pid=$!
> > +	if [ -z "$server_evts" ]; then
> > +		server_evts=$(mktemp)
> > +	fi
> >  	:>"$server_evts"
> > +	if [ $server_evts_pid -ne 0 ]; then
> > +		kill_wait $server_evts_pid
> > +	fi
> >  	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
> > -	local server_evts_pid=$!
> > +	server_evts_pid=$!
> >  	sleep 0.5
> > -
> 
> Minor nit: I would not remove this empty line here.

This has been removed in v3 in the ML.

> 
> >  	# Run the server
> >  	ip netns exec "$ns1" \
> >  	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
> > @@ -161,7 +174,6 @@ make_connection()
> >  	sleep 1
> >  
> >  	# Capture client/server attributes from MPTCP connection netlink events
> > -	kill_wait $client_evts_pid
> >  
> >  	local client_token
> >  	local client_port
> > @@ -173,12 +185,11 @@ make_connection()
> >  	client_port=$(sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
> >  	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
> >  				      "$client_evts")
> > -	kill_wait $server_evts_pid
> >  	server_token=$(grep "type:1," "$server_evts" |
> >  		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
> >  	server_serverside=$(grep "type:1," "$server_evts" |
> >  			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
> > -	rm -f "$client_evts" "$server_evts" "$file"
> > +	rm -f "$file"
> 
> At this point is better to move even 'file' as a global variable, for
> the same reason as 'evts'

I just sent a squash-to patch against v3 to fix this.

Thanks,
-Geliang

> 
> >  
> >  	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
> >  		   [ "$server_serverside" = 1 ]
> 
> Thanks!
> 
> Paolo
> 
