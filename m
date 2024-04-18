Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC416078D
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458686; cv=none; b=rXbEOUImD1s9wKMro+2AKBxmI0WY5742HPIorRhlqy2YH+7BjaiwWNacC2SR2KpwbT8wotzTKudm7cnCxYRvrLfUxZSYHylmh+kzksf3mrPdLXqLx39iPf8hR2Rx+/KtgVHFlOHXPnVeC7uNAow33UIHihvWl6MARrkYN1DeB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458686; c=relaxed/simple;
	bh=A8sMijOYgrC9+NMTlCO+Ohq6HZKQV39AdrSzuvifcgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iTpuvn1TpgOEd80sBleclVg/i+ScVnRsc+BiCR+m8jA/0Wvbzuxz4vLXZpoli7Z0RJHYGsyM49sbpyVOzz7EOrBN3YEz82SMgc101FIDUVplJmNwkSTEiGxd/wYTqI9Z3MyszJhD73pBRfIddpssGnKAp+2UhBFqcxQQb9bZmc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3aPHtzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3aPHtzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC758C113CC;
	Thu, 18 Apr 2024 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713458685;
	bh=A8sMijOYgrC9+NMTlCO+Ohq6HZKQV39AdrSzuvifcgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=A3aPHtzlMfETmBDtbS3Xd6oDmBhZciNOeLm7xXK2xWdRhNS8vh+Gh6j0d3ieimg+u
	 XpEMnS6rBglHgHvIVN5UKeP8VPDxY/Tv5LNAXiQEGynd9TWIziOjGFMecEEuZ3gGGm
	 wSJYRMiU/T1HeLD3xMEQKAPV2orOjuO1TpAU7ra018sZI1f+xQ3QYfLJLvBNzVeXku
	 vyq+pEhQYaBREpodrGg/mtqXbi+KYc6AaYjcDYreGlN62Srvw3kLuxqJKNRz0cSsqM
	 9ZzIOMixtlUf5kXOdIFHrVuv+L9d1YY+0kwNx7QioSVqH/MLRvrygEJFwqbzCO+t6+
	 RdqQagGe4XASQ==
Date: Thu, 18 Apr 2024 09:44:45 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_first
 scheduler & test" 2
In-Reply-To: <cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn>
Message-ID: <2804769e-9cf0-9ed5-bc7c-491149009269@kernel.org>
References: <cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 18 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Check the string length of sched as Mat suggested.
>
> Please insert this patch into "refactor mptcp bpf tests" v9 as the
> last commit.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 9f17453b2d59..56dca35f289d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -509,6 +509,10 @@ static void test_bpf_sched(struct bpf_object *obj, char *sched,
> 	struct bpf_link *link;
> 	struct bpf_map *map;
>
> +	if (!ASSERT_LT(strlen(bpf_sched) + strlen(sched),
> +		       MPTCP_SCHED_NAME_MAX, "too long string"))

Matthieu, could you change the above message to "Scheduler name too long" 
when applying?

Otherwise, looks good to squash with along with v9 of "refactor mptcp bpf 
tests", thank you!

- Mat



> +		return;
> +
> 	map = bpf_object__find_map_by_name(obj, sched);
> 	link = bpf_map__attach_struct_ops(map);
> 	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
> -- 
> 2.40.1
>
>
>
