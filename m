Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606D2FB08F;
	Wed,  3 Dec 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764768720; cv=none; b=BG10rBmUY2LNXkCjD7VLAf3IQWjn4UOiOInbVTaIenLmUYyjdOiAOUISb/c5CPN7gHy9VyrD35itf+B2Grn8BBAvpIv52jC4VP1sorcdwB1Hq4X1avy9370ZX3D3wipKLDhKGKf5PDDutn5kGy8kZ7I8iusY13mXMf9NdGdp2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764768720; c=relaxed/simple;
	bh=uXJDv15SsCAdhA6on8Kcs6NSuijMkmM3ly31Esed8w8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=Fxi75mrwyEoy+UdAZcGPQKCcsBc4OU/Dg4zSEwY1KsPVXSS7LbWq5D+Vp9MbzGWv24bZ1fORrs4hhWK+R1Mar4iuasewUMYjJy3vPLN6XdwM10q3l/IN38G5KFrcJtdUPTQbCVaTwmz34Nf0zwHbl+keNymdXu1XeOMcTdQB7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WqEVLmrd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WqEVLmrd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75970C4CEFB;
	Wed,  3 Dec 2025 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764768720;
	bh=uXJDv15SsCAdhA6on8Kcs6NSuijMkmM3ly31Esed8w8=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=WqEVLmrdQCyO7ZJbbM3yIC1HE8YIUgI9s1mZCqs5iXQlyobWisqKgTndsdPjV/SPG
	 usl2F60tpGy5VLtIJOKSmXJDeybj+rswdEyUPmZ5xyB0DqYqUhmYq9E8mmt3DPLbJD
	 /IFU7Q+BxgEB8H9AMHAlV4zaMKDqF93zeG6w4rwU=
Subject: Patch "mptcp: Fix proto fallback detection with BPF" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org,jakub@cloudflare.com,jiayuan.chen@linux.dev,martin.lau@kernel.org,matttbe@kernel.org,mptcp@lists.linux.dev
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Dec 2025 14:31:37 +0100
In-Reply-To: <20251201112712.3573321-2-matttbe@kernel.org>
Message-ID: <2025120337-shakable-coastline-aea3@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: Fix proto fallback detection with BPF

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-fix-proto-fallback-detection-with-bpf.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-197759-greg=kroah.com@vger.kernel.org Mon Dec  1 12:31:55 2025
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon,  1 Dec 2025 12:27:13 +0100
Subject: mptcp: Fix proto fallback detection with BPF
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, Martin KaFai Lau <martin.lau@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20251201112712.3573321-2-matttbe@kernel.org>

From: Jiayuan Chen <jiayuan.chen@linux.dev>

commit c77b3b79a92e3345aa1ee296180d1af4e7031f8f upstream.

The sockmap feature allows bpf syscall from userspace, or based
on bpf sockops, replacing the sk_prot of sockets during protocol stack
processing with sockmap's custom read/write interfaces.
'''
tcp_rcv_state_process()
  syn_recv_sock()/subflow_syn_recv_sock()
    tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
      bpf_skops_established       <== sockops
        bpf_sock_map_update(sk)   <== call bpf helper
          tcp_bpf_update_proto()  <== update sk_prot
'''

When the server has MPTCP enabled but the client sends a TCP SYN
without MPTCP, subflow_syn_recv_sock() performs a fallback on the
subflow, replacing the subflow sk's sk_prot with the native sk_prot.
'''
subflow_syn_recv_sock()
  subflow_ulp_fallback()
    subflow_drop_ctx()
      mptcp_subflow_ops_undo_override()
'''

Then, this subflow can be normally used by sockmap, which replaces the
native sk_prot with sockmap's custom sk_prot. The issue occurs when the
user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
Here, it uses sk->sk_prot to compare with the native sk_prot, but this
is incorrect when sockmap is used, as we may incorrectly set
sk->sk_socket->ops.

This fix uses the more generic sk_family for the comparison instead.

Additionally, this also prevents a WARNING from occurring:

result from ./scripts/decode_stacktrace.sh:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept \
(net/mptcp/protocol.c:4005)
Modules linked in:
...

PKRU: 55555554
Call Trace:
<TASK>
do_accept (net/socket.c:1989)
__sys_accept4 (net/socket.c:2028 net/socket.c:2057)
__x64_sys_accept (net/socket.c:2067)
x64_sys_call (arch/x86/entry/syscall_64.c:41)
do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f87ac92b83d

---[ end trace 0000000000000000 ]---

Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20251111060307.194196-3-jiayuan.chen@linux.dev
[ Conflicts in protocol.c, because commit 8e2b8a9fa512 ("mptcp: don't
  overwrite sock_ops in mptcp_is_tcpsk()") is not in this version. It
  changes the logic on how and where the sock_ops is overridden in case
  of passive fallback. To fix this, mptcp_is_tcpsk() is modified to use
  the family, but first, a check of the protocol is required to continue
  returning 'false' in case of MPTCP socket. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -77,8 +77,13 @@ static u64 mptcp_wnd_end(const struct mp
 static bool mptcp_is_tcpsk(struct sock *sk)
 {
 	struct socket *sock = sk->sk_socket;
+	unsigned short family;
 
-	if (unlikely(sk->sk_prot == &tcp_prot)) {
+	if (likely(sk->sk_protocol == IPPROTO_MPTCP))
+		return false;
+
+	family = READ_ONCE(sk->sk_family);
+	if (unlikely(family == AF_INET)) {
 		/* we are being invoked after mptcp_accept() has
 		 * accepted a non-mp-capable flow: sk is a tcp_sk,
 		 * not an mptcp one.
@@ -89,7 +94,7 @@ static bool mptcp_is_tcpsk(struct sock *
 		sock->ops = &inet_stream_ops;
 		return true;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-	} else if (unlikely(sk->sk_prot == &tcpv6_prot)) {
+	} else if (unlikely(family == AF_INET6)) {
 		sock->ops = &inet6_stream_ops;
 		return true;
 #endif


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-5.15/x86-boot-compile-boot-code-with-std-gnu11-too.patch
queue-5.15/mptcp-disallow-mptcp-subflows-from-sockmap.patch
queue-5.15/revert-docs-process-howto-replace-c89-with-c11.patch
queue-5.15/mptcp-fix-race-condition-in-mptcp_schedule_work.patch
queue-5.15/mptcp-restore-window-probe.patch
queue-5.15/mptcp-fix-proto-fallback-detection-with-bpf.patch
queue-5.15/mptcp-do-not-fallback-when-ooo-is-present.patch
queue-5.15/arch-back-to-std-gnu89-in-v5.18.patch
queue-5.15/selftests-mptcp-join-rm-set-backup-flag.patch
queue-5.15/selftests-mptcp-connect-fix-fallback-note-due-to-ooo.patch
queue-5.15/mptcp-fix-ack-generation-for-fallback-msk.patch
queue-5.15/mptcp-pm-in-kernel-c-flag-handle-late-add_addr.patch
queue-5.15/mptcp-fix-premature-close-in-case-of-fallback.patch
queue-5.15/mptcp-fix-a-race-in-mptcp_pm_del_add_timer.patch
queue-5.15/gcov-add-support-for-gcc-15.patch
queue-5.15/mptcp-avoid-unneeded-subflow-level-drops.patch
