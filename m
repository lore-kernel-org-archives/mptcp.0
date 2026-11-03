Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672740;
	b=GgQKkDCWqwtfPuQ3dlvlwxP1foB4vm8vwxjinw4P93bmED9NwwqtztR1mfAjhXUPNGg4
	 7+ZgkVUoLi0t457nJ+mdoMJ8pyMTHwekmCoheL3pN2WuD9N3L3SApEPuPNkFMkl+OIL2o
	 ec9Z8jip1cGpIbx+yaHxyz1ooVhRDsBqmvZs+LLjek273QNJ0SoXEg6GC1Rnd8c5mQxUL
	 HHZchHyp6lE7sccXXE9IIWZWK4dfuUGZnFW2H3LSFRWfbxyuj0oQqnbRjnogqGt27FEgW
	 woqFUCiCtnEibWD68vSNsQB0C3K6uusPgHSVGt/vTjxJhAsr3HLZ2NBe2gGXOYE19Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672740;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IvOE97nqCYOuKLVpMLw0btVRPz7o5pR9mipwEI05Wt4=;
	b=U081e0Es3Ky3RbUHvm1ma36YS2RoTsrHPUReFKB2OcrjKxm/RDMI4wHxrDPnztH2FMP6
	 yU9dOw6XaSbUT1P5u37l+9TOUMHRY7fLx7yIlNTYtSswpWBZge6yxa4xocRvv6rFaQrUp
	 pcYhtGlx5IxJa/+Qc/SSQytR9GyLlRtIOnqalHv0v7HJQ4L8ukZOYOoWCUDGSu1i8uISx
	 VrYs+uGSGMbr5f3QLztxKv78aYRkeW+lF7phGxxjAcNKWL9nq/KBXHbK8hMNnDh03e3w+
	 uhstHTmMiSdpgxZNpKpQT54EEVzdD/kYIUpnNUp7zqui8NaLVzDoU6O4xjowppqchwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="I5SSa/hB";
	arc=none smtp.remote-ip=95.215.58.133
Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD5E606A327
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 02:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AD5E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I5SSa/hB
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=IvOE97nqCYOuKLVpMLw0btVRPz7o5pR9mipwEI05Wt4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793672736; v=1; x=1794277536;
 b=I5SSa/hBkeH/5TPTeuN4X07ju8nimjMubtSxy3YDqbsZhEDXwfvyXC6MLzr5m+4WTeH6YWl1
 5rQ6R5/95ZCsT+JnqTUDRVVFWUMFrFnuCiHacr9bTC82WWKt8l09zoQx9sGf3T36x3UNzzUPRwl
 x1p1nzzCBuYxH7Fp8cytOjlc=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 736ecbeae81c178a;
	Tue, 03 Nov 2026 02:25:36 +0000
X-Mizu-Trace-ID: 736ecbeae81c178a
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc5a153e-f1d8-4b2f-a1ee-646ac5d8d8e4@linux.dev>
Date: Tue, 3 Nov 2026 10:25:24 +0800
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
Subject: Re: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork
 after a redirect
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
> Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
> sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
> the message is the cork. It removes the cork from the psock before it
> releases the socket lock. After the redirect it frees the cork together
> with the rest. Thus the rest is lost, and sendmsg() reports it as sent.
>
> If bytes remain after the redirect, put the cork back into the psock. Then
> the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
> or the push fails, sendmsg() now returns a smaller value or the error.
>
> msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
> psock has a new cork after lock_sock(), the kernel still frees the rest. If
> the redirect of a cork fails, sendmsg() still returns success and frees it.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

