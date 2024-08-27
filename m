Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C62EAE6
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789384; cv=none; b=TVDr+bS20An+hUfXozyRpPlAt3ecMTlY12ukctlLWzjlSKUrYF+Q2TNtjkmB43RFF1RyeaOZlUwxBiWMoe73fdCCGomIBa/eAHf4q4YKJTA16uyvoz62Y2BW8SlssozYIX7KiGaCvTi8r06zAGOetywze4mjneaHjoINEKKMirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789384; c=relaxed/simple;
	bh=mMfWq1UJW3ZNfUwTkH4I3pUlwmsGIcCWKi8T6OyMavE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ndlIdXp7BxR0Hw080mlR0vEZaMzXqdQJeIaFfDbc28MHzJlMt7TQjO73HO0YzD7BmBSt+ZPZ74b59y/fL5upZN/ragw3VE2mOTSagZ0qRkT9Ls1VneYNzoM5a7eYrqqHUp4HGmZX0HfaGAB6TTYrpM56HkEjRfShEf7KD1fFZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGMyCOPY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGMyCOPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C85C4AF4D;
	Tue, 27 Aug 2024 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724789383;
	bh=mMfWq1UJW3ZNfUwTkH4I3pUlwmsGIcCWKi8T6OyMavE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eGMyCOPYVxxiq3pfqU/q5TpkumFL/nYlmzKgnNgHIS7XnsTZGJVYMsZS73Nh+xURa
	 k6Q7SKs9Lr4Jrruht/zn4weTXSTFExhtWk3d3kc7wy8he5K4gZ0ZqR/VydZh1R4tVP
	 vJKKt6PY0cj1Us1QLht4tTvrGBqId7otyIjdAhSVcH/jAocAxBZgoxtWv4GsQO0swz
	 05Oos7lUqtdzTeP95ZsdPQVQu7VtFwTFpCBHz3C6ZZ9Hj7Xd4jhjhvvX/nQFQsfPdO
	 YCWaI7GSxT2EaOGwMMTOODmzsMMhb5RrBuq8gun5HP4w3Jssw+qybBJpGOIKHj98oB
	 2vd7b8K+ZP4DA==
Date: Tue, 27 Aug 2024 13:09:42 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: Squash-to patches for "mptcp: more
 fixes for the in-kernel PM"
In-Reply-To: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
Message-ID: <41e9e465-c8dd-fa13-a7d9-93a865f2159f@kernel.org>
References: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 27 Aug 2024, Matthieu Baerts (NGI0) wrote:

> These two small squash-to patches would avoid issues recently seen on
> the Netdev CI when this series has been sent upstream.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (2):
>      Squash to "selftests: mptcp: join: check re-re-adding ID 0 endp"
>      Squash to "selftests: mptcp: join: check re-re-adding ID 0 signal"

Hi Matthieu -

Both of these LGTM.

- Mat

>
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> ---
> base-commit: a69c43e7eeeb5c959245dc2a20e6b41bc7afccb3
> change-id: 20240827-selftests-mptcp-longer-tests-f3b30918add9
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
