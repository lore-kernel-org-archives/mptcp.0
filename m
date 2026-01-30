Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FD2DEA9E
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761686; cv=none; b=k5EhrKs/yqVKAnNzGFzzyWrsXdrspoHIxXSK/UAqkU5oBaG9gNV0CavlOUrAaXwxH8F8QHbgcm01JLvRse8KL7unWQraZ6KmK7EzUeRU08N16Ne+kXUnXUdeURr4U9Vc+f6tzSCAz9HK7ZBOk6wFOJMsPU9+5UCrfZqaZ5+fFMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761686; c=relaxed/simple;
	bh=zLFG1Ys60ShaPwRiKhFqkDshXlLo0bS0bp3F5NOi+p4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fglUiwIYay0/HbHE+Z0YN/HGwUVGckSuf8aPI9NF8tASEYdX6R6en4V8xFjQIa7M/x5vMPy0ny7/c2LODipH7U0qpnNen7RtR55xhhpIjJwqhvdSnMf6eoDB1TmZPJOtQk7cBTHfHqk0MwM1VJ4Fc7Ym1qoujoUC0Tz3kWwXNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNvpSoAI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNvpSoAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55901C4CEF7;
	Fri, 30 Jan 2026 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769761685;
	bh=zLFG1Ys60ShaPwRiKhFqkDshXlLo0bS0bp3F5NOi+p4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=iNvpSoAIw7CafmVV1yobuL7j6yyJ6kcgl7SXEoNZxVLaLcwMcWcvdyb+FKjHrX5+H
	 MbSqpk5kbvzgH3ed9pT0ecgooXMQuYB4M3V2BaYLR5+0lZvl0VXwOpR1+eKeA96xkj
	 i6ke5PCgNhHjBupTmdgTjMvka3kx20t8UQJQA5Agnfrnhb8nUMJtsoSe3VAELAcYrM
	 ZaHkT2I22gtdsUhaZj5/voFKQl3k73Qv6vOUGN9EJCAZH61/lhgEFsXqJ3NPOY4IcJ
	 tBGlQS+draqtwAp7CdCOo5VZYJruq1uBcpritgjLgUznk8e6VyTQcE3qR9K0mf/KWQ
	 EYjLPjTA5JZdw==
Message-ID: <186516ed4c548c2a35584153c5f995a205064725.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: fix kdoc warnings
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 30 Jan 2026 16:28:01 +0800
In-Reply-To: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
References: <20260130-mptcp-fix-kdoc-v1-1-a391da37f1ad@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this fix.

On Fri, 2026-01-30 at 08:52 +0100, Matthieu Baerts (NGI0) wrote:
> The following warnings were visible:
> 
>   $ ./scripts/kernel-doc -Wall -none \
>         net/mptcp/ include/net/mptcp.h include/uapi/linux/mptcp*.h \
>         include/trace/events/mptcp.h
>   Warning: net/mptcp/token.c:108 No description found for return
> value of 'mptcp_token_new_request'
>   Warning: net/mptcp/token.c:151 No description found for return
> value of 'mptcp_token_new_connect'
>   Warning: net/mptcp/token.c:246 No description found for return
> value of 'mptcp_token_get_sock'
>   Warning: net/mptcp/token.c:298 No description found for return
> value of 'mptcp_token_iter_next'
>   Warning: net/mptcp/protocol.c:4431 No description found for return
> value of 'mptcp_splice_read'
>   Warning: include/uapi/linux/mptcp_pm.h:13 missing initial short
> description on line:
>    * enum mptcp_event_type
> 
> Address all of them: either by using the 'Return:' keyword, or by
> adding
> a missing initial short description.
> 
> The MPTCP CI will soon report issues with kdoc to avoid introducing
> new
> issues and being flagged by the Netdev CI.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  include/uapi/linux/mptcp_pm.h |  2 +-
>  net/mptcp/token.c             | 16 +++++++++-------
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp_pm.h
> b/include/uapi/linux/mptcp_pm.h
> index c97d060ee90b..fe9863d75350 100644
> --- a/include/uapi/linux/mptcp_pm.h
> +++ b/include/uapi/linux/mptcp_pm.h
> @@ -11,7 +11,7 @@
>  #define MPTCP_PM_VER	1
>  
>  /**
> - * enum mptcp_event_type
> + * enum mptcp_event_type - Netlink MPTCP event types
>   * @MPTCP_EVENT_UNSPEC: unused event
>   * @MPTCP_EVENT_CREATED: A new MPTCP connection has been created. It
> is the
>   *   good time to allocate memory and send ADD_ADDR if needed.
> Depending on the
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 5bb924534387..f1a50f367add 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -103,7 +103,7 @@ static void mptcp_crypto_key_gen_sha(u64 *key,
> u32 *token, u64 *idsn)
>   * It creates a unique token to identify the new mptcp connection,
>   * a secret local key and the initial data sequence number (idsn).
>   *
> - * Returns 0 on success.
> + * Return: 0 on success.
>   */
>  int mptcp_token_new_request(struct request_sock *req)
>  {
> @@ -146,7 +146,7 @@ int mptcp_token_new_request(struct request_sock
> *req)
>   * the computed token at a later time, this is needed to process
>   * join requests.
>   *
> - * returns 0 on success.
> + * Return: 0 on success.
>   */
>  int mptcp_token_new_connect(struct sock *ssk)
>  {
> @@ -241,7 +241,7 @@ bool mptcp_token_exists(u32 token)
>   * This function returns the mptcp connection structure with the
> given token.
>   * A reference count on the mptcp socket returned is taken.
>   *
> - * returns NULL if no connection with the given token value exists.
> + * Return: NULL if no connection with the given token value exists.
>   */
>  struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token)
>  {
> @@ -288,11 +288,13 @@ EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
>   * @s_slot: start slot number
>   * @s_num: start number inside the given lock
>   *
> - * This function returns the first mptcp connection structure found
> inside the
> - * token container starting from the specified position, or NULL.
> + * Description:
> + *   On successful iteration, the iterator is moved to the next
> position and a
> + *   reference to the returned socket is acquired.
>   *
> - * On successful iteration, the iterator is moved to the next
> position and
> - * a reference to the returned socket is acquired.
> + * Return:
> + *   The first mptcp connection structure found inside the token
> container
> + *   starting from the specified position, or NULL.
>   */
>  struct mptcp_sock *mptcp_token_iter_next(const struct net *net, long
> *s_slot,
>  					 long *s_num)
> 
> ---
> base-commit: 9eafdb3251fecf25d365143d1a7da2dca70f181f
> change-id: 20260130-mptcp-fix-kdoc-eb08ff6f17ca
> 
> Best regards,
