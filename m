Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34C42F44
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 13:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651585761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdBG7YoLS0ncEfgzv12bJ9OxFF7fI78ecS3cGkYj3JU=;
	b=V6MyhI2bw84b4njkzM3D+2afX/Fnh4D8tTu7s8jCbVg5zF5QYoipTiPCY41HEHwCGvqXAg
	+Q+w+QhGtiqm+tE5L4C094Myp8crx8uV/0wsPAM+44F36XSisnjCznpg4+FIdGhB+/LKo+
	SMxQA16s/jJk9Zfj+b9LsOrTLtBp6A4=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-BJfrY_S0NoiNIDNgY55B0A-1; Tue, 03 May 2022 15:49:20 +0200
X-MC-Unique: BJfrY_S0NoiNIDNgY55B0A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCfK4MGMCCZZaMIkNvGVOWArfz0vIX/5SAmdrCB2mvI72PFtZxNHnGLPo531JKIIvQhQjvPa2BEWZtlXF9nPT/XhoGI1G6NOKd3FKB2q9FMN0WUNaU2vJNlkdY+xopTk36JoZ4LFRZ2n1JSL9Z2LGmbJ9Un6keu9X2AKiQEJtsL36qHpIjm7TPqV7CFEN/mVO47p5jt2ek/vvZpB5dE+xiYtXW0aBJu+GEBUKlQYAEVApcq3+gVN1UsuPrfEFLQ9brI6Bmdm6xoqeK5Kgf/HIQUjcWzGH0oq9Jw35XwOvLqAs6NTbc+hUbUXKPsLA31WXr+3+o7xldNaxwxSrmcMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdBG7YoLS0ncEfgzv12bJ9OxFF7fI78ecS3cGkYj3JU=;
 b=NEO4bsF5lixyWv0Txy8KmkHBHWC0u+lYFMGafJ7Dg4ld7o/7EtXha2ernVJ0Vv9QyfU35gwi3qoYUVi6nkvL/RbZzRTEhE9B9Xw+zfQz/kB7/k+n58lz6v6CEzL8SlLdbc2kIPr63RMTXuvWpK+wP/09PLL84Cha6d3khk8ZWAppm7L6eztAG4aKwwmEipoC1nfLNpcOFz1N9hqa2+5m5rucBfA0LPMW+jjLErzzkLp65OCSOqZyr8FFbnMinVKW48+MIKz1GNijaUFtfXP8A1PjmxUaU8Y0ND54zfers+5r5ZRziSU0PKXspwr2AY5hex9tx0stMJyHUUBxGyZrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8073.eurprd04.prod.outlook.com (2603:10a6:10:24d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 13:49:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 13:49:19 +0000
Date: Tue, 3 May 2022 21:49:13 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix a mp_fail test warning
Message-ID: <20220503134913.GA20147@bogon.HOST>
References: <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dd3d1ae0042025c2b4b4fde0e341562c200024a.1651537116.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:202:2e::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 146d187f-6f78-487b-001b-08da2d0bb864
X-MS-TrafficTypeDiagnostic: DB9PR04MB8073:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB80736BEC5AA7E61419BDB788F8C09@DB9PR04MB8073.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WIs/x6QI5mxkCMoTFcW/NUO3dM4/OXii+gaquYQuLeGB8u2txu58IobplR/GgS47XosDroBt7WDONKm8WkpjYbucynA494tKJ5QkcXjnCRN/jrVf3Mx6Pp6KgRbX4NxCq3q1J1jrsg5hi8i/8xeVn/sKaCD5jr6iqC0+3uVQ6Nsa1rl5K6k8wGkCP0eKJpMlJR1ze8f2ISWPgslx1NaSlUazpgtIqek/trk24pbb3os+RfZJLqYbV6bzulmCoiGKCrwMBCTQnzPTiCduwW/9Dl8V9JbGFHGYa/XrqVuuLVh27uY/Gdpme935zNsjF9ljUEYfXqgKiHmUcqQYsk7J/Gm/sxbUFKcdbR6/knCURYkgdTpEaxO7zDmYZ8JfASUe60Ja1ivnWKhBKccmthncAHTX4UI2cOQ+dlThjrNihZM7u11avsaW0/PNTQn3tF+zXIStZJTo8XIS68nB0NK3C44Uv2knsPPnHRP9jW8qEYBq2TmQixFvQYpwmq4IpcsJvyoapGSuiWV2BWowSj1ZTvaZuSelSgi98UGupx9MZFFaX9oIqBRvuLnT72+4VFLUfz0AIUt7D5RIP60uSS4CT2XLCoOlvw8PwxHRAQWkzpDKj2mC3AIDc3gNDCHmmA8WyzIi4Wj9Z2ngWm9Tr9Lx4Jq9Nw6yqM3d9EyYnSdbOATzWHe8c6T5l18cqtUQmQb6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66476007)(66946007)(33656002)(83380400001)(8676002)(6916009)(316002)(186003)(1076003)(2906002)(9686003)(6512007)(26005)(86362001)(6506007)(36756003)(6666004)(44832011)(5660300002)(38100700002)(8936002)(6486002)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YgtHyL9efZgNLiMCjouWl3Ud6RRdgA2ntIUT7I9GoT41nILN39jq2H9W3ZFm?=
 =?us-ascii?Q?uBV5Pp3uqD7hIgLG+029U9fl26Lc43ipKfuc6CImPq3EIY/T91Z6ekpSXAgw?=
 =?us-ascii?Q?tAZcYDhc5uMg+Pd9U6ihz9kDhCawMY5BePDSpA7Z/UXlLLpuZZ6ckbiknpvm?=
 =?us-ascii?Q?MXHC85lHTnkYYjRnVRbwbot9JSW5aPGuPMtE/guMetzAWHmOgwrn+fCSRiXF?=
 =?us-ascii?Q?LGdoHrcR7KliRcKMZLi8Ilm8hEBos0OS082dS9wpktIDNyz7nGtDRipE09df?=
 =?us-ascii?Q?NO2P4mRFKIFIyxZMOTwvfHu29ywHP4tsFu9I+Pyi8hYcTC17X38uXhfq6fOf?=
 =?us-ascii?Q?w8bzWDhNfBg7O2KI+PTu20+2K5B3Gi3iXSGJHNvtnhcvET/i2CRFYWIFpPPB?=
 =?us-ascii?Q?KEMSslLZI6/Aglin3ZEG/5EqumHrTEN5KQn9HAWeh4kdzz0EZrjDYAm2KFNM?=
 =?us-ascii?Q?maF2v+SZFBmGFoNwyJPLIBfycOE6yp03ic5fGR3UJYv77O8G3chO2S1+Iyoz?=
 =?us-ascii?Q?kYwNH2A7eqiSlhmpD88rZQTpumlb1GI4I+q5dogt2f5GlPJ0cGfIhJaXx/lX?=
 =?us-ascii?Q?o3KHvTiFE11XC3++faBaNZEnRmHVKlrkG3WX+Kkrq4ytdsUiKmjreCgOgsMO?=
 =?us-ascii?Q?O3n501OjTYLMUtbZvZ53o5zAIPnusbbxMfkxeNE2HLUIzgFuBS0RJyYe2Uz8?=
 =?us-ascii?Q?voD2FdGvcqOuQj0PjN8zX4uLElFosZiaW6v+7/bIve6QR/Ll5mzingmODWNf?=
 =?us-ascii?Q?AGPT3TtKQKrL/g6Tyhk+TM2CiSTvQL/ChUzf4jbJnbO/kXto4oZQmWXCHKmG?=
 =?us-ascii?Q?XBfBLRd9hNh+qLcLNhXAyso/ei7MZYyRMky3xcfM6b7GDV51zoTtow6QoyGN?=
 =?us-ascii?Q?slpH1CbwdSOZjiHgMaPcwrTm8J360ijccqKecpT72nPQznDLZ70NsFU0S8JW?=
 =?us-ascii?Q?A1CTVU0b+QCRKdwkvnW/BuiPTwddRpcdmy/O+TPXcrGs2/apWoAorSyb72h5?=
 =?us-ascii?Q?XXoAYb9cSt5axXY1Ob6aL5KruBP9rc+oLkqYyNvpJK8/S0HIa7oYK5aBeGNg?=
 =?us-ascii?Q?0gGirTnWYjTJQ5N6w3eaAtnjB//9X7b7RpOmujLVKb3KpeuukOd/KmacUKS8?=
 =?us-ascii?Q?ScouMPYj1OQ2giz8XRdQ4pgFM0NFMpdpwqAZ0R0fhwxJvZywijfg2JZx83SS?=
 =?us-ascii?Q?bga62f/3jlsLEjZySCQJMM/nJJBD1it+kqiTphORMoXgucwSfGOFeamqBH3V?=
 =?us-ascii?Q?D16GmWvC/Ql6q29FqN+i/QzsdJGI1DGYts4w5vtuC32q+gPUa4H0MgiKjl0Y?=
 =?us-ascii?Q?endOtKiDYiakEwYhIK3RZVtg9+UnxIgOEe78FtStPKc0+UkKFHH3usvZsMpO?=
 =?us-ascii?Q?c+QjrsYvdCQvMu/BsjMAeRJhzJRdGAUiHcDjxLQwdGuaiMSF1gG5TJ+JamJN?=
 =?us-ascii?Q?xZPnwwDSZ9KwTFQzM2QkhIp6+Qf5xDupHaWsi7xKzXzFEeFn+99mhfi3NKRN?=
 =?us-ascii?Q?PGUFcEPfGkPVf9l9roV5+7i+9a4o7Zyo+i2Q+SHojBScMnC3iz/uX4TatygT?=
 =?us-ascii?Q?O1ai7doImPSsI8KQvPlfoHIAZox/CXQvWh4Fv4Fvz1IqddnZKOiPiTsagSM9?=
 =?us-ascii?Q?yhEuIvbM8IisxwYfZUXvOA8NTUq6IqirMnajivxn7zp+gjZX3hXOw9s4bWZ7?=
 =?us-ascii?Q?Iiu4fQvAxdz1ryEUEbj1Vy4ORIR/+e2wKE+i+59DmA+7IqyCA3gHLLiHXAiz?=
 =?us-ascii?Q?o4YafK00DN4c8uFXWfAF0+lE2O8X9W4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146d187f-6f78-487b-001b-08da2d0bb864
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 13:49:19.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dmxjEsFFILbwh+4Ov81vNjoirj5I/WQ90SvNKwJoPCltreXYcCslIQ+PpOwJSpDRaxkh5529033FvT1gpwHyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8073

