Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4433A955
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 14:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIypGCJYEUHhQdxHQ+uk3+f1fzR0IlVhG9nxjRS/2UtHw4y7OjG0rOrzTS6XJDAntVBdKB7X0dJzWEdjwnw7ZNGYOMBRc2aXveR33y9M8n6k6Qu9VweGoDe3KBczPX0RL4i+hr6LHsE9M+95KUq1exv7/NLSbVmRVtPnhZ3KN3d4+snjmxNw+hn4JUA7lwuCbiK11Mq9I01Wf8Tbh8EQC21Q4xbct0F91+CXwzrw+QJMGhigP5y6EP3ffBpJkxECkUl1p4Sp7fnY4OpJ7cEplOBosMkkkvj2gGoCqXcWtwiBrPCYzkR6g2sLrpGkZ4yWEDbHM0/BSyH/xjajYISzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tc8vVD7HMqkgHQiYiWXw1HENPisVFlLQX69Wn9OgJkk=;
 b=FEHRAVUK5m0fXe8TpFSVxfxW1+vIHv/T+5TCfJa3bC+gl9lBbHgt08e06jYZPCL8YuXiygxhr5XA5/jHdpeNpnSz/tH3yz+NbgI9/b2iNjWdKNsoIykAlN8L71m+tPyfYL/Qb/9AR5AXHp5beaYD9ZI6VCXNelB6YiOAY0twj9UqFIkDaFPsHeJc/ipObk5oPh+tw82AsseAs9D/Q08cNbM00zDnyREH1pb/ykPnUqY20JzbyZx0owICExbR1eOxCq+siLF26E0kWCo3v6R1fK0wt+zqnH3MLRBYGhKyrVsn69S1bPjssjsBQ3a5h3wLsLinN1EimFKfZDz3zfUWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc8vVD7HMqkgHQiYiWXw1HENPisVFlLQX69Wn9OgJkk=;
 b=aGk9PGOgw7MsAy7m/f0ulZQ2CeXCZpURjFwFlUXwH4ftuHRMBgeloK2MUl6ykYsXnP+AnkVgoAxXrboDiDY1nce9NUjQUqEZrQAuXJy4RtWQAhsid13nqicsBVhPPh8U9DcLDeHDGwiaYl6lWQzZUWhDIb10jJo2Mst8YtfuazUpLanNEJh8QUDhe2b2AKfxpiXpMgRZVj72TTPUGpB7xIHNF/eJ/psflPL3Oh6hzvI4j4Psq69SdroQKtMIdg62W1Ceb2xg8OaL3w6J4S+/b+B7rgELJ60OubfTA0FyvnlA3jdMlcdA8r3eXfCOxVqsZu0+wsQcbeNSACrsUrRpAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6962.eurprd04.prod.outlook.com (2603:10a6:208:188::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 14:10:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 14:10:55 +0000
Date: Wed, 24 May 2023 22:10:56 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v15 5/5] mptcp: update userspace pm infos
Message-ID: <20230524141056.GA2643@bogon>
References: <cover.1684915182.git.geliang.tang@suse.com>
 <f6f3a1de7d640cbb4ea45fe820c042c6b134e3f2.1684915182.git.geliang.tang@suse.com>
 <f5b66a5d-4dcc-04a1-76cc-58c872c7ff37@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5b66a5d-4dcc-04a1-76cc-58c872c7ff37@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1e7a62-a48b-4e99-9ce7-08db5c60b0aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f91rykHE/weRO9Sohtxlk1+QGXmXWhjE5p9cuqwwwFdQFKokaFP0/aCg9Fyb1N9UuMfK/yFvdN0w4h0F3D/YCf8sVj4ySpIIWxIJGk6W7jaBHpl3ttZV7y5PvkBNXxO1jBUaiFhgSftJC8zoJ3qkO7CgIoHVsGHn70JqZPO6jczpj8+UopkzK3ifQslJLi1VL5oloDSsPhf1YlI2se/UMn3GJatXfr24IvEy0vba8U+sP2yOuckaN9fNRLri0Y5w4n5KT0ahdP8bndp/EElPPGj3W2j0ePqijEQUD97eq7LthflrXPwJLfs1YhgFgXtbReju7/dxTQWzOZXhuSecblCyhOvqXBCrlpgYF3u8iik55J4+6w+eWwU/fq65G09advvwKFC1la8jGFQat0NLu9njuvHbCSOUSfB7mhU0i3rwZcmI35Mw4+1Vo6MegGCi6CKmcSv8DU0FXTOzDR0v+klNrs+le3Gvq1GCgVq7IQQTf2QVe2tOb5q4u4dNpN+ahbgtO8QJzKMseKLu8E6Qmf8/nW2GK417Ywf1Srju8KumRbVm1OzKmtY7b4ZztWHpjCuGpy2YWLE9ONzmQ01+LiurCe8/TZHMnDfjMlRF3VE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(53546011)(9686003)(6512007)(8936002)(8676002)(83380400001)(15974865002)(38100700002)(33716001)(86362001)(33656002)(6506007)(2906002)(41300700001)(66946007)(66556008)(66476007)(6486002)(4326008)(316002)(5660300002)(44832011)(6916009)(186003)(1076003)(26005)(478600001)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p4Cvuz41xA4yWqPgQjKWwCXC7qVbpZlIhijkxzFuUFyW+TE1yyHVWvXPQZif?=
 =?us-ascii?Q?xIVmEN//W4mlCAtA6nVIr6etif5/sxZAOwBDH4J89One2EAUEj92AadY1Pbz?=
 =?us-ascii?Q?MCyibGs6CtZAzhwINkhEdPbo/1gBsVmTenOvLEOkVhnZoz45X6UYf6qvDo7h?=
 =?us-ascii?Q?ES6EuyzLEdoAdwVPGZiK0JSRbn8UeXAaMwHZpko+NaWHIvC6Dfm/rPsg1V8f?=
 =?us-ascii?Q?fjkhc05CxAjU7HbNU/KwWs0q/UWD99K4ePajA4AUmJP0JLzCE7q7vPViAh+z?=
 =?us-ascii?Q?4uW357aRFoCjydl9i/HPRulaUTUkLSvGnHveeJUJY7IxoKWZEt2T0uyULX/9?=
 =?us-ascii?Q?Q+RVFV/j/uUpGfDoYEAdaGSDt3DhnAb+5Hp8nK5Wy4Iavw7Uhbff7qWtzSqr?=
 =?us-ascii?Q?pMOipM4ozFNLsqvpTwwYL+UskInFGNtc6+a2XBiil2HXrIBN+9/Km2VBE/GD?=
 =?us-ascii?Q?ga4zEVDiqkTD+Jl4GZjyfshbv5d4hpP/G+TTD5qzjTYizdNEeX8zoFuw7mBD?=
 =?us-ascii?Q?qF5FYVZKKTLPkNmxfHZolUk2TVePGYvUCatRzkkBN6TAij/m2uI1tXf5Di2H?=
 =?us-ascii?Q?sPFQuNYAGMgvoOyieZ4t3LxzWbeqoycbLaKghfTOAVdoRrXOP7dG7omq0ctf?=
 =?us-ascii?Q?sHC4TISs0XDUgI1Z83RwMHxIw5O9hJLDwZwHXy+duv03Hi9bfMdzpJij6Bgw?=
 =?us-ascii?Q?mUe5N9IqSyWspeMCTzbDi7whdLqwxMLRmAzwhoZVFcnv53txjhWZKWKjmOYx?=
 =?us-ascii?Q?1TcEhiyNP2L0jMVEo5MjV17Q1Mc6DXD7AUouadCchX1zvNqnKMfL9YCqYe2H?=
 =?us-ascii?Q?48QPbQllHV7TkrcfvzHUMoXvOnxI7txiJQ6tv4c6nTARUo8Riaul1W6bor6s?=
 =?us-ascii?Q?+aSCOVkXgNnl9dKbk6pcqtHaDlC27st9Ro9QVA7OwnkIQ9mpVtiMS1qazoQ8?=
 =?us-ascii?Q?7JfbhYAbdkH0zWHqigA5RbXpJT7FQKKODRcIhk05W8u7dmsez32fHI4n3Bz+?=
 =?us-ascii?Q?klCl2ppQmz3ki4HYOAGQFNr7aWScKcllgLjP217wTECZha8bEnwe0TwM3tKe?=
 =?us-ascii?Q?4jZixJAqO6A8VYsOfhfLmjtjE4mTkurvhkU5tzU0nidI8XQtoLdkGinULOP/?=
 =?us-ascii?Q?AWZLOjMFD48Cc3RGjGU2s2zn/9AfcsFWVrJBR3GtJLHvOZyOJRAjCgZ8YRAH?=
 =?us-ascii?Q?1AS3IXqTN35GAe0j81xyzhehKJ2MvZ/CA5MjrWEyXr3bCt2VJendftZMyOiS?=
 =?us-ascii?Q?1uUIUuWBtKlDyDG82T5V3fnW6ZQm9Eh9gGNvV9sRuZB4/a8jG2b+l/S6guKM?=
 =?us-ascii?Q?XDAMgxn9CAFKlIBR16Nz0EzQeexiZHCV0NcRupqRWDI18GZJmI6NbWm3Rquj?=
 =?us-ascii?Q?EktdKc5jjdhMlgsIu4i9dWDeTUG7T4776b7MUoqtAxhq5E+hZvn10mhIHHJG?=
 =?us-ascii?Q?Jk8N5Udz3V7k6JmylJy4C9t6TSPk15xYrV2Rjmr6kRZUBrvjxs/m8q8chpkA?=
 =?us-ascii?Q?nk8bR/cOdY/80va6+qNWvZJBu8K8TD3Ch1BIysA7ek1oXRxcRv+fhbYlWETH?=
 =?us-ascii?Q?V9GOjOj5wtVfwvjSOCxweNhpNe6pnJdnjEwdufO9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1e7a62-a48b-4e99-9ce7-08db5c60b0aa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 14:10:55.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNUz53rR+/0w41Mth8o5vJ1g+sD4N2wLGvdnpimoTNqu1FgcE0xdcHD2SPL9TgA9dyFNTWIjGfjRjtiWdd5DTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962

On Wed, May 24, 2023 at 03:24:09PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/05/2023 10:02, Geliang Tang wrote:
> > Increase pm subflows counter on both server side and client side when
> > userspace pm creates a new subflow, and decrease the counter when it
> > closes a subflow.
> > 
> > Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> > address is announced by userspace PM.
> > 
> > This modification is similar to how the in-kernel PM is updating the
> > counter: when additional subflows are created/removed.
> (...)
> 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 114548b09f47..7ada9cf81c14 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -91,6 +92,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> >  
> >  	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> >  		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> > +			msk->pm.local_addr_used--;
> 
> Do you mind if I add this under the following comment with the TODO? We
> should only decrement the entry if it is the last one being used.

Yes, it's much better to move this under the TODO comment.

Thanks,
-Geliang

> 
> >  			/* TODO: a refcount is needed because the entry can
> >  			 * be used multiple times (e.g. fullmesh mode).
> >  			 */
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
