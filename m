Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DC353A6F;
	Wed, 22 Jul 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730161; cv=none; b=h7mwnuriSYL9jZmzOCtfotaQQbXMHYNW6EQNSVauABnIsnWoVl1I6LM4ExdW5UFX44TOiglcwvU+SRs039ZrfmLeG0rEvVrOBTCkeB91ENnJ4NOnCnkdd5VgP5mzLbZonIU/xyVwl4BUB/G4XFa2vpOLA2pxqr19CBCaL1eYHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730161; c=relaxed/simple;
	bh=UdmmEzMRHP3kZF/dAZuCdbx67Wws/1VJIGbN2Pe9llU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKDgNNJ2HWrJFRZTyOLuZB1vBg32jQDj5B9mKgKLvC1SJ7pLmo5hBEJcQOlaY2ixZ6KtY26BEJUmrP+WRuOchw/x1aie+YlzMu4E/Zob6wC5rpW04gayMBVbgNIVQfLpMHu6K6T2THS5GItq9ke3KVRyfwtXfS+kuyNzAdOQkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnnlW5OR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnnlW5OR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63551F000E9;
	Wed, 22 Jul 2026 14:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784730160;
	bh=UdmmEzMRHP3kZF/dAZuCdbx67Wws/1VJIGbN2Pe9llU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fnnlW5OR3+JhrV4BZg8Ocwuiwh1AhJWwfK6nW/FrBEJfVyGaeup+rdeqWiVQA3yRR
	 fSnOODn4NZO9RiBgegu0J5VdVSmpuQdmuVZ9Qteg6syb7BqcII4sAYWyg2N9RseF2f
	 ug101gWFFLyPXF8umDhQN6c8rAqEHsk8+gr9Tb2zhJOOQDDlvqmsvBfK589mVQBidZ
	 b6cgvfcncfnO9/4fc8n4lwrOw2T4TO85MU3bWjQLcgRXTXWImLptcTcdmO3SivvU3Z
	 JD7SpGX9JEesBeoVL8K1QyC9yWac0gDJQOTj8BQOgzNkhRtShBegyyL84PLqrg1Z4l
	 9BqPWOa06yvYA==
Date: Wed, 22 Jul 2026 07:22:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 pabeni@redhat.com, dmytro@shytyi.net, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com,
 bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH mptcp_net-next 1/1] mptcp: fastopen: only mark MPTFO
 subflows with SYN data
Message-ID: <20260722072239.4ea019fc@kernel.org>
In-Reply-To: <178471846217.973832.14121853580804517391.b4-review@b4>
References: <cover.1780458440.git.bronzed_45_vested@icloud.com>
	<81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
	<178471846217.973832.14121853580804517391.b4-review@b4>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 13:07:42 +0200 Matthieu Baerts (NGI0) wrote:
> @Netdev maintainers: this can be applied directly in net.

Too late, please take it.
