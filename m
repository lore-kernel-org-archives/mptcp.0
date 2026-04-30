Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA27413237
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777555253; cv=none; b=HAKAGeSfWGMZtfQ7qXXcDzdxRW15nK64pIvr7Gencl48yeuErL652HTiv+yEImbMm9vsG+J4Y1RuCMNlt/9qW6Nau2Z9Aezj93w+XhS6/1Yv7SSeEJvXiz3mTYyE+qNg4YNV/x/JmcU7numN8+1JBKsIy23O4x+hPHtkN+5DEdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777555253; c=relaxed/simple;
	bh=JekrtzEYzVYLxVVTO1XY73/7OQqyfCAx32/vszCf8Y4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=qGujnao0gDkwwzghNG8YmMvei2le7wZpRRXf/YA0rx9qZvQ7as9B36RQ8B97pgW/XEBewAWrpgoN7syCXn41k+Tf0j9G78f4/+Yq2bqx7hcVgjbCLM54skqcLH32dhU8s/RpDh0X9Blsn/3R8qDG7MRKL3VQ8oULcRmkp/0zTBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSEzpHFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSEzpHFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29A3C2BCB3;
	Thu, 30 Apr 2026 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777555252;
	bh=JekrtzEYzVYLxVVTO1XY73/7OQqyfCAx32/vszCf8Y4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=qSEzpHFAywnhHOXj1sVpmW5C2UPymKwZBvTUX75WM22Pm6ySoxJ4EtfqDjVX7tHc/
	 fvUyurUNsDAzr45yx/j7J6W997WxpaACvfR3ZDN6NmNRBBt7Y7DFkmyjvDK+duOPJN
	 LBQRcdZYeByYpUbI4hVIxpcq+iIP9y8pYbgGc+noL7p/gdAXytXx18KimjCIlaVgut
	 /G5fNP25KvR5Rg8EGmyKwiI1UyS/zB7qgHl7RYGY8KvA3U7/fBhGUcdO8ZOJLpzmRM
	 oQJuiI3IAKVZolDe/fKddlHoVFlvGTwjuzkokC5DScC0S38kxacyNWTdBpSS2g1j5J
	 I8+GS/p0S0RDA==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: fix ADD_ADDR timer
 infinite retry on option space insufficient
From: Matthieu Baerts <matttbe@kernel.org>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: mptcp@lists.linux.dev, weiyongjun1@huawei.com, yuehaibing@huawei.com, 
 zhangchangzhong@huawei.com, xiasong.lee@gmail.com
In-Reply-To: <20260430112026.343691-2-lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
 <20260430112026.343691-2-lixiasong1@huawei.com>
Date: Thu, 30 Apr 2026 15:20:42 +0200
Message-Id: <177755524215.1566930.3209225574765644709.b4-review@b4>
X-Mailer: b4 0.16-dev-76c3c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JekrtzEYzVYLxVVTO1XY73/7OQqyfCAx32/vszCf8Y4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/hxtO3lDw89Li9feady9SMtJbttzlsHFi9UGWQ38Xq
 zRNdOc621HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjARgwSG36wRMgtYv62f1KXg
 9MhX4MCEOsGaT+Z7v3NWCAcfT6uy+MbwP+FW4hVfof0OMt81doUYJ1xTU3hhdV28fF1zqNLkh8t
 2MQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Thu, 30 Apr 2026 19:20:25 +0800, Li Xiasong <lixiasong1@huawei.com> wrote:
> When TCP option space is insufficient (e.g., when sending ADD_ADDR with an
> IPv6 address and port while tcp_timestamps is enabled), the original code
> jumped to out_unlock without clearing the addr_signal flag. This caused
> mptcp_pm_add_timer to keep rescheduling indefinitely, not sending ADD_ADDR,
> preventing subsequent addresses in the endpoint list from being announced.
> 
> Handle this case by clearing the ADD_ADDR signal and skipping the matching
> ADD_ADDR retransmission entry. The skip path cancels the matching timer
> (with id check) and advances PM state progression, preserving forward
> progress to subsequent PM work.
> 
> This avoids endless retries for an ADD_ADDR that cannot be emitted in the
> current pure-ACK option-space constrained path.

Thank you for this new version!

>
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 57a456690406..a94177d9f265 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -401,6 +401,13 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  	return entry;
>  }
>  
> +static void mptcp_pm_add_addr_skip(struct mptcp_sock *msk,
> +				   const struct mptcp_addr_info *addr)
> +{
> +	mptcp_pm_del_add_timer(msk, addr, true);

I *think* sashiko is right here, and I guess sk_stop_timer() should be
called instead of the _sync() version. Thinking about that, I wonder if
sk_stop_timer() shouldn't always be called when check_id == true, no? Do
you mind checking this please?

  https://sashiko.dev/#/patchset/15237?part=1

> @@ -881,24 +889,47 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
> [ ... skip 26 lines ... ]
> +			goto out_unlock;
> +
> +		if (*echo) {
> +			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
> +		} else {
> +			skip_add_addr = true;

Even if I don't think we would have space issues with the echo, should
this variable also be set also in case of ADD_ADDR echo?

(In this case, the variable could also simply be called 'skip', or
'drop', similar to the MIB counters here.)

> [ ... skip 13 lines ... ]
> +	/* On pure-ACK option-space exhaustion, stop retrying this ADD_ADDR:
> +	 * clear the signal bit, cancel the matching retransmission timer, and
> +	 * let the PM state machine progress.
> +	 */
> +	if (skip_add_addr)
> +		mptcp_pm_add_addr_skip(msk, addr);

If you have to modify something else, maybe the new helper is not
needed, and the code can be added here directly? I know I suggested the
introduction of this helper, but now that I see the code, I think it
would be easier to understand the new comment above without it, and to
backport this patch.

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
