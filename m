Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B31129A9D
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805812; cv=none; b=QQag9EOq4ducOpRECPfX7+RwDN7fXmyvjrE6vmf2YmgTR7dFs70/aAHluptn54LFsMrO9K90DbMQKsNSmU+pcWVYqCvz5HGj/l7s1Rs2LJKLiHO2ZDcNkcmC9XFgJdpm8bYHAmjjFvFtKN07sTbbqwu83BtLo4jkvvlyVVW4rn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805812; c=relaxed/simple;
	bh=efUQKT6HLf1cTbV1ONgDlw3FwR4rdxLQJuqr52Z3NN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqR+IkLDUWefBZtMCGon2V4Y/SQMcwuIR/6uAKigziZCbkSegbBufiNB+WRZ8O85GcYQqgSdJUPTBIBtuTmDQa+74cBBNiTVDK0W6h2Uk+toUaHupmVvBwtQEKrdXnabJ36H9pSCSiMgMi+mqmRD6MM3n5SG+sjEfhQ1QP9vEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6l5VyDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6l5VyDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F59FC433F1;
	Thu,  7 Mar 2024 10:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709805811;
	bh=efUQKT6HLf1cTbV1ONgDlw3FwR4rdxLQJuqr52Z3NN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6l5VyDD6pB0wXAD1ES4IGQ3s37uNUH2LDUJ6bihw819+C+SigYF5+iIRRH59BTPz
	 PKccEt8wLM0Gph//9xmWT3lXUG48KNod2Z/JpyAGX4C8wQoq9tgBh1eCY2555EPxwV
	 6ViO0wW8drIwbi2NtlK0L5RT6jlGMwrjkjTN2aU1XWABAki1OUOR9kKs9sKI6SvO7R
	 eeo+jcsvnmekgE2LqJn4M9Nzl4BdifZScSMtORRFp8U+hNEzMpG6ocjiZ6jmLtOlzm
	 qlFiDLFKV885uYljcQXbapdNBsuB9uxZPP1X8wCRbVLvixZaTUb5/MY163MEyyrgWi
	 PZWf3tiO/WQSg==
Date: Thu, 7 Mar 2024 18:03:25 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: connect: add
 dedicated port counter"
Message-ID: <ZemQ7eI8ZT4fMGOB@t480>
References: <cover.1709773913.git.tanggeliang@kylinos.cn>
 <17e1c8e1f7e8a30585c3b8d2b0711f3d8f4e460d.1709773913.git.tanggeliang@kylinos.cn>
 <ef4e2d4d-4de1-4d56-b92d-3fb2602e2e8e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef4e2d4d-4de1-4d56-b92d-3fb2602e2e8e@kernel.org>

Hi Matt,

On Thu, Mar 07, 2024 at 10:25:44AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 07/03/2024 02:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Move port++ from the beginning of do_transfer to the end of it, then
> > 9999 can be set to 10000, the same as 19999.
> 
> I initially wanted to do that, but...
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 5942256857a5..8feb4eef0931 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -33,7 +33,7 @@ do_tcp=0
> >  checksum=false
> >  filesize=0
> >  connect_per_transfer=1
> > -port=$((10000 - 1))
> > +port=10000
> >  
> >  if [ $tc_loss -eq 100 ];then
> >  	tc_loss=1%
> > @@ -320,8 +320,6 @@ do_transfer()
> >  	local local_addr="$6"
> >  	local extra_args="$7"
> >  
> > -	port=$((port + 1))
> > -
> >  	if [ "$rcvbuf" -gt 0 ]; then
> >  		extra_args+=" -R $rcvbuf"
> >  	fi
> > @@ -446,6 +444,8 @@ do_transfer()
> >  		return 1
> 
> ... the counter will not be incremented in case of failure.

Yes, let's drop this patch.

Thanks,
-Geliang
> 
> To avoid incrementing the counter from different places, I found it
> safer to start it one off the first one. We can still see it's 10000.
> 
> >  	fi
> >  
> > +	port=$((port+1))
> 
> (it is not really the end of the function :) )
> 
> > +
> >  	mptcp_lib_check_transfer $sin $cout "file received by client"
> >  	retc=$?
> >  	mptcp_lib_check_transfer $cin $sout "file received by server"
> > @@ -719,7 +719,7 @@ EOF
> >  
> >  	mptcp_lib_pr_info "test $msg"
> >  
> > -	port=$((20000 - 1))
> > +	port=20000
> >  	local extra_args="-o TRANSPARENT"
> >  	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
> >  		    ${connect_addr} ${local_addr} "${extra_args}"
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
