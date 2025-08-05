Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9E78F2F
	for <mptcp@lists.linux.dev>; Tue,  5 Aug 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754381874; cv=none; b=ZNsgsco+4AZlu46o6hb+Sx3MUNWvHlP4mkJv/xaZC1DcO/rAyfpulVe9iYw7etxe55Xu7lXqtgk6aTXidAibewPRJKpMrjHhtNc71GlU1ucfcYOpv/zvcy53Y0iIhSvaM6L4IMTLqrPKewJ8RkId2hewzKo7f64hnaRvJwzj6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754381874; c=relaxed/simple;
	bh=WkIhudi3YP+n2C8f1xTv4aRsY1D8885LyI4jb93V2To=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XyFo1o20GXXy4zZOmsFLQCd+DKIe1rxZiLqBOzFjag1iSqKJjhzqt5SNwWMFH59AGHFOiq40tHxkgGi0erpPnIRr/fdx0/BMZz4KyKwMSMg3KGMPFYatBkr5gOTVocknxDUCROv8leGc57IYlTGJHFdJeYPFBJHOTEnK7fphSbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpSPFss4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpSPFss4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1EEC4CEF4;
	Tue,  5 Aug 2025 08:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754381874;
	bh=WkIhudi3YP+n2C8f1xTv4aRsY1D8885LyI4jb93V2To=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=rpSPFss4Ki9peKC+Y8YHA0c913mxYkG0Fj6mnGs7qz42kF0hbw4D3as9R0hv+1+EB
	 U9ZpX5MqGf1C/Yuk7OzMoGJPio9jUtZBofYYdlGCeGFtU+GPH8W9eat9rLRdlCtreF
	 A79o/Ev1ri/QhoflN+cEPeHCXUwTnoWrqR/hYNiO5IsUqp29felE5/BGt4uXnwM0Nh
	 7GIqFN0c++HWzC6SP/De3TWs7K80DEHSnrNrSPTe5hfjHnmt9bkaDCU5T5mVGm3RpX
	 Pu71Ckiw2mrIwpnGK3QX8Ej+l63z8bVFNAmGH1N/XsgaTgF6akghHkJ/vFLKVufnPf
	 aSSMZtpqFZmqQ==
Message-ID: <84a8cc576ad125c12daea8d409121e3165f30c83.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2] mptcp: adapt ADD_ADDR timeout to maximum
 subflow RTO
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 05 Aug 2025 16:17:43 +0800
In-Reply-To: <79652ff2-96ce-4c11-a955-59ef59300abc@kernel.org>
References:
	 	<40706ad511220729207ccd7cf48e320e4d0d7dea.1754028199.git.tanggeliang@kylinos.cn>
		 <79652ff2-96ce-4c11-a955-59ef59300abc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2025-08-03 at 14:10 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 01/08/2025 08:07, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Currently the ADD_ADDR option is retransmitted with a fixed
> > timeout. This
> > patch makes the retransmission timeout adaptive by using the
> > maximum RTO
> > among all the subflows, while still capping it at the configured
> > maximum
> > value (add_addr_timeout_max). This improves responsiveness when
> > establishing new subflows.
> > 
> > Specifically:
> > 1. Adds mptcp_adjust_add_addr_timeout() helper to compute the
> > adaptive
> > timeout.
> > 2. Uses maximum subflow RTO (icsk_rto) when available.
> 
> "when available": this worries me and is linked to my question from
> v1:
> I don't know if ["icsk->icsk_rto"] will be set to a correct value
> when
> we will look, no?

Can we ensure this by adding a check whether icsk->icsk_rto is between
icsk->icsk_rto_min and icsk->icsk_rto_max?

I have also used srtt_us and rttvar_us to calculate rto, and the value
obtained is similar to icsk->icsk_rto:

    rto = usecs_to_jiffies((tp->srtt_us >> 3) + (tp->rttvar_us >> 2))

> 
> I guess it will be set by TCP only when retransmissions will be
> needed,
> no? So maybe not set when sending an ADD_ADDR? Or set at the wrong
> value, no?
> 
> some mptcp_join.sh subtests are failing, maybe because the
> retransmissions are done too frequently, no? Also, it is suspicious
> that

Yes, "delete re-add signal" test failed. It needs to be updated:

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3938,14 +3938,14 @@ endpoint_tests()
 
                chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
                chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
