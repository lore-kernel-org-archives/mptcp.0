Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B651C27
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 05:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiQxsWyIZRjt9JMhGpRzmcyHztwL4jg9psMnZWHql9RhVskRYA2q+5X44eCRCQwkPVqc30MdX+p1zGLOB8YBUai/A+OxiD4GFeLkjT5uRG9n8E++q6CWbi+x/F72HiSbVhA8hJhHwX0nedRHmKLfA9OkasBmOpmAu1hn5gFwYvM+NwLQ6i/qiP1bkRC4QkaTMgGpZ2uZTWmLQyW2XKe7Eqp7o/AzYsgDbeXCv2hdaZUV6SXOtMGHhef2FBsEYVDAacwlVDTQlkXNt3O/I8YVzNCAWnzBKks2BAy1Lpz1dX60U3vrsrkIpQuejPiozXRDOdRGQcMoSwWco/NGHL76Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arZ15rTdYgT7bD9ZBHA8b+QLs3ACX4Eeo/2E34WFQXw=;
 b=AH9iMOLx+cbQslJ318h8YVa09ZbFIHwvCIApD9Z3q6C04943NmGHGr1gjGA6gBgce+ALnjaM8idbHRgPF/4pY7J80OZd3Ht5GmestD17XhOgmjZ/E7FK+TUPb5X3KByZouYgoXWlgkX27rK0E9AYEmkHWyzxPsF5D6YDFeU2QaDYXFoibZ5adtgBDQUnN1gCgu4uVsB6xbH9lZAym2q28ZmVqTxlSblaiWZMw9QEY9J0Ptqg6k/2TgCTydwXq/ag99Qy5LZ7IGP+TCt4wUcT9FDhz2R5CJxAsWa4EtWzXY2mCaxOH0jSaTpSnfcpAVNMjobnbMvGIWM54xdmq5O5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arZ15rTdYgT7bD9ZBHA8b+QLs3ACX4Eeo/2E34WFQXw=;
 b=SAx+gTl61au/KnIbskSc7fqvsiiYHJpQ9MljEQZdhdWxV+mUgd7nNUdGjbEVj1USW9bSMwwsQ1nUEqrjifbiInsXK0iPty1zfejP7/hpj2oHmKaOCWTHyNTCSEfiScVlVLGfvnXutTjSAZIJBFtGfwfMHhj/howIhf5vXVstSh4a8i6PaxarX+9a5SwHXLH0P6nPaTwSsmYjW0Q+gB1Ok4Y50i0gfsUS9OoQQrHza8ZFGcuD/0V8qUCaPXh3qvCx4iVDQvzigte/QleAI8iw2RDF63vI7nTlcccXzXXLN74wO1IZnhJDj56pv2l4VAf36AlOig9T4NJgacDr7YWi9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 05:52:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 05:52:23 +0000
Date: Thu, 23 Feb 2023 13:53:28 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3] mptcp: update userspace pm mptcp_info
 fields
