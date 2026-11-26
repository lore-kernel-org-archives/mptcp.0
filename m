Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703529;
	b=Wh+g4/fK2qif+Nit2wFiKRGGdBLdzPKnhmjteiVAmzULLy+PhaCXEOnjQnMtDpc+22Ik
	 e41hPvG6tq124zL7+wekPQgZqYoXd+WjnmJgPFI5QfSoxj52j/Fs2RBXj7JpQdRdxqkrT
	 kgQOQ2mQl9mNqsXHNl3NDZvWxBsVYyXBT8tXMho8bLVCjHoy4MuMiEexW63+O8j9Y1oS8
	 KyqY+GugxcWviEFsAXRJhZ3dpEVtpeMaYokrvYy5+kLghV6muGY9OIx1mxPItMeCW2bfB
	 1l5Vw1XXNpevMJ0jlNA9jMjej+mDOuXLMV8zVIavewPSTImJWLmFhqutK9VsTB47rhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703529;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=wPzmjdGQDhaVZKR6eg682hzMxJin6Qounz2geCrdUcs=;
	b=gIrPtht/7REHuYYuyf2qrWeIpDBqheTqmhmH7JydKHLRxSdLbXq6YeE3WJn9rZ/4JQV4
	 JyrpWyVIXvrx4u+IGzhi+8gYAaS7vcTRl3haH9Z94L4iC7Ex10XLQUlCoij+GTWd3y5S3
	 uDfvYpSH8+jhrbbniHTktv0mz1ocmS7/rTkDyfqQ44QzY+GszAofp8XZ4E4eOGfh8WUxW
	 WACkhIjwSz0hk0qaI7PCqnXyHYCTUbxq4Qph0+BwM6+Ud83Ws2EAefMK2S/e6ChOWhNeH
	 G5Xilk+ihkuXEWdfrdP8/vlyVDktH+rw5uO6cskT9AVMrajwTWYgSc7uUsplcs0U0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5G0m7Ub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A6606A685
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5G0m7Ub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5201F000CF;
	Thu, 26 Nov 2026 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703528;
	bh=wPzmjdGQDhaVZKR6eg682hzMxJin6Qounz2geCrdUcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l5G0m7UbBBLiG/jthB83RR2swIcC1SKWf9yJE5pecE1bLTZfixIPo53H5t4KikWCu
	 bgFfdGO62FEo4tHkTlMNwdBGvW6cpe4hizlDhqdap2qR6gjmcaPU9LuGo/12qFsYH7
	 F0xebAgd+WmJGUPxbrGfvawv/Z3CNJWuYONDPAjWk2L0aaCJ6l53ZUGBOHhKPHxgZb
	 GRAkbnMTkOvtW907bDv5Cml8QYrU9LIGG7dHDuYgb2bi0IFlNfNTJBtT7pioJ3ylXR
	 sqGdfjNgpNM64hMU8BRGq0LmzVM9jtO+UNygTyHXPn7q/7NnT64X+poOQb6Nzqpzfw
	 +OJ18oPpQCqSQ==
Message-ID: <527e1d5d-29cf-4fa4-9d0d-067f5ebed443@kernel.org>
Date: Thu, 26 Nov 2026 15:32:06 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 33/50] mptcp: don't charge a shared page
 twice at accept()
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Chris Mason <mason@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-33-416c0920c73f@kernel.org>
 <6e1bc879-784e-5115-fa6c-0365182929a1@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6e1bc879-784e-5115-fa6c-0365182929a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the reviews!

On 26/11/2026 03:20, Mat Martineau wrote:
> On Tue, 24 Nov 2026, Matthieu Baerts (NGI0) wrote:
> 
>> From: Chris Mason <mason@kernel.org>
>>
>> accept() of an MPTCP connection that has already received data can leak
>> one page of memory cgroup charge, and the leaked charges can get the
>> server OOM killed.
>>
>> At accept(), __inet_accept() charges the MPTCP socket (msk) for the
>> memory that it holds, rounded up to whole pages, and
>> mptcp_graft_subflows() does the same for each subflow. A page is
>> uncharged only once, when the socket that holds it releases it, so
>> rounding up each socket on its own is only correct while each page
>> belongs to one socket. But for each skb that the msk takes over from a
>> subflow, it borrows skb->truesize bytes from the pages that the subflow
>> reserved, so the two can share a page:
>>
>>    reserved by the subflow      4096 bytes  1 page
>>      now held by the msk         896 bytes  charged for 1 page
>>      still held by the subflow  3200 bytes  charged for 1 page
>>
>> The fix used here is to keep a running sum of what the msk and its
>> subflows hold, and to let the new mptcp_charge_subflow() charge each
>> subflow only for the pages that it adds to the rounded-up sum.
>>
>> This issue has been found with the help of an LLM, and reproduced in a
>> VM, with the reproducer shared with the original version of this patch:
>> an MPTCP server in a memory cgroup, the first byte of the client
>> arriving before accept(). Without this patch, 4096 bytes stayed charged
>> to the memory cgroup for each connection, after its end:
>>
>>  SNAP label=after-1000 rounds=1000 sockets_left_in_srv=0 [...]
>> c_sock=4096000 [...]
>>  SNAP label=after-5000 rounds=5000 sockets_left_in_srv=0 [...]
>> c_sock=20480000 [...]
>>
>> With a memory limit, the original version of this patch reported that
>> the server was killed by the OOM killer after about 14,400 connections.
>>
>> Fixes: 9db5b3cec4ec ("mptcp: borrow forward memory from subflow")
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> [ Shorter comment. Commit message: how the issue was found, and its
>>  symptoms. ]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Note (Clashiko on v2): the backlog can still be charged twice here: this
>> is fixed by the next patch.
>> ---
>> net/mptcp/protocol.c | 21 ++++++++++++++++++++-
>> 1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f8cb585da0b3..504fe4a9954f 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -4664,10 +4664,26 @@ static int mptcp_listen(struct socket *sock,
>> int backlog)
>>     return err;
>> }
>>
>> +/* The msk and its subflows share pages: charge their rounded-up sum */
> 
> I suggest adding a note that this is similar to __sk_charge() (to make
> it easier keep the two functions consistent if either has future
> changes). But otherwise the patch looks good.

Good idea! The v4 will contain:

/* Similar to __sk_charge(), but the msk and its subflows share pages */

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

