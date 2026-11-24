Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547018;
	b=S7YF7GJ5qISVW+Njl2GJ0yjoEEcut4zz/3hCO/J0SPJKiM0bIK7G0pTSAS63ya2Ur87m
	 jCOC/pUqVIVC4yXVtVgc+MfOMjjZrR02+R1GU1vsv+mbCJo4MhvaHbMGot9CDuRCsl6oq
	 iEMSgklm+rMIq010svd2fpFMiBsXVLLWaTm7DmjhiMdta2tRY90dzkx2vEG5jHaJw7wJK
	 bs3erPVNwheafy9dj1/eWnDPOc/ryapPsDa03KQZPU4tTh/4vK4mEh39HFYvW941r4+2t
	 nYsBsIRL+lh/jm31Kk2CY9iR+i6L5ML0dXmn3UxoxRHPJuFiT7oBGkul4mavGq6z/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547018;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3NHkiK89FGhMqxmhyPjWv59hYEFcdhqG3oRKdQBbdbI=;
	b=DWd4Skd4F5yGAWVj7TOAuTMGT9s1Gyyusto+DwrxG2W1M9EIOA19uFbJXmMpwhyKK4qy
	 WPOKtKpZjV/rP2Tn2UBVHfGQHf8wLPSHIbtIg02iyGpsmU3W9eKeOYQSJq5OqKUBv1zdv
	 qgjYfcYde5m2SepHTFXV9wL0ovfoluSA7WKwxm86SzzxgytGR1kbGyE8hb/3Sb0AfTeWl
	 +J1gdmcBktt9uVaKvscC1QYKxwNJ7zIxf2eVMfgr3+Wzlg6jwbdV+SYWymGG4a3R6MdOG
	 xNx3ExQG9VMu4+YYHvQtNtANY5Uch2rOe2lQ+iHbsnUmC2lEC/G5fSjbpm9FcBuwVYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQuUL4U0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF564606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQuUL4U0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879961F000C0;
	Tue, 24 Nov 2026 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795547017;
	bh=3NHkiK89FGhMqxmhyPjWv59hYEFcdhqG3oRKdQBbdbI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hQuUL4U0KYbvYANxbBxCUG+yl3QK7mxptFwxq0oE3y5h9tfdLnt5jt1KfheiHBfC7
	 GkWSTfHWtVuuaeVkcKNLkLn+9xgl+p1PoxdyJV9CjzNguPlbmydk5MieYZiRVHWblC
	 tylJ2aoYzIJZ4G4Nq++KjAICbS3eWbVUofL4GKvF1UQWJdoeYPiHB9uGQLqfh7aal5
	 lVSkb5OeYoF5nAbHvDwYRnoTSg9aoJqVaCfgjaoIOd368LAf3DKLNxF1c5KyHdG7wI
	 KNfB8JiaHnATY91lKT1AnuiQ61tSxNz/6rjQXURMLk4n6NzatrGg9YfE+/Wx6ZMlTg
	 kicCCLdn5EH3w==
Subject:
 Re: [PATCH mptcp-net v14] mptcp: hide sequence numbers in Netlink diagnostics
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Tue, 24 Nov 2026 19:03:37 +0000
Message-ID: <179554701704.3133.17670693401738699374@kernel.org>
In-Reply-To: <20261123054324.561321-1-kalpan.jani@mpiricsoftware.com>
References: <20261123054324.561321-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/mptcp/mptcp_diag.c, mptcp_diag_get_info() (lines
  219-221) sets mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt to 0…
- [Low] The same helper, mptcp_diag_fill_info()
  (net/mptcp/sockopt.c:1013, 1027-1028), fills struct mptcp_info for…
- [Low] The in-tree selftest helper
  tools/testing/selftests/net/mptcp/mptcp_diag.c, print_info_msg() at…

--

mptcp: hide sequence numbers in Netlink diagnostics

