Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152402905
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744158204; cv=none; b=RIYsZVlqViWb9Dzj7PcRjrqplZZfUC9Ujb5n8LKACcRqil7H/LHr1pU/HHNQB4iSfnhnjG2rZhb4Ts/yYbmIUuPVXlDrmvFw021Xet4fhK0xaK0IGjI2rt94c1TTNc8azTsHfyx0BScyxn2pbczUrNZSm92SytQiK+t0dViptZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744158204; c=relaxed/simple;
	bh=fRZHJMQE1mcA90NXfHUdln2HH0ALCWHVHTEwU7D1uck=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Po4/XTqOHRAbctJt1MW62FSGhRxIRqvSx71jkrvp6h1h3cOIn8FBY7yQLGdFkQjQMZ9GLu2hknYFW8QkQkRfUFvL564XpUmSA4NY/fTzZr0SP4e1TFAD+iImBBbmz8UFNOKiNU4Smwo5JWqnRaTge++sON3dEaA/sMhPJD+9890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5iFJsU/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5iFJsU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB69C4CEE5;
	Wed,  9 Apr 2025 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744158203;
	bh=fRZHJMQE1mcA90NXfHUdln2HH0ALCWHVHTEwU7D1uck=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=u5iFJsU/eZSNCuQDe6bhg/hhkFxWknPYrkM3uaatiX3umcrZWVhwxmSqDTuE0D98v
	 v3mhFKS+W5BZOmMM/J8kalTBoHtapLC4TlbhCI9TxWPfyN+IOWpaJ/CVtaqo1mZqvk
	 SuzcXCORcjvX16IHvvfiGEtVskWFKGVdq5f0R/+GM8R2BwLF0BeBM/v9mt/P03YSKL
	 EW3skpkVKVE/ajAY1J5140rHKWR3VpD5A9fn+O1B8F9hWF0d/8xcWwF9PzGOTgrLYn
	 D3qNH2/4MjML6nvygG8Dfv2p/8mtd3PAOmcFoRKxF9alvzHcuRoVrNwqrgeNELy3UJ
	 hSrYgiJZV/UzA==
Date: Tue, 8 Apr 2025 17:23:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 0/3] only remove entry from local_addr_list
 when sending a REMOVE_ADDR
In-Reply-To: <cover.1743562290.git.tanggeliang@kylinos.cn>
Message-ID: <a132ad93-029a-f083-d140-59929b4c4dc7@kernel.org>
References: <cover.1743562290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 2 Apr 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403

Geliang and Matthieu -

Since this is a bug fix, should it go to mptcp-net rather than -next? Or 
does the associated selftest change make that complicated?

I think there's a nearby bug in mptcp_pm_nl_remove_doit() that I noticed 
while reviewing this series. If we upstream this series to the net tree it 
might make sense to send the fixes together.

In this code:

 	list_del_rcu(&match->list);
 	msk->pm.local_addr_used--;
 	spin_unlock_bh(&msk->pm.lock);

 	mptcp_pm_remove_addr_entry(msk, match);

 	release_sock(sk);

 	sock_kfree_s(sk, match, sizeof(*match));

The struct is removed from a linked list with list_del_rcu(), but doesn't 
wait for a grace period before the sock_kfree_s() in the final line. The 
easy solution is to make the kfree rcu-aware and open-code the handling of 
sk_omem_alloc, like this:

 	atomic_sub(sizeof(*match), &sk->sk_omem_alloc);
 	kfree_rcu(match);

instead of calling sock_kfree_s(). tcp_md5_do_del() takes this approach. 
This does allow possible allocation beyond the optmem limit, but only for 
the duration of the rcu grace period.

I can send a patch tomorrow, unless someone wants to implement it before 
then.


- Mat


>
> Geliang Tang (3):
>  mptcp: pm: userspace: local_addr_used-- after sending REMOVE_ADDR
>  mptcp: pm: userspace: drop delete_local_addr helper
>  selftests: mptcp: send REMOVE_ADDR after subflow is deleted
>
> net/mptcp/pm_userspace.c                      | 37 +++----------------
> .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
> .../selftests/net/mptcp/userspace_pm.sh       |  6 +++
> 3 files changed, 14 insertions(+), 33 deletions(-)
>
> -- 
> 2.43.0
>
>
>
