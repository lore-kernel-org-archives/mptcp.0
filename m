Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755942;
	b=BZB/mMAY6Bdmtlh0YACbKN2keH1uKRYWMysQe9Mz7GTh/4e2oN56nvkOqEzi17jyHP+w
	 C7fIWEGX1Q2Gr5E3OOLmOwyu90jf8ynSaqDyK9BPOaYKJMgew6I2YtOdA5kApEc844ekm
	 e/5Petq0h7lJEQ72q4vKs8xNN9fei77QFHyOonKFwwxLpI0D1QkZxSMw7nJeunjp0KEp3
	 4xXxzcrzLbQ8mUQbcZ5JSziotL8LCDsh6QOTzObOL0O9QyKWVFw8/ZMdu/7Oss8mKppju
	 n82FmfX+yZuhfBGwKwpVde85Sc+YcaEYjnnGGm+TSDhwGvA7TWk3cZEvFJqKE1Sz+2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755942;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ImYOFm0MAebhNTUFGXynzS2XV7CBueaLVN4xxynXbUk=;
	b=5LEIijFvdE1uVfkrlf9CNNWX/OLXCVhk4wrNaPAPtzqjsAoPNHNO8bycumyQk3p0jk7f
	 n90AiJ/9ECSu5wnRiW+ZUYeK6x/1YghTvPYWMElcRpZFBuDJCdTXPECxy4LKMV4yXwJYw
	 ksuFugkmXoSgeYpwSww8hOvDC7OgbiXNnLpTMitLL34Vs69nkN3jug38UIf0nEf2vj7qa
	 qidXj8+eV4Ad/KKlx30KAXkcEAexs7SHxlbypBxFsWGx5hgO7nLxKACINm9Aji2pDPyW4
	 RYLYsQpSv+y3E10AiN0t1KLX0Wc/6yFnd5in7hdRR9QKREIkzTwP3H/xiv+t91Ghlvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VbTK68bA;
	arc=none smtp.remote-ip=95.215.58.117
Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334E606A326
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 01:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6334E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VbTK68bA
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=5LFImwIEYpEcOncv7J6XZb3AJW0OuTI7OHxkKVrqaDI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793755939; v=1; x=1794360739;
 b=VbTK68bA4KdqM/Jksd9s8OaycW5DtBsby1SFHwE/jmfZxw9/zBYXT3fIZif/Ocp86wqCrCsQ
 o4RGViSN6gxyzv/aGencVsPEYy3CSvloSPjBI0PnKszuL47cmyrCXkg95/vdsrN9jkJVkaXA9Lr
 RJAIFBrdkB7lEwML7TBJ4AqI=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id c146b8be300003a3;
	Wed, 04 Nov 2026 01:32:19 +0000
X-Mizu-Trace-ID: c146b8be300003a3
X-Migadu-Flow: FLOW_OUT
Message-ID: <4d3b8639-a313-444b-831a-f1f069882b86@linux.dev>
Date: Wed, 4 Nov 2026 09:32:12 +0800
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
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 netdev-bot+sashiko@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
 <179374187706.488855.8366350890804573396@kernel.org>
 <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/4/26 8:28 AM, Alexei Starovoitov wrote:
> On Tue, Nov 03, 2026 at 01:37 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>>> +		if (!psock->apply_bytes)
>>> +			psock->eval = __SK_NONE;
>> When psock->apply_bytes is not 0, eval stays __SK_PASS during the push.
>> The budget is still debited only after tcp_bpf_push() returns. Can a
>> second sender on the same socket still get past the prog here?
> Yes, as today. It's already explained in the commit log.
>
>> But B's message is sized against the budget before A's in-flight bytes
>> are removed from it. Would it be better to reserve the budget before the
>> push? That means debiting tosend, and ending the verdict when the budget
>> reaches 0, before calling tcp_bpf_push(), instead of subtracting after a
>> failure.
> No. That breaks the single sender. After -EAGAIN the verdict has to
> cover the bytes that the push didn't send. A refund after the failed
> push can land on B's verdict.
>
>> The shared-cork problem with two PASS senders already existed. The kfree()
>> variant used to need a third sender to end a byte-limited verdict. The
>> early reset makes it reachable with only two senders.
> yeah. It's an old bug, not from this patch.
> Two senders are enough today too. B's first message goes out with A's
> verdict, and the code after the switch resets eval. The prog runs on B's
> second message. SK_REDIRECT frees the cork that A still pushes.
> The log of patch 13 says that a cork is not safe for two senders.
> Jiayuan proposed to serialize the senders in the reply to that patch.


I will pick up thoes pre-existing issues and organize others reported by sashiko.


>> With the early reset, can sender A's bytes be charged against a verdict
>> that another sender installed?
> Not a bug. eval, apply_bytes and sk_redir belong to the socket, not to
> a thread. B's verdict ends early and the prog runs again for the rest.
