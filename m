Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397763;
	b=fK3J1ZjLJOqfBKW6dSrnTG7ZgxjSEdHp5O7Rjd8n+5N3/tscZkvP9Qp0jQRkGbE7SC7g
	 F00FWwOvdCoFT4V054VUVbFF3Upxnujxk8dRSE5rUTtwXY4ho4ajdeLgcVo/CcCZ/BkHa
	 mlOJtnwZgLJp74Inf6gQBq6/ZvGSRpZqru2qcBvZitG3bV4D5WhaFhOK8Oyai/FEY/hph
	 6540oyDHo5JZ6NtJM2ygEMRjXfy4VkUzr3WA3JpA14dKhLEupQUwtoP1ZdpJUqVaUHoye
	 4ufwv4ZXBFZmvpTStEnHGunGSJiirC5KuAZWXxFrhoxwgm0DcGMGCaW19Nl3kVvY3OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397763;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vW+fFIQ+nvfH5yYpv6eJ1lv2Lfev3lBwiViTWVTneQ0=;
	b=ZnCJS8VfD1ohC/Qth614nAIHpMi59YPjy8aOw6DDnLNS1Rl5JRpPji6IBEHYUzd9z71d
	 F1PwfzJw7lwVrvO24GtrnYvZK+SOBsGOXaWz99lMBxVQp9YGlbjBhnrQJ6s7JGTN5qucm
	 Er/dt+dBHrTFgNtPEQr9FaUjNRF5cUy5+UIxIC+QEJJb+9WxJByw0p8KujgFjG05yh5/v
	 bZ45N0ehNjuQhe0AAm+2V6wlMkGd/L+WhyPmNiM3YbX7y88/wjJS0pbDT9jFrPYPTKApJ
	 4yJyjDjy+O+c6zqsG+EHmuQ+uRJYEu9jmsISrQaDByjP9xvh+QiM0bVwlQtGauX5VNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AenqwyyA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933B6606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AenqwyyA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9D81F0093A;
	Fri, 30 Oct 2026 22:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397763;
	bh=vW+fFIQ+nvfH5yYpv6eJ1lv2Lfev3lBwiViTWVTneQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AenqwyyAN3IJaobDemubtaLk/sYvo/VtGP8kOBiYnt6zCbM5WxYsipW9lJlTX/7rF
	 3hqYixHPu5YVWNcD7fCvc0OIyhMWjdAKflEbkDvYt8Uq9jk2Fje6MsBnWd/mkb1vaY
	 SD1fRZRw3bsnkG6EHE1NVMH5w28GN5uRjoieTg9OCbi9/eqoRDbDY2zysnSP8VGueX
	 sBu2gP0Ljcb5YarbxMlFJFq9r7TpfiZrH6huOh2OKvuNsHYadAMq+uvJMxFH+NYfNV
	 kZtB0ZCHViIBhPiedRJaagYKieAOERMj1nZnFIIojpwq3QHeliTirtEZe8UqQnR/gs
	 SDn/2OqDuigXw==
Subject:
 Re: [PATCH mptcp-next v2 4/5] mptcp: track app-limited state in mptcp_sendmsg
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 30 Oct 2026 22:02:42 +0000
Message-ID: <179339776278.3128.3969303217214480719@kernel.org>
In-Reply-To: =?utf-8?q?=3C2ff471fbc06c1c748865e61116b6f386310a4d00=2E1793258?=
 =?utf-8?q?749=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C2ff471fbc06c1c748865e61116b6f386310a4d00=2E17932587?=
 =?utf-8?q?49=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [Low] The From: address and the Signed-off-by: address do not match on
  commit "mptcp: track app-limited state in mptcp_sendmsg".

--

mptcp: track app-limited state in mptcp_sendmsg

This commit adds mptcp_rate_check_app_limited(), which walks every
subflow and calls tcp_rate_check_app_limited() under each subflow's
socket lock. It returns early if the msk still has unsent or re-injected
data. The helper is called from mptcp_sendmsg_locked() so that subflow
rate samples are marked app-limited when the MPTCP connection really is
application-limited.

> Author: Geliang Tang <geliang@kernel.org>

[ ... ]

>     Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the Signed-off-by address
don't match. The author is recorded as geliang@kernel.org, while the only
Signed-off-by trailer uses tanggeliang@kylinos.cn. checkpatch.pl reports
this as FROM_SIGN_OFF_MISMATCH.

The first patch in this series ("mptcp: update mptcp_check_readable")
uses geliang@kernel.org in its Signed-off-by. The same mismatch shows up
on "mptcp: implement peek_len for proto_ops", "mptcp: add sendmsg_locked
to proto_ops" and "selftests: mptcp: sockopt: check app_limited".

Could the identities be made consistent, or a Signed-off-by be added for
the From: address?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793258749.git.tanggeliang%40kylinos.cn
