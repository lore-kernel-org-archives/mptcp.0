Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE3921146C
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737548536; cv=none; b=bih5kzx8pwZONB3EAj3XSGMabXttGo92/jmDpX6e8yL9jaJJ3RJCOmSuosPj1M0QVGZuwrsZQ/I1BTSu3KPozpW+M3w8hAQVzsLOfLi2Q4zeJPzWgg+1h5zplVbinkuNbIbjJi36RdgfrLW1w1BoI7o0J7zSSNb2TAfBhkwKeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737548536; c=relaxed/simple;
	bh=nQjOqeKP+rMNCECJNlxgeMn9WMuTemI8Rbbj6w/AWsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akFgqVnV1yDU1mpToamYNoGPt9PLQlu6UEZ9VR91U/IOCPDi7WzY0+ROx5TlKdRhJs+aULG5nV+5fd1g5GoMiw0PVRiJDewKEX0iptO+BvzCqfJuPZCXFRddlzGUPo/lfKV5bGckv84wNZ1jx4XM2+tbhfhlaf82jkW7ySr/V+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IabxOJE3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IabxOJE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0954BC4CED6;
	Wed, 22 Jan 2025 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737548533;
	bh=nQjOqeKP+rMNCECJNlxgeMn9WMuTemI8Rbbj6w/AWsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IabxOJE3IltxWXi1861dXmKU8OLpD1ueVChiVHpWW3pRM73gd6lf48ZJlrbJ1o7T1
	 5T+KPDmcIyN61GVu8GqH0oB/x7q2Af38FnOdWkzupxpPWjHPW3MGMqTGIg/+2cyTlo
	 76ejarC+hdaERzmQ0cvhZcLllDMHpJ4rxld8arb8KlsXqh60OqxBCCG7AFyc8r0odr
	 P5e7poQjvwIHes5IMaztugQcf1w3volkXHkEima7f7pU0IJdGbTGnzqLwdbMXfxyQi
	 UuQZGAzUBeVBX6gyWS5OMZdvpXnVvCiNhhaXgFuNb10p7XH5nNp9wii1TmO7NfU3Ww
	 BeL3UAUg/6bxw==
Message-ID: <b03082c9-d372-4071-8320-35d00fa285b1@kernel.org>
Date: Wed, 22 Jan 2025 13:22:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 1/3] mptcp: pm: only set fullmesh for subflow
 endp
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev,
 syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
References: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
 <20250117-mptcp-issue-540-v2-1-a194740fb380@kernel.org>
 <44078eaf-f963-ddc2-c1b6-d5d01c527e85@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <44078eaf-f963-ddc2-c1b6-d5d01c527e85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 21/01/2025 23:59, Mat Martineau wrote:
> On Fri, 17 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> With the in-kernel path-manager, it is possible to change the 'fullmesh'
>> flag. The code in mptcp_pm_nl_fullmesh() expects to change it only on
>> 'subflow' endpoints, to recreate more or less subflows using the linked
>> address.
>>
>> Unfortunately, the set_flags() hook was a bit more permissive, and
>> allowed 'implicit' endpoints to get the 'fullmesh' flag while it is not
>> allowed before.
>>
>> That's what syzbot found, triggering the following warning:
>>
>>  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496
>> __mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
>>  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496
>> mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
>>  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496
>> mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
>>  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496
>> mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
>>  Modules linked in:
>>  CPU: 0 UID: 0 PID: 6499 Comm: syz.1.413 Not tainted 6.13.0-rc5-
>> syzkaller-00172-gd1bf27c4e176 #0
>>  Hardware name: Google Compute Engine/Google Compute Engine, BIOS
>> Google 09/13/2024
>>  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1496
>> [inline]
>>  RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
>>  RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
>>  RIP: 0010:mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
>>  Code: 01 00 00 49 89 c5 e8 fb 45 e8 f5 e9 b8 fc ff ff e8 f1 45 e8 f5
>> 4c 89 f7 be 03 00 00 00 e8 44 1d 0b f9 eb a0 e8 dd 45 e8 f5 90 <0f> 0b
>> 90 e9 17 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c c9 fc ff ff 48
>>  RSP: 0018:ffffc9000d307240 EFLAGS: 00010293
>>  RAX: ffffffff8bb72e03 RBX: 0000000000000000 RCX: ffff88807da88000
>>  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>>  RBP: ffffc9000d307430 R08: ffffffff8bb72cf0 R09: 1ffff1100b842a5e
>>  R10: dffffc0000000000 R11: ffffed100b842a5f R12: ffff88801e2e5ac0
>>  R13: ffff88805c214800 R14: ffff88805c2152e8 R15: 1ffff1100b842a5d
>>  FS:  00005555619f6500(0000) GS:ffff8880b8600000(0000)
>> knlGS:0000000000000000
>>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>  CR2: 0000000020002840 CR3: 00000000247e6000 CR4: 00000000003526f0
>>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>  Call Trace:
>>   <TASK>
>>   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
>>   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
>>   genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
>>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
>>   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
>>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
>>   sock_sendmsg_nosec net/socket.c:711 [inline]
>>   __sock_sendmsg+0x221/0x270 net/socket.c:726
>>   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
>>   ___sys_sendmsg net/socket.c:2637 [inline]
>>   __sys_sendmsg+0x269/0x350 net/socket.c:2669
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>  RIP: 0033:0x7f5fe8785d29
>>  Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>>  RSP: 002b:00007fff571f5558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
>>  RAX: ffffffffffffffda RBX: 00007f5fe8975fa0 RCX: 00007f5fe8785d29
>>  RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000007
>>  RBP: 00007f5fe8801b08 R08: 0000000000000000 R09: 0000000000000000
>>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>>  R13: 00007f5fe8975fa0 R14: 00007f5fe8975fa0 R15: 00000000000011f4
>>   </TASK>
>>
>> Here, syzbot managed to set the 'fullmesh' flag on an 'implicit' and
>> used -- according to 'id_avail_bitmap' -- endpoint, causing the PM to
>> try decrement the local_addr_used counter which is only incremented for
>> the 'subflow' endpoint.
>>
>> Note that 'no type' endpoints -- not 'subflow', 'signal', 'implicit' --
>> are fine, because their ID will not be marked as used in the 'id_avail'
>> bitmap, and setting 'fullmesh' can help forcing the creation of subflow
>> when receiving an ADD_ADDR.
>>
>> Fixes: 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")
>> Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
>> Closes: https://
>> lore.kernel.org/6786ac51.050a0220.216c54.00a6.GAE@google.com
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/540
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>> - v2: check the two flags in one instruction. (Paolo)
> 
> v2 LGTM:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- c3a63555780b: mptcp: pm: only set fullmesh for subflow endp
- Results: e7c5c5982f54..28c8f5a4574b (export-net)
- 6cce766067be: conflict in t/mptcp-add-local-parameter-for-set_flags
- Results: a9a670c7f9f9..8c4d55afa2c3 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/cd6d39abeeb0ad570a1f34adef4731098cec9cb0/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/3a8173007814d102c6043c8f4830f6621e87d435/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

