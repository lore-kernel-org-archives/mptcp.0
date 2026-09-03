Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BB463B89
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426384; cv=pass; b=o/dIjNXSzAiW7vuZs0ayQwCiEH7njZGUNsVRiHRpUqrG1TILdukeX7N1O5vkOUI9QJaY+A8hLFvejhLJXVT2lDrJn/KgAYWju0AU1BhebdE2Xj6+mGNzXPjYeePPmj37iMmzxxSqXv0FMvFC9PJN+AKvby+98xrE1UCJ9I/LKZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426384; c=relaxed/simple;
	bh=RerHkLmYytFoz/0Hz5mPD767fG086UZG3Gjx5b0MfRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CMUQfI1u58v6tWd5ZCxJIcqF7HoGy/gBbAMY4aeyg0XRiwcDwej5+RyYcy9bjvDHjr5ywIxP4rdiHaHYYhDNmZ62z0X3bMBROk8gX3DdcsuKH6/JbJhJ/EhLPNiBW1H12df6NIrTbxPI3/NgZMLjpZkjESRhVg6WShqyw2HnQ/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=akshit@mpiricsoftware.com header.b=ikTzBFkL reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=akshit@mpiricsoftware.com header.b="ikTzBFkL"
ARC-Seal: i=1; a=rsa-sha256; t=1788426380; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NPQkrBcJalRsLEi3DYwgjHJQTSv1lRYBvPAH67hYi+I+bS+giHGUB/+w0sb7ezJqcRtkiyZ06apNWNb+/SPs7zSGt8bE52eFBwkmsleJEGTDs9PZch7MwsPP4lTyuwGcdN6Y3c3lwyHpesWQx8VtKC8TkMKgPEJeUd/gCnhX6jE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788426380; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CvF0+blD5mzqpqmTB/+LQ1x1gnac5N8uMjOkJzKtRnA=; 
	b=MQh9bTkY285FkxYwmHVT0czvUqbNQwH/xdYaEY7yUhVMYlg+3jcZBEAJWy0WHwuOz6AdSSmBzQV+pn/39twETYLG7H4nAdRoJ9r/qpicNzJyTFXt8pVcM9Sh0krx+DV3OcaQ0BQWRqrYeQAorfceVmVHXNRVCozPY05fvNH16a4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=akshit@mpiricsoftware.com;
	dmarc=pass header.from=<akshit@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788426380;
	s=mpiric; d=mpiricsoftware.com; i=akshit@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CvF0+blD5mzqpqmTB/+LQ1x1gnac5N8uMjOkJzKtRnA=;
	b=ikTzBFkL4lnVA2AFz94KX6Xf1gzM6NuhFVqLT1zW+UyQTPl9M+oHGSY1l+oZAXop
	+M/DI5O/XKX2Nxesohx/5kKfcEhU2NgyxwTz2CWQIuW1v6FtGJP4bA9sWWo4QtsejZ6
	uhKKDTmMmNdYfDIaQnDzflzoe7ECYuFdpU27hhaU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1788426379922117.32606594796937; Thu, 3 Sep 2026 02:06:19 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1788426374602914.4254052288398; Thu, 3 Sep 2026 02:06:14 -0700 (PDT)
Date: Thu, 03 Sep 2026 14:36:14 +0530
From: Akshit Patadiya <akshit@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>
Cc: "shardul.b" <shardul.b@mpiricsoftware.com>, "janak" <janak@mpiric.us>,
	"kalpanjani009" <kalpanjani009@gmail.com>,
	"kalpan.jani" <kalpan.jani@mpiricsoftware.com>,
	"akshit" <akshit@mpiric.us>,
	"Akshit Patadiya" <akshit@mpiricsoftware.com>
Message-ID: <1a06684cdb6.76fab980244194.5937750492835496711@mpiricsoftware.com>
In-Reply-To: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
References: <20260813123754.4095492-1-akshit@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on
 subflow close
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

On Thu, Aug 13, 2026 at 05:19:09PM +0530, sashiko-bot@kernel.org wrote:
> [High] Concurrent updates to msk->pm.rm_list_rx can cause RM_ADDR IDs
> to be silently skipped, resulting in leaked subflows.
>
> If a remote peer sends multiple RM_ADDR options in rapid succession,
> softirq context can call mptcp_pm_rm_addr_received(), which
> unconditionally overwrites pm->rm_list_rx while scheduling work
 
Looked into this, it's real. Traced it down:
 
mptcp_pm_rm_addr_recv() passes &msk->pm.rm_list_rx straight into
mptcp_pm_rm_addr_or_subflow() (pm.c:830), and that loop re-reads
rm_list->nr / rm_list->ids[i] on every iteration. It also drops
pm.lock mid-loop around mptcp_subflow_shutdown()/mptcp_close_ssk()
since those can't be called under a spinlock.
 
Worse, mptcp_pm_worker() clears the MPTCP_PM_RM_ADDR_RECEIVED bit
before calling mptcp_pm_rm_addr_recv():
 
	if (pm->status & BIT(MPTCP_PM_RM_ADDR_RECEIVED)) {
		pm->status &= ~BIT(MPTCP_PM_RM_ADDR_RECEIVED);
		mptcp_pm_rm_addr_recv(msk);
	}
 
