Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF57E1
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662710969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F74k80kmKQcNpnk8rHeXwpB1+UR8uKnOOR3kIEI9RmY=;
	b=OMIgG4dKtTYwXPzfZ/mEGhSe15+uSJouWgQ+gssZoyUmVAKDb6qf2F/LevJCbOS0T63D1J
	Yhw4oL8s0XD/4Wv+LOCBuv2lUQGo6yXP6+PVPBQmtjAMjBbRfeYrCIbIjfFhaw2QdZjOnf
	GBBO7+e9MtgBIdFvUav68C9j4fjeTQg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-Yc1p3JV8Oium1yGLKIMtag-1; Fri, 09 Sep 2022 04:09:28 -0400
X-MC-Unique: Yc1p3JV8Oium1yGLKIMtag-1
Received: by mail-qk1-f197.google.com with SMTP id bq19-20020a05620a469300b006c097741d3dso858064qkb.2
        for <mptcp@lists.linux.dev>; Fri, 09 Sep 2022 01:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=F74k80kmKQcNpnk8rHeXwpB1+UR8uKnOOR3kIEI9RmY=;
        b=qsOg63Lrvjqv61oIlKkPkixpJ8wuRNcHejxku3YPy7eCQVd6a1eEjq0peqdy5MVfqs
         /gLpVf+6QA1tb7JTYgCfhcByKcSG/sa0HA5gI8YVUjJlS+bDHUiDWHiEjWH3yZOiz7bf
         tUVvEG/nfb6nWS4A0SB9ZhRotLjYBVZMCH4UicFAKhD+ldez27IT0HfZ3PbePzUF6APV
         Lp/t9rOMBVCLUuzZSZZx5PqteOT+t7RTdaXjNwN3K9EASnM5sRmxgfsTBmm9yFWpYfkR
         J/D+mDqu0AsCs2x2vyDgowg+InrS0zvJAl0tYjKjH5YnbBgfILVrR0tEgTIsFbSHg8f9
         yFkQ==
X-Gm-Message-State: ACgBeo2Po7/GbGS4Ci7PusZB2XoDd0psj1e7buqs5etN8zQMVpVO3irt
	upXOVCHt2I6VcZPnfC2TMjuP4qCZdTqI3NsSiHGuke3Oqo061FfpEReEPg0nC8zLKvN7X/lRs1L
	RDW/Q15ka/+GGasE=
X-Received: by 2002:a05:622a:138e:b0:343:7e0f:f9cf with SMTP id o14-20020a05622a138e00b003437e0ff9cfmr11542603qtk.314.1662710967866;
        Fri, 09 Sep 2022 01:09:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4jK9vpD3BtfOgQIHe5TBScuhq18p57OC7M1eaM0pacinLnH61T4Gabbi+nKVPLAm9YNPR9lw==
X-Received: by 2002:a05:622a:138e:b0:343:7e0f:f9cf with SMTP id o14-20020a05622a138e00b003437e0ff9cfmr11542585qtk.314.1662710967578;
        Fri, 09 Sep 2022 01:09:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a0c4500b006b640efe6dasm809409qki.132.2022.09.09.01.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 01:09:27 -0700 (PDT)
Message-ID: <8f1825a347340edfc1af0ebba57b8088f4f49cb6.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 3/3] selftests: mptcp: update and extend
 fastclose test-cases
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 09 Sep 2022 10:09:24 +0200
In-Reply-To: <d7a536f8-ac96-0b8b-7460-2a240aeb2d32@tessares.net>
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
	 <27d535b3cc0cd665ba6404056aa51fb4a1628f44.1662051551.git.pabeni@redhat.com>
	 <d7a536f8-ac96-0b8b-7460-2a240aeb2d32@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-09-07 at 19:22 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 01/09/2022 19:31, Paolo Abeni wrote:
