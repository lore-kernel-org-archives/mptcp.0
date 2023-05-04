Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC081863
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 10:57:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7zTUFdCb70xhAJABo3PuklY/de38/3CRmCAgi85OracFDUwUUBnjZxVofoPbSZqSKMtZV3LuwH3WN+FA20bcqQ6thJl7/u6t4O1vOlDHDIMP59cQRBp3+D+sEdnvz24ZnpBuH5onoGOQYP2d8zSGN3KjhX4mM+8R5QySaaihmt/fdvGAEf7xo58Lubkg6jmgBeSbbqOxVxfou17/yrdJ2jrA3ZqsVMYptgpC3dpr6Apcp7kimyrtg59GqudW6QHJpKh1PpS8wJRkhFhXVPVWLUlTjmYOGw9GZ5kybZw5M4D6249DenLZ7/NQFuRfngYSOXzlhTMUF36WZb4xJp9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIDLH/hbR8t6KRSqu3Q8GjrdWa4ztBfzeZrlphvsj3A=;
 b=Ec4+3vQQN/l0fAaNa7xj+ZkVet/eoQCyri6Jj5+cOTfBm8qQHsOhfcWQIPUhfipel6z19E2Y4XexlSdGzbE0mCc2fgkzbYgu/HX+EUzvuavw5oG+KN4FHDbWjYT9MheFnbeNNy0rRAkI3xWzr+lm7+sbkxjKYmPribqCfjBSpNuKynbb7iquRQiVe5vQ4Y7cw0TS98TXQl6b6YNE68aYhRRr3rcSaAG0XNt6y3dCz1yvKwDL06huTG9Vjg/aCXykkhp3Ad9LrpDg/uyExjMtq3Xc5QJ0Eu5n3x+G16LzKchhmWAaba21ZoShUEPbIJc8VBu0IVMeWVaHg4tQa6pztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIDLH/hbR8t6KRSqu3Q8GjrdWa4ztBfzeZrlphvsj3A=;
 b=WLwTRohUYsXKUkkgeI/SQxq8oMtfaYOou0Hs1xbMQ8yQ/vxuwWsxH984niScEz15EEW8G/51TV15XQFYit3ZAy9i8H/JujIbVBLLOJxadZu3Np5oVBeGXaea2dIRsnbKtgzF+fI0UGqaeSEj7jBE4Vdzk7fZoqRr6592CU5rrBBM8gyyEs3bj2b0GrtZ3+8vd8DVvYXTMWglpZqfZlr55ZtC4PTzAmRkvenEMhYKVFfj4dck4APMOGd5IDhNVVlok4U1AdC+wsG9x++p/yyRLSxR80SNhzCAjJQLM2ALJe+r1kNeUJyHu8flUIYX1l42qNYWSB0/fiwUnIJdY4EsVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 10:57:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::ab8:3754:66a1:2ef2%6]) with mapi id 15.20.6363.025; Thu, 4 May 2023
 10:57:51 +0000
Date: Thu, 4 May 2023 18:57:58 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 04/12] mptcp: add addr into userspace pm
 list
