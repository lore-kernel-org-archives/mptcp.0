Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50514D534
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 16:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1ECC433CA;
	Wed,  2 Aug 2023 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690995152;
	bh=JbA1bT8bR4s8va/QPSIPWfn4a7cHH1H2awJP+OBydUE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=i5fOZCrjMQrlxLGZF0srcjHYsemK6PYp5n9HSMIPiV25yJmrS16MvHgElESU60ABJ
	 5kkfhyeen1HZjawRHvlTJ3DmVitPmWlfli6KlfCXgEH573RDmth4WZxH50X4iWASBI
	 lOzziDT7E6PmXQEn8llF/s3XCwP3npY5ACx4ZNfTCeoB2Wtz3l27coc1rZ0WNsTPTj
	 rfFrApSzpwPhedoeoxyz9yKUh5paRJ71AMGzANvG4YgY0gHDYd4GW/9nPwWItqDIKF
	 0JPT0tvcMn6lP50gDbNXMCnidBjsgvjRLIR2hRjNNxO54djag9FLOplX+NwTi4LsCm
	 uOEbOHqOZHPhQ==
Date: Wed, 2 Aug 2023 09:52:32 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] Squash to "bpf: Add
 bpf_mptcp_sched_ops"
In-Reply-To: <aaebf8f891475fb3b946be734aff714530af09e4.1690952908.git.geliang.tang@suse.com>
Message-ID: <93831b6d-17a9-1905-d771-5ccd67a425ae@kernel.org>
References: <cover.1690952908.git.geliang.tang@suse.com> <aaebf8f891475fb3b946be734aff714530af09e4.1690952908.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 2 Aug 2023, Geliang Tang wrote:

> No need to change subflow->stale bit-filed now, so drop the writing
> access of it.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/bpf.c | 3 ---
> 1 file changed, 3 deletions(-)

This looks ok to squash, thanks Geliang.

- Mat

>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 51634efe4741..5c82cc35bfe0 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -52,9 +52,6 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
> 	case offsetof(struct mptcp_subflow_context, scheduled):
> 		end = offsetofend(struct mptcp_subflow_context, scheduled);
> 		break;
> -	case offsetofend(struct mptcp_subflow_context, map_csum_len):
> -		end = offsetof(struct mptcp_subflow_context, data_avail);
> -		break;
> 	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
> 		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
> 		break;
> -- 
> 2.35.3
>
>
>
