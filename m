Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC73246347
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846827; cv=none; b=nHZq+XuI5RnxGjMpV/ofIbN3GQNzNkJvQv1qvNmvxllsdLGCoSyVQSB23lseHvqNQs1jEaEPqZmCQOyto8dOWq+DGQr/8llGQ7ZagQJmZ/HC1TcDZ5IOQcFLcTM71EZNzOi3dXszmVWogM3/I+DX2gxQep4JB1n9shivJzU9+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846827; c=relaxed/simple;
	bh=gAaTpiZZxVuo9MKBAvxUrMZl0HLfKqPTNHQEkZUllLM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7hgB5GB7bDZKyFfzi3yicz3ucn5QLPmc2Z5l6yAEbqB1a3R0t6BOjYolxdp1fXHBmWsbQhzBcgLzZ7OD5GBg5jcS8E4DXzR491gd9iBWXym61Nk3ffvaBqn3BkwGBoZE+fzU683pcgRnpFmqagi4bgH8B126MBuKb8a54x8BfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2gQJHto; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2gQJHto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE95FC4CEDD;
	Tue, 14 Jan 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736846827;
	bh=gAaTpiZZxVuo9MKBAvxUrMZl0HLfKqPTNHQEkZUllLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=D2gQJHtoollIJtBqYIJmIPCVS+9ZcoFpqi/0Td3OxnlCdVHI9Kt5K6iMUF8NrADKV
	 OS6b0H+Zn+M2LG+paUrBvLuyoBzPTpBjM9CMub3Fvulxneu0fDJgr+r7akeNJU043c
	 ls2gZzZxxHjJV4qMJku3stgeLazppGCyMje6Ol+KYA0I9ezxzXSC74OC81n3v0VsM2
	 x7Z8f/nmbwMhVWUQL010Tullw2BgX4sRuOy0nbDZtk17F5HOyZ9QJ2sJfo/0+Kt45R
	 as/GrHfqAdiaFOE/yBSlhraCJB2bhgNBUNTGjoqHcKgnXsMmuCXjOKdKIqwKeLBl4f
	 6AiSCAnAO/RjA==
Message-ID: <a055dba88515ada6b42689178131e38f8e4d52e2.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 22/36] mptcp: change is_backup interfaces
 as get_flags
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 14 Jan 2025 17:27:03 +0800
In-Reply-To: <1ab2187a-7858-42c9-9aa6-a8425cf20bdf@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <d8538f628ff2264b75c6c5e64e28147cb5793497.1729588019.git.tanggeliang@kylinos.cn>
	 <1ab2187a-7858-42c9-9aa6-a8425cf20bdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2024-11-04 at 19:55 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The is_backup() interface of path manager is not very common. A
> > more
> > common approach is to add a get_flags() interface to obtain the
> > flags
> > value of a given address. Then is_backup() can be implemented
> > through
> > get_flags() by test whether backup flag is set in the flags value.
> 
> Out of curiosity, is this going to simplify something later on?
> Because
> with this description, it is hard to see the value of this patch.
> 
> The backup flag is special: that's the only one that is linked to a
> bit
> that will appear in the packets, the only one that needs to be known
> by
> the other peer. In this case, I think it makes sense to have
> dedicated
> helpers to retrieve this info, and not the rest.
> 
> Except if you think we will need to extract the other flags later?

Yes, I am preparing for the use of other flags in the future. In that
case, we don't need to add another function pointer interface in struct
mptcp_pm_ops.

This patch is resent in "BPF path manager, part 3".

Thanks,
-Geliang

> 
> Cheers,
> Matt

