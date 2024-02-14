Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FC1AAD0
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911234; cv=none; b=HbP+DEk2QsJW0Xxp1PBFxEUk37jdAYUhx84ZkmPkL/imKnQRezPBck8CkOHkf4bFwHKiVjP9PO3M0pobNJD8z+WEHHiDdEZEYbdlFKO1/ScgQcmkL4DB3qsyM5vJ/ET9a6vDoHE3b8J+yGdJT+W2JXHH9ez6I5sG1Oo18RaJoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911234; c=relaxed/simple;
	bh=hzoDvORcUODn2TltLUt00ijqxloyOuBDD2eTsyZl7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7FdnqJahWRuX5LwR7P39u+hDOvE6+jGeKc31zoNmSGeIEFBs26Rm4Kva9NXWajpLRwh0FTSJIkz0t5KaWPHUBE25l1lIyOflY0nKU2CV8pdUdpd3FbE1tVZ2Zwd52QaRdmfF4UkOtULNROEycRGdx/SjojX0if6bNwNazWwc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFRIALqv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFRIALqv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F556C433C7;
	Wed, 14 Feb 2024 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707911234;
	bh=hzoDvORcUODn2TltLUt00ijqxloyOuBDD2eTsyZl7fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFRIALqvFS6WTRRpiNXB5dmCj7gWVFmPGyfSRbBiUEw6aeH5S5FCNLT2/N+opBxj+
	 UmWo6XRQYjVBIdw0G4rPu+N8DVCRIhU+8S+zgzA5YYv+QSNvnIOU0gXptlKXFnoRIm
	 sQTGomxWopT53u4BDKUb3l80KBx2hFBducxN5xt3ULRB2q237RVrW82VIhDIjma0l3
	 MfdN1lOg10hhdrCu2ofMj7ah4eg1trTXZ0PcASiWfN2sN7+bBKibs915+GAIBf0qAF
	 Cpa9tkumWCnR+pTbhCk7MHIBKvisL2qzcTNe48PVQgRgenefkEZZ51xne7tNfIIV1X
	 Q+YI6BLTlbuSw==
Date: Wed, 14 Feb 2024 19:47:10 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 2/2] selftests: mptcp: rm subflow with
 v4/v4mapped addr
Message-ID: <ZcyoPhQU4N8twwsu@t480>
References: <cover.1707270765.git.tanggeliang@kylinos.cn>
 <0c91c59ef950d3e64237e8a667a244ef850d0981.1707270765.git.tanggeliang@kylinos.cn>
 <2f1a2240-b213-47b5-bd4b-4bd398bae475@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1a2240-b213-47b5-bd4b-4bd398bae475@kernel.org>

Hi Matt,

On Wed, Feb 14, 2024 at 11:18:04AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/02/2024 02:55, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Now both a v4 address and a v4-mapped address are supported when
> > destroying a userspace pm subflow, this patch adds a second subflow
> > to "userspace pm add & remove address" test, and two subflows could
> > be removed two different ways, one with the v4mapped and one with v4.
> 
> Thank you for validating this.
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > index 3a2abae5993e..69001d2a8dab 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > @@ -213,9 +213,12 @@ mptcp_lib_get_info_value() {
> >  	grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
> >  }
> >  
> > -# $1: info name ; $2: evts_ns ; $3: event type
> > +# $1: info name ; $2: evts_ns ; $3: event type; $4: addr
> >  mptcp_lib_evts_get_info() {
> > -	mptcp_lib_get_info_value "${1}" "^type:${3:-1}," < "${2}"
> > +	local addr=${4:-""}
> > +
> > +	cat "${2}" | grep "${addr}" |
> > +	mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
> 
> When modifying shell scripts, please make sure 'shellcheck' is happy
> with the modifications you did.

Sure, I'll use shellcheck to check my script modifications next time.

> 
> > $ shellcheck -x mptcp_lib.sh
> > 
> > In mptcp_lib.sh line 220:
> >         cat "${2}" | grep "${addr}" |
> >             ^----^ SC2002 (style): Useless cat. Consider 'cmd < file | ..' or 'cmd file | ..' instead.
> > 
> > For more information:
> >   https://www.shellcheck.net/wiki/SC2002 -- Useless cat. Consider 'cmd < file...
> 
> I then did this modification when applying the patch:

Thanks a lot.

-Geliang

> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > index 69001d2a8dab..3777d66fc56d 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> > @@ -213,12 +213,9 @@ mptcp_lib_get_info_value() {
> >         grep "${2}" | sed -n 's/.*\('"${1}"':\)\([0-9a-f:.]*\).*$/\2/p;q'
> >  }
> >  
> > -# $1: info name ; $2: evts_ns ; $3: event type; $4: addr
> > +# $1: info name ; $2: evts_ns ; [$3: event type; [$4: addr]]
> >  mptcp_lib_evts_get_info() {
> > -       local addr=${4:-""}
> > -
> > -       cat "${2}" | grep "${addr}" |
> > -       mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
> > +       grep "${4:-}" "${2}" | mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
> >  }
> >  
> >  # $1: PID
> 
> Note that it is not strictly needed to add ':-' in '${4:-}' (we don't
> use 'set -u'), but it clearly shows the argument is optional.
> 
> I also edited the comment above the declaration of the function to
> reflect that.
> 
> About 'shellcheck', please note that for the moment, not all scripts are
> shellcheck compliant, only 'mptcp_join.sh', 'mptcp_lib.sh' and
> 'userspace_pm.sh'. For the others, it would be great if at the least the
> new code is shellcheck compliant. I don't think it is needed to modify
> the existing ones, they are not often modified and they work. (Except
> maybe if there are some other big modifications needed.)
> 
> Also, some checks can be ignored with '# shellcheck disable=XXXX'
> directive if needed:
> 
>   https://www.shellcheck.net/wiki/Ignore
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
