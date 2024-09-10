Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B6013DDBD
	for <mptcp@lists.linux.dev>; Tue, 10 Sep 2024 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725941916; cv=none; b=UVvdS4gbG/CLNn8aDgN7Sul2xbirolfJYAD6yRmpufEtgbZUpKJW1b7LBV3ospjkeyeuHyjssbOQUsDfE/6bS1ezBg6khTqH3TnMoZ5vIGoA1KSZBZcZXO/YmklVFwx2G60smgtn/AFAE2i+M04FRe/VD5Rdv919QMEoIMfl16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725941916; c=relaxed/simple;
	bh=D1nv6VrnLnnDwlhzzAoW5nL7SuF7yussEiFsYcVJ9r4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VaGU4BdJF11roVe+IOT/QR5f3fBfIbLNrtwqxuvUSlbQC2sCjTG3t719OaszP6DnYAJ20SqhfTIs9H8R0m2w4ICKL2BZdBM6VD4b1zvSeHT4bgukI6Ym+eHDkdTEAyJmAeSujui+8bPl3i2IUk0eUp9MBWGtU2AC8gKze4RKUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mNcw969Q; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mNcw969Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725941611; bh=T3/zxzh9M3hr5Izd42Ue97EPDESHvm/1VabQ9jMvPc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mNcw969Q9uVWUjLn6lunr3jYlz4fwLr6gJ7mht7lgCFgIvFJvLJwiLX384YJjQXJ4
	 QQuXHnIpfbJLmKaFfuSeziNyeJAeSBKJq/w9wj/jGRQU02TNvmO1IjDWvpItnsfXOK
	 zXbPHtwZu3XcjGjwreTdORu6Zmi8XopqJoZdZ28U=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id EEA96CF1; Tue, 10 Sep 2024 11:59:42 +0800
