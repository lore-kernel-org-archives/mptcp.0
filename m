Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33427B
	for <mptcp@lists.linux.dev>; Wed, 15 Feb 2023 16:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C24C433D2;
	Wed, 15 Feb 2023 16:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676479762;
	bh=33eCh7t6VN/LtP9909AsUUDLvNslOFfq/tIUXZDPkdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/sVsMGPREV+V6EYq5mVrifCTdJ08otI8K69ChtcfwYsyvrZ86iKSH/5fZAPUUT+g
	 gMy5UPI63bfK1kQX56aDC+CtJLS7TdxZan66NJRT14s3bm6BfLMti1li3yAhU4VGvh
	 kxwpgD8IATw9TbwzbETXhYNpP/CmNiOp0Un3YGPyyIWSRwbJWKN9LgNLtjiugzjXv3
	 Ot9y1k7fVfCm3kVdnh6VhKQ/c1oatQ4GoNmUguHFVH77rv4M/Wu+McO8pQfSxvWvO/
	 QNgcCb+fjhX8CsKBm+Egg4ARc+M9CUD0sbGIITMSM3LgKzpgzOVKdqEWi6meCatAqc
	 cq/fM+anVnz/w==
Date: Wed, 15 Feb 2023 11:49:21 -0500
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.1 0/4] mptcp: Stable backports for 6.1.12
Message-ID: <Y+0NEQB5CrCa9Nlw@sashalap>
References: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230214-upstream-stable-20230214-linux-6-1-12-rc1-mptcp-fixes-v1-0-02f36fa30f8c@tessares.net>

Hey Matthieu,

I've ended up doing something slightly different:

On Tue, Feb 14, 2023 at 05:05:06PM +0100, Matthieu Baerts wrote:
>Hi Greg, Sasha,
>
>Here are two MPTCP patches backports (patches 2-3/4), and one
>prerequisite (patch 1/4), that recently failed to apply to the 6.1
>stable tree. They prevent some locking issues with MPTCP.
>
>After having cherry-picked patch 1/4 -- a simple refactoring to make a
>function more generic -- patch 2/4 applied without any issue.

I did the same for 1+2.

>For patch 3/4, I had to resolve two simple function because two
>if-statements around the modified code have curly braces in v6.1, not
>later, see commit 976d302fb616 ("mptcp: deduplicate error paths on
>endpoint creation").

Instead of resolving the conflict, I took 976d302fb616 ("mptcp:
deduplicate error paths on endpoint creation".

>On top of that, patch 4/4 fixes MPTCP userspace PM selftest that has
>been recently broken due to a backport done in v6.1.8.

I didn't have this one, I'll go and queue it up. Thanks!

-- 
Thanks,
Sasha
