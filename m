Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37254170841
	for <mptcp@lists.linux.dev>; Tue, 28 May 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902395; cv=none; b=ueFxNw++ZeDSwH5wDRv7nMa0wmD2ekj9gJ8j+Ln6qV9JIvbLkHcx5DSqIEwB2GMrw0A9ei33DMb+k+muKiBF/s1UsW0oTGHn/pzDUpk7ZMSiMvZm9WJTT7IabPNjNiRGDxzRA7+9W+GEntdZ/iDfkgyj/tkU0P1N50haeZi8434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902395; c=relaxed/simple;
	bh=7E1wXdiFOHFfvViXJSLGKxGNc6VCZY8hHdiLWMHKy50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqu6DHlPUVcg/Hyjt3CDfzHtMvdSLWN7RQeF1fCMjz3tGIEHd/gy6rC5j2H3MGM/yeAsH4zQuuSjYnfiX9GCTo9i6nA4LOo9HRZWVmIvlXOw8S5q5GLMfiIKXCOX4QZv/9uH0Z7/SLpKMjK8+h3FSC1F5/49tm/uEAnHF132pZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1sbQZE/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1sbQZE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB382C3277B;
	Tue, 28 May 2024 13:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902394;
	bh=7E1wXdiFOHFfvViXJSLGKxGNc6VCZY8hHdiLWMHKy50=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C1sbQZE/weLlXXHrLnQgqmT2M9U2Kmynd/HRS+EfvCI4k3A/aHtHT61nP6end4HDF
	 3AQ9OLAyqkGIuLBLTAM2WKEDh/9cUjG026kZdKPxrThok1WTRJDcY2t6kK+QKDXNNH
	 B1n5sNIusghMp6kcWNMB89Rzr8v5wHrG6dYvtVTexxgDtGKMU1Z0AUmCDnUoe3oPXe
	 VXXvYBAIFUFVpicMFs4K/KgzebCYFmhVm93FofOQKowAgb5Kx03n3qCIWjbfT9GZGI
	 HBL5cQ/CCLmqXLZ+Zn9Lufb0QQi6b8yGcjIwXMNhWNEVU9wPXKKhY3GTVbpPzdWKvJ
	 YecTBJiXEQ7ag==
Message-ID: <88fe6f925f2db11c7fda8703d3ccb5f2c20c01ce.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/9] use helpers in lib.sh and
 net_helpers.sh
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 28 May 2024 21:19:51 +0800
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2024-05-27 at 12:58 +0200, Matthieu Baerts (NGI0) wrote:
> (This is a new version for the series created by Geliang. @Geliang: I
>  hope that's OK for you like that, it was easier to describing the
>  modifications by email. I validated my changes by running MPTCP
>  selftests only)
> 
> This set uses the public helpers defined in net selftests to replace
> helpers in mptcp_lib.sh.
> 
> v6:
>  - Replace "rename ns in setup_ns" by "remove 'ns' var in setup_ns":
> we
>    don't need it, avoid extra conflicts.
> 
> v5: (Matt)
>  - New patches: 1-6: some unrelated fixes, some modifications to
> avoid
>    adding workaround on our side (changing variable names, trap,
> etc.)
>  - "rename ns in setup_ns": drop the modifications in cleanup_ns,
> exit
>    in case of error, and updated commit message.
>  - Drop patches 2, 4, 5/6 from v4.
> 
> v4:
>  - two more fixes added
>  - exit when setup_ns fails in mptcp_lib_ns_init
> 
> v3:
>  - address Matt's comments in v2 (thanks, it's very useful.)
>  - don't rename ns in diag.sh, but in lib.sh
>  - ns in get_counter needs to be renamed too
>  - add a ns_name valid check in setup_ns
>  - drop $NS_LIST in mptcp_lib_ns_init
>  - don't drop mptcp_lib_ns_init, use cleanup_ns in it
>  - don't use cleanup_all_ns, still use mptcp_lib_ns_init
> 
> v2:
>  - only patch 3 updated, mptcp_join.sh, move cleanup_all_ns from
>    cleanup_partial to cleanup, setup_ns will delete existing
>    namespaces automatically.
>  - update commit logs.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks Matt, please add my tag:

Reviewed-by: Geliang Tang <geliang@kernel.org>

> ---
> Changes in v6:
> - Link to v5:
> https://lore.kernel.org/r/20240524-selftests-net-lib-fixes-v5-0-b9e0968571a3@kernel.org
> 
> ---
> Geliang Tang (3):
>       selftests: net: lib: remove 'ns' var in setup_ns
>       selftests: mptcp: lib: use setup/cleanup_ns helpers
>       selftests: mptcp: lib: use wait_local_port_listen helper
> 
> Matthieu Baerts (NGI0) (6):
>       selftests: net: lib: set 'i' as local
>       selftests: net: lib: support errexit with busywait
>       selftests: net: lib: avoid error removing empty netns name
>       selftests: net: lib: ignore possible error
>       selftests: net: lib: remove ns from list after clean-up
>       selftests: net: lib: do not set ns var as readonly
> 
>  tools/testing/selftests/net/lib.sh             | 71 +++++++++++++++-
> ----------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 33 ++++--------
>  2 files changed, 50 insertions(+), 54 deletions(-)
> ---
> base-commit: 55aceb609c1baec3e762e938e2028df7ecd545e1
> change-id: 20240524-selftests-net-lib-fixes-5a70b8d3b828
> 
> Best regards,

