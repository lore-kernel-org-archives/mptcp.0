Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2C7366
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 07:03:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvVxRJ5BONAyKFbdtRtG4qobb5H3LcZQidrnhY1rFUBRt/ev1leDSRreAHxTOLXm8q9J7fB6AZVczgbgfRrA8EY9SyhhSr+8jsqj3NHQZpLiu8mJPa54CiHCs09qONVASj/fEswRTdOZMerO2NeFuABL+kXGSMvKv/MQX4asqIK943+W7l7PxoALR6tpoKFhyrvIC9gdgi2CpMcQOAPlx/F+I9+ggrvU9Su6PU8OsqNjrPkUAGFiI0nKZPF6NzOVgWWOotpXOUawa4eV11S56BtTVqKLIDAQ8kuvC1KJ/NBZGBEsY3HiPw7LtT7vBu34jWHRcG5/J+2mgoywuKgrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwmlETeij26o19xcrAIx7sVJSSfF41uVvrldGyvbFAI=;
 b=Yf36oZIMLokKGFglRWaNQ264/jaSirNOelYdEVNfAOXDpIA55gEtiA8hfdqShEPklBtnzh+suUVRA5bjmTv5RMUr7uXwSU1Cmxo6cDgJ6fuhuwSu5Ptst34SKDEh4B39wX0EePFHU17DS8suc9uNJ8kX+OMB0JmmrJFCq0b+1a5+DvarcSdGj265kJkQsuT7p0INCBYDf7ZQ/CQQTvMLxofruT/CXtI4/Mx/vFmBHoqglH7FHnjDxPUMp8Y/PwJ+wfUri1l99dAHhIOtgz9WtMoA/XNgu+U7autcZL+6qmaOau4rIbDClhRMi4GUvfcBz2kVdlfHq+5gLVWbMj0nYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwmlETeij26o19xcrAIx7sVJSSfF41uVvrldGyvbFAI=;
 b=S0d5aMW+HjZY/y0CjeJ9P0ATOajhJ1RgWjI83AKjJwWDnvEkSSE5L7uUS8q21q79UF5u6OYwuEzYrlpELoCqwoF8enxgBJvllEpAZ3N+qXF35cdSyWZlMSncINTMfbAq+ipVEA3acbF34YYE2/fMhBm/PIoulDTRshYrEVFOBnCPmFcZ9t8SoK5gBpbnq4YDWhbbtVnXQ/m12ZJo4xph/7EqhtINBBckXJy0im/HsrY43MzrhdYjPz/tcRH9uNWDmkvKqh4wGA466h0mgufGUiC9SZQrD9GJv0R1VtUgp6fCIlXtKvaDMHRxSh4zevonjWoNZYXZXX3m2HH9ct03vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 07:03:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 07:03:52 +0000
