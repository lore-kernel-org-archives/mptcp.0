Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704605;
	b=NoD+qhKW0/JXF1CbwYRNb6W7gLsGsm+eUABgKtK5OemtQcalT+f+coW+lkGLXUnTf4gK
	 6gvEBj55U8fsAVjncV6bSEjSMMoQ7kBK7Jr8q+BRYSz13UnKc6b+gjTQVeGdUA26N2cOx
	 ETZNQ8rz3mN57KYRm96uW0BJQPnRIeBSm10uW+mfO/MtnSRFFXERW/q9p2W0iPOT2kGtp
	 gVMSjOCK7ebXLHi4VLoO1cYHB6lj1jyhR9YDwatuxQYaWbA+AF7JAJCWIIy6NOiEil6J8
	 CvQNuX6cV+gYpUpvnMmXynQvAN9NqZXM9f92b3CkmbKnhrhGgkAd4CIEnZ+2EOXojEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704605;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UdGceef4pegtxKK+YwuFRJv6UHReAQ38bdz3sHhHMgs=;
	b=fvO7PFragoiFO5+6vahukD7hOWJDcxGimSfjZWbW4oOqvDa7j10tuHSYTnGvW7O7JXKI
	 Z/dtLHQKH957IjCUvS16aaGHHPzcaqj0lrx/33miGJu/qXcf05WeZyTQhcQme3r1jURhr
	 JTHFQhVkyetMxNoIyRLrKYume6T4pRnui2CKPtC6+rk/3t5RLRt/xI8k8tzt7UYZyxFPf
	 DSda7FQemwQBqwFLDPuHpRmP2ZGIVIdh4qX3D4PnfLXnFXlTX6fVmHRDOreHiVYL8XkmK
	 AKzS0NlXh8C0cVr0wDA5L5WqucMx0tgTvEoA0yaxwbQeXxKZ/z5wvgcHO3dTFLDA7Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oj6BsGNN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67FC606A327
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oj6BsGNN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E881F000C4;
	Sun, 15 Nov 2026 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704604;
	bh=UdGceef4pegtxKK+YwuFRJv6UHReAQ38bdz3sHhHMgs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Oj6BsGNNlhco5T9mzSXXjWBgQIDdQVLothASujSwkbFcH4GtJA2m+Ubw88LleZ/PM
	 zHFemmtExygUaLD3Njvw3kTn8UdvO2shd6/OCvva3WZ1yTiY39EsEWmSJ+hO4CpFTJ
	 /vIKzSuCA88KqbHzv5fCiddZtXqo+NdROASFpRm/EeyNn4FAbEmYVCJhD9Dh9GzBFb
	 reUJp3hn238IOCVOXAkbihm33hzO9ZzydF3o9TpRElsXAhFpn4ODe0gyob4eee27je
	 RdqaZpBqGON+SVe6DDi6i/PluqpLntv+lpq8Yh1fs5Japu+FgqqKPIpaXpe0s7jwWy
	 DOExRjBCfzxhg==
Subject: Re: [PATCH mptcp-net v26 1/8] mptcp: fix TFO SIOCINQ overflow in
 mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Sun, 15 Nov 2026 01:03:23 +0000
Message-ID: <179470460390.488855.6606812255432269348@kernel.org>
In-Reply-To: <e288e463e3eed170694151450d5508e9df97e497.1794563432.git.tanggeliang@kylinos.cn>
References: <e288e463e3eed170694151450d5508e9df97e497.1794563432.git.tanggeliang@kylinos.cn>
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

- [Low] The email in the From: line does not match the author's Signed-
  off-by: email.

--

mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint

This commit changes mptcp_inq_hint() so it computes the available bytes
with mptcp_data_avail() rather than ack_seq minus the head skb's map_seq.
On passive TFO connections the old calculation reported INT_MAX, and it
also broke receive buffer autotuning. After DATA_FIN, non-TFO connections
now report N rather than N+1 unread bytes.

> Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
> Co-developed-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author address and the sign-off address don't
match. The commit author is:

    Geliang Tang <geliang@kernel.org>

The only sign-off from Geliang is:

    Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

None of the Signed-off-by lines use the From: address, so checkpatch.pl
will report FROM_SIGN_OFF_MISMATCH. Could a Signed-off-by with
geliang@kernel.org be added, or the From: line be changed to
tanggeliang@kylinos.cn?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794563432.git.tanggeliang%40kylinos.cn
