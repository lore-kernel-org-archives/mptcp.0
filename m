Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38508AD23
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 20:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B773C433C7;
	Mon, 11 Sep 2023 20:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694463381;
	bh=VZBl9IB372rybHia7cJeGNW1yolJuzD3V77N7R7qEEU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LUEzS7kWhE4GByqm1AO4Go1YbYOzQNh8p89p7KclRnLmKUbcle0611uA/JI793JXX
	 iPJ2/vSJZi+pvCoYQurtmJIP4Fl7yuU1oLiUeti99AvifO8iPBfVMeE1DztIqdOhQi
	 ACg/zVTeZtteJkmP5w70ghoNsLNfeqSPO/4KR154b8kmEC/FDd91X4vGZ//oLBKljv
	 /0G44vMvzuV1rJBm+xlygtgdqBmWgXrt3MvybpfnJiCuQ54GaOmUkYUsRP4UZSrBsu
	 M54By8A/kTvPX9PoF45HDaTBN6NIJbqEk2s/E5Vw07vJ3FiXh58Zw0okrVll1UT3y7
	 s1+uj6BpVDxug==
Date: Mon, 11 Sep 2023 13:16:15 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v5 0/2] mptcp: fix another close hang-up
In-Reply-To: <f4e8f6cc-d557-4b60-9d22-096595cd2ffb@tessares.net>
Message-ID: <c2c5bcae-931c-f094-7247-ce844765eeb9@kernel.org>
References: <cover.1693988314.git.pabeni@redhat.com> <f4e8f6cc-d557-4b60-9d22-096595cd2ffb@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 9 Sep 2023, Matthieu Baerts wrote:

> Hi Paolo, Mat,
>
> On 06/09/2023 10:30, Paolo Abeni wrote:
>> If the TCP subflows close silently due to timeouts, the msk socket
>> can hang-up indefinitely.
>>
>> Implement an additional close timeout triggered with the last subflow
>> close event and move the msk to TCP_CLOSE when it fires.
>>
>> Should address issues/430 and issues/431.
>>
>> v4 -> v5:
>>  - let the tout always expire for dead socks (Mat)
>>  - fix comment type (Mat)
>>  - targeting net, added fixes tag
>
> Thank you for your patience (sorry for the delay), the new version and
> the previous reviews! It looks good to me!
>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>
> (@Mat: I can add your RvB tag as well, especially because you did the
> previous reviews.)

Sure, series looks good to me as well:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> I just applied these two patches in our tree (fixes for -net) with the 2
> suggestions I mentioned in a reply to patch 2/2 (still possible to undo
> them if needed).
>
> New patches for t/upstream-net and t/upstream:
> - 292454bf7376: mptcp: rename timer related helper to less confusing names
> - 246aefd6e9b3: mptcp: fix dangling connection hang-up
> - Results: 07a89d3454a9..c35c49bddbfc (export-net)
> - Results: 07a689bb4cbf..c23e74879d43 (export)
>
> Tests are now in progress:
>
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230909T160908
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230909T160908
>
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
>
