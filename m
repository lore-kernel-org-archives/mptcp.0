Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026680;
	b=bb3fTvKAEIi2m+EFXl4nnnc39pU7qg1Z2cqLBckS7Og/eSh0xaIcHSi5aboTghHTYD2r
	 Np6CgrCZLnvjX1zf+lWL8Ng4hoiVgNGxzoao5p9iLor4wpNwGLhg1PprjvBWQqggarfrp
	 I1FhSSeETkYCvYCbKYlgEfNcvdI0ehIS4pXnNO6bQ5ul3KcihtxftoCGrAyaUnPuZZtQs
	 xV1w9F4Mv42TEWqYBc5e8BcvVSsWNSTcPYYGOZPTkOJ5ys+hu4L5f/BJWOYywHGfAEtYV
	 xy8xYmTKqbqLSoxFii/IhDelFs7qnGCRVX9sLeKskd7UryxvlD8RvU3aXEPcZhIYRAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=9POCCF331g14iFPj8SgUyVVQk9XQYyGlnQIRNxTupwc=;
	b=T5l8ljUTwXAYav19aZg2WiXQ1Tu2melX+xZ8u0BEF5HFR+4D341QhPUXtRyDlE9iiCJv
	 ffaOcxJUILoTEmitMNVCfzvLvH4YNR/sF9MTXKyENQq7euNlrPYR7WStuHCfZEo9a7TBg
	 4wMloT59h9tTZkJXF3KkdN+IEmurVvSYRO8DSZFNqqP/kKH+lsL1J5wA3ytbxkr230r6J
	 FNoFSNJzSZjKD+AEMQ4OEj1CDNzzGzRx7b9x/rsBZ5mCri7Om73hbBaCWygMj3rWp4MaQ
	 N1+BPXFDgrIRpohLO6YOpUW+8KtpaiciOc1amLkYt1SpGzGKvHnjuJ7G34GHy95dRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWAC+H1I;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D75606A32F
	for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 18:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D75606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CWAC+H1I
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd69954c755so1150344a12.3
        for <mptcp@lists.linux.dev>; Wed, 18 Nov 2026 10:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795026679; x=1795631479; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9POCCF331g14iFPj8SgUyVVQk9XQYyGlnQIRNxTupwc=;
        b=CWAC+H1I4yEsoRtHCElSfGL59TUm7PvkSIg5B9GrI/kw4V0hFdr1FrXwgI15wzvLPC
         KCa52GQOl3L2V5XwZsApN4Av4AvniqmEJotBO0txjQVXitUVhejo74Irqw0KCuQm0f9Y
         vDqy7+BdGWWHofm9RPFVt3ldbR4NTTANL6HTK0iAiiuAKsu08n4Jh70ULy5z2xxnHhRz
         ET2kSiAfoTGvILyseEmC4dqmijJJjQnDVNexAnEdPM95jZbjK62AZpq6L/9YhHaA5t3H
         86e/oyGQ0x5lmJN+p2y7LAKgvdpMLnqklDvlfmsHZMfMri2b+dOpxH3CcWdtZiHv1Xgy
         UblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795026679; x=1795631479;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9POCCF331g14iFPj8SgUyVVQk9XQYyGlnQIRNxTupwc=;
        b=RmJnbaxpzsYEPZBodl+MHwEAb4Q9ZU5/lCJLHG3vneyQPA++euV+4Geu276LPWtWev
         cvpeRK1DlIFaPPrUAACKsik9GE3Un8puFAAB7DJ/P3/kFfkQBrKv39AJmnzRnZaq2kpp
         zL4aYheOpMBVw7f41+yDFZWBM+OYKGegvK5A1dXbWtzpKMaVNGlGfftiTW3S2LOYtKM8
         ivn/KKgc21trmoLmdI7uS3ijoROtNXjXMc3cxk1vKpFclXx+/jqvLLn12/Ztn4449ZSe
         IiCHrDJZR2E32/aBJQwCec7/fZ/KjmXzjdx9N2dyzeBtrkQn/Cq9Qnw3Y4HKw3T1qTj/
         OZvQ==
