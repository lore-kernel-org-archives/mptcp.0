Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E27A702
	for <mptcp@lists.linux.dev>; Mon, 29 Jul 2024 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722222580; cv=none; b=MQ7ZhjgC6SpTtHx9HRL7F+AzIHMRkHyC4qqxSZnrKVtpy057o4jOP/XuTuMjE9a2rtwBBVmygiiNxLLISzpFwQ19FBQzcOsJtZjcHsxVSiwwdtUE3S+ayKSQVpkG4flBK2/LdZPM2Sm3Csu4U2yYIQyRSNB+rWLpUZ5YIpyn11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722222580; c=relaxed/simple;
	bh=6rECRIdAtSqNw2IJVFIkBhpgTpCAQi22WbyAhXiU3x0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWnjYGHwfShto5k0Yk3QHJlKB56QtcG4jWDfpTysM4Y+s1u4lTANbmhuFlq5B8+ZMPZ8gtIDh9hC+IFhSPQaGPqxx0KkMYDiQOX0z83u92nbY8Zla38ys1IgCxXZuf4jpR5GC/HacgxR/kbSdb8ea2wTCI4J6Frz1t/Rc7E9XCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1N1yj+3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1N1yj+3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FEC116B1;
	Mon, 29 Jul 2024 03:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722222579;
	bh=6rECRIdAtSqNw2IJVFIkBhpgTpCAQi22WbyAhXiU3x0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=e1N1yj+37o7JxhEaoIdk1Egftz8cBz/ORxu24zNh5cnIWdngLJG0gtP/mfvjG4Kv+
	 pbU7TEzG0gLeacMDLyeHVltaGYiUkes7I/THXFZtJ0CJvHh1aLgN0yE4JMiWecmKil
	 xy3e67H/aMXAqRLVFN9YKamlCV3wTBMgRMZm4/Tm1TCQn8M9d0huz/mZdydN5+gmrG
	 irJ5X0ZMP4JGQRnpHvcSO+yDqHiQH4Pcwnv4QxyNuWEMFbOTiPd+6P1LABVxZRoBCj
	 uieLEgHe/ECKRNUBwhQtKj1HjHk4KAox2zY2CyO8VbQoIm1W4GHLiD5x8urBcuPL2Y
	 fij5VSCkKLrHg==
Message-ID: <797a6a26e1f422dfd4722c6e53e623500fd93ab5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/2] mptcp: MIB counters for sent MP_JOIN
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 29 Jul 2024 11:09:35 +0800
In-Reply-To: <20240726-mptcp-join-tx-mib-v1-1-7f2149ba0dcf@kernel.org>
References: <20240726-mptcp-join-tx-mib-v1-0-7f2149ba0dcf@kernel.org>
	 <20240726-mptcp-join-tx-mib-v1-1-7f2149ba0dcf@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2024-07-26 at 19:48 +0200, Matthieu Baerts (NGI0) wrote:
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
>  net/mptcp/mib.c     |  5 +++++
>  net/mptcp/mib.h     |  5 +++++
>  net/mptcp/subflow.c | 24 ++++++++++++++++++++----
>  3 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 7884217f33eb..a0b1152c32f1 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -25,6 +25,11 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure",
> MPTCP_MIB_JOINSYNACKMAC),
>  	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
>  	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
> +	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
> +	SNMP_MIB_ITEM("MPJoinSynTxFEstabErr",
> MPTCP_MIB_JOINSYNTXFULLYESTAB),

It's better to keep the "Err" postfix to reduce ambiguity:

MPTCP_MIB_JOINSYNTXFULLYESTAB_ERR or MPTCP_MIB_JOINSYNTXFULLYESTABERR.

> +	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr",
> MPTCP_MIB_JOINSYNTXCREATESOCK),
> +	SNMP_MIB_ITEM("MPJoinSynTxBindErr",
> MPTCP_MIB_JOINSYNTXBIND),
> +	SNMP_MIB_ITEM("MPJoinSynTxConnectErr",
> MPTCP_MIB_JOINSYNTXCONNECT),

Same these three.

Thanks,
-Geliang

>  	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
>  	SNMP_MIB_ITEM("InfiniteMapTx", MPTCP_MIB_INFINITEMAPTX),
>  	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 66aa67f49d03..ccb3a30e835a 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -20,6 +20,11 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK
> + MP_JOIN */
>  	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN
> */
>  	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK +
> MP_JOIN */
> +	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN
> */
> +	MPTCP_MIB_JOINSYNTXFULLYESTAB,	/* Not in fully established
> when sending a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNTXCREATESOCK,	/* Not able to create a
> socket when sending a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNTXBIND,	/* Not able to bind() the
> address when sending a SYN + MP_JOIN */
> +	MPTCP_MIB_JOINSYNTXCONNECT,	/* Not able to connect()
> when sending a SYN + MP_JOIN */
>  	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping
> that did not match the previous one */
>  	MPTCP_MIB_INFINITEMAPTX,	/* Sent an infinite mapping
> */
>  	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite
> mapping */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index a21c712350c3..d305c0f53a09 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1577,12 +1577,18 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_addr_info *loc,
>  	int ifindex;
>  	u8 flags;
>  
> -	if (!mptcp_is_fully_established(sk))
> +	if (!mptcp_is_fully_established(sk)) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXFULLYESTAB);
>  		goto err_out;
> +	}
>  
>  	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
> -	if (err)
> +	if (err) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXCREATESOCK);
> +		pr_debug("msk=%p local=%d remote:%d create sock
> error: %d\n",
> +			 msk, local_id, remote_id, err);
>  		goto err_out;
> +	}
>  
>  	ssk = sf->sk;
>  	subflow = mptcp_subflow_ctx(ssk);
> @@ -1608,8 +1614,12 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_addr_info *loc,
>  #endif
>  	ssk->sk_bound_dev_if = ifindex;
>  	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
> -	if (err)
> +	if (err) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXBIND);
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
> @@ -1624,8 +1634,14 @@ int __mptcp_subflow_connect(struct sock *sk,
> const struct mptcp_addr_info *loc,
>  	sock_hold(ssk);
>  	list_add_tail(&subflow->node, &msk->conn_list);
>  	err = kernel_connect(sf, (struct sockaddr *)&addr, addrlen,
> O_NONBLOCK);
> -	if (err && err != -EINPROGRESS)
> +	if (err && err != -EINPROGRESS) {
> +		MPTCP_INC_STATS(sock_net(sk),
> MPTCP_MIB_JOINSYNTXCONNECT);
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

