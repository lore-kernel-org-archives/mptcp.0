Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669956;
	b=m1sxqwjczIAe1i+oruUZlEkkmF4l8iBD8auvd5C71H8OIxUce6sCJWRV/n6BefLqdN4T
	 AgJjR14aGgprlFKGftRa4JO8/diPe/dnypcNyH5US/clflUMTErCut9OHF2waH4rlTLUs
	 UyLHFsCsqjezhFeFbkiNMYLKMIbR6QtN3lXN0St3s2qdMTj9yqncL2Cb7Auxe46HcTnrz
	 +2SCI1lAtM9B72BsPCxyaXvcEFAsQmlTKA4wBroQOQwvLdo4nsKt9QeB8gn2RnZxkvJ3A
	 8rCjYTjA//FTkKPMLzu+3OzTE4Rku5+Vx3Bkyxxb7INhMcAQt5Oa/MafAZuALOFiOig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669956;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HOxjTWq8USRbKf1NHRtOCVdwPDHFFHRlSbuWNNCvU8A=;
	b=qcxkNd9li8P9nxlb+AIQwu7OFKcRUkqs5/L3zjQk3E1pyBLpgm0wR0EBnMiusa7Lseuw
	 8vcINwve6jKSk8w6x8NV47Lt/O1qbtJY2/TrFtHgZ76Up07dh5Cm4f5FvOTjAchbPlC0X
	 jFwt5nnGd74kf5CURxVnk92AbvVRarOOqs2ciMWpmWL4bCtc8cqA0QTn3YMb3c6PLK7CO
	 uVBK+0oNNj6nxsbj5WWjQfriDpTPNBxQjg4sJZKahOXwx8TjI0YTvcFh9V7hRLMr3nnpE
	 CA4vglEOX6PwZNWK7WcgDJytOWMBm5LZtyFZxIKi2faaUQXGStzX+/pjBp/59Su4pWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uDfYp4CI;
	arc=none smtp.remote-ip=91.218.175.195
Received: from mta0.migadu.com (out-195.mta0.migadu.com [91.218.175.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA8606A326
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 01:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uDfYp4CI
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=HNSCS4mk/qPWR2K35tmQ3WR1yx22JuOv+/Tg+3LgkOQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793669952; v=1; x=1794274752;
 b=uDfYp4CIMXMT0YXcKpjF9YB3K5YdgLBw4c88NqUHwD/Lclmvn3GyDF3AeYlSAKjVzlZUoafv
 eeyU7b2yNVBPf6u3Uom/s9NH6qbZ1pAgOagbIhnxVGqmo6ypScxjhm6RO97oPf3OANgiusJem7v
 XjHbBbnFksp3s1WmK6Yr2+eM=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 6da7c6571af7a7ce;
	Tue, 03 Nov 2026 01:39:11 +0000
X-Mizu-Trace-ID: 6da7c6571af7a7ce
X-Migadu-Flow: FLOW_OUT
Message-ID: <c5a1ce12-2c0c-489b-840b-1cef8cda999c@linux.dev>
Date: Tue, 3 Nov 2026 09:39:04 +0800
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
Subject: Re: [PATCH bpf v2 10/15] bpf, sockmap: Reset the copy position when
 corking
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-11-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Chris Mason <mason@kernel.org>
>
> sk_msg_memcopy_from_iter() writes to the copy position: byte sg.copybreak
> after the offset of element sg.curr. Both tcp_bpf_push() and sk_msg_xfer()
> remove bytes from the front of an element. They increase its offset, but
> they do not change sg.copybreak when the element is sg.curr.
>
> tcp_bpf_send_verdict() can send a part of a message and keep the rest as
> the cork. tcp_bpf_sendmsg() appends new data to it. If sk_msg_alloc() then
> extends element sg.curr, the peer can get memory that nobody wrote:
>
>   old offset    offset    end of data     offset + sg.copybreak
>   | removed     | rest    | not written   | new data
>
> Move sk_msg_reset_curr() from filter.c to skmsg.h. Call it when a message
> becomes the cork, as the helpers that change a message do. It sets the copy
> position to the end of the data. Without removed bytes it changes nothing.
>
> Fixes: 91843d540a13 ("bpf: sockmap, add msg_cork_bytes() helper")
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