This commit clears mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in
mptcp_diag_get_info(), so MPTCP data-level sequence numbers are no longer
exposed through INET_DIAG_INFO. The fields are cleared for all requesters.
getsockopt(MPTCP_INFO) and getsockopt(MPTCP_FULL_INFO) still report the
real values.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> index 136c2d05c0eeb..fe1603ce80162 100644
> --- a/net/mptcp/mptcp_diag.c
> +++ b/net/mptcp/mptcp_diag.c
> @@ -215,6 +215,10 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
>  		return;
>  
>  	mptcp_diag_fill_info(msk, info);
> +
> +	info->mptcpi_write_seq = 0;
> +	info->mptcpi_snd_una = 0;
> +	info->mptcpi_rcv_nxt = 0;

[Severity: Medium]
Should these values be hidden from CAP_NET_ADMIN requesters too? After
this change, a privileged user running ss -Mi always sees 0 for these
fields.

The commit message says:

  However, the current diagnostic callback does not
  provide the privilege information needed to distinguish requesters.

Is that accurate? The idiag_get_info() signature doesn't carry the flag.
But net_admin is already in scope at the call site in inet_sk_diag_fill(),
and the next statement passes it to the sibling callback:

net/ipv4/inet_diag.c:inet_sk_diag_fill() {
    ...
	handler->idiag_get_info(sk, r, info);

	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
		if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
			goto errout;
    ...
}

mptcp_diag_dump() already computes it with
netlink_net_capable(cb->skb, CAP_NET_ADMIN) and passes it through
sk_diag_dump() into inet_sk_diag_fill(). Only tcp, udp, raw, sctp and
mptcp implement idiag_get_info, so adding a net_admin argument looks
like a small change.

The MPTCP subflow diag already follows this policy in subflow_get_info()
in net/mptcp/diag.c:

	/* Only export seq related counters to user with CAP_NET_ADMIN */
	if (net_admin &&
	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
			 sf->rel_write_seq) ||
	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
	...

With this patch, root can still read the data-level MAP_SEQ for each
subflow. For the same connection, though, root always gets 0 for the
connection-level write_seq, snd_una and rcv_nxt.

Would it be more consistent to gate these three fields on net_admin, as
subflow_get_info() does? This patch has a Fixes: tag, so it will also
reach stable trees. Privileged tooling there would silently stop seeing
these values.

[Severity: Low]
This isn't a bug, but mptcp_diag_fill_info() fills struct mptcp_info for
both getsockopt(MPTCP_INFO/MPTCP_FULL_INFO) and INET_DIAG_INFO. After this
change, these three fields carry real values on the getsockopt path and a
constant 0 on the sock_diag path.

Neither struct mptcp_info in include/uapi/linux/mptcp.h nor
mptcp_diag_get_info() has a comment noting this. The subflow diag drops
hidden attributes from the message. mptcp_info is a fixed binary struct,
so here the hiding shows up as a silent 0.

Could a short comment be added here, or in the uAPI header, saying these
fields are intentionally reported as 0 over sock_diag?

[Severity: Low]
This isn't a bug, but print_info_msg() in the selftest helper
tools/testing/selftests/net/mptcp/mptcp_diag.c still prints these fields
from the INET_DIAG_INFO payload:

	printf("\nTransmission Info\n");
	printf("write_seq:        %llu\n", info->mptcpi_write_seq);
	printf("snd_una:          %llu\n", info->mptcpi_snd_una);
	printf("rcv_nxt:          %llu\n", info->mptcpi_rcv_nxt);

On a patched kernel these will always print 0. chk_dump_one() in diag.sh
only parses the token from this tool, so no test covers the new zeroing.

The changelog says the dedicated selftest was removed following
maintainer feedback, so the missing coverage looks deliberate. Printing
whatever the kernel reports is also fine for a tool that has to run on
older kernels. This is noted only for completeness.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123054324.561321-1-kalpan.jani%40mpiricsoftware.com
