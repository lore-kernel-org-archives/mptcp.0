Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0425DCE5
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 10:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813032; cv=none; b=BaKJtRimh8aO3CWECCUruFv2PPQAUmLUdrqUzUamEbDGP/lT7boKID0j3LhrK5Br4nAAvgsXy66aoiDL6Lmt+9Nopwy9w6Nne0b+L9a3m7E7890jVcZsUDueOCcg/fg5S5BRx9bNRxDqhWlc17m6xCtgiERIXstpXs6iEaaCEKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813032; c=relaxed/simple;
	bh=Hql/8+UMzpo6QmKH8wTuGmPRq67A3s5mv6SAYLv2Jbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fDl6TB617DXWXPZrEkWrg163wXSv6EqWc0G80oF6V69qxYjuFcX1loLiva+2x5zd8Sob9jfTXfeccu/wYUNEy4eB/V76QtfOIzNzY2tS/LdggwHdgX/BlfHLjXbT97pHMHaDUaOTqxb1bJt2c60xIjFkw3lymw8Jju8BaZsnj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0//fFhh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0//fFhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938E7C4CEDD;
	Mon, 24 Mar 2025 10:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742813031;
	bh=Hql/8+UMzpo6QmKH8wTuGmPRq67A3s5mv6SAYLv2Jbo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=L0//fFhh8JKq7DLGmN6sHxiXYZBSU2EXczVxLCv7A9E1wtbhmBJurReW1ZddL/AiE
	 PfsiI6Uffr/jdoGFlaW0NUgYczmTyXbgZn1VIWjb7QKRbAVVYt0sBOtRSMGefC4vks
	 zV0skeVtIC4o2vUw0jDJRFQz55rbZsyjuYlkxcIH5Z9HsmYUenzXOKOiOz0Tn+nJAb
	 nL5qIP2QXVMTSAhgcfZVCY7LXpVR2RZ0BrOeBFDjHOueyFJTMIRH/lSWhEp8h1QAo6
	 CnzqSleZAxZRwd4uCjx+tGrqF9OBEmzRAhttnzdpf8ckmHeLlogufDnJkHv6GFK6rU
	 iv2ZD9bymoPIg==
Message-ID: <fcb63d9a8c190c7cf57b87ad09378981ec89df66.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1 1/4] bpf: Add mptcp path manager struct_ops
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 24 Mar 2025 18:43:48 +0800
In-Reply-To: <d5222db5-c6b0-4f3a-a4f5-d7b3a9932b19@kernel.org>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
	 <aa77f73b6b6227cf88fd4aae77c5604593bf79d8.1742521587.git.tanggeliang@kylinos.cn>
	 <d5222db5-c6b0-4f3a-a4f5-d7b3a9932b19@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2025-03-24 at 11:26 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 21/03/2025 02:49, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch implements a new struct bpf_struct_ops for MPTCP BPF
> > path
> > manager: bpf_mptcp_pm_ops. Register and unregister the bpf path
> > manager
> > in .reg and .unreg.
> > 
> > Add write access for some fields of struct mptcp_sock and struct
> > mptcp_pm_addr_entry in .btf_struct_access.
> > 
> > This MPTCP BPF path manager implementation is similar to BPF TCP
> > CC. And
> > net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/bpf.c | 259
> > +++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 258 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 2b0cfb57df8c..596574102b89 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> 
> (...)
> 
> > +static int __bpf_mptcp_pm_get_local_id(struct mptcp_sock *msk,
> > +				       struct mptcp_pm_addr_entry
> > *skc)
> > +{
> > +	return 0;
> > +}
> > +
> > +static bool __bpf_mptcp_pm_get_priority(struct mptcp_sock *msk,
> > +					struct mptcp_addr_info
> > *skc)
> > +{
> > +	return false;
> > +}
> > +
> > +static void __bpf_mptcp_pm_established(struct mptcp_sock *msk)
> > +{
> > +}
> > +
> > +static void __bpf_mptcp_pm_subflow_established(struct mptcp_sock
> > *msk)
> > +{
> > +}
> > +
> > +static bool __bpf_mptcp_pm_allow_new_subflow(struct mptcp_sock
> > *msk)
> > +{
> > +	return false;
> > +}
> > +
> > +static bool __bpf_mptcp_pm_accept_new_subflow(const struct
> > mptcp_sock *msk)
> > +{
> > +	return false;
> > +}
> > +
> > +static bool __bpf_mptcp_pm_add_addr_echo(struct mptcp_sock *msk,
> > +					 const struct
> > mptcp_addr_info *addr)
> > +{
> > +	return false;
> > +}
> > +
> > +static int __bpf_mptcp_pm_add_addr_received(struct mptcp_sock
> > *msk,
> > +					    const struct
> > mptcp_addr_info *addr)
> > +{
> > +	return 0;
> > +}
> > +
> > +static void __bpf_mptcp_pm_rm_addr_received(struct mptcp_sock
> > *msk)
> > +{
> > +}
> > +
> > +static void __bpf_mptcp_pm_init(struct mptcp_sock *msk)
> > +{
> > +}
> > +
> > +static void __bpf_mptcp_pm_release(struct mptcp_sock *msk)
> > +{
> > +}
> > +
> > +static struct mptcp_pm_ops __bpf_mptcp_pm_ops = {
> > +	.get_local_id		= __bpf_mptcp_pm_get_local_id,
> > +	.get_priority		= __bpf_mptcp_pm_get_priority,
> > +	.established		= __bpf_mptcp_pm_established,
> > +	.subflow_established	=
> > __bpf_mptcp_pm_subflow_established,
> > +	.allow_new_subflow      =
> > __bpf_mptcp_pm_allow_new_subflow,
> > +	.accept_new_subflow     =
> > __bpf_mptcp_pm_accept_new_subflow,
> > +	.add_addr_echo		= __bpf_mptcp_pm_add_addr_echo,
> > +	.add_addr_received	=
> > __bpf_mptcp_pm_add_addr_received,
> > +	.rm_addr_received	= __bpf_mptcp_pm_rm_addr_received,
> 
> Out of curiosity: I see here that even the optional hooks are
> assigned:

Optional hooks must be assigned here, otherwise this hook cannot be
defined in BPF.

> does it mean that all function pointers will never be NULL and checks
> like 'pm->ops->add_addr_received' will always be true with a BPF PM?
> Or
> is it still OK to assign them to NULL for a new BPF PM?

I think it's the latter, it's OK to assign them to NULL.

Thanks,
-Geliang 

> 
> Cheers,
> Matt

