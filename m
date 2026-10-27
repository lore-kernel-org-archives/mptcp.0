Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134544;
	b=v9vssl2hjzQ8dogW45S9GyYG8KvplY9fEdbVuiBSxEVYhqeNu0wsP2aWBDCYOfs8ED1a
	 tfVC7/OQH6sTt4IaeXLcPhpKMzAAcuMXf6AU1qGIgWdmQJx1x1qrrV61gDVBhIy0aZ8UJ
	 zyorpHeDxSaZvv/Xf9nYbyPHqlc1pjCjR10BVr9w0bLee6yvBBmudAHLaU4JCsx9JzTTe
	 TOTtu5XPE8G0pisOXaXFCSH5U01QDCaT43EOvQHKfI590kArxVOx/xA7qT6fZ4UMSgWH9
	 f7LaPuMG/0IEuYJmLjrJOkHXA3ndH3PRZo3B4AGdjFTXViESUyd2uDpomqbJ4v2T1iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134544;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=9pYpjR0jbFyhhOGSr1aqWt3YSZWfFXi3Z/Ivd5GARQQ=;
	b=FDf7+K+8tjtBAr2EhYVWg4OC4MuBZJoKmu8zSsbPXLgcs0roBnq82lEMv5Xit9FJXowU
	 skdLPBtAxaJO+MNAJxdwQJez0MaPrtVFR/Ht+hB4HhFXng32COmsCI/CfQvNCV8AIRgd0
	 CkmfytMmMtdeyTWSIbAR3srEFxweOhcATqyQRMNAozZ58hSPFrWJPz4Ycg6G9b5KymyT/
	 Q0dPw8+zSMkLGCunnApaJ4taFajoI30EWfJZSak6MF1SbSIBwQ+YO98P6kagFLMLnO9OT
	 Y69/pmrZDoj+DqwUmr48ux1Nofm3b8rmMfdCLEe65/1GUq5ajA+ffQHBe3ZFzKda6xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Inpt5WYI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C137606A320
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 20:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Inpt5WYI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BEA1F01828;
	Tue, 27 Oct 2026 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793134544;
	bh=9pYpjR0jbFyhhOGSr1aqWt3YSZWfFXi3Z/Ivd5GARQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Inpt5WYIPYKx0sp8trytg4hd109W80IVJOE95swSve9n3+DFNPL96+fP9Q5sI5GkG
	 btL0y+uj5YZA8pPX7hk0LDG418xtpHfAmUskqzvq6svYphHbZxcnZmCt2uj3mmoFe2
	 dWztaqdp+xV5Icroat3/zBBiTybfZlOAEHnlnlFx/9AJFSJ/Nv9dPunWRNouF8qXVi
	 T7+AcNa0COpb/jLdIxdNvWpKPip2Hkim96klEP+VzbJ2cKxroBSmlXS2quDZ79KvzP
	 YCOPPde3vvgplcaH4v1drsvq9SvNG8jFma1e3jS7IagAekYfYQ5K9/8gndG2JegZUn
	 X2RAEPy6hK/4g==
Subject:
 Re: [PATCH mptcp-next 5/6] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Tue, 27 Oct 2026 20:55:43 +0000
Message-ID: <179313454353.3132.17889771780482672469@kernel.org>
In-Reply-To: =?utf-8?q?=3Cca74735533f3c29d3bf81fc94d7a61c0a1db89f2=2E1792999?=
 =?utf-8?q?988=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Cca74735533f3c29d3bf81fc94d7a61c0a1db89f2=2E17929999?=
 =?utf-8?q?88=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] Author and Signed-off-by addresses don't match.

--

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited(), which runs
tcp_rate_check_app_limited() on every subflow under the subflow socket
lock. It returns early when the msk still has unsent or re-injected data.
mptcp_sendmsg_locked() calls it so that congestion controllers such as
BBR can ignore rate samples taken while the connection is
application-limited.

> Author: Geliang Tang <geliang@kernel.org>
> ...
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but should the Signed-off-by address match the author
address here?

The author is geliang@kernel.org and the only Signed-off-by uses
tanggeliang@kylinos.cn. checkpatch.pl will report FROM_SIGN_OFF_MISMATCH
for this.

The first patch in this series, "mptcp: update mptcp_check_readable",
is signed off with geliang@kernel.org. Is the different address on this
patch accidental?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792999988.git.tanggeliang%40kylinos.cn