On Tue, May 03, 2022 at 08:19:21AM +0800, Geliang Tang wrote:
> Older version tc command (iprout2 5.3) shows actions in multiple lines,
                            
Here's a typo in commit log, it should be 'iproute2 5.3'. Please help me
to fix this when merging this patch.

Thanks,
-Geliang

> not a single line. Then the following unexpected MP_FAIL selftest output
> occurs:
> 
>  file received by server has inverted byte at 169
>  ./mptcp_join.sh: line 1277: [: [{"total acts":1},{"actions":[{"order":0 pedit ,"control_action":{"type":"pipe"}keys 1
>          index 1 ref 1 bind 1,"installed":0,"last_used":0
>          key #0  at 148: val ff000000 mask ffffffff
>  5: integer expression expected
>  001 Infinite map                      syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                        sum[ ok ] - csum  [ ok ]
>                                        ftx[ ok ] - failrx[ ok ]
>                                        rtx[ ok ] - rstrx [ ok ]
>                                        itx[ ok ] - infirx[ ok ]
>                                        ftx[ ok ] - failrx[ ok ] invert
> 
> This patch adds a 'grep' before 'sed' to fix this.
> 
> Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b703b61562bf..cb1ba78da3ce 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2693,6 +2693,7 @@ fastclose_tests()
>  pedit_action_pkts()
>  {
>  	tc -n $ns2 -j -s action show action pedit index 100 | \
> +		grep "packets" | \
>  		sed 's/.*"packets":\([0-9]\+\),.*/\1/'
>  }
>  
> -- 
> 2.34.1
> 

