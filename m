Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3382F87B;
	Fri,  8 May 2026 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778237202; cv=none; b=uz1pyI3aGOvAembJ/ZWTSkTKxmUfbBP4ng4PSw622J01M5lDjkOcH5lUi+3SlJnloPNyNrVVuId2pZWB46EDDxhLZj6rFtHaoemlwPjSL0qPJjw4bmvqJzAXc3tcPfMZ82CvpLEC3cVU3/SnZxN5AthAek5yCppo5RLCxq/A3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778237202; c=relaxed/simple;
	bh=xf6BGLSfRGHCKfcnkN3d0PQtyTozP0RjLq6vHzEGdiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if/mN7QnbdvtFscnlUQalPkw0yaNkAwXPp3KgoElPVgl9JCC+SPQ5jwwjTQbwpefPhT8QFEuhBqLHkkrioA3ZEeLWcuLvsmxgFhnRmjt2sxFVVwF5N3Uh/En8vre5rsrWncGrYiNj3Ud5PgKQmFnxAKfky56zLYU4QP+LLe80yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXojbh09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXojbh09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF89FC2BCB0;
	Fri,  8 May 2026 10:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778237201;
	bh=xf6BGLSfRGHCKfcnkN3d0PQtyTozP0RjLq6vHzEGdiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NXojbh09MBN0F00EIlOJ7aNjEaicIcQ4nUbOEJzpMiblzunAcWr0c8RtpMOG+uXPh
	 qXH7DGZD1xCGMUysWVkC2X8iWf0s4yqWNepZGYcZd3MlOgA+abtOS9327IzRidpOin
	 dBsJZequpdXOmJiuJRu1RnWjANDl0mzaluk33cuZpHiLGHTEhONH0nQgGSOEMdGLzT
	 IGKqI6W3S7r8wjVe0JueLP5L2wmZ5nCg0lDL/Bt1spMuE3wmXRTNm8cCStDb4p8TGw
	 ov4HVJL6YARcw3moivN8V2JMnPk8eYTxU05ctUabYlbQTP4N65+ohgdm/imr/SmeIK
	 GSMqUwYeagj5A==
Message-ID: <43a84c8c-0d65-400e-b735-76210af4cddb@kernel.org>
Date: Fri, 8 May 2026 12:46:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in
 mptcp_established_options
Content-Language: fr
To: Alexander Potapenko <glider@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: kuniyu@google.com,
 syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <69f8e352.170a0220.bb392.0005.GAE@google.com>
 <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
 <CAG_fn=Ud-sXzebnwvsiwnu6e0uOHRAFzmUH91Du9pek7Fsx5bA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAG_fn=Ud-sXzebnwvsiwnu6e0uOHRAFzmUH91Du9pek7Fsx5bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexander,

Thank you for your reply!

On 08/05/2026 12:11, Alexander Potapenko wrote:
> On Fri, May 8, 2026 at 11:27 AM 'Paolo Abeni' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
>>
>> On 5/7/26 9:44 AM, Matthieu Baerts wrote:
>>> Hi Paolo, Kuniyuki,
>>>
>>> On 04/05/2026 20:20, syzbot wrote:
>>>> Hello,
>>>>
>>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>>> KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt
>>>
>>> It looks like the issue is different now:
>>>
>>>> =====================================================
>>>> BUG: KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
>>>>  irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
>>>>  irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [inline]
>>>>  irqentry_exit+0x7b/0x760 kernel/entry/common.c:164
>>>>  sysvec_apic_timer_interrupt+0x52/0x90 arch/x86/kernel/apic/apic.c:1061
>>>>  asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:697
>>>>  kmsan_get_metadata+0x17/0x160 mm/kmsan/shadow.c:125
>>>>  kmsan_get_shadow_origin_ptr+0x4a/0xb0 mm/kmsan/shadow.c:102
>>>>  get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
>>>>  __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:93
>>>>  tcp_data_queue+0xdc/0x7c90 net/ipv4/tcp_input.c:5589
>>>>  tcp_rcv_established+0x19bb/0x3200 net/ipv4/tcp_input.c:6656
>>>>  tcp_v4_do_rcv+0xc4b/0x1b10 net/ipv4/tcp_ipv4.c:1852
>>>>  sk_backlog_rcv include/net/sock.h:1190 [inline]
>>>
>>> That's the input side.
>>>
>>>>  __release_sock+0x360/0x7d0 net/core/sock.c:3216
>>>>  release_sock+0x22d/0x300 net/core/sock.c:3815
>>>>  mptcp_subflow_shutdown+0x358/0x690 net/mptcp/protocol.c:3144
>>>>  mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
>>>>  __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
>>>>  __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
>>>>  mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
>>>>  inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
>>>>  __sock_release net/socket.c:722 [inline]
>>>>  sock_close+0xd6/0x2f0 net/socket.c:1514
>>>>  __fput+0x60e/0x1010 fs/file_table.c:510
>>>>  ____fput+0x25/0x30 fs/file_table.c:538
>>>>  task_work_run+0x208/0x2b0 kernel/task_work.c:233
>>>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>>>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>>>>  exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
>>>>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>>>>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
>>>>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>>>>  do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
>>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>
>>>> Local variable mp_opt created at:
>>>>  mptcp_incoming_options+0x11d/0x43b0 net/mptcp/options.c:1171
>>>
>>> Confirmed here. With "struct mptcp_options_received" while the original
>>> issue was with "struct mptcp_out_options".
>>>
>>> Plus I'm not exactly sure to understand the issue here: mp_opt is
>>> defined and used only in mptcp_incoming_options(), and I don't see
>>> anything using it after the end of this function. Or did I miss something?
>>
>> I also had hard time understanding the backtrace, I think some frames
>> are omitted/missing (it happens sometime, IDK why), specifically the one
>> related to mptcp_options_received() - which would be useful to
>> understand the issue.
> 
> This is probably related to
> https://lore.kernel.org/all/69e7ee1f.a00a0220.17a17.001d.GAE@google.com/T/

Ah yes, it looks similar.

> Let me send the patch, perhaps this issue will also go away.

That would be great, thank you!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

