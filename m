Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617239E17D;
	Tue, 12 May 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576111; cv=none; b=ifp6uHl1M44dcJx6xvJM8O/YLkDTAWHCVVo9955B+7IEeO7WEGJy6lN04OtQc58Fni9tUZJAUMVXfMHMIxh8fQQPaqS7B6glFaYPFNKSA7zevaKpzSfkF6PI4JpVgpMSJ+Zh8Q6vtsHP/9wO9k9gueYM7GQVlvNTXzXR+S5facs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576111; c=relaxed/simple;
	bh=XROo2bEdsLd5Tq2p7VwmfPkeI7+vXSpwBdvqu/4Uv44=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=ja+s6JvzRPVAmdrwHu/hed1cT3Wm85o5OOxn5jvuEOxjVYl8eL1W7EHPCFZaAYx/fhPATcV6KugB5mZ2wSCa5BZspmt0pxBHF86lUDegiFQNdlP47wyevjrhZKl6Li5FhV27fVdmR4vmYSYYjyvQIY4uCQVSZ7RZY9YzYOHiAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OczSC+ap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OczSC+ap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17E3C2BCB0;
	Tue, 12 May 2026 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778576110;
	bh=XROo2bEdsLd5Tq2p7VwmfPkeI7+vXSpwBdvqu/4Uv44=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=OczSC+ap1gUqEj0ajVbcp2COPgqiESV1Gjw9lA5D8zZRMmYS8OD/M15KrFNwnPdpe
	 5lM/t+piEX4l24Ys1K7wRSqVfBM/CMaNz2+xa49CaKNLR5U0fhUuLKJbAojWLi8CDG
	 svzNxUp0Ao83H2j1yWiJxqYDXB4l1EUkfI7/4qKHMRZ+8Ngpc725aaRjOdHXkog9/t
	 28SxGd1th/e+vo85pvBtEpch07Ea15rp9F3WMq50yooQ28ndLuI8NC8T25IPt8EGiH
	 R8PPQKvrEj0OryyaOyAzFkRW+L9V077wSA9niYITGiEqY8TUTCP9I5/5SSw+8CFyUc
	 7sBFmosFm84pg==
Content-Type: multipart/mixed; boundary="------------Ue3f73wH07p8aT0gnO1Ykfg0"
Message-ID: <88d94464-9391-49f4-848f-f359b09b0500@kernel.org>
Date: Tue, 12 May 2026 10:55:05 +0200
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
From: Matthieu Baerts <matttbe@kernel.org>
To: Alexander Potapenko <glider@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: kuniyu@google.com,
 syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <69f8e352.170a0220.bb392.0005.GAE@google.com>
 <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
 <CAG_fn=Ud-sXzebnwvsiwnu6e0uOHRAFzmUH91Du9pek7Fsx5bA@mail.gmail.com>
 <43a84c8c-0d65-400e-b735-76210af4cddb@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <43a84c8c-0d65-400e-b735-76210af4cddb@kernel.org>

This is a multi-part message in MIME format.
--------------Ue3f73wH07p8aT0gnO1Ykfg0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexander,

