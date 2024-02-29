Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484D7CF05
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209132; cv=none; b=tlyUjvZf5dBfTYkA8uoyAyS4Cr9JNHiSBQS/1WuLiVbKQ0dZZPEqeQDpQkQcgHLrTDWQHq3rs52heRdfe1IWAF/4e82I06Xy6OZsPbYXmuqEBKQteKBxxcdLG8YqXe1HKjxDBYD0GNSthDXl0Tyr8B6Cbqc3ddZLuJkg7e3gD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209132; c=relaxed/simple;
	bh=aZzsuhGBQXkGNpG5ETxMMW0sjDgecjgs6nXFsyO9aKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUT3xdz9jb+G0L71V15SJUEjW313hnFpJ+Hcy05WDcNAY6ICJeTDvFqP7/rzRcfXbtsuNgXofGMEWWSnwcBDFKSZhkbimMZh31bcQcQgPDFotWVqC8b8/fC1p/U5D0P55pcdWeJdCM/ycuvEpmQL15qv/0Rf+2d2xosBhDTihj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VumxPQWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VumxPQWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD47C433C7;
	Thu, 29 Feb 2024 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709209132;
	bh=aZzsuhGBQXkGNpG5ETxMMW0sjDgecjgs6nXFsyO9aKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VumxPQWYte4pMrZGsB0D2/uvxFguGZD4h0OprFRSoAhTK8PS0/9AsNlOaDZtoLeyT
	 Zj36Hj9/2/74yZDwmFsWeY/0K59fugZILXHn+7HDcVQwYL0OhkwJJlaaUtWvUzCkci
	 RPHGVylp4loE6k+6R9ZmxXm+xxIXf7IdsVyM4480DSZXMUQQZegC0c8Cq+5pAYClwn
	 f/70WXbqoDK3n42pl9DJDOh/GUBPt+KRoIUzgmjyBhCvHqnB1b006Y7/hurPeCbU2/
	 pU2loa3eJ0wyY+IY1nCOHkqgwsyO25QYb9km1X1pYMHFvQq7itjva/CPK3kHGKwe5r
	 2lSa5ZoLBmx2g==
Date: Thu, 29 Feb 2024 20:18:48 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 2/8] selftests: mptcp: connect: add
 dedicated port counter
Message-ID: <ZeB2KFQQjouqrOu9@t480>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <dea8ab3b33e331083ef740bb385bad314dc321db.1709200070.git.tanggeliang@kylinos.cn>
 <fff83de1-97fc-4cd9-ad4c-7c785256bc2b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff83de1-97fc-4cd9-ad4c-7c785256bc2b@kernel.org>

Hi Matt,

On Thu, Feb 29, 2024 at 12:23:54PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/02/2024 10:51, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
> > increase port numbers in mptcp_connect.sh.
> > 
> > This can avoid outputting discontinuous test counters.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index 0ca2960c9099..4f40221a86cb 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -33,6 +33,7 @@ do_tcp=0
> >  checksum=false
> >  filesize=0
> >  connect_per_transfer=1
> > +PORT=0
> 
> Sorry, I forgot to comment on the previous patch: I didn't get why you
> cannot use TEST_COUNT for the increment?
> 
> So have here:
> 
>   PORT=10000
> 
> (Or 'PORT_BASE', or even 'port_base' like most "global" variables used
> in this file)
> 
> >  if [ $tc_loss -eq 100 ];then
> >  	tc_loss=1%
> > @@ -314,7 +315,7 @@ do_transfer()
> >  	local extra_args="$7"
> >  
> >  	local port
> > -	port=$((10000+TEST_COUNT))
> > +	port=$((10000+PORT++))
> 
> Here:
> 
>   port=$((PORT + TEST_COUNT))

The first time here TEST_COUNT is 2, so all ports begin with 10002, not
10000. The values of port are changed.

Thanks,
-Geliang

> 
> >  	TEST_COUNT=$((TEST_COUNT+1))
> >  
> >  	if [ "$rcvbuf" -gt 0 ]; then
> > @@ -710,7 +711,7 @@ EOF
> >  
> >  	echo "INFO: test $msg"
> >  
> > -	TEST_COUNT=10000
> > +	PORT=10000
> 
> And here:
> 
>   PORT=20000
> 
> So there is only one counter, not 2. Would that not work?
> 
> >  	local extra_args="-o TRANSPARENT"
> >  	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
> >  		    ${connect_addr} ${local_addr} "${extra_args}"
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