Date: Thu, 13 Jul 2023 15:03:45 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH iperf3] add MPTCPv1 support
Message-ID: <20230713070345.GA19473@localhost.localdomain>
References: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
 <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net>
 <8c868c93-86a0-39ab-57d6-e621c833f8bd@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c868c93-86a0-39ab-57d6-e621c833f8bd@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fc65f8-38d6-4949-45bb-08db836f50c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9WW3MqJreG03dJrlH4imtFAeO24G3NOo6jj43kq+7cGtFRQQdK9Z9e5Z1tQs8MaGpEDyAmnrg82E/q3JVtgoYjh/3KtHhNtWMUbFq+HK5nIKlRhsEhYMTSvvIJiK/D0Q1UWWPic1u5tqiJlvAQ7y4+N3T7mF6NUEZNpkGOJ4Rr8zuGozR7rMxKZi8R/FBF98hVpL5PdfreOYhfCVJDhipN8aBpe2WedtWeDFMQGHTePalUcOSt1DtsrINXnRNHlMW89csJNH9NC/NELusnxIav4+I1WS4qYffnnCZWJmESgCv2mXmDU5BLulgpgF7L3Gl9SOjNSD18gJc2NejjG820lTeeIMJ5Fr3ibwFlHQ5drgP+Ewp8PGfx3BWcXNC86eNnJG3Jd68IIo2u1XVsZIn8by+J21+2vVfdnoRMl/gymXkb7xb+nd/CJWb2AcIQtwtZQkQupwYYHgBZDYB2gzc6v9a92bR3OSvYZRTuCVneHo9G22tvu/kZ5/S3uuqJTamryBXqywCDk2qub4pkoHVM0OtBDi9m08pkO0h0CDGNmp0YR9+aw47BGR1k/wJHCdr3bRou/G6gqIqOw5zhgmbYV1nl0UN9hA44UJD+HOG3I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199021)(316002)(6666004)(6486002)(66556008)(66946007)(66476007)(186003)(41300700001)(6916009)(478600001)(4326008)(6512007)(8936002)(8676002)(53546011)(86362001)(9686003)(5660300002)(44832011)(26005)(6506007)(1076003)(83380400001)(33656002)(15974865002)(2906002)(4744005)(38100700002)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UTkmF7hk95k9FkFeNs/v0aZlnFY8ZF3/4atC4MszVrjVcpa+PtCKDx6t2acZ?=
 =?us-ascii?Q?S90I/3iRqTXyOXSWaXK0ulIMw4TNzKZTfhOc10YUdHSpd1Akx5vUI461g7pV?=
 =?us-ascii?Q?sdHeuZxhCG52JGqcILGFOdVB8o7/PNFeEZ1sI7vy4mECLGqtrrSq+kqoyNRH?=
 =?us-ascii?Q?qK1G8UiZppkvK7NnAtpYulZKGT+vEpxAFnGJT1y4PVTWTToSYWbRc5q2aXYs?=
 =?us-ascii?Q?lIyQi3yFNR30y2wiXKlbsT8ooqOfsZ2hK+8ryclj7Guss+OV+cPl3iUu0TWO?=
 =?us-ascii?Q?GUKj3naPvuJn+KF5BqS2mLUckWMXM4RZBs1FRE1rrOfuHzkNSwRn3T4Aa0in?=
 =?us-ascii?Q?tahrgSJ5m9yaWmxCHjvhqnsMpX29K1UJDWV193+sZWT0Cc3tJri1dRuZV1I0?=
 =?us-ascii?Q?W4TenOiMWZbS+C6p68XEChMPQ0Cgxbwo3sal1v6SL6SjYGvbDMy+T7IlLHYp?=
 =?us-ascii?Q?bs8bhYGe1HrfD8BTwi0OlnDn50+vQdoV4VzhsR4r/ZBOqB7ArKOHwsBnjXtv?=
 =?us-ascii?Q?eGWoES6QqGlfs1CvaMr9ExFoIuS8duwPU7LMH6mmL4gvbjMqc4+XcC0HvV0S?=
 =?us-ascii?Q?IXxbuMG5eMbqSOylIGP4Q9soRXIL4kiLccAAq04yOkDpGGCyZ0Nb1rL3VwSd?=
 =?us-ascii?Q?OTLvSP649nLgUr4D3pHqb/xhuIt4HDI3nHaKbgnS8MIjjsVeRQ2vkqN7JUyp?=
 =?us-ascii?Q?8STsEEzo1fhPGKq0ve7DPU+HL1hT3BIbL62bKpGsgohiYPWDA51mreqUOuXw?=
 =?us-ascii?Q?P8jUC9UqvBOxjvxbFxmhbjZphMs7xOF9JOoW6xp5LJ3pIAv8folv+teIFVy2?=
 =?us-ascii?Q?lLvBMDVmMfiVr/N+2wnoESI4a14kwcxZ/lltVM9Z++ht/fibPtswtgvkmRVW?=
 =?us-ascii?Q?bN6X6QgFLJuneM+mLisYt4lsxUbiHA94RwkrRRumC8kvfZIeCgDGaRQNf7Ux?=
 =?us-ascii?Q?eHtJRrOOWC6m+kF01a7IMe2AeocRttLFjjO2/Lfr/bL2abbRQXbB56DcNBJS?=
 =?us-ascii?Q?m1SrPJRhaj8Ontu3kKjb8PE5/oKTgfc/+f6Ls/t3usXJ2Onduu8WFoSyoR9Q?=
 =?us-ascii?Q?w+DJwccgpTUy3c8+gXfsmsfeYS8s3OB1J/5KHJMbYxUpkAJLIGSSvL48Lydf?=
 =?us-ascii?Q?TGqdYdnGKEWVdz+ESomROMDJwRc8X0hFc4ds6iw/qFic+j7+zZrUQjVM4qWs?=
 =?us-ascii?Q?i8ZEfgBse+3K3LQLwI1NR1cy5cZof8/YeFjKl2e+iYANbCNk5rvnZblyLEr9?=
 =?us-ascii?Q?nsFqw7TgEH5djJz9IzzQteWo37laFfja+V29Z/uCMx3xTfgOqbIVPAEUw03s?=
 =?us-ascii?Q?008N2gAJoSAkP3qaK3Q6xalT5ttfTtwPjvOj3O789B+nAJibjq2pt5aTT78r?=
 =?us-ascii?Q?z9j5aKQSTHKV/pCjDwnAPZWcGonTdVVGfF6YMDrPrv4aLNi6PHoeocMUisX1?=
 =?us-ascii?Q?H8GlvMlqgcheVNYneBA1I4CzNTdP7YjJ6q5CeuFymJLa/IZCUxDSo77DsRnE?=
 =?us-ascii?Q?Uqf/EQAGhv4ViiZfMGVgtNpzaIIfGRJkY7cMqkxA2s+mf7ApZ6yBzJUMZO/2?=
 =?us-ascii?Q?Q7n4gllw/7ch2/BzKtRLWMqzrQ4WzGFA7D3Bppcn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc65f8-38d6-4949-45bb-08db836f50c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:03:52.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slhLyuw6gudz30IqHRDFr0JPSMn8OQ12nkJfVYhkRQys45c4gAoG6+7wHmd2fochDL9Es7mQXmuoVJoGOcQpYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065

On Wed, Jul 12, 2023 at 10:14:31AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/06/2023 18:03, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > Thank you for this, that would be helpful!
> > 
> > The code looks good to me, I just have one suggestion for the commit
> > message, one "typo" with the alignment and one small suggestion in the
> > code. Please see below.
> > 
> > I think you can create a new PR on esnet/iperf repo (and mention it
> > replaces the one of Paolo).
> 
> What do you plan to do with this patch?
> 
> There is no hurry at all to suggest it upstream (esnet/iperf) but it is
> mainly to know if you are expecting something from one of us, just to
> avoid a deadlock :)

Hi Matt,

Thanks for the review, a v2 will be sent later.

-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
