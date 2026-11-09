Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186925;
	b=4Y5pFikW+wlniMlPaeWFZODlqF6CY/bQbYzJDz3PfwS18RedG/hij2sQjQUKVTY2MJAT
	 zVDWuZglBgxqn1lRK6t5PbQgwpl9MwE0FLx4VFDZiamSyz6dGxZc7PeHp+CcLwZAagLiT
	 kIhNvrFe4nKieRMLdIUqEKFdQ1TLQ/rGX36kMynQn6NswjXMrQHQZ9KuSsRbkye4MyPBk
	 JKHIMxv954Fm+UyPJyUXUO41sPLV5NnUULUlCeEWOqshvCfbkFd9AlT+vai/9ygEL20Fs
	 tkNu+yNswt2/7tbH7wV1BzX5ytKt7I20vsB07EEdfMPhjSasAOQs+EViOGrstl+lmZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186925;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=G6Mzw56DWkrUhn/kgV3DP01ARhi/XkKLUQyL6zGrpPI=;
	b=lVGZLsgudC9+/8VbVeoK6HLH73DcfilgJoRwmJDbNVtH3uyLkRb7xGStg6K04HMqwrmD
	 Lrp6TD4VEDsESQlVtSUKU01itf3U5wgergifsH6zJjvpIC4vmPzY4ESPeDbfFT8ozebvO
	 xShWv4+AEBV1wPLSVaNHIK3OjfRVwgYpAdhFSZGPSARezjdD6D7kf7Xl2YTTgnxKZ4Aux
	 q/RoBJ96eWDMxPTQ9nQkkDA0Y2E/pmLDzMUqwiHM2GFrcgbx/0RwjkgThrIda/BroTc2p
	 nP0DJQj0Z5ygSrFAcSRAZ+uPPtKCu1k706U920Z/LRz9MDWWagZDVRe+Oc5Bx8NI83Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i3xU0gq/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFFA606A31C
	for <mptcp@lists.linux.dev>; Mon,  9 Nov 2026 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i3xU0gq/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A691F008A1;
	Mon,  9 Nov 2026 01:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186924;
	bh=G6Mzw56DWkrUhn/kgV3DP01ARhi/XkKLUQyL6zGrpPI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i3xU0gq/jThBluz1KRq69oUAvXe8jaSlij0+AycSadYG6zBeZFoleV3ZOWiapUuao
	 Ex74XDtgpAodlC69dok+x73Nwwo7jPcaZ2pc+qB7R++ibskKorWGGPVPtF5w4rvIf3
	 nZ/gUCTmqSjutQAzRcksK5qnWd6JbteBYakKRbyyAlMn+jmNNhhToQbA3gPBV0Gbgy
	 DkSVRiB6xtsQM0/8vi3OMLG+CN/9YYC4EKBxGxyGZA+6N7G0lgvq/lPD3sfNjP70Jn
	 gEdEX0pt6kUwp/Dm/qPfz9S7iVTa52z6zKScT73VShUhtVLtfTf3thigvxkefTrL8G
	 YIZw7g5zmcZ9w==
Subject:
 Re: [PATCH mptcp-next v7 5/7] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, yangang@kylinos.cn, kuba@kernel.org
Date: Mon, 09 Nov 2026 01:15:23 +0000
Message-ID: <179418692392.488855.3746637988097114791@kernel.org>
In-Reply-To: <4e7579752a4e3425830d8f66df284ca7ce61bdf1.1794053683.git.tanggeliang@kylinos.cn>
References: <4e7579752a4e3425830d8f66df284ca7ce61bdf1.1794053683.git.tanggeliang@kylinos.cn>
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

- [Low] The From: address and the Signed-off-by address of commit "mptcp:
  track app-limited state in mptcp_sendmsg" do not match.

--

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited(), which walks the subflows
and calls tcp_rate_check_app_limited() on each one when the MPTCP send
queue is empty and no retransmission is pending. It is called from
mptcp_sendmsg_locked(), so BBR and similar congestion controllers can
ignore rate samples taken while the connection is application-limited.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the From: and Signed-off-by: addresses don't match.

The author is recorded as:

  Author: Geliang Tang <geliang@kernel.org>

but the only trailer is:

  Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH. The last patch in
this series, "mptcp: update mptcp_check_readable", uses the kernel.org
address in its Signed-off-by.

Could this be resent with a matching From:, or with an extra
Signed-off-by: for geliang@kernel.org?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794053683.git.tanggeliang%40kylinos.cn
