Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189772F2A
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163819; cv=none; b=CUVREARX68t+3hGpk3Ku+mMmp1Ws9fYAJzmmNwFQAAL6Z6YcRYRAp0tzMtbfojvCglOUqiULuRRpBBLeduw5eX3hL+XbFsv2yGpGAHf0WVc6MSBy93lXGzuXHOPhpW1youJzbjbAqnz/RRxQ1UOUUyVFA6qfiycscZErobK7VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163819; c=relaxed/simple;
	bh=gbzFOff/QAqACAXAfYAPeGkfruTNW905ytjvZ7TgEBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ExLmKrk9d0OSaQfBp/EWRui+61/Ckjco2V1Wwab7teDM041F9nTmtw7HBi2JQ65QI6ID8fH6gJfR+KesJ43dBcg9licd+LqTyOP807FarE1w+d6JhbVLlVBxxvJUi/jL8ofVQ+od7IDjAKVG/88UnPsgi+gg5FrwH6tYThsQkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEKJV18p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEKJV18p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B7CC32782;
	Fri,  9 Aug 2024 00:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163818;
	bh=gbzFOff/QAqACAXAfYAPeGkfruTNW905ytjvZ7TgEBs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=DEKJV18pDpXiy6Td1bydEBOONZqfvw8npGrZxCJGPo+galjxQ5QHu5L7tfIB78TjC
	 x6oY5lZbY/NGE/+tRW9sUkgbt45zXrGtfzPIO1fvGsEl1aw/Ngx9Jx3nr/lvaOiqls
	 QLGzuevbwtjMKUltjt+Lc8ArAWijpy2+WM3AzcetHlfm0ebwdcGB2LM5AtS+m/rwSd
	 Dt2oziQ8V/jr0DK5BZaXHCif9x3rVaYyi//IC2DkkFxwxhOQdvNtc34wI3bTZsDAD/
	 AlzJ9nQfEZMy4ETTehPHv/fTmROhXA7CkoqbUW2XQE3/OqbzmbQ3S5OTM6BKnj/ws/
	 LMbwywRDs4pEA==
Date: Thu, 8 Aug 2024 17:36:57 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v6 00/11] mptcp: pm: more fixes around the ID
 0
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
Message-ID: <05750c29-565c-925d-18f0-016d480d0a8a@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:

> The two first patches are some small improvements for previous patches
> that are already in our tree, but not sent to netdev yet.
>
> Then we have a fix to send a RM_ADDR with the correct ID 0, instead of
> using the ID of the global endpoint. The test that is linked to that
> doesn't check if the ID being sent is 0, but we can see the reaction of
> the other peer if it closes the connection or not.
>
> The next fix is to correctly reset the ID corresponding to the initial
> address: to avoid some confusion, or not to send the wrong ID if it is
> re-used by another address later on.
>
> That leaded to two extra fix: sending an ACK on an active subflow, and
> allowing to create a new subflow if the subflow was not closed: that's
> because when the RM_ADDR was not correct, the other peer was not closing
> the expected subflow, and the connection ended up being half closed.
> This last issue is fixed by the next and last fix of the series.
>
> The last patch is not for -net. Something that sounds better to do.
>

Ok, after revising my response to patch 5, and a couple of minor changes 
noted for patches 9 and 10, I think the series looks good:

Reviewed-by: Mat Martineau <martineau@kernel.org>

If you want to rework patch 10 given the reverse-compatibility question, 
then you're welcome to apply all but 9 & 10 so you only need to respin two 
patches.


- Mat


> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (11):
>      Squash to "mptcp: pm: re-using ID of unused removed ADD_ADDR"
>      Squash to "mptcp: pm: fullmesh: select the right ID later"
>      mptcp: pm: fix RM_ADDR ID for the initial subflow
>      selftests: mptcp: join: check removing ID 0 endpoint
>      mptcp: pm: send ACK on an active subflow
>      mptcp: pm: skip connecting to already established sf
>      mptcp: pm: reset MPC endp ID when re-added
>      selftests: mptcp: join: check re-adding init endp with != id
>      mptcp: close subflow when receiving TCP+FIN
>      selftests: mptcp: join: cannot rm sf if closed
>      mptcp: pm: send ACK on non stale subflows
>
> net/mptcp/pm_netlink.c                          | 72 ++++++++++++++-----------
> net/mptcp/protocol.c                            |  5 +-
> net/mptcp/subflow.c                             |  8 ++-
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 49 ++++++++++-------
> 4 files changed, 81 insertions(+), 53 deletions(-)
> ---
> base-commit: 2b058d91b96082b282ab2b5bd2dbc7abdd28bacc
> change-id: 20240620-mptcp-pm-avail-f5e3957be441
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
