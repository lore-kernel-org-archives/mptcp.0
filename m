Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40E837FF52
	for <mptcp@lists.linux.dev>; Tue, 17 Mar 2026 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773772619; cv=none; b=eSRDXIDlUvJVi5Dl9Msp7XcaZxy4hFz/xG4AsGuLNSb8rHa/LgYE+v/7Jn2XJT4b16LGh6Ms4DXlhrCeu4iiO11jppSoX6z3T706voLSNe5hkN4FTmCm3cCJQoaZIADFMAuyuRPBBcL8UL2L0dub1gmLcNGkTSQUJfr31adH5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773772619; c=relaxed/simple;
	bh=v5TSiUqgSXhvWtPGZwNdW9O0xTq3vbCjjnG8D43t7Qs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=caGqCkCUvNmJnGhqVk//+Q8MovjKCqkuVgdqS1U48xTHhzhqbADDhnK99k9Q422MMgYpBqg1dFzPuyVfB1/8IYt9rEFkl56eW/xwtuXGQMpcwp5JV2glyiGv7YvGDyC5zntJsjHyqhPza9U3X87QVz5iHFNQ+EPpJ7R8dHKl12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLnPXIk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLnPXIk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37730C4CEF7;
	Tue, 17 Mar 2026 18:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773772619;
	bh=v5TSiUqgSXhvWtPGZwNdW9O0xTq3vbCjjnG8D43t7Qs=;
	h=Date:From:To:Subject:From;
	b=RLnPXIk7Em6+mxzwzJx74m+V5pO4l4c12kcgcsJcGDF4ePX18+r5XQTfGIMdtabnn
	 a9FnY+898NOvfrlp+tf1KHc7Y7wrhyK/2qcCjgTNyQCtOrWfzwXfHDpQEGFdvdFhf+
	 1CgSEYjI037tqsLGJtGV6ZJWxMK13Nty2QI8HTAQTeZTTYiVEPlZq0fTFrnP16iAsl
	 EMUWzO3vmglhKbeBCaZXe3SXYirlz2/rGg4W2U8FgutiLfxxzaEVLqyaK8m56POU2N
	 3ZAFGWkcPQXlvKt+3b3T3ImFj8lHelsBDuignj4i6KvJPBpkDKqpFrzL1W+pcHqPG5
	 oSMY7Yk3UBr8g==
Date: Tue, 17 Mar 2026 11:36:58 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Subject: New resource for patch reviews
Message-ID: <8f042587-32fc-b008-a60f-e1fe16800dfb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Matthieu & community -

Roman Gushchin (a former coworker of mine) announced a new resource for 
automated Linux kernel patch review: https://sashiko.dev

More info at https://lwn.net/Articles/1063292/

It's already configured for the netdev list in addition to LKML and 
several major subsystems: https://sashiko.dev/#/?list=org.kernel.vger.netdev

Could be interesting to evaluate in addition to the netdev review 
infrastructure we are leveraging, so we can utilize feedback before 
posting to netdev.


- Mat

