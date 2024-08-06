Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495C3612D
	for <mptcp@lists.linux.dev>; Tue,  6 Aug 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983348; cv=none; b=KR7af8xlJn+0D9pNfKgE5v18x8AqmHnbBhVe5hnaPVNRmHgxHDOyIgAcSJsfdEOF2risQrePMqj6AwMtFI9Z/fXgmS6vzXFNJLXsmjXUo7Ovfn6WK/tuGvtQVCFPxM02jBLNG7A5Ak0CrfnDGZr8XhUpSXfQzkybC8cinWE/00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983348; c=relaxed/simple;
	bh=4Pkq++c+38d3FXG/t+BzJtBCa8gwpL6IIl8gAPYnV+0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jX7kKPVQOy4EmvyrGJxQH3yxurTFmmS8ZmKcJrJPWJq5zL6SpMUezRtqbqLExnbLHJw0aaN7IhPZ24+anobZyjhT1o1jNupE9gVTWW8n4rSygboPg9uWzoaqArKxsYxY2CIZ4hOoi1UTAhGoNa93bEhjYjDk4p6ZVNdYJxc1Jpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF5n2rD5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF5n2rD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FDCC32786;
	Tue,  6 Aug 2024 22:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722983348;
	bh=4Pkq++c+38d3FXG/t+BzJtBCa8gwpL6IIl8gAPYnV+0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QF5n2rD5LfTZO+oMMtRc6sBgvil3wzWE5VHVan7/goZA84TRTDKjB9p25lYaXe+dS
	 6p7/qo+BOFmv5a1tz6GMSe9RCoX5blih+8JO6MBZGTEMjQ7IlqkKANqYkViV5h+9no
	 l/UV0z97k/PDuaW8QC+U6wAgr8+x3zw1Qc5VGSRVhpUPgIS6xKKdf6CBfNFlk7K4B0
	 vPjXQfaqSnF+NS56G4+UA5pA//NU+Z7ivLKoPzoS8UZJL4VYXOrNS2kWWiqwTbn8tA
	 1YwJvk3Egn/CFVMevFQ/csAZFUe12alO9MMkd4H1iY3YM2ijxSUNiunZjgYW6/jQR4
	 NwS8UqXZfMcuA==
Date: Tue, 6 Aug 2024 15:29:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v6 05/11] mptcp: pm: send ACK on an active
 subflow
In-Reply-To: <20240802-mptcp-pm-avail-v6-5-964ba9ce279f@kernel.org>
Message-ID: <e3368a02-2083-b0b2-54c4-3a9662c0d80f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org> <20240802-mptcp-pm-avail-v6-5-964ba9ce279f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:

> Taking the first one on the list doesn't work in some cases, e.g. if the
> initial subflow is being removed. Pick another one instead of not
> sending anything.
>
> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>  - We could also check if the subflow is not "staled", but probably
>    best to do that for net-next only.
> ---
> net/mptcp/pm_netlink.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 4000de54c99c..e25cda3909fa 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -768,9 +768,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 	    !mptcp_pm_should_rm_signal(msk))
> 		return;
>
> -	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
> -	if (subflow)
> -		mptcp_pm_send_ack(msk, subflow, false, false);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (__mptcp_subflow_active(subflow)) {
> +			mptcp_pm_send_ack(msk, subflow, false, false);
> +			break;
> +		}
> +	}

Hi Matthieu -

If all subflows are stale, it should still try to send on one (falling 
back to the original first entry seems as good as anything else?)

- Mat

> }
>
> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>
> -- 
> 2.45.2
>
>
