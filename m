Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0B3AC00
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149883; cv=none; b=QgOv4ITicknofJBgxuLPtilaJQy0ive37lwRH5JYjzTZ977A9zM4E8oco8mFuFqOl3sWFgIMHobqiwAK6srQ3lYj4cF5ThbCMPulHq0dw9zzMS0/ZDxyAroTghghtbjQuFe40YMIPllwOwqG3MSRJ7nHZDm4GZ5w2J5BmlHX0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149883; c=relaxed/simple;
	bh=lLm7Ws+ZyWm2K6Jd8U8LTbBVf+oIqmhu/ekKFa2KRpE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k+DdVUvQGc3UgzVAbh+VsB1m0cVnW2d0KOZNFwI3q9s2xloM3MUgyDGZddCb3y+BEpAijm6KQeiLeGWHpPXKHJdNvOcyuSDdyK1uCkmahtJ8mz99mY7WmNAJy9aF5LXy02r6qsosjv3vzexggcrm+oKLI+j0kSJIuNCfWdZpYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPNEIB0c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPNEIB0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9286CC2BCB7;
	Tue, 19 May 2026 00:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779149882;
	bh=lLm7Ws+ZyWm2K6Jd8U8LTbBVf+oIqmhu/ekKFa2KRpE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BPNEIB0cD3VQ7x4mJomLvSmNMQf1SYGP8ihtzK6y29U+yuMLVYIXGaKoowio40W8S
	 VX7VqtPxPSgvZlqgDyZlqf0So2+mz7F7qFIs56i4WPdwE63FLXXjnBA1MHtZvOooN+
	 CNPlk3T/R/lvwHPL7j7MU3Eq/pUcraIYLR5r2X5H8Hx7KD/VfDImqHUUZgR3/MQC72
	 phcfN5gJkpBel2hRJ9n6HtHCi4a0Tfh9fzGAwAs4XwN+Q7habSFOFfkf44ZBAEzECW
	 BJMkVAyLwzihdZYe9N9netBaNZfbGjoSAWv2Xm5GtSrGooJgUxWWZMPZ80fZB4QXeZ
	 WXZaC9oXZHPsA==
Date: Mon, 18 May 2026 17:18:01 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] Different time this week
In-Reply-To: <80db88ea-1e7e-4417-92d7-e2ddc12400af@kernel.org>
Message-ID: <77f0e560-b51b-9cdf-86d5-a79c7679805f@kernel.org>
References: <80db88ea-1e7e-4417-92d7-e2ddc12400af@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 18 May 2026, Matthieu Baerts wrote:

> Hello,
>
> This week, I'm not available at the usual time: 15:30 UTC (8.30am PST,
> 5.30pm CEST, 12.30am CST).
>
> I suggest either having it at a different time, e.g. on Wed/Thu at 0:30
> UTC (Tue/Wed 5.30pm PST, Wed/Thu 2.30am CEST, Wed/Thu 8.30am CST). Or
> cancelling it. WDYT?

Your suggested 0:30 UTC time works ok for me.

If I recall, there might also be a need to cancel the first meeting in 
June, which would make for a very long gap if both are canceled. So, not 
ideal to cancel but ok if needed.

Thanks,

Mat

