Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CED15B5
	for <mptcp@lists.linux.dev>; Fri, 25 Nov 2022 02:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIJWtIXH/pJ09fjCFJzMk2gZNtERj52RzlxbV6rJ0kNLm0pe8PhGWquHPj0PNEDQF/w5x8UEw6nqaCiuuelObfQKdj2WsL7wz7r9jWXgP82myeebuehPIUnhZXpH/RgvjZNCthg39Hnm+Uo30f4Y7wCWwQMRGcNoJs7+TPxfdyjGerVVUZ9nAi3Cj8A6Cs1U0KXfPwYb7sNBzyczheYfZrxxvpeFY9oApq/5I58EDQ0Hpwelp6X7BvY7JeoAZIWiH5n6yYaMnYcxblAHlC6AMDnaQMSQPmxgI34aQLvIvhyQvPtKaK76x94vud6daOFDmYMnpU/mg/amNs3iFPymyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmNMMvI06nQq17S4dJJOsTEI1hinunTY7U7qva4rek0=;
 b=JOmVV6ZlQTiRe/gT7pG2Sqg5ZsjMoOGdwoUjriqRN5zYiVUDhazkU3/eq1nSYqztYVeivnKRPYaacCSP8cpPUw9HjHW6gxv+EAXj2aJIYBHYMDnLxRlhG43EAzhHC4Licz9hox8M5QYqNBzOTEuT8alDkvvr6k3pBAv35kVNUhgkkcuBBKk8XcaXozYIXpeTmJddV4ULCMMCVEiKl3ZsqitTFh6K/8btJo6lJxN8UnRU7HJpY5G74rA1b5RXbo9KAA8FYi62V7+SCswjd7dyKj6t0vh0CVmtxMlXp1Ls4vURr6zPlCTa7mpHJg45YlYcSUQBXf5GBPGjzr7WlALMPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmNMMvI06nQq17S4dJJOsTEI1hinunTY7U7qva4rek0=;
 b=zDTMhjN6PJvRVWjmz1sXdjZWsqh5xxje1DZuXEza96E9k0EhFSj+iu7igaSRgPq0dWk2zwfWH9wyTbFadkdo+hVFnfo63RXO59wEFCaOmQ1D1Wpcw841ysBXRz7SvlF3KgebaKbJ2cSJr/8WrX6/NOYbBz21Fwbpj9ynh4Y92K0UAmI1KiWFRUki7tj7/QAHoP87zjkCLBPy9wfuanUf2hp464rYVtrilVB+A8Zhdri+HDw0vsveJQ2J1ic1DdFfRBjrzF4I9mAWiZDZE6YtX2LWTrJOUhic/UVfrCDFkrgFYxwPeDVGOSPl1P8JHBgnv4EidDgqaINkoOvb3i9KLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBAPR04MB7207.eurprd04.prod.outlook.com (2603:10a6:10:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Fri, 25 Nov
 2022 02:15:06 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::89bf:6855:abfe:203b]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::89bf:6855:abfe:203b%7]) with mapi id 15.20.5834.015; Fri, 25 Nov 2022
 02:15:06 +0000
Date: Fri, 25 Nov 2022 10:15:29 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 4/4] selftests: mptcp: listener test for
 in-kernel PM
