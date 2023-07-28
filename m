Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5031BB37
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 18:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC7C433C7;
	Fri, 28 Jul 2023 18:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690568673;
	bh=Gz77RkZARYsgpklW79EQj7We1jm52OYevZL7fZyIR+g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=onK/nw9n5qS5a9olqhsgaikIm0WYbwfyrkE/uf6gKkdqPXF5UsIyYh8e8ILdH6aU/
	 xe0yOsFpfcAbvFP2DUztoPmgccuOLZAI+m5PF6YutXu2L37DqueqgBvLzwRDg2NqSx
	 0y0moB8sX+a5MNT7paN3lHl4oK+6Gx+LIuwFwq7yenJiRxfX5KYKZA9Ra4c/Y83F/J
	 hf9NkoGNOQzjBhx63/b6ShqftaOnVz3ZqAQSiRN5vm5jgq6YhBVmET029ofsdFvIgN
	 kWXdzQvSUjTZQZ0nEcuy3mYzYo+G7Oq++3/iFUDP9+wJ1qs+YNJuAIF9G8DnSS5cAo
	 mHQW+hyG17KJQ==
Date: Fri, 28 Jul 2023 11:24:32 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: join: colored
 results"
In-Reply-To: <20230728141833.916787-1-matthieu.baerts@tessares.net>
Message-ID: <5466723a-9b49-04f9-0b95-defd1efadf4d@kernel.org>
References: <20230728141833.916787-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 28 Jul 2023, Matthieu Baerts wrote:

> New env var to force using colours.
>
> Most CIs these days support colours in the serial but they will execute
> scripts in a non interactive mode and colours will then not be displayed
> by default. So we need a way to force displaying them when we are in
> this mode:
>
>  SELFTESTS_MPTCP_LIB_COLOR_FORCE=1
>
> Note that it is still possible to force disabling them if needed via the
> standard NO_COLOR=1 env var way.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    to be squashed in "selftests: mptcp: join: colored results"
>

Looks ok to squash, thanks Matthieu.


> tools/testing/selftests/net/mptcp/mptcp_lib.sh | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 1080d5d2430b..92a5befe8039 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -10,8 +10,9 @@ readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
>
> MPTCP_LIB_SUBTESTS=()
>
> -# only if supported and not disabled, see no-color.org
> -if [ -t 1 ] && [ "${NO_COLOR:-}" != "1" ]; then
> +# only if supported (or forced) and not disabled, see no-color.org
> +if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
> +   [ "${NO_COLOR:-}" != "1" ]; then
> 	readonly MPTCP_LIB_COLOR_RED="\E[1;31m"
> 	readonly MPTCP_LIB_COLOR_GREEN="\E[1;32m"
> 	readonly MPTCP_LIB_COLOR_YELLOW="\E[1;33m"
>
> base-commit: 18d38b0f6b8f3d12bbd55c179b87d3ab014fef48
> -- 
> 2.40.1
>
>
>
