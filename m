Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9825392C
	for <mptcp@lists.linux.dev>; Sat,  1 Aug 2026 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542784; cv=none; b=W84nseNXb+jF8M9U7pk/VPULQonlFSJ+1imwRSBCh2V6C9Ir1l/Y2xe9FId5eYEV32XvDp61kmEPBB2f3+RnnAlGFV4dVVub6JKCzpoW5C8h7UdRGhyyqsndAXCeHgSrmVT7X1749SE3jyDf969HR4O1ivHTTsXv9yNcH+Nel04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542784; c=relaxed/simple;
	bh=NoQpXfv3c7THUi9ONzieOiUoB9yTh5eau8STOwWOxG0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZF1bflNFBA00rN/+8I4cktP+p/rRyK+5p936njASZrv7y8yLJnoOPRjgWT+RNDpbNuilNf0NLv8yRn3WgIcbzhcnKa+sarysGDBaxCSC7QecUbniIjwGIfL97Zeou5kN2TRKbBuZoTMgr8ZvnCIkzUPh4uZE46EVni552/oeP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtG9+e7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtG9+e7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EFC1F00AC4;
	Sat,  1 Aug 2026 00:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785542775;
	bh=RU0PMssrt6SrKilsfcufB6p3t0gyUga6mHrMxYCDXDw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=QtG9+e7aUAbqfMqiMJFJBwVLwaS/cBGul/P/Gdzl+VUW8DVmEyiA9siKIHBru0Ro6
	 yu9iBJzNNeV0Qxit0Q3k9PGpOujiZZFZeI7l/sP3Bug/O5VDOtxNcQjAfAU3UKdee8
	 7CkDjMHSWQVWGDQsGahOE/zfEFqF2JSFHkbkAWmrpd+qeFFkpnE2N0OkSbO7VbbBhj
	 JRBmP3NiSvvrII3bplSWY823scHHh5m5UwmNjDzlSlBQm2er7qg8NcOgi0Jvnx2kb6
	 kmGCgfObVamJ1kTmtLRP8Mtf3gOrlmVabamzQgz40Obd+BHf65avgzE+7tz0scHxEO
	 SwlefgwJIDLTw==
Date: Fri, 31 Jul 2026 17:06:14 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net 0/6] mptcp: pm: userspace: properly deal with
 the ID0 case
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
Message-ID: <317887c0-8298-3b5a-5cb1-70beaf968a04@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 Jul 2026, Matthieu Baerts (NGI0) wrote:

> In MPTCP, the local address and port used by the initial subflow has the
> ID "0". It means that when this address and port are used for some
> operations -- e.g. creating a new subflow -- they should be linked to
> the ID0, and no other addresses and ports can get this special ID while
> the initial IP address and port is used.
>
> Instead of dealing with the ID0 case as an exception, add it to the
> local addr list, and deal with it like the others, with minor
> exceptions. That way, it seems easier to maintain instead of adding new
> exceptions at a few places, at the cost of a few more bytes, which seems
> OK in this mode.
>
> The first patch modifies add the initial address to the list, and the
> others remove exceptions, and validate that in the selftests.
>

The approach looks ok to me. Have you tested with mptcpd?

- Mat


> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (6):
>      mptcp: pm: userspace: properly handle the ID0 case
>      mptcp: pm: userspace: allow announcing ID0 addr
>      mptcp: pm: userspace: no ID0 exception for RM_ADDR
>      mptcp: pm: userspace: don't dump initial ID0
>      selftests: mptcp: join: new ID0 subflow from the right IP
>      mptcp: pm: restrict in-kernel worker actions to this PM
>
> net/mptcp/pm.c                                  |  8 ++-
> net/mptcp/pm_userspace.c                        | 69 +++++++++----------------
> net/mptcp/protocol.h                            |  1 +
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  7 +--
> 4 files changed, 37 insertions(+), 48 deletions(-)
> ---
> base-commit: ddf9f880a057486230f16d6a4a8cab7e41c40da1
> change-id: 20260724-mptcp-pm-userspace-id0-case-f074f64466c8
>
> Best regards,
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
