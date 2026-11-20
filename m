Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200109;
	b=dI+NxtL7gjHccG+6AJJrsjEBcewFPWuAXfmzmD2NdTvZoA3y86jKhmgL+RzmFhROsm3V
	 Q6a1RfY7AgWOfbDjgSPssrto64k7ww08oMCMqb14eFGCrEaX4FBfyS6JO8Tgg0H4gc/iP
	 2IiB/z9qKXMdGFnvrYi7wy4Ij+mrD09kQm6XCptkkz5M1SKcdP09ch0ddvNcyUEmfypsW
	 jy8w49CsB3VPGhTQbWIH/qTLkMkGsA9Mdn9s1M+QxForHW9IAvc6bWsGnvjgjS1Zx20IT
	 j3v7YB32A4Is2E7IA3LwJFAuj3Z7xraI/LhNLoV5ZEMphRdxglrDCZ1MG7LdwOkIgRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200109;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wZ+QghfG8siorctHym5Jqm+QqcsQegJKjM82SzWsc+c=;
	b=yz23dLzOwpnc/x9jsENAJJ56xf2PF7BNsHYciddnKIzbwam52YPEstwdOSK5+8K0IZBN
	 PUuGS4vzdmFm5QwI5yq7U2iY82KxkJveffLRN7WL/oM09BLfunqKN4Bl2fTv2w0+YASQf
	 OODhdLoHjtMknXrkukKDpXr9uyhHpfy7OU64ayf1H9GI6bEAm16S35PQzES2WUhxcGpLB
	 gEA1Wozb6mNCxl2/hYdQiwrc4Mwf1GV6mkaerkQZOtgLjP7WRDgoo2BSQIB2XmeAH9aAS
	 XWTt+F+GoHB4Yjo9aWeJXexVvNSssuUjk7tPZ3yalZTFw/3lD6MQWpOXjZjItx98eKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LiBXTOmF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86988606A33A
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LiBXTOmF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8991A1F000C4;
	Fri, 20 Nov 2026 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200108;
	bh=wZ+QghfG8siorctHym5Jqm+QqcsQegJKjM82SzWsc+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LiBXTOmFniLGFC1Dvbk1VU8pJs43wUgk+WFLiDhQb5k5s5fqAa5pdb7o3yNMFksN4
	 UVAzGTXcOU9RZMShIG0PAWn88VMmJsVJXsnR3qtS2Kzx8j/WtDb7UR22lkE9/x2t5F
	 SL7s9jCuLIeM4Ayj5jE+MIVchhIDVHa0oUHG8mggyAfGr3krCY7OAabPidpnPxBpUA
	 nGzpSu5evAkCrVle+fvWdCmOKHywbbwcNIDU7+J6QD+mRRkjheP0a35uSh9Uo0AITh
	 0j3ucQKUbcTd4dE8FROL7o/EFj8fIWv7jTmCIBL6JVmGVzaF+RmQ128xscf0jemOG/
	 71uRvGrUyCVoQ==
Subject: Re: [PATCH mptcp-net v29 1/8] mptcp: clear rcv_data_fin_seq in
 mptcp_disconnect
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 20 Nov 2026 18:41:48 +0000
Message-ID: <179520010810.3133.1816117827174569907@kernel.org>
In-Reply-To: <8ddc0c84953b684795e5059639b88594c30a3470.1795063943.git.tanggeliang@kylinos.cn>
References: <8ddc0c84953b684795e5059639b88594c30a3470.1795063943.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message describes a failure that cannot happen.
- [Low] The From and Signed-off-by addresses don't match.

--

mptcp: clear rcv_data_fin_seq in mptcp_disconnect

This commit resets msk->rcv_data_fin_seq to 0 in mptcp_disconnect(), right
after the existing rcv_data_fin reset. A disconnected and reused socket then
no longer keeps the DATA_FIN sequence from its previous connection.

> This can cause mptcp_pending_data_fin() to incorrectly match the old
> rcv_data_fin_seq against the new connection's ack_seq, triggering a
> spurious DATA_FIN processing.

[Severity: Low]

Can this sequence actually happen?

In mptcp_pending_data_fin() in net/mptcp/protocol.c, rcv_data_fin_seq is
only read after the rcv_data_fin check passes:

	if (READ_ONCE(msk->rcv_data_fin) &&
	    ((1 << inet_sk_state_load(sk)) &
	     (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2))) {
		u64 rcv_data_fin_seq = READ_ONCE(msk->rcv_data_fin_seq);

mptcp_disconnect() already clears rcv_data_fin. The only place that sets it
again is mptcp_update_rcv_data_fin() in net/mptcp/options.c. That function
writes a fresh rcv_data_fin_seq just before it sets the flag:

	WRITE_ONCE(msk->rcv_data_fin_seq,
		   mptcp_expand_seq(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
	WRITE_ONCE(msk->rcv_data_fin, 1);

Every caller goes through this helper: mptcp_incoming_options(),
get_mapping_status() (twice) and subflow_sched_work_if_closed(). So the
stale value seems to be overwritten every time before
mptcp_pending_data_fin() can read it.

The reset still looks necessary, but because of the next patch in the
series, "mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint". That patch adds
a reader in mptcp_inq_hint() that does not check rcv_data_fin first:

	if (READ_ONCE(msk->rcv_data_fin_seq))
		hint_val += 1;

Without this reset, that check would count a FIN byte after disconnect and
reuse, even though no DATA_FIN was received.

Could the commit message give that dependency as the reason instead? As
written, the Fixes: b29fcfb54cd7 tag points to a mptcp_pending_data_fin()
problem that doesn't seem to exist. That could give stable maintainers the
wrong reason and the wrong backport range.

> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]

This isn't a bug, but the From and Signed-off-by addresses don't match. The
author is Geliang Tang <geliang@kernel.org>, while the only sign-off uses
tanggeliang@kylinos.cn. Because of this, checkpatch.pl warns with
FROM_SIGN_OFF_MISMATCH.

Other patches in the same series sign off with the kernel.org address.

Could the author be changed to the kylinos.cn address, or a Signed-off-by
with the kernel.org address be added?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795063943.git.tanggeliang%40kylinos.cn
