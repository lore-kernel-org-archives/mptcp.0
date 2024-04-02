Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A505414B062
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075330; cv=none; b=hgrb5LPztSCHWbYDet3xjEw9gQbIADa6EtBK5ZJDTpJm5lQmD8S7JZSiyMedHN/uyE8NZrojTB0quY+1iPZudFz8Ic/QTDnKOAcN9IaTyx+Jlyculv7de4Pp6ksCIuUzwxUiRjqzbgkjvj3ZyFyhMNIZYFMGHjOZ4TAxaxA6IsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075330; c=relaxed/simple;
	bh=oUdZ8QZAswlXWD3/77ZMtSbYfJnfzgeKBMMuEceBwLA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IuPMRIZEjT4MDt+mQULwQVT2sJxPwSMH32a1Ib37DcuE/eJJyb6uR3oXc8Fi647O07BWQkdgYNyB0SNjFMOllZpId1Yi5gbWyvcpb+5ObPeqLqxDALGr0ryU4E90XHCcpqDHv3MPx72+EVy921i8koLsKCWcADilQsOCrYZcF5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNSbBc74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNSbBc74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C043C43390;
	Tue,  2 Apr 2024 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712075330;
	bh=oUdZ8QZAswlXWD3/77ZMtSbYfJnfzgeKBMMuEceBwLA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cNSbBc74CpZmWuLSI3KcSBIyHrNDgdn9NoPMnEJlBaPhqHWcvYqKlK/8Eh2LFA3Cs
	 wvHB54rHTIjsxC1T1X6sIt8IIsqONYzrbr5SgR/WJnw0d+39jgz+cW58eo76pi3t+t
	 6gVYnTYClw4LDnOwJDynaM7ZYC8HaCaGtmzmhWZ6ckjpBR46EJ+GIs7yJvgeQCFoHi
	 zCQ8LWEHw44DuGbZm+899y8asNQdnryHrHsyfs1enByciSB/S2PIANhd4uI4AN9Kf6
	 ++1DLMNW9jpzBSoj+Amx8kLJltyaC9QxXDqQEKWcxiiyxTVfCUqEmw3EfW16e40xon
	 bK2zhWomucGXQ==
Date: Tue, 2 Apr 2024 09:28:49 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/2] display "last time" actions info
In-Reply-To: <cover.1712062199.git.tanggeliang@kylinos.cn>
Message-ID: <24ec2290-7304-75be-8f2b-0fda1695190c@kernel.org>
References: <cover.1712062199.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 2 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> v5:
> - merge the squash-to patch
> - rename cnt1/2/3 as Matt suggested. (thanks)

v5 LGTM (with Matthieu's suggestions), thanks Geliang!


Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> v4:
> - address Mat's comments for v3 (thanks).
> - merge patch 1 and patch 2 into one.
>
> v3:
> - address Matt's comments for patch 3 (thanks)
> - add "dport", "sleep", and mptcp_lib_expect_all_features.
>
> v2:
> - address Mat's comments for v1 (thanks)
> - set msk->last_data_sent only if err > 0
> - set last_data_recv in __mptcp_move_skbs_from_subflow
> - add three reserved bytes after mptcpi_subflows_total
> - move selftests from mptcp_join.sh to diag.sh and check that the
> timestamps move forward.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/446
>
> Geliang Tang (2):
>  mptcp: add last time fields in mptcp_info
>  selftests: mptcp: test last time mptcp_info
>
> include/uapi/linux/mptcp.h                |  4 ++
> net/mptcp/options.c                       |  1 +
> net/mptcp/protocol.c                      |  7 ++++
> net/mptcp/protocol.h                      |  3 ++
> net/mptcp/sockopt.c                       |  4 ++
> tools/testing/selftests/net/mptcp/diag.sh | 51 +++++++++++++++++++++++
> 6 files changed, 70 insertions(+)
>
> -- 
> 2.40.1
>
>
>
