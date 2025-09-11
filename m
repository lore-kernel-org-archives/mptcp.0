Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF62EBB98
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584647; cv=none; b=b1+VFpEHg+GrmEb/D0rbnN1aIRRDYmi8Xn3U5zleFVff0wyVnlruEhkELoCSpv1ckLi0c2oGcRMBkZ8SrMb7IrqoChZycQUV3g3K/D4eys0THW1CIX+sr+yxqd9wuKvdwrJ2OtYoFq1mTWWRhcGwj5suPuX8XOWXhblUTTnF/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584647; c=relaxed/simple;
	bh=dDCFLN4tclGhJlAiHRI2T/c5mo/3qWQ4BNmDF7sKf0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=okpUiSGGRCS8AFXVWAE99ede0UL3T7AYQBpq4Kqvwic+/qN9xyJgMdLZXSlYvFnq4VT5k0x5juK8UbBBmvdpYpnX7JFmhYY5K3CwmVGkXBMDWG7fGZuNGmZEzwxZQ4hceqJ3Vq2SeYfttrUxIo1kGALw19Ts7zwbsT1HteV70hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxGZTFZh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxGZTFZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA0C4CEF0;
	Thu, 11 Sep 2025 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757584646;
	bh=dDCFLN4tclGhJlAiHRI2T/c5mo/3qWQ4BNmDF7sKf0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DxGZTFZhg7Ac0DOhzK+0hBvXi4EaM4eHWFB39v+VcERq1IA4X4fUynV/EDTOo4atk
	 GShfkIAnarN5OLz52443LI70loN/rymPQmLB41yXXDFTLfOrBbZod0h7xULgI1xkda
	 +xRzJUfFT71WtUaoL9baalFeVNO4Op2GoOc/wJNwHBRK86d+y4Ez4uOEguEq6ANH7O
	 2vIxg7L7e2VaKwQjNTp5fFHFp6qe3v7JQnAPjj3skM6/hm3m+XZXnBqvNhWIWaFYHD
	 8zO+VUzGRg6rIfXCKfC6lsD4FfxEvrRFo/zeRPv4JHTV7/P3wnTe+zpQzDU8oKhs/k
	 4eHdaoXOtQ+fQ==
Message-ID: <36cc4557dbabf935e9a4e027f1e76aeed3caea42.camel@kernel.org>
Subject: Re: Patchwork: Prioritising the queue
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Mat Martineau <martineau@kernel.org>
Date: Thu, 11 Sep 2025 17:57:22 +0800
In-Reply-To: <6ddd8121-331b-4f93-b0ce-5eb7871ac553@kernel.org>
References: <6ddd8121-331b-4f93-b0ce-5eb7871ac553@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Wed, 2025-09-10 at 19:05 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> As you may have noticed regarding the reviews of your patches, we are
> lagging a bit behind, sorry for that.
> 
> Here is the list of pending series:
> 
> - only remove entry from local_addr_list when sending a REMOVE_ADDR
> - mptcp: TCP_MD5SIG support
> - refactor MPTCP socket option handling
> - mptcp: add more sockopts
> - selftests: consolidate TCP_INQ testing into sockopt
> - implement mptcp read_sock
> 
> (+ the WIP ones marked as "changes-requested")
> 
> Can you help us to prioritise this list please? Which ones should we
> start with? Priorities can be given based on the dependences and/or
> your
> own priorities for example. With that, we can iterate over them one
> by one.

All my queued patches can be divided into three groups: Path manager,
NVMe over MPTCP, and sockopts. These three groups have no dependencies
on each other.

1. Path manager has two sets:
- "BPF path manager, part 6"
- "only remove entry from local_addr_list when sending a REMOVE_ADDR"
These two are not directly dependent on each other. "BPF path manager,
part 6" has higher priority, as there is a part 7 still queued.

2. NVMe over MPTCP has only one patch set:
- "implement mptcp read_sock"
Its priority is not as high as the BPF path manager, but there is
another set called "NVMe over MPTCP" queued in my tree.

3. The rest are all sockopt-related and have lower priority:
- "refactor MPTCP socket option handling" is still valid and does not
depend on any other patches.
- "mptcp: add more sockopts" depends on the previous set and is still
valid.
- "misc fixes for sockopt selftests" has been reviewed and requires a
v3. I have marked its status as "Changes Requested".
- "selftests: consolidate TCP_INQ testing into sockopt" will conflict
with the previous set, so I have marked it as "Superseded".
- "mptcp: TCP_MD5SIG support" depends on the previous set, and I have
marked it as "Superseded" too.

Thanks,
-Geliang

> 
> Cheers,
> Matt
