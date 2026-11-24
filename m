Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563039;
	b=R/MldViuyWSN4CBGz+cgwymrx4Uiv89WROgkPbRtqvxbn/rn3UOVUGAO0CRswyJj090p
	 dh87rEkSooEDnV+kjtgTd9n8gvzntWqiTyCPcJfIgTdfI0TcTuebm819mIkRQLdsCvHgh
	 XfuNS/t+2EtM0Kh0aV6Xpyx8q4Nfxe34G8rmvZ19ncG6RZj/HPwYCeK1qWDtDdD0ZZRQC
	 B+f4YYGGY4KuAGfWDsAeXYgtiNeyOi79fusFHmPXK3WatCZPUvRH9ZBCNb9IcYK1c/WH7
	 /44zLwy7AZpw5l/cvPTtyFls1zehTJ5yeZxcoL36x8oOtA2Pmss6n1ThL+7+PUFSO7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563039;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=os0sLy+/frBWO3Z4Mr20sjmL8G9pzr45/cj7904wOWE=;
	b=cB3UBqKw8DODJxJcGEOSRCLxJ0kBMTod7pPvBVLPv3V7hx4REkXQYrjwiq6n1+NLO+Ii
	 bhjTo9S1CLyVEZdSB7uFYXGN+LN0hzLtdPRX66GMzwamwr9Cv8DktwSN0SHMwudAGCmqv
	 f6G+R7vx+VaajmYknDKZqiPdg+5jIpAxXthIo3SI2mPbggDMRku8loIidvq6jjyAS/fZ2
	 UmWy9t7XWDz1O5ADm5JkvIcqgV1zb5A5NgVejxGgRsaC6cI2/AyI+QMMcmmXZaRUm6l9v
	 apA5Dnnx2jb7U4/fQ6uy7A8La05knX/p+o0+IlkaPnXd9iVRsAYXep6dXVv200n5Iig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyBj6DNw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F85606A32C
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EyBj6DNw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3871F000C6;
	Tue, 24 Nov 2026 23:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563039;
	bh=os0sLy+/frBWO3Z4Mr20sjmL8G9pzr45/cj7904wOWE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EyBj6DNwbNLywif8D6Y493IH5NtPJ/gIdIkb9FhNqxUInvGuq7ZCCo5Jlf/s0gJ4h
	 IsLc1MWSAHDZgbwVx+S9E8dGrlQkZjYZXCM57Ht04wcEJFEmgxoXKS5hUyf7lCJVkb
	 ysh52wvwbzp5b7Jv8PZz/VkRQ+3YsPVSDRXjDCIb2ZzdRA3S7jBx7yFysdN1XMB51g
	 eo/sZS3DdrdacvJm+4yq15nWpNJUtaXS4gGU00l+UUFDH4TIoJftM0umQFKRii1W1I
	 zDYwhO+BLY5ykBH4DdY0HYLhWrTYOv1bN/MShzr/Jcrzr31A4q6IfxXF6cB2FRGOlO
	 el9DFiLXnWneA==
Subject:
 Re: [PATCH mptcp-next v8 2/7] mptcp: use local variable tp in sendmsg_frag
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:38 +0000
Message-ID: <179556303882.3133.16814177710763422277@kernel.org>
In-Reply-To: <ef8555540d1f14932280a8f9b0259a953969ebe1.1795421388.git.tanggeliang@kylinos.cn>
References: <ef8555540d1f14932280a8f9b0259a953969ebe1.1795421388.git.tanggeliang@kylinos.cn>
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

- [Low] The commit message of "mptcp: use local variable tp in
  sendmsg_frag" gets the reason for the change wrong.
- [Low] The commit author address does not match any Signed-off-by
  address.

--

mptcp: use local variable tp in sendmsg_frag

This commit adds a local tcp_sock pointer tp to mptcp_sendmsg_frag() in
net/mptcp/protocol.c. It replaces the repeated tcp_sk(ssk) calls in the
tcp_mark_push() calls and the write_seq update.

> mptcp: use local variable tp in sendmsg_frag
>
> In mptcp_sendmsg_frag(), tcp_sk(ssk) is called multiple times.
> Introduce a local variable 'tp' to hold the tcp_sock pointer and
> use it throughout the function. This avoids repeated dereferencing
> and improves code readability, with no functional change.

[Severity: Low]
Is "avoids repeated dereferencing" accurate here? tcp_sk() does not read
any memory. It only converts the pointer at compile time:

include/linux/tcp.h:
#define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)

inet_conn.icsk_inet.sk is the first member at every level of nesting, so
the conversion is effectively a cast. The compiler should emit the same
code with or without the new variable.

Could the commit message drop the dereferencing wording and keep only the
readability reason? The "no functional change" part looks correct.

> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
The author address and the sign-off address are different. The author is
Geliang Tang <geliang@kernel.org>, but the only Signed-off-by uses
tanggeliang@kylinos.cn.

checkpatch.pl reports this as FROM_SIGN_OFF_MISMATCH. The other patches in
the series have the same mismatch.

The mismatch may have come from an in-body From: line being dropped when
the patch was applied. Could the series be resent with a matching author
address, or with an in-body "From: Geliang Tang <tanggeliang@kylinos.cn>"
line?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
