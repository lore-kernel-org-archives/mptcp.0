Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33116F274
	for <mptcp@lists.linux.dev>; Tue, 28 May 2024 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902308; cv=none; b=VDjdsn4NCLlUlqbNukOyW0BYP1kZHMocUeh2VfHEgjpCarmq4nAccjTxGV4xIMgRTkMpW34HuNei4UhxPWrYYyxX27nJzS5YJB1z3P7minVGzLhQDMvwcxaP7/7ViWpxkb0fDlZin8EiPFoAq09sWJnQJ1ZjHR+0zRaB0LG96fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902308; c=relaxed/simple;
	bh=21UaUH6ad/Pq+sHvZs0mRYcKLuNizF8Oa8QnSuAAyj0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f39IUuzItmv+TARKC6FoNIlumSmTmSJwClsjWl1jpTXRpOxC56qEoX4YFcJaHboZtU0FTVDDJkD2V1x4GP81oj+Cc2PMD22B0X0VoGhPQKYyrcQxM9942tJ5Q2UgajCkJ9UuteCbIBUipf5k/Fn1f+NEX8cb6NiQWdPdTq6ORuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxQF0ow6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxQF0ow6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA58FC3277B;
	Tue, 28 May 2024 13:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716902308;
	bh=21UaUH6ad/Pq+sHvZs0mRYcKLuNizF8Oa8QnSuAAyj0=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=UxQF0ow6O7VKb6MSCRnoBYwIVW3qNVbX/78qIczUpBJUpxKsIqWETbjekG/nulfrd
	 kKq4sp27WjewHuMeglgoN9mbstOH4gTAW6GGvpBX4w5ZFQMvu+PV+cYkUAvYAzUfWZ
	 RW93M0PupoLUSfj82nN2RpVB3mp4LNLPzJU4GPo30gQouXiTtJW8Ai4e/EkJfRI7fq
	 EBvHPAuhvb4UAJSxfd+U4PC61b8c0dDPgPJRqfAPuMgRSQsHCsqfrKwNJ1blkm0MX6
	 nVDHSoueV+HnltdKJ5tkc9hRFi9yAK/NCnQZZGnRD6IhYtDbGDDCuDjHfbclDzwm/T
	 Vpvc+0Ky51pgw==
Message-ID: <60d8e4dd2e8bb8671200bf009c7f49d9ec545cec.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 5/9] selftests: net: lib: remove ns from
 list after clean-up
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 28 May 2024 21:18:24 +0800
In-Reply-To: <a5f1ae57-009b-4a44-93a9-8bfd38ab672b@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
	 <20240527-selftests-net-lib-fixes-v6-5-72411ff2460e@kernel.org>
	 <312d5bb28672c8bd0eff47fcaf1ea7707bec8d60.camel@kernel.org>
	 <a5f1ae57-009b-4a44-93a9-8bfd38ab672b@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-05-28 at 12:38 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for your review!
> 
> On 28/05/2024 05:47, Geliang Tang wrote:
> > On Mon, 2024-05-27 at 12:58 +0200, Matthieu Baerts (NGI0) wrote:
> > > Instead of only appending items to the list, remove them when the
> > > netns
> > > has been deleted.
> > > 
> > > By doing that, we can make sure 'cleanup_all_ns()' is not trying
> > > to
> > > remove already deleted netns.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/lib.sh | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/lib.sh
> > > b/tools/testing/selftests/net/lib.sh
> > > index b2572aff6286..c7a8cfb477cc 100644
> > > --- a/tools/testing/selftests/net/lib.sh
> > > +++ b/tools/testing/selftests/net/lib.sh
> > > @@ -125,6 +125,20 @@ slowwait_for_counter()
> > >  	slowwait "$timeout" until_counter_is ">= $((base +
> > > delta))"
> > > "$@"
> > >  }
> > >  
> > > +remove_ns_list()
> > > +{
> > > +	local item=$1
> > > +	local ns
> > > +	local ns_list=("${NS_LIST[@]}")
> > > +	NS_LIST=()
> > > +
> > > +	for ns in "${ns_list[@]}"; do
> > > +		if [ "${ns}" != "${item}" ]; then
> > > +			NS_LIST+=("${ns}")
> > > +		fi
> > > +	done
> > > +}
> > > +
> > >  cleanup_ns()
> > >  {
> > >  	local ns=""
> > > @@ -136,6 +150,8 @@ cleanup_ns()
> > >  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \|
> > > grep -vq "^$ns$" &> /dev/null; then
> > >  			echo "Warn: Failed to remove namespace
> > > $ns"
> > >  			ret=1
> > > +		else
> > 
> > nit: Should we also remove ns_list when "ip netns list" is busy? Or
> > should we not delete ns when "ip netns list" is busy?
> > 
> > I think we should do these two commands together:
> > 
> > 	ip netns delete "${ns}" &> /dev/null || true
> > 	remove_ns_list "${ns}"
> > 
> > I'm not sure. WDYT?
> 
> Good point, I'm not sure either. I kept it in the list because in
> case
> of errors, the caller could still get the list of NS that have been
> created, but not deleted yet.
> 
> To be honest, I don't think any actions should be done on the NS
> after
> having called cleanup: it would probably better to kill all attached
> processes before that, and not retry later after errors and a kill.
> But
> I didn't want to change this logic as there might be other impacts.
> So
> at least here, we let the responsibility to the caller, and it can
> call
> cleanup_all_ns() again in case of errors. WDYT?

If so, I think this is better:

        for ns in "$@"; do
                [ -z "${ns}" ] && continue
                ip netns delete "${ns}" &> /dev/null || true
                remove_ns_list "${ns}"
                if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -
vq "^$ns$" &> /dev/null; then
                        echo "Warn: Failed to remove namespace $ns"
                        ret=1
                fi  
        done

If you agree, please update this when merging it. No need to send a v7.

And please add my Reviewd-by tag. I'll repay it in the cover-letter.

Thanks,
-Geliang

> 
> Cheers,
> Matt