Message-ID: <20221125021529.GA13283@localhost>
References: <cover.1668662624.git.geliang.tang@suse.com>
 <60b6d97a1087057ed07ec1c0c7068e22cede2ad9.1668662624.git.geliang.tang@suse.com>
 <db094b53bb343ec9c490506134b913e15ea5ac20.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db094b53bb343ec9c490506134b913e15ea5ac20.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::18) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBAPR04MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f29aa8d-8db7-44f1-bbf7-08dace8adeaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zmnfy8dnPQVfGeeRElAPUXulh41UXg47i7Bl6AOVQZ1c5OCZbinZEVzfOSADL07G/USG1bgZVWs9DZEmZsXV4eS3qDjchfSWshgjzwZdmwrJPw9DVz69BTPQKPEd+A6gMQi0UuJFaMHidNbXwVkTlsgqMT/bcMDL3ZFVac4tFN3QKt5Z44dJ2v839zReyKqrhCTvkujfa4WoofASwT+EwJ4uco1+X04NxIytTSHs1qN+qbbg6APXVPEYsivhsTdgQoOJqd+2OuKCJsa7xfL/Yx2c6oQoC2hvdVLURG0ZLbuqtksMi1kA0fotwlQtGy1Ob3+H1R6QEPVPpdHoZsu6/UbHexKkD99NXlEVKu9w15QwFvdjXHnX/w/yNOmL4GHG5bDS+IA8bLpxxiPOyDVHHn2RkZb7IGPWfcuo2T/VUheQxTkmjKI6wHrt7n9cyc45Lc+I2l8oEClZKFXat2QbhNch0/YD2/ezXU6FiAAOZiBtbHsBcmv92Cq+D+J0rQcU96gGGxW1Jx7cxkA8aT1d7xRc73xpP02tiCz9kW/9aAjYXMr6/6R9210JU9+BfcYU2ROfZiYSNj5EShHCGNBVONWRoHaptUwYzPNGM95wFrndkQr5HOJDVNqjwKnBnvwWIGzlAsXTtpk7+qvtI16rrA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39850400004)(136003)(346002)(396003)(366004)(376002)(451199015)(2906002)(83380400001)(26005)(41300700001)(6512007)(6666004)(6506007)(6916009)(316002)(86362001)(33656002)(1076003)(186003)(44832011)(5660300002)(4001150100001)(9686003)(478600001)(8936002)(38100700002)(8676002)(66556008)(6486002)(66476007)(33716001)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVNyTUdXOHZmb0VINDRsUlZBQ0ZoZTM4Qkc2VnJxSStYVytsUk1VU2lrY3dy?=
 =?utf-8?B?QUdLc3l0WU54bkF5SnhJR01CM0Z1aFhVZm9RdmNZRFdyeXhSKzdEblpocUJ4?=
 =?utf-8?B?TWhteHJzeXYyMWo3d3psMXlSMTlQL1dURTNGQ2RiWFJTbGpWUTZIQm1JakRZ?=
 =?utf-8?B?NXlKTFgzMWpoQ21ncmcwWHN2VkFSOVRxczRmdEw3ZG1EQVhEZVcxUWFrQnVW?=
 =?utf-8?B?RFBWZGZZbjFTbXppdDh5NFcrY0liM05PTWs4UXFkRlMvRm5vZ3ZCVUl4S3R5?=
 =?utf-8?B?NEsxZjFSMWRzZVJSdkp2TDgxcmlIMFNZYWpvU0NGSTRVc2xGYVhrMlNKTnRq?=
 =?utf-8?B?T3VxamFTVjRWU28vWGhyaTVCM1U5NmFkZzRLZUpHTkpQbk1yaTZLRTNwbzdv?=
 =?utf-8?B?VG9WQ04vVHN0T1k0QmFSODYzejZDOEg4cFNlVG02MTVsemgwcXpkUkNSN3lp?=
 =?utf-8?B?K2xHeFpTY0p6bVp2czNpK1pZeCs3TXlGdEhkVWdvRVZnNG1zUVJXQnZTcmlQ?=
 =?utf-8?B?cXlySjJnc1RuY015NUlpcmQ1YWJiLzJDMFp1R1JQWUEwTEEvWGJWd2RoaElE?=
 =?utf-8?B?bWlla1hUSVc2L3RtTWJOelBneFRDTE1TRWo5RFhMcE9wYVdCYmNVNXU2WW1E?=
 =?utf-8?B?RTEzZGVHamMrc3VFUWtDSG1OS0phQm1nQVF3UXdpWUxvUHR3R2dxZkZaMmU5?=
 =?utf-8?B?VXNSaE9wc1RSRFMzQ3VYd2oyOHFISE9mWFg3TU5oYnVtaWRFVnZYRzB1d3RQ?=
 =?utf-8?B?RVphTytJQnc0c3NoTGtZVWZsVVJiNHRHU0tsaDlFMDc4VzAwWExQRjdhVmx4?=
 =?utf-8?B?S1RaZHdzdnhQa1N4cWpYSm0xSTA5WW5sbnRxdjVWVUIwenlpbFBsZytXNGdY?=
 =?utf-8?B?eFppNXNaNkw5OHI2Tll0VWFaR2JxTzR4YzJEZ09TZzdHdGF2UHpSREpmdnNJ?=
 =?utf-8?B?UzJXeVM1UzhXUS9aZkFMeE5DVVBqOGpDWk1QYXdoQVh4ZFcvbDdjWWFVd0h5?=
 =?utf-8?B?bXNvejhMVlY0NkF4S0VNdlpHRWh6UjFCWGdXTmltT1RwbjBPdGtzRmFYYlJX?=
 =?utf-8?B?RWJ3b3dtdzhYYjBQOTBJNGFFRHc4eGJQOE9zTXBLdWhDNGp5U2hsN3FQVzdQ?=
 =?utf-8?B?c1VQQk5XbHh1ektldElXb0RLSXpmd0hrVm1TT0NyL05sM0U3NjVZQ0FvM1cy?=
 =?utf-8?B?VXBsV2xHZkhSQTdTR0ZXcTUzcndHWFU2RXpsbFZxSjdHaWZqNVNFdHA3UFpN?=
 =?utf-8?B?UDZxK0tZMElxTG5nbE5kZEZQVE1hTndLQzBFOU9ibW5oeUZJUnJvZnZOZHhY?=
 =?utf-8?B?RmdVZjg3T2h4d2VrKzg4K0tYZWNxbjVJcTcxTUZDSHpYUmNlQW9IWFlXOXVL?=
 =?utf-8?B?a0x3dWRsSHg0SGl3YU1PRGNMS1hiUWFJd1ZvSVJCMmU4dStxSlN1eTZ5RXdE?=
 =?utf-8?B?TFJoRkJ6SExtWlhOdDhEOUlKSUhtMzlMUzQ5K283bzhCaDBCNXNTM1kvWDlS?=
 =?utf-8?B?cy9tbHdKQVV0MW5kRWtUTnhmcnczVUxKZmYzQldWa0ttV0ltMFlLQUVMSjdv?=
 =?utf-8?B?SHFLc3MvczN5QmVHdXA4amxXSS81SkEyTGVtc1h6dTBVS01JU3FzVVM4WldP?=
 =?utf-8?B?ZXRZOHVyOTM5aVdLNzFQL1ZsOXE5bW1vMW5CRkN6TlRINEgyQllWaksrdVJM?=
 =?utf-8?B?dC9tSTJqVnVSN2N1RzJYMW81ekpSdjhUY2VQQ3N6WDRldFpRb0prNDU5cVdx?=
 =?utf-8?B?UHIzdVExdDE4SHk5WFN3ZWd6RkJGZ1NZWmwxNlBDNDlOaTBpYUQyR2M1VWdr?=
 =?utf-8?B?NURkLzFDVWNvd0g4d21lcUwrUnRneU9VN0k4YjJJRlB4dWZLK1lOeVEvSzBK?=
 =?utf-8?B?SU0vSTR5Szh2Vm1TbmJvSzR4L0REVldMWG1Nay9YQjRFdWNKYXc3SVUrbnh0?=
 =?utf-8?B?Ri81QTZCZ1A5SEJabnpGVFEwSVhrYk1wNUVheUs3b3RienovcURXbUVoZHEv?=
 =?utf-8?B?Vm14aVhhY1NaellEby81WFZFZytTTG5QWXk3WW14eXdnLzAxeDczTlFmTjEx?=
 =?utf-8?B?NWhvZDVsSXpEaUxkYm5lQXFIZzk3clZKWDgyWXdiWjk1WlRPRGxZZE1LRXVY?=
 =?utf-8?B?UEZmVlFqd1RsS21oRU5ob2oxMUpjMmJtZUhvWVdkL3FwZE5McnlncDYxTUo2?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f29aa8d-8db7-44f1-bbf7-08dace8adeaa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 02:15:06.5386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzpnLrXNwFBE42sVaR85AZyC5gYVcEw4N89VAfsTXNvooWxmIItGBWf7h7aaGxZ/KreHZAP42a2sCmZ4zJwDoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7207