On 08/05/2026 12:46, Matthieu Baerts wrote:
> Hi Alexander,
> 
> Thank you for your reply!
> 
> On 08/05/2026 12:11, Alexander Potapenko wrote:
>> On Fri, May 8, 2026 at 11:27 AM 'Paolo Abeni' via syzkaller-bugs
>> <syzkaller-bugs@googlegroups.com> wrote:
>>>
>>> On 5/7/26 9:44 AM, Matthieu Baerts wrote:
>>>> Hi Paolo, Kuniyuki,
>>>>
>>>> On 04/05/2026 20:20, syzbot wrote:
>>>>> Hello,
>>>>>
>>>>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>>>>> KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt
>>>>
>>>> It looks like the issue is different now:
>>>>
>>>>> =====================================================
>>>>> BUG: KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
>>>>>  irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
>>>>>  irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [inline]
>>>>>  irqentry_exit+0x7b/0x760 kernel/entry/common.c:164
>>>>>  sysvec_apic_timer_interrupt+0x52/0x90 arch/x86/kernel/apic/apic.c:1061
>>>>>  asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:697
>>>>>  kmsan_get_metadata+0x17/0x160 mm/kmsan/shadow.c:125
>>>>>  kmsan_get_shadow_origin_ptr+0x4a/0xb0 mm/kmsan/shadow.c:102
>>>>>  get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
>>>>>  __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:93
>>>>>  tcp_data_queue+0xdc/0x7c90 net/ipv4/tcp_input.c:5589
>>>>>  tcp_rcv_established+0x19bb/0x3200 net/ipv4/tcp_input.c:6656
>>>>>  tcp_v4_do_rcv+0xc4b/0x1b10 net/ipv4/tcp_ipv4.c:1852
>>>>>  sk_backlog_rcv include/net/sock.h:1190 [inline]
>>>>
>>>> That's the input side.
>>>>
>>>>>  __release_sock+0x360/0x7d0 net/core/sock.c:3216
>>>>>  release_sock+0x22d/0x300 net/core/sock.c:3815
>>>>>  mptcp_subflow_shutdown+0x358/0x690 net/mptcp/protocol.c:3144
>>>>>  mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
>>>>>  __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
>>>>>  __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
>>>>>  mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
>>>>>  inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
>>>>>  __sock_release net/socket.c:722 [inline]
>>>>>  sock_close+0xd6/0x2f0 net/socket.c:1514
>>>>>  __fput+0x60e/0x1010 fs/file_table.c:510
>>>>>  ____fput+0x25/0x30 fs/file_table.c:538
>>>>>  task_work_run+0x208/0x2b0 kernel/task_work.c:233
>>>>>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>>>>>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>>>>>  exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
>>>>>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>>>>>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
>>>>>  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
>>>>>  do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
>>>>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>
>>>>> Local variable mp_opt created at:
>>>>>  mptcp_incoming_options+0x11d/0x43b0 net/mptcp/options.c:1171
>>>>
>>>> Confirmed here. With "struct mptcp_options_received" while the original
>>>> issue was with "struct mptcp_out_options".
>>>>
>>>> Plus I'm not exactly sure to understand the issue here: mp_opt is
>>>> defined and used only in mptcp_incoming_options(), and I don't see
>>>> anything using it after the end of this function. Or did I miss something?
>>>
>>> I also had hard time understanding the backtrace, I think some frames
>>> are omitted/missing (it happens sometime, IDK why), specifically the one
>>> related to mptcp_options_received() - which would be useful to
>>> understand the issue.
>>
>> This is probably related to
>> https://lore.kernel.org/all/69e7ee1f.a00a0220.17a17.001d.GAE@google.com/T/
> 
> Ah yes, it looks similar.
> 
>> Let me send the patch, perhaps this issue will also go away.
> 
> That would be great, thank you!

Thank you for having sent your patch.

Here is one combining your modifications, and the ones from Paolo, for
syzbot. If this one is OK, we can continue with Paolo's patch.

#syz test