so if a second RM_ADDR shows up while the first is still being
processed, mptcp_pm_schedule_work() sees the bit already clear,
treats it as new work, and mptcp_pm_rm_addr_received() overwrites
rm_list_rx right under the loop during one of its unlock windows
instead of getting coalesced. End result is the outer loop's i /
rm_list->nr can go stale mid-flight and some IDs from the original
batch just never get processed.
 
This is pre-existing, not something this patch touches (different
struct, different lock concern than the id_accepted_bitmap stuff
here), so I'm not folding a fix into this one. Will open a separate
issue/patch for it, can take it myself if nobody's already on it.
 
For #498 itself, this patch should close it as-is. It also looks
related to #496 per that issue's note - let me know if you want me
to check whether this covers that one too, or if it's a
prerequisite.
 
Tested against mptcp_join.sh for the close-before-RM_ADDR case,
fullmesh reuse of the same remote id, and duplicate RM_ADDR - all
passing.
 
Thanks and regards,
Akshit patadiya


From: Akshit Patadiya <akshit@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, <kalpan.jani@mpiricsoftware.com>, <akshit@mpiric.us>, "Akshit Patadiya"<akshit@mpiricsoftware.com>
Date: Thu, 13 Aug 2026 18:07:54 +0530
Subject: [PATCH mptcp-next] mptcp: fix add_addr_accepted accounting on subflow close

 > When an accepted remote address is used by a subflow that is
 > closed before the corresponding RM_ADDR is received, the
 > add_addr_accepted counter is not decremented when the subflow
 > is removed.
 > 
 > As a result, the accepted-address budget can remain consumed
 > for the lifetime of the MPTCP connection. A subsequent ADD_ADDR
 > is then not acted upon because the peer is considered to have
 > already reached the add_addr_accepted limit.
 > 
 > Track accepted remote address IDs in a bitmap instead of relying
 > on a live subflow to signal removal. Release the accepted-address
 > slot as soon as the subflow using it is closed, instead of
 > depending on a matching RM_ADDR that may never arrive. The same
 > bitmap also guards against double-counting if the same address ID
 > is accepted more than once.
 > 
 > This allows a new MP_JOIN to be created after a previously
 > accepted subflow has been closed and its address has been
 > removed.
 > 
 > Fixes: 1c1f72137598 ("mptcp: pm: only decrement add_addr_accepted for MPJ req")
 > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/498
 > Signed-off-by: Akshit Patadiya <akshit@mpiricsoftware.com>
 > ---
 >  net/mptcp/pm.c        |  8 +++---
 >  net/mptcp/pm_kernel.c | 63 ++++++++++++++++++++++++++++++++++++-------
 >  net/mptcp/protocol.h  |  3 +++
 >  3 files changed, 60 insertions(+), 14 deletions(-)
 > 
 > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
 > index ba7c6f80a183..b6edb9df3216 100644
 > --- a/net/mptcp/pm.c
 > +++ b/net/mptcp/pm.c
 > @@ -681,8 +681,10 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk,
 >          return;
 >  
 >      spin_lock_bh(&pm->lock);
 > -    if (update_subflows)
 > +    if (update_subflows) {
 >          __mptcp_pm_close_subflow(msk);
 > +        mptcp_pm_nl_close_subflow(msk, subflow);
 > +    }
 >  
 >      /* Even if this subflow is not really established, tell the PM to try
 >       * to pick the next ones, if possible.
 > @@ -786,7 +788,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 >  
 >      for (i = 0; i < rm_list->nr; i++) {
 >          u8 rm_id = rm_list->ids[i];
 > -        bool removed = false;
 >  
 >          mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 >              struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 > @@ -807,7 +808,6 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 >                   i, rm_id, id, remote_id, msk->mpc_endpoint_id);
 >              spin_unlock_bh(&msk->pm.lock);
 >              mptcp_subflow_shutdown(sk, ssk, how);
 > -            removed |= subflow->request_join;
 >  
 >              /* the following takes care of updating the subflows counter */
 >              mptcp_close_ssk(sk, ssk, subflow);
 > @@ -819,7 +819,7 @@ static void mptcp_pm_rm_addr_or_subflow(struct mptcp_sock *msk,
 >  
 >          if (rm_type == MPTCP_MIB_RMADDR) {
 >              __MPTCP_INC_STATS(sock_net(sk), rm_type);
 > -            if (removed && mptcp_pm_is_kernel(msk))
 > +            if (mptcp_pm_is_kernel(msk))
 >                  mptcp_pm_nl_rm_addr(msk, rm_id);
 >          }
 >      }
 > diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
 > index d3014bf57bf3..8b087677a4e7 100644
 > --- a/net/mptcp/pm_kernel.c
 > +++ b/net/mptcp/pm_kernel.c
 > @@ -694,8 +694,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 >      spin_lock_bh(&msk->pm.lock);
 >  
 >      if (sf_created) {
 > -        /* add_addr_accepted is not decr for ID 0 */
 > -        if (remote.id)
 > +        /* ID 0 is not accounted: the remote address of the initial
 > +         * subflow is known from the beginning. Remember the other
 > +         * accepted IDs, so the counter can be balanced later on even
 > +         * if the linked subflows are gone by then.
 > +         */
 > +        if (remote.id &&
 > +            !__test_and_set_bit(remote.id, msk->pm.id_accepted_bitmap))
 >              msk->pm.add_addr_accepted++;
 >          if (msk->pm.add_addr_accepted >= limit_add_addr_accepted ||
 >              msk->pm.extra_subflows >= limit_extra_subflows)
 > @@ -705,16 +710,53 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 >  
 >  void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 >  {
 > -    if (rm_id && !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 > -        u8 limit_add_addr_accepted =
 > -            mptcp_pm_get_limit_add_addr_accepted(msk);
 > +    u8 limit_add_addr_accepted;
 >  
 > -        /* Note: if the subflow has been closed before, this
 > -         * add_addr_accepted counter will not be decremented.
 > -         */
 > -        if (--msk->pm.add_addr_accepted < limit_add_addr_accepted)
 > -            WRITE_ONCE(msk->pm.accept_addr, true);
 > +    /* Only remote addresses that have been accepted by this host are
 > +     * accounted: not ID 0, and not MP_JOIN requests initiated by the peer.
 > +     * The bit, not the presence of a subflow, is what tells them apart, so
 > +     * this works even when the subflows are already closed, and a
 > +     * duplicated RM_ADDR is a no-op.
 > +     */
 > +    if (!rm_id || !__test_and_clear_bit(rm_id, msk->pm.id_accepted_bitmap))
 > +        return;
 > +
 > +    if (WARN_ON_ONCE(msk->pm.add_addr_accepted == 0))
 > +        return;
 > +
 > +    limit_add_addr_accepted = mptcp_pm_get_limit_add_addr_accepted(msk);
 > +    if (--msk->pm.add_addr_accepted < limit_add_addr_accepted)
 > +        WRITE_ONCE(msk->pm.accept_addr, true);
 > +}
 > +
 > +/* Called with the PM lock held, from the subflow close path, before the
 > + * subflow is removed from conn_list.
 > + */
 > +void mptcp_pm_nl_close_subflow(struct mptcp_sock *msk,
 > +                   const struct mptcp_subflow_context *subflow)
 > +{
 > +    u8 remote_id = READ_ONCE(subflow->remote_id);
 > +    struct mptcp_subflow_context *iter;
 > +
 > +    /* Only the subflows this host has created upon an ADD_ADDR reception
 > +     * are accounted, and never the initial one.
 > +     */
 > +    if (!subflow->request_join || !remote_id ||
 > +        !test_bit(remote_id, msk->pm.id_accepted_bitmap))
 > +        return;
 > +
 > +    /* The remote address can still be used by another subflow, e.g. with
 > +     * fullmesh endpoints.
 > +     */
 > +    mptcp_for_each_subflow(msk, iter) {
 > +        if (iter == subflow || iter->close_event_done)
 > +            continue;
 > +        if (iter->request_join &&
 > +            READ_ONCE(iter->remote_id) == remote_id)
 > +            return;
 >      }
 > +
 > +    mptcp_pm_nl_rm_addr(msk, remote_id);
 >  }
 >  
 >  static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 > @@ -1668,6 +1710,7 @@ static void mptcp_pm_kernel_init(struct mptcp_sock *msk)
 >      WRITE_ONCE(pm->accept_subflow, subflows_allowed);
 >  
 >      bitmap_fill(pm->id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 > +    bitmap_zero(pm->id_accepted_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 >  }
 >  
 >  struct mptcp_pm_ops mptcp_pm_kernel = {
 > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
 > index 7e168e450fb0..54663d7aca34 100644
 > --- a/net/mptcp/protocol.h
 > +++ b/net/mptcp/protocol.h
 > @@ -243,6 +243,7 @@ struct mptcp_pm_data {
 >      );
 >  
 >      DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 > +    DECLARE_BITMAP(id_accepted_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 >      struct mptcp_rm_list rm_list_tx;
 >      struct mptcp_rm_list rm_list_rx;
 >  };
 > @@ -1127,6 +1128,8 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 >                 bool prio, bool backup);
 >  void mptcp_pm_addr_send_ack(struct mptcp_sock *msk);
 >  void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id);
 > +void mptcp_pm_nl_close_subflow(struct mptcp_sock *msk,
 > +                   const struct mptcp_subflow_context *subflow);
 >  void mptcp_pm_rm_subflow(struct mptcp_sock *msk,
 >               const struct mptcp_rm_list *rm_list);
 >  void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 > -- 
 > 2.43.0
 > 
 > 



Akshit Patadiya
 
Team Lead & Software developer at Mpiric Software
 
View My Digital Business Card
 



Disclaimer: This email and any attachments to it may be confidential and are intended solely for the use of the individual to whom it is addressed. Any views or opinions expressed are solely those of the author and do not necessarily represent those of Mpiric Software.


