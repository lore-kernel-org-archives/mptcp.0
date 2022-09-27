Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DA259A
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 15:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664291399; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RCQCAlxBX4awDK9aYVlL1HlZbg1L0EbFd8Ck4V2ChbRLXFFh/sev8puRYd+kpDmRhEarEPF3R9nLH5Gepl9ioZPVC/knduBmBOkKW6KzA8KYLU2jgI1qt1jCWlWVeIitVF0hZHDhmATWlOSNS0zpcIiiyVi9G52o0eenAiemHZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664291399; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=mC6aMjG62HyegJr2E5PqEjKPeYlAVtKdxZA3PjhkeC0=; 
	b=R9XRW2qY40P/Jk8+1YkF0qhYJ03t4qMBtoMhNFsN+/glFT6yCAdOCN2TiW7w4HWtXHDEBAOXxwzbEvaCqWaMcHj6c5vgqhR0egMcvfeAYEpQZq6AV3XgpdIkckpGBSvMAva/NK55p3hui9tJOpIb1bT+m3ADQnuI4qW7RplYwjw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664291399;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mC6aMjG62HyegJr2E5PqEjKPeYlAVtKdxZA3PjhkeC0=;
	b=eRpKh0inAlIjkHo6QVlRatDRL+ltog1UtSjdYYahN+ZiP4RmODwB/CBuzNlxMWVe
	5iYWSfc51E1QesoIWu8RdZdx9cL4sn6Jr4l2O+s7yzEVvV7FVPSjDzOMjrlp5OqVo96
	Uqskd9cuKFk/evyuaO09lHoQ08rzJyQfe5PJuho8=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664291397069378.5966740624657; Tue, 27 Sep 2022 17:09:57 +0200 (CEST)
Date: Tue, 27 Sep 2022 17:09:56 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v11 4/4] mptcp: reuse
 tcp_sendmsg_fastopen()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
References: <20220925232601.25252-1-dmytro@shytyi.net>
 <20220925232601.25252-5-dmytro@shytyi.net>
 <3b85c5f3ceac73bfc397c783910ef0bc5532fb69.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <1e813adc-0171-3274-48fd-a9f20316b477@shytyi.net>
In-Reply-To: <3b85c5f3ceac73bfc397c783910ef0bc5532fb69.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello,

On 9/26/2022 4:46 PM, Paolo Abeni wrote:
> Hello,
>
> On Mon, 2022-09-26 at 01:26 +0200, Dmytro Shytyi wrote:
>> In the following patches we will reuse modified tcp_sendmsg_fastopen().
>> We call it from mptcp_sendmsg().
>>
>> Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   include/net/tcp.h    |  3 +++
>>   net/ipv4/tcp.c       |  6 +++---
>>   net/mptcp/protocol.c | 25 +++++++++++++++++++++++--
>>   3 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 27e8d378c70a..97cb014ddcab 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1755,6 +1755,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, str=
uct sk_buff *skb,
>>   =09=09=09      struct request_sock *req,
>>   =09=09=09      struct tcp_fastopen_cookie *foc,
>>   =09=09=09      const struct dst_entry *dst);
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=09=09=09 int *copied, size_t size,
>> +=09=09=09 struct ubuf_info *uarg);
>>   void tcp_fastopen_init_key_once(struct net *net);
>>   bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
>>   =09=09=09     struct tcp_fastopen_cookie *cookie);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index a22c8044de17..daa611671d9a 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -1162,9 +1162,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
>>   =09}
>>   }
>>  =20
>> -static int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> -=09=09=09=09int *copied, size_t size,
>> -=09=09=09=09struct ubuf_info *uarg)
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=09=09=09 int *copied, size_t size,
>> +=09=09=09 struct ubuf_info *uarg)
>>   {
>>   =09struct tcp_sock *tp =3D tcp_sk(sk);
>>   =09struct inet_sock *inet =3D inet_sk(sk);
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index fb08e1f458c0..dd2414fdcf04 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1679,9 +1679,30 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
>>   =09long timeo;
>>  =20
>>   =09/* we don't support FASTOPEN yet */
>> -=09if (msg->msg_flags & MSG_FASTOPEN)
>> -=09=09return -EOPNOTSUPP;
>> +=09if (msg->msg_flags & MSG_FASTOPEN) {
>> +=09=09struct socket *ssock;
>> +=09=09struct sock *ssk;
>>  =20
>> +=09=09lock_sock(sk);
>> +
>> +=09=09ssock =3D __mptcp_nmpc_socket(msk);
>> +=09=09ssk =3D ssock->sk;
>> +
>> +=09=09lock_sock(ssk);
>> +
>> +=09=09if (ssock) {
>> +=09=09=09int copied_syn_fastopen =3D 0;
>> +
>> +=09=09=09ret =3D tcp_sendmsg_fastopen(ssk, msg, &copied_syn_fastopen, l=
en, NULL);
>> +=09=09=09copied +=3D copied_syn_fastopen;
>> +=09=09=09if (ret) {
>> +=09=09=09=09release_sock(ssk);
>> +=09=09=09=09goto do_error;
>> +=09=09=09}
>> +=09=09}
>> +=09=09release_sock(ssock->sk);
>> +=09=09release_sock(sk);
>> +=09}
>>   =09/* silently ignore everything else */
>>   =09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> the above/previous patches duplicate quit a bit of code. Instead the
> following should be enough (replacing patches 2, 3, 4 here):


Indeed. You are right. We could use this=C2=A0 and seems like it works :)

> ---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c99eb4ce948e..c50e8f85bb11 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1673,17 +1673,14 @@ static int mptcp_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t len)
>   =09int ret =3D 0;
>   =09long timeo;
>  =20
> -=09/* we don't support FASTOPEN yet */
> -=09if (msg->msg_flags & MSG_FASTOPEN)
> -=09=09return -EOPNOTSUPP;
> -
>   =09/* silently ignore everything else */
> -=09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> +=09msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_FAST=
OPEN;
>  =20
>   =09lock_sock(sk);
>  =20
>   =09ssock =3D __mptcp_nmpc_socket(msk);
> -=09if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> +=09if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect ||
> +=09=09     msg->msg_flags & MSG_FASTOPEN)) {
>   =09=09struct sock *ssk =3D ssock->sk;
>   =09=09int copied_syn =3D 0;
>  =20
>
>