Message-ID: <20230504105758.GA17540@bogon>
References: <cover.1683195386.git.geliang.tang@suse.com>
 <4ec2d013559dce53d222e9cbd53c45a4b4d5ba12.1683195386.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ec2d013559dce53d222e9cbd53c45a4b4d5ba12.1683195386.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6bb844-c2cb-4675-d209-08db4c8e6793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+z/+m4o0MAr7YTkd/93hnRcBDgnY8UBj7UI/cFmdqjphzqpHleqXzQ9qV8Aagt0xZZMixbOLvcNiuCX4JMf3ZPfbjGbRDPmw3cHUtNMUBuMvz834NLXeG0K/vvOzVyh6C/BDT0pIZWP+tNxj/Y2VGlUYJQag0LdqhFWDOSoKA71FdgSiEAbDGmd52tOLS9bVE9s02zoNE0HS2CYsH9psqomSbkhOwSvlNt1v8SLak04ohkbAE574tiInLO3h6RDrLow2nzOc9itGdGTrL6ZHUpwVXWhx3mF3tAu1IfkuDtIuaL+/EvGcb0p24k3ySRwWrvFbaQZ2XS4RgG7bBpvccz2Dxf5w0pT/8ywPkHq2DbeyE2zkv8xYJeplY9+yF5/9+bV5p1qVSfwXhLVVXbGFYlcdAW1Frsl29azn3HvYKLXO5UcDRybNLL2LzAKMMu80GmmU8YCotHAYhCEgj2gcGzGftf2EppeL2zX1FJVjTA0Cqnzkc0VbCLCvidFwLeRJ1B1gTx6TwhEKW7UTjASF8mOtkaSLwrClUcKRhRreZC0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(6486002)(44832011)(26005)(33716001)(1076003)(41300700001)(86362001)(33656002)(316002)(83380400001)(6916009)(66476007)(66556008)(66946007)(478600001)(2906002)(9686003)(38100700002)(186003)(5660300002)(966005)(8936002)(8676002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eu1vVkLcT3XKjhIjZF6RxH69JzINHU37Nex1v2MJCbKfGOJPw2L+QjT6QX6s?=
 =?us-ascii?Q?zt9J+kG3zo418lNgbRUZ4q/45GMP0BXBII5p+wSQi0Vf9aTElhnTJ6rVolS3?=
 =?us-ascii?Q?GWY+dDkpBqqymwFMpQlmM347le8UxtYXS98rO0zl0By7pjoERwrUb/J/06Nb?=
 =?us-ascii?Q?QmKnx+NQN2NodM2Yyvhd/Iv53qRXABTMyuz+Z9Lj+IUotjPQzMfUPhNpc/6V?=
 =?us-ascii?Q?cIBwBCTKMpce3qMXxaopnNRvAZI/pJ9P4f9INCVULHw1K2D/FU7Z4qoNji94?=
 =?us-ascii?Q?D9/XoPx63eTiXgkmZPsaz/2nT/J3HnR40lY/pquZ7DpznZ/UbuQvJGCo7mL7?=
 =?us-ascii?Q?JVCUq75Xsd9fgDM0p3qIPMRGnvXd5Cus/0sJZRNXl7dzVxgKVQUEhg35XtnY?=
 =?us-ascii?Q?QRdXa9YK0VWcbA5x/n71eeTYiPELiELVLzvClT5s/SnEtSc0362uYMwnO+OB?=
 =?us-ascii?Q?3ulqKcfYdLMGyE3O31g3boHW8iw4fvKE1lcix9mI9F/u4iefvPhfkhsIKozy?=
 =?us-ascii?Q?DncA8PouYSI/GQ787oBkUDI7vuR6T3ItTepqffJUtt9PTpIS9Pz1vnr54Jfx?=
 =?us-ascii?Q?Kk2CJtLokAE4YOBJTbfOgWSU1tCYfF6vVmy2mpLLfQgO8gvmgoVq84cRwIyA?=
 =?us-ascii?Q?1d68NZ2TyFA8gwt1zH7D9ZeHxCpjPPNHX47W589tjf5QuNQixt9GX8eP1AsQ?=
 =?us-ascii?Q?AKwqHS2QnMQ8EhfnrQM79Td17IS4MrrJx/5TJVNbDnvVN4F45bnkGMYZ4MEW?=
 =?us-ascii?Q?dxr8Dh/q54JHGmjiPzC3qeyHXBoDc1ABx+CabCxQ7dFAX6IkH0v30wVy1oCT?=
 =?us-ascii?Q?A07FTVO+2QOPcKdlP3eYHI95qtmtIhrQEndYjDlemA4CkcUkbRQiuevMfN2u?=
 =?us-ascii?Q?MREHqW6cVyyLBzOMeuXv7i5MU5Q5PM6YyQgDtgOIzFCbN+E8wULe8F8xsLL9?=
 =?us-ascii?Q?T//+zVZGJz/Fh7MGgPsBGzebwn0j56zxSGQWNXPu3Wk0HEBjTgloPHZOpI8J?=
 =?us-ascii?Q?jCwY+Lic51Rha4lUNk6/1PSAl27+i22HN0TTeVF1GMXKNqSrbuHDtUezFo1l?=
 =?us-ascii?Q?Q9/UFofntAGkXX1Mv+m3FmWc5XSkvDzE05aK78sVhLbIzq1DDQt2pczXixjI?=
 =?us-ascii?Q?aog5i+P18H3TTUBeLX+dHNIuUkmiYekUCQJ9yKC0Udq7HfYUGJgp3ID3U1w1?=
 =?us-ascii?Q?Kh1nL0ZsoWjoGwGG9Hpx4O7/kNBbPFiZ5UplfPukeGP+mbwDYDR6/oj5FaOQ?=
 =?us-ascii?Q?yNsiqxy3EYcA/NN/B7v93XCkF2sCb51+bg6JY1prmgnp6g/Vm3oQ5G39Vmmp?=
 =?us-ascii?Q?l+MZ/XEAnWVTl5pC5pNoGKj/Hax+9I2lai3Uvqgnyy6VK9K5Au56vvZyOzhX?=
 =?us-ascii?Q?WI74fUcpLlx+E4QET3oZtBTM+rOMZlBvqBmAU7HUtNtuwNYKUE0MTtEmMnH4?=
 =?us-ascii?Q?TMuxKy3n8ndyXSpOvc2psOShVLzC7WVaWl8sJ6pzwLURbyn6IwJaCAH9XW5H?=
 =?us-ascii?Q?/f5t3dI7sUW5na5OhN/p/i3Oy9zCK8IGq6PrWrMDB8HlbAdR02vBVL8NvJnR?=
 =?us-ascii?Q?EFq76m8NHtlsJlP0KgwnVu0mzjvDLoncYjY6JHAW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6bb844-c2cb-4675-d209-08db4c8e6793
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 10:57:51.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzg+N8VyC5Cnu0cKxHPV6NbPSOlPot5eWHzyuS9y45JUphiYC49ghV1OcT3pagW4Tse7uVSHj6VCB87bBtjyHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

On Thu, May 04, 2023 at 06:20:09PM +0800, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
> it in the new helper mptcp_userspace_pm_delete_local_addr().
> 
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.
> 
> By doing this, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..c50e1507ae35 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,24 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	return ret;
>  }
>  
> +static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> +						struct mptcp_pm_addr_entry *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> +			/* TODO: a refcount is needed because the entry can
> +			 * be used multiple times (e.g. fullmesh mode). */

CI reported a checkpatch warning here. It should be:

			 * be used multiple times (e.g. fullmesh mode).
			 */

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
> @@ -251,6 +269,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry local = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_sock *msk;
> @@ -302,12 +321,40 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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
> +	spin_lock_bh(&msk->pm.lock);
> +	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +		spin_unlock_bh(&msk->pm.lock);
> +		goto create_err;
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>  
>  	release_sock(sk);
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	if (err) {
> +		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	/* If the subflow is closed from the other peer (not via a
> +	 * subflow destroy command then), we want to keep the entry
> +	 * not to assign the same ID to another address and to be
> +	 * able to send RM_ADDR after the removal of the subflow.
> +	 */
> +
>   create_err:
>  	sock_put((struct sock *)msk);
>  	return err;
> @@ -420,10 +467,14 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
>  
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> +		spin_unlock_bh(&msk->pm.lock);
>  		err = 0;
>  	} else {
>  		err = -ESRCH;
> -- 
> 2.35.3
> 