Message-ID: <20230223055328.GA24434@localhost.localdomain>
References: <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
 <691e7dde-be9d-ee56-73dd-e6e6ede37d06@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691e7dde-be9d-ee56-73dd-e6e6ede37d06@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c059af-34ad-44d4-64b2-08db15622239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ac2ov41hNhpuKYRYFnEoxmOFeo003R9cVPSAo8A26iQThTtEhlEIHfWZaBXUoIfcFY1SaVQo2/wWtwGEARwLzs7CQC+lhcHszd0JBgLnuk5W2bGd6gpvmHurMA/H24Z4bSBZ1ymRHnqpSxcAXMr8X8iFHr0T1Fls5GsSGjRh3GpD/9t4U+SPl3c0nuFjhYE0h2MjtWperY9H6SOUq5HkyXNOUg0KtOnXLkbHZPhI8kgJnZMk1gPUU/zkIEZBj8Iezg0lQwF73Eb/S749zFViKDnvhN4cfeghWuvIYLjtTcBEhWglPVx70mVh4j/h0I6FXpCxSk7FWInzHHY3rrk2pcPNhML6hnJZ6E5+4VgBP6s/J40BOWvpKBYc8KA0sbd25daw29oYXpRNkbyTKbnyDPN2vMSn+8jZdO5KYtHmg8f9Lq2YxNe6/Ns9fdB6YVy6hspg3o/tqdj5dS0fusEWU5VQY2hLUjEdB5Ca/fOhORxSSBVYiyVVJN9t+jVeBK67qsmDaWjwoREOEO/TaIcUME8VyW35n2rs5yZysvNeKYFzpc4Aa8UFWB4yMLFJq8Y06o/eiRSQL1el5LKSzjkv8uhe/IkwAQOfg0Sz5p5TaahPGaITbE2xHIQTx2ObNiy73FYFPwHc6m/oVthVcmOwuVq+OLiJAWqnicMdkdicjO18NaIROEpxfRDwssxdfCSs5EXl3ld2OhEzgCBl460/KCiraqq55YoCKl0uP0qweGA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199018)(38100700002)(83380400001)(15974865002)(86362001)(33656002)(2906002)(8936002)(41300700001)(44832011)(15650500001)(5660300002)(186003)(26005)(9686003)(53546011)(6512007)(1076003)(6506007)(19627235002)(8676002)(4326008)(6916009)(316002)(66476007)(6486002)(66556008)(966005)(66946007)(478600001)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?prBECYFuYrJ1kpRHyAAMwq3rb437XZPLnGeQeliLHvAMIuGwIxUcowH4/CPX?=
 =?us-ascii?Q?silBEt9f9udCMokNO33WLGPoY8be15fk0NvbAwxjj8JSm2kY+Lhwn5R9ZGlC?=
 =?us-ascii?Q?vttnw4dMKwXF7hFoAdmjwCYxM62lO70mRQaZyOLKP9I7Ia/SzSxnz6dUcWiN?=
 =?us-ascii?Q?pgyOGYTeE+rHTQJziZTw6IyIkITGmb8kHYXi1NzBPKvZjI4mRsiqgvuCfc7X?=
 =?us-ascii?Q?lnTXqs3G512SYuStrmTGmpEP8U0xx03lyfqoSIM9/yGy//zBmwJR75VTPyWd?=
 =?us-ascii?Q?Kuyhyo8PhjjAe5yY6AVvIVt3ZNcF3K+5VzE0AF5P/BC8fR43A+4R2jg4+8AQ?=
 =?us-ascii?Q?qGA9ocaI76ufwtCmGGLc1T5KADADo2gvwMEu0eZ7W6k6930llTLrHHSh813r?=
 =?us-ascii?Q?KVP3DHaBBjIkQIw0ZaPkpfKaY4/p2KNpKopMLzMy9sGWSGwPTYrD/gYuU4tq?=
 =?us-ascii?Q?yV0MKHAgK9Re/rpKn7L8ddB4bc9ARAjk+C+9NUIJZcAX4S2uCErqxWd63vGH?=
 =?us-ascii?Q?Mx7ni+T25ejtrhHAw2BK0aezsFGj+m93IcZDeDyb6UWdDK2COh8bnl52sfB7?=
 =?us-ascii?Q?D8+QBLFUCOYGvd+t/dpSzZ8jeUtGzq7lZ4gZJHvQniP5KTwBfBTxlfzeVq77?=
 =?us-ascii?Q?qFCAFwii9qNkKX/0nq7Lnav0Xe591rdAG7MCST4+qxyefltOxIMjkDJuYDKe?=
 =?us-ascii?Q?gqqVts/F79Y8PzE2cX8F9QU2Hu3N8NEHUy3odynNG8jFhTbS3SuJuf5LWcJ6?=
 =?us-ascii?Q?Zlo976eHRqlcFyWZWuGVcvRfSnzOilRbhaVA+Li3TdzWirmgMTRsfy2adT2a?=
 =?us-ascii?Q?mIpKUoh8jYK5gGNGS0kO619ve/IGgwoUULIt/KiGJV8sgNb0yd7lNuJoReHm?=
 =?us-ascii?Q?AShfpeSld7Dzj+cMm0Hk5jRMAJCFP3cuTEbDnbjf5Ja3/f1haS+nDm+QbLmD?=
 =?us-ascii?Q?HAab9OMenGPL9r3GFd5BPHhWkGECO5miBRW4etu+SkOE7I8Mn9Xj4DWRvCzC?=
 =?us-ascii?Q?hGvVoP1qWNgNfcdBkHqjIY/+hdD38cdqcRzyN0Em0M2CQFrMB7RDvkiNVppJ?=
 =?us-ascii?Q?rbWkN4XvPkwQ6VkyXUd7jzCYzYlYPLQ11OEj1dOYJHTwn3v04dnc3X4izo7G?=
 =?us-ascii?Q?mUQ4s4CBnbB1+be++hh+OigQKIEf2kE54Qknz7Fmhm77c2ud4pTjvM1FpKsE?=
 =?us-ascii?Q?4V5OJRGRhrXn1OsqPy2IFdmbQNmwnDWDHd+b1YwdWrueBi3/8SjNDVeN6/u3?=
 =?us-ascii?Q?if4TKuxJsq/rK4ycYRsabsoLzoK+Ia5sfVwv8jhkqVElO2+J+7OxTgTHNH7o?=
 =?us-ascii?Q?TrxsEHugXF5AYAkcy4crB5sHx6H42aX6zz6kUxdQQJT9NnE2gugVVeQhyJcA?=
 =?us-ascii?Q?GIlbw8YXQ0pVhsjXmK2G1RBUGsjTz71KxeQ7RysBk1gPUQE47DvyQO3OxzPZ?=
 =?us-ascii?Q?7M3w9dCrzK/f2a5mUL933ua5V8okXtw2+JMCVleL0IEl5RUEcnHQQxfVnyO2?=
 =?us-ascii?Q?DZ5G+ZyUOWKiReqtszHQ4MZf2ZtI6f7yX3sNbjps/aujSrargilBZF+6p2lZ?=
 =?us-ascii?Q?STBKiGNn1kQda9TcVTt8brVZIxhOeaF8WF0101pW5o5uDIatYpa6KBfMOqMq?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c059af-34ad-44d4-64b2-08db15622239
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 05:52:23.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJXr660/1uEz2JTI0TIYQZnh0I1XuGpduMqc1uQY8EaM0mXUg2S4aapluJtzBggaQQlNMXZefyjshNf+Yu5g4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490

