Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162976;
	b=3F3iAHD1nxp0Xoz4oZjFszpzugPbS2DjAnl6BPi0o0IiAE3muGZ0JmSfdUxSpA7eOBw5
	 Wc78G/OL4q8oW0/szImsXFOTvs3BDZXjnr+LDfV5nOT3dflVZEsIetXeQ2bFYS0v+4laB
	 J3odAwn23Vx+ojO8+OEIGlA9IleyMT5XKAn+KyfOuhS6BFKQTIXvU5PnvezJyK8xdVBvQ
	 bD/t/dGTHstchHyS+CqilROPUsz+9US6nKLxTdsKjwGVqWe/8G4cvx7z2pzBcaK1dCI6Z
	 /4Ltlfspj0T/tAUMZpohvO07OjkpTMF+YbsbBSQEbpPuO4RLoRHFyAJRk1QB4T19tng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162976;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GjziEvlqFaNa2wofmK1lX3Z0KjbRFoJjP3MVUywEbsc=;
	b=kHH9ekW2VzHBPmPf/7mKR5vi1D+uOw9R0ONdtzOE6wysWYURnNeyau3CnBIZfOb6BasP
	 fmlXzy99qS1Sxr08ImOyb5D681UHtHna/3r+ygBByuA4xDhrzBdtZDThgBm65NpaO4PpZ
	 SQdBfVE+gCdGhEOg29aptrmKvVs6VWIGbSg4iXq2r07jzygHbBZAHFDJm3dRIF9x/5AAM
	 XaTdjV3yWqET0xei+FYYGqMsthn4GlASSF6Iqxttvs74LmVyDHFJrhMSywbB4hhm1fh5D
	 lHhFZTCOuYKLgQ8tnQmt4vz/uWW0vo15ObDFnypZcXH6xHWucgJe4+bd0gCbQTncWfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeEC3Gtt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BFA606A333;
	Fri, 20 Nov 2026 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZeEC3Gtt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2137A1F000C4;
	Fri, 20 Nov 2026 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162975;
	bh=GjziEvlqFaNa2wofmK1lX3Z0KjbRFoJjP3MVUywEbsc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZeEC3Gttzyhra6djfjp/IJiPaGsCyab2JsZqXZ1Mfezp+0kUBFIQPKXrx50DuIVmt
	 kEoFzeWnpRpFyBYiR8T9JMsQN86Uqq3P2z68omshkOm6Vt9O1PjyoAvxTuKf+dY9rD
	 cCdrHzKHNmsG8Y8paic/ksPnQO/2GGzvKaAbbWpoSBlub8OAabbyD/rDjalOa7eoUK
	 2+Q6QjgdUbnxZlUilijI5M1JwdMPkX30Bb7YePVQtN5XxTooBYqeUrbPvFj07nDm3X
	 L/tmX7IhhjKN9UOP0YDqCokp9gALxnzrLCDR6V2cTY9+XMfwP46LXAZIS+a//jbVtr
	 CGnSX5Uvr2MEw==
Subject:
 Re: [PATCH net 3/3] mptcp: exclude MSG_PEEK from receive buffer autotuning
From: netdev-bot+sashiko@kernel.org
To: llleigoing@outlook.com
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, edumazet@kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, martineau@kernel.org,
 geliang@kernel.org
Date: Fri, 20 Nov 2026 08:22:54 +0000
Message-ID: <179516297471.3136.7019370824354358240@kernel.org>
In-Reply-To: <20261117052200.1507847-4-llleigoing@outlook.com>
References: <20261117052200.1507847-4-llleigoing@outlook.com>
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

- [Low] The name in the Signed-off-by tag does not match the author name.

--

mptcp: exclude MSG_PEEK from receive buffer autotuning

This patch stops __mptcp_recvmsg_mskq() from passing bytes copied by
MSG_PEEK to mptcp_rcv_space_adjust(). Repeated peeks no longer count the
same queued data as new application consumption, which could inflate
sk_rcvbuf. This restores the MSG_PEEK check that was dropped by commit
581302298524 ("mptcp: error out earlier on disconnect").

> Author: lei lei <llleigoing@outlook.com>

[ ... ]

> Signed-off-by: lllei <llleigoing@outlook.com>

[Severity: Low]
This isn't a bug, but the name in the Signed-off-by tag ("lllei") does
not match the author name ("lei lei"). The email address is the same in
both.

checkpatch.pl reports this as a From:/Signed-off-by: name mismatch.

Could the sign-off be changed to match the author identity, using the
real name, in a v2?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117052200.1507847-1-llleigoing%40outlook.com
