Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9D63B9
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109658; cv=none; b=rzcOAMt6d+ODWVpC5Ju6zeMCNo4jc+6ixROW/PDG9IZ2h9dHNulVDfUFS9y/Y3HTqUo6qSTU3vkW6i1Pwszsbz2FtLUs/l5FMZbhcHaA5TZKyKZV48Jwo037DWMI5gb35OomFKwkR+5vZa1OU+SHXRp01QbjEMkespwF2KOq4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109658; c=relaxed/simple;
	bh=giGXWo+4vd/WgnjKgtn9V+E3elOMsFGEc8drcvYhYas=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cnp5uXTdiyC8oMaEnPb0orjNtIMFfztDJ5TYxAJICuj4FR0DFTOgqe6nrGBmdctPTY4Sp5Scry/j6R7WlyHsuDbjvHCRCUl4HM1HkHyXjlohsVN0Vq0BVgaHPHlNoH7GJzAn0xzO2hdmDzmLBri7UGMdLURRF319DdMT8LBZ/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhuD73vc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhuD73vc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82302C19421;
	Tue,  3 Feb 2026 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770109658;
	bh=giGXWo+4vd/WgnjKgtn9V+E3elOMsFGEc8drcvYhYas=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BhuD73vcQrRoZnqFCdg1lFlk/1uSeEicVe+s59VSYlBwy/yjYncKciiNxat4nYwhs
	 xLrSoq6JPD04WrIX+zcEJpRL6M0MwefzBy4UbuiKuh1oeQx4Tl12GLOn41Nu8ilIC2
	 AZtAjVCdwbUSL59LQKMYI4hdg5IR00dOo/zaGD576i2UhiV3i3NSYXPPQJQWHSRDOS
	 1B3eywAa72nqBG6Vq9vSTpDg3TSzUBRGemJikOjdZhzHyWDvWlxyv67DQKt5530eVg
	 VRihYTEf1AMpD2EBxSVqhxy2krUXGihJojuZ8rv7rEn8pAKcMKxcN7ovogqF2DQl5U
	 SMeMXu3MVNrAA==
Message-ID: <6eb6a640-8837-4970-b58f-e2ad5eef9b0e@kernel.org>
Date: Tue, 3 Feb 2026 10:07:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/3] mptcp: implement .splice_eof
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
 <9e3dddfc65f24c1a11e5f0353b497f1d4f1c6f82.1770023932.git.tanggeliang@kylinos.cn>
 <5866364b-87b9-4abd-9eed-5437e6c56ffb@kernel.org>
 <b0ca46ead8c060d093b8aefc4939cadc1f4c159f.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b0ca46ead8c060d093b8aefc4939cadc1f4c159f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 03/02/2026 07:36, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2026-02-02 at 11:07 +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for looking at that!
>>
>> On 02/02/2026 10:21, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> This patch implements the .splice_eof interface for MPTCP, namely
>>> mptcp_splice_eof(), which sequentially calls do_tcp_splice_eof()
>>> for
>>> each subflow.
>>
>> Can you please explain what this hook is supposed to do / used for
>> please?
> 
> do_tcp_splice_eof() ensures that any remaining data in the TCP send
> queue is flushed immediately when a sendfile() operation reaches end-
> of-file (EOF).

OK, so if I understand correctly, it means that without .splice_eof()
support, the queue is not flushed immediately when a sendfile()
operation reaches end-of-file (EOF). But that's OK, it will be flushed,
eventually with a small delay but the most important is that all data
will be transferred. Is that correct?

If it is, can you please reflect that in the commit message?
I think it is essential to mention it is not linked to the 'splice()'
syscall, it is an improvement, and nothing was broken before.

>> And also why the solution is to call do_tcp_splice_eof() on each
>> subflow?
> 
> MPTCP operates over multiple TCP subflows. When splicing data through
> an MPTCP socket, each subflow may have pending data in its send buffer
> that needs to be properly finalized. So here calls do_tcp_splice_eof()
> on each subflow.

Can you also please add a note about that in the commit message?

>> Also, I'm a bit confused: why is this needed? Does it fix something
>> or
>> is it a new feature or an optimisation?
> 
> It is not a fix, but a new feature, to keep consistent with TCP. Since
> TCP handles the splice EOF notification but MPTCP didn't.
> 
>>
>>> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> ---
>>>  net/mptcp/protocol.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index c88882062c40..5635d196cb9f 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -4018,6 +4018,20 @@ static int mptcp_connect(struct sock *sk,
>>> struct sockaddr_unsized *uaddr,
>>>  	return 0;
>>>  }
>>>  
>>> +static void mptcp_splice_eof(struct socket *sock)
>>> +{
>>> +	struct mptcp_subflow_context *subflow;
>>> +	struct sock *sk = sock->sk, *ssk;
>>> +
>>> +	lock_sock(sk);
>>> +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
>>> +		ssk = mptcp_subflow_tcp_sock(subflow);
>>> +
>>> +		do_tcp_splice_eof(ssk);
>>
>> Is it fine to call this on closed subflows? e.g. if the initial
>> subflow
>> has been closed. (I didn't check, maybe that's OK)
> 
> Good point. I will add this check in v2:
> 
>        if (ssk->sk_state == TCP_CLOSE)
>                continue;
> 
>>
>>> +	}
>>> +	release_sock(sk);
>>> +}
>>> +
>>>  static struct proto mptcp_prot = {
>>>  	.name		= "MPTCP",
>>>  	.owner		= THIS_MODULE,
>>> @@ -4049,6 +4063,7 @@ static struct proto mptcp_prot = {
>>>  	.obj_size	= sizeof(struct mptcp_sock),
>>>  	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
>>>  	.no_autobind	= true,
>>> +	.splice_eof	= mptcp_splice_eof,
>>>  };
>>>  
>>>  static int mptcp_bind(struct socket *sock, struct sockaddr_unsized
>>> *uaddr, int addr_len)
>>> @@ -4540,6 +4555,7 @@ static const struct proto_ops
>>> mptcp_stream_ops = {
>>>  	.set_rcvlowat	   = mptcp_set_rcvlowat,
>>>  	.read_sock	   = mptcp_read_sock,
>>>  	.splice_read	   = mptcp_splice_read,
>>> +	.splice_eof	   = inet_splice_eof,
>>
>> Is this line required? Will it not call inet_splice_eof() by default?
>> (I
>> didn't check)
> 
> Yes, this is required.
> 
> sock_splice_eof() needs to call the .splice_eof interface from struct
> proto_ops. To maintain consistency with regular TCP behavior, the 
> .splice_eof interface of mptcp_stream_ops is set to inet_splice_eof
> too. inet_splice_eof() will switch to the protocol-specific
> implementation (sk->sk_prot->splice_eof), which for MPTCP is
> mptcp_splice_eof().

OK. Then be careful that inet_splice_eof() will call inet_send_prepare()
which will call sock_rps_record_flow(sk). mptcp_rps_record_subflows()
should be called on each subflow, probably from mptcp_splice_eof().

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

