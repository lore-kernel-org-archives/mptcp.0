Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A2F4A3B
	for <mptcp@lists.linux.dev>; Thu,  6 Jul 2023 08:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQHc+5hojVRdN9BVU5iG6cBkuWwEgYoTMxujXyXlNOrozV4tgUwFx5uy/8PG4/KcTb29EltMW8oZIn9QzPFHPKXjt8C2INeyBwlkOD6dTtkKDcYTn0WQfOjRmR0/ZLpWdaZOCA4UDi97zlXRsc0zPirnBGPiXOUxKfTGMHg+IwZ1FTHpgcu/d0176pP2m7iTI7OybWz0URqBXT0WYWrmnZz9pL5zY++Wz63gaN3/ww/aEpTBQnd1JoKXQEqVXhRQ4qYLAOGRjiyFrnDICp8N8sEEdCukDWsuTD1uxKMSOHmok9FXjoHaFoyTdaBWUv6HN03HDTeVQ0p3NhW8UtATtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKqvaHXR/yF+oHWAeTTdrT9YxdVXJh2HjdDStW2Gj1Q=;
 b=Nf5eZ7KUfUDEfqyvt54Llpwh4saF+uMhFgGb8f9jvRjIoPthlK30CJdrzhEzwlk8nT2tKOtReBHltQWqFMW9SubtPrXOR9/1Fqux4fedbZuUDbNpDkYhEtO32ReILJZaQOsqfb06Gt+pJ6khhnr4bPV2/6SxIrme+7L3ZhpTTsVCPhftB71oQY19ZKSueaISX/1HE/tewyxoca0YTJHE3TMnqa43I7HQDZv7HQ1UoXjitNAFHytg/ryGMAqF+VPwyyzNhUMaCwPgb9k+D7jezIS9n+y1CKcz9WWcslDpFtyAnx+SCHJ8qH9lrrN27Py0qAiYQItt6mVrNG5KOqgwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKqvaHXR/yF+oHWAeTTdrT9YxdVXJh2HjdDStW2Gj1Q=;
 b=ePuaOmK2GxoyJ7wQzpqd+XaDSemin+3jhUI935zijxMsCH5duaPzJnZ+0qVduz89D2JvcxW+NktV4N7LMq6/zCp1Js7Ng8Jk9RZRppWUp5Hl0mTHHsL3yXdju6n7fJZirl+rdceW/gYOMF++0SYm20w0SUr0meTL3/7GjePcfzysH/f5zBGJSVZnYWEoDN2Zs83epDWXfnErM8lpnsZaPGzONnJGuyPa9eaOMIY5goV2XXAyzUyHyvlZLVJrfKTq/1ZjNMCKr0vzJIys3UraEQaQB1C0ay5fdBJuy9qHh6buKj9sj40ZYEKfDJ27DNeZUKXlTEqPJVfEn2NzWdy/2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7739.eurprd04.prod.outlook.com (2603:10a6:10:1eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 08:42:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:42:46 +0000
Date: Thu, 6 Jul 2023 16:42:52 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [RFC bpf-next v2 8/8] selftests/bpf: Add mptcpify selftest
Message-ID: <20230706084252.GA15169@bogon>
References: <cover.1688629124.git.geliang.tang@suse.com>
 <5c88e528d4be098c2fa73ba49bc1b20615b77a53.1688629124.git.geliang.tang@suse.com>
 <194f9db2-c5dc-d7b7-a237-5c458a028764@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <194f9db2-c5dc-d7b7-a237-5c458a028764@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9da69e-c41a-4553-b181-08db7dfcf8a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q91ryHll9b0vaCXKgcObDtmzgvm5l0zTYC2Dipe8Tobn5FMEL/onJU9xPctf6zUK0/l2LNAtc6mTiJZ0hMdv6BJu4u1kAED4D3gd7LZCSVmCTjI8pec7lNk6ytrFuleKPp5zKtrnhCY+3vOpXRJueoTr0HTkzrlKSLEd3cwwW025GQsykF/11RhQaUuUCqgr1AxPuhW66K4hpzrMC123XHQvVosO4b17TG1rUFWp49765vKFM7Ege2i7P9VyEkVR2G2HNc0uXl8qMfRWBuyT8E/PzEiRKc8CyCwaDGjcLsNH7u5SXlbjI5bUQ0lHEUki5RfVd8EdCBLz4wztIyPCGj4FlHfFJ3IGLpUL+0VuOQK6HdSp86dwUQYYaOucZnj2DwgmuHrPKJwwrZuQMpsr+SrG+TtFgoWQae5TyFurDk+P562fl/6t+fWoj6nGZcgrL9Ad0482IXEHG1j65z1H9TOZo9S/slwJJDDfet8WGe8Z3VIh0r4BgmlQU86CamEA+kDr0VqWX/fz+eihDppvL/9rGfaomvKYGDS4lo4ZkYu53sOUGV5vIwVOCA306UxRttlwVbVmKegSuX7sWDEBbbMySA8bCKmMXPtB87/CJ+gUZM4Ceu2Jx1K0i8khRUhv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(66556008)(8936002)(41300700001)(6666004)(66946007)(4326008)(6916009)(8676002)(316002)(66476007)(38100700002)(478600001)(83380400001)(186003)(6512007)(26005)(9686003)(1076003)(6486002)(53546011)(6506007)(33656002)(15974865002)(86362001)(5660300002)(2906002)(33716001)(44832011)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zuSB4XXRgXh6TWBK9eCXUjQGYM2JgYHVdUV8UizZ7of42e4ZMPYdJG/I8ZqI?=
 =?us-ascii?Q?SiOElydyZYRz5caGFlwvI7M4Ly/i43+OZJaSI8agduSkRapaCik+OAIs2P8t?=
 =?us-ascii?Q?VYLAYcDyTzjLrxDvHPgcuqkbcKJJO0iUkMwUvCjLHyW7uZXxAgRHovX7j0kK?=
 =?us-ascii?Q?hD0X/BA1e9EorjyLO2gogk4b2WvxHoygIWeAgzqvWGro2SvENAlr5fOnInOC?=
 =?us-ascii?Q?l4gTg3MhGPszKWzkM+T2qB32bfHoWEU00AO/wxQ3UW8QxdM2WW/farQF9Ogb?=
 =?us-ascii?Q?lgrm8K/XSKJzZJD67WdK4mH4GpO+OVkK48T06euRi3aIdDzVLqyyGqxcY7hW?=
 =?us-ascii?Q?Ll6IaKH1f3au4p61P6EsgwgLcTKKcrX2IkmoT4URIrlTDJ+qB9bDPTqWdI4u?=
 =?us-ascii?Q?LqAoa2p1HjwQjdNFAlYuQnyHS3PgnhHlPLgAlNPYsw3HmRDgiUZFejkZSApf?=
 =?us-ascii?Q?i/lHxKLd1g4ihkMXi8d1xI6jWd2zACdBP5rH4z5749ABnGlekPcIcs61et3h?=
 =?us-ascii?Q?djNOhWmtuaGjriPJiB5Ehz/tzEOv+68hQCR001QkVW9VPPq6aUP+p8yeT9t0?=
 =?us-ascii?Q?Vz8Y6bHm5FCLgJpomcNMs15OSX3fnzJylngRGgKR6kionDCFy47q7doqZc46?=
 =?us-ascii?Q?FVmtQxoDfc9bkczvEyzBE3uEVr+JCKJII5YthS1edba8p29N3WxXLq68jFBn?=
 =?us-ascii?Q?8UwYItNW9viFJraUxjaXQPVE1l+l9mmxUsm5MQFSMOLSrMxYg9X1jumOQQBK?=
 =?us-ascii?Q?ZetkD97fwXg19Hn3HIHMvbVQUZTqQDM/ZhUI7kxicoMu0+RpTnmGUe0R8Zdc?=
 =?us-ascii?Q?C3U2zNngNeRvy2/l+O0YUDzyG5CLazoRL3/PalsVrdoG9khOib2AVTh0QrP+?=
 =?us-ascii?Q?Gd92aHsYTgnHhj+sNXBfclHqw9JC9NODOWCf8uym1x/ppCB7MhPuQpWkwcOk?=
 =?us-ascii?Q?aaYp2ChXRiqv5yWN0C8S78XM3w2bL6yQBbOwRzrKQ8Yz7dP5hy/tGX4V/lFH?=
 =?us-ascii?Q?kSGqq06vCveIURxw9Q3ayqzOX/UoA2QzFcSli0L0oMlxJM9zRgXHXLzJSZU+?=
 =?us-ascii?Q?hpJSknF+hNzEcOwUSgXIlI6Kjnl085wjS5cVvXi0AbLa9LHU+uXXHpv+K3fK?=
 =?us-ascii?Q?bg8eavnowLtbKGzr+k7dAzfisgqucOO6p9Mx+Eu+C3TPB20gc+D627s+K5X/?=
 =?us-ascii?Q?ITTQJ0TTPde9MAzfMmNT6R+3XMlrIabH4iCuHBLuUCkRsW+tBZe/G+vlrH8B?=
 =?us-ascii?Q?0NKVJ/dZjRaYxpbszQkgKu+QsyZecwldpM5LMyI39SVgsRJ/wbWut91OVcGu?=
 =?us-ascii?Q?+cfUCeata40yMlgyDRPh7pPz7fur6io89m5939LSLFBYXmXPki3C4mMzjDUV?=
 =?us-ascii?Q?WaICjYYmWnol3o1qXcgTzEJRullLdEW5niBXbcnU2EBUPZUWa/R2tpXI1gBc?=
 =?us-ascii?Q?JlSwpZY0IF550vCk/F0hJ/7ZVmnuS17B3sLQp9LjaWdE/lsOab5NcGIJo/eU?=
 =?us-ascii?Q?z0Z12qO7vN++p7ju5xnc9f0O9zpGEWGruEPFxZcS3/75hu8oK6GAYnv+54qF?=
 =?us-ascii?Q?bKpnGMMUkbn9NtLowOJz1wMaXpd3CONRLi2MNHqL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9da69e-c41a-4553-b181-08db7dfcf8a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:42:46.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7iVmHTo6ZHU0fpLYb+6Hrcr2+jjzyvoMjki6aJWw+GHK88IEFyyVKRzrziqSMfpI+Ri5SgN7NcCSsfkx2AthQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7739

On Thu, Jul 06, 2023 at 10:21:47AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (without BPF ML not to disturb them for this detail)
> 
> On 06/07/2023 09:47, Geliang Tang wrote:
> > This patch extends the MPTCP test base, add a selftest test_mptcpify()
> > for the mptcpify case.
> > 
> > Open and load the mptcpify test prog to mptcpify the TCP sockets
> > dynamically, then use start_server() and connect_to_fd() to create a
> > TCP socket, but actually what's created is an MPTCP socket, which can
> > be verified through the output of 'ss' command.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 91 +++++++++++++++++++
> >  1 file changed, 91 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index b2a833a900c2..de05140fe638 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> 
> (...)
> 
> > +static int verify_mptcpify(void)
> > +{
> > +	char cmd[128];
> > +	int err = 0;
> > +
> > +	snprintf(cmd, sizeof(cmd),
> > +		 "ip netns exec %s ss -tOni | grep -q '%s'",
> > +		 NS_TEST, "tcp-ulp-mptcp");
> > +	if (!ASSERT_OK(system(cmd), "No tcp-ulp-mptcp found!"))
> > +		err++;
> > +
> > +	snprintf(cmd, sizeof(cmd),
> > +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> > +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> > +		 "NR==1 {next} {print $2}", "1");
> 
> It might be safer to increase cmd size to 256 (or even 1024) because if
> I'm not mistaken, you might need here 129 chars if NS_TEST can go up to
> 31 chars:
> 
> > ip netns exec 1234567890123456789012345678901 nstat -asz MPTcpExtMPCapableSYNACKRX | awk 'NR==1 {next} {print $2}' | grep -q '1'
> 
> That's 128 chars but without '\0'.

Yes, I had changed this size to 256 and sent out the v3 before reading
your letter :)

Now the tests for v3 all passed. Let's wait for the reply.

Thanks,
-Geliang

> 
> But I don't think you need a v3 now: it is an issue just with the tests
> and also because I know most subsystems ask not to send more than one
> version per 24h ;)
> 
> BTW, excellent cover-letter, thanks for that!
> 
> > +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))
> > +		err++;
> > +
> > +	return err;
> > +}
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
