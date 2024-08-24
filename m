Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7D161
	for <mptcp@lists.linux.dev>; Sat, 24 Aug 2024 00:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460165; cv=none; b=d+BODs4S2AlDU4cOzH+vGc/dVmWN9HrAqyjCBj19jXT7ngQmfaInyha0k9wgtqEHlKYMFFSB5qPsMQ7tqWkGhmDnHdpcGcMD+nwuyA16PKrPTxoEd8RapOlw8rzhyVtiLjs2tRcCO/lDATkKegoHm82P6oUy9RHSuEAX0VTkIPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460165; c=relaxed/simple;
	bh=UXtD0Pybi8D+i5mRRUUhMPdPOf2eYpGTCRhD0SxC1NQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YqoCqXmlQu7C48GtUNn2avdUA3cyLCplR5GHi2O18tt400OGeKShhiJmNnOnEOQveUD/2a1un0zPQE1lsdMP/+YNCmPeBz9oU14+5JGQnFQ+U8QWNHBIli06rn8RbaA94InjYu8hfZD+GovzY1pBM0NWOHvbhbCRYb1jg8AjAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1ZEuHxG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1ZEuHxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBAFC32786;
	Sat, 24 Aug 2024 00:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724460164;
	bh=UXtD0Pybi8D+i5mRRUUhMPdPOf2eYpGTCRhD0SxC1NQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Z1ZEuHxGuRaBC9xQIrb/y5eG4hgbGOadALkaJLDKCP2MQvFgynVxsnLNZfwNxfMab
	 bnvLOCB6DwwJC01CGcjFpvQBpELgoTuGmKMqrJZ+3wnk/0k1GaTSSyZ/0qmU+H1vmB
	 u7U9+FyiuwRINuN9cWiJehu2ZdzobkAlX3bTJHzfE/G+CU1jr1qSmcB3G+cMOlk6D3
	 JbzPNZVY1H2u+x0ZVO703QjoIvefVcU+X4i/x+GxRhkvncNG7W298aVqGesdUydHaE
	 JH0Z59TuEUoziyujMAvdsLMGu7dBxAAhiLiHsMyY7IW38xL8hK1zOve6Y+FxvdGB8v
	 t3ohp9RL6dyNA==
Date: Fri, 23 Aug 2024 17:42:43 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, 
    =?UTF-8?Q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH mptcp-net v2 00/12] mptcp: pm: fix re-re-create the ID
 0 endpoint
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
Message-ID: <9382cd97-6674-d748-5559-d52f33b922fb@kernel.org>
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2132630534-1724460164=:25270"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2132630534-1724460164=:25270
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 16 Aug 2024, Matthieu Baerts (NGI0) wrote:

> Even more fixes for the in-kernel PM :)
>
> There are a few Squash-to patches fist:
>
> - a partial revert for a previous Squash-to patch: probably fine not to
>  block the send of the original patch then.
>
> - improve code coverage
>
> - use the right ID with __mark_subflow_endp_available()
>
> - small fix for the fullmesh case when re-adding the ID 0 endpoint
>
> - set the ID for __mark_subflow_endp_available()
>
> Then a few more fixes:
>
> - avoid the RM_SUBFLOW MIB counter to be incremented twice
>
> - fix re-re-creation of the ID 0 endpoint
>
> - validate that in the selftests
>
> - avoid duplicated SUB_CLOSED events
>
> - validate that in the selftests
>
> - ADD_ADDR 0 is not taking into account by the 'add_addr_accepted'
>  counter, then it should bypass 'accept_addr' & make sure ADD_ADDR 0 is
>  not sent with a new address
>
> - validate that in the selftests
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - New squash-to patches after new issue reported by Arınç: patch 3,5/12.
> - Patch 8/12 is re-creating the ID 0 endpoint 3 times.
> - Link to v1: https://lore.kernel.org/r/20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org
>

Hi Matthieu -

I have one comment for patch 9 that you can add while applying.

A more general question for self tests, is there documentation around for 
our reverse-compatibility goals for the self tests?


Reviewed-by: Mat Martineau <martineau@kernel.org>
--0-2132630534-1724460164=:25270--
