Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62583C13E2
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786087435; cv=pass; b=jEKUauvq6/M3M5xl4t7srgaWpR/M9inx9j5DFCV19ThrVoQTgS1GCQvJscFClLUpCF0iEDf9LBgMXjf/JnRo4AjQR0KlAn4x2EE0495gd4/HdyMEf0vtHHgS4wMvanC7jjzLy8xQu4RLCq6A8AqLEheuMFLiWX/KVLzAYpXOu3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786087435; c=relaxed/simple;
	bh=YZHyxQ0mh46z94Q1RkrZZBHS2BUn8PSvOYqpUhErHN4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Hjs/L/PTwHP21BMsqQA/JIWvZzEwFpxpOql+9uptUonY9J8XV4Yvm/y4NnlmdE4F0Q5iqAWOYryWscAxVwiEJA6NtruO/weGUcr6UtOGzoDoGbqoAhl0Utmx9RxCNEEq2t4Rcm8WSxCCWRagTsfV4QE/bPzQFlxpF9pxdojGxeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=tIOeVz31 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="tIOeVz31"
ARC-Seal: i=1; a=rsa-sha256; t=1786087424; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ihhcxB5PQOO4Y+Pr9dBuefijo5O9arp0CfHN4mhpqM4Vfj+uMjT2xChySRGYz36a898LebM60HoZsqTyITNyR+jHSNWnHJ5zPAQrXNEblxwSvSRbRrm2RQPRb6jVawAH+VsFKHzM7cGmtGB3uQQtrQJbZcv5osoewFYZ91zkQF4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786087424; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dBiKF8eiaeB3+5PT9B9q5hItzl1bhhcCZd9i4daHCHg=; 
	b=YqqFY14fm3p2XwoP2xcTdnDYLyCVn8VfiQ2ldFcsuySbPIZMP9Bpt8GqLDPKRaqhoPwzOLfqjRunNqKItTq8tdPaikcr68f8PoDww585wdehsf6dowwxjbTcjlWYdPbigwT6qY/VrxyRNTl1HPykTq8grgt3ucgC0Ib8yJjUU3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786087424;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dBiKF8eiaeB3+5PT9B9q5hItzl1bhhcCZd9i4daHCHg=;
	b=tIOeVz31UNHJs9CyuyTuRLHbepOy34QX5ovBMBwAb+DwQfPvvqihLL/EOpNapHRH
	cU2YTjGkKZJbYI+cZ02IRsSRgPCi8xhSzyj1W5wLWZM2oAQuB2Y0+ax+wFbdot8+b8t
	mxTH3DZ7lsAW0jJ0OA+XuZdgnOzg5XNhZZ3XQWKw=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1786087416950467.95873856524895; Fri, 7 Aug 2026 00:23:36 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1786087415104700.5200890803163; Fri, 7 Aug 2026 00:23:35 -0700 (PDT)
Date: Fri, 07 Aug 2026 12:53:35 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>
Cc: "matttbe" <matttbe@kernel.org>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"akshit" <akshit@mpiricsoftware.com>,
	"Kalpan Jani" <kalpan.jani@mpiricsoftware.com>,
	"syzbot+55c2a5c871441261ed14"
 <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>,
	"Tao Cui" <cuitao@kylinos.cn>
Message-ID: <19fdb1b1cdd.122b1f65587045.5393804019530024742@mpiricsoftware.com>
In-Reply-To: <20260630150632.899750-2-kalpan.jani@mpiricsoftware.com>
References: <20260630150632.899750-1-kalpan.jani@mpiricsoftware.com> <20260630150632.899750-2-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v5 1/2] mptcp: pm: drop pending ADD_ADDR when
 removing id 0 endpoint
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Sorry for the long silence on this.

The packetdrill test is now up at
https://github.com/multipath-tcp/packetdrill/pull/201 - I rewrote it and this
time validated it in the virtme-docker environment: 3 failing without the
kernel fix, 3 passing with it, on export/20260622T173908. Your suggestion about
the endpoint linked to the initial subflow is what unblocked it. Details and
the limitations I hit are in the PR.

Two things about v5 itself.

