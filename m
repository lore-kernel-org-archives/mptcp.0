Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320310E5
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeMraWh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A925FC433C7;
	Sat,  6 Jan 2024 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704502101;
	bh=3GBzwRu7c5hbG4DvYxz5XaG1OS1QAKCgCI/MzmHEIzY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BeMraWh6o63G4TM64OV1lnHSesVWoiSpx1tZZC8mUxthmjl5rYpZha8SfQ+emxpie
	 kRQFVWrWylzbvAxIH0mA18IEDi0zt5iTbK/yYRCITTar1YmxHyKUn23pokWlN+RZTL
	 K/0HUnDbE2UYodsCcy2pwfc5yABtVs6xN0EcwBPu5qW+LIiD7NKjZbEp+n2ecLqyb9
	 WVrh1p6LZC1mkUO9T9kOROy8gvpkct09jWk3iZYVb08r2e8eQAmSA7j5BH3t1SRXl0
	 OBkQfClbJGtOu+FEF5bITHCp3fT79gB5eTtLbU7xwkM4QkANU9xJ2RgnmqX6KoERIh
	 ykmSrLT3X2egg==
Date: Fri, 5 Jan 2024 16:48:20 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 01/24] mptcp: set set_id flag when parsing
 addr
In-Reply-To: <8f402f2cbd7571e85fbc41b9559cbb2d05bf7c58.1703904325.git.geliang.tang@linux.dev>
Message-ID: <077c657a-e8c1-d04d-46d2-05dccef28091@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <8f402f2cbd7571e85fbc41b9559cbb2d05bf7c58.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Dec 2023, Geliang Tang wrote:

> When userspace PM requires to create an ID 0 subflow in "userspace pm
> create id 0 subflow" test like this:
>
>        userspace_pm_add_sf $ns2 10.0.3.2 0
>
> An ID 1 subflow, in fact, is created.
>
> Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
> no ID is set by userspace, and will allocate a new ID immediately:
>
>     if (!e->addr.id)
>             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
>                                             MPTCP_PM_MAX_ADDR_ID + 1,
>                                             1);
>
> To solve this issue, a new flag 'MPTCP_PM_ADDR_FLAG_SET_ID' is added
> to distinguish between whether userspace PM has set an ID 0 or whether
> userspace PM has not set any address.

Hi Geliang -

It's better to not modify the UAPI here, and it isn't necessary to get the 
userspace PM behavior we need.

mptcp_pm_nl_append_new_local_addr() is only has two callers:

mptcp_pm_nl_get_local_id(), which always needs a new ID allocated

and

mptcp_pm_nl_add_addr_doit(), which needs to allow ID 0.


Instead of changing the UAPI, modify this function to add a 3rd arg:

static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
 					     bool needs_id)

change the code you mentioned above to:

      if (needs_id)
              e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                              MPTCP_PM_MAX_ADDR_ID + 1,
                                              1);

and update the two callers. This replaces patches 1-3.



- Mat




>
> Add a new parameter 'set_id' for mptcp_pm_parse_pm_addr_attr(), and
> pass a 'set_id' flag to them. If an address id is set from userspace,
> this 'set_id' will be set as true. If 'set_id' is set, then the newly
> added flag MPTCP_PM_ADDR_FLAG_SET_ID will be set.
>
> Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> include/uapi/linux/mptcp.h |  1 +
> net/mptcp/pm_netlink.c     | 17 +++++++++++++----
> 2 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 74cfe496891e..ef3663792765 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -36,6 +36,7 @@
> #define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
> #define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
> #define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
> +#define MPTCP_PM_ADDR_FLAG_SET_ID                      (1 << 5)
>
> struct mptcp_info {
> 	__u8	mptcpi_subflows;
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 661c226dad18..dedc5a038b10 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1159,7 +1159,8 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
> 				       const struct nlattr *attr,
> 				       struct genl_info *info,
> 				       struct mptcp_addr_info *addr,
> -				       bool require_family)
> +				       bool require_family,
> +				       bool *set_id)
> {
> 	int err, addr_addr;
>
> @@ -1174,8 +1175,11 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
> 	if (err)
> 		return err;
>
> -	if (tb[MPTCP_PM_ADDR_ATTR_ID])
> +	if (tb[MPTCP_PM_ADDR_ATTR_ID]) {
> 		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
> +		if (set_id)
> +			*set_id = true;
> +	}
>
> 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
> 		if (!require_family)
> @@ -1223,7 +1227,7 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
>
> 	memset(addr, 0, sizeof(*addr));
>
> -	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
> +	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true, NULL);
> }
>
> int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> @@ -1231,11 +1235,13 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> 			 struct mptcp_pm_addr_entry *entry)
> {
> 	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
> +	bool set_id = false;
> 	int err;
>
> 	memset(entry, 0, sizeof(*entry));
>
> -	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
> +	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr,
> +					  require_family, &set_id);
> 	if (err)
> 		return err;
>
> @@ -1248,6 +1254,9 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
> 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
> 		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);
>
> +	if (set_id)
> +		entry->flags |= MPTCP_PM_ADDR_FLAG_SET_ID;
> +
> 	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
> 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
>
> -- 
> 2.39.2
>
>
>
