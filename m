Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42914180
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 00:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF53C433D2;
	Wed, 24 May 2023 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684886735;
	bh=UGYR/vM28bs7j3Vtfom03GL5uW5ltpnP0wXhQuVIBEA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=PHmL2UGXXsSqvw5HaH614UEqkx3N0wQ4loN4g2CsCP7hXVN6jtkCeK4n7vYI63wmf
	 dDxyALoZW7TPMv1VIc1aYq3uBJCaDGI3G0QKqePhAVLEI8FzZHF/nDbvbd4G1NhZsH
	 ztNcwO0EynQWj0XdYcFkotJealuRfYwy8EWbxK7MylKr7st6PSgWiGEBNl60NsJeef
	 zcK5F41JszD6yGHTFDSv3TQ0Kt0As2wrS+QyWVY0Lha47beFxlZGxrle+cs8+VjY7q
	 a4G4ebjlN1SDvlD/PNK8xqNTJiwWz1AFq0lnFJg4kYBUZHqJdDlY2dgR6FmYxfiLOx
	 DmZ7OZ3RvRwZA==
Date: Tue, 23 May 2023 17:05:34 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Christoph Paasch <cpaasch@apple.com>
Subject: Re: [PATCH v2 mptcp-net 0/5] mptcp: a bunch of data race fixes
In-Reply-To: <cover.1684427027.git.pabeni@redhat.com>
Message-ID: <7482f42a-cab2-6737-9901-4acad8193a60@kernel.org>
References: <cover.1684427027.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 May 2023, Paolo Abeni wrote:

> The patch 1 && 4 are direct response to recently reported KCSAN
> splat.
>
> The patch 2 && 3 are just by code inspection of related code path.
> Patch 3/5 is there mostly to make the next one simple, even if the race
> mentioned in such patch should be real (but very tiny, if possible at
> all).
>
> This iteration addresses a compile warning in patch 2/5 reported by
> kbuild bot.
>
> Patch 5/5 is new in this round, fixes an unrelated issue found by code
> inspection. I should have posted separatelly
>
> Paolo Abeni (5):
>  mptcp: add annotations around msk->subflow accesses
>  mptcp: consolidate passive msk socket initialization
>  mptcp: fix data race around msk->first access
>  mptcp: add annotations around sk->sk_shutdown accesses
>  mptcp: fix active subflow finalization.
>
> net/mptcp/protocol.c | 111 +++++++++++++++++++++++++++----------------
> net/mptcp/protocol.h |  14 ++++--
> net/mptcp/subflow.c  |  28 +----------
> 3 files changed, 81 insertions(+), 72 deletions(-)

Thanks Paolo,

Series looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

