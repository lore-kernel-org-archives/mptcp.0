Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82981211A
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 07:15:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYFNm9RJlig1fPKP03jirpxqMYQmXEGz5eWmjMvmhuC5hK+IZybg0eHCPSVXpth0GztoF55Mmo98fi0K7IbPO/ZTd2Bo0NrE4LqTskuxq/Ofs+dVVbp5U9y3dJiVOn3Q5Cyt8QU+pMZmfeeOJ3G4SEcHymTlr9JrcCrDRfEy9+Le0BxyD4ZLO5rjd4j7y9w59Zbtize9WDmb9T6+0D5h5E/yP/N+WPnvFNvQklWkNuRSjM2GuPgbUIQ8Zo38Zo3cArKSEie1hvAi/mSoIkSNessBhefqhfniQyNWlrZJymiRvlKxJXqQRnEQ1rc7yWkGJYN4K5LgB1VCzPORTZEUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ7eMrL4iuFqt5H17wTZHrzfyNZ8fDSd1RQ3xkln24U=;
 b=Iv1CLmnrOCkcfV/oUPOxHxIguNi73uYpz4BFsVGMInH0s07ZkALK4jI1H+4QxNQtASxhe86WsFKweWmus4smRREXCOO3P3ZerVSz25KLia7pSdmH9ZtivYGrg6Uh3AVXuVf7SWXoyjC6kqRSJQ5GCdCqEwhU1hJf2HAdXSRVfl2Crl1Eo6SusfkDakLcAqMQwo1oLA7HK5aajPvhDwUJVlWR+Os++t5aBpsygeX0v9A+h0eLPh8FOdRQRSjDjelGz8rzzS6qMZ1KIbb/A1JYm7PnY5Y98xUllt55zGQLhblgwugYkCimmk1cOfFHRBnRlwoCMa7B4g83utHGk8+oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQ7eMrL4iuFqt5H17wTZHrzfyNZ8fDSd1RQ3xkln24U=;
 b=zH76AHPRzLn3F47TjRX4F+G83lD8UrF4gjvj3tElwd01psHZRF6STmJQlLtxOuJmiXyPznvLZbn/C1rEYFmEMyCcQD7E2qg26IN0ECJ1pEtmjI2mmP7YbzjqtKG98zoKXd5CktuyVthi+wJ7r6BHmWeZHdR4BDAYQrO4Lrxh4pTNiw0LF9UBOULkrm1kGj8ZtWchxEZ+IwAeGpR8ieBX6ThINmxbh8OdBhdmJX2HJCbG592ISG7Zdpz3Ke+kr9yFE9LyJuwdtqRaHJPMTEQt7Fbc01U99tIK295YhLg26gUDXZefBWszWklm1JLTAH+9DglexmtzhqY0Ea8F7r7QYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9988.eurprd04.prod.outlook.com (2603:10a6:102:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 07:15:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 07:15:24 +0000
Date: Thu, 13 Jul 2023 15:15:19 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 03/11] Squash to "mptcp: add
 sched_data_set_contexts helper"
Message-ID: <20230713071519.GA19684@localhost.localdomain>
References: <cover.1687827857.git.geliang.tang@suse.com>
 <5694986e33e230afaa68c83c9e9fd64f7a551da1.1687827857.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5694986e33e230afaa68c83c9e9fd64f7a551da1.1687827857.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9988:EE_
