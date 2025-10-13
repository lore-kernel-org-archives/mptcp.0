Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1B253951
	for <mptcp@lists.linux.dev>; Mon, 13 Oct 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358198; cv=none; b=G1Jb0DMvcvGAjIwC8RwwjF4SIwPDcvFhjV2MFvOUU1XnMDKxQxeFlobSi9WAxh1K2QRma9Ge3ipqnwhMWL5bln4uOYaBKhwL/fM/fGGQ3YDKF26wUC50dU5QgFoVmsAlWR3iXj/Fs0Pib2tEKjhQZ7W/3EjVZPHfZ88WME6m178=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358198; c=relaxed/simple;
	bh=13HR7N/hMdgRYUEplNzXfVZ4jyv3RMuI+khYdh7e05c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XON7Kvhi+sDa2VsVpyTMnl6KH4Yccd2dco/uF2Ys3ksczLj30NLjyD/037tXpi2YpqSOUqOSEuTI6dmhCzgVgqueOlKSC5a7BNHBn84O1yons0ScPueVnuL/rJGEfw1InO6IUPts6N7ZsqwZQ8v5Qq3Du9yiY+jOdGm+IMMd3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHEkDP0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHEkDP0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5532FC4CEE7;
	Mon, 13 Oct 2025 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760358197;
	bh=13HR7N/hMdgRYUEplNzXfVZ4jyv3RMuI+khYdh7e05c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RHEkDP0UblvK5b674tQdc81nY+J8CPmBKANoz3DwMC+4e20Ys3Bwu85RAZgrChYu/
	 6KMa+lnWcfpK5dK9eGkr/DWafAg7ya/qKQmi8u2XAExWeI1p46/ijquSax84BGONP8
	 nVahNpcmgPHmP3QpZ3PDbff6jgjoMr/HngeJJ418mB+RjT7KQeRBVAQfLERMhXcWt8
	 4pvtwdWv06gUGVeNWd4cX1C9lG229AuhWMhgTyTnjNAvg/ygomqXoS0jKM0zK/jRM4
	 59ftQxcByweu66up8Iz55Z77ehzen+3tNkZsXM2XVNEAPVCQTX8tA/+fUgbkSHSfNs
	 RHA9yK4LxFqYw==
Date: Mon, 13 Oct 2025 14:23:09 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Message-ID: <b4d4604d-317f-4636-a87e-5a99b5a13207@kernel.org>
In-Reply-To: <b760f349-b2a2-2259-7038-ef101aaa0642@gmail.com>
References: <20251013101946.248420-1-yangang@kylinos.cn> <b760f349-b2a2-2259-7038-ef101aaa0642@gmail.com>
Subject: Re: [PATCH] gen_initramfs.sh: use 'date -u' to get Timestamp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <b4d4604d-317f-4636-a87e-5a99b5a13207@kernel.org>

Hi Gang,

13 Oct 2025 13:50:42 MPTCP CI <wpasupplicant.patchew@gmail.com>:

> Hi Gang,
>
> Thank you for your modifications, that's great!
>
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed=
 test(s): packetdrill_fastclose selftest_simult_flows =F0=9F=94=B4
> - KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
> - KVM Validation: btf-normal (only bpftest_all): Script error! =E2=9D=93
> - KVM Validation: btf-debug (only bpftest_all): Script error! =E2=9D=93

FYI, this issue has also been fixed in our tree, but just after you sent
your patch:

https://git.kernel.org/bpf/bpf/c/de7342228b73

Cheers,
Matt
