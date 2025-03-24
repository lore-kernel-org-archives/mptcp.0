Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA842E337E
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814143; cv=none; b=W+5S9F1C8eiOSRAG0CAUXcicGPkBHVlCvmLObJNfY8xY9YedqbjtZCYpoRN7VtPdsPX9fonBSS8bzQWuPojZmxyBnhrSkTEKzMSy10SMP+4+ONkY6PT5vifUxZjpUdbi9cjnF7sotbYH433vPKUmpdfnvdZWmJT48+TGDD/NXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814143; c=relaxed/simple;
	bh=b1Q0mwGvyydHtpznw/4CMXdsMnqnLb3+DDBJYleg5qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpef2kL6S1a47X+fJ9IIJDVymPA46TiyXy13bQ5yFhNnzEmASSuYcfzyhdDtrQLXwYAMC3zi2uc1LHAOFWiqlqgKDcaLSIkCs+Hvl6u+aVod6ieg9fb/08s4NC+7dQqET5862J2FmpqP4hg786yDA72N6e0twPmaReW0Ob+XZxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Bujq1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Bujq1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C52C4CEDD;
	Mon, 24 Mar 2025 11:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742814143;
	bh=b1Q0mwGvyydHtpznw/4CMXdsMnqnLb3+DDBJYleg5qQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L+Bujq1C0L2Z8iHjHIIPRvmR8ty2Djs9imx1wVrmbDlj/JTB9/rt7ehc39uzWgnOg
	 /hJgKJix02vj5tQz/326HFJnV+jN35gfbvwhdjwI1nFqvfOgwNBixLJA5ZpEJHeGfn
	 QvrDqDE86kWzios63v5CNIwVMIDs0G9LH6tf9tQBztVzHpk/VLs9/obrIqzfgVc3yD
	 SsjRAikZXvoUygFMgZn8faSoSlZI8SA8dmXbrF4zjVA0qy1q/23jRjVBVQiZnkJy4w
	 PmB2XuLKytKzmB+kmyJ+f5YkAaeUTxaEiVwhdn7PCUEHm1okju1ck4+9nVHIpUUj4U
	 9Xt+KFZLDyvkQ==
Message-ID: <39fcea60-1eb2-4cf3-ba2d-0330bae6f92c@kernel.org>
Date: Mon, 24 Mar 2025 12:02:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 5/9] mptcp: pm: add add_addr_received()
 interface
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742804266.git.tanggeliang@kylinos.cn>
 <0b18abccee51f68bb1e0016426159df0b2ca1e36.1742804266.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0b18abccee51f68bb1e0016426159df0b2ca1e36.1742804266.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/03/2025 09:19, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds an optional .add_addr_received interface for struct