X-Forwarded-Encrypted: i=1; AL+hErHYPuFk1JmZAyphZ+shwLnnNfq1F6tldidcYHRZknMVUOAn6VP29Dj6D/zJzrURhLqTbQnl0w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+HK/2i5ckoB50TYSE3V6s3j8QCEkfD8XgbuOvdH9q5MDOC5T/
	MFt6EfVyHfBjCZdj8m9f+8H9aH/7rBRnXogbQrkD+greRNND65lzGKO+
X-Gm-Gg: AZFdTZeLLN7yHvZDqTW5AQ0Fsq0KbElblOvY+aGZ1lNo9ygNzjL4dXvrd31ROSr4H3G
	No2GgTb4nyMTmtvXImWTEB8HHOcNVdFnLZBJVmYOCZtkDjSK+q8XI9uSfnbwaRPtZ036SlcIvMk
	PijF33Aq8DmVNzVXiXHSpY0AJJWRxtucXkAC8e2U/jOOlcpKL7PrWqCTpvcYbpG1C5gtOAYmHT1
	7uw5tyycx7seGH8EYoKiD6cVE6IfldyRs0dXswhUNMm62ZG2XVLCSzTJfQHjfl1fytGoRsQWDbA
	oFOtiHWbMWVs+QZhSn+AQu9rJAkT0kZadFBeaaQhGTbIzq8/DSZY8IPEYmDp3Sl3GP258FrogJ7
	y+SEqRy9uP1MS9yvyC0kPJzxd6S7Qjh/lORYjBMPN3mINFOBBMM7lgNXZpwfilZ+DG/yX+E0htu
	dXugLTVLncMDiYwvDeQlK8qywmQt9GZsToo54y64s6I15LjwfDSrUQPMaCd6ofbW9qmnaCkhSdf
	PwMXDhymmsmdib3iMUdac9Yu+09crPRotP2xcxM8yU8mS2wyqt6ZqiH6AKMQALx0b6it2U=
X-Received: by 2002:a17:90a:d445:b0:3b1:4eb6:b3a with SMTP id 98e67ed59e1d1-3b3d0640e47mr3501738a91.8.1795026678945;
        Wed, 18 Nov 2026 10:31:18 -0800 (PST)
Received: from [172.21.0.2] (vldb.skku.ac.kr. [115.145.173.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3f6a94c8fsm421066a91.1.2026.11.18.10.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:31:17 -0800 (PST)
Date: Wed, 18 Nov 2026 10:31:17 -0800 (PST)
From: Kyuwon Cho <kyuwoncho18@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mptcp: pm: WARNING in mptcp_check_listen_stop() when listen
 fails on a new endpoint listener
In-Reply-To: <5d651146-b21d-44da-9f15-860f0c9c2dc5@kernel.org>
References: <179502042942.2742790.17887994424282536144@gmail.com>
 <5d651146-b21d-44da-9f15-860f0c9c2dc5@kernel.org>
Message-ID: <179502653236.3033236.9177220287548482679@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Matt,

On 18/11/2026 19:18, Matthieu Baerts wrote:
> Please always decode stacktraces with ./scripts/decode_stacktrace.sh.

I'll keep that in mind and decode them in my next reports.

> Out of curiosity: if your LLM has already analysed the root cause and
> has a reproducer, why not ask to generate a fix and send this patch
> instead of the bug report?

I'm more used to communities like LLVM, which are cautious about
LLM-generated patches, and I was hesitant to send a fix for code I
don't know well, made in a way I couldn't fully judge. So I only sent
the root cause analysis. Thanks for explaining; I'll send a tested
patch with later reports when I can.

For this one we do have a small candidate fix, tested with the
reproducer: it puts the MPTCP socket back to TCP_CLOSE when
__inet_listen_sk() fails. Since you already have a fix for v2, would it
still help if we posted it, or should we leave it to your series?

Thanks,
Kyuwon Cho
