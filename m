Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284F1C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663680818; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=S8a2zb4NPs073tb88E5tw7IWnOeGPA3KpdTurOanXpoLEGgPLqZGJyEU9nt23fJ0WQ8jouJzJ1PEmXfDskdG9tgUEeP4j4o0cV9yJL8Wo3yaYhFNMP6frLK8mf8HEWMNUl39w61pKJ6GhSLIhBclaCMjrz2x1Hd5LfUl2UcOR4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663680818; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=ImCozllMgLCtmKcCXB3grXrSda6SX85kQcT6q93OmOY=; 
	b=EQ/PZDr9meP2Nq2kbD9JUbkh9g4zE2cgsfUsuXP97bAYMwiGTxh4jS7dru0hQvHZlZ/DmqhdBHYYunF4lxO5T8u/R8ON0tRos+Hbgb5GA8YSDc/XfhCsSM7nbE6EQBNoxJMX9Geq9xyP31/RiQs/iN01wjo+n0YdrhTuxn4PP04=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663680818;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ImCozllMgLCtmKcCXB3grXrSda6SX85kQcT6q93OmOY=;
	b=g4RkCU61GuXs+/UfY1fTAt4cSZOmKffZuDrVEdTFZX9NJmSer/7SWMVrMaNZLCLV
	xwzAtvsg77n83BkjadjCqDouzgzOyUDP1Vk4TuYOv3N82D90Vhnym4RSVv3ne5uSsFt
	DIxKTiNIntJeVD9B0CvXsKexkXQLOhDa8wKdMslc=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663680816261632.0351942037904; Tue, 20 Sep 2022 15:33:36 +0200 (CEST)
Message-ID: <30e2eca0-3411-fff6-f4f0-7052516bdbb4@shytyi.net>
Date: Tue, 20 Sep 2022 15:33:35 +0200
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
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-7-dmytro@shytyi.net>
 <5f15c4fa1e263faa553940bf9fcf57b566fa2dea.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
In-Reply-To: <5f15c4fa1e263faa553940bf9fcf57b566fa2dea.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Fixed in v8

Best,

Dmytro

On 9/19/2022 12:48 PM, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> Add set MPTFO socket option for MPTCP.
>>
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
> The above can fit a single line:
>
> 	if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))) {
>
> Otherwise this patch LGTM.
>
>
> Cheers,
>
> Paolo
>
