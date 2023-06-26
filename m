Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2052.outbound.protection.outlook.com [40.107.249.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C956FB2
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 09:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/hygsuVSoTx9cP3IWjMia2JFf/bQ/XBfHLo74+Cx/cCowZ2TUQC3XOd7iS5/GPlrRqr6YxmPUCgAJwXvhFyxBCmgh2AC5hv0w1zH/NjAs6e/U5JRxHRy9329rvkcL5xStan8C2P3QHzPx7xGj0Sd3yUPQN6Q26PV5Vu+Oh1ZGADnYUDsCTYMvzb3JaS3nvesYZvjeOPFA8WM+CqnW0yFtHP7yWgsjAVZrha4PX9OzGIeNsHJOzbiB83DMaJj/ipxzALChTjCnDmdVUbd3ZhB1qIw/qB+y7M1/Qon2/eRp/vDiOktYJfjRGw08OHKDne1mA3JRSPeDhoKWidW8rlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4B2gFT0WUN+CnodFmXh5coK90W0gkhG15cGBsKBaWcA=;
 b=hjx0obD5cR/sAuwM8GrTxP/k/txxrAxqc9wsuiKHcQxkHgJcLIuPVQvXMyxSj9U9cZ9AvvnbJiBjj3ffeiqeY8NobB4COfLNtFFGCDUG6l+IGSgLm8WQ3uNngzgN3+bfCWNKj/Cys2NHUUwLaL69jYHzrTM90HUypXnQrlxooqSFg9gIng4lZAeNkBT//Q3+s2EklS8ptuRLJvHe2bIb25YFtJHNm/ZsdLM4PzdyN99P/f44Fat1mwVBK/xIiJusWRXzPKSCiKRLNn3D2zlRmJcPsVKYR5yvov3rfVW/esAyzEIYApYdV2isA+5fH6QYE8aONQzkimP1cWyFsYIxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4B2gFT0WUN+CnodFmXh5coK90W0gkhG15cGBsKBaWcA=;
 b=xu6EavA3MxDSUz9wIytaryglE5HIY+34yawLQCDAys/DVw/8DJnK9Qn+xoCqEWgz6NsgfM16SOSJiU2ocDPjuyNz5n1x5b/48sQOzWdKDkXa14gL7w1x/nXGGIURolFypsj90HC7I/CoNg1ayuzCxUf8cURJiWqrnbZltmDW7A5CAxBwrCFf7OCLuLx+MEdBCXYMjBTwOJeNNVLokIg5tAS4qXhglSadrmEdpWTkgYDnup4lVgc36f4rZOOPRclykWiGjWntGBSV8ye9J9LgetCMhY0NXvYPtwjWDeys1GU+s6uJialQ+hHrjR6me7CuLak4Y/TaQREQZgUxFt18Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8695.eurprd04.prod.outlook.com (2603:10a6:10:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 09:40:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 09:40:44 +0000
Date: Mon, 26 Jun 2023 17:40:47 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v10 08/13] bpf: Add mptcp_storage helpers
Message-ID: <20230626094047.GB11120@bogon>
References: <cover.1687746021.git.geliang.tang@suse.com>
 <b2ec9149c3161152699aa6ac331d439b15a8380a.1687746021.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ec9149c3161152699aa6ac331d439b15a8380a.1687746021.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYBP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 992339b7-b7de-446d-43c4-08db762969b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s+XOpjE+wel5jxbAudCFESP9Ik65opxNe8WbxURszow/spFnxNzJw/cut9gIkAvRc8wiETUdxqIXi3KSoZDYRASI/87aILv2c/ThPRr09CmkRXHYGylfQDLfbsw+lyecDFn2m6TWRaX6KwsyxaV2DIwT2tY8c/z8NzF8R0k1xxr2zUdcyWLVIyHVKiO9xP6EqJSfJpBIxitd7hENlN1rB4oQkrbFqE1dO+KvyFw9b97w8Uvv4ixu8AcwKF2bHHiDodoQyH3PdIUy4924Sy7NRwv6Ks/hq7ze90KPC0m0NKpZ8x5NtWU3Q0fmYAHYo1vzPZ0mIe6PP7NSdEPzoTvD0CD3KRmBc5WNVR3QA/MMHQ9oDBGCe1k2vnpdErk6SFzhlGVGYFSNGxXzjfDOCYHN1N/jI/jXCsp2XqGxinRVFbMscebqkkQL/2fVVoVzOfsmaeqB3pzMGQcSVzFrj9zuGf376ocW67C7SFjJofv9w2gLQAqgtw8jWuBHAHlWSeA4rrYY4pJFjtvUUvORD5i0D5i4R2hUA0OPJkNl5Ht5LOKpubOFyi7fR6W9tgyMfa+3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39850400004)(376002)(366004)(136003)(346002)(451199021)(8676002)(8936002)(66476007)(66556008)(66946007)(41300700001)(316002)(6916009)(6506007)(6512007)(1076003)(26005)(9686003)(186003)(478600001)(6486002)(33716001)(2906002)(5660300002)(30864003)(44832011)(38100700002)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C2TxygxmWE8SATsJ0NjqxnpnbLy3MNoSwxQS7qOd11i6Is7MFevY5vLUDNLz?=
 =?us-ascii?Q?LAHjzU8oAx27JvSacC3msmUrEwzSRC+JOAytfyCjeJyIUFCsw0UEBcH7Mc9Y?=
 =?us-ascii?Q?92sAh93oFJeFIJyRHobZMaP+d7+RscSlDJ9opceEIN2PI5pAwEkiSQXLeiCZ?=
 =?us-ascii?Q?HMPdxvtBAql0F9vBNA14SIosrq+6q1QCBie3o/wMax1rxXZsd+Ga9M7X0P9b?=
 =?us-ascii?Q?cyAwWE9mSS8iuk6lQRg/+oBthykmsoYa7KUpMBSSnKoJ/7Bl6oHZR/I2YkIY?=
 =?us-ascii?Q?k1r2Kp9/VvEHR3XY+SaFwrfAZGy/ByDjZHQ2imIjNvuGFHIqqRMc7z/33+b+?=
 =?us-ascii?Q?H8aNJxptCHtyKc4jlVeve1b3HZ13S/XQouwrTd02Zg5NnumCv6Zm86pfCKqc?=
 =?us-ascii?Q?Y2OCZSzNR16dqAL2Dz9SC2ItWErFCq0OwtjBzKYwFoBhCJ6RplI7ijoOgL/A?=
 =?us-ascii?Q?fFBiC7lpQSem/pGi+I+HWqUlavu9aq70TY5VmPYgwKLQfXOkO7E3+ZHAVJu+?=
 =?us-ascii?Q?XNLiCHBbmAY9LCZR3fwvsp8J9PhP+THK1IWnhUrzgv8Lgm9PvbZf+n4B03zC?=
 =?us-ascii?Q?SeHUqXZwrINjMg7ayKmvlmqmRTL1Ihv/JbOkGGp+OftXyEKsm6bwH30LLqYT?=
 =?us-ascii?Q?hh14rt52U1LiI9gOhSLES2fwsJIcwkMFmJ/jo2InBvdNa1BIQYNyDygLMAXl?=
 =?us-ascii?Q?1KcGaiwuwNsnAZ/WrOzv4+lYuFTiN5XLMXWswAI0KCPzdozEzwWUgAB9tsf3?=
 =?us-ascii?Q?stGNEBmcULb8Ic5wDhaPiK7YsLJ7zhg6kk8H9AwxDxsxXrHth4RRFeOzwPiT?=
 =?us-ascii?Q?UMbGtkk861F8TKBEa4tCT26u7WepPGyx8xlijsNqXPiTfW5hZzQogEGQKAf5?=
 =?us-ascii?Q?kU92o8pW461nlmwdE0cZfwlbzT1cTbPesI9Glk+IxCIZ0Lmxvy0wa/j9LSZx?=
 =?us-ascii?Q?myckFAaHjAixMxYXnjbaMELCNp+rO05Dtkn0pp+JldzbahdABQXlIdlSfMep?=
 =?us-ascii?Q?/u8fkyzZjAcbmN4S9nU41q+HXnpSinEc3/iEETsXEHTdu0u4lOHDqspStAmI?=
 =?us-ascii?Q?qGdNwr/fE/b7kQcSaVjHZUm0FfQWxvvzoQmB39UMSQ/1IUzt09droEDVL0xE?=
 =?us-ascii?Q?SIfwjN9NuxgW7ToC0epYfGGzeEKgrOhjxe1EdN84InjXDpUIwJC36fInvBwp?=
 =?us-ascii?Q?D+jSoA7lsSeozsjaUWAxb3z7EFZO0HeB7l8Uhw3i/rIuFU+sGWKppePKb7Lq?=
 =?us-ascii?Q?O+hcEWWoKrrp3pXqT8lZY6hHmyn6QrFA5CZBuDNHvyn2lkadwcm8INPlFAIx?=
 =?us-ascii?Q?d7UDv/zb9df8Ha3RfZ09sHmGd9u6PCrPXB6501zMr/aftX36TOvzb3sX9j/W?=
 =?us-ascii?Q?Z/Eq1Qlrymw6fhOWzzUjJ8JaBTrFOyNV7rEuB6yZdHHbohqrUgq+CLsyd2Ge?=
 =?us-ascii?Q?DPM+1X0vwlZls/BSSpcSp2MYKWjI7aZ8GK6CbL2N+rESgD9hBRKSIc9FDg+Y?=
 =?us-ascii?Q?c/BOd3/v8Qww9kdKiJ/FLJgUwyet/Eoyb+TFhGI+JOBvKAoOAAOQq/Q0uYTl?=
 =?us-ascii?Q?gVOsiX/jsKZ6ES6id37ibFsXPM52wn/gZQnXlU6N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992339b7-b7de-446d-43c4-08db762969b1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:40:44.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkJNt5g4gHoXfRX++PcfKBSPNJbgt5qfZ/CEjHBPBQKZHiPSgEdzfc5SLiUJ5IfxYnpxR9M+M8Sa35CmL47A7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8695

