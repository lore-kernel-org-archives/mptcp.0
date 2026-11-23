Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429102;
	b=pZKVGzYYEY5Sou0EBgfxOydReiWYGW47PUjGaVT0rVae8mAshbnPe0FyUwPDvaHlZokq
	 nPp6nLCHFy8YeV6H/PODrFdCTKr1FUvYcFfZlcmG4/5Z9fYtZXicDFzHJtwfuFIvVm3UF
	 kx5BPV1T6FW62D3VQEl0T7kLrxQB3x/qQ+j9UYXooNnJKwpZ38YQ1vztokI4CY78fUQf5
	 /GxG2QzYWoApBJFuMaMO6u/ZPE+2ozDiU98OuEYsyz+cIafNNTcRzPenbV9IRnGZZxS6J
	 euG9eGOr1jnmBJy0FqgCNPsxmd5WE5660CmfT9acC0CK4sHhH1SIPh4He1+B0lqrUsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429102;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QaFTrSB1UKnHwp3T3biJ5IgaoaKliB/c0FJCbEihJKo=;
	b=dOR5utwroTcJol5DUp8EflSbpobwVAEtOevciCFXwBS4fqxaRXCx4ItrdGSQuEyfm1DF
	 ZbvOCUtznffjNYCb4jYS/XLF/LgEct9jafX1plGfp9xEM9bpXsaoQGfAkyRv77R29s6of
	 aKDqhEqhlGV5NKLqSaSWmflTTBj5kUR5BZ83WoGh+a6DvEuFNsiQZcKSp5j84LRMSa51a
	 D6Uuj+nGpKgejoSRhmmhjp42KgTi8Js4xa3wI1r5IBSJ2D7JE3snVrVOxUr5n9vDp8gJ6
	 0Hmi9KP5utk0h+lzrvDxR2b5v3J/Bx2jpHXSC1zvaOTHqkJN99gyzsw641CQFVLUZ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IklTar8G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EB606A31A;
	Mon, 23 Nov 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IklTar8G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191BB1F000C6;
	Mon, 23 Nov 2026 10:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795429102;
	bh=QaFTrSB1UKnHwp3T3biJ5IgaoaKliB/c0FJCbEihJKo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IklTar8GkpzS5SgnfSwWWbLh1sSJinFmu+k/1OJWy/qpRxNRJlIjjXxW5e6GUzrf/
	 o99rhTjEIPf1GepylnbUnQlQdkjJP5Tkf5N6PA9gv1+dx5xG1EYXiRZIyLWfDpDw1V
	 JyeX//L46WSL8wrdbR7tGnP2AUXqf/26ufbuCmNL8VXc46oSFOxeuK1wjQyr3k7cDa
	 TBqJOJd/7b+o5dk1+xNW2PRnWrxvrgh6ALQO2CMv5uzbedw+m4g0EfOmiaD8Tptvvy
	 chxqk5h3zX88ji1NRWb4X6pMQL9aP+7j08q8a4zAOgiGanr3Kp6Zspdw+DBm9O5smp
	 OTAaP0yRd3TrQ==
Message-ID: <4640f676-bcad-4ad8-aa38-14ac99c2d6d7@kernel.org>
Date: Mon, 23 Nov 2026 11:18:13 +0100
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
Subject: Re: [PATCH net-next v4 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Content-Language: fr
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "edumazet@kernel.org" <edumazet@kernel.org>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "gang.yan@linux.dev" <gang.yan@linux.dev>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>,
 "ycheng@google.com" <ycheng@google.com>,
 "weiwan@google.com" <weiwan@google.com>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>
References: <cover.1795424546.git.x-professor@outlook.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1795424546.git.x-professor@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yingjie,

On 23/11/2026 10:04, Yingjie Wang wrote:
> The TCP Fast Open and MPTCP blackhole timeout calculations can wrap in
> 32-bit unsigned arithmetic, even on 64-bit kernels. With HZ=1000 and a
> 64-fold backoff, 67109 seconds becomes 8.7 seconds instead of about
> 50 days.
> 
> Compute both delays in u64, cap them at MAX_JIFFY_OFFSET, and limit both
> initial timeout sysctls to one day. The new input limits reject values
> that were previously accepted, so this series remains for net-next and
> is not intended for stable.

Thank you for the v4, it looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> Changes since v3:

Note for next time: you can put the ChangeLog in a "notes" section, so
under "---"

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