On Wed, Feb 08, 2023 at 06:43:58PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for this v3.
> 
> On 03/02/2023 08:55, Geliang Tang wrote:
> > Increase pm subflows counter when userspace pm creates a new subflow,
> > and decrease the counter when it closes a subflow.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330
> 
> Sorry, the description of #330 was not clear: pm.subflows is not
> incremented for the server side when using the in-kernel PM if I'm not
> mistaken. I just updated the ticket to make it clearer. So this patch is
> not fixing #330.

Matt, how can I reproduce the issue you mentioned in #330? In my test,
pm.subflows is incremented for the server side. My test patch is as
follows:

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -981,6 +981,12 @@ do_transfer()
                done
        fi
 
+       ip netns exec ${listener_ns} ss -version
+       echo "listener_ns ss"
+       ip netns exec ${listener_ns} ss -inmHM
+       echo "connector_ns ss"
+       ip netns exec ${connector_ns} ss -inmHM
+
        wait $cpid
        local retc=$?
        wait $spid

The output is:

-----
> sudo ./mptcp_join.sh -f
Created /tmp/tmp.nlYc41VABR (size 1 KB) containing data sent by client
Created /tmp/tmp.jXUuNj0w4c (size 1 KB) containing data sent by server
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         0                              0                                                      [::ffff:10.0.1.1]:10000                                                   [::ffff:10.0.1.2]:56062
	 skmem:(r0,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows_max:2 remote_key token:3d8da2a0 write_seq:1bdfa9cc563d9593 snd_una:1bdfa9cc563d9593 rcv_nxt:f9c1c74b10372bef
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:56062                                                       10.0.1.1:10000
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows_max:2 remote_key token:70251e1b write_seq:f9c1c74b10372bef snd_una:f9c1c74b10372bef rcv_nxt:1bdfa9cc563d9593
001 no JOIN                              syn[ ok ] - synack[ ok ] - ack[ ok ]
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         0                              0                                                      [::ffff:10.0.1.1]:10001                                                   [::ffff:10.0.1.2]:40688
	 skmem:(r0,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) remote_key token:f9a00098 write_seq:809c061103ce5ad9 snd_una:809c061103ce5ad9 rcv_nxt:412126c447a36405
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:40688                                                       10.0.1.1:10001
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) remote_key token:6bcc9fdb write_seq:412126c447a36405 snd_una:412126c447a36405 rcv_nxt:809c061103ce5ad9
002 single subflow, limited by client    syn[ ok ] - synack[ ok ] - ack[ ok ]
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         996                            0                                                      [::ffff:10.0.1.1]:10002                                                   [::ffff:10.0.1.2]:53652
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) remote_key token:5d60cbb3 write_seq:86f08453ff95670b snd_una:86f08453ff95670b rcv_nxt:f7e7aa5d21fa8a88
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:53652                                                       10.0.1.1:10002
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows_max:1 remote_key token:d62b3e1d write_seq:f7e7aa5d21fa8a88 snd_una:f7e7aa5d21fa8a88 rcv_nxt:86f08453ff95670b
003 single subflow, limited by server    syn[ ok ] - synack[ ok ] - ack[ ok ]
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         996                            0                                                      [::ffff:10.0.1.1]:10003                                                   [::ffff:10.0.1.2]:48836
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:1 subflows_max:1 remote_key token:d0bc750f write_seq:9f381515047a2a44 snd_una:9f381515047a2a44 rcv_nxt:3c331d647144410e
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:48836                                                       10.0.1.1:10003
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:1 subflows_max:1 remote_key token:a5f0a0ec write_seq:3c331d647144410e snd_una:3c331d647144410e rcv_nxt:9f381515047a2a44
004 single subflow                       syn[ ok ] - synack[ ok ] - ack[ ok ]
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         0                              0                                                      [::ffff:10.0.1.1]:10004                                                   [::ffff:10.0.1.2]:60990
	 skmem:(r0,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:2 subflows_max:2 remote_key token:3fea3f91 write_seq:bd76dd90157ab6ff snd_una:bd76dd90157ab6ff rcv_nxt:1b0decd9b66febf9
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:60990                                                       10.0.1.1:10004
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:2 subflows_max:2 remote_key token:db7fad77 write_seq:1b0decd9b66febf9 snd_una:1b0decd9b66febf9 rcv_nxt:bd76dd90157ab6ff
005 multiple subflows                    syn[ ok ] - synack[ ok ] - ack[ ok ]
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         0                              0                                                      [::ffff:10.0.1.1]:10005                                                   [::ffff:10.0.1.2]:49704
	 skmem:(r0,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:1 subflows_max:1 remote_key token:33715c04 write_seq:e55d02a2aec657a4 snd_una:e55d02a2aec657a4 rcv_nxt:eefb958600fec9c
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:49704                                                       10.0.1.1:10005
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:1 subflows_max:2 remote_key token:95404d0b write_seq:eefb958600fec9c snd_una:eefb958600fec9c rcv_nxt:e55d02a2aec657a4
006 multiple subflows, limited by server syn[ ok ] - synack[ ok ] - ack[ ok ]
ss utility, iproute2-6.1.0
listener_ns ss
ESTAB                         996                            0                                                      [::ffff:10.0.1.1]:10006                                                   [::ffff:10.0.1.2]:34258
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:1 subflows_max:1 remote_key token:2ff54490 write_seq:e4f5e6f38dc1fcc7 snd_una:e4f5e6f38dc1fcc7 rcv_nxt:ed5e200e8c906632
connector_ns ss
ESTAB                            996                               0                                                            10.0.1.2:34258                                                       10.0.1.1:10006
	 skmem:(r996,rb131072,t0,tb16384,f0,w0,o0,bl0,d0) subflows:1 subflows_max:1 remote_key token:81398a53 write_seq:ed5e200e8c906632 snd_una:ed5e200e8c906632 rcv_nxt:e4f5e6f38dc1fcc7
007 single subflow, dev                  syn[ ok ] - synack[ ok ] - ack[ ok ]
-------

You can see that the subflows are updated for both sides.

This ss -version is a bit strange. If it is removed, the test will fail.

Anyway, I think it's necessary to add a testcase for this mptcp_info
fileds. WDYT?

Thanks,
-Geliang

> 
> (before this patch, it was also not updated with the userspace PM but
> that's different: ticket #329)
> 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> 
> Could you also add a Fixes tag please?
> 
> > ---
> > v3:
> >  - update local_addr_used and add_addr_signaled
> > 
> > v2:
> >  - hold pm locks
> > ---
> >  net/mptcp/pm_userspace.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index a02d3cbf2a1b..ba8ad500993c 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -171,6 +171,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
> >  	spin_lock_bh(&msk->pm.lock);
> >  
> >  	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> > +		msk->pm.add_addr_signaled++;
> >  		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
> >  		mptcp_pm_nl_addr_send_ack(msk);
> >  	}
> > @@ -240,6 +241,10 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
> >  		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
> >  	}
> >  
> > +	spin_lock_bh(&msk->pm.lock);
> > +	msk->pm.subflows--;
> > +	spin_unlock_bh(&msk->pm.lock);
> 
> Should you not decrement msk->pm.subflows in the loop just above?
> Potentially, there is more than one subflow linked to the given addr ID.
> 
> Not directly related but it looks like in mptcp_nl_remove_addrs_list()
> -- for MPTCP_PM_CMD_FLUSH_ADDRS command -- we don't decrement
> pm.subflows as well. Maybe this 'pm.subflows' should be decremented in
> mptcp_pm_remove_addrs_and_subflows() directly to cover both cases?
> 
> (if you do the modification in mptcp_pm_remove_addrs_and_subflows(), the
> "Fixes" tag might be different, a separated commit will be needed)
> 
> > +
> >  	err = 0;
> >   remove_err:
> >  	sock_put((struct sock *)msk);
> > @@ -302,6 +307,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
> >  		goto create_err;
> >  	}
> >  
> > +	spin_lock_bh(&msk->pm.lock);
> > +	msk->pm.local_addr_used++;
> 
> Mmh, here the counter is incremented for each new subflow: no matter if
> it is a new local address (addr_l.id) or not, right?
> 
> If I'm not mistaken, we don't maintain a list of local addresses we use
> to create subflows, right? Just addresses we announce I suppose.
> 
> I don't know what's best:
> - not updating the counter with the userspace PM (current behaviour)
> - update it but with a not so correct value
> - maintain a list of IDs just to set the proper counter?
> 
> Maybe it is enough to keep the current behaviour and mention somewhere
> "local_addr_used" counter is not supported with the userspace PM because
> this is managed by the userspace?
> 
> (Same for "add_addr_accepted" counter I suppose)
> 
> > +	msk->pm.subflows++;
> > +	spin_unlock_bh(&msk->pm.lock);
> > +
> >  	lock_sock(sk);
> >  
> >  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
> > @@ -424,6 +434,10 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
> >  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
> >  		mptcp_close_ssk(sk, ssk, subflow);
> >  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> > +		spin_lock_bh(&msk->pm.lock);
> > +		msk->pm.local_addr_used--;
> 
> (same here: remove this line?)
> 
> > +		msk->pm.subflows--;
> > +		spin_unlock_bh(&msk->pm.lock);
> >  		err = 0;
> >  	} else {
> >  		err = -ESRCH;
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
