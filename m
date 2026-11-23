Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427838;
	b=mUVD1o+LNUy1GckFiXyDhNCHWY6Y2kUwneQFIu6tcrUp/Geq6PTm2ZCosatk/z9qcaWc
	 oGpUNa1b/MWjErLd2HyBoPNeij8BeTFSIbbqeUwRXLYVzEghd1O5xTkTQNAbzpAhfTrKJ
	 xEFdFgd/VrQ3C80fHjvhUA0Wg4Kv0DMDeokikHN2z86XH3hDAn92mAabvz97tXxNAUwJX
	 flh1k4ovdVx9q00l4CIg8BxWPf9vts65UTd7q26QwwFx4oRT1xr7iodqHZVZwShmafQsm
	 FELQYILB3PhyVccHXDflA8ED1wwpm/bz62H8k4UrQeFtz0vAdEJrn9BqwlMRo9Lxp0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427838;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4s8ObVh8aYrx9unOg3Fhb+rodQ27w3kLEqVCY36mwwQ=;
	b=TK0vUv4hYdEjUBRJWpxIwwqZnaqA9xZMuDE9cJrHOgDgDEXdr43vWLEEIQR/EoFZv1wz
	 j/2gWCi2wx9O3fHrATi/W+KBUk+FTp70EJQPXRBKxf5lvvAjXygJQ5Hing//1qQgGA6ZZ
	 fbqEgyCBiczoxxIyCIBddqSMDKxLmS9X1eYK0s/PNiz0S7et59aDcNfJQMzI9lZx/l/BI
	 ll89fFiO/OF3KX/mJ2oJOSgpnfXsqnWGD2gXv7ZO1V7Qlq8dSEQ6Ls7Dzvr6+FFJqZcnL
	 4GjmYSRYJLxKBjEf5nz14Vi2f4s7gwZj7JxBlxhxl8rq4hsqsjETrrt1pVOOiZfiuMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KhPbG/Co";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4095D606A31E
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhPbG/Co
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22501F0089E
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 09:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795427837;
	bh=4s8ObVh8aYrx9unOg3Fhb+rodQ27w3kLEqVCY36mwwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KhPbG/CoifjG+/yNpmHATBRMfFPEhDxkvSiMArJ2Io+DP3li+Gfx3z/uGaXDVzLAf
	 z8U7loBNU/h9j9f1uSWcPTK29wLWcsEzD5rE5QenWvJ2BW/1uKxVLRKisUUDd9hoDh
	 6VadaL+BpdddiZrbbFkTy6cU/gy8vVcUotFjjbfOzEYxpN9NbSX2h0Rk2SQKO6D+YU
	 ZFsj7hz5JHcHXYV6Ce1IKcHCylniO4M0uqqGk0/2OqamGelhrV00Hmz2l8XcODXe6A
	 IURHeVHzq+t+jxLrgP0wBlILq3V1kTd0HpaWCQ1HZudIRI+1L5i54NvRKy8sESCLM0
	 OnQAtsRg5DmEQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-57728d87699so1202644b6e.2
        for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 01:57:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH2EDGm/SWNWlxULX5wkrn0ZzMO+PRZ8lIX1TBJSfON/gjahN29o/hJoQsHA8eQNmm0igK7DQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9RayJ092oautf0AUPQOW5oakCrnUbnMOaaAeA73k7y9IyeYzSQ
	Bj8nKYzxug5lm1jZOCwMC4iNxm3P/di8DxZC6MeaHktyXAgF3aelDitrad/Ph2HvQz/UdaUFrt7
	VduTxBYXoa8V4GLb180axsSq/HjEDSGs=
X-Received: by 2002:a05:6808:4f4f:b0:56a:dc07:f218 with SMTP id
 5614622812f47-57a0a10c801mr12163511b6e.20.1795427837069; Mon, 23 Nov 2026
 01:57:17 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <cover.1795424546.git.x-professor@outlook.com>
In-Reply-To: <cover.1795424546.git.x-professor@outlook.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 23 Nov 2026 10:57:06 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqKAmkvqD+WMms7ZCwGDm3QE_Aw8VfqA=Xc6k1=8O-8Rg@mail.gmail.com>
X-Gm-Features: Aa3M54p7KYmo2scuMtB2OXhhali3YsSnFeJgNMDOhVNqlLJAMAK0n7zrYR_BrAM
Message-ID: <CAL4WiiqKAmkvqD+WMms7ZCwGDm3QE_Aw8VfqA=Xc6k1=8O-8Rg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"gang.yan@linux.dev" <gang.yan@linux.dev>, "kuniyu@google.com" <kuniyu@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"matttbe@kernel.org" <matttbe@kernel.org>, "martineau@kernel.org" <martineau@kernel.org>, 
	"geliang@kernel.org" <geliang@kernel.org>, "ycheng@google.com" <ycheng@google.com>, 
	"weiwan@google.com" <weiwan@google.com>, "joel.granados@kernel.org" <joel.granados@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 23 nov. 2026 =C3=A0 10:34, Yingjie Wang <x-professor@outlook.com> a=
 =C3=A9crit :
>
> The TCP Fast Open and MPTCP blackhole timeout calculations can wrap in
> 32-bit unsigned arithmetic, even on 64-bit kernels. With HZ=3D1000 and a
> 64-fold backoff, 67109 seconds becomes 8.7 seconds instead of about
> 50 days.
>
> Compute both delays in u64, cap them at MAX_JIFFY_OFFSET, and limit both
> initial timeout sysctls to one day. The new input limits reject values
> that were previously accepted, so this series remains for net-next and
> is not intended for stable.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