> mptcp_pm_ops and invokes it in mptcp_pm_worker().
> 
> This interface is only implemented in the in-kernel PM as a wrapper
> of mptcp_pm_nl_add_addr_received().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h   |  1 +
>  net/mptcp/pm.c        | 18 +++++++++++-------
>  net/mptcp/pm_kernel.c | 24 +++++++++++-------------
>  net/mptcp/protocol.h  |  1 -
>  4 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 4ac936e4ce0d..5118d11d2ee9 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -127,6 +127,7 @@ struct mptcp_pm_ops {
>  	/* optional */
>  	void (*established)(struct mptcp_sock *msk);
>  	void (*subflow_established)(struct mptcp_sock *msk);
> +	void (*add_addr_received)(struct mptcp_sock *msk);
>  
>  	char			name[MPTCP_PM_NAME_MAX];
>  	struct module		*owner;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8efb47331f79..71589cd5dee7 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -607,10 +607,11 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
>  		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {

How do you plan to remove the 'if (mptcp_pm_is_userspace(msk))' here above.

I guess this code is there to force the other peer to retransmit the
ADD_ADDR, hoping a userspace will be launched in between. Either we
remove this exception for the userspace PM (other events will not be
retransmitted: RM_ADDR, subflow closed, etc.), or we have another hook
but it feels wrong.

EDIT: I just saw your patch 7/9. Maybe we should avoid adding this
add_addr_echo hook, no? It is not clear what should be done here. I need
to think about that too.

An alternative is to send the ADD_ADDR echo from the worker, if
pm->ops->add_addr_received() returned true. If
pm->ops->add_addr_received is not implemented, then the ADD_ADDR echo is
scheduled from here. WDYT?

>  		mptcp_pm_announce_addr(msk, addr, true);
>  		mptcp_pm_add_addr_send_ack(msk);
> -	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
> -		pm->remote = *addr;
> -	} else {
> -		ret = -EINVAL;
> +	} else if (pm->ops->add_addr_received) {
> +		if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED))
> +			pm->remote = *addr;
> +		else
> +			ret = -EINVAL;
>  	}
>  
>  	if (ret)
> @@ -948,6 +949,12 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  		return;
>  
>  	pr_debug("msk=%p status=%x\n", msk, pm->status);
> +	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
> +		spin_lock_bh(&pm->lock);
> +		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
> +		spin_unlock_bh(&pm->lock);
> +		pm->ops->add_addr_received(msk);
> +	}
>  	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_SEND_ACK)) {
>  		spin_lock_bh(&pm->lock);
>  		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_SEND_ACK);
> @@ -972,9 +979,6 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
>  		spin_unlock_bh(&pm->lock);
>  		pm->ops->subflow_established(msk);
>  	}
> -	spin_lock_bh(&pm->lock);
> -	__mptcp_pm_kernel_worker(msk);
> -	spin_unlock_bh(&pm->lock);
>  }
>  
>  static void mptcp_pm_ops_init(struct mptcp_sock *msk,
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 2e181224bccb..4f4791620072 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -461,12 +461,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  		 msk->pm.add_addr_accepted, add_addr_accept_max,
>  		 msk->pm.remote.family);
>  
> +	spin_lock_bh(&msk->pm.lock);
>  	remote = msk->pm.remote;
>  	mptcp_pm_announce_addr(msk, &remote, true);
>  	mptcp_pm_addr_send_ack(msk);
>  
>  	if (lookup_subflow_by_daddr(&msk->conn_list, &remote))
> -		return;
> +		goto out;
>  
>  	/* pick id 0 port, if none is provided the remote address */
>  	if (!remote.port)
> @@ -477,7 +478,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  	 */
>  	nr = fill_local_addresses_vec(msk, &remote, locals);
>  	if (nr == 0)
> -		return;
> +		goto out;
>  
>  	spin_unlock_bh(&msk->pm.lock);
>  	for (i = 0; i < nr; i++)
> @@ -493,6 +494,8 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
>  		    msk->pm.subflows >= subflows_max)
>  			WRITE_ONCE(msk->pm.accept_addr, false);
>  	}
> +out:
> +	spin_unlock_bh(&msk->pm.lock);
>  }
>  
>  void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
> @@ -1342,17 +1345,6 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
>  	return true;
>  }
>  
> -/* Called under PM lock */
> -void __mptcp_pm_kernel_worker(struct mptcp_sock *msk)
> -{
> -	struct mptcp_pm_data *pm = &msk->pm;
> -
> -	if (pm->status & BIT(MPTCP_PM_ADD_ADDR_RECEIVED)) {
> -		pm->status &= ~BIT(MPTCP_PM_ADD_ADDR_RECEIVED);
> -		mptcp_pm_nl_add_addr_received(msk);
> -	}
> -}
> -
>  static int __net_init pm_nl_init_net(struct net *net)
>  {
>  	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
> @@ -1394,6 +1386,11 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
>  	.size = sizeof(struct pm_nl_pernet),
>  };
>  
> +static void mptcp_pm_kernel_add_addr_received(struct mptcp_sock *msk)
> +{
> +	mptcp_pm_nl_add_addr_received(msk);

No need to add a new static function only calling another static
function with the same arguments.

Simply rename mptcp_pm_nl_add_addr_received() to
mptcp_pm_kernel_add_addr_received().

> +}
> +
>  static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
>  {
>  	bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> @@ -1419,6 +1416,7 @@ struct mptcp_pm_ops mptcp_pm_kernel = {
>  	.get_priority		= mptcp_pm_kernel_get_priority,
>  	.established		= mptcp_pm_kernel_established,
>  	.subflow_established	= mptcp_pm_kernel_subflow_established,
> +	.add_addr_received	= mptcp_pm_kernel_add_addr_received,
>  	.init			= mptcp_pm_kernel_init,
>  	.name			= "kernel",
>  	.owner			= THIS_MODULE,
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 64aa091cb685..7fa26c49fbed 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1164,7 +1164,6 @@ void __init mptcp_pm_kernel_register(void);
>  void __init mptcp_pm_userspace_register(void);
>  void __init mptcp_pm_nl_init(void);
>  void mptcp_pm_worker(struct mptcp_sock *msk);
> -void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
>  unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