-               chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+               chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 8
                chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
                chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
                chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
 
                join_connect_err=1 \
                        chk_join_nr 5 5 5 
-               chk_add_nr 6 6
+               chk_add_nr 8 8
                chk_rm_nr 4 3 invert
        fi

This test does indeed cause add_addr retransmissions, but the original
retransmission timeout is too long (120s), so the test does not detect
the retransmissions.

> the ADD_ADDR packetdrill tests are still passing: are they not
> checking
> for retransmissions done once every second? (or maybe the tolerance
> is
> too high → best to check with a packet trace)

In both add_addr_retry_errors.pkt and add_addr_retry_plain.pkt, we set
net.mptcp.add_addr_timeout to 1 second. With this new timeout
adjustment, the timeout value is adjusted to several hundred
microseconds, which is similar to the original value, so the tests all
passed.

> 
> > 3. Applies exponential backoff based on retransmission count.
> > 4. Maintains fallback to configured max timeout when no RTO data
> > exists.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > v2:
> >  - do not rename add_addr_timeout
> >  - use icsk->icsk_rto instead of tp->srtt_us
> >  - increase the time after each retransmission
> > v1:
> >  -
> > https://patchwork.kernel.org/project/mptcp/cover/cover.1753777199.git.tanggeliang@kylinos.cn/
> > ---
> >  net/mptcp/pm.c | 34 +++++++++++++++++++++++++++++++---
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 687dbb59d084..22198609be2f 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -268,6 +268,28 @@ int mptcp_pm_mp_prio_send_ack(struct
> > mptcp_sock *msk,
> >   return -EINVAL;
> >  }
> >  
> > +static unsigned int mptcp_adjust_add_addr_timeout(struct
> > mptcp_sock *msk,
> > +   const struct net *net,
> > +   u8 retrans_times)
> > +{
> > + unsigned int timeout = mptcp_get_add_addr_timeout(net);
> > + struct mptcp_subflow_context *subflow;
> > + unsigned int icsk_rto = 0;
> > +
> > + mptcp_for_each_subflow(msk, subflow) {
> > + struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > + struct inet_connection_sock *icsk = inet_csk(ssk);
> > +
> > + if (icsk->icsk_rto > icsk_rto)
> > + icsk_rto = icsk->icsk_rto;
> > + }
> > +
> > + if (icsk_rto && icsk_rto < timeout)
> > + timeout = icsk_rto;
> > +
> > + return timeout << retrans_times;
> > +}
> > +
> >  static void mptcp_pm_add_timer(struct timer_list *timer)
> >  {
> >   struct mptcp_pm_add_entry *entry = timer_container_of(entry,
> > timer,
> > @@ -302,7 +324,9 @@ static void mptcp_pm_add_timer(struct
> > timer_list *timer)
> >  
> >   if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
> >   sk_reset_timer(sk, timer,
> > -        jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
> > +        jiffies + mptcp_adjust_add_addr_timeout(msk,
> > +        sock_net(sk),
> > +        entry->retrans_times));
> >  
> >   spin_unlock_bh(&msk->pm.lock);
> >  
> > @@ -354,7 +378,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock
> > *msk,
> >   return false;
> >  
> >   sk_reset_timer(sk, &add_entry->add_timer,
> > -        jiffies + mptcp_get_add_addr_timeout(net));
> > +        jiffies + mptcp_adjust_add_addr_timeout(msk,
> > +        net,
> > +        add_entry->retrans_times));
> 
> (I guess you can also set it to 0 here, no? If yes, all in one line?)

Yes, this is much better.

> 
> >   return true;
> >   }
> >  
> > @@ -370,7 +396,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock
> > *msk,
> >  
> >   timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
> >   sk_reset_timer(sk, &add_entry->add_timer,
> > -        jiffies + mptcp_get_add_addr_timeout(net));
> > +        jiffies + mptcp_adjust_add_addr_timeout(msk,
> > +        net,
> > +        add_entry->retrans_times));
> 
> (I guess you can also set it to 0 here, no? If yes, all in one line?)

Yes. Will update this in v3.

Thanks,
-Geliang

> 
> >  
> >   return true;
> >  }
> 
> Cheers,
> Matt