First, patch 1/2 is unchanged from what you have. I said I would rework the
addr argument because the anno_addr copy looked fragile for endpoints with a
port, but after re-checking I no longer think that case is reachable: the MPC
endpoint cannot be a ported endpoint, since both __lookup_addr() and
mptcp_nl_add_subflow_or_signal_addr() compare the port when the endpoint has
one, and that would require it to match the initial subflow's local port -
which mptcp_pm_nl_create_listen_socket() binding the same address:port makes
unreachable in practice. So the entry reachable from
mptcp_nl_remove_id_zero_address() always has port 0 and clearing it is correct.
Tell me if you see a case I have missed.

Second, and I should have raised this earlier: please drop patch 2/2. The
selftest does not exercise the fixed path. I used addr_nr_ns1=-1, which deletes
the endpoint by its real ID via pm_nl_del_endpoint ${listener_ns} $id and
therefore goes through mptcp_nl_remove_subflow_and_signal_addr() - the path
that was already correct. Only -9 reaches mptcp_nl_remove_id_zero_address(),
and the endpoint is 10.0.2.1, so the address check there would not have matched
even with -9. The subtest passes identically with and without patch 1/2, which
is why CI was green everywhere, and it largely duplicates the existing "remove
single address" subtest. Sorry for not catching that before sending v5.

With the packetdrill test covering the same ground, I think patch 1/2 alone is
the right thing to apply. Happy to send a corrected mptcp_join.sh subtest as
well if you would rather have both.

Cheers,
Kalpan Jani


From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <akshit@mpiricsoftware.com>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>, "Tao Cui"<cuitao@kylinos.cn>
Date: Tue, 30 Jun 2026 20:36:31 +0530
Subject: [PATCH net v5 1/2] mptcp: pm: drop pending ADD_ADDR when removing id 0 endpoint

 > The in-kernel MPTCP path manager can leave a stale ADD_ADDR announcement
 > entry alive when removing the id 0 endpoint. This happens because the id 0
 > removal path does not tear down pending announcements, unlike the non-zero
 > id path.
 > 
 > When the PM later reselects id 0 after adding another signal endpoint, it
 > finds the stale anno_list entry and hits WARN_ON_ONCE(mptcp_pm_is_kernel())
 > in mptcp_pm_alloc_anno_list().
 > 
 > Root cause: asymmetry between removal paths.
 > - Non-zero id path: mptcp_nl_remove_subflow_and_signal_addr() calls
 >   mptcp_pm_remove_anno_addr() to clean up.
 > - Id 0 path: mptcp_nl_remove_id_zero_address() skips cleanup entirely.
 > 
 > Fix by making the id 0 path symmetric: call mptcp_pm_announced_remove()
 > and decrement add_addr_signaled before queuing the RM_ADDR.
 > 
 > Subtle detail: signal endpoints are stored in anno_list with port 0, but
 > msk_local carries the connection's local port. mptcp_pm_announced_remove()
 > uses use_port=true for comparison, so clear the port before the lookup.
 > 
 > Fixes: 740d798e8767 ("mptcp: remove id 0 address")
 > Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com
 > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620
 > Suggested-by: Tao Cui <cuitao@kylinos.cn>
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > ---
 >  net/mptcp/pm_kernel.c | 8 ++++++++
 >  1 file changed, 8 insertions(+)
 > 
 > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
 > index 331f6fa99014..d3014bf57bf3 100644
 > --- a/net/mptcp/pm_kernel.c
 > +++ b/net/mptcp/pm_kernel.c
 > @@ -1138,6 +1138,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 >      while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
 >          struct sock *sk = (struct sock *)msk;
 >          struct mptcp_addr_info msk_local;
 > +        struct mptcp_addr_info anno_addr;
 > +        bool announced;
 >  
 >          if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 >              goto next;
 > @@ -1147,7 +1149,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 >              goto next;
 >  
 >          lock_sock(sk);
 > +        /* Drop a possibly pending ADD_ADDR for this address. */
 > +        anno_addr = msk_local;
 > +        anno_addr.port = 0;
 > +        announced = mptcp_pm_announced_remove(msk, &anno_addr);
 >          spin_lock_bh(&msk->pm.lock);
 > +        if (announced)
 > +            msk->pm.add_addr_signaled--;
 >          mptcp_pm_remove_addr(msk, &list);
 >          mptcp_pm_rm_subflow(msk, &list);
 >          __mark_subflow_endp_available(msk, 0);
 > -- 
 > 2.43.0
 > 
 > 