> > After the previous patches, the MPTCP protocol can generate
> > fast-closes on both ends of the connection. Rework the relevant
> > test-case to carefully trigger the fast-close code-path on a
> > single end at the time, while ensuring than a predictable amount
> > of data is spooled on both ends.
> > 
> > Additionally add another test-cases for the passive socket
> > fast-close.
> 
> Thank you for the v3!
> 
> (...)
> 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > index 24d4e9cb617e..ee6df83c55f3 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> 
> (...)
> 
> > @@ -381,8 +382,6 @@ static size_t do_rnd_write(const int fd, char *buf, const size_t len)
> >  		do_w = cfg_do_w;
> >  
> >  	bw = write(fd, buf, do_w);
> > -	if (bw < 0)
> > -		perror("write");
> 
> Should we skip the sleep done here just below and return bw directly in
> case of error?
> Or is it more like an small opti not really needed?
> 
> >  
> >  	/* let the join handshake complete, before going on */
> >  	if (cfg_join && first) {
> > @@ -571,7 +570,7 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
> >  		.fd = peerfd,
> >  		.events = POLLIN | POLLOUT,
> >  	};
> > -	unsigned int woff = 0, wlen = 0;
> > +	unsigned int woff = 0, wlen = 0, total_wlen = 0, total_rlen = 0;
> >  	char wbuf[8192];
> >  
> >  	set_nonblock(peerfd, true);
> > @@ -597,7 +596,16 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
> >  		}
> >  
> >  		if (fds.revents & POLLIN) {
> > -			len = do_rnd_read(peerfd, rbuf, sizeof(rbuf));
> > +			ssize_t rb = sizeof(rbuf);
> > +
> > +			/* limit the total amount of read data to the trunc value*/
> > +			if (cfg_truncate > 0) {
> > +				if (rb + total_rlen > cfg_truncate)
> > +					rb = cfg_truncate - total_rlen;
> > +				len = read(peerfd, rbuf, rb);
> > +			} else {
> > +				len = do_rnd_read(peerfd, rbuf, sizeof(rbuf));
> > +			}
> >  			if (len == 0) {
> >  				/* no more data to receive:
> >  				 * peer has closed its write side
> > @@ -612,10 +620,14 @@ static int copyfd_io_poll(int infd, int peerfd, int outfd, bool *in_closed_after
> >  
> >  			/* Else, still have data to transmit */
> >  			} else if (len < 0) {
> > +				/* ignore errors on I/O operation when the peer is fastclosing */
> > +				if (cfg_truncate < 0)
> 
> (it is confusing to me to use negative values for a special case
> (requiring an addional comment each time) instead of using a new
> dedicated option with a clear name but probably just me :) )
> 
> > +					return 0;
> >  				perror("read");
> >  				return 3;
> >  			}
> >  
> > +			total_rlen += len;
> >  			do_write(outfd, rbuf, len);
> >  		}
> >  
> 
> (...)
> 
> > @@ -1262,8 +1295,15 @@ static void parse_opts(int argc, char **argv)
> >  {
> >  	int c;
> >  
> > -	while ((c = getopt(argc, argv, "6c:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
> > +	while ((c = getopt(argc, argv, "6c:f:hi:I:jlm:M:o:p:P:r:R:s:S:t:T:w:")) != -1) {
> >  		switch (c) {
> > +		case 'f':
> 
> Maybe better to update the die_usage() function if you don't mind.
> 
> > +			cfg_truncate = atoi(optarg);
> > +
> > +			/* when receiving a fastclose, ignore PIPE signals */
> > +			if (cfg_truncate < 0)
> > +				signal(SIGPIPE, handle_signal);
> > +			break;
> >  		case 'j':
> >  			cfg_join = true;
> >  			cfg_mode = CFG_MODE_POLL;
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 2957fe414639..0f4c9c4bcb5b 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> 
> (...)
> 
> > @@ -707,9 +718,29 @@ do_transfer()
> >  	fi
> >  
> >  	local flags="subflow"
> > +	local extra_cl_args=""
> > +	local extra_srv_args=""
> > +	local trunc_size=""
> >  	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> > +		if [ ${test_link_fail} -le 1 ]; then
> > +			echo "fastclose tests need test_link_fail argument"
> > +			return 0
> 
> Probably clearer to exit directly with an error, to be sure the CI
> catches this, no?
> Or do you think it is not needed?
> 
> > +		fi
> > +
> >  		# disconnect
> > -		extra_args="$extra_args -I ${addr_nr_ns2:10}"
> > +		trunc_size=${test_link_fail}
> > +		local side=${addr_nr_ns2:10}
> > +
> > +		if [ ${side} = "client" ]; then
> > +			extra_cl_args="-f ${test_link_fail}"
> > +			extra_srv_args="-f -1"
> > +		elif [ ${side} = "server" ]; then
> > +			extra_srv_args="-f ${test_link_fail}"
> > +			extra_cl_args="-f -1"
> > +		else
> > +			echo "wrong/unknown fastclose spec ${side}"
> > +			return 0
> 
> Same here.
> 
> > +		fi
> >  		addr_nr_ns2=0
> >  	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
> >  		userspace_pm=1
> 
> (...)
> 
> > @@ -1188,12 +1221,23 @@ chk_fclose_nr()
> >  {
> >  	local fclose_tx=$1
> >  	local fclose_rx=$2
> > +	local ns_invert=${3:-""}
> 
> (I'm not sure why you need to default to an empty string but that's a
> detail :) )
> 
> >  	local count
> >  	local dump_stats
> > +	local ns_tx=$ns2
> > +	local ns_rx=$ns1
> > +	local extra_msg=""
> > +
> > +	if [[ $ns_invert = "invert" ]]; then
> > +		ns_tx=$ns1
> > +		ns_rx=$ns2
> > +		extra_msg="   invert"
> > +	fi
> >  
> >  	printf "%-${nr_blank}s %s" " " "ctx"
> > -	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
> > +	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
> >  	[ -z "$count" ] && count=0
> > +	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"
> 
> detail: if we are not in the "invert" mode, extra_msg will be empty: no
> need to add the 3 spaces? or init extra_msg with these 3 spaces?
> 
> >  	if [ "$count" != "$fclose_tx" ]; then
> >  		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
> >  		fail_test
> 
> (...)
> 
> > @@ -1236,7 +1283,7 @@ chk_rst_nr()
> >  	printf "%-${nr_blank}s %s" " " "rtx"
> >  	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
> >  	[ -z "$count" ] && count=0
> > -	if [ "$count" != "$rst_tx" ]; then
> > +	if [ $count -lt $rst_tx ]; then
> 
> Why is it fine if we send (and below receive) more than expected?

[answering only here because this will be the only suggestion leading
to no changes in the next revision]

Because the rst can be retransmitted. I'm not sure/can't recall how the
self-test previously was able to enforce a single reset, but that does
not look possible now.

Thanks,

Paolo

