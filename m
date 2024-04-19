Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26C3D961
	for <mptcp@lists.linux.dev>; Fri, 19 Apr 2024 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523070; cv=none; b=YE7XWo7pJzjJ+2DrBbUJ7m9EkVLEU6Z+ue7Uv4R3e6wB503wBk5SjkVcwTIA0LKCam8Xe31DGODpTcJgy3YhmxWq5ZDDcDP8LlkBIy4AxQvwg3d5q77yn3DumdB5r7MyVMuVQlUdA5BGcx0bKWNeGI2l93aTHnS/21AGVi3dpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523070; c=relaxed/simple;
	bh=fgfkERYMJXhfIA+0/GgWHuyzieX6yt579/ql8g6IYEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtVNXtTQ5sftBhfm9xXMJbwvORwGUodJsyIVnNhpg/IYGOFwT55AmTDk/sxYBrCp9QA5aSTahvf8TDu211FyJqRG78yX32cjkWrBmeSECOAmjOIEIVbIbBXpOcXfd9+woBXjO4ZFheWF1eiP1z+sLKyi26FwLrTSdfMgrETAR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBDDF2+n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBDDF2+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7A6C072AA;
	Fri, 19 Apr 2024 10:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713523070;
	bh=fgfkERYMJXhfIA+0/GgWHuyzieX6yt579/ql8g6IYEc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jBDDF2+n59IHtBgrTyVPuhZp3stL9qO6+oDKFRWf093yNK0Uta0SDlLNOXuKati40
	 NAMAIzfA4jvQCJXcvSDehfZoJ4fFfj7jUUkdVkJCKu6dG1yr8Su7AkWSx5w1zp1sRp
	 SbQmDVip/Rqs0szeQJhl10y2luiNwwl8Tb9tS2MW0CJeFVMvOM8NqUydbtEkNHrjv2
	 JyBVom+ur21PbBD9nRpt22bvy4Mq5qMgiSqcNk4RBCyhDGJU6KQzWwzjSD6DJGbDf4
	 vpRnGqsiRphGzpxQksro3OsCoUg67B8XqGW9V4FgTJ+P/2M5B5qKQUmVP8NFTQ2Q4U
	 L4IykjKBw0Dcw==
Message-ID: <00035fe7-143e-400e-84cb-61d3aaca9f34@kernel.org>
Date: Fri, 19 Apr 2024 12:37:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3] mptcp: ensure snd_nxt is properly
 initialized on connect
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
References: <3b0ca23eaa8906f967a841f55bafed48d0f895cb.1713367699.git.pabeni@redhat.com>
 <422a4453-7344-e5dd-342f-577baa9743b0@kernel.org>
 <489104fb63bdef5493a179ee84058cb8aa11c9f2.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <489104fb63bdef5493a179ee84058cb8aa11c9f2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 19/04/2024 12:33, Paolo Abeni wrote:
> On Thu, 2024-04-18 at 09:59 -0700, Mat Martineau wrote:
>> On Thu, 18 Apr 2024, Paolo Abeni wrote:
>>
>>> Christoph reported a splat hinting at a corrupted snd_una:
>>>
>>> WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
>>> Modules linked in:
>>> CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>>> Workqueue: events mptcp_worker
>>> RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
>>> Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
>>> 	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
>>> 	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
>>> RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
>>> RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
>>> RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
>>> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>>> R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
>>> R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
>>> FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
>>> Call Trace:
>>> <TASK>
>>> __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
>>> mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
>>> __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
>>> mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
>>> process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
>>> process_scheduled_works kernel/workqueue.c:3335 [inline]
>>> worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
>>> kthread+0x121/0x170 kernel/kthread.c:388
>>> ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
>>> ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>>> </TASK>
>>>
>>> When fallback to TCP happens early on a client socket, snd_nxt
>>> is not yet initialized and any incoming ack will copy such value
>>> into snd_una. If the mptcp worker (dumbly) tries mptcp-level
>>> re-injection after such ack, that would unconditionally trigger a send
>>> buffer cleanup using 'bad' snd_una values.
>>>
>>> We could easily disable re-injection for fallback sockets, but such
>>> dumb behavior already helped catching a few subtle issues and a very
>>> low to zero impact in practice.
>>>
>>> Instead address the issue always initializing snd_nxt (and write_seq,
>>> for consistency) at connect time.
>>>
>>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>>> Tested-by: Christoph Paasch <cpaasch@apple.com>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/485
>>> Fixes: 8fd738049ac3 ("mptcp: fallback in case of simultaneous connect")
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> v2 -> v3:
>>> - init snd_nxt/write_seq instead
>>>
>>> v1 -> v2:
>>> - moved the initialization at established time (Mat)
>>> - dropped debug code wrongly landed in v1
>>> - added fixes tag
>>> ---
>>> net/mptcp/protocol.c | 10 +++++++++-
>>> 1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 3e1b15d76442..4205cef2d45f 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1002,8 +1002,13 @@ static void __mptcp_clean_una(struct sock *sk)
>>>
>>> 		if (unlikely(dfrag == msk->first_pending)) {
>>> 			/* in recovery mode can see ack after the current snd head */
>>> -			if (WARN_ON_ONCE(!msk->recovery))
>>> +			if (WARN_ON_ONCE(!msk->recovery)) {
>>> +				pr_err("sk state %d:%d snd_una %llx write_seq %llx dfrag end seq %llx frag len %d bytes sent %lld acked %lld",
>>> +				       sk->sk_state, msk->first ? msk->first->sk_state: -1, msk->write_seq,
>>> +				       msk->snd_una, dfrag->data_seq + dfrag->data_len, dfrag->data_len,
>>> +				       msk->bytes_sent, msk->bytes_acked);
>>> 				break;
>>> +			}
>>
>> Hi Paolo -
>>
>> You dropped this debug code in v2, do you want it included?
> 
> Nope, it's there by mistake. @Matttbe: could you please drop this chunk
> while applying the patch or do you prefer me to resend the patch?

No problem, I can drop it when applying it.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