X-MS-Office365-Filtering-Correlation-Id: a56d0a49-32a1-42f7-bcc9-08db8370ed72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gQuM8VYUAx75FCEOlRBnQ8ZT1YM7JPeq/XMzQAsGbY52a42vi1/N6AeneU68P1l1y4hcRIPAogcQ2vrsSzPODq6Nd17gjLvXUC+Jsg/Ggwmws4uxkbk7Z89L5MkDYIrXItZlBUyruzVsnjw1bRgpFWqLq8mOSckiBPVVeO4EDq7L1RISk5KMFGrt4omvdlWv64btt794axHOcoA2mqJhYUEC5kCtT98BTiymc7GaOTdk1/MvH+PECZ5s5xeUIpBnxf3+K2PFjjxy186hT90RHdszpO/o8/TNXNX0RY9Y9Elwz0pjHG8c/2GrPAqKzklji/w85obiXXw1N0IEjQlLSNEHV+X23kytXL/fyoIzxv8X5VZQzDfn4qaaXDPxmoasS48hBsho0oHSF3241rfFinYJrnhfPET5L0GqDfm6Kjh6ikZ5TgnehORqPHujlekT4ars/uwyOPDrWadbvgWCUzJFoGp/bDRZFoNCLqzZ0JtgJxewpQnBpdKl/62VFr0TFmsjx8W9rZBsiqPNh6mofhujloeeUN3/+Lbpr13oPK/sSABBz7Mtbj6Ioy2ROmep
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199021)(86362001)(38100700002)(33656002)(6506007)(6486002)(6666004)(9686003)(26005)(186003)(1076003)(478600001)(6512007)(2906002)(5660300002)(316002)(66556008)(66476007)(6916009)(8936002)(66946007)(8676002)(83380400001)(44832011)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kVMTX1H3U6l7z0D/YVKcP4CuGfXM2qIcATky9OwMsruwbY74c4OwZjO9LQH2?=
 =?us-ascii?Q?NX20XBe+sAgkXG3Pu2z+soPlajDZ+Jq+nKGzQWDaPr/WIyvdWxjeFJPYACCa?=
 =?us-ascii?Q?qmQW0NrhkfQqYmYPoOFFEkdUeNth4pM4X7hKK3xcATfyeanUC2ONXg22YjHv?=
 =?us-ascii?Q?VPFpyQ5d4P0CSo/4V/0YkdchLEsRxxcUJz5uN9sUTJ3ZV1innXyX7hWjt1ur?=
 =?us-ascii?Q?5oiu3yaEbQdCgPLmyqLVU2W/eWjJZNNHkhT8bwNEsi6d5u2l0VoWP2TAbK1C?=
 =?us-ascii?Q?zaJX8q3eS1a0MEhlZAoOuiOjF5Jx3PEyuqOfgAjvJ1pu+4KV2S31q+ZQljSO?=
 =?us-ascii?Q?x6OFxY9qXvluPAdml2XqOZjsbZzNcqsZfB7G8Uhd6nM8LW8O/qr4JZwdo7oD?=
 =?us-ascii?Q?10gZFOkZq9Pks4GBM/OfjQoHuqqN08YUk+qEhFdbvvXCyuTaZ+1T3JxI9pja?=
 =?us-ascii?Q?k1YZN5CrL/BqeAT9tzOluvN9DUQLQL2EzBHVZykCqwm4RN+K752Rib+gznij?=
 =?us-ascii?Q?NztscK3ZIAx9I8o1JRdaew8qpCIbTLC8Cq6KWLbvG3Nb1PRDm//pZVealqk8?=
 =?us-ascii?Q?Vbr9C60bq08XA6UdMGP3fehT/vCg5TOYDsYhSjVlAw5BXBieSPhwfloXFJsa?=
 =?us-ascii?Q?3uYxilEftXD9Y60sw31uhDl9DNot6dE3HePv9ZeJTNrfXZRdbMiM9zMYujvZ?=
 =?us-ascii?Q?Hh5XNBlc8K6D0EGAs3mqHiTssdJQ+I1Hh8nylBxv0ZY5vVNYidPqVxwT58kc?=
 =?us-ascii?Q?iRuPDnPVNhs93hkhO54posdzVSlXPhBv3deRWBhuu36/iKEEkFVNLjw0503R?=
 =?us-ascii?Q?R5pPWZVh7WNHasogWNnavYZfLaiWczJWuIGqTDY8QP0BJ7a9ahjYwUMt/tUa?=
 =?us-ascii?Q?8OXWwvGegkxv0XP+waD4cFS2u5AVJFGemkFdokC902rA/uyk+oUKyQB7kvnv?=
 =?us-ascii?Q?2PfG0Khrk+gnRVVJMeHRAxYR8Hp9RK1pc8dHM7+rdspPV64edKaQWdyoHKYo?=
 =?us-ascii?Q?fKv8DfISR/XnOyg6KR3NLjo0NFXY5qVME6BOyJMJW2RRYFlNgyKR9EznGmKD?=
 =?us-ascii?Q?NDmQfv+45lLq66jkY/FVgHvoEUj4WfeTXcD06fVJfm2ceXbQ4ad2nipuzVaR?=
 =?us-ascii?Q?115eyv6GyEVQujVOXsQ6mNzlw/O/ugWlFBZ1NWEE8kVNCFivP3l8lt9TRBWq?=
 =?us-ascii?Q?JnDIkArLG2t/llRzlyx9rUUJLC1SfL+5uoQe3suRG+MO3Bltc+MZPR9fSMRm?=
 =?us-ascii?Q?4Th/fjK1Pco35DyI/0ev3z98ekA5GIP8bVMsIz50+Cp9ZG905IBYV7UCmcJN?=
 =?us-ascii?Q?JhYahh8vOJ4SDMRnZeAxZPr9lyuwmx7z0/wkQats66s2hWWXZYpc1pM7w42Y?=
 =?us-ascii?Q?0NO5gOBPGkQPuqpSY8X5q8eRjhH/Ynq7V1nuLjo8fU18MxcDejEocRh6+gfI?=
 =?us-ascii?Q?fifPnJ8V0EWSfmeIGiQMi7n7FpyMCQ7hg+4JlE6QNLRpf5RJo7NzMWiFxHN6?=
 =?us-ascii?Q?A0UlEZ3TPf8KJv4CRpw1acN6Snlo6ltkiQl0UbO1p4ssw2bILMpAjGiW4PGT?=
 =?us-ascii?Q?SIvtz7SDhqs07pZO0hAK8sXOWtQouGHRhkUmXPo5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56d0a49-32a1-42f7-bcc9-08db8370ed72
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:15:24.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEbjAxx6eNFPR3FUvCGzayGX2vz0HIryZG1huU3jZwZsS+fbqhs8eJqCPlakyvyg/HLOX9aVBnjMX9aeS0I3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9988

