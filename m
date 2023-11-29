Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B437EDD
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSyBfjUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6F0C433C7;
	Wed, 29 Nov 2023 01:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701220735;
	bh=CpBu8BTfiwHVeLqWDiK8yP5wyD1XqqHk3BcmQL+CaJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uSyBfjUoy126aBB+S5ccQWMJmXrtuSFQkS6nrnQrxv18/O7n6D5jswBWVFWCweUuz
	 mfzdk7iNVJ75tBjXqSv9DtOvaSEqoWo7xyd2cuo5lObF6KDlIvD7YwZDURfHs/jyPp
	 mV38q5Z25esDObNYoqyYKZFzVNdiD5+szh7SjIVv2mV9r0scn1B6d5qg+UzKP6A5Qz
	 WtzNHNnVzIm/zCHZjd+JGkYkU/66VUUfUiFnqBgrnQ4WsJXHTv6bcbVVw/3XGSUiIk
	 UJ+5BLJLJ7Fp3iWD3wvYr4xjGRDqy7hiGFYrM1xBLaoFxav6kZo6PTU2qUus17ENzx
	 ofyAwg3rrTuFg==
Date: Tue, 28 Nov 2023 17:18:54 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net-next] mptcp: cleanup state propagation.
In-Reply-To: <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
Message-ID: <9db8d6ee-1cf2-cb03-178c-00fbbe8cda95@kernel.org>
References: <240a97d522887a938faeb24a6a3e3a9ed24570b1.1700667908.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Nov 2023, Paolo Abeni wrote:

> When propagating the first subflow state via the release_cb, the
> msk must actually take to 2 separate actions: state sync-up and
> send buffer sync-up. Relaying on the specific flags instead of
> bounding both in __mptcp_sync_state(), allows cleaning up a bit
> the code.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 3 +--
> net/mptcp/subflow.c  | 5 ++---
> 2 files changed, 3 insertions(+), 5 deletions(-)
>

Looks good to me, thanks Paolo.

Reviewed-by: Mat Martineau <martineau@kernel.org>

