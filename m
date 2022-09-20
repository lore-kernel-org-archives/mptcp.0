Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A7F1C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:34:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663680860; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LGKEyialMrXbwZQYCurO/9GZvTg9qKSKnC4xFkhNV57+DDTRGPxcppZHF8FQwPh+WXp3ga7/Y0dgUyyVpkwRMcXepgY0DdrneNvob0jK/phImli9UqDd4nTd/VHW2H7A+GC3Ot3X/Nb/ufKR4V0S9EgJ5zZnvKHgyPP7PZa0p3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663680860; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=6svrby31yDNm1+qEBeCy2cGtPrCB9Vp3LNjOYu6Npa0=; 
	b=MbjBZvu0TQCXJlRrl44T7dEsEBbX3fPbcp4YzVjV6vu3UcrFBQ6s5rA1ed2rhWOANkTQjpyApaCYksamu0vPeqnrx2zbWbZFsMwjE83x3ysE1LgO9PpCvlxWqMhY4QnA4GtFLfOlG/sMb78xLBoFlzE3uMGKUah2PUyg9v3eobg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663680860;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6svrby31yDNm1+qEBeCy2cGtPrCB9Vp3LNjOYu6Npa0=;
	b=cfVWGN0JR+zySNE++tWzLEhZPd4J1iiwHn6u6XsaWSFSfRVWtgWcumgKwrIi7pOy
	CnTlZCxbXHXcgIFTmwjcsnhb7PmBMnW5M3RNzcbPWUiFFpVulCLnLvAH/dmwGsEYm6u
	jDraTVPcCP2ZZrB1xGdL4jwPGsCceSrxrQa79+8k=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663680857843766.5307157575517; Tue, 20 Sep 2022 15:34:17 +0200 (CEST)
Message-ID: <97e236ae-3a63-f18d-9436-f91ab3ba46d4@shytyi.net>
Date: Tue, 20 Sep 2022 15:34:17 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 06/11] add mptcp_setsockopt_fastopen
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-7-dmytro@shytyi.net>
 <fc096cda-4522-ca8e-1c2f-a0d036923f11@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <fc096cda-4522-ca8e-1c2f-a0d036923f11@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Matthieu

Thank you for comments,

I will improve this in v9.

Best,

Dmytro

On 9/20/2022 11:37 AM, Matthieu Baerts wrote:
> Hi Dmytro,
>
> On 18/09/2022 00:28, Dmytro Shytyi wrote:
>> Add set MPTFO socket option for MPTCP.
> It is often very helpful to not just mention what you are doing here
> (e.g. add XXX) but explain the reason why you are doing this. Getting
> the reason is often not clear when looking at a commit diff so it is a
> very valuable info to add in a commit description.
>
> For example here, it could be nice to explain this option is needed for
> the listen socket only to accept TFO. And also why you are changing the
> values directly, what it is similar to, etc. etc.
>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/fastopen.c | 28 ++++++++++++++++++++++++++++
>>   net/mptcp/protocol.h |  2 ++
>>   net/mptcp/sockopt.c  |  3 +++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> index 50b5c3376672..436e773d798a 100644
>> --- a/net/mptcp/fastopen.c
>> +++ b/net/mptcp/fastopen.c
>> @@ -63,3 +63,31 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>>   	ret = -EFAULT;
>>   	return ret;
>>   }
>> +
>> +int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_t optval,
>> +				      unsigned int optlen)
>> +{
>> +	struct sock *sk = (struct sock *)msk;
>> +	struct net *net = sock_net(sk);
>> +	int val;
>> +	int ret;
>> +
>> +	ret = 0;
>> +
>> +	if (copy_from_sockptr(&val, optval, sizeof(val)))
>> +		return -EFAULT;
>> +
>> +	lock_sock(sk);
>> +
>> +	if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
>> +	    TCPF_LISTEN))) {
>> +		tcp_fastopen_init_key_once(net);
>> +		fastopen_queue_tune(sk, val);
> Can you not call tcp_setsockopt() here instead of copying what is done
> in do_tcp_setsockopt()?
>
> It would be simpler and easier to maintain I think.
>
>
> Also, in general for the series, may you add 'mptcp:' prefix in the git
> commit titles?
>
> What is important too is to add comments if what you are doing is
> similar to what is done in TCP, e.g. similar to XXX() in tcp_XXX.c? You
> can add a short comment in the code and explain why you are doing that
> and not call TCP functions in the git commit description for example.
> That would help a lot reviewers and maintainers later.
>
> Cheers,
> Matt
