Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F201863
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:59:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHA5djWAc99NoVd071MBFW26YR+63hf1dhfD+fG2NQU5gAVqsRMUCjMgitLu1wE0cG0feycBynPlM8Psc7mGQVLNy4cOiqrVIe3/Mss1gqpa53TQIq2qWNC0rz73r1++CO+alqCbx8LdL8DKVRRp5OgxgZh8QBHW4YZ3m/8uIWf+pOExVmAtnr+9qX+5D8EIiUgplVLpNRBWcPtc/4zC53gHhYl4gYHzXgAt/fAFELFlPoYgwXX4V4p9OMnXNEzY+ZfdiF9aITU6hyaOiyC3+gKOYwYbIfFSMbIM5NA4wO/pfBSNPjddUdTCiFVNNbeAAN/xoLZwGkZOu9dOUz05gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nl3kLBa9l3e0Cs/XK2eSflFk+p9gDO8oQkIhghHiOw=;
 b=RzBrE4yE7D5tCbhaWCIcK6gxG9neN6WZgjnPoae/Mn3p87hu4gRiHwOEQRSINyfxswdw7nPtkl7PWKSbhma3ohIgpQsQW8jp3qWUSLwyAjorvu0liaJJ0xOWB/v4oe8JI5uJlfcfeV4a/zxzQQdxXqMqCSG8+I4FSnrG0zYo0RtwUBP9kgCvs/96x009eaoXuZZrTK39MfAUJBODXypC23mDfVB/RK1PnIxOU87iLvExtb10wflgtr/vNQKLvj7peXBHPFwR+31nWfsvJ0RYbQRshmETsxXqa+hlW9WsupBZj7WPV969OZt7Vua02KakC1sl3DA17NEmCeypuRoeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nl3kLBa9l3e0Cs/XK2eSflFk+p9gDO8oQkIhghHiOw=;
 b=h2KwWWRU2YlIPq18cBkUtYzyiYMbDImxs+aoIMlbWUM/EPPMSHqv3aC/pR97ESsiPwUp/ikpu/w7bUPMhX9r9CsvZjSois7qg1Xp6K93xW/etu/Idn2jsCj/z5jlwVo0wxI2MYsXrg1R0Uo3tgfwQQAC39vzCdUhoxELl4ejvak0O5HkGYTj392RXp9XQwPKvfafeTQLY52aJVHvp2SBnc9/wR6R2IW3HI8Gdya2+g2zBzrrX4hL/rlaBCqAGP4To1EWIFhJXz1bs0iPwWrNCsB4WMYc6or+ElkNzJVs1/BztIhXAmi8OqnoqNepWRTrGBHTin6io4ftW3Ps06HNBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8443.eurprd04.prod.outlook.com (2603:10a6:102:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 4 May
 2023 10:59:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:59:16 +0000
Date: Thu, 4 May 2023 18:59:24 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 06/12] mptcp: update userspace pm infos
Message-ID: <20230504105924.GB17540@bogon>
References: <cover.1683195386.git.geliang.tang@suse.com>
 <0356f03ca8d7e6655914e26502308414d27d3ae5.1683195386.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0356f03ca8d7e6655914e26502308414d27d3ae5.1683195386.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b8531a-462e-4aa0-03ad-08db4c8e9a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Li8sNEVKs4c1qj9CYsYgQeQP6I4SznjpnNzoZCBk1yI20+C+rod0DJ7kjEzjSbZ/rtpc87gTavNua/5xBTTS8X0bwA35RnuTqMVevpSGQCFRsi0gDDgmQuhr282T6AaFxj+nyVHYMCEIvyftq/INcZScGjFOItcJtBWVCEjap0rljv90xA5hBZmeO/0/pyOSY7kupqaKCcstU1QqXAONupbebKS2EHeI3+r9x4eUUi5bwxWe4eiGNjtyPWOmfwncHIPgZwns+BCbV97iI/u79BqFnPnXZQL8Sx8PUXiLYOZaREZaPHlZ0VHbSRin/c/is7Dmf/LvregqIt+glRMfGo1MwABKrPfauzqZPB3BfLuo8nLVK9Gn/6aaEDL10jZgHDJZcaLW9Md0IuoF7q6fcBrfoTpFvcftszG7GY9zz8rF+59NZpH7s0VjJ6VJCjsG8fUkxe2WKb4LMSayJ70Lp7GZAWHyvolzeuzxbFuRGop5kVL/S2jY4C9KbIl4ujJNxRKZtf2c2uop5bhsO+LxI9Foyn1XNcLyRZhjiMB1ong=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(451199021)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(2906002)(478600001)(1076003)(33716001)(966005)(6506007)(44832011)(15650500001)(8936002)(38100700002)(86362001)(186003)(33656002)(6666004)(83380400001)(5660300002)(6486002)(6512007)(9686003)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?psBnDSngfwbpKPiH1MtzX71d7N9UzF/hX2G8YOTctxr6qdhOK5987qm3AOu8?=
 =?us-ascii?Q?j+LOEQhRSFoxwBWvUssoBvCnTRFoLTIHC/g9YskiutSnUfOV3k0xOZxoFscn?=
 =?us-ascii?Q?X2v4uBiIg95zV41G8snDKA9VucMBAqV8dp/rhQnla+tAkTRfpdBN6H73L81E?=
 =?us-ascii?Q?3bruk7kt7S2P4HM+BLTtkZHi9Yj1brT4AhnR37XpEqv42dt6bMWiw+VtNBr/?=
 =?us-ascii?Q?1dZCQHv18lx6qqxujJGmuuRfsE6ws505Lybnj3pUBaFv+CmqXIppPLTi9GSE?=
 =?us-ascii?Q?EtNFhJM6TO48trNcN2Vy8UIJjQBvK6Xg15EKRn94KyobNrYjDiWMKaBoGQN4?=
 =?us-ascii?Q?9xzRK2mF13AvIBB9axe6LQSynsldW3g2t242HKxQebps6Vrb2jBVv3yP4ysJ?=
 =?us-ascii?Q?PLCyHRKnLpN8kwtqMT8mYoeZ1CzRrmWra8vYrdtkUGZ63QsT86jFiuvWdFTm?=
 =?us-ascii?Q?nI/GP8VHU/XK61XMlPP/TMTtPlM2NWlI4ggj3HYRPfH2d+baNQG+Usw/jKV6?=
 =?us-ascii?Q?m0YhLLYJoANce642JUPP1BZ+nqSIvrcUF/sdOKkm1sar+m0BH7MqCUbnpPCT?=
 =?us-ascii?Q?Gh1JgZTJ8vq5VA3sOH+s5BLDCmo06sDdLD2vI2WzcLpgwuCNRaWjWM18TRzK?=
 =?us-ascii?Q?7EBKv/fxOmWYh/22RwKccWbJdLhgRJwa5P68hvM0nmKp85l4DTLnjRgOY2I+?=
 =?us-ascii?Q?JKQd153G7GHlLvrYv1tM7Sl0bBnwPm1QVh0Sl6waaVCFeemZ51O/vIAjK5sY?=
 =?us-ascii?Q?/vq8bsiRZYXp8MWkD+tIJ5QmvDZGXtrKVH5n9x0uiJ/0mzkmgwQF5Vs0YIcT?=
 =?us-ascii?Q?JpcqJfA+BxLXE80SMkac/J1hJG73jMwXo/y90bTjkKOJFgT8tHkhABUezLRX?=
 =?us-ascii?Q?P7Pb3+UMON6XY9cas8HJMzgWKvBpnYG9PFGlJWbcF0XmaQL7Nbrwsc8ofRx7?=
 =?us-ascii?Q?h+TarOKzWz1IlZhESqGHhNKSRWv9qlBwfH72ZX798k78t3skH1kN4SoxvI7W?=
 =?us-ascii?Q?kWODRKuFvgbm2NjsQX7XEkcdCCBW0O6yQ223EGlAOvuZbfeDEkw5KSAAqDgi?=
 =?us-ascii?Q?3r972cu0Y6FD4bpbIomijUzYu/8C2nz9o/Ztk6iQJKOF9lmNIGCnAXnJFe1R?=
 =?us-ascii?Q?w8eGmbN6cwcONcigh4MVy6vyrES1Mr8n8A4uSZpzQxKCn0skp0wHQIkt13mh?=
 =?us-ascii?Q?sFj6YcB91AQbbwCubqjMrSrXfijyteB10JIwHeznq2zumLFOtsGbI0zVaiG2?=
 =?us-ascii?Q?pRPf3QjcWGTMY8vXnEWjHUoSI2hYfcXqvjFGEPV5ywPRDBb6koDRodvrqw4x?=
 =?us-ascii?Q?da83681e5ytzXQUcNA13ZXu7/wQfN3gbnpQeu2j2O4kgrFOdnPv01tfw/8TT?=
 =?us-ascii?Q?2Fw379VcRSIDhdk3I8hK1gwS1Gr3dNWUB9vY3lwTsWpQ/7gAYS/8vhPTJnLO?=
 =?us-ascii?Q?qr2SR/9aVVYPLGO/yy4r2lUJGKKese1MTxKfI8W4mIMy54JGCUCA9DKVsWCg?=
 =?us-ascii?Q?w/PhySqHHDfPrywjRLD18vuChI+n7mgyB5Pwakgxz6d9v5SjH1PY6tQZzKN7?=
 =?us-ascii?Q?T/t4mnrXxisPTIg8bYwZWNNrVcwysbtBUFlH+Anh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b8531a-462e-4aa0-03ad-08db4c8e9a76
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:59:16.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6GpkdtxKZZ9bSHZ4/BKP7v/YqdzXtptpsQwGVA3830t1fKPPh7Zte2/YFWqNRQSsBIlNmR+5imzXYf21S4efQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8443

