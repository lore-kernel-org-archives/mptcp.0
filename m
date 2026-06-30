Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2457E3FBB72;
	Tue, 30 Jun 2026 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817775; cv=none; b=KUdSA4r6zp/tWfk5ed1SCKm0GgfqwPEGykwQBiknJQ96ozTVaWWWQUMeDHDcvQ9EOfEeGpEDwldIhfDk1+jaYsd3bVAKRkUp4zaD/JO+1C8LZ7OTzql+W83WM9iOVMj2BqO9SGHeb/DBsFe0fl/mvxkL2sR2iaBV/q2OnM+ZR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817775; c=relaxed/simple;
	bh=LDtINCcCDbAQN/lDJwIzHf34H7YwfSI1iyKLb8sI5Ac=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mpOJTirwZp/nZgrsOeN42+Jkk1H2+XWD6b0LfYZxfMvCprs2Y9GTraVrLWY4YGXisI3yhEjp8yi7yILHWuqQRLrsbXkbjMDnfFo2Q7auPZWszWG1n9ARaS/JTwkqHH1l78kuBYLxmBQnq6XpDoSgv+iHia7q5bhe/3SEzCH3MIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJb3XyLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJb3XyLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0691F000E9;
	Tue, 30 Jun 2026 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817773;
	bh=3KMj5bAXV72/vr7i0iWBQZicBPu9LajLdf1dnb0ON3o=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=TJb3XyLlV69QofssxSQ6LDnIqB9DgMuYHF2J+gykUHK+WcbxktgXa8N260MmTValQ
	 dLgHkDs/vbXl6qrTn6559/gkWvt7gmK/zqvAeJfz93dndhWCX+yXpYwNHlZdGkluN+
	 oH8LmrzMh4u84voT8ohJ2rCaOKzCvgJaoLNosUePGuchunDF0XbH8C7MO+ZxaLogWr
	 4aAf5Eadof5NzP1A7Xq/yQxNVJIEiLJE6PCcYsgX2TxQJEiOIkNg6xI35xWjjOjkmL
	 yKnSM15co6nI0S8bo9r7sPnWNtY2wL1wvCOIFZunJ+X7gVe8fAJuhvxnLclM9Ogsbt
	 FRFIuSXnYEnzQ==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Mask socket type flags in
 mptcpify prog
From: Matthieu Baerts <matttbe@kernel.org>
To: Guillaume Maudoux <layus.on@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, mptcp@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260630095723.564392-1-layus.on@gmail.com>
References: <20260630095723.564392-1-layus.on@gmail.com>
Date: Tue, 30 Jun 2026 13:09:22 +0200
Message-Id: <178281776277.2535326.16467031353021194373.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1067; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LDtINCcCDbAQN/lDJwIzHf34H7YwfSI1iyKLb8sI5Ac=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKcF7+aGNfXv+Rfxg/NHud1t2xzJBzkuYxqjhmnZr8rn
 394z7KmjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIm4ZzH8L75basBx51rk3cTZ
 R5u+77M6pXH4I88Xv7lJ8+KeVFiYGDL8D7B5Kfbv5LnC5/WLVCWfVD7v520oW9bBVvbsqP6Z4KQ
 fbAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi Guillaume,

Thank you for sharing this fix!

> The mptcpify BPF prog upgrades eligible TCP sockets to MPTCP, but only
> when the socket type is exactly SOCK_STREAM. Its update_socket_protocol()
> hook runs on the raw type from userspace, before the socket core masks
> it with SOCK_TYPE_MASK, so the type may still carry SOCK_CLOEXEC or
> SOCK_NONBLOCK in its upper bits and the equality check fails.
>
> As a result, a socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0) -- what
> common libraries do by default -- is silently left as plain TCP. This
> was hit in practice with curl. Since mptcpify.c is referenced as example
> code for enabling MPTCP transparently, the same mistake is likely to be
> copied into real deployments where it fails the same way and is hard to
> diagnose.

Good idea to fix this code in mptcpify.c, which is indeed used as a
reference, and ends up in real deployments.

The modifications look good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
