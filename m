Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2080.outbound.protection.outlook.com [40.107.15.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4879F9
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 08:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbqr63vDuRaBzZObC3W4SRKJqOhZQXIR00CYPXPi5Sf4pzAdUQRi5peg7DTL7G6V5q37CTJhky3p1QvyT8idUzeIi6R/TEa94nb0aihAvG+K3ZL+6gN3sfAhB9z4HSNzlMJDidvGd225mg2ME/6rS+plzB3M8P6Tum/pfXT7+cU+W0Z+nWmvxntCLf9gJytJY+wwfDBD6fDrqJHBQn0kFLxESqESrGlfa287YYfKF5kbzaNRZVnrjRp/8LzjMEYJcFtqaPMip5/mGMnZejtrzFxqQgR3cl+7W7/yBfPWZrc9Dgu8j3Jsc7l+eHsmdc4AZgMTmal0CzkTUFMDc4aAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlihm9n3Tcg8HBF8NHg8lozSSIe8b+8jW3oi1XAIKKk=;
 b=RM7IAiS60/NrmaOjZ+88zLIsMkJLkKpeCC+q985Xbc9Bg7xPNw0ujubBKjGRYaS5Nh50JrRQWjAJ+uzQH8BLFHrL+E1JqNvGgk+MHOsTGl3765kjae8EIHL3/NTAyC/v7hALTnnPrNHQLh4EFPWsGIktWUEsFrcKasu4v+vrSxvt+hEHFm0Q15hORWDiz2MGV5IIu3IdFryKDnxJaHWvqqfIf98sx8q8Rz+ltvumqKNKDv4IkgYmmokpIH/DpJxT0mfhA+ohdSNGvlraj1rSNCVoeWT3rr8Uj4pKrENSQ8F6CqNGam9tSCj/UmXy6p7vZeADat4h58+dqBflNT0TAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlihm9n3Tcg8HBF8NHg8lozSSIe8b+8jW3oi1XAIKKk=;
 b=bsLVqq1UsDqjRps9VNsgqUd3UdLMCaUJIOCoDrTjKUFGRQA43XbKRxT2iwm9vWHuDd1vtq+8P9PVcHdKkITxx0ye82Svknfa4V5R8FBPOEr6PGiLSDbfmnUfmk0OqfKXwKdMrz5IHQfPP4E2ZbpMYyxKqtXGSYNdehJRiAx0z9C5cw1XLiO6IfcihSnP77mn4aYFbwmoL7iJV9/M3mZTbw9wECab7yBURTv25Uj7TG+Osri60z0pYpKILMjJmH7/YtuJ4wDEN4S7NUIVhLx226WCPC0tJZ99D5FwYeZEBdsSA6fbOzXKGFORF06sUdVlLBYd2J2hifnZzWmmVjF+Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8647.eurprd04.prod.outlook.com (2603:10a6:10:2de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:43:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:43:38 +0000
Date: Wed, 24 May 2023 16:43:32 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v15 3/5] mptcp: add address into userspace pm
 list
Message-ID: <20230524084332.GA9891@bogon>
References: <cover.1684915182.git.geliang.tang@suse.com>
 <b897ae1cbd3615b1304cac6f3dcefe42854f273b.1684915182.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b897ae1cbd3615b1304cac6f3dcefe42854f273b.1684915182.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8647:EE_
X-MS-Office365-Filtering-Correlation-Id: 284c06ff-daf6-4506-fae2-08db5c32f7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j9saCXzlNE+5erp/VIsM6GBSIkdHSBASz1o2htu5e6h4rbzs67W9jC9nQrgC9fRCYQbXYApZ9Y41J4SD7KNLxG1oA3HVdX2w7DECtIGb5K0Q0V9mCBa96b9dsJd/hiE9YiKcAZjEnkt5XOuKnbjBm2xTWIYRR7F5VrdFG0rTDpRzxXklZnQ5sp1goyYEwWA3hd+KQeyXuXMBiHKRa1BWhj9P0UEpmMdvnZiCM2tOCQHG2CduFSj01FKnGxgQm0edYKR6+VEZrlEOcAo6NFSPfPQk5oP1yiNAhnRW8ybwo19MiDN1nosn16gQ/pn26JcTgjj3CUM/idpZReJvwEjuE0dpWj70CWpXWMNxzQKQFMHYMCM90RnQm0rHlxcRgxFzGdZCMjIrWmjUza9mHigOCuNq/+qmAHj1IOCE+XgUd/9ODxPlK//IjExVAh/C5wA4pOGRnJjx0+eDHAQmJQy70tCyZEyqTgXRmYudkSKp8YmkiuUAifUwarLn4t3Xf1u7dnYDorYtzqP5sA9YAL7wS5mRibxRbblTraydD/inTfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(136003)(376002)(366004)(396003)(451199021)(2906002)(5660300002)(8936002)(478600001)(8676002)(44832011)(6666004)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(33656002)(6486002)(966005)(6506007)(9686003)(6512007)(1076003)(26005)(33716001)(38100700002)(86362001)(83380400001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h44ZSboYUqDhHdYrTLcRuitga2ShOnj0w7q+gbXRY4DA/rKKADlckNj5EVTM?=
 =?us-ascii?Q?teP04lBIidLP35Jdw59HyLzUCyDJ0L1C8CTNqxC8DLyNln4L7axPq/6WnmC6?=
 =?us-ascii?Q?ifx7riHUexB89uJ+ywFRyy0UYuXkn0VAc2plg0mlYO1T6b11RgG5taCR5Km/?=
 =?us-ascii?Q?93tZK3CqmzmbDkSh/hZMye7dVz+cqUhDuHP9ekVYBl3C+Nf2Nc9XN6qORSUz?=
 =?us-ascii?Q?r2iGsro+MBuny5LGNVWW5timxAgfJkJpn5rHg/d9fCh4fvTDoEaNtSiy/FZW?=
 =?us-ascii?Q?f9C4dDUj7ymrQVGWZ2+MmHNkyrCihEnindjiCiIAS6x8c8MEtaR9yjlZBLir?=
 =?us-ascii?Q?BgRY63f+NFhmQBGsoGEgpPhw1rNRdLw8gnNDbXeZ4PUqYNzNdLQHp8eu+vdz?=
 =?us-ascii?Q?3qIvnQ6fZwDA0KAWi9aiILCEvvVAPiAFav6gr6+BrJTTKYNQ/H9ApbIQJ0HT?=
 =?us-ascii?Q?1/ABUMDcdfYC7yTf9ZXoHfKq7eTP2i9ve05L09Q7VkNRMgY5/KBUYECylPKg?=
 =?us-ascii?Q?tPMumaiPzgoHnv2zHuMJuSk1wTJEIvsyRwIgq5UGInLMqh4VJ4REewW/BXER?=
 =?us-ascii?Q?P32G6rwhojnRuyAIbrS8PKEM7DVOql2eY3w9En39aNdzoH5KaKXR+1/hHwN2?=
 =?us-ascii?Q?s3d0kChvrqT+i3QKuCwmyEhALfmNyfAKTuJqwpMqbdhEl1qUUqjctqDoJAKL?=
 =?us-ascii?Q?73+EannhnfLjRtad4IkBAexGKSHALi9aYhmu5KHGrvyLJqJs9Em4gS3tLOP/?=
 =?us-ascii?Q?UZFmnbQrB/685xhdHt0nCnRXfcpkwP2m8vkdZaLz+9KwcrLcsDnxGmzA35JZ?=
 =?us-ascii?Q?TeIK+BL1xae5pux9k27hGSQJNywntx7d0TzNeaj9Ecgew9VyY8hRD+Hh25KO?=
 =?us-ascii?Q?/EWbjg6yP4Z9KkGG+gkUq1a5fiV3xvo0/ZUJ2WFRUKbe37jzdtaS2XBgXKDD?=
 =?us-ascii?Q?0iB2ulsS+HdOal9npmvhc83onXDdM3eJlCmVgmnW2uH79oBym9EMe14je1kF?=
 =?us-ascii?Q?W6ZMDq8mMgI2wjhak6dA5o4LDlmTnoI5hxslWAbDh0DsgwoZKPtfOMC4B+nO?=
 =?us-ascii?Q?InHAqgIBrLMldm6yVnMAW7Ca781T8oJ2h4KGNraAbEWwPVFtrq8iO6TuyoYk?=
 =?us-ascii?Q?id6oENWt5+sbymCiG72ftGdnR0puHfoKE4hDAiLQ6rcT/LhQxsuRqLsUcazd?=
 =?us-ascii?Q?FifDiOjZHQFbmN8pCS73LaIpCwHf7ZkH66RMLxxgJnoWifU2bWpskN7PnqMB?=
 =?us-ascii?Q?EwmE5d7s+7cizbA3yV+0IyPERPVXlj2WH0/abMpTm60jd6OnZE7NxixHogxD?=
 =?us-ascii?Q?peD59cXp/kXK79jQbaL3LbSqFckpmDsvS8V0I7nJqHX1gqlVx+tmZFVfubeT?=
 =?us-ascii?Q?sUddcsDJwyNhR26hoQQCCk2PKENROBEL8CR5U3KuoJG86M7I/IBZf/T4tmjA?=
 =?us-ascii?Q?zB+pCQMtz6NMpIbjVtv5ebVF8pZG8K0HOuurxUGWzFto75lyNLjNz0uyg7nf?=
 =?us-ascii?Q?v3xiupwAcMUoOnpzOTtcP8t2JmcnztXHrFpapGnvNv7zpU+YWoFfkP340onQ?=
 =?us-ascii?Q?68syKJR/W97524jUrfrc3AE5lwm/d8aSslNMRzV9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284c06ff-daf6-4506-fae2-08db5c32f7ef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:43:38.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xeSYDkZLjARtjP6ACxNO6xCDRRaFkfQlTBD2qlj9SWlYl4q0bZzeRsZHqg18WstXJ60UCi+aj5XATnI0h5Ocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8647

On Wed, May 24, 2023 at 04:02:46PM +0800, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
> it in the new helper mptcp_userspace_pm_delete_local_addr().
> 
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.

These two lines should be removed.

Thanks,
-Geliang

> 
> By doing this, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..114548b09f47 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,30 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	return ret;
>  }
>  
> +/* If the subflow is closed from the other peer (not via a
> + * subflow destroy command then), we want to keep the entry
> + * not to assign the same ID to another address and to be
> + * able to send RM_ADDR after the removal of the subflow.
> + */
> +static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> +						struct mptcp_pm_addr_entry *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> +			/* TODO: a refcount is needed because the entry can
> +			 * be used multiple times (e.g. fullmesh mode).
> +			 */
> +			list_del_rcu(&entry->list);
> +			kfree(entry);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>  						   unsigned int id,
>  						   u8 *flags, int *ifindex)
> @@ -251,6 +275,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry local = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_sock *msk;
> @@ -302,12 +327,24 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	local.addr = addr_l;
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		goto create_err;
> +	}
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>  
>  	release_sock(sk);
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	if (err)
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +	spin_unlock_bh(&msk->pm.lock);
> +
>   create_err:
>  	sock_put((struct sock *)msk);
>  	return err;
> @@ -420,7 +457,11 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
>  
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> +		spin_unlock_bh(&msk->pm.lock);
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> -- 
> 2.35.3
> 
