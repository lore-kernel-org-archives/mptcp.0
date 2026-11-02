Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608338;
	b=aLyTBHQzOGSzI+vmOhBWaFylc5f7HO/AzFo//L4GRJcFTybNyo8naZKgVqLECafNVOfw
	 I9oQKpmPKTt8D1D/wKfJOPErDnkYYhgr+2lfptbeyPXn7G5md851sgaSmfihk7/MuGcnZ
	 W21HhXTCGGna7FtvKzzsJtpeQZkYd4FFImsYac/FmaiztC9+Z7JQ8jm7pGI0q3kwSfBzD
	 lXLmj+mNe8cfn3kTkPsBLLfXL5a3ohL2e2jqK5iJcBNUZb8/Qp3zh3T7EgbNQjsY4Tg2G
	 nimh7kT4WDgk4q8Rtj46shftyihip79IxnXPnoExvNCfnTI+kseGp1Z0zP7/b+RUi0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608338;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IYreqHUz2HQR2AUBnBbZcSxaTUlKTzbRYKcUs5sJV1I=;
	b=U5sv+BOWwoeB0sQlqXufGl8RwGTpzXdnei0A1xlbHgdQn0L4J508PITnaGyWzNyQSPv/
	 lk0u2kpujga5FD7MEmrIrGXWllgx4Bwd6s6advatyZmTHY3bZAYRSF+BzlPW3TTVuZOY7
	 5dNKEd2NgsQDg2T11pIVTA4xNYTrgEx/p03f1579Nb2ayAYvkRBUtJspoHXXlah4rNlck
	 7sQ6gog+R3dnnj1TDiJ6MO7ozr5OsQf76RhqAFIRrOyd19hN5FrQw8BFteJc2jJeB397/
	 Gxixt5+3DLQ5BUx2LH5C4TJK9FLDcY02QIXU0QI35BSWGkurTy5qVXMx0NDRxTk0R/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ds6Fln3l;
	arc=none smtp.remote-ip=95.215.58.80
Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24A606A331
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 08:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C24A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ds6Fln3l
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=2P3ROvsM82yhJ2gGF+tSdLtq7UlfUDARI+FzX4vCWJI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793608335; v=1; x=1794213135;
 b=ds6Fln3lPjT2pVFkMVnpUW34VbSJu7/oKSYKMxWcrvJaNQo76xr+hiufxkXcSqUoTUEkMj8O
 ro0gdx7xJwPcmy9yAEmjqY2USKm8t0zf0IsIg4uTgtFu1jBg7/ScKiPTaD6og7gW1ZUZ70KwqwA
 IgpXOTJSHz7jNKictxCdyGtg=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 884a5ea4713e1463;
	Mon, 02 Nov 2026 08:32:15 +0000
X-Mizu-Trace-ID: 884a5ea4713e1463
X-Migadu-Flow: FLOW_OUT
Message-ID: <1d0cce30-28d8-43ee-b6b9-12e2660d4992@linux.dev>
Date: Mon, 2 Nov 2026 16:32:07 +0800
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 01/15] bpf, sockmap: Write sg.start when recvmsg()
 faults
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:20 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> __sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
> sg.start. After a full copy of an element it calls put_page(), unless an
> skb owns the page. It handles 0 copied bytes as a fault. It writes the new
> sg.start after the loop, but not when copy_page_to_iter() faults.
>
>   element    0: length 0, put_page()   1: fault here   2: not copied
>   sg.start   ^ today                   ^ this patch
>
> Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
> user cannot read the rest of the data. sk_msg_free() starts at sg.start
> too. It calls put_page() for element 0 again and can free a page in use.
>
> Write sg.start in the fault path too. The commit in the Fixes tag removed
> this write. Do not write it for MSG_PEEK, which changes no element.
>
> Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

