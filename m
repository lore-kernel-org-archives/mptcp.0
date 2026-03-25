Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6A29DB9A;
	Wed, 25 Mar 2026 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774423015; cv=none; b=UNgUfou++wW4AQfoQNoI1rcRiz93TbCR4hGFmVntb/k1VrhBZJLtB7/V2NmQ2N40KNXLPNDmXvQ2jqsJKlZUU342/NskJrO03ZyFthOaYfnj6woSPYnfNTJh0bvjKwIM9NNkUesz6ETJSiWy//7ahup4QPRJaaeeDi6B4j4gekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774423015; c=relaxed/simple;
	bh=7QXUZOFF7dVaO5ocvHKjtARthhgEwEQEzL0MIxKBkE0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=UlPipTXEIrf8YYXw/Cn71olqVBAyKUylZ1j5q79GD2aoftBkflcBVIZNv+/qe0+sLyfOS7q1TU6Ebe0weBa3NPmjQatVDwBE0/4BmIsA1GB+cTttn7DGuMQK3aFL9Xt58Anaed/iaakn69OuOIhpn1ePskCXVOPgWeoQ+n1ADCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujsjc+Yf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujsjc+Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F808C4CEF7;
	Wed, 25 Mar 2026 07:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774423014;
	bh=7QXUZOFF7dVaO5ocvHKjtARthhgEwEQEzL0MIxKBkE0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Ujsjc+Yf9ZYAwP2fi+NDzniWBVFVcwbwPjPFFMPpxOQaprM1/gi4j8NnOPBpNIMVu
	 CvfeYT8n3WUVFVjl1YTWUPfiFdLExWzS6JSsI/v0TpSizhlJFpqbP2OTLmefKQP/CD
	 ProfjJs0oBD4oIzVrRP1Qvt7V2+wGlbCF0BbTmIOXfgbc9MVfxJwqsokq876rzFyT+
	 M2PJJi2PCMhVKfX5e0TOZKCdk1m6BVo8krQtfYyqCKgooa3iY7QB0V032q8B5Rh+bQ
	 Cue48Rv6jNH/rT9k6XEylsZcXr6B5dxnsC1XPl9ybqqn3Bi7n4w5v6inLlkL/fy33X
	 3BBE7XJWsuoDg==
Date: Wed, 25 Mar 2026 08:16:46 +0100
From: Matthieu Baerts <matttbe@kernel.org>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Message-ID: <5d5d6905-4348-409a-9bb3-8eee30f215b1@kernel.org>
In-Reply-To: <2da353a7-96cf-40ed-9d83-f256ec6965e1@huawei.com>
References: <20260324085131.4187473-1-lixiasong1@huawei.com> <12ad947e-f386-4fcc-9043-bf4f95a7db83@kernel.org> <2da353a7-96cf-40ed-9d83-f256ec6965e1@huawei.com>
Subject: Re: [PATCH net v2] mptcp: fix soft lockup in mptcp_recvmsg()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <5d5d6905-4348-409a-9bb3-8eee30f215b1@kernel.org>

Hi Li,

25 Mar 2026 03:39:13 Li Xiasong <lixiasong1@huawei.com>:

> Hi Matt,
>
> On 3/25/2026 3:23 AM, Matthieu Baerts wrote:
>> Hi Li,
>>
>> On 24/03/2026 09:51, Li Xiasong wrote:
>>> syzbot reported a soft lockup in mptcp_recvmsg() [0].
>>>
>>> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
>>> removed from the sk_receive_queue. This causes sk_wait_data() to always
>>> find available data and never perform actual waiting, leading to a soft
>>> lockup.
>>>
>>> Fix this by adding a 'last' parameter to track the last peeked skb.
>>> This allows sk_wait_data() to make informed waiting decisions and preve=
nt
>>> infinite loops when MSG_PEEK is used.
>>
>> (...)
>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index cf1852b99963..401fb2b17685 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, s=
truct sk_buff *skb)
>>> static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 size_t len, int flags, int copied_total,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct scm_timestamping_internal *tss,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int *cmsg_flags)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 int *cmsg_flags, struct sk_buff **last)
>>> {
>>> =C2=A0=C2=A0=C2=A0 struct mptcp_sock *msk =3D mptcp_sk(sk);
>>> =C2=A0=C2=A0=C2=A0 struct sk_buff *skb, *tmp;
>>> @@ -2048,6 +2048,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, =
struct msghdr *msg,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copied +=3D count;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *last =3D skb;
>>
>> My bad, my recommendation to move this assignment here was not a good
>> idea, because 'skb' can be freed at some points after mptcp_eat_recv_skb
>> that can be called here below.
>>
>> If I'm not mistaken, when MSG_PEEK is not used, sk_wait_data() can
>> always be called with NULL for the last skb, because the queue is
>> supposed to be empty. If not, no need to wait for new packets, so NULL
>> can be used. Is that correct?
>>
>> If yes, then I guess 'last' can be initialised to NULL before calling
>> __mptcp_recvmsg_mskq (limit scope), and only set to 'skb' here below,
>> when MSG_PEEK is not used (what you had in v1).
>>
>> Would that work for you?
>>
>> Cheers,
>> Matt
>
> Thanks for the review. I analyzed the concern about the 'last' pointer.
>
> When writing the v2 patch, I did consider this case - in non-MSG_PEEK
> scenario, the skb is freed by mptcp_eat_recv_skb() after setting *last =
=3D
> skb, making 'last' point to freed memory. However, in sk_wait_data(), the
> 'last' parameter is only used for pointer comparison:
>
> =C2=A0=C2=A0=C2=A0 skb_peek_tail(&sk->sk_receive_queue) !=3D skb
>
> It only compares the pointer value without dereferencing, so there's no
> actual UAF issue.

Indeed, but the skb could be (unlikely) reused at that stage.

For me, the main point is that mptcp_eat_recv_skb() will remove the
skb from the queue. Then NULL can be passed instead, safer.

Cheers,
Matt
