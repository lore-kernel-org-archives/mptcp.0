Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46701379
	for <mptcp@lists.linux.dev>; Sat, 25 Mar 2023 00:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DDAC433EF;
	Sat, 25 Mar 2023 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679704988;
	bh=VC4LrXIF04CB9UI3YL7KBxUU3Rgd8E+cXX5umTXNqcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKc3auWvJwwER8r1iZLbtkD18t/mdt2Ns/Dzn+6VHgL/hqq4bz0JyXR4FNCtszAut
	 UXypxn5d1Uxuy42qx23BZAhsot2gYmlkN9ieRnq4Q1ZRF3aMWCa+zjqvogQri18tU5
	 0B3BBPrn9swc0amUR7LBi2i6w+d+XgCgRFrTaaYXysoHOBz8bgx1qYL9LX0u2UTZE/
	 Ad9gNL/MPsIrbw1/yIAETrfrYMgOddXYiIriIFOena+gdFF9siFNKTdDs26/uEvBtq
	 LF7F4bykE2Vv69oahenGsYp2AEVRdRDuMb8u19ewHG0FHGSw0TNKs8ng16ej748nQR
	 2p+PiRBIK546g==
Date: Fri, 24 Mar 2023 20:43:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paolo Abeni <pabeni@redhat.com>, stable@vger.kernel.org,
	mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1 0/2] mptcp: Stable backports for v6.1
Message-ID: <ZB5Dmt1lm/4Js3di@sashalap>
References: <20230323-upstream-stable-conflicts-6-1-v1-0-ef2a6180eaf3@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230323-upstream-stable-conflicts-6-1-v1-0-ef2a6180eaf3@tessares.net>

On Thu, Mar 23, 2023 at 06:49:00PM +0100, Matthieu Baerts wrote:
>Hi Greg, Sasha,
>
>Recently, 3 patches related to MPTCP have not been backported due to
>conflicts:
>
> - 3a236aef280e ("mptcp: refactor passive socket initialization")
> - b6985b9b8295 ("mptcp: use the workqueue to destroy unaccepted sockets")
> - 0a3f4f1f9c27 ("mptcp: fix UaF in listener shutdown")
>
>Yesterday, Sasha has resolved the conflicts for the first one and he has
>already added this one to v6.1.
>
>In fact, this first patch is a requirement for the two others.
>
>I then here resolved the conflicts for the two other patches, documented
>that in each patch and ran our tests suite. Everything seems OK.
>
>Do you mind adding these two patches to v6.1 queue as well if you don't
>mind?

Queued up, thanks!

-- 
Thanks,
Sasha
