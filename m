Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710E1C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:32:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663680754; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OKuZagCtyThP7A1Uq79Ewppq7y5P4XBprMmI4PtJ5Cob7pnEeVvi2uecjH4XpBrK8LWHFvbfea72uQMTOWUeJR3FzQT4SlcD0HtBQd/tS4kFF2oW9hDMcH6Z+uLjx//hUH7OBQ6LxL2cjId2/YVOxs6I53Swe3rwrZ9twBaAyqQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663680754; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=rC1grzGIKJ7gGMJ+NlZaRfOlV1hnFcEd9Em1iZse/5Y=; 
	b=QCEYJAM4Cov+t6RXR8fD24N8JvRkYBqTDqULjLUfa6i96tBCfjGikyLF7qr10UghQS5Cv2zQ8HW5l6ymZo+W8CWoBNO0Y+wthiB5mrrGs07XWbHw83siJmHihQ6nig8ZtfAbIun6TEw6qekrWDVMoSrTB442mpwwwUG+kwfja24=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663680754;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rC1grzGIKJ7gGMJ+NlZaRfOlV1hnFcEd9Em1iZse/5Y=;
	b=FlqrAdydaisNqNzqkckjQRJ9XlEEGB/q8+InxkpurEh56UP/T99Dkm8Ymb/N8MIz
	LlY9X2ZfO3v+cPuAkAhY6v1zOTwvViOxPxfP8f/TptkjhoEfvd/zxI94QyosmHJZVEL
	+xVBaHOfaw9sUBatxz6ClxYpGstamyMXNUWzZGgs=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663680751671107.8225451013983; Tue, 20 Sep 2022 15:32:31 +0200 (CEST)
Date: Tue, 20 Sep 2022 15:32:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 03/11] Initiator: MSG_FASTOPEN sendto().
 request cookie
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-4-dmytro@shytyi.net>
 <e1e8bfbc5f3ba023e01354e62c4f3a28f69c0bca.camel@redhat.com>
 <7f09e484ec0d6068d62bca82d4ca907a09db64d5.camel@redhat.com>
 <369dc9a1-eb92-00d3-0447-81e5e017d728@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <732cccc8-55de-e08a-9cc7-5cf0132856ae@shytyi.net>
In-Reply-To: <369dc9a1-eb92-00d3-0447-81e5e017d728@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Paolo. Matthieu,

Please, check my last commit please v8 . It *fully reuses the existing=20
code.*

As from the beginning my misunderstanging from the received feedback was=20
that it is better

to not impact the existing TCP code and I was forced to create hooks and=20
reimplement some parts.


As from now I see clear acceptance from majority=C2=A0 of modification of t=
he=20
existing code (execpt of fastpath),

I prepared a patch v8 that is fully reuse the exsiting code at maximum :)


On 9/19/2022 1:22 PM, Matthieu Baerts wrote:
> Hi Paolo, Dmytro,
>
> On 19/09/2022 12:44, Paolo Abeni wrote:
>> On Mon, 2022-09-19 at 12:35 +0200, Paolo Abeni wrote:
>>> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> (...)
>
>>>> +=09skb =3D tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, t=
rue);
>>>> +=09if (unlikely(!skb))
>>>> +=09=09goto out_EFAULT;
>>>> +=09iph =3D ip_hdr(skb);
>>>> +=09if (unlikely(!iph))
>>>> +=09=09goto out_EFAULT;
>>> Use only lower case for macro names. Also EFAULT is probably not a good
>>> return value. EINVAL should fit better. More importantly, it looks like
>>> this check is not needed ?!?
>> Addendum: you probably need to add/duplicate the full checks
>> implemented in tcp_sendmsg_fastopen():
>>
>> https://elixir.bootlin.com/linux/v6.0-rc5/source/net/ipv4/tcp.c#L1174
>>
>> lines 1174-1180
> We discussed a bit about that at the last meeting and I think it might
> make more sense to re-use tcp_sendmsg_fastopen() like Benjamin did in
> his seris, see patch 2/10 and 3/10 from [1].
>
> I think there were just some confusions here: it is not forbidden to
> modify TCP code. Of course we don't want modifications for MPTCP
> affecting TCP perf, especially the fast path but here, it makes sense to
> export some functions to be re-used in MPTCP instead of duplicating a
> big bunch of code.
>
> It is not needed in our case here, it is more a generic comment about
> MPTCP dev but I think we can also say that if needed, it might make
> sense to refactor some code from TCP to export a part of it, no?
>
> Cheers,
> Matt
>
> [1]
> https://lore.kernel.org/mptcp/20220908133829.3410092-1-benjamin.hesmans@t=
essares.net/T/

