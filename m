Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C28207DE7
	for <mptcp@lists.linux.dev>; Wed,  4 Dec 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334544; cv=none; b=Rp3qdKUrgnTuVUN4eZHveyUca0OwJP8/EKDBpq9Uvt9W1EAjRA4tCbCzmBNuN6ZnVjYdgA263R29jqU/lEa9zAJkdCpfdPbPmRT+CcKTxGN6ltifoKEj6HUkTZ5ktsKfCZg5E4LqRoWf4bszVmQHWLyr8vjqEwGMt9NbM4guEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334544; c=relaxed/simple;
	bh=ZRVThppBbqvGu7dVQsJMRzkt36FF29Vhe6sf5x+nhqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNoTkpEKgoVGTPBe6HGcGcrT3EV7e+weswt69KQwARdeGvSI4IIJTnUkDDVuRRU/1y7z+xDNWncjK9EK86vHzPt7aFM4kE5OvjhN8eXbR3rmOpuZfi05ViH7OhWKJqBzJ42qpRoAZuiTkkGY3n8YTqtHmRQkOiGCghlZwaQBhjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg1Vvfz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg1Vvfz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6A1C4CECD;
	Wed,  4 Dec 2024 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733334544;
	bh=ZRVThppBbqvGu7dVQsJMRzkt36FF29Vhe6sf5x+nhqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sg1Vvfz8hsoUL5H5kEtXnAPkn6IR37a9mQF+Yony7nrW3kN+coJRt3nVRwMZ4CEVZ
	 wQROET9xkUNlakZ1NU/6r5VhddLOVJlbYBLCp+f0xXyqUu1rVn6ROCLjlRAQqwvS40
	 iinBxJDoHWcNN+HXzZe/3PEGlJe0+XjhjyOT6T8Fe8CUb7DgsI+KWTpyq2xQC4gtOE
	 bsjqkZe5uNRIi9Y35qzz2HFBN8lxJZhgnoQeIOYiSwjqRwgz+CGsyDpcPa7fx5jBPb
	 iqQKwpLoEI6s/JfefCrMmhbztc6E/qIQPOsu5PNpB8wKI8gEU3esY01HbGwDU1CFuZ
	 8NG9zUgPndxgQ==
Message-ID: <0df84759-abb5-4030-bb2b-1e73ab2b8693@kernel.org>
Date: Wed, 4 Dec 2024 18:49:01 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 5/9] mptcp: drop free_list for deleting
 entries
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
 <68e7a3deaea7319b4fb36b9ee8a6073a8bbfa37d.1730961810.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <68e7a3deaea7319b4fb36b9ee8a6073a8bbfa37d.1730961810.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/11/2024 07:45, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> mptcp_pm_remove_addrs() actually only deletes one address, which does
> not match its name. This patch renames it to mptcp_pm_remove_addr_entry()
> and changes the parameter "rm_list" to "entry".
> 
> With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
> move the entry to be deleted to free_list and then traverse the list to
> delete the entry, which is not allowed in BPF. The entry can be directly
> deleted through list_del_rcu() and sock_kfree_s() now.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 33 ++++++++++++---------------------
>  net/mptcp/protocol.h     |  3 ++-
>  2 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 737a07f5defe..a98da9a44bfa 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -286,26 +286,21 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
>  	return err;
>  }
>  
> -void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
> +void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> +				struct mptcp_pm_addr_entry *entry)
>  {
>  	struct mptcp_rm_list alist = { .nr = 0 };
> -	struct mptcp_pm_addr_entry *entry;
>  	int anno_nr = 0;
>  
> -	list_for_each_entry(entry, rm_list, list) {
> -		if (alist.nr >= MPTCP_RM_IDS_MAX)
> -			break;
> -
> -		/* only delete if either announced or matching a subflow */
> -		if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
> -			anno_nr++;
> -		else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list,
> -							&entry->addr))
> -			continue;
> +	/* only delete if either announced or matching a subflow */
> +	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
> +		anno_nr++;
> +	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
> +		goto out;

Here, you can 'return', no need to use this new 'out' label.

>  
> -		alist.ids[alist.nr++] = entry->addr.id;
> -	}
> +	alist.ids[alist.nr++] = entry->addr.id;
>  
> +out:
>  	if (alist.nr) {

If the 'out' label is removed, you can also remove this if-statement.

>  		spin_lock_bh(&msk->pm.lock);
>  		msk->pm.add_addr_signaled -= anno_nr;

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

