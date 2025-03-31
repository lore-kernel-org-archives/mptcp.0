Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725F1E884
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743386380; cv=none; b=ov//d52DgXSsMLrMJ0M1JxUfU98swVOGWs4XA2oU7AjnFzfv4QnejZYxWXE1FxIq3P7IC7yGPu+/cwGdM3ZXWYxeQCt94nawSEbFIrxQ08xo3rauh7ueWuVwU7ByAh9SouWAWjEq1MAxptqTLBMI6wVxpSxwzZMaJH4opil2CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743386380; c=relaxed/simple;
	bh=qLdvlndM147i7ryRndzodEdXnkL0rAVuySsuNsIOy/s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtLpEct7tQ+UXzyoEi6BbAggte7RMrUS1ZBt7F9f0Y4DQozIKOLfIq1atXKhyW4oD0CsBGpdcY7+6c+ybbeUMz5Aw3uDePeXdCvUncxleXXVHCr76CNE056tzH6LcsCtphZxGNDGDG32sgBNRHQFmzUfqyaOK52YPhy6FM+NswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEMREptr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEMREptr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC2DC4CEDD;
	Mon, 31 Mar 2025 01:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743386379;
	bh=qLdvlndM147i7ryRndzodEdXnkL0rAVuySsuNsIOy/s=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=GEMREptrJdPSKWAsYudud3BxpEoEQoi0NirG9vsLMcL/81KMkZe/njcdF/J2wq+Zx
	 OCUO8Eqdc7ORvrr9Oi8AXEwbjn2aHU+ZjhJzjr2hUzMjHMDaTuXDPOszDy3moDCYdG
	 UOwO72idbdLMik9bZnVvix/jSZTJad66OSwmXCcE8upE0Kb/PeC+D3oIQNA4wU3pxh
	 F7p4N3LlyIsCiaCiOE0+qLj/TzHg8PGlyrCfYQJ4AX1fiIdH8A9UF731iATVwD/qBO
	 bN8UMUG9XZ4X38fSx0tQPDRrn6/fRB+zqAx0SMEHKfW8XMggaBYg0wLqfBLO9itNPm
	 ffDHOkQMs32eg==
Message-ID: <910fc74590b10617dfc0dffe950f895f2457c089.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 4/5] mptcp: add MPJoinRejected MIB counter
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 31 Mar 2025 09:59:35 +0800
In-Reply-To: <20250329-mptcp-mpj-reject-v1-4-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
	 <20250329-mptcp-mpj-reject-v1-4-2396d5666e8f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
> This counter is useful to understand why some paths are rejected, and
> not created as expected.
> 
> It is incremented when receiving a connection request, if the PM
> didn't
> allow the creation of new subflows.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/mib.c      | 1 +
>  net/mptcp/mib.h      | 1 +
>  net/mptcp/protocol.c | 4 +++-
>  net/mptcp/subflow.c  | 2 ++
>  4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index
> 19eb9292bd6093a760b41f98c1774fd2490c48e3..0c24545f0e8df95b3475bfccc7a
> 2f2ce440f7ad2 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -28,6 +28,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure",
> MPTCP_MIB_JOINSYNACKMAC),
>  	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
>  	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
> +	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
>  	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
>  	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr",
> MPTCP_MIB_JOINSYNTXCREATSKERR),
>  	SNMP_MIB_ITEM("MPJoinSynTxBindErr",
> MPTCP_MIB_JOINSYNTXBINDERR),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index
> 128282982843a07614a46f9b2c2f7c708306c769..250c6b77977e8f846b5741304f7
> 841a922f51967 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -23,6 +23,7 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK
> + MP_JOIN */
>  	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN
> */
>  	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK +
> MP_JOIN */
> +	MPTCP_MIB_JOINREJECTED,		/* The PM rejected
> the JOIN request */
>  	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN
> */
>  	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a
> socket when sending a SYN + MP_JOIN */
>  	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the
> address when sending a SYN + MP_JOIN */
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index
> 9042a86e003036f8eb9680bc6c520fb57d92dbd0..8ba1a4f225bd2014ebdc973e752
> 702028ee5f31a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3527,8 +3527,10 @@ bool mptcp_finish_join(struct sock *ssk)
>  		return true;
>  	}
>  
> -	if (!mptcp_pm_allow_new_subflow(msk))
> +	if (!mptcp_pm_allow_new_subflow(msk)) {
> +		MPTCP_INC_STATS(sock_net(ssk),
> MPTCP_MIB_JOINREJECTED);

nit:

Although the result is the same as sock_net(ssk), what do you think of
using sock_net(parent) here?

Thanks,
-Geliang

>  		goto err_prohibited;
> +	}
>  
>  	/* If we can't acquire msk socket lock here, let the release
> callback
>  	 * handle it
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index
> e7951786a97c91190c7341d2c586a1f4acc05ed5..15613d691bfef6800268ae75b62
> 508736865f44a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -247,6 +247,7 @@ static int subflow_check_req(struct request_sock
> *req,
>  
>  		if (unlikely(req->syncookie)) {
>  			if
> (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
> +				SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_JOINREJECTED);
>  				subflow_add_reset_reason(skb,
> MPTCP_RST_EPROHIBIT);
>  				return -EPERM;
>  			}
> @@ -902,6 +903,7 @@ static struct sock *subflow_syn_recv_sock(const
> struct sock *sk,
>  			}
>  
>  			if (!mptcp_can_accept_new_subflow(owner)) {
> +				SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_JOINREJECTED);
>  				subflow_add_reset_reason(skb,
> MPTCP_RST_EPROHIBIT);
>  				goto dispose_child;
>  			}
> 

