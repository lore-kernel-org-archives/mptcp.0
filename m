Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED58B29CA
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642078705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRaKTbjvvmVZXNLUjV1aCeQ2nNSCdrq5E7cy4ivADnU=;
	b=b9f8SwskhH4xouZAo+a6CURrWswclVyob/K6HXhWGpi/btEJx9hO7NRoLanAFLumo6Ccz6
	dnE+liHiSQrbUoPypL9YkyHBFopURt3ewF/ociA5XEXxpZ6FexUpNiKaYih0hNIM2UakpR
	B5M0Ooyw4rMWnsEzHFIuzc7Z7644oVA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-4qarc7UZNYWb7vXiJQ1uOA-1; Thu, 13 Jan 2022 13:58:24 +0100
X-MC-Unique: 4qarc7UZNYWb7vXiJQ1uOA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cF6f0ac21us6/Gc/wH8gBLyPsXZoPOy8b5LnzAZpLElo36ekSpImaaMa3KDAX6HX0tHXPj4VgFj7hfsecJocu6PpVxIpcEqkBvM+rEnOvPVf1WTOs69n2lP4vLntSndBd5D0f8nZF1iWsatFsM4Iie/CXMUgEO6OWci61G19lloYPjmmbALw8ZoICN8CXLBmWSf5JNUD7LdaFy4TzO9i0TId643vakmF883b3BtLskf3ebuP9TLR6cUmqRBZe+NlWdfaT7XJQoIl5w/ORMC4iXrxGRC/o6Zsw00y2WnWBsT7f64Oehm7PIpu2o7EUx5DJNMYtnUaRqC3x9cX07J3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/eCffqc4WX31iVBoH7ChXtfbtEPQ1b950ZYmbYwxk8=;
 b=b0fDCG8pcNDFXYp26eAjvE0MV9GYtLOmhy5v7yuasZQDHxxqWfTtbnMqobGAmzW+huPBVeQK+z4leZFejzlDL+7uuyeSb4mAUAJFpBfHkwKpgAEYe9qbuXf2GQt+TtnTqX4MalbkdQrCFqzcW3T52xLkuufeCXiBiLXZ9iJUwekGoz87zfY3KhFoGePoazpoCAwWSJH5vevKQhmSa+qTT6GdUaYJa/2ZVfx1Ev4P9f7B3AumNTAZIWM+HUM2BxQn2w02VNJlnUreNpuMKDLi9gwSVQZ+/uYDDj/4w4KCsdg6pRPQiXyP7Pye+E/rUGK9NQQw3CrANY3L2C9D1IU41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR04MB3175.eurprd04.prod.outlook.com (2603:10a6:6:7::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Thu, 13 Jan 2022 12:58:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 12:58:22 +0000
Date: Thu, 13 Jan 2022 20:58:23 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join
 tests-cases"
Message-ID: <20220113125823.GA3195@bogon>
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
 <263f77b0221bee6a9b99245e8c23f5ebafbe9137.camel@redhat.com>
 <20220111034543.GA11026@dhcp-10-157-36-190>
 <868181f675d5372fb202b4b81be690a8572988ec.camel@redhat.com>
 <20220113103534.GA16094@dhcp-10-157-36-190>
 <06dfb6e37c6eeb34f4f9e0f23086486072e9c6ad.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <06dfb6e37c6eeb34f4f9e0f23086486072e9c6ad.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:202::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a634fd44-302b-4d62-60b3-08d9d694611b
X-MS-TrafficTypeDiagnostic: DB6PR04MB3175:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR04MB31755925F945EF3967E17DEAF8539@DB6PR04MB3175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uZABKSIRFicskiqXqKrvLUmJdClo5aBEkKxLIbg6sc5iGDOoNvfjTfketaOHlOWHECONtcdG/3iS4VDB87vEAPEczBBRNwtTsW75bLByJORCzNxtzNfoc92M+W3oy7/ifiFrjByLHDEv2d12arAUk8qIuvAPtA08BG7UkaIhlihKfN521ulIJdgBz/J6gSu0aKb+2JgHjdKaXzYTX/efEDPhQBjIcfhNFHFkF+YMt0zCOHFoNcrEOvh0tmClCfDlL6cceLjb3HfnATBOSSZMicTZZIMBhATfGefSxvYx6c7XnHHqn1c8HojjPBSNf7f7q+RACH8am4pEHTIsjFEvYeBszzoXUejwTuxfS2xnI+8gJK9ayMaI+A9/ocQhs31yr1WoBAe5ZnIEZumW3WdDdTsDn7BIiiVioVys1z7gcaPEinvODyyucvfyFuTEH/xF7pDV1qAicVgrvGr4JJi6NUgoMZesSXd5v1vIlg9JWrgE3NSe5l/tcTuWWV7/6GYmZ7A3slrU+KKW+7GfrL19y1IYCZSCBUWpbXwOOchm1MoIaA0+0wZ22Sf8Ddwkn8rQ96k4QYk4NkqKrbDV4juh4dGrUvMKjd+l3kq5peJm/tyXOPapxsgB0CQN9EZh2oZB0WsjroZ/zCOQj8ptaSBrwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(6486002)(9686003)(6916009)(8676002)(316002)(6512007)(6506007)(5660300002)(8936002)(66476007)(66946007)(508600001)(38100700002)(33656002)(1076003)(66556008)(83380400001)(186003)(33716001)(86362001)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FRVZDi0KVDdKRUQF1qEs18h796JkYjlBLua0LMAEQ7L6cptxYXZ01iBkZGMR?=
 =?us-ascii?Q?yv+BwO8Bc0JPKfqEzSk82qOvzgeJJxu361tIvEZNtA98CAPUse1s2tZGbGrX?=
 =?us-ascii?Q?lLH1UoD+ub4r8Sj/TKNmBMMMgnehSlaNxxpum1e4k8qaI2QwOiWggSei9wIC?=
 =?us-ascii?Q?ptFMYH+2r6VYY9zjXrYezd0w3iU8TmQ4sPK0b8XLfD3Ozhmgf8uMn3Goa87R?=
 =?us-ascii?Q?TLtYHqmxImlh2xP3VbS7g3lwnPB+SN3LKBl2vix3LGiquNrB+Mjz8iFmAgJs?=
 =?us-ascii?Q?kAEuliAY7vJcaduH3WBivIKvaa8B0o1kMa4+aMO792tpw7t5BLOMx1PInuoi?=
 =?us-ascii?Q?Xhnic5gd86LRe0pixUe719R8jdSKC5keKcwSlwyc39dza5SeRA+griLa9lok?=
 =?us-ascii?Q?C2tujgGpzITRSFumKgTaMYh1uRcU8reUMbPC42Pbp7YFYr/Uf/y1Wb1BjZue?=
 =?us-ascii?Q?6UOHYLTjSHCUoy+ZzvRhihfyNbo0kCbqiAPuW2Xs8STKdSbSSiDbBvCe/e71?=
 =?us-ascii?Q?cN+LTDX8GWFpwP/m40sF8YXScjpaSVMP7IqrUVhtXSdysvwS2lGboqqTTcdC?=
 =?us-ascii?Q?xA9Rv6N52AMrCkb3pA4MgQ2lQTMmW7C+6hbf2Ao/VcMrulqdPioa64iZ6EHt?=
 =?us-ascii?Q?q/hNI+DSkynT2P77EEy0/Ej8hNpgp0gjdYwQO/YJLnGR2/caBmf+87rOAYNo?=
 =?us-ascii?Q?IxQs46WT8C8zV6UfFlrlATo7stVO1GMcp+TyOeAOlIyTYH3qFJllumxr6qDV?=
 =?us-ascii?Q?BSBnUYjG9t5aECp7aD4bXiPYWXErVE4jkMqKlzu9kZRmmaEdibYrSMomBq5x?=
 =?us-ascii?Q?nZ+sBWTFy6sqStXse6TwC58f3V72Nu9H0A0FlY4dLeJqxodeTYZBPl1mqrm3?=
 =?us-ascii?Q?YYXY/JC+3UEmwHOxdjzSBpkl7YkopzHXkrZ7ppt4sNyx/+TEavoLdEur+JXv?=
 =?us-ascii?Q?eZ3iScxzxlCxvDYZBNJGmAuXrs380YvOoLJQB818XUJdijbgFuvFpEhQ4Mbt?=
 =?us-ascii?Q?AdAAOPc5iDWWrev25C8AVKAaJFoFIO4XJ8s3ozRhlgJkThqw3YI93MEAcBnR?=
 =?us-ascii?Q?D5qSebRLnTW61eCYji/zyzwuYIbGB0fO7OKdLnF23Im03QNM/UtAr1PTnzv0?=
 =?us-ascii?Q?NqDtBvV/4Lw5Qvm/oFsMfdW4NbPMjPOa8TdOpDE5n3s9MdikE4UOyVgSMXnw?=
 =?us-ascii?Q?QxO0TagKQeEC7LMiwQUitHq+LAPV46AI6zHWgI4KrLQ7yGwpO1nSbixLqSZY?=
 =?us-ascii?Q?UDw6bn5QmwytzFfVmu8Bb3BmGM10mOMsauCvQ7R2PIGNo7wwJRArMRH+BgKx?=
 =?us-ascii?Q?lYbxW/iXx8sAEZJ5UvbPrez7GGJmJeEg6qno4CtuQYfXWUGupXRR56CEq7d3?=
 =?us-ascii?Q?YzoEs4jRd8hvgui2HHMM6tjZu8OdmuWEbOvQxoVfJKN9quO6wzG4DpT2qQLr?=
 =?us-ascii?Q?I0WW9heq7N0mSI8V7vyDyVenQUlyKxRiM1XK9IUVWCjwyoKFZqjcw0QOA6b1?=
 =?us-ascii?Q?9UWOqa/vifKxjQa1IwQHEZNqNsCFI8iWjZ8V2uK6D2ULH3zR/u+1pAw3Zeu5?=
 =?us-ascii?Q?onKNj0/YmlJTyDT5wibFd5bD2an+musNBqTV74vMrgiiGHLhdLNpF4x6o2q9?=
 =?us-ascii?Q?uCH5AvW/PAddnXMf6kw+6MONR7s8Bu/sM7n2lroAzu0jsxRMauzN7zo7zMS+?=
 =?us-ascii?Q?MTC/N4yJp2CuaxOx+gMRzNHtxOE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a634fd44-302b-4d62-60b3-08d9d694611b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 12:58:22.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1LNMxnyCtNc59xCobNGsVfDbfo2403jTA3W8WZDx++njS5zg4hvZXAEKRil1vAGHk3V1gkw2uQF7h1UQwxkPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3175

On Thu, Jan 13, 2022 at 11:52:20AM +0100, Paolo Abeni wrote:
> On Thu, 2022-01-13 at 18:35 +0800, Geliang Tang wrote:
> > On Tue, Jan 11, 2022 at 01:02:15PM +0100, Paolo Abeni wrote:
> > > On Tue, 2022-01-11 at 11:45 +0800, Geliang Tang wrote:
> > > > Hi Paolo,
> > > >=20
> > > > On Mon, Jan 10, 2022 at 12:11:38PM +0100, Paolo Abeni wrote:
> > > > > Hello,
> > > > >=20
> > > > > On Fri, 2022-01-07 at 17:51 +0800, Geliang Tang wrote:
> > > > > > IPv6 removing test failed on my test every time, this patch fix=
ed it.
> > > > > >=20
> > > > > > 12 remove subflow and signal IPv6       syn[ ok ] - synack[fail=
] got 1 JOIN[s] synack expected 2
> > > > > >  - ack[fail] got 1 JOIN[s] ack expected 2
> > > > > > Server ns stats
> > > > > > TcpPassiveOpens                 2                  0.0
> > > > > > TcpAttemptFails                 1                  0.0
> > > > > > TcpInSegs                       54                 0.0
> > > > > > TcpOutSegs                      58                 0.0
> > > > > > TcpRetransSegs                  2                  0.0
> > > > > > TcpExtEmbryonicRsts             1                  0.0
> > > > > > TcpExtDelayedACKs               15                 0.0
> > > > > > TcpExtTCPPureAcks               23                 0.0
> > > > > > TcpExtTCPTimeouts               1                  0.0
> > > > > > TcpExtTCPSynRetrans             2                  0.0
> > > > > > TcpExtTCPOrigDataSent           24                 0.0
> > > > > > TcpExtTCPDelivered              24                 0.0
> > > > > > MPTcpExtMPCapableSYNRX          1                  0.0
> > > > > > MPTcpExtMPCapableACKRX          1                  0.0
> > > > > > MPTcpExtMPJoinSynRx             2                  0.0
> > > > > > MPTcpExtMPJoinAckRx             1                  0.0
> > > > > > MPTcpExtEchoAdd                 1                  0.0
> > > > > > MPTcpExtRmSubflow               1                  0.0
> > > > > > Client ns stats
> > > > > > TcpActiveOpens                  3                  0.0
> > > > > > TcpInSegs                       58                 0.0
> > > > > > TcpOutSegs                      53                 0.0
> > > > > > TcpRetransSegs                  1                  0.0
> > > > > > TcpOutRsts                      3                  0.0
> > > > > > TcpExtDelayedACKs               3                  0.0
> > > > > > TcpExtTCPPureAcks               29                 0.0
> > > > > > TcpExtTCPTimeouts               1                  0.0
> > > > > > TcpExtTCPSynRetrans             1                  0.0
> > > > > > TcpExtTCPOrigDataSent           24                 0.0
> > > > > > TcpExtTCPDelivered              26                 0.0
> > > > > > TcpExtTcpTimeoutRehash          1                  0.0
> > > > > > MPTcpExtMPCapableSYNTX          1                  0.0
> > > > > > MPTcpExtMPCapableSYNACKRX       1                  0.0
> > > > > > MPTcpExtMPJoinSynAckRx          1                  0.0
> > > > > > MPTcpExtAddAddr                 1                  0.0
> > > > > > MPTcpExtRmAddr                  1                  0.0
> > > > > > MPTcpExtRmSubflow               1                  0.0
> > > > > >                                         add[ ok ] - echo  [ ok =
]
> > > > > >                                         rm [fail] got 0 RM_ADDR=
[s] expected 1
> > > > > >  - sf    [ ok ]
> > > > > > Server ns stats
> > > > > > TcpPassiveOpens                 2                  0.0
> > > > > > TcpAttemptFails                 1                  0.0
> > > > > > TcpInSegs                       54                 0.0
> > > > > > TcpOutSegs                      58                 0.0
> > > > > > TcpRetransSegs                  2                  0.0
> > > > > > TcpExtEmbryonicRsts             1                  0.0
> > > > > >=20
> > > > > > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > > > > > ---
> > > > > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >=20
> > > > > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/=
tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > > index e48ce23d2386..41a2510e2f97 100755
> > > > > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > > @@ -393,8 +393,8 @@ do_transfer()
> > > > > >  				do
> > > > > >  					id=3D${dump[$pos]}
> > > > > >  					rm_addr=3D$(rm_addr_count ${connector_ns})
> > > > > > -					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > > > > >  					wait_rm_addr ${connector_ns} ${rm_addr}
> > > > > > +					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> > > > > >  					let counter+=3D1
> > > > > >  					let pos+=3D5
> > > > >=20
> > > > > Uhmm.... this is equivalent to replacing 'wait_rm_addr()' with 's=
leep
> > > > > 1'. It defeats the purpouse of wait_rm_addr itself: reducing the =
delay
> > > > > required for 'del address' related operation. Additionally, an
> > > > > unconditional 'sleep 1' could impact negatively in other test-cas=
es.
> > > > >=20
> > > > > Possibly some alike:
> > > > >=20
> > > > > ---
> > > > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > index e48ce23d2386..b209a303d1fe 100755
> > > > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > @@ -366,7 +366,7 @@ do_transfer()
> > > > > =20
> > > > >         # let the mptcp subflow be established in background befo=
re
> > > > >         # do endpoint manipulation
> > > > > -       [ $addr_nr_ns1 =3D "0" -a $addr_nr_ns2 =3D "0" ] || sleep=
 1
> > > > > +       [ $addr_nr_ns1 =3D "0" -a $addr_nr_ns2 =3D "0" ] || sleep=
 2
> > > > > =20
> > > > >         if [ $addr_nr_ns1 -gt 0 ]; then
> > > > >                 let add_nr_ns1=3Daddr_nr_ns1
> > > > > ---
> > > >=20
> > > > This patch doesn't work on my test either. I changed it to "sleep 2=
",
> > > > the "remove subflow and signal IPv6" test still failed.
> > > >=20
> > > > >=20
> > > > > could be more appropriate, but 2secs to complete MPC + 2 MPJ HS l=
ooks
> > > > > really too much...
> > > > >=20
> > > > > Can you please capture a pcap trace with the failing test?
> > > >=20
> > > > The pcap is attached.
> > >=20
> > > Thank you!=20
> > >=20
> > > I'm really fail to understand why that happens, but the server replie=
s
> > > to the subflow endpoint MPJ syn with more than 1s delay, and that
> > > causes the failure.
> > >=20
> > > The interesting part is that the ipv6 routing configuration is actual=
ly
> > > broken, as we lack an ipv6 route for the server on each link. The
> > > following addresses the issue here, but I don't see how things were
> > > somewhat working so far...
> > >=20
> > > ---
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/=
testing/selftests/net/mptcp/mptcp_join.sh
> > > index e48ce23d2386..cdfb7da47384 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -76,6 +76,7 @@ init()
> > > =20
> > >  		# let $ns2 reach any $ns1 address from any interface
> > >  		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric=
 10$i
> > > +		ip -net "$ns2" route add default via dead:beef:$i::1 dev ns2eth$i =
metric 10$i
> > >  	done
> > >  }
> > > =20
> > > @@ -1545,7 +1546,7 @@ ipv6_tests()
> > >  	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > >  	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
> > >  	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> > > -	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
> > > +	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 dev ns2eth3 flags=
 subflow
