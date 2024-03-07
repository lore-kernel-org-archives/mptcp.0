Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7B839E8
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805006; cv=none; b=upZKmMy0nUKmouqAQ/sOn06e42CXJvbf3vgDBQkSDUUh6Qfd/QWzyOyAukzyl/fS2/I09FiEVG2/U9EqVAqef8Hk367Fvjo0ZwfhyvyHMGpKUrHFgR2HlqgJlnYFUf2iaZ0mrv95EIFFGL+M0frbzn4F7dlfyFbJuTK4iW9FfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805006; c=relaxed/simple;
	bh=0bvoQTlIAzfuDplziYEr+0UXWlSexYxxIdnZkTSeviI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpiSHtQvff6TiZOFCuLN5/E1HtNAyzGL8A0ba3LN+TlXAqSePifKfo9qNXK/SU5Uh/WJVjk9jnoHaLBfyCz0p8DQInQlOVTjM2Xx8UyVR1OUQ4FtVH3Ek7nqfWvbjBO7MTVi4fuQo2d6yc5GaA/aGH8VUi0GcgYJBDI0fvGB/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS6iW4vZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS6iW4vZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9026EC433F1;
	Thu,  7 Mar 2024 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709805005;
	bh=0bvoQTlIAzfuDplziYEr+0UXWlSexYxxIdnZkTSeviI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tS6iW4vZI1ZadLWvB2K0XnmJp08ksQA+hqCimWYRK3/MRUzS91GF84knSzMiP12lJ
	 vAxS3lkPMCBIrFCAqZ6gX8YAL/oG4N632MttR9M9LSafgJ7u2+j8mLRSVXNq1FR1gr
	 ifshS1VDnY9abyb3cvzFzuq7cSgVqudLZ+dpUe0ST4fYgXRlGT2/oQ2iuYs+Gwjb8b
	 ab+ScjjuPuGMODDuFhl1I4fLaaoJmZLNTzr6baO2grxuPfQO0I2PsfM+bl/CLnyrwf
	 7JTwIfiDNAYzxEqV3MdCcGGM0/Ozy+IInx47j+LXxkHEy9el+F6NkRUxtaU9eGhTvy
	 Ktn2Mc5JeiMPA==
Date: Thu, 7 Mar 2024 17:49:59 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: print test
 results with colors"
Message-ID: <ZemNx1NDoNIjlVDH@t480>
References: <6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn>
 <78621021-60bd-4d7e-80d7-2df9a4f3d571@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78621021-60bd-4d7e-80d7-2df9a4f3d571@kernel.org>

Hi Matt,

On Thu, Mar 07, 2024 at 10:35:43AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/03/2024 06:58, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > _printf is dropped now, use mptcp_lib_pr_fail instead.
> 
> Good catch.
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/userspace_pm.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > index 9fc9e574bc27..30652a1c548b 100755
> > --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > @@ -242,8 +242,7 @@ check_expected_one()
> >  		test_fail
> >  	fi
> >  
> > -	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
> > -		"${var}" "${!exp}" "${!var}"
> > +	mptcp_lib_pr_fail "Expected value for '${var}': '${!exp}', got '${!var}'."
> 
> Maybe best to use 'mptcp_lib_print_err()' instead?
> Because a "[FAIL]" will already be printed via test_fail() called just
> above.
> 
> I will apply this patch with mptcp_lib_print_err instead. Please tell me
> if it's not OK.

Yes, mptcp_lib_print_err is much better.

Thanks,
-Geliang

> 
> >  	return 1
> >  }
> >  
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
