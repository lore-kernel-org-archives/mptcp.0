Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161C42F6E9
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131131; cv=none; b=e4tDcs6AztD0lWSriP9taa0yymUahsW31njHiTSFtRhD8ItTJRvPb1ahPKiJ3+M/4mYq4Me7ZiJFQfykrMfMWOeTwf5suulUDXwdpkDChXMkysuAakMFCifgIyA9knVZIQ1OzQXFxTzkvWlktlPIawUbbrwwE7zL13Kvu11xYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131131; c=relaxed/simple;
	bh=2c2fZCGv+sMle6CFx0vCHkTzZfZw4Wy2zxp6bNxRYZM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhpuLuQ+XTZ72Z2XOAE+gWyX9lMFUS/dRfF4JMLGzXrXuC1EMsP9bLp+Qst0UIImOLoICJHzNuelYqUBuV02n/6XRSzjvtjoMHAXeetCzBFcK0zvQY95p+hv2E0cHfUZTgA2Bztz7IAUZ29xEgCHr7kAA+tkcKnKW6Lej90nbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz8L/cg+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz8L/cg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E5F1F000E9;
	Wed, 19 Aug 2026 09:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131123;
	bh=nsvbK5ouMt40YxqX9gvuoOycbUMuv+BP1uxWrguyAkc=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=iz8L/cg+bkBUyKwEkU8cTfe39j63hrxJtVxOxDuBrnMUzvpotw8aUZ6ZyEqso5TC2
	 nVsZqXPUiy+XJbhehmEUqc3vvl9ANIHLTvZTEKkh+oldDJRbfCEk5eBsPV/XYbOMeH
	 YiWsPoo3Cke2VUpHKISFJgIHAES/14kepo1y8OgZ4NEI4jFFw/iJXPCj+FRwNXuARq
	 OmIqK/0ispwEis41oiRVUUPNfmcNWqYtfwlnIACROZ9MHPlvLY9co1DNjpBI6e7zg7
	 2344TOlKnPjttwnOsfY8LcwhdOIm+jjsGRs9ZvXfs+9sXe7Hv/eDYIKJpbKXFAVvYU
	 m3tt7/YyW+cQQ==
Message-ID: <ca3835771c68837d6760657bfabc5cdb9c918d86.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/2] selftests: mptcp: lib: get counters for
 the right test
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
Date: Wed, 19 Aug 2026 17:18:39 +0800
In-Reply-To: <3e2f5944-2c0f-4bee-ac18-16835b19c4e2@kernel.org>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
	 <20260813-sft-mptcp-nstat-hist-v1-2-5bb96bae7ef6@kernel.org>
	 <001a333947659c88e41d9fc7847ce35778ea821c.camel@kernel.org>
	 <3e2f5944-2c0f-4bee-ac18-16835b19c4e2@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2026-08-19 at 11:02 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 19/08/2026 10:34, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Thu, 2026-08-13 at 12:29 +0200, Matthieu Baerts (NGI0) wrote:
