Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4F3714E
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI/QN+Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE05EC433C7;
	Mon, 27 Nov 2023 18:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701109648;
	bh=oq3mE05FOiYP3I4Kd+9ditXqbJhiFPR7HUki5IN135g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=hI/QN+Fv9qroAOoRdoWZIOs/NrEYWUh5UWgNpKc7goFq4KLa8p7tDhQ6uM1p2QENY
	 7PI9HB5ixIQZ7z0OEi4o1nx8Y+7Dc1xfywIf6pPnlkEflMqmBKvluuLJNCaOAFv2tu
	 gg6hbm6MoBMubp9BVNqioEkUigWyFqc0jlbYnmYGzxjv9607J7iJc3V/oBVtdkxY11
	 RII3YS3kK6y03g0nmI5MNXNFKp1PrKgyOkPdDpjVS3fYsC4HaGL2wysr3ln0WHDD2C
	 AuX5h0Ab9DH8B6uWT9DA6K30rS9YGjg0ywt0AXzLSFMb+emBPs3suhN7yXjZ1HvWd0
	 4H7+5zMvn/PKg==
Date: Mon, 27 Nov 2023 10:27:28 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2] selftests: mptcp: join: fix subflow_send_ack
 lookup
In-Reply-To: <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
Message-ID: <163b498e-8f0e-ae46-2097-c87bf4c491c9@kernel.org>
References: <f343a6ca7d627b4092a284dbc6724f34e6f8c491.1699973683.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 14 Nov 2023, Geliang Tang wrote:

> MPC backups tests will skip unexpected sometimes, since static functions
> like mptcp_subflow_send_ack may also be listed in /proc/kallsyms, with a
> 't' in front of it, not 'T' ('T' is for a global function):
>
> > grep "mptcp_subflow_send_ack" /proc/kallsyms
>
> 0000000000000000 T __pfx___mptcp_subflow_send_ack
> 0000000000000000 T __mptcp_subflow_send_ack
> 0000000000000000 t __pfx_mptcp_subflow_send_ack
> 0000000000000000 t mptcp_subflow_send_ack
>
> In this case, mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"
> will be false, MPC backups tests will skip. This is not what we expected.
>
> The correct logic here should be: if mptcp_subflow_send_ack is not a
> global function in /proc/kallsyms, do these MPC backups tests. So a 'T'
> must be added in front of mptcp_subflow_send_ack.
>
> Fixes: 632978f0a961 ("selftests: mptcp: join: skip MPC backups tests if not supported")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> v2:
> - Update commit log, fix typos in it.

v2 looks good, with Geliang's commit message change from the follow-up 
message 
(https://lore.kernel.org/mptcp/20231117053305.GA26319@localhost.localdomain/)

Reviewed-by: Mat Martineau <martineau@kernel.org>

> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
