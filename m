Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7582DC772
	for <mptcp@lists.linux.dev>; Thu,  6 Nov 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762421829; cv=none; b=Mp7b0O1g5NMe9iPgHZ4+BU3fJMgRHuri0+A48+9K6BuwdWSBaO1eP/EjqvhNwbTALY2R33LGcFVxhX2ASgVCeQNWqMIh9yvjIrAZOFekBhswmc5n2F59uQWYIUjSa+m+3ywC9TAcgJ6pMbx+3TMvqhmJp16WSzk6A72xXCoWIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762421829; c=relaxed/simple;
	bh=lkNTDEpI9xDwOGpJ4vlKtUmxdJ5uM/jDLSo6R/Glopc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=STLzsF2AprrS//m+hpwee9TMwVLCKU2hr3v6887CocY1JQYWidxntch3cREGVthQ0aWMuXNct0G/KwPc33Uol6a+NXaWlTk2Bw7GjIdtijCImrTfBRpGk4Fr6wfzg8Uphs8HV1YuhqS9fkQ3rZdqHsw9IjsMK76CUoYoR++69rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2Et5EXD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2Et5EXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51697C4CEF7;
	Thu,  6 Nov 2025 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762421827;
	bh=lkNTDEpI9xDwOGpJ4vlKtUmxdJ5uM/jDLSo6R/Glopc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=J2Et5EXDrQg9EFLV51y0YZaA30he7VJyzMLOJbESRyfhmeJbg9roabSgJGurdB7yX
	 2AjKNY90V1XNLZghD6Hgbkgs55im9B3fuB2QrNrbLkHEdnrCTnEDC4CdHVtxLJMSIv
	 e/RpoQ7DTBw+YRmAi88qMzuprP5txi0Aibc7w7OeK8PPl51aMVfNzEevGs9U//X2ck
	 tp3US0gDpGq7f186iqJWlAV7+PM8F8XPFDKg3nGJKVVZOwNtoRKpwxDWMzTFeohdgm
	 rwMsPzGVQP9o0MY7ehFjr8As9jl2L0YzBvxcEQVjgqkmx0Ft5q7rFA4met0CxReBZu
	 ue04G2FAN8MNA==
Message-ID: <695cb8b2257afb66830f8c8536504b100ae31a62.camel@kernel.org>
Subject: Re: [PATCH, mptcp-next] selftests: mptcp: Add a check for
 'add_addr_accepted'
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Date: Thu, 06 Nov 2025 17:37:02 +0800
In-Reply-To: <20251106075457.41025-1-gang.yan@linux.dev>
References: <20251106075457.41025-1-gang.yan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

Thanks for this follow-up patch.

On Thu, 2025-11-06 at 15:54 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> The previous 'delete re-add signal' test did not validate the
> 'add_addr_signal' and 'add_addr_accepted' counters. These counters
> are crucial for ensuring the MPTCP path manager correctly handles the
> subflow creation via 'ADD_ADDR'.
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>

Looks good!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Except that we typically do not use capital letters to start the
subject line. Let's have Matt update the subject when applying this
patch.

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 4faf58fecc94..cca97a8ad0d6 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4203,38 +4203,45 @@ endpoint_tests()
>  			$ns1 10.0.2.1 id 1 flags signal
>  		chk_subflow_nr "before delete" 2
>  		chk_mptcp_info subflows 1 subflows 1
> +		chk_mptcp_info add_addr_signal 2 add_addr_accepted 1
>  
>  		pm_nl_del_endpoint $ns1 1 10.0.2.1
>  		pm_nl_del_endpoint $ns1 2 224.0.0.1
>  		sleep 0.5
>  		chk_subflow_nr "after delete" 1
>  		chk_mptcp_info subflows 0 subflows 0
> +		chk_mptcp_info add_addr_signal 0 add_addr_accepted 0
>  
>  		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
>  		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
>  		wait_mpj $ns2
>  		chk_subflow_nr "after re-add" 3
>  		chk_mptcp_info subflows 2 subflows 2
> +		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
>  
>  		pm_nl_del_endpoint $ns1 42 10.0.1.1
>  		sleep 0.5
>  		chk_subflow_nr "after delete ID 0" 2
>  		chk_mptcp_info subflows 2 subflows 2
> +		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
>  
>  		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
>  		wait_mpj $ns2
>  		chk_subflow_nr "after re-add ID 0" 3
>  		chk_mptcp_info subflows 3 subflows 3
> +		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
>  
>  		pm_nl_del_endpoint $ns1 99 10.0.1.1
>  		sleep 0.5
>  		chk_subflow_nr "after re-delete ID 0" 2
>  		chk_mptcp_info subflows 2 subflows 2
> +		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
>  
>  		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
>  		wait_mpj $ns2
>  		chk_subflow_nr "after re-re-add ID 0" 3
>  		chk_mptcp_info subflows 3 subflows 3
> +		chk_mptcp_info add_addr_signal 3 add_addr_accepted 2
>  		mptcp_lib_kill_wait $tests_pid
>  
>  		kill_events_pids

