Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBF816
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712364500; cv=none; b=M6VHLHdbMlEX3Ray6QK54E7ggejLS1FfFz7qPA+0wmRI41yyqWzhtIjr4uD+D/EBOjrp5tCWJ94YN4E18sCEYG6fcdXTrBFTgRnmdic7xfwXCrkHzQAdu47gzxRllEDlg2s612zbGnxojrnzcUJk6/2q0V/oNaHkOfrMVLlDjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712364500; c=relaxed/simple;
	bh=VGJznFArkHFBQo2IBcKmgw5vOGQqzT8WTC9Jx1COSxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bwyKebZnpd2AuZvKdUsQcHgbp1gU0qsmt4hHr8V0CeTLU/Z/19LqX+wyTvehBEyRyZ0dHEZZ41vn5Xg22uJsAO7jTPB6uFOvgmHJ7CF50g9w/AdKeBQaZxyUWwTesg+ccWcQuvjsdxcR5wqXkPvpVvGTwpOHxDPGtmTgT1fz+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JF8goXJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JF8goXJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC1C433C7;
	Sat,  6 Apr 2024 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712364499;
	bh=VGJznFArkHFBQo2IBcKmgw5vOGQqzT8WTC9Jx1COSxc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=JF8goXJE583jM75FHkQRVhM3liflo8/wrgEZ8WVXyl4KpXhrrjf2GiJiUL8UrDnJ4
	 PjZ2g51obHDKHOohPBHBuqB4EsBE7/X6wnGeOyHvplSvS2JJLXhVJ0+AIx5juCf6zW
	 U9C0EyHBamVDW9HykY4uCjjbd04YVAX//lHPzt6XmfTlmo5gG2ZoVCxx+YhRvNMode
	 3t2P5NWAsoUhKYanak3At0updCFDIbfsjKzAEkWtyGRJ92LtYDzxvtmToDvTfDt+VI
	 eXfGFJ9SodC7ghH5ES5ejcV25gYeBu9YuadXxk8Kh+CzRu3yEeEln/NrJKLKCvto8W
	 lA1LAmqgeNDYw==
Date: Fri, 5 Apr 2024 17:48:18 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add last time fields in
 mptcp_info"
In-Reply-To: <0979b4df687213cfaccaca526ad74958db8f67cf.1712363381.git.tanggeliang@kylinos.cn>
Message-ID: <5900b56b-6654-b7e0-2fd4-88abeaeb52c1@kernel.org>
References: <0979b4df687213cfaccaca526ad74958db8f67cf.1712363381.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 6 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Reload now = jiffies32 as Eric suggested.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/sockopt.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 2ec2fdf9f4af..17223da5436d 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -944,6 +944,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
> 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
> 	info->mptcpi_subflows_total = info->mptcpi_subflows +
> 		__mptcp_has_initial_subflow(msk);
> +	now = tcp_jiffies32; /* reload it, lock_sock_fast can sleep and be quite slow */
> 	info->mptcpi_last_data_sent = jiffies_to_msecs(now - msk->last_data_sent);
> 	info->mptcpi_last_data_recv = jiffies_to_msecs(now - msk->last_data_recv);
> 	unlock_sock_fast(sk, slow);

Geliang and Matthieu -

I'd like to minimize the time difference between the assigments for all 
the last time fields. For example, if the last_ack_recv is copied before 
the socket lock is acquired, the value in the info struct could become 
stale while waiting for the lock and not match up well with 
last_data_sent.

Could instead move the entire mptcp_data_lock()/mptcp_data_unlock() block 
inside the socket lock critical section. Then, if 'now' is assigned with 
both locks acquired there should not be significant delays between them.


- Mat