Cheers,
Matt
--------------Ue3f73wH07p8aT0gnO1Ykfg0
Content-Type: text/x-patch; charset=UTF-8; name="zero_opt_flags_irq_mmi.patch"
Content-Disposition: attachment; filename="zero_opt_flags_irq_mmi.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oIGIvaW5jbHVk
ZS9saW51eC9pcnEtZW50cnktY29tbW9uLmgKaW5kZXggMTY3ZmJhN2RiZjA0Li5iZTQ3ZDQz
MGQ1MjEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oCisr
KyBiL2luY2x1ZGUvbGludXgvaXJxLWVudHJ5LWNvbW1vbi5oCkBAIC00MjcsNiArNDI3LDcg
QEAgc3RhdGljIF9fYWx3YXlzX2lubGluZSBpcnFlbnRyeV9zdGF0ZV90IGlycWVudHJ5X2Vu
dGVyX2Zyb21fa2VybmVsX21vZGUoc3RydWN0IHAKIAkJY3RfaXJxX2VudGVyKCk7CiAJCWlu
c3RydW1lbnRhdGlvbl9iZWdpbigpOwogCQlrbXNhbl91bnBvaXNvbl9lbnRyeV9yZWdzKHJl
Z3MpOworCQlrbXNhbl91bnBvaXNvbl9tZW1vcnkoJnJldCwgc2l6ZW9mKHJldCkpOwogCQl0
cmFjZV9oYXJkaXJxc19vZmZfZmluaXNoKCk7CiAJCWluc3RydW1lbnRhdGlvbl9lbmQoKTsK
IApAQCAtNDQzLDYgKzQ0NCw3IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgaXJxZW50cnlf
c3RhdGVfdCBpcnFlbnRyeV9lbnRlcl9mcm9tX2tlcm5lbF9tb2RlKHN0cnVjdCBwCiAJbG9j
a2RlcF9oYXJkaXJxc19vZmYoQ0FMTEVSX0FERFIwKTsKIAlpbnN0cnVtZW50YXRpb25fYmVn
aW4oKTsKIAlrbXNhbl91bnBvaXNvbl9lbnRyeV9yZWdzKHJlZ3MpOworCWttc2FuX3VucG9p
c29uX21lbW9yeSgmcmV0LCBzaXplb2YocmV0KSk7CiAJcmN1X2lycV9lbnRlcl9jaGVja190
aWNrKCk7CiAJdHJhY2VfaGFyZGlycXNfb2ZmX2ZpbmlzaCgpOwogCWluc3RydW1lbnRhdGlv
bl9lbmQoKTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L21wdGNwLmggYi9pbmNsdWRlL25l
dC9tcHRjcC5oCmluZGV4IGY3MjYzZmUyYTJlNC4uMDc2M2ZkNmY3NzU4IDEwMDY0NAotLS0g
YS9pbmNsdWRlL25ldC9tcHRjcC5oCisrKyBiL2luY2x1ZGUvbmV0L21wdGNwLmgKQEAgLTI3
LDYgKzI3LDkgQEAgc3RydWN0IG1wdGNwX2V4dCB7CiAJdTMyCQlzdWJmbG93X3NlcTsKIAl1
MTYJCWRhdGFfbGVuOwogCV9fc3VtMTYJCWNzdW07CisKKwlzdHJ1Y3RfZ3JvdXAoZmxhZ3Ms
CisKIAl1OAkJdXNlX21hcDoxLAogCQkJZHNuNjQ6MSwKIAkJCWRhdGFfZmluOjEsCkBAIC0z
OCw2ICs0MSw4IEBAIHN0cnVjdCBtcHRjcF9leHQgewogCXU4CQlyZXNldF9yZWFzb246NCwK
IAkJCWNzdW1fcmVxZDoxLAogCQkJaW5maW5pdGVfbWFwOjE7CisKKwkpOyAvKiBlbmQgb2Yg
ZmxhZ3MgZ3JvdXAgKi8KIH07CiAKICNkZWZpbmUgTVBUQ1BPUFRfSE1BQ19MRU4JMjAKZGlm
ZiAtLWdpdCBhL2tlcm5lbC9lbnRyeS9jb21tb24uYyBiL2tlcm5lbC9lbnRyeS9jb21tb24u
YwppbmRleCAxOWQyMjQ0YTlmZWYuLjM5MDM2NDk0M2Y5MiAxMDA2NDQKLS0tIGEva2VybmVs
L2VudHJ5L2NvbW1vbi5jCisrKyBiL2tlcm5lbC9lbnRyeS9jb21tb24uYwpAQCAtMTc3LDYg
KzE3Nyw3IEBAIGlycWVudHJ5X3N0YXRlX3Qgbm9pbnN0ciBpcnFlbnRyeV9ubWlfZW50ZXIo
c3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAKIAlpbnN0cnVtZW50YXRpb25fYmVnaW4oKTsKIAlr
bXNhbl91bnBvaXNvbl9lbnRyeV9yZWdzKHJlZ3MpOworCWttc2FuX3VucG9pc29uX21lbW9y
eSgmaXJxX3N0YXRlLCBzaXplb2YoaXJxX3N0YXRlKSk7CiAJdHJhY2VfaGFyZGlycXNfb2Zm
X2ZpbmlzaCgpOwogCWZ0cmFjZV9ubWlfZW50ZXIoKTsKIAlpbnN0cnVtZW50YXRpb25fZW5k
KCk7CmRpZmYgLS1naXQgYS9uZXQvbXB0Y3Avb3B0aW9ucy5jIGIvbmV0L21wdGNwL29wdGlv
bnMuYwppbmRleCA4YTFjNTY5ODk4M2MuLjNmZDQwZGJmZjgyYiAxMDA2NDQKLS0tIGEvbmV0
L21wdGNwL29wdGlvbnMuYworKysgYi9uZXQvbXB0Y3Avb3B0aW9ucy5jCkBAIC01NzIsNiAr
NTcyLDExIEBAIHN0YXRpYyBib29sIG1wdGNwX2VzdGFibGlzaGVkX29wdGlvbnNfZHNzKHN0
cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYiwKIAlib29sIHJldCA9IGZhbHNl
OwogCXU2NCBhY2tfc2VxOwogCisJLyogWmVybyBgY2FuX2Fja2AgYW5kIGB1c2VfbWFwYCBm
bGFncyB3aXRoIG9uZSBzaG90LiAqLworCUJVSUxEX0JVR19PTihzaXplb2ZfZmllbGQoc3Ry
dWN0IG1wdGNwX2V4dCwgZmxhZ3MpICE9IHNpemVvZih1MTYpKTsKKwlCVUlMRF9CVUdfT04o
IUlTX0FMSUdORUQob2Zmc2V0b2Yoc3RydWN0IG1wdGNwX2V4dCwgZmxhZ3MpLAorCQkJCSBz
aXplb2YodTE2KSkpOworCSoodTE2ICopJm9wdHMtPmV4dF9jb3B5LmZsYWdzID0gMDsKIAlv
cHRzLT5jc3VtX3JlcWQgPSBSRUFEX09OQ0UobXNrLT5jc3VtX2VuYWJsZWQpOwogCW1wZXh0
ID0gc2tiID8gbXB0Y3BfZ2V0X2V4dChza2IpIDogTlVMTDsKIApAQCAtNTk1LDcgKzYwMCw2
IEBAIHN0YXRpYyBib29sIG1wdGNwX2VzdGFibGlzaGVkX29wdGlvbnNfZHNzKHN0cnVjdCBz
b2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYiwKIAkvKiBwYXNzaXZlIHNvY2tldHMgbXNr
IHdpbGwgc2V0IHRoZSAnY2FuX2FjaycgYWZ0ZXIgYWNjZXB0KCksIGV2ZW4KIAkgKiBpZiB0
aGUgZmlyc3Qgc3ViZmxvdyBtYXkgaGF2ZSB0aGUgYWxyZWFkeSB0aGUgcmVtb3RlIGtleSBo
YW5keQogCSAqLwotCW9wdHMtPmV4dF9jb3B5LnVzZV9hY2sgPSAwOwogCWlmICghUkVBRF9P
TkNFKG1zay0+Y2FuX2FjaykpIHsKIAkJKnNpemUgPSBBTElHTihkc3Nfc2l6ZSwgNCk7CiAJ
CXJldHVybiByZXQ7Cg==

--------------Ue3f73wH07p8aT0gnO1Ykfg0--
