Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CB38CFE9
	for <mptcp@lists.linux.dev>; Thu,  2 Apr 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125599; cv=none; b=NZHK6JEmBMNRL8mZ5yEJ1tohKinJn4OUQcyoHv4ziiKnjNc8bM/3URDBmadvA1OXjBNKrT/DPDHF9x8opXWPxu0Lv2TbsaD8H5lLmLrRdWCzR6z9Fwz+TbSOaFQZVoYJ6esubdXnzJEBfV46sZMRWTqhdYYETboWUfqhfVd31E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125599; c=relaxed/simple;
	bh=KjjDtFLl3URziGGRbAPaFFXdnrMZSogppB/AqAgoLpE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hmcYPfl08KAVbdrvtjRYTLNyHKY4GjhnYQ02idvnAYwgQcOIJtt/nIG93XdM2g01LI5qCc6t6DGa370FLYkmxJy9Ly2aE8JYbY2g1dh4Rq4yH9clXiNZoZW8J5kOUCnyFtAVwzabKV8xnhVuzxzzjWHPRcf/9UDGf3yHmhJx/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkYhTbqs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkYhTbqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2F2C116C6;
	Thu,  2 Apr 2026 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775125598;
	bh=KjjDtFLl3URziGGRbAPaFFXdnrMZSogppB/AqAgoLpE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=tkYhTbqs7ncYkrwjk6XXyk+kQ7XPNXzckn3aM+Mrk3EslBr+SMh/MmS4EyVLUVUMy
	 fFazphgEDKKEfgV6NE5XK5t8hwpg6d8Log1FD1kGsFzVue/ZWLfyLgrf+d2d/a6EFU
	 4/i3KyGxEs7D5WICCjCgEGcDTWoxbAOOMX7NKs3Dy+bhGWH4e1vwOUBWjsAUvEPZIt
	 o0YmVc5okVyY8CIdGYQVyfSQti54CspfmmR59tvUdaYg49bAw32+cDbq0p6O/8bC/S
	 VhB2cv1ZYl3aRytgZNBh8xamNq8vYjsNcasjWJQCu0HRskkW/bR28KUz5RQicZJTVN
	 KdI1cr7CO7dAA==
Message-ID: <8bb754486ad9151ab971fe25364f07894d8c5940.camel@kernel.org>
Subject: Re: [RFC mptcp-next v12 00/15] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 02 Apr 2026 18:26:33 +0800
In-Reply-To: <fd0f8787-5395-4a72-451b-d348429e66a5@gmail.com>
References: <cover.1775115102.git.tanggeliang@kylinos.cn>
	 <fd0f8787-5395-4a72-451b-d348429e66a5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2026-04-02 at 09:21 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Script error!
> ❓
> - KVM Validation: normal (only selftest_mptcp_join): Script error! ❓
> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 3
> failed test(s): packetdrill_mp_capable packetdrill_sockopts
> selftest_mptcp_tls - Critical: KMemLeak ❌

It's strange.

Based-on: <cover.1775033340.git.yangang@kylinos.cn> tag didn't work,
this is "mptcp: fix stall because of data_ready" v5.

Without this set, the TLS tests failed. This resulted in a KMemLeak. If
this set is successfully applied, the tests will not fail, and there
will be no KMemLeak error.

Thanks,
-Geliang

> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> - KVM Validation: btf-normal (only bpftest_all): Script error! ❓
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/23890722536
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/88f07fcab32d
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1076267
> 
> 
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
> -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
