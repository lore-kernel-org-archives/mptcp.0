Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C70C71
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620983645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qma/kfLpBYZh9uV8vHoGw72NsyMdWuTxwT+3ZRWdFVU=;
	b=BEvXDSLhdI7hHx1/U3U46ytnQEPv98b8yGcY7pmWDuI66Ai6Io86XVgMiEKFTtPbkYl/sb
	33B1VvFsPE3xj/WL5a3GHMipscS3oAW4nO+IvGeLdY9L7AuSpz9DEaZoQdLa9k4N5rRze1
	DlUWPPV4gF+MaKQCqmJ96FnJJNxqiT4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-2cbD4F8XOgycQ5teljcwfw-1; Fri, 14 May 2021 05:14:02 -0400
X-MC-Unique: 2cbD4F8XOgycQ5teljcwfw-1
Received: by mail-ej1-f70.google.com with SMTP id kg5-20020a17090776e5b02903d343c715d9so975662ejc.0
        for <mptcp@lists.linux.dev>; Fri, 14 May 2021 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qma/kfLpBYZh9uV8vHoGw72NsyMdWuTxwT+3ZRWdFVU=;
        b=nDEyWhXnb5MgrlQAljaTt/zjUCFJJ3XJFEkMblnp1K26C4FmDlhoQpkUaFZ0+Hkr5+
         nX8Be5sYKk4ODY0qAu09zMZuVhhaxVpu60PmcuZSPBgQ4a3AMDT0HjXtW+m9cSI262jq
         KueW3SiI6eRtqSqaZNZ3WuBBKqQumkhTN1Uk0+zAIhyl0oYLpndg9dUJdqOpJEERK+rh
         l/eeyHPoZQ4zYKlKMITHKeu6gqwRyxRX7vNbWrOSFs4srCfazAtD0YqwCj1beq9zgbAS
         V3btWHNU68JH2F1KN38+FQbMfJsa43hvNKKApkX49lOo4PSWBzBedshJSCAqrS0/y/qW
         mwYA==
X-Gm-Message-State: AOAM532O3ca9ncSmErEWaHyToF7/LbPIYqNUF6n0G79jjlgJ6xDYwDSh
	6wnaFABk6xdgLsDDK9t56NqF4JrogKWqVyKgJ5IjtJlm46kFUpBfCzFuBLMFgOus8CyAJlEmwYQ
	5t1G35csM3YWTF5A=
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr54803067edz.70.1620983641072;
        Fri, 14 May 2021 02:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+h9ATi0CEBZL0mX6Jraf3Q/1r2FP2s4WsbY+Z+L+XKhxMiRdDaK6JPPeheQPGVP3O6+zvaw==
X-Received: by 2002:a05:6402:1914:: with SMTP id e20mr54803048edz.70.1620983640898;
        Fri, 14 May 2021 02:14:00 -0700 (PDT)
Received: from localhost (net-188-218-24-141.cust.vodafonedsl.it. [188.218.24.141])
        by smtp.gmail.com with ESMTPSA id q18sm4156146edd.3.2021.05.14.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 02:14:00 -0700 (PDT)
Date: Fri, 14 May 2021 11:13:59 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@gmail.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH net] mptcp: validate 'id' when stopping the ADD_ADDR
 retransmit timer
Message-ID: <YJ4/V56p8zc/gcoy@dcaratti.users.ipa.redhat.com>
References: <68c6032edaf880a958bf7f65afc7e9520f39d5cd.1620754971.git.dcaratti@redhat.com>
 <e03119dc-67cb-6ac1-67fe-d92a8f954e4@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e03119dc-67cb-6ac1-67fe-d92a8f954e4@linux.intel.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

hello Mat, thanks for reviewing!

On Tue, May 11, 2021 at 03:39:14PM -0700, Mat Martineau wrote:
> On Tue, 11 May 2021, Davide Caratti wrote:
> 
> > when Linux receives an echo-ed ADD_ADDR, it checks the IP address against
> > the list of "announced" addresses. In case of a positive match, the timer
> > that handles retransmissions is stopped regardless of the 'Address Id' in
> > the received packet: this behaviour does not comply with RFC8684 §3.4.1.
> > 
> > Fix it by validating the 'Address Id' in received echo-ed ADD_ADDRs.
> > Tested using packetdrill, with the following captured output:
> > 
> 
> Hi Davide -
> 
> The code path for ADD_ADDR echo ignores the return value of
> mptcp_pm_del_add_timer(), so there's no chance there of leaving
> entry->add_timer running if the addr.id doesn't match.

true, and that's the purpose of this patch. When addr.id doesn't match,
it leaves the timer running to allow another attempt of ADD_ADDR + HMAC.

> The function is also called by remove_anno_list_by_saddr(), which will free
> 'entry' if a non-NULL value is returned by mptcp_pm_del_add_timer(). There's
> more of a chance here that the sk_stop_timer_sync() would be skipped and
> entry would be freed anyway. Looking at the various paths to this in the
> path manager it seems like it *should* not happen, but I'm not convinced
> it's impossible. Did you look at the effect of this change on these other
> code paths?

good point, I only tried packetdrill and the kselftests. I see

mptcp_pm_remove_anno_addr()
  remove_anno_list_by_saddr()

and its callers: in this case,either 'addr.id' is always read from the return
value of 

 __lookup_addr_by_id(pernet, addr.addr.id);

or by iterating over

&pernet->local_addr_list

, so those should all be 'signal' endpoints previously added by netlink:
the value of addr.id should always match and the timer should always
be stopped.

However, I also don't feel 100% safe - because 'entry' is freed by
remove_anno_list_by_saddr() and the value of 'address.id' is never checked
in addresses_equal(). Maybe it's safer to do soemething like:

 347 struct mptcp_pm_add_entry *
 348 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 349                        struct mptcp_addr_info *addr, bool strict)
 350 {
 351         struct mptcp_pm_add_entry *entry;
 352         struct sock *sk = (struct sock *)msk;
 353 
 354         spin_lock_bh(&msk->pm.lock);
 355         entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 356         if (entry && strict && entry->addr.id == addr->id)
 357                 entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 358         spin_unlock_bh(&msk->pm.lock);
 359 
 360         if (entry && strict && entry->addr.id == addr->id)
 361                 sk_stop_timer_sync(sk, &entry->add_timer);
 362 
 363         return entry;
 364 }


so that mptcp_pm_del_add_timer(..., true) is called only in the receive
path of echo-ed ADD_ADDR. WDYT?

thanks!
-- 
davide

