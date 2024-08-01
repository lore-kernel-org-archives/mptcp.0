Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5263136E37
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476051; cv=none; b=ovbz/qLOcBncG4xoTjFKmZ2fGUF9d6Z7m1CIQKSqYst8ja+uF873xxQMoTE4rVrUiOqifTQQpvYHNtaiJkBAcwepZQcKm05xb2raimZ8/BIcBobWwF6/CFlgRby9KF4AH6HuFUx7otlOvjOeuvSrT3wky7oFaHWmqWwgP1XciSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476051; c=relaxed/simple;
	bh=DiShS/tue8JytDDXhpozuGkvzimHyHWOHEJ/DMM+j5M=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I9u9+nAwUARveO2EFSAi0aL6ndT34nFCp16JGHkRluA0JA3sEnmpkE9mYfqbZKOLgmrstHYvlI8bXNawu3GXdWcrHLdFLcNvRDv+SOWWZkxYcwIkVpXfoLjAagqbA33gkN6TI0ykW1y8Pc+5TbIQNpjfi2oHr1tLqtdgVnZXE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euYQmEEq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euYQmEEq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A21C116B1;
	Thu,  1 Aug 2024 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722476051;
	bh=DiShS/tue8JytDDXhpozuGkvzimHyHWOHEJ/DMM+j5M=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=euYQmEEq1XtvvcbpwYJS7PyLD6ZwaIi56+2emWJaJNXDbBa3eiLJmgBS2O7ijAnXE
	 VB5YMduZQ2SZ8zwbA1JVwl0BCiVPPyB6YDUUjxrKlMVgmubi4BFZeAA4hbgLyUrvYD
	 CVl/YZ4uh6NEaQqE4A6so24pNyWPYsPwJkKeat1sPPyxuXP3Dj6ez37cMBUXCo0GgQ
	 AxPkGjlomYbw0fgZ8RhgAqdRuYkcp+wkisNZpXhpX6ee8LPg1koBMWx5JJh0qURGPI
	 5/7yh9U5zmlJ0t0o3IQ/CakijGdJtxLMXdz8GvEDO/72eGOl6vGFJ/Mwapu8WSaGcj
	 nz39bnijUTuFw==
Message-ID: <71b96aa39bb4830c01f6292c99d5c42ea4d86005.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: validate MPJ
 SYN TX MIB counters
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Thu, 01 Aug 2024 09:34:06 +0800
In-Reply-To: <9a05b63f-5f09-4a46-9c41-5d9c0a0d5318@kernel.org>
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
	 <20240729-mptcp-join-tx-mib-v2-2-8ace70fd407a@kernel.org>
	 <54fe0a426f00ad7c6d4b2c639da7bb5925b408f7.camel@kernel.org>
	 <9a05b63f-5f09-4a46-9c41-5d9c0a0d5318@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Wed, 2024-07-31 at 17:02 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review!
