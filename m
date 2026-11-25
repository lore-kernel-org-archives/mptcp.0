Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630914;
	b=DfefsqgDcWTAV9yj66N3iE23ofqkH9YRHdsBpJrKP9DlpWixicyHAbCXIsWOQEiz3XQ5
	 DGvL92RZPPUr3FqKomkUB9gfbxFJhXR+ik0OgWsvHX0XdHNAFwcAlM+NMOAvbPWGZYkd+
	 ja31kf7f4Twrjujs4EHKD4hO/2CwxGfO0ZaHQYOOh/muIujGbj1nHVkXpW9dzGLmof4Z5
	 UwUwv5U4Flu/EmxKbr0MJYXAInocPnmUi73MimmUwZZavkdTiA2k7D7f8Z8QLg27u2PFj
	 8Qudbm4BMQRddVRyemtQJt0bw1iwZVDQysaM/no6YuA91b32Fg9pTo/VGcraAmjpwPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630914;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2/M8DRfIY/TYAtoZwAoan41mnD0wQzD0fABvuqoVL9o=;
	b=B+yeGksz2Df8DX8ubylX4A2xcWtUP/1Y68TDYNuptYBVpqfRaQ9Mh+FRDIu3uvt0B8QL
	 1uhb9e83U5upA+jM3te6cwpEST25J+J+Qw0jkjDH07jXqmQpzkjuMXOv6ZV6YdrUuJif1
	 qnsqxxKNOD7hm5kcM9JhittV+gnUasLNLEh5Vdy+4I2UF0r9iKIMAYfim0heDguUGwCR2
	 KO9IDJNPdZsh6If+hJzUH9uQouMk9xXx1GNkyeC3KctjcxjWpr2fjKhCpF1ELLq5Ra7QC
	 6RgizYEVxOwtStUq6UEA0lFCR0Xfjm2alu4wb6bqvVvZhzAyRisc10JGGcMtMW0tVvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMGSukXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C826606A31E
	for <mptcp@lists.linux.dev>; Wed, 25 Nov 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hMGSukXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74C21F000C4;
	Wed, 25 Nov 2026 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630914;
	bh=2/M8DRfIY/TYAtoZwAoan41mnD0wQzD0fABvuqoVL9o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hMGSukXjL7L88o2mJZZolxogwV5yR8JSCOsH6oN5+1vKjiXYGnYrLWlY4AIN42SMc
	 OOvC0fDD5vtMBMNWuLmS2+vFzkXkLpx+WQxRqMcrNdSJS1bkXYhSif0+5BPlLUBvrT
	 64GdE+3Lmm0Vwtpd5uLQwS8PBuKW9aie9bGj1u00Utfn0izcSVXcrbWcE26hGr87+r
	 9lIdt8L8OK+mloQWyruXZcTAKZ6ZToxCx8krHOHUXaifYD7fDMW64N9sKBAnSkG21m
	 qWxTOqxL34JShT3yvBrnXnmsFVfP/qsTRPRRrIRkezkoaQXY//y3iCVk9XaoNj0H8g
	 rxabbijSzdCKQ==
Message-ID: <28a5ce9c-900b-4145-bc99-f6842f19572e@kernel.org>
Date: Wed, 25 Nov 2026 19:21:50 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v8 2/2] selftests: mptcp: join: re-add the
 initial subflow endp with fullmesh
Content-Language: fr
To: Abdul Wasey <w453y.me@gmail.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261024111842.1069878-1-w453y.me@gmail.com>
 <20261024111842.1069878-3-w453y.me@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261024111842.1069878-3-w453y.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Abdul,

On 24/10/2026 13:18, Abdul Wasey wrote:
> The "delete and re-add" test validates the removal and the re-addition
> of the endpoint used by the initial subflow, but without the fullmesh
> flag.
> 
> Do the same with the fullmesh flag: with a second subflow, after a reset
> of the initial subflow, and with the initial subflow only, then re-adding
> its endpoint or adding another one. Without the previous patch, no new
> subflow is created, except when adding another endpoint.

Thank you for these patches, and for your patience.

Regarding the new tests, I think we should only add the minimum and
avoid overlapping. Currently, these patches add 2 minutes in a debug
build on the CI.

I think it would be better to drop the 4th subtest because it is
redundant (and already passing before the previous patch). I would also
combine 1st and 3rd ones to save time with the setup: at the end of the
1st one, so after the re-add, delete both endpoints and check there are
0 subflows ; re-add the ID 0 endpoint alone and check there is 1 subflow
; update the checks (wait_mpj 3, chk_join_nr 3 3 3, and the RM counters
I suppose).

Because you might not remember all that from one month ago, please tell
me if it is not clear or if you prefer me to edit the patch.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

