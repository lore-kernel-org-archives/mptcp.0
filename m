Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D11E633C
	for <mptcp@lists.linux.dev>; Mon, 24 Mar 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814410; cv=none; b=TjCq6zuNLBZwnT3GedAQGf8+X4M5DQ1LJXc7DZf0WtBq/chSqGsKh60iYlnlOF2ueoAN4lDTVKPO/53Pa5crJIV1XFw07o94VUWEy+XCVHyE1rQdDySTSpGICdztiovHoozJ75TNijwe2GUMsHy6Zv3VlRw3ian3FOycFKTGJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814410; c=relaxed/simple;
	bh=YLDqeErgwxeQzwwUyecR2jUiRA8Y3FdsSLS3uy1BeFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVzl9ffmZUTbD2QaObtOQODRp+9oU5Z1k2m5gAI1JFFS4z4aWaQ9Sane8nrB5trt3M8Zkr+Oh8grOlhwcUgRC/yxofSbdADfSLqbp78e7DGFhQWVQMtfx76HVFAb2WlXrAfUSLUWl/2x3G29bZHx5LazwZcdtmy7bQm/dHoqnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX138Oht; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX138Oht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D2BC4CEDD;
	Mon, 24 Mar 2025 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742814409;
	bh=YLDqeErgwxeQzwwUyecR2jUiRA8Y3FdsSLS3uy1BeFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VX138OhtI/lpUhju1l7JJi4LP3tMJUbBlAL6iK/H3xuyuIe59VBIXifaVkQyY3cNC
	 DDwX6FS1Fz7s46LSq2EPMcu4yucmwuKzrzf0WnTghX1MGJg4fiXkU3wgA1I083MDep
	 PePc7aRrJSsNKXkPcP3uVmXZzHrQ3pa84DjV2fUafZ1v3sA5/l4sE3eHHtJk3vZAmX
	 n6xjVu37KwDXUZyXastvHs2CAFtdgx8LoJqCC+t7Hvoa6+Qg0xjK/+ZYHZVE51yZgN
	 l5qiQReucWhTYZn3M+EMNT7ipPKvo8oN41epb61rD/gHJOyPBHCIySMrH36dpfJnAx
	 yZNrC404Qr8Tg==
Message-ID: <e78ddf1a-d3cf-4bc9-bcb9-bf901499e843@kernel.org>
Date: Mon, 24 Mar 2025 12:06:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 1/4] bpf: Add mptcp path manager struct_ops
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1742521587.git.tanggeliang@kylinos.cn>
 <aa77f73b6b6227cf88fd4aae77c5604593bf79d8.1742521587.git.tanggeliang@kylinos.cn>
 <d5222db5-c6b0-4f3a-a4f5-d7b3a9932b19@kernel.org>
 <fcb63d9a8c190c7cf57b87ad09378981ec89df66.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fcb63d9a8c190c7cf57b87ad09378981ec89df66.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 24/03/2025 11:43, Geliang Tang wrote:
> On Mon, 2025-03-24 at 11:26 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 21/03/2025 02:49, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch implements a new struct bpf_struct_ops for MPTCP BPF
>>> path
>>> manager: bpf_mptcp_pm_ops. Register and unregister the bpf path
>>> manager
>>> in .reg and .unreg.
>>>
>>> Add write access for some fields of struct mptcp_sock and struct
>>> mptcp_pm_addr_entry in .btf_struct_access.
>>>
>>> This MPTCP BPF path manager implementation is similar to BPF TCP
>>> CC. And
>>> net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
>>>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  net/mptcp/bpf.c | 259
>>> +++++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 258 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
>>> index 2b0cfb57df8c..596574102b89 100644
>>> --- a/net/mptcp/bpf.c
>>> +++ b/net/mptcp/bpf.c
>>
>> (...)
>>
>>> +static int __bpf_mptcp_pm_get_local_id(struct mptcp_sock *msk,
>>> +				       struct mptcp_pm_addr_entry
>>> *skc)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static bool __bpf_mptcp_pm_get_priority(struct mptcp_sock *msk,
>>> +					struct mptcp_addr_info
>>> *skc)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>> +static void __bpf_mptcp_pm_established(struct mptcp_sock *msk)
>>> +{
>>> +}
>>> +
>>> +static void __bpf_mptcp_pm_subflow_established(struct mptcp_sock
>>> *msk)
>>> +{
>>> +}
>>> +
>>> +static bool __bpf_mptcp_pm_allow_new_subflow(struct mptcp_sock
>>> *msk)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>> +static bool __bpf_mptcp_pm_accept_new_subflow(const struct
>>> mptcp_sock *msk)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>> +static bool __bpf_mptcp_pm_add_addr_echo(struct mptcp_sock *msk,
>>> +					 const struct
>>> mptcp_addr_info *addr)
>>> +{
>>> +	return false;
>>> +}
>>> +
>>> +static int __bpf_mptcp_pm_add_addr_received(struct mptcp_sock
>>> *msk,
>>> +					    const struct
>>> mptcp_addr_info *addr)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static void __bpf_mptcp_pm_rm_addr_received(struct mptcp_sock
>>> *msk)
>>> +{
>>> +}
>>> +
>>> +static void __bpf_mptcp_pm_init(struct mptcp_sock *msk)
>>> +{
>>> +}
>>> +
>>> +static void __bpf_mptcp_pm_release(struct mptcp_sock *msk)
>>> +{
>>> +}
>>> +
>>> +static struct mptcp_pm_ops __bpf_mptcp_pm_ops = {
>>> +	.get_local_id		= __bpf_mptcp_pm_get_local_id,
>>> +	.get_priority		= __bpf_mptcp_pm_get_priority,
>>> +	.established		= __bpf_mptcp_pm_established,
>>> +	.subflow_established	=
>>> __bpf_mptcp_pm_subflow_established,
>>> +	.allow_new_subflow      =
>>> __bpf_mptcp_pm_allow_new_subflow,
>>> +	.accept_new_subflow     =
>>> __bpf_mptcp_pm_accept_new_subflow,
>>> +	.add_addr_echo		= __bpf_mptcp_pm_add_addr_echo,
>>> +	.add_addr_received	=
>>> __bpf_mptcp_pm_add_addr_received,
>>> +	.rm_addr_received	= __bpf_mptcp_pm_rm_addr_received,
>>
>> Out of curiosity: I see here that even the optional hooks are
>> assigned:
> 
> Optional hooks must be assigned here, otherwise this hook cannot be
> defined in BPF.

OK, thanks!

>> does it mean that all function pointers will never be NULL and checks
>> like 'pm->ops->add_addr_received' will always be true with a BPF PM?
>> Or
>> is it still OK to assign them to NULL for a new BPF PM?
> 
> I think it's the latter, it's OK to assign them to NULL.

If you have the infrastructure ready, can you check if you can set
add_addr_received to NULL in a new BPF struct_ops mptcp_pm_ops for
example please? Also, just to be sure, can you also check that in this
case, in the pm.c, pm->ops->add_addr_received is also set to NULL and
not to __bpf_mptcp_pm_add_addr_received? (not urgent)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

