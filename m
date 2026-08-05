Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEEE331EB3
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922011; cv=none; b=GttTybdRQaeS2H9tS1FLTsLPbs7NfBF/E1DSfupC4tN/zlGHIsO/hkJgJs8CtSfm3VpX/xOl/fLRuD5hEHMGEmiVbgDw+LMHGXuelrks2vyUWMRy/MhSGlpbqzZrj7QksQKfTiBsWUg+rxcaZ8L6UWlou1bs+jSLSCYQm032Se8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922011; c=relaxed/simple;
	bh=wa087nn6aldHW5bhM+GbPWr5L0zgOV8qKMUpOFaOXJ4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UQIPtdyYBz+0vw9jtKzzpAvNiN36h3LAroVbkmbclabgNkRv8mYn2tUSoTpgPfOs4XwMWeGgKFEigP3GKidJAaazmAF+XQBugdyOhsAkVv8tnA9Eh4GP+rzoZDrA7JW3ZFZkRZoC8J/nCbsIC6mmOywuAevgE3LZ5EBtOLGbmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inr/uzOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inr/uzOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E85D1F00AC4;
	Wed,  5 Aug 2026 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922010;
	bh=KX48V1Rk2TIWFSUKY3njxJdaTRGvJbjck8QL7jYzvFI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=inr/uzOctjf9Mld1c5yJJxTuLG5d+qB+QeX7mw3m03Xi1UmXFhepfmS6i+VniIsnL
	 FjmucCtgS2M9fxnpFi/ftQyM3TF/p1WL38slWmBpmhRaHoswk/C/OjkRWDGphlb43Z
	 qYdLikxkQX5BnBbgazXpGy5LW0gBkKYOceV86mCDHodql0SFm8Q49TxvvQgNnzthr3
	 YhQb43Vjiavz68OKVPm0rg4LpSOYAaaShvRs7DiHlryyWo1hJ3ZSLsbMfOX9uR2PUV
	 EJs6/jltljP7lmZ+ZBHoy+4mLRekyuxTBv6gQQuotCOPwcWbJNJJ9TM6u8WQqDxVZM
	 paj9o6qge5eBA==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-next v4] mptcp: honour configured min/max RTO in
 retransmit paths
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev, matttbe@kernel.org, martineau@kernel.org, 
 pabeni@redhat.com, shardul.b@mpiricsoftware.com, janak@mpiric.us, 
 kalpanjani009@gmail.com, Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
References: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com>
Date: Wed, 05 Aug 2026 11:26:42 +0200
Message-Id: <178592200238.584022.14857128963976903477.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2487; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wa087nn6aldHW5bhM+GbPWr5L0zgOV8qKMUpOFaOXJ4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKKGa8zzPlx2+X35KDe4JsscbbPc1SNzK/OYT0ba7I8P
 G/Fi5AZHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhvCxSkAE9FZxfCHp31iyrm5iU26J74U
 Tgg+Yen4wEspNWBi2kGfkuB13T5CDH/F+f7vanmm9liQJ//z/JAch8AtT2/O02u7fPaIReGJxsc
 sAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Hi Kalpan,

> The MPTCP-level retransmit timers (DATA_FIN retransmissions and the
> fallback timeout) used the hard-coded TCP_RTO_MIN / TCP_RTO_MAX
> constants, ignoring the tcp_rto_min_us and tcp_rto_max_ms sysctls.
>
> Make them follow the sysctls instead: seed icsk_rto_min / icsk_rto_max
> on the MPTCP socket from the per-netns sysctls in __mptcp_init_sock()
> -- the msk does not go through tcp_init_sock(), so these fields would
> otherwise stay zero -- and read them directly where the constants were
> used:
>
> - mptcp_set_datafin_timeout(): both the backoff cap computation and
>   the resulting timer_ival. The two sysctls are validated
>   independently, so rto_min > rto_max is a valid configuration; keep
>   a max_t() guard so ilog2() is never called with 0.
>
> - __mptcp_set_timeout(): the fallback when no subflow timeout is
>   available.
>
> The icsk fields are read directly instead of using the
> tcp_rto_min()/tcp_rto_max() helpers: the MPTCP socket does not perform
> routing lookups in these paths, so the rto_min route metric checked by
> tcp_rto_min() can never apply here. The TCP_RTO_MIN_US /
> TCP_RTO_MAX_MS socket options are not supported by MPTCP setsockopt()
> either; this can be revisited if they get supported on MPTCP sockets.
>
> The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (default
> add_addr_timeout) and net/mptcp/subflow.c (MP_FAIL timeout) are
> intentionally left unchanged: they use the constant as a default
> duration, not as an RTO bound on a retransmit timer.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
> Reported-by: Li Xiasong <lixiasong1@huawei.com>
> Closes: https://lore.kernel.org/all/95552642-7b60-410b-9953-70e0b31a90e1@huawei.com/

I guess we can remove these two lines because it was about fixes related
to the route checks that are no longer used, and this might be confusing
for others, right?

If yes, no need to send a new version, I can remove them when applying
the patch. The rest looks good to me:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Also, usually there is no Reported-by tags when addressing review
comments: you can either use 'Suggested-by' when the whole idea was
given by someone else, mention a person in the commit message if a part
of the idea is coming from someone else, or only in the changelog.

BTW, thank you, Li, for the previous review!

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
