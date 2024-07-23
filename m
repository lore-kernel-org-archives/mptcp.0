Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F3BA40
	for <mptcp@lists.linux.dev>; Tue, 23 Jul 2024 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694282; cv=none; b=O5Lw2Ate6x6IWYcdiUWb/a7pdZZ9L6hB83JOyvzS/OgIR4ZGoOCuFYnda98VdTL8EnLhJJfhJOD7bReXbjBiYlcPxrSo462KYfvFEAxape63HiThHYS2VJu7K5Qy7IjS+fqC2DSyogQ0i54DAg84CaUJjQmWAb2mAZTr+64ZBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694282; c=relaxed/simple;
	bh=VCvjBdd8b4Xf7g32U8ynrPRjRdoYcw+biePBxRCw1K8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A9q3ah1X4uH9QhsPYA1P0PlQ+SZx9lTfkpepngx6XsbDKg9stzz6iNqjsf9c238oCvPo4d7yTs/5OHJDvgX2FyrGkcGA55GWTzjliETcZZy1LnI0w9MXcqm8L4zWvMi49bNomcsHAb0DaF2PaP7nfNv5KdSxnb0gtakgqiTK65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjW44A56; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjW44A56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F19C116B1;
	Tue, 23 Jul 2024 00:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721694282;
	bh=VCvjBdd8b4Xf7g32U8ynrPRjRdoYcw+biePBxRCw1K8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gjW44A56b2gXsw1UFmEhJq2LahlqbD6Dr432CWosTM0k3IhbFQBUj5zAro4sHI0H3
	 bx/Ebea3Vu7llRE2fLAdHbE071GDlOR87lo2+gyppC7Ec47UH7tWKRkxNhpHk4xg29
	 RZYRLEvXoEbtx9ij78pyJ9a1oeczZjBHlUMeVd4SX3NsW/bVsxbyhPc/IC+Hpard8h
	 No9h5so8awEy571r9Tqf3sbCnaHLenA7l1qBxsNlJu5uH554X5Rnwr19Zw3SM95+Rc
	 Kj65iqUvR9lhJE5Ly+L3tu1q+sRi2UXm1oY9ok+/xjy/uRHFDTz9Myevc1t81EgYfw
	 lDFM6LH1E76Xw==
Date: Mon, 22 Jul 2024 17:24:42 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3 0/9] mptcp: fix inconsistent backup usage
In-Reply-To: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
Message-ID: <a59b9b6a-0c6b-0918-415e-378a482b3d6b@kernel.org>
References: <20240718-mptcp-backup-mpj-v3-0-1f6cd9b89ee4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 18 Jul 2024, Matthieu Baerts (NGI0) wrote:

> In all the backup tests we have, the backup flag is set on one side, and
> the expected behaviour is to have both sides respecting this decision.
>
> On the scheduler side, only the 'backup' field is checked, which is
> supposed to be set only if the other peer flagged a subflow as backup.
> But in various places, this flag is set when the local host flagged the
> subflow as backup.
>
> One last thing that has been fixed is the backup flag in 'signal'
> endpoints: it was working only when setting the backup flag while the
> connection was already opened. That's what the MPJ selftests were doing
> to check that the signal endpoint were supporting the backup flag (on
> purpose I guess, because the support was broken in MP_JOIN...).
>
> The last two patches adapt the BPF selftests to mimic what is now done
> by the in-kernel packets scheduler.
>
> Note that the Packetdrill tests need to be updated because the behaviour
> has been changed / fixed:
>
>  https://github.com/multipath-tcp/packetdrill/pull/152
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v3:
> - Small fixes in patch 1 and 5: see the individual ChangeLog
> - Use a new dedicated helper in patch 6: see the individual ChangeLog
> - Link to v2: https://lore.kernel.org/r/20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org
>

Hi Matthieu -

v3 LGTM. I'm not sure if the new MIBs are best targeted for net-next, they 
do help with testing but don't seem critical for -stable.

Reviewed-by: Mat Martineau <martineau@kernel.org>


> Changes in v2:
> - new patches 4 and 5.
> - split patch 6 in two (code then tests) to ease the backports.
> - patch 6 addresses Mat's comments, and support the ID0 case.
> - Link to v1: https://lore.kernel.org/r/20240711-mptcp-backup-mpj-v1-0-d45506182a9e@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (9):
>      mptcp: sched: check both directions for backup
>      mptcp: distinguish rcv vs sent backup flag in requests
>      mptcp: pm: only set request_bkup flag when sending MP_PRIO
>      mptcp: mib: count MPJ with backup flag
>      selftests: mptcp: join: validate backup in MPJ
>      mptcp: pm: fix backup support in signal endpoints
>      selftests: mptcp: join: check backup support in signal endp
>      Squash to "selftests/bpf: Add bpf_bkup scheduler & test"
>      Squash to "selftests/bpf: Add bpf_burst scheduler & test"
>
> include/trace/events/mptcp.h                       |  2 +-
> net/mptcp/mib.c                                    |  2 +
> net/mptcp/mib.h                                    |  2 +
> net/mptcp/options.c                                |  2 +-
> net/mptcp/pm.c                                     | 12 ++++
> net/mptcp/pm_netlink.c                             | 19 +++++-
> net/mptcp/pm_userspace.c                           | 18 ++++++
> net/mptcp/protocol.c                               | 10 +--
> net/mptcp/protocol.h                               |  4 ++
> net/mptcp/subflow.c                                | 10 +++
> tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c |  3 +-
> .../testing/selftests/bpf/progs/mptcp_bpf_burst.c  | 12 ++--
> tools/testing/selftests/net/mptcp/mptcp_join.sh    | 72 +++++++++++++++++-----
> 13 files changed, 142 insertions(+), 26 deletions(-)
> ---
> base-commit: 50d1a79f5003b88b03b37d05189ad02a84d7be49
> change-id: 20240711-mptcp-backup-mpj-2f8369fad366
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
