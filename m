Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC51A8F8B
	for <mptcp@lists.linux.dev>; Thu,  5 Dec 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383639; cv=none; b=updClHTepZOcCmph0dai3oCbtf2EL6rUIwMFfX+PLYPQB0pE1IgvO5FiN8ERls72ecwtF2MnyT/YuBbExGPvF9OXrOHgAINRIUAg0wPzESE6vI6aBfpYFDpkUxL3rl59pSoP2skhjObPfpTgMODzRG51yF8NComtt6lsPNQ7HCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383639; c=relaxed/simple;
	bh=rsmTPdvsKRuRqQUmXgx7P7hNlwUpV350JLExPEL9dOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3lazjhX4xf/b4+5MFK8weP4ySUcudatEN++3tgpq3XuZHrB9+gHL85ECHovUHHo4mW20Bk9PPnbyJaF0CNwyIPIu6dNcahFFnAb8aW6MjkzguKjVdXhlPC5eltuJfUhbPE1E0qKfltn8N+VKjlb9utxTV5vKoHSSFhC6FjH9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qkf2G5V2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qkf2G5V2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DACC4CED6;
	Thu,  5 Dec 2024 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733383638;
	bh=rsmTPdvsKRuRqQUmXgx7P7hNlwUpV350JLExPEL9dOI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Qkf2G5V2EY6T8BoUEO2cYl2sJOjfBgqWq29d2TlCW34lgN48h06xQbCAQxVaOgGy/
	 m9tMinf4MGbTqAt6oi21DBB4kBLYtsXamFFkGex2qJUjplGbWoLB8epsaYcpOezYPJ
	 elS2WJCSvQBRlESElM50eOtT2l6Iyu4ZEe84Otp5jqMXxO/zoUn+YHUxvAToYG7KQC
	 ZLYn6Giwh58nxhJo5mKb8TNu/ODP+Ipl2x8D5MnqUajgd032G4OgJVmWhL7AoaRhrD
	 VyuxT4LdeTkOr+D5pirdaUif/W7pce9vYdFxyq64DArVR8O0aqwG4EZAWm35ZgQOxy
	 rD+yWLeSUusaQ==
Message-ID: <7d784ad9a27c346e0fc90c54ad05157e64b77c7d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 5/9] mptcp: drop free_list for deleting
 entries
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 05 Dec 2024 15:27:14 +0800
In-Reply-To: <0df84759-abb5-4030-bb2b-1e73ab2b8693@kernel.org>
References: <cover.1730961809.git.tanggeliang@kylinos.cn>
	 <68e7a3deaea7319b4fb36b9ee8a6073a8bbfa37d.1730961810.git.tanggeliang@kylinos.cn>
	 <0df84759-abb5-4030-bb2b-1e73ab2b8693@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-12-04 at 18:49 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/11/2024 07:45, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > mptcp_pm_remove_addrs() actually only deletes one address, which
> > does
> > not match its name. This patch renames it to
> > mptcp_pm_remove_addr_entry()
> > and changes the parameter "rm_list" to "entry".
> > 
> > With the help of mptcp_pm_remove_addr_entry(), it's no longer
> > necessary to
> > move the entry to be deleted to free_list and then traverse the
> > list to
> > delete the entry, which is not allowed in BPF. The entry can be
> > directly
> > deleted through list_del_rcu() and sock_kfree_s() now.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/pm_userspace.c | 33 ++++++++++++---------------------
> >  net/mptcp/protocol.h     |  3 ++-
> >  2 files changed, 14 insertions(+), 22 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > index 737a07f5defe..a98da9a44bfa 100644
> > --- a/net/mptcp/pm_userspace.c
> > +++ b/net/mptcp/pm_userspace.c
> > @@ -286,26 +286,21 @@ static int
> > mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
> >  	return err;
> >  }
> >  
> > -void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct
> > list_head *rm_list)
> > +void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
> > +				struct mptcp_pm_addr_entry *entry)
> >  {
> >  	struct mptcp_rm_list alist = { .nr = 0 };
> > -	struct mptcp_pm_addr_entry *entry;
> >  	int anno_nr = 0;
> >  
> > -	list_for_each_entry(entry, rm_list, list) {
> > -		if (alist.nr >= MPTCP_RM_IDS_MAX)
> > -			break;
> > -
> > -		/* only delete if either announced or matching a
> > subflow */
> > -		if (mptcp_remove_anno_list_by_saddr(msk, &entry-
> > >addr))
> > -			anno_nr++;
> > -		else if (!mptcp_lookup_subflow_by_saddr(&msk-
> > >conn_list,
> > -							&entry-
> > >addr))
> > -			continue;
> > +	/* only delete if either announced or matching a subflow
> > */
> > +	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
> > +		anno_nr++;
> > +	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list,
> > &entry->addr))
> > +		goto out;
> 
> Here, you can 'return', no need to use this new 'out' label.
> 
> >  
> > -		alist.ids[alist.nr++] = entry->addr.id;
> > -	}
> > +	alist.ids[alist.nr++] = entry->addr.id;
> >  
> > +out:
> >  	if (alist.nr) {
> 
> If the 'out' label is removed, you can also remove this if-statement.

Good idea! Thanks.

> 
> >  		spin_lock_bh(&msk->pm.lock);
> >  		msk->pm.add_addr_signaled -= anno_nr;
> 
> (...)
> 
> Cheers,
> Matt

