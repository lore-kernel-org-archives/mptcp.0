Received: from mta0.migadu.com (out-109.mta0.migadu.com [91.218.175.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A012237F727
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610997; cv=none; b=qxB6Bb81oG8sB8FCIckbkMFee4otnpDYccPgyAHUUu4KGcp36vrL5NqU3NZ7ij2hEvcnipnzB1xsQtkSeIcpfsXkmnN9EJQPewzw0rPmw7Uwh2H6RGIXelw6TtRbpYbrKRUVYTQ6RRscsf4N4zTKSnkgzWpdgv/dsK6Z4GvyBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610997; c=relaxed/simple;
	bh=G5YjIweiS9XXUhSWSx9n6pTD6nW4PM+Yid2m9QScxs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT9XivIZGRUGLXh4F+9urh/EkCJJNrMavHKc5YeP9N3dbkHmRTFXwPnN3Hig6CInNq3qOAWAOYxec6o+17F4SU8ieNUOupMxDgsulMXzEDbgxDtJtHUlhZMV0EkA89rMP8uPFpjCniS3frbDjk2ITrW+ENvI8b4ANQIJHvEtL28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n3wneHCQ; arc=none smtp.client-ip=91.218.175.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n3wneHCQ"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=G5YjIweiS9XXUhSWSx9n6pTD6nW4PM+Yid2m9QScxs8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786610993; v=1; x=1787215793;
 b=n3wneHCQZg3pdJH053NfID7HKhQlXdLuHsWdL9kub34w77XIqF6FKMDsmQVXEWnPT5U6b5jl
 nbnEE8cO1JgEtnlomuDBK5cRKDwcKbvLKVx6F6GP+HAuFDS0ejpzIzn5p+0DdsvxuMsSpGapKZA
 tCHdasmMekUuuGXCw/xu45Vw=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.109.30] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 2f3656aaa98b4769;
	Thu, 13 Aug 2026 08:49:52 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <17b95ca7-c616-426a-a321-dd6bf62f88dc@linux.dev>
Date: Thu, 13 Aug 2026 16:50:01 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH export v3 4/4] mptcp: fallback to TCP on MP_FAIL with a
 single subflow
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-5-chenguang.zhao@linux.dev>
 <e9082cf3-6889-44b6-9e81-c2a2a21e8e9f@redhat.com>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <e9082cf3-6889-44b6-9e81-c2a2a21e8e9f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/12 18:47, Paolo Abeni 写道:
> On 8/12/26 7:46 AM, Chenguang Zhao wrote:
>> @@ -901,6 +898,12 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>  		subflow->send_mp_fail = 1;
>>  		subflow->send_infinite_map = 1;
>>  		tcp_send_ack(sk);
> Slightly unrelated... AFAICS the current code sends the mp_fail reply
> immediatally, and will send the infinite mapping with the later data
> send, if any.
>
> I *think* it will be better to send MP_FAIL and infinite mapping
> together. It should remove a little bit of complexity on the xmit path
> and will be IMHO closer to the RFC specs.
>
> /P
>
To keep both MPTCP options on the same packet, that packet would have
to be sent before FALLBACK_DONE: once fallback is done,
mptcp_established_options() drops MPTCP options unless the skb
already carries an infinite mapping.

tcp_send_ack() builds a plain ACK with no mpext->infinite_map, so it
can include MP_FAIL but not the infinite mapping. The infinite
mapping is filled in later on a data skb in mptcp_sendmsg_frag().
With the current xmit path those two options therefore cannot go out
on the same packet. Sending them together would need a dedicated
transmit helper that builds a skb carrying both, rather than reusing
tcp_send_ack().