On Mon, Jun 26, 2023 at 10:23:09AM +0800, Geliang Tang wrote:
> Add two helpers bpf_mptcp_storage_get() and bpf_mptcp_storage_delete()
> for mptcp_storage map type to get or delete a bpf_local_storage from
> the given msk.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/linux/bpf.h            |  2 +
>  include/linux/btf_ids.h        |  1 +
>  include/uapi/linux/bpf.h       | 39 ++++++++++++++++
>  kernel/bpf/helpers.c           |  4 ++
>  kernel/bpf/verifier.c          | 13 +++++-
>  net/mptcp/bpf.c                | 84 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 39 ++++++++++++++++
>  7 files changed, 181 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f58895830ada..ac4b5748451a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2909,6 +2909,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>  extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>  extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
> +extern const struct bpf_func_proto bpf_mptcp_storage_get_proto;
> +extern const struct bpf_func_proto bpf_mptcp_storage_delete_proto;
>  
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 00950cc03bff..abd56cfcb03f 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
>  extern u32 btf_tracing_ids[];
>  extern u32 bpf_cgroup_btf_id[];
>  extern u32 bpf_local_storage_map_btf_id[];
> +extern u32 bpf_mptcp_btf_id[];
>  
>  #endif
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index f43cf69e47ea..137e0620fd69 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5570,6 +5570,43 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void *bpf_mptcp_storage_get(struct bpf_map *map, struct mptcp_sock *msk, void *value, u64 flags)
> + *	Description
> + *		Get a bpf_local_storage from the *msk*.
> + *
> + *		Logically, it could be thought of as getting the value from
> + *		a *map* with *msk* as the **key**.  From this
> + *		perspective,  the usage is not much different from
> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *msk*) except this
> + *		helper enforces the key must be a mptcp_sock and the map must also
> + *		be a **BPF_MAP_TYPE_MPTCP_STORAGE**.
> + *
> + *		Underneath, the value is stored locally at *msk* instead of
> + *		the *map*.  The *map* is used as the bpf-local-storage
> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
> + *		searched against all bpf_local_storage residing at *msk*.
> + *
> + *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
> + *		used such that a new bpf_local_storage will be
> + *		created if one does not exist.  *value* can be used
> + *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
> + *		the initial value of a bpf_local_storage.  If *value* is
> + *		**NULL**, the new bpf_local_storage will be zero initialized.
> + *	Return
> + *		A bpf_local_storage pointer is returned on success.
> + *
> + *		**NULL** if not found or there was an error in adding
> + *		a new bpf_local_storage.
> + *
> + * long bpf_mptcp_storage_delete(struct bpf_map *map, struct mptcp_sock *msk)
> + *	Description
> + *		Delete a bpf_local_storage from the *msk*.
> + *
> + *	Return
> + *		0 on success.
> + *
> + *		**-ENOENT** if the bpf_local_storage cannot be found.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -5784,6 +5821,8 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(mptcp_storage_get, 212, ##ctx)		\
> +	FN(mptcp_storage_delete, 213, ##ctx)		\
>  	/* */
>  
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 4ef4c4f8a355..381b680007fb 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1768,6 +1768,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  	case BPF_FUNC_get_current_ancestor_cgroup_id:
>  		return &bpf_get_current_ancestor_cgroup_id_proto;
>  #endif
> +	case BPF_FUNC_mptcp_storage_get:
> +		return &bpf_mptcp_storage_get_proto;
> +	case BPF_FUNC_mptcp_storage_delete:
> +		return &bpf_mptcp_storage_delete_proto;
>  	default:
>  		break;
>  	}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d8482a4ef465..c7479628acf7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -553,7 +553,8 @@ static bool is_storage_get_function(enum bpf_func_id func_id)
>  	return func_id == BPF_FUNC_sk_storage_get ||
>  	       func_id == BPF_FUNC_inode_storage_get ||
>  	       func_id == BPF_FUNC_task_storage_get ||
> -	       func_id == BPF_FUNC_cgrp_storage_get;
> +	       func_id == BPF_FUNC_cgrp_storage_get ||
> +	       func_id == BPF_FUNC_mptcp_storage_get;
>  }
>  
>  static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
> @@ -8241,6 +8242,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>  		    func_id != BPF_FUNC_map_push_elem)
>  			goto error;
>  		break;
> +	case BPF_MAP_TYPE_MPTCP_STORAGE:
> +		if (func_id != BPF_FUNC_mptcp_storage_get &&
> +		    func_id != BPF_FUNC_mptcp_storage_delete)
> +			goto error;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -8353,6 +8359,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>  		if (map->map_type != BPF_MAP_TYPE_CGRP_STORAGE)
>  			goto error;
>  		break;
> +	case BPF_FUNC_mptcp_storage_get:
> +	case BPF_FUNC_mptcp_storage_delete:
> +		if (map->map_type != BPF_MAP_TYPE_MPTCP_STORAGE)
> +			goto error;
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 764c670e843b..0bf3409cf288 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -201,6 +201,17 @@ static void bpf_mptcp_storage_unlock(void)
>  	migrate_enable();
>  }
>  
> +static bool bpf_mptcp_storage_trylock(void)
> +{
> +	migrate_disable();
> +	if (unlikely(this_cpu_inc_return(bpf_mptcp_storage_busy) != 1)) {
> +		this_cpu_dec(bpf_mptcp_storage_busy);
> +		migrate_enable();
> +		return false;
> +	}
> +	return true;
> +}
> +
>  static struct bpf_local_storage __rcu **mptcp_storage_ptr(void *owner)
>  {
>  	struct mptcp_sock *msk = owner;
> @@ -305,6 +316,59 @@ static long bpf_mptcp_storage_delete_elem(struct bpf_map *map, void *key)
>  	return ret;
>  }
>  
> +/* Called by bpf_mptcp_storage_get*() helpers */
> +static void *__bpf_mptcp_storage_get(struct bpf_map *map,
> +				     struct mptcp_sock *msk, void *value,
> +				     u64 flags, gfp_t gfp_flags, bool nobusy)
> +{
> +        struct bpf_local_storage_data *sdata;
> +
> +        sdata = mptcp_storage_lookup(msk, map, nobusy);
> +        if (sdata)
> +                return sdata->data;
> +
> +        if ((flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
> +                sdata = bpf_local_storage_update(
> +                        msk, (struct bpf_local_storage_map *)map, value,
> +                        BPF_NOEXIST, gfp_flags);
> +                return IS_ERR(sdata) ? NULL : sdata->data;
> +        }
> +
> +        return NULL;
> +}
> +
> +/* *gfp_flags* is a hidden argument provided by the verifier */
> +BPF_CALL_5(bpf_mptcp_storage_get, struct bpf_map *, map, struct mptcp_sock *, msk,
> +	   void *, value, u64, flags, gfp_t, gfp_flags)
> +{
> +	void *data;
> +
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !msk)
> +		return (unsigned long)NULL;
> +
> +	bpf_mptcp_storage_lock();
> +	data = __bpf_mptcp_storage_get(map, msk, value, flags, gfp_flags, true);
> +	bpf_mptcp_storage_unlock();
> +	return (unsigned long)data;
> +}
> +
> +BPF_CALL_2(bpf_mptcp_storage_delete, struct bpf_map *, map, struct mptcp_sock *, msk)
> +{
> +	int ret;
> +
> +	WARN_ON_ONCE(!bpf_rcu_lock_held());
> +	if (!msk)
> +		return -EINVAL;
> +
> +	if (!bpf_mptcp_storage_trylock())
> +		return -EBUSY;
> +
> +	ret = mptcp_storage_delete(msk, map);
> +	bpf_mptcp_storage_unlock();
> +	return ret;
> +}
> +
>  static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  {
>  	return -ENOTSUPP;
> @@ -334,6 +398,26 @@ const struct bpf_map_ops mptcp_storage_map_ops = {
>  	.map_btf_id = &bpf_local_storage_map_btf_id[0],
>  	.map_owner_storage_ptr = mptcp_storage_ptr,
>  };
> +
> +const struct bpf_func_proto bpf_mptcp_storage_get_proto = {
> +	.func = bpf_mptcp_storage_get,
> +	.gpl_only = false,
> +	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
> +	.arg1_type = ARG_CONST_MAP_PTR,
> +	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
> +	.arg2_btf_id = &bpf_mptcp_btf_id[0],

No need to add this bpf_mptcp_btf_id, we can use
&btf_sock_ids[BTF_SOCK_TYPE_MPTCP] instead.

> +	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
> +	.arg4_type = ARG_ANYTHING,
> +};
> +
> +const struct bpf_func_proto bpf_mptcp_storage_delete_proto = {
> +	.func           = bpf_mptcp_storage_delete,
> +	.gpl_only       = false,
> +	.ret_type       = RET_INTEGER,
> +	.arg1_type      = ARG_CONST_MAP_PTR,
> +	.arg2_type      = ARG_PTR_TO_BTF_ID_OR_NULL,
> +	.arg2_btf_id    = &bpf_mptcp_btf_id[0],

Add here too.

-Geliang

> +};
>  #endif /* CONFIG_BPF_JIT */
>  
>  struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index f43cf69e47ea..137e0620fd69 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5570,6 +5570,43 @@ union bpf_attr {
>   *		0 on success.
>   *
>   *		**-ENOENT** if the bpf_local_storage cannot be found.
> + *
> + * void *bpf_mptcp_storage_get(struct bpf_map *map, struct mptcp_sock *msk, void *value, u64 flags)
> + *	Description
> + *		Get a bpf_local_storage from the *msk*.
> + *
> + *		Logically, it could be thought of as getting the value from
> + *		a *map* with *msk* as the **key**.  From this
> + *		perspective,  the usage is not much different from
> + *		**bpf_map_lookup_elem**\ (*map*, **&**\ *msk*) except this
> + *		helper enforces the key must be a mptcp_sock and the map must also
> + *		be a **BPF_MAP_TYPE_MPTCP_STORAGE**.
> + *
> + *		Underneath, the value is stored locally at *msk* instead of
> + *		the *map*.  The *map* is used as the bpf-local-storage
> + *		"type". The bpf-local-storage "type" (i.e. the *map*) is
> + *		searched against all bpf_local_storage residing at *msk*.
> + *
> + *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
> + *		used such that a new bpf_local_storage will be
> + *		created if one does not exist.  *value* can be used
> + *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
> + *		the initial value of a bpf_local_storage.  If *value* is
> + *		**NULL**, the new bpf_local_storage will be zero initialized.
> + *	Return
> + *		A bpf_local_storage pointer is returned on success.
> + *
> + *		**NULL** if not found or there was an error in adding
> + *		a new bpf_local_storage.
> + *
> + * long bpf_mptcp_storage_delete(struct bpf_map *map, struct mptcp_sock *msk)
> + *	Description
> + *		Delete a bpf_local_storage from the *msk*.
> + *
> + *	Return
> + *		0 on success.
> + *
> + *		**-ENOENT** if the bpf_local_storage cannot be found.
>   */
>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>  	FN(unspec, 0, ##ctx)				\
> @@ -5784,6 +5821,8 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(mptcp_storage_get, 212, ##ctx)		\
> +	FN(mptcp_storage_delete, 213, ##ctx)		\
>  	/* */
>  
>  /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
> -- 
> 2.35.3
> 
