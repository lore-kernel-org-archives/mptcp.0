Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DB433A9
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 02:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085220; cv=none; b=oUZagE15GHBuz0WzxmBn2VdYrHS9XmDvofxLTDGvRJT+X5SaJO0EW3JGSO8iAZ2N5xQCXoGQJP9Xm5WfjdgdrYsyF8vFLAW3FosCYVIVRep1MY3a7JhrDMeM8yBpCBFWfbTbCB0CyVDY8gHq4GfN8wj6gD1GXy7fU+5xWQZF3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085220; c=relaxed/simple;
	bh=VKMKcTZsLfYcXhOmPIMjjHQoqcPfvw7S9RWaaIV3Xdc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtGq9oxXffef05o17Y5FP89dUWR75BLXtSkQI1EZbgoCMh7O0nYNJ+xTobbuoJBJBbCB+6cV01vVzjDxx/meVLRIXE//BpLdJoj7WQ2zXtapTiO1CGyEDbr/qkAdtzCD/p7c4uJGws+YsvOBXeI91vqTAKxb5sGLOH/DiaqNLGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9RVQx1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9RVQx1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E624C32781;
	Thu,  8 Aug 2024 02:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723085220;
	bh=VKMKcTZsLfYcXhOmPIMjjHQoqcPfvw7S9RWaaIV3Xdc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=M9RVQx1eHxFYmLqaHM3J/y3PzmXl4NUOFLpDMXUCSDzBHl4AvSNyuoyq3rViyc03i
	 oUUrQ2Hmzql1IQsLzV0VCK4/lBwWEa8SADyIp/yQfc3tLChqUi+0uUOHMMVv0Ug1si
	 oZEjmwrGTTKT13CbgHce+RogRu98AWWQZLCOcileb1awfwwHV7csg2qjkPwTbDzgUj
	 5UsObs5zbOI6pSe+7KqmIXubGKooVy8T2/ipXM8Nne7xTcELzFo2ZLvL4Zi5WQ+8pD
	 tUrh7GQhfg6vfTcRoeT4EkUTGaTl6eYlUvr1Ec8X6jalgOltOK4U58DhGNo62ldU3N
	 OPcaRlHba1Pdg==
Message-ID: <88fa2fcc26d43988d897b306df39df5c3b41afd6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 2/8] mptcp: MIB counters for sent MP_JOIN
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 08 Aug 2024 10:46:57 +0800
In-Reply-To: <20240806-mptcp-join-tx-mib-v3-2-c3b54d2099e9@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-2-c3b54d2099e9@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
> Recently, a few issues have been discovered around the creation of
> additional subflows. Without these counters, it was difficult to
> point
> out the reason why some subflows were not created as expected.
> 
> These counters should have been added earlier, because there is no
> other
> simple ways to extract such information from the kernel, and
> understand
> why subflows have not been created.
> 
> While at it, some pr_debug() have been added, just in case the errno
> needs to be printed.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/509
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Notes:
>   - v2:
>     - Add "ERR" suffix in variable names. (Geliang)
>   - v3:
>     - removed Fully Established Error counter: should only happen
> with
>       the userspace PM, which will propagate the error in this case
>       (ENOTCONN). (Geliang)
> ---
>  net/mptcp/mib.c     |  4 ++++
>  net/mptcp/mib.h     |  4 ++++
>  net/mptcp/subflow.c | 21 ++++++++++++++++++---
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 7884217f33eb..ec0d461cb921 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -25,6 +25,10 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure",
> MPTCP_MIB_JOINSYNACKMAC),
>  	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
>  	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
> +	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
> +	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr",
> MPTCP_MIB_JOINSYNTXCREATSKERR),
> +	SNMP_MIB_ITEM("MPJoinSynTxBindErr",
> MPTCP_MIB_JOINSYNTXBINDERR),
> +	SNMP_MIB_ITEM("MPJoinSynTxConnectErr",
> MPTCP_MIB_JOINSYNTXCONNECTERR),
>  	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
>  	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
>  	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 66aa67f49d03..d68136f93dac 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -20,6 +20,10 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK
> + MP_JOIN */
>  	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN
> */
>  	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK +
> MP_JOIN */
> +	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN
> */
> +	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a
> socket when sending a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the
> address when sending a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNTXCONNECTERR,	/* Not able to connect()
> when sending a SYN + MP_JOIN */
>  	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping
> that did not match the previous one */
>  	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping
> */
>  	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite
> mapping */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a7fb4d46e024..fdeb7df8b095 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1575,12 +1575,17 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_pm_local *local,
>  	u32 remote_token;
>  	int addrlen;
>  
> +	/* The userspace PM sent the request too early? */
>  	if (!mptcp_is_fully_established(sk))
>  		goto err_out;
>  
>  	err = mptcp_subflow_create_socket(sk, local->addr.family,
> &sf);
> -	if (err)
> +	if (err) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXCREATSKERR);
> +		pr_debug("msk=%p local=%d remote:%d create sock
> error: %d\n",

It's better to use "remote=%d" instead of "remote:%d" I guess. Same
below.

> +			 msk, local_id, remote_id, err);
>  		goto err_out;
> +	}
>  
>  	ssk = sf->sk;
>  	subflow = mptcp_subflow_ctx(ssk);
> @@ -1615,8 +1620,12 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_pm_local *local,
>  #endif
>  	ssk->sk_bound_dev_if = local->ifindex;
>  	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
> -	if (err)
> +	if (err) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXBINDERR);
> +		pr_debug("msk=%p local=%d remote:%d bind error:
> %d\n",
> +			 msk, local_id, remote_id, err);
>  		goto failed;
> +	}
>  
>  	mptcp_crypto_key_sha(subflow->remote_key, &remote_token,
> NULL);
>  	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d",
> msk,
> @@ -1631,8 +1640,14 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_pm_local *local,
>  	sock_hold(ssk);
>  	list_add_tail(&subflow->node, &msk->conn_list);
>  	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen,
> O_NONBLOCK);
> -	if (err && err != -EINPROGRESS)
> +	if (err && err != -EINPROGRESS) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXCONNECTERR);
> +		pr_debug("msk=%p local=%d remote:%d connect error:
> %d\n",
> +			 msk, local_id, remote_id, err);
>  		goto failed_unlink;
> +	}
> +
> +	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNTX);
>  
>  	/* discard the subflow socket */
>  	mptcp_sock_graft(ssk, sk->sk_socket);
> 