On Thu, May 04, 2023 at 06:20:11PM +0800, Geliang Tang wrote:
> Increase pm subflows counter on both server side and client side when
> userspace pm creates a new subflow, and decrease the counter when it
> closes a subflow.
> 
> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> address is announced by userspace PM.
> 
> This modification is similar to how the in-kernel PM is updating the
> counter: when additional subflows are created/removed.
> 
> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329

And CI reported a warning here, should use 'Link:' instead of 'Closes'.

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm.c           | 21 +++++++++++++++++----
>  net/mptcp/pm_userspace.c |  5 +++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 7539137719ef..9ba671902e69 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -89,8 +89,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  	unsigned int subflows_max;
>  	int ret = 0;
>  
> -	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_active(msk);
> +	if (mptcp_pm_is_userspace(msk)) {
> +		if (mptcp_userspace_pm_active(msk)) {
> +			spin_lock_bh(&pm->lock);
> +			pm->subflows++;
> +			spin_unlock_bh(&pm->lock);
> +			return true;
> +		}
> +		return false;
> +	}
>  
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>  
> @@ -183,8 +190,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>  	struct mptcp_pm_data *pm = &msk->pm;
>  	bool update_subflows;
>  
> -	update_subflows = (subflow->request_join || subflow->mp_join) &&
> -			  mptcp_pm_is_kernel(msk);
> +	if (mptcp_pm_is_userspace(msk)) {
> +		spin_lock_bh(&pm->lock);
> +		pm->subflows--;
> +		spin_unlock_bh(&pm->lock);
> +		return;
> +	}
> +
> +	update_subflows = (subflow->request_join || subflow->mp_join);
>  	if (!READ_ONCE(pm->work_pending) && !update_subflows)
>  		return;
>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index c50e1507ae35..98a5c81083be 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -189,6 +189,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
>  	spin_lock_bh(&msk->pm.lock);
>  
>  	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> +		msk->pm.add_addr_signaled++;
>  		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
>  		mptcp_pm_nl_addr_send_ack(msk);
>  	}
> @@ -334,6 +335,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		spin_unlock_bh(&msk->pm.lock);
>  		goto create_err;
>  	}
> +	msk->pm.local_addr_used++;
>  	spin_unlock_bh(&msk->pm.lock);
>  
>  	lock_sock(sk);
> @@ -344,8 +346,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	if (err) {
> +		msk->pm.local_addr_used--;
>  		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
>  		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +	} else {
> +		msk->pm.subflows++;
>  	}
>  	spin_unlock_bh(&msk->pm.lock);
>  
> -- 
> 2.35.3
> 