X-QQ-mid: xmsmtpt1725940782t2ogp07xo
Message-ID: <tencent_272542BA3FBB37337F9EE91B384BB21BF008@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ577KvoMsX0d774LFei9XZ12iFMT1uZy7PA2/932JdS9w+KWdrZN3
	 sBV/8e+MzBfeCZagIBX8kYSnze9SFPN4SaV5Faq8Fcl9hYKavVpcC6LPvvXPggvHxl2MSOSsr/4/
	 XK91bItlx1n159phZqJeraxVjxw7Zmss4oZBVqIx/o56/gJEm9vGp3r96DqoEwyOmt4ZtdoQFtrV
	 wJmZQqKen1mUZ2ypHEDwlLtobnRmOKuvx494Ho8ErrlSaAVmuM7WmOqBD0xmc56YwRxoo6rRd+2c
	 uinna8lTWdOlRkGTNywYC7ej8Gop6G+miDqtZD+6PkAktSItRYLrPzCI+Wtbs4LY9ubFAf2m52m1
	 KdZY8tCstZfnJFanOShM3ZwYSyV+EISzM3KOVHeMIEU7yC4QNBfvPzwP6NEe4dDbunqORmBEl+Ye
	 KLLpOo5LFhi+CGgjAy0vaj9iR+x9xTwb/OTlvxCaYir6FsUoibmD5t8SEzWotZiYXwotDB8Z43cQ
	 1N2sbq/9ccve/s/XAD0J3eoCGjrPvMufgBLnxQd8ZwSrOmVYjMxzmSdRGaQRzw6SrRHQ57qDykf8
	 swb6HLCWViwD5c0LlRnByf79yTTQiU2ZKdQS9wJpdOiwQUuBT5YQq8WRiDRNGKU9BB+idYXQ6+gH
	 bNBAH7DIIiDk88s25txyvb/zgN9XyCgUENpbA5tcKib+fRGY13dZ3FT2bPoUiAEHSkAqAnUmqfPw
	 qxawHfopCjMAUIoi8gs1LRqssjo3OFxJqLsQdXE6ks2oaUaI9bnXrg4s3wYev0kJ1mYhH7Z0wkN+
	 YOkQr8VEvqSvB9NHrl62GyWFb8drs6d49H6WiyNbYyJ9iTk41cxX97RWn+XbN87DlSvzmnTS6I9n
	 kBE+VgVNg6aAcc6BT6vvDuRIP+xU6th6PobiOEIv8S9f0nZY2c/fs5pt4eSkfafwAeH54Hl1QKL7
	 KinQfLG6CtpBn0m+WMhkaUzBvtGlq2
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	geliang@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net v3] mptcp: pm: Fix uaf in __timer_delete_sync
Date: Tue, 10 Sep 2024 11:59:43 +0800
X-OQ-MSGID: <20240910035942.2293801-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <4e74f641-a4a0-4668-b77a-94082f0ea6f1@redhat.com>
References: <4e74f641-a4a0-4668-b77a-94082f0ea6f1@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 9 Sep 2024 15:07:21 +0200, Paolo Abeni wrote:
> On 9/5/24 14:27, Edward Adam Davis wrote:
> > There are two paths to access mptcp_pm_del_add_timer, result in a race
> > condition:
> > 
> >       CPU1				CPU2
> >       ====                               ====
> >       net_rx_action
> >       napi_poll                          netlink_sendmsg
> >       __napi_poll                        netlink_unicast
> >       process_backlog                    netlink_unicast_kernel
> >       __netif_receive_skb                genl_rcv
> >       __netif_receive_skb_one_core       netlink_rcv_skb
> >       NF_HOOK                            genl_rcv_msg
> >       ip_local_deliver_finish            genl_family_rcv_msg
> >       ip_protocol_deliver_rcu            genl_family_rcv_msg_doit
> >       tcp_v4_rcv                         mptcp_pm_nl_flush_addrs_doit
> >       tcp_v4_do_rcv                      mptcp_nl_remove_addrs_list
> >       tcp_rcv_established                mptcp_pm_remove_addrs_and_subflows
> >       tcp_data_queue                     remove_anno_list_by_saddr
> >       mptcp_incoming_options             mptcp_pm_del_add_timer
> >       mptcp_pm_del_add_timer             kfree(entry)
> > 
> > In remove_anno_list_by_saddr(running on CPU2), after leaving the critical
> > zone protected by "pm.lock", the entry will be released, which leads to the
> > occurrence of uaf in the mptcp_pm_del_add_timer(running on CPU1).
> > 
> > Keeping a reference to add_timer inside the lock, and calling
> > sk_stop_timer_sync() with this reference, instead of "entry->add_timer".
> > 
> > Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> > Cc: stable@vger.kernel.org
> > Reported-and-tested-by: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=f3a31fb909db9b2a5c4d
> > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >   net/mptcp/pm_netlink.c | 14 ++++++++++----
> >   1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 3e4ad801786f..7ddb373cc6ad 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -329,17 +329,21 @@ struct mptcp_pm_add_entry *
> >   mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> >   		       const struct mptcp_addr_info *addr, bool check_id)
> >   {
> > -	struct mptcp_pm_add_entry *entry;
> >   	struct sock *sk = (struct sock *)msk;
> > +	struct timer_list *add_timer = NULL;
> > +	struct mptcp_pm_add_entry *entry;
> >   
> >   	spin_lock_bh(&msk->pm.lock);
> >   	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
> > -	if (entry && (!check_id || entry->addr.id == addr->id))
> > +	if (entry && (!check_id || entry->addr.id == addr->id)) {
> >   		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
> > +		add_timer = &entry->add_timer;
> > +	}
> >   	spin_unlock_bh(&msk->pm.lock);
> >   
> > -	if (entry && (!check_id || entry->addr.id == addr->id))
> > -		sk_stop_timer_sync(sk, &entry->add_timer);
> > +	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
> > +	if (add_timer)
> > +		sk_stop_timer_sync(sk, add_timer);
> >   
> >   	return entry;
> >   }
> > @@ -1430,8 +1434,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> >   
> >   	entry = mptcp_pm_del_add_timer(msk, addr, false);
> >   	if (entry) {
> > +		spin_lock_bh(&msk->pm.lock);
> >   		list_del(&entry->list);
> >   		kfree(entry);
> > +		spin_unlock_bh(&msk->pm.lock);
> 
> I'm sorry for the late feedback.
> 
> I think this is not enough to fix races for good, i.e.
> 
> mptcp_nl_remove_subflow_and_signal_addr() -> mptcp_pm_remove_anno_addr()
> -> remove_anno_list_by_saddr()
> 
> could race with:
> 
> mptcp_pm_remove_addrs() -> remove_anno_list_by_saddr()
> 
> and both CPUs could see the same 'entry' returned by
> mptcp_pm_del_add_timer().
Yes, you are right.
> 
> I think the list_del() in remove_anno_list_by_saddr() should moved under
> the pm lock protection inside mptcp_pm_del_add_timer(), and no need to 
> add spin_lock_bh() around the kfree call.
Agreed, I will update the patch.

BR,
Edward

