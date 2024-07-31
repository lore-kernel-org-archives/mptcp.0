Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEABE5E
	for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390274; cv=none; b=DBBbh32XbKVMWOou1RNzzohp4kubkX/jstgp00CNVOTR25gewyZd3pHJJUIw9llBHpnYh/Y4AxrzH40LdpfC5nioL3aS3rv6w50/foqWR36zbdMExk0pA8KEg8Zx3TD92PfjekGmt2yr+3sUcrEngziJe8VS/uGgTT5EpDGczSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390274; c=relaxed/simple;
	bh=Te7cfhLSSIJs8KTiS3jyg8QBVP5nQfXz+GdszuA/xGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fQDasjDG//hCTgvWW4HbdZ30V7XV8pmLsRenyIaNDE4WFXhQthI09LeHSd18kGlVcoFs4Tn7IlikHvZ0StZUTp4rUPEtGH4O1y0cAKUiOKy1R5vyvYRpVuBOYQ5sY90WbLe9OlhJXIWICRvJrWUYCXoMm/292M1Bdo5D8s7R7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni0Mr2kM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni0Mr2kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 954E0C32782;
	Wed, 31 Jul 2024 01:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722390273;
	bh=Te7cfhLSSIJs8KTiS3jyg8QBVP5nQfXz+GdszuA/xGQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Ni0Mr2kMN6uUHKbga2OT1efmqo0cxcNoPbARaoQ6jEpDB/kxd9TYSVBDXQR58ctRn
	 ksxEZ99/zdxFSnGHi8aEj0jKr8haQaVnxzWlGCCcqHV2gLo1u+usw6ZZQ2BoFj2afr
	 0Puy1hnSWN/MFkCG6ONhcMtgqZ5pBvYM7vuF0uIzwwatLcfZ++4I9yhW+Xo473lwAD
	 3Ah3+ZzYgljyqEojSZSf3BGPFF3zsuyFjhVxF9oWZFMmgUaQfJN4nBpUQFboAb81EB
	 p9S7ePcaI42A2gHiXKBQfEZ70wER5IRcBHhafSItu5VHXoYCEh8JbGwIoUhZK1zQhv
	 H6PAh1JkBHP0w==
Date: Tue, 30 Jul 2024 18:44:32 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v5 00/13] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
Message-ID: <5962e7dc-435a-fdb3-1564-e8cdb701db3a@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 26 Jul 2024, Matthieu Baerts (NGI0) wrote:

> The first 11 patches have already been applied. Here are the remaining
> ones.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v5:
> - Split patch 1 (previously 12): the renaming has been done in a
>  dedicated patch at the end (patch patch 12), for -next.
> - Patch 10: fix typo and avoid memcpy.
> - Patch 11: fix comment.
> - Patch 13: fix build issue and use a new dedicated struct.
> - Please see the individual changelog for more details.
> - Link to v4: https://lore.kernel.org/r/20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org
>

Hi Matthieu -

v5 LGTM, with the "fix when applying" changes already discussed in this 
thread.

Reviewed-by: Mat Martineau <martineau@kernel.org>

> Changes in v4:
> - Patch 19: check for msk->first != NULL
> - New patches 21-22
> - Imported patch 23: might be easier to review all of them, then this
>  single one alone, while it depends on the previous ones.
> - Link to v3: https://lore.kernel.org/r/20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org
>
> Changes in v3:
> - Small changes in patches 10 and 14, see individual changelog (Geliang)
> - New patches 18-20: small fixes
> - Link to v2: https://lore.kernel.org/r/20240715-mptcp-pm-avail-v2-0-fc5153bd1f6e@kernel.org
>
> Changes in v2:
> - Do not split id_avail_bitmap per target in patch 5 (Paolo)
> - Explicit deny (patch 2), reduce indentation (patch 3), stop earlier
>  (patch 4) (Paolo)
> - New fixes and tests (patches 8-17).
> - Link to v1: https://lore.kernel.org/r/20240621-mptcp-pm-avail-v1-0-b692d5eb89b5@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (13):
>      mptcp: pm: re-using ID of unused flushed subflows
>      selftests: mptcp: join: test for flush/re-add endpoints
>      mptcp: pm: remove mptcp_pm_remove_subflow()
>      mptcp: pm: only mark 'subflow' endp as available
>      mptcp: pm: only decrement add_addr_accepted for MPJ req
>      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
>      mptcp: pm: only in-kernel cannot have entries with ID 0
>      mptcp: pm: fullmesh: select the right ID later
>      selftests: mptcp: join: validate fullmesh endp on 1st sf
>      mptcp: pm: avoid possible UaF when selecting endp
>      mptcp: pm: reuse ID 0 after delete and re-add
>      mptcp: pm: rename helpers linked to 'flush'
>      mptcp: pm: reduce entries iterations on connect
>
> net/mptcp/pm.c                                  |  24 ---
> net/mptcp/pm_netlink.c                          | 195 ++++++++++++++----------
> net/mptcp/pm_userspace.c                        |  40 ++---
> net/mptcp/protocol.h                            |  19 +--
> net/mptcp/subflow.c                             |  29 ++--
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  31 ++++
> 6 files changed, 180 insertions(+), 158 deletions(-)
> ---
> base-commit: a9a9b3b154d187864b73eb0e86a0ff737d79a10a
> change-id: 20240620-mptcp-pm-avail-f5e3957be441
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
