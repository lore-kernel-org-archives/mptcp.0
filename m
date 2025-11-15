Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4CD224D6
	for <mptcp@lists.linux.dev>; Sat, 15 Nov 2025 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763170357; cv=none; b=b9JEj7W6LTKBvrXb/T0jI0u1wMlZ93LBGMrgRoaAUzRDOI4HSlezkqQX+7NbRbWEAXJLlF2HzeLg7I8aCalEKT5TSkAsc4AGsJCdHT6gdVUvFJ/I29WMxsUnzMlPBG+bHkCrUcpid6X5rEY1WA0SZqVTgtIi3ChTJK+T+34FiWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763170357; c=relaxed/simple;
	bh=pHH/8a87O8lK7PM7FRg0jDqrAG5Q1yk+3brd7F/TCK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ElC+/gs8+EX7lZaEuoL/Uqc4xTv2u36s02diTNwcmB7eHvqmmYCpvMwD5uKGYtqSB+nfuNfOMZfosj6jLgGNArnLsursNZ3qSEbYdoQOyfomzYUNlB1YQd9yk2wlNy4oe8A0lAN7PX0C6BXPutaawOLALyt50HePXqYeQcsdf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUAioMPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUAioMPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED566C16AAE;
	Sat, 15 Nov 2025 01:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763170357;
	bh=pHH/8a87O8lK7PM7FRg0jDqrAG5Q1yk+3brd7F/TCK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VUAioMPNGW8sRsLQiZMFU5EwWWOOsED45qc5DvjJMxpbFk7y3iNAB6tQRCcvCBN8I
	 XBu8vhW2T64fpUqnXFkjXEDyieVcP0psQhPHESJnDc1vfVGzzV3jCTfsKQzKO5JIKH
	 UKy/4xYZOsmaizarOVOxqraJCYdjvX/K76I6ysWF8W6ca61GNLEf7IZXTGkvu+YdPO
	 hle3XI+E2SX6yXbpH4Bn3Db6Ti5GhB3fJmB37GnswrLxiG1AEVH0zQ+TrDtqxo64hf
	 zzGGR6UhY8PdnOpKSiS6UPGW7NisUF4ivAWqFFY4zDo0dhuqWJoJ2I5lTeFWH8IUUD
	 urYnb6IZX/FJA==
Date: Fri, 14 Nov 2025 17:32:36 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v4 mptcp-next 4/6] mptcp: better rcv space
 initialization
In-Reply-To: <add0910a988cd8f45b7c3f5c76dea0fc3f4ee666.1762940290.git.pabeni@redhat.com>
Message-ID: <c279328d-9ae5-fb26-4d71-d23d887a44da@kernel.org>
References: <cover.1762940290.git.pabeni@redhat.com> <add0910a988cd8f45b7c3f5c76dea0fc3f4ee666.1762940290.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Nov 2025, Paolo Abeni wrote:

> Each additional subflow can overshot the rcv space by a full rcv wnd,
> as the TCP socket at creation time will announce such window even if
> the MPTCP-level window is closed.
>
> Underestimating the initial real rcv space can overshot the initial rcv
> win increase significantly.
>
> Keep track explicitly of the rcv space contribution by newly created
> subflow, updating rcvq_space.space accordingly for every successfully
> completed subflow handshake.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++--------------
> net/mptcp/protocol.h | 30 ++++++++++++++++++++++++++++++
> net/mptcp/subflow.c  |  3 +++
> 3 files changed, 63 insertions(+), 14 deletions(-)

Reviewed-by: Mat Martineau <martineau@kernel.org>