> > >  	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
> > >  	chk_join_nr "remove subflow and signal IPv6" 2 2 2
> > >  	chk_add_nr 1 1
> > > ---
> >=20
> > Hi Paolo,
> >=20
> > This patch works on my test. Should we change this "single subflow IPv6=
" test too?
>=20
> In theory, yes...
> >=20
> > ---
> >=20
> > @@ -1654,7 +1655,7 @@ ipv6_tests()
> >         reset
> >         pm_nl_set_limits $ns1 0 1
> >         pm_nl_set_limits $ns2 0 1
> > -       pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
> > +       pm_nl_add_endpoint $ns2 dead:beef:3::2 dev ns2eth3 flags subflo=
w
> >         run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
> >         chk_join_nr "single subflow IPv6" 1 1 1
> >=20
> > ---
> >=20
> > This "single subflow IPv6" test passes every time with or without this
> > change,=C2=A0
>=20
> ... in pratice, as you noted, it's not needed.
>=20
> > but the "remove subflow and signal IPv6" test fails. What's the
> > difference between the two tests?
>=20
> I'm wild guessing, as I still fail to understand the full picture
> completely. In the "single subflow IPv6" test, is irrelevant if the
> additional subflow uses the "wrong" interface, because we just need to
> establish it.
>=20
> In the "remove subflow and signal IPv6" we have additional time
> constrains due to multiple subflow creation and removal, and the wrong
> routing setup causes the large delay I mentioned before, ence the
> failure.
>=20
> I'm very suprised the wrong routing setup casues a delay instead of an
> unreachable error and that puzzle me much.=20
>=20
> Do you prefer sending a new version of the squash-to patch, or do you
> prefer I'll go ahead with that?
>=20
> Please, let me know,

Hi Paolo,

Please send the new version. I'll test it if needed.

Thanks,
-Geliang

>=20
> /P
>=20

