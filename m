Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671112;
	b=D/U8lL4nwnM8d4crnXAAhDSCuRU1OyxHGGJ6yQKxZ9BerfxgWBgM7lRGCzXzlO+c9M7/
	 BZ+FEC+E6ZzVMgZxo6oInKORZu7U9QxCEPg9Ex1NsKNX7JH5qbrM+ZyQK/n6Z9qAgg76Y
	 jnb/0kV/vJB1WbYSGW3cIOQqLGk/l20Fj/NrzvYK3cKJXLLBYlXGy564vh/xNZRWhpr8w
	 Xh9XkCVu2PFE271NeyojOPOWEOCzNok8zH5q8dqxKitHfwr8KZVlaY0kTstgGd/Vq+JoN
	 qMpYcASw7A6NF8vxp722OzheZ+gE9/MHpYxSl7B/ujkv1rhAzxofvb3FANi3b0jOIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671112;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HvlT1XjrX2pqFLgxdO8FZhy56kYrtx0Ju6Likqq4/Is=;
	b=ZqYDSmHoE187NzWrlghLcbvbdCZ1E6Zx37gVZX8CRXUlgNzjJoRZO3F9yd0S4yITYv+7
	 Xe8F7VR9SIZOyVyWFKKlI+koypSNC9+J+7SSEagbvlbCt6Mv3oT9Hcm1cpUB9Cpjsy7y1
	 3rD4FS1yji3F16FKVSSC4rPdQ6zh4/NCl1GBJJQi1FFTfhzfju6nLhuB554dsfjPpIABu
	 033mEW2TG3ep52ADCpsOHEiQd8fd33Fw2PUVVmraDNTv404/nXdaA084AU9+P/29m3fS+
	 seiXq1CzkAI4WbveXfnxAVnI3p1wYpYhr3OhZQSOj2Lf6simZZ6/V0k3qa3SyVuQnbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uRZEuZB1;
	arc=none smtp.remote-ip=91.218.175.130
Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F1606A327
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 01:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC8F1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uRZEuZB1
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=HvlT1XjrX2pqFLgxdO8FZhy56kYrtx0Ju6Likqq4/Is=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793671108; v=1; x=1794275908;
 b=uRZEuZB1MIG+JrUSRpHgvgMdk2c68Q9U6xzmblMOr/qBg6NjJznPDDiqjHT9QLEmfwar2v3n
 7JcO1hG+c2oycIWr7EgKcKhD0yqkJ/ednaDBOvX3pKSLezw/Vj1plVphB51YGhB68zvNGRG6Fmd
 gSVFl3JRUETARJpNkcEzjjkA=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fa320ababef1ed04;
	Tue, 03 Nov 2026 01:58:28 +0000
X-Mizu-Trace-ID: fa320ababef1ed04
X-Migadu-Flow: FLOW_OUT
Message-ID: <9d684932-998b-4f78-a445-79f07523d600@linux.dev>
Date: Tue, 3 Nov 2026 09:58:17 +0800
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
Subject: Re: [PATCH bpf v2 12/15] bpf, sockmap: Clear the redirect target
 before the sk_msg prog runs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-13-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> bpf_msg_redirect_{map,hash}() store the target in msg->sk_redir, without a
> reference. After the prog has run, sk_psock_msg_verdict() makes SK_PASS a
> redirect if this field is set. But tcp_bpf_send_verdict() runs the prog
> again on a cork, and on the rest of a partly sent message. Nothing clears
> the field between runs. Thus SK_PASS without a new target is a redirect to
> the old target. If that sock is already free, this is a use after free.
>
> Clear msg->sk_redir before each run, as the skb verdict paths do with
> skb_bpf_redirect_clear(). Only SK_PASS without a target changes. It now
> sends the data on psock->sk. Then sendmsg() can return another value. A
> redirect that applies to more bytes uses psock->sk_redir, with its own
> reference. The counts msg->apply_bytes and msg->cork_bytes stay as today.
>
> Fixes: e5cd3abcb31a ("bpf: sockmap, refactor sockmap routines to work with hashmap")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

