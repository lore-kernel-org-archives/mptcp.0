Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07B331EDF
	for <mptcp@lists.linux.dev>; Thu, 25 Jun 2026 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376790; cv=none; b=Tp01yWKZj91GLZrHwxv1dAWYCD1bnhJ1YgsWM/uprayBgGb/XyKLrTgKZjxTu0vsojnnIqpBDcjWhJ71Kb9Isl3bjIJ23oOvKIiGPHKqXNm58liKRNZbFe0siOqwn8XrdvRvHDiHBQgEXeBYshnZkkNh2rfcc8BUGvq3Mdcof2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376790; c=relaxed/simple;
	bh=bxk87GCQuWyYT8xcghnTFyx1OZPJqi/nlrhLVn3xuJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjFeSL0wrN7b27KWAJ0SuwHlOGKnYmOf88l6QQLWhE/4ALd0v4OeJOFPEJoEbyzRo79W5WZv68TwgSQHKVPDqr+r9RAK6W/5QcnQM0iNI/WsigRej5oJXxNPKrLLrmcV2y7dBSfkCIZFCWKDgKhM3K8GIqKreWipihKuBwacBFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZMimUdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZMimUdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F66D1F00A3D;
	Thu, 25 Jun 2026 08:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782376789;
	bh=OeMzLk05E59pN6Hi0RS59HSsnlKhBsMMonrzgROdlpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZZMimUdIqJ7zpKEZRDeuc/nKhZkUM8BcfrSYhWY6VjojcMR0MyMo3JPW/0qWqcJ2q
	 dEXit6JJ8tXRuL8x4w8ZwrFDOUbx2BrWNivirjfPRXU2Dn5CE6QnquyYJgW7XocvMK
	 SWXzzGguc0rmEXADWbtVd+1q3A3ZwLqG26DrlnfXxd0gorbQ4w+g06L+JhkIvNqigB
	 WUTSCbMClkabO/j8ZxTKkYlvmbb16Zejbw4X6A0HLqNernV0sHV6TV23Dgbi24GkhP
	 Mzl+RjymNn56CdRsU6UEcmJIWt3S8l2JdBdfrPLTIGLb6jD7aM4NV1xqzkcV7A5sK5
	 DJK45GWJu/0mA==
Message-ID: <f644447b-87de-4e9f-81de-d43811f39a4e@kernel.org>
Date: Thu, 25 Jun 2026 10:39:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4] mptcp: fix stale skb->sk reference on subflow
 close
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, shardulsb08@gmail.com,
 Paolo Abeni <pabeni@redhat.com>, syzkaller <syzkaller@googlegroups.com>
References: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260601083010.924938-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 01/06/2026 10:30, Kalpan Jani wrote:
> The backlog list is updated by mptcp_data_ready() under
> mptcp_data_lock(). The cleanup of backlog references to a closing
> subflow, however, was performed in mptcp_close_ssk(), before
> __mptcp_close_ssk() acquires the ssk lock, and while holding neither
> the ssk lock nor mptcp_data_lock().
> 
> Because that traversal ran without mptcp_data_lock(), concurrent softirq
> RX processing on another CPU (subflow_data_ready() -> mptcp_data_ready()
> -> __mptcp_add_backlog(), under mptcp_data_lock()) could add a backlog
> entry referencing the ssk while the cleanup loop was in progress. Such
> an entry could be missed by the cleanup, or the concurrent list update
> could corrupt the traversal, leaving skb->sk pointing at the ssk after
> it is freed.
> 
> A later mptcp_backlog_purge() then dereferences the stale pointer,
> triggering a warning in inet_sock_destruct() (ssk->sk_rmem_alloc != 0)
> followed by a use-after-free in mptcp_backlog_purge().
> 
> Fix this by moving the backlog cleanup into __mptcp_close_ssk(), after
> subflow->closing is set to 1 and while the ssk lock is still held,
> serialized under mptcp_data_lock(). The cleanup runs only on the push
> path (MPTCP_CF_PUSH), where backlog references accumulate; on other
> teardown paths the caller already handles cleanup.
> 
> With subflow->closing set and mptcp_data_lock() held across the purge,
> any concurrent mptcp_data_ready() either completes its enqueue before
> the purge runs and is caught, or observes closing=1 and bails out. Once
> mptcp_data_unlock() is reached, no new skb referencing the ssk can be
> enqueued, so the cleanup is exhaustive.
> 
> Remove the unprotected traversal from mptcp_close_ssk() entirely.

Thank you for the patch. Now in our tree (fixes for -net)

New patches for t/upstream-net and t/upstream:
- 3462c6e4c363: mptcp: fix stale skb->sk reference on subflow close
- Results: b4e31a1d879f..3ca09a35eeb2 (export-net)
- Results: beb02b81dcc9..de7eb4dc952e (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/3c5df8d7e52fe1bca30ed7f1358cd0d51c438800/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/ed605c82f0536e49e42d77d6e77366d59888b4f1/checks

> Tested with the MPTCP kernel selftests on the patched kernel:
> - tools/testing/selftests/net/mptcp/mptcp_join.sh: all tests pass
> - tools/testing/selftests/net/mptcp/mptcp_connect.sh: 68/68 pass

Note that you don't need to specify this: for MPTCP patches, we assume
all kernel selftests and packetdrill tests are passing. If you did other
"unusual" tests -- e.g. running many times a reproducer mentioned in the
issue -- then that's interesting to add that in the commit message.>
> Fixes: ee458a3f314e ("mptcp: introduce mptcp-level backlog")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Reported-by: syzkaller <syzkaller@googlegroups.com>

Detail: it might be confusing to add this: the issue has not been
reported by the public syzbot instance [1], but by a private one
dedicated to MPTCP. People on this mailing list will likely not find the
related issue.

https://syzkaller.appspot.com/upstream/s/mptcp

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

