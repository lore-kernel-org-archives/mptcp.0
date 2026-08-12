Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509A8377EBC;
	Wed, 12 Aug 2026 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546038; cv=none; b=NdCNYQtgcTdVwPLdhjGt+S9kk1RLRIqxNzGfXyCwKP5G5u2nZp7e36LeiEou1Rhy5fZCd703cut/gH/tzx4JfuT8NhpO1kGmzTOCvD8vqXhpUQVdJBG/Cb5gIHIaA5wO75gjynOg5jpOayrRpzCP591KiyPVeTI/2Qtim06qRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546038; c=relaxed/simple;
	bh=idFfQ1Np9CR7Be2S3SG7/hunKNDtOHIL0QF2bgyr2+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcewEo1fOG8BIWoKRpV9HFSmsn9+sKbjddkh3Nud7lxH/yBboRoTve4/ecI4pfoMd/J/XXKgpNBQQnPD5XXUqqQXhv6Z894kg+PyFG/1jODqqlAQqNjru0ZEpEzWAX/2YysMWldIAnbFJkYa19lk+9sTMGkT31bZMdeuTtTNH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8n0Pcay; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8n0Pcay"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79981F000E9;
	Wed, 12 Aug 2026 14:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786546037;
	bh=n8ttIAcsLaVvlpTfKGqk/LRV0RbRzLGRHafBM6VGeh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y8n0PcaytkNKrTL3Njhih0pXxQHOMo6gU+PNKGlBq9r+1jXGfKylMQAkIfc8lqUtb
	 +BDUk6t6e9fUIXgKzrB1LYqDntrE+ZMtqNkxxeiSmh283mbf3occBpGN9Tl5EOLzBJ
	 zF5NGumSYMN3tSM4sscVLJ+IPuquQ9k5G+uH67k8QgAdVxg5D8LLzSe6sWh5kRBjHW
	 zg1ZmiUg9rENg4CVVp2Z5FDiRlfWLLQ/YtKHzPnyD8KSpLcA9JVuUysbqvL7uIFpnb
	 olb9Jd4wiSwHbL6meKQ4uSv85+3X6Rd0+96gVWVrt7RD8QIRJizZc0GmtBBqS7tWVx
	 05FPQvfnEOE4Q==
Message-ID: <dc89cede-57ef-448e-96f8-e8251d9007ec@kernel.org>
Date: Wed, 12 Aug 2026 16:47:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v3 7/7] mptcp: implemented OoO queue pruning
Content-Language: fr
To: Eric Dumazet <edumazet@google.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 Gang Yan <yangang@kylinos.cn>
References: <20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3@kernel.org>
 <20260807-net-next-mptcp-oooq-pruning-v3-7-dbc1eb853cc3@kernel.org>
 <CANn89iL-rnJtxVxJEf3j0PX3X8A04vsf-XXQvb-_FyjMBBM5nw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iL-rnJtxVxJEf3j0PX3X8A04vsf-XXQvb-_FyjMBBM5nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 12/08/2026 13:39, Eric Dumazet wrote:
> On Fri, Aug 7, 2026 at 3:50 PM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> When moving incoming skbs in the msk receive queue and the latter
>> is above limits, prune it as needed quite alike what TCP is doing
>> at the subflow level. The main difference relies in the stop condition:
>> since MPTCP does not perform collapsing, it's better off dropping the
>> bare minimum to fit the (newer) incoming packet.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Tested-by: Gang Yan <yangang@kylinos.cn>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2:
>>  - Uniform the new counter with the other OFO ones.
>> v3:
>>  - prune only for new data
>>  - reorganize the code to follow more closely TCP
>> ---
> 
> ...
> 
>> +
>> +/* The stack can't drop packets for fallback socket at the msk level, or the
>> + * stream will break.
>> + */
>> +static bool mptcp_can_ingest(const struct sock *sk)
>> +{
>> +       return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
>> +                       __mptcp_check_fallback(mptcp_sk(sk));
>> +}
>> +
> 
> This unlikely() seems inverted.

Thank you, yes it is!

Paolo already told me that before I sent the v3, but it looks like I was
in an OoM state, and the pruning was a bit too aggressive on my side...

A follow-up patch will be sent soon.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

