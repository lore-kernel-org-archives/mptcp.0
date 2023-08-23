Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEA4C139
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 16:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1E9C433C7;
	Wed, 23 Aug 2023 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692809962;
	bh=WVN54yyUsSEFkFqQeGM2p7Z9yHfiJYHAfiTdB0IGP78=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QZ+Xme7rPjTB7Yurm/ruFSW6L5jcgqnnBcZD5366kQ9U0yZvuFF9EzTogsKyMXchG
	 BB/5X4KWXKlGQ1jk04R6mVOFnZe4fzcEcSTNBcKW9zCO0MQEGaxR6xeFk84+DVbTgT
	 jsREoguVRdpr+WFy0dC5Apr7engbyB00W3/aWf5Do4Sgph9/+pkHuZO+bUhB+ELibF
	 rYkEwYO31QUqIDnLJDoR20CgLOzX8NfH+hp0NEmF0IAxh5DJd7o9imD/fH01eY7dg1
	 2Y9xdCnSFXstv4qdmh/1IR+kMjnk87t158vXNbrWK4si8yiJJZR61McK/Gk10Zpt5R
	 FO/KURxan/0ug==
Date: Wed, 23 Aug 2023 09:59:21 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-net 0/2] mptcp: fix missing close transition
In-Reply-To: <cover.1692779220.git.pabeni@redhat.com>
Message-ID: <d6acfbd3-0db8-066b-0e55-4416d33f1a9a@kernel.org>
References: <cover.1692779220.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 23 Aug 2023, Paolo Abeni wrote:

> This is an attempt to address the 2nd issue reported in:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/427
>
> See the individual patch changelog for the details. The cover letter
> is here mainly to trigger the CI.
>
> v1 -> v2:
> - fix compile warning reported by the CI
>
> Paolo Abeni (2):
>  mptcp: move __mptcp_error_report in protocol.c
>  mptcp: process pending subflow error on close
>
> net/mptcp/protocol.c | 41 +++++++++++++++++++++++++++++++++++++++++
> net/mptcp/subflow.c  | 36 ------------------------------------
> 2 files changed, 41 insertions(+), 36 deletions(-)

Thanks for the v2, series looks good:

Reviewed-by: Mat Martineau <martineau@kernel.org>