> > > When the value for a MIB counter is required,
> > > mptcp_lib_get_counter
> > > is
> > > called. It tries to use the cache, if available. If not it falls
> > > back
> > > to
> > > calling 'nstat' directly by looking at the absolute counters.
> > > 
> > > That's an issue for tests that don't recreate the netns for each
> > > subtest. In this case, 'nstat -a' will look at the counters for
> > > the
> > > netns.
> > > 
> > > Instead, it should look at the increment for the current test, by
> > > using
> > > the history recorded in /tmp/<ns>.nstat, if available, and not
> > > using
> > > '-a' which was dumping the absolute values.
> > > 
> > > While at it, rename the previous 'hist' variable to 'cache' as it
> > > was
> > > used to look at the cache, not the nstat history.
> > > 
> > > Fixes: 71388a9f331d ("selftests: mptcp: lib: get counters from
> > > nstat
> > > history")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 +++++++++---
> > > ----
> > >  1 file changed, 9 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > index da1da414c30f..b9d14647f401 100644
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > > @@ -416,19 +416,21 @@ mptcp_lib_nstat_get() {
> > >  }
> > >  
> > >  # $1: ns, $2: MIB counter
> > > -# Get the counter from the history
> > > (mptcp_lib_nstat_{init,get}()) if
> > > available.
> > > -# If not, get the counter from nstat ignoring any history.
> > > +# Get the counter from the cache (mptcp_lib_nstat_{init,get}())
> > > if
> > > available.
> > > +# If not, get the counter from nstat ignoring any cache, but
> > > using
> > > the history.
> > >  mptcp_lib_get_counter() {
> > >  	local ns="${1}"
> > >  	local counter="${2}"
> > > -	local hist="/tmp/${ns}.out"
> > > +	local cache="/tmp/${ns}.out"
> > > +	local hist="/tmp/${ns}.nstat"
> > >  	local count
> > >  
> > > -	if [[ -s "${hist}" && "${counter}" == *"Tcp"* ]]; then
> > > -		count=$(awk "/^${counter} / {print \$2; exit}"
> > > "${hist}")
> > > +	if [[ -s "${cache}" && "${counter}" == *"Tcp"* ]]; then
> > > +		count=$(awk "/^${counter} / {print \$2; exit}"
> > > "${cache}")
> > >  	else
> > > -		count=$(ip netns exec "${ns}" nstat -asz
> > > "${counter}" |
> > > -			awk 'NR==1 {next} {print $2}')
> > > +		count=$(NSTAT_HISTORY="${hist}" ip netns exec
> > > "${ns}" \
> > > +			nstat -sz "${counter}" |
> > > +				awk 'NR==1 {next} {print $2}')
> > >  	fi
> > >  	if [ -z "${count}" ]; then
> > >  		mptcp_lib_fail_if_expected_feature "${counter}
> > > counter"
> > 
> > I noticed that the code being modified in mptcp_lib_pr_nstat and
> > mptcp_lib_get_counter is duplicated. I'm wondering if we could
> > remove
> > this redundancy - for example, by creating a new helper for this
> > logic.
> 
> Thank you for the review and suggestion.
> 
> > # $1: ns ; $@: nstat arguments
> > # If cache exists, return it; otherwise run nstat.
> > mptcp_lib_nstat_cmd() {
> >     local ns="${1}"
> >     local cache="/tmp/${ns}.out"
> >     local hist="/tmp/${ns}.nstat"
> > 
> >     if [ -s "${cache}" ]; then
> >         cat "${cache}"
> >     else
> >         NSTAT_HISTORY="${hist}" ip netns exec "${ns}" nstat -sz
> > "${@}"
> >     fi
> > }
> > 
> > Then mptcp_lib_pr_nstat can be simplified to:
> > 
> > mptcp_lib_pr_nstat() {
> >     local ns="${1}"
> > 
> >     mptcp_lib_nstat_cmd "${ns}" |
> >             awk '/Tcp/ { print "  "$0 }'
> > }
> > 
> > And mptcp_lib_get_counter can be simplified to:
> > 
> > mptcp_lib_get_counter() {
> >     local ns="${1}"
> >     local counter="${2}"
> >     local count
> > 
> >     count=$(mptcp_lib_nstat_cmd "${ns}" "${counter}" |
> >             awk -v c="${counter}" '$1 == c {print $2; exit}')
> 
> The cache cannot be used to check non-Tcp counters because it only
> contains *Tcp* counters. Then that makes this code adding extra
> conditions, and I'm not sure the new helper is worth it. WDYT?
> 
> Maybe it could be added if other modifications are needed around
> these
> helpers, but here, I wouldn't do that in a series targeting -net.

Sure. I can also send a follow-up patch later. I have no other comments
on this series - I'll reply to the cover letter with my Reviewed-by tag
shortly.

> 
> Cheers,
> Matt