On Wed, Nov 23, 2022 at 12:49:58PM +0100, Paolo Abeni wrote:
> Hello,
> 
> sorry for the late feedback.
> 
> On Thu, 2022-11-17 at 13:31 +0800, Geliang Tang wrote:
> > This patch adds test coverage for listening sockets created by the
> > in-kernel path manager in mptcp_join.sh.
> > 
> > It adds the listener event checking in the existing "remove single
> > address with port" test. The output looks like this:
> > 
> >  003 remove single address with port syn[ ok ] - synack[ ok ] - ack[ ok ]
> >                                      add[ ok ] - echo  [ ok ] - pt [ ok ]
> >                                      syn[ ok ] - synack[ ok ] - ack[ ok ]
> >                                      syn[ ok ] - ack   [ ok ]
> >                                      rm [ ok ] - rmsf  [ ok ]   invert
> >                                      CREATE_LISTENER 10.0.2.1:10100[ ok ]
> >                                      CLOSE_LISTENER 10.0.2.1:10100 [ ok ]
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index f10ef65a7009..89a30225bbd7 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -2509,6 +2509,54 @@ backup_tests()
> >  	fi
> >  }
> >  
> > +LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> > +LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
> > +
> > +AF_INET=2
> > +AF_INET6=10
> > +
> > +verify_listener_events()
> > +{
> > +	local evt=$1
> > +	local e_type=$2
> > +	local e_family=$3
> > +	local e_saddr=$4
> > +	local e_sport=$5
> > +	local type
> > +	local family
> > +	local saddr
> > +	local sport
> > +
> > +	if [ $e_type = $LISTENER_CREATED ]; then
> > +		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
> > +			$e_saddr $e_sport
> > +	elif [ $e_type = $LISTENER_CLOSED ]; then
> > +		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
> > +			$e_saddr $e_sport
> > +	fi
> > +
> > +	type=$(grep "type:$e_type," $evt |
> > +	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
> > +	family=$(grep "type:$e_type," $evt |
> > +		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
> > +	sport=$(grep "type:$e_type," $evt |
> > +		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> 
> This does not handle properly error conditions: $family, $type or
> $sport could be undef in case of bugs, you need to quote them
> everywhere.
> 
> > +	if [ $family = $AF_INET6 ]; then
> > +		saddr=$(grep "type:$e_type," $evt |
> > +			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> > +	else
> > +		saddr=$(grep "type:$e_type," $evt |
> > +			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
> > +	fi
> > +
> > +	if [ $type = $e_type ] && [ $family = $e_family ] &&
> > +	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
> > +		stdbuf -o0 -e0 printf "[ ok ]\n"
> > +		return 0
> > +	fi
> > +	stdbuf -o0 -e0 printf "[fail]\n"
> 
> This is not enough, you must additionally call
> 
> 	fail_test
> 
> to properly report the failure to the CI, otherwise the test will be
> considered successful even when the condition is not meet.
> 
> > +}
> > +
> >  add_addr_ports_tests()
> >  {
> >  	# signal address with port
> > @@ -2533,7 +2581,16 @@ add_addr_ports_tests()
> >  	fi
> >  
> >  	# single address with port, remove
> > +	# pm listener events
> >  	if reset "remove single address with port"; then
> > +		local evts
> > +		local pid
> > +
> > +		evts=$(mktemp)
> > +		:> $evts
> > +		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
> > +		pid=$!
> > +
> >  		pm_nl_set_limits $ns1 0 1
> >  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> >  		pm_nl_set_limits $ns2 1 1
> > @@ -2541,6 +2598,11 @@ add_addr_ports_tests()
> >  		chk_join_nr 1 1 1
> >  		chk_add_nr 1 1 1
> >  		chk_rm_nr 1 1 invert
> > +
> > +		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
> > +		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
> > +		kill_wait $pid
> > +		rm -rf $evts

Thanks Paolo, I just sent the squash-to patches to fix them.

> 
> is better if you make the 'evts' variable global, moving its definition
> in the initial global variable declaration and move the 'rm -rf $evts'
> in cleanup() 

Here I prefer to keep 'evts' as a local variable, since all other 'evts'
both in userspace_pm.sh and in do_transfer() in mptcp_join.sh are local
variables.

Thanks,
-Geliang

> 
> @Geliang: could you please send a squash-to follow tacking care of
> the above?
> 
> Thanks!
> 
> Paolo
> 
