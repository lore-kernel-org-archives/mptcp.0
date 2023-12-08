Received: from fallback23.i.mail.ru (fallback23.i.mail.ru [79.137.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F530659
	for <mptcp@lists.linux.dev>; Fri,  8 Dec 2023 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=internet.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=internet.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="n5ah7QX+";
	dkim=pass (2048-bit key) header.d=internet.ru header.i=@internet.ru header.b="oEHr8snc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=uLvIAzQLJfTQIHdD/nz7Ve9RoUu17dboBQNR7iHd/i4=;
	t=1702061648;x=1702151648; 
	b=n5ah7QX+uCUmgK7oxxzftZoS4lOVnnzqjNVtql4sM2U0A6PRNHP5CdR0l3tkTlsLtj4gvFi6gaxerBpN8k0RI/FNJaWPQ+HWcNTHMKlPLn78vAWuvS1jTf2kuOcTmfgsAQU6tn6geFKPBl0CQrKsHCoAHszF6D5DU56ad2/bG+Ilkr6AUH/3Vt6026ZlH2zVVuch/xH+GL71pBQGGW30R0PX0yDiYYMhG2xSqQXWlqvvpzmDO2HskjdEZ3QcO3wv5lPbsxIWQWFUrpDC+itd6Brw8YjbswtNYdDYUECnUJaK7y/ouFtKa9FV0FHNDF1/xtK81nCTVF5Qb+Hxp0Uz2g==;
Received: from [10.12.4.20] (port=40740 helo=smtp44.i.mail.ru)
	by fallback23.i.mail.ru with esmtp (envelope-from <max@internet.ru>)
	id 1rBfDb-0076NL-Rs
	for mptcp@lists.linux.dev; Fri, 08 Dec 2023 21:04:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru
	; s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=uLvIAzQLJfTQIHdD/nz7Ve9RoUu17dboBQNR7iHd/i4=; t=1702058695; x=1702148695; 
	b=oEHr8sncPX8qAM37Gk4Xp7Ll7aJwFnWoltEESJP1mml4zjZPuEAA19xd+tQbCLYWhqyAFdf/5cr
	WjIH3hyCvQrFOian7cEnAaybg+cKS1QHvPJLq9ztrVb2t8wUk3Q8nKzp5qYRSL2sgO65pVdUQGnqI
	4AkpNYT45D4McOYMAo+5PKyWC0iz1WoK1MDBxd3DqC8ymcaVNZ+epsnU3jCh4lS8Wf3LxD8Yy84aA
	jLGpqGBqFEVksUGI/g6AL6bL2FpcMo5QninwB4LOHUbIDi9J0pjG9fxNKcek7MEhumP1726N+NYet
	JFVJe6TFzs35dWdV7E+8uUFio4nqe9oBZNlw==;
Received: by smtp44.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1rBfDL-00A0fw-0e; Fri, 08 Dec 2023 21:04:39 +0300
Message-ID: <df2fa1b7-3ced-4473-b6bd-5864d3282f35@internet.ru>
Date: Fri, 8 Dec 2023 21:04:38 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next 2/3] mptcp: sockopt: support
 IP_LOCAL_PORT_RANGE and IP_BIND_ADDRESS_NO_PORT
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20231129113403.157953-1-max@internet.ru>
 <20231129113403.157953-3-max@internet.ru>
 <7d400717-0bfd-5dcc-3ea7-fc12db4c4759@kernel.org>
 <2da11695-1691-bf06-4554-427b18820a97@kernel.org>
 <CABbSpcgKEkA8iu8FD5vLAvb6c-mawRJyFMm7LnEmuQSRtpKXRQ@mail.gmail.com>
Content-Language: en-US
From: Maxim Galaganov <max@internet.ru>
In-Reply-To: <CABbSpcgKEkA8iu8FD5vLAvb6c-mawRJyFMm7LnEmuQSRtpKXRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9B1592A052B88CCADC723B38012FD4A199F6CA7F36E5B91021313CFAB8367EF908E2BE116634AD74D9B6187A27AFB9678C98D3B27851EFA0F3D637C9628A39152DFD01B7CA0B1DCD2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75C385DEB91CEC222EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378D70459434292EC88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D86144B53CF98311170654C6FBEFB709F26F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE70B7EC9B0538196269FA2833FD35BB23D9E625A9149C048EE26055571C92BF10FC26CFBAC0749D213D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BEA77C8EAE1CE44B0A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FCEE6865575290A7923AA81AA40904B5D9CF19DD082D7633A0C84D3B47A649675F3AA81AA40904B5D98AA50765F7900637C19E3E633E4C12D3D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F7900637A451E1E29F2EDBED6D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063772BA5C7373F6D986EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A512D6058DEE3E10B6460CDB8670916B90AB7CA050525296F8F87CCE6106E1FC07E67D4AC08A07B9B0A816C540FC8EEC30CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF73503F15BC1ABD3634F4F4E2C75861D97256D7CF199F8A8C63E0F8DCFB7F502714625291CC5E48B92DAB5BB764D2450937F80B32C483B76DBB4CCBAE99DD74F340B08DDBC5CE87D002C26D483E81D6BEA5ED0C00A4B096A39697699CFF2E0C50CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UPPAyv4Tswx2EUKjWfzwg==
X-Mailru-Sender: 7766D515518070DED5E1F59BD085B5D43AB1DD8B734098F94CE9906786EBAEDF75434CE7A01A4145AA92DCB28147B367B60569B44082A3A3CC338593878DF048773EBFF2F43C11D6EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4504CF8691E74CC1EE045C20511AAF4EE20659E52C60CB635049FFFDB7839CE9E02300A6554B5DD3CFC525FB935FE67519A2C16E04E19FD7B4BE91A254D99A923
X-7FA49CB5: 0D63561A33F958A57173A0CA1157F0FB88797F6DC39A508E1565735969683CD7CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637D2AD7660D07C2C48389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8632EDEA9CD5989A3F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7BEA0E1DB66A6FB7C731C566533BA786AA5CC5B56E945C8DA
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj1UPPAyv4TswD8X5jj8uDww==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 08.12.2023 03:24, Mat Martineau wrote:
> On Fri, Dec 1, 2023 at 3:59 PM Mat Martineau <martineau@kernel.org> wrote:
>>
>> On Wed, 29 Nov 2023, Mat Martineau wrote:
>>
>>> On Wed, 29 Nov 2023, Maxim Galaganov wrote:
>>>
>>>> Support for IP_BIND_ADDRESS_NO_PORT sockopt was introduced in [1].
>>>> Recently [2] allowed its value to be accessed without locking the
>>>> socket.
>>>>
>>>> Support for (newer) IP_LOCAL_PORT_RANGE sockopt was introduced in [3].
>>>> In the same series a selftest was added in [4]. This selftest also
>>>> covers the IP_BIND_ADDRESS_NO_PORT sockopt.
>>>>
>>>> This patch enables getsockopt()/setsockopt() on MPTCP sockets for these
>>>> socket options, syncing set values to subflows in sync_socket_options().
>>>> Ephemeral port range is synced to subflows, enabling NAT usecase
>>>> described in [3].
>>>>
>>>> [1] commit 90c337da1524 ("inet: add IP_BIND_ADDRESS_NO_PORT to overcome
>>>> bind(0) limitations")
>>>> [2] commit ca571e2eb7eb ("inet: move inet->bind_address_no_port to
>>>> inet->inet_flags")
>>>> [3] commit 91d0b78c5177 ("inet: Add IP_LOCAL_PORT_RANGE socket option")
>>>> [4] commit ae5439658cce ("selftests/net: Cover the IP_LOCAL_PORT_RANGE
>>>> socket option")
>>>>
>>>> Signed-off-by: Maxim Galaganov <max@internet.ru>
>>>
>>> Thanks for the v2 Maxim, looks good to me:
>>>
>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>>
>>
>> Now that I've signed off on this, I see that there's work going on to
>> change the implementation of local_port_range:
>>
>> https://lore.kernel.org/netdev/a4f5b61c9cd44eada41d8f09d3848806@AcuMS.aculab.com/
>>
>> I think it makes sense to do a v3 of this series if a version of David's
>> patch gets merged soon (I expect a v2 as he got some feedback from me and
>> some others). I'll watch for progress with his patch on netdev.
> 
> Maxim -
> 
> It looks like this patch will be merged to net-next soon:
> 
> https://lore.kernel.org/netdev/4e505d4198e946a8be03fb1b4c3072b0@AcuMS.aculab.com/
> 
> Please cherry-pick that and update your IP_LOCAL_PORT_RANGE patch to
> fit the new implementation.

Hi Mat,

I'd prefer posting v3 once the mentioned patch gets to net-next and then 
export branch, otherwise bots will probably complain about build errors. 
Tell me if I should just post them now.

Thank you for spotting and tracking this.

Max

> 
> Thanks!
> 
> - Mat
> 
> 
>>
>>>> ---
>>>> net/mptcp/sockopt.c | 29 ++++++++++++++++++++++++++++-
>>>> 1 file changed, 28 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>>> index a4bf337e6f77..a164a3e21be4 100644
>>>> --- a/net/mptcp/sockopt.c
>>>> +++ b/net/mptcp/sockopt.c
>>>> @@ -440,6 +440,8 @@ static bool mptcp_supported_sockopt(int level, int
>>>> optname)
>>>>               /* should work fine */
>>>>               case IP_FREEBIND:
>>>>               case IP_TRANSPARENT:
>>>> +            case IP_BIND_ADDRESS_NO_PORT:
>>>> +            case IP_LOCAL_PORT_RANGE:
>>>>
>>>>               /* the following are control cmsg related */
>>>>               case IP_PKTINFO:
>>>> @@ -455,7 +457,6 @@ static bool mptcp_supported_sockopt(int level, int
>>>> optname)
>>>>               /* common stuff that need some love */
>>>>               case IP_TOS:
>>>>               case IP_TTL:
>>>> -            case IP_BIND_ADDRESS_NO_PORT:
>>>>               case IP_MTU_DISCOVER:
>>>>               case IP_RECVERR:
>>>>
>>>> @@ -688,6 +689,7 @@ static int mptcp_setsockopt_sol_ip_set(struct
>>>> mptcp_sock *msk, int optname,
>>>> {
>>>>       struct sock *sk = (struct sock *)msk;
>>>>       struct sock *ssk;
>>>> +    bool slow;
>>>>       int err;
>>>>
>>>>       err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
>>>> @@ -710,6 +712,16 @@ static int mptcp_setsockopt_sol_ip_set(struct
>>>> mptcp_sock *msk, int optname,
>>>>               inet_assign_bit(TRANSPARENT, ssk,
>>>>                               inet_test_bit(TRANSPARENT, sk));
>>>>               break;
>>>> +    case IP_BIND_ADDRESS_NO_PORT:
>>>> +            inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
>>>> +                            inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
>>>> +            break;
>>>> +    case IP_LOCAL_PORT_RANGE:
>>>> +            slow = lock_sock_fast(ssk);
>>>> +            inet_sk(ssk)->local_port_range.lo =
>>>> inet_sk(sk)->local_port_range.lo;
>>>> +            inet_sk(ssk)->local_port_range.hi =
>>>> inet_sk(sk)->local_port_range.hi;
>>>> +            unlock_sock_fast(ssk, slow);
>>>> +            break;
>>>>       default:
>>>>               release_sock(sk);
>>>>               WARN_ON_ONCE(1);
>>>> @@ -755,6 +767,8 @@ static int mptcp_setsockopt_v4(struct mptcp_sock *msk,
>>>> int optname,
>>>>       switch (optname) {
>>>>       case IP_FREEBIND:
>>>>       case IP_TRANSPARENT:
>>>> +    case IP_BIND_ADDRESS_NO_PORT:
>>>> +    case IP_LOCAL_PORT_RANGE:
>>>>               return mptcp_setsockopt_sol_ip_set(msk, optname, optval,
>>>> optlen);
>>>>       case IP_TOS:
>>>>               return mptcp_setsockopt_v4_set_tos(msk, optname, optval,
>>>> optlen);
>>>> @@ -1346,10 +1360,20 @@ static int mptcp_getsockopt_v4(struct mptcp_sock
>>>> *msk, int optname,
>>>>                              char __user *optval, int __user *optlen)
>>>> {
>>>>       struct sock *sk = (void *)msk;
>>>> +    bool slow;
>>>> +    int val;
>>>>
>>>>       switch (optname) {
>>>>       case IP_TOS:
>>>>               return mptcp_put_int_option(msk, optval, optlen,
>>>> READ_ONCE(inet_sk(sk)->tos));
>>>> +    case IP_BIND_ADDRESS_NO_PORT:
>>>> +            return mptcp_put_int_option(msk, optval, optlen,
>>>> +                            inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
>>>> +    case IP_LOCAL_PORT_RANGE:
>>>> +            slow = lock_sock_fast(sk);
>>>> +            val = inet_sk(sk)->local_port_range.hi << 16 |
>>>> inet_sk(sk)->local_port_range.lo;
>>>> +            unlock_sock_fast(sk, slow);
>>>> +            return mptcp_put_int_option(msk, optval, optlen, val);
>>>>       }
>>>>
>>>>       return -EOPNOTSUPP;
>>>> @@ -1450,6 +1474,9 @@ static void sync_socket_options(struct mptcp_sock
>>>> *msk, struct sock *ssk)
>>>>
>>>>       inet_assign_bit(TRANSPARENT, ssk, inet_test_bit(TRANSPARENT, sk));
>>>>       inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>>>> +    inet_assign_bit(BIND_ADDRESS_NO_PORT, ssk,
>>>> inet_test_bit(BIND_ADDRESS_NO_PORT, sk));
>>>> +    inet_sk(ssk)->local_port_range.lo = inet_sk(sk)->local_port_range.lo;
>>>> +    inet_sk(ssk)->local_port_range.hi = inet_sk(sk)->local_port_range.hi;
>>>> }
>>>>
>>>> void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>>
>>>