> 
> On 31/07/2024 04:59, Geliang Tang wrote:
> > Hi Matt,
> > 
> > Thanks for these patches.
> > 
> > On Mon, 2024-07-29 at 12:18 +0200, Matthieu Baerts (NGI0) wrote:
> > > A few new MIB counters have been added. They are being validated
> > > here.
> > > 
> > > Most of the time, there are no errors, but sometimes, more MPJ
> > > SYN
> > > are
> > > queued compared to the numbers that are received.
> > > 
> > > Only one test has an error, the one to connect to a broadcast IP
> > > address.
> > > 
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 63
> > > +++++++++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index fbb0174145ad..c1f1ebd2340c 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -1372,6 +1372,66 @@ chk_join_nr()
> > >  	fi
> > >  }
> > >  
> > > +chk_join_tx_nr()
> > > +{
> > > +	local syn_nr=$1
> > > +	local festab=$2
> > > +	local create=$3
> > > +	local bind=$4
> > > +	local connect=$5
> > > +	local count
> > > +
> > > +	print_check "syn TX"
> > > +	count=$(mptcp_lib_get_counter ${ns2}
> > > "MPTcpExtMPJoinSynTx")
> > > +	if [ -z "$count" ]; then
> > > +		print_skip
> > > +	elif [ "$count" != "$syn_nr" ]; then
> > > +		fail_test "got $count JOIN[s] syn TX expected
> > > $syn_nr"
> > > +	else
> > > +		print_ok
> > > +	fi
> > 
> > Do you think it is necessary to check MPTcpExtMPJoinSynTx in
> > chk_join_nr()?
> 
> I thought about that, then I realised some tests were sending more
> MP_JOIN than the received ones (e.g. when using "invalid addresses").
> We
> would then need to change the default counters, but chk_join_nr() can
> already optionally check the checksum, making it difficult to read
> when
> we have to pass 14 parameters:
> 
>   chk_join_nr 1 1 1 0 0 0 0 0 0 2 0 0 0 1
> 
> It looks simpler with a dedicated helper, and checking this only in
> some
> places. WDYT?

We can handle this like "addr_nr_ns1". In chk_join_nr(), the default
value of this "syn_tx_nr" is the same as "syn_nr". If we need a
specific value, we can pass it to run_tests() through a "syn_tx_nr"
variable:

	syn_tx_nr=1 \
		run_tests $ns1 $ns2 10.0.1.1

> 
> > > +
> > > +	print_check "syn TX Fully Estab Error"
> > > +	count=$(mptcp_lib_get_counter ${ns2}
> > > "MPTcpExtMPJoinSynTxFEstabErr")
> > > +	if [ -z "$count" ]; then
> > > +		print_skip
> > > +	elif [ "$count" != "$festab" ]; then
> > > +		fail_test "got $count JOIN[s] syn TX Fully Estab
> > > Error expected $festab"
> > > +	else
> > > +		print_ok
> > > +	fi
> > > +
> > > +	print_check "syn TX Create Socket Error"
> > > +	count=$(mptcp_lib_get_counter ${ns2}
> > > "MPTcpExtMPJoinSynTxCreatSkErr")
> > > +	if [ -z "$count" ]; then
> > > +		print_skip
> > > +	elif [ "$count" != "$create" ]; then
> > > +		fail_test "got $count JOIN[s] syn TX Create
> > > Socket
> > > Error expected $create"
> > > +	else
> > > +		print_ok
> > > +	fi
> > 
> > There is no test that can trigger MPTcpExtMPJoinSynTxFEstabErr and
> > MPTcpExtMPJoinSynTxCreatSkErr. Does this mean that there is no need
> > to
> > add these two MIBs? Maybe adding pr_debug logs is enough? WDYT?
> 
> MPTcpExtMPJoinSynTxFEstabErr can be easily triggered by the userspace
> PM. Maybe we don't need the counter for this case then? We could also
> do
> the check in the userspace PM side, and return a netlink message
> instead, but I don't think it is needed. Not sure what's best here. I
> can remove it or leave it.

If so I think it's better to remove it, since too many MIBs are added
in this function.

> 
> For MPTcpExtMPJoinSynTxCreatSkErr, it can be triggered if it cannot
> allocate memory, if the socket limit has been reached out, if a
> security
> module blocked it, etc. I think we should keep it, and we don't need
> to
> validate it in the tests.

These errors are not related to MPTCP protocol. I think we can remove
this MIB but keep its pr_debug log. WDYT?

Regards,
-Geliang

> 
> > > +
> > > +	print_check "syn TX Bind Error"
> > > +	count=$(mptcp_lib_get_counter ${ns2}
> > > "MPTcpExtMPJoinSynTxBindErr")
> > > +	if [ -z "$count" ]; then
> > > +		print_skip
> > > +	elif [ "$count" != "$bind" ]; then
> > > +		fail_test "got $count JOIN[s] syn TX Bind Error
> > > expected $bind"
> > > +	else
> > > +		print_ok
> > > +	fi
> > > +
> > > +	print_check "syn TX Connect Error"
> > > +	count=$(mptcp_lib_get_counter ${ns2}
> > > "MPTcpExtMPJoinSynTxConnectErr")
> > > +	if [ -z "$count" ]; then
> > > +		print_skip
> > > +	elif [ "$count" != "$connect" ]; then
> > > +		fail_test "got $count JOIN[s] syn TX Connect
> > > Error
> > > expected $connect"
> > > +	else
> > > +		print_ok
> > > +	fi
> > > +}
> > > +
> > >  # a negative value for 'stale_max' means no upper bound:
> > >  # for bidirectional transfer, if one peer sleep for a while
> > >  # - as these tests do - we can have a quite high number of
> > > @@ -1907,6 +1967,7 @@ subflows_error_tests()
> > 
> > Add an invalid address here in this test:
> > 
> > 	pm_nl_add_endpoint $ns2 10.0.5.2 flags subflow
> > 
> > >  		speed=slow \
> > >  			run_tests $ns1 $ns2 10.0.1.1
> > >  		chk_join_nr 0 0 0
> > > +		chk_join_tx_nr 0 0 0 0 0
> > 
> > It will trigger a "syn TX Bind Error":
> > 
> > 		chk_join_tx_nr 0 0 0 1 0
> 
> Good idea! I will do that in the v3.
> 
> Cheers,
> Matt