On Tue, Jun 27, 2023 at 09:06:46AM +0800, Geliang Tang wrote:
> mptcp: add sched_data helpers
> 
> Add a new helper mptcp_sched_data_set_contexts() to set the subflow
> pointers array in struct mptcp_sched_data. Add a new helper
> mptcp_subflow_ctx_by_pos() to get the given pos subflow from the
> contexts array in struct mptcp_sched_data. They will be invoked by
> the BPF schedulers to export the subflow pointers to the BPF contexts.

Hi Matt,

You forgot to help me update the subject and commit log :)

Thanks,
-Geliang

> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.h | 2 ++
>  net/mptcp/sched.c    | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8c9b2a03dc94..cb2f34c8ed09 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -664,6 +664,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
>  				 bool scheduled);
>  void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
>  				   struct mptcp_sched_data *data);
> +struct mptcp_subflow_context *
> +mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos);
>  struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
>  struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
>  int mptcp_sched_get_send(struct mptcp_sock *msk);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index c7c167e48d72..82665263bb94 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -108,11 +108,20 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
>  		mptcp_subflow_set_scheduled(subflow, false);
>  		data->contexts[i++] = subflow;
>  	}
> +	data->subflows = i;
>  
>  	for (; i < MPTCP_SUBFLOWS_MAX; i++)
>  		data->contexts[i] = NULL;
>  }
>  
> +struct mptcp_subflow_context *
> +mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
> +{
> +	if (pos >= MPTCP_SUBFLOWS_MAX)
> +		return NULL;
> +	return data->contexts[pos];
> +}
> +
>  int mptcp_sched_get_send(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;
> -- 
> 2.35.3
> 
