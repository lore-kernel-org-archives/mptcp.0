Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C7513EFE3
	for <mptcp@lists.linux.dev>; Tue, 15 Apr 2025 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744708734; cv=none; b=YS63jFBgzF59amd1jXP+CfPLaYhMoVueZxVWjwTwP6iLcWucguLFwBV8zJ7HKa8sUkVRRJfjjbiYWX1hN7bkyr2/Ktrp8U3bUCZpGYe+6x5rZS5ZOA71z5/aTboMrgZBDrrsmlYKaJbSJpk+zxAKYL2HFUksEBAPT1Lhi82UeBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744708734; c=relaxed/simple;
	bh=o+rzEWU9tVWVBHmQlhEdjH56gFFraJG+zwxI5g8u1M8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z06MepmCFJzry6TMc+PeWZznQ8Vob33OhHBuqCkpwCAWR6tCMAttQylj5GSU2YE8IlINlv7Wte7m7kYXjXlRqy7p4ZfKH2GUmp2n8aRpGegazuqQ8NXG/WkZa2Zqsij8ZerfR0X+twdU2JdENeeokWqDIVmukk5UPWr6TOwBx+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhzH0y7h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhzH0y7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C00FC4CEDD;
	Tue, 15 Apr 2025 09:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744708733;
	bh=o+rzEWU9tVWVBHmQlhEdjH56gFFraJG+zwxI5g8u1M8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FhzH0y7hOwrz9fusmSyfTLcgn9TebHJA2cDfqu86ZtBpW9H6SFFu+97GGygX9W0gk
	 LOlXA2B6SR33zsKzNoNt9tQ9tdkfTwL+WR30vHxBGByB3Gg82L5Nq2DogudAwrHFD9
	 i3QHwCwi88hJnExwK4tZqUJxSV4epT9N0maDpVfavUH9Ha/UkmiM8+K7D5lnW+FQl4
	 WlYDfP/tK5GQJ+cy5xmkZK9oPRmpKvv0pTcUXwqpbyaWmtvdsgLYS0PA5DGVNK0PXR
	 gcueMnJbMWv7C2tARqK1DHRZMQIU+2JLUUIK6FKVDc4oiVZj9Fzr4m5GMTVVaFpq1e
	 26MXR/xd1YQLw==
Message-ID: <66f456226a68cc9e5458bb49eae348fadbe8649a.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop
 delete_local_addr helper
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 15 Apr 2025 17:18:48 +0800
In-Reply-To: <0caab1005d589bbda1e4e9224757ccc258ab37d4.camel@kernel.org>
References: <cover.1744257362.git.tanggeliang@kylinos.cn>
	 <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
	 <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org>
	 <0caab1005d589bbda1e4e9224757ccc258ab37d4.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mat, Matt,

On Tue, 2025-04-15 at 11:09 +0800, Geliang Tang wrote:
> Hi Mat, Matt,
> 
> On Fri, 2025-04-11 at 17:26 -0700, Mat Martineau wrote:
> > On Thu, 10 Apr 2025, Geliang Tang wrote:
> > 
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > Address entries should not be removed from local_addr_list when a
> > > subflow
> > > is deleted by the userspace PM, should only be removed when
> > > sending
> > > a
> > > REMOVE_ADDR.
> > > 
> > > So mptcp_userspace_pm_delete_local_addr() helper shouldn't be
> > > called in
> > > mptcp_pm_nl_subflow_create_doit() and
> > > mptcp_pm_nl_subflow_destroy_doit().
> > > 
> > > Since this helper is open-coding in mptcp_pm_nl_remove_doit(), it
> > > can be
> > > dropped now.
> > > 
> > > Address entries are removed from local_addr_list when sending a
> > > REMOVE_ADDR
> > > by the userspace PM, the local_addr_used counter of PM should
> > > also
> > > be
> > > decremented accordingly.
> > > 
> > 
> > Hi Geliang -
> > 
> > Have you tried this patch with mptcpd? Does it affect any tests
> > there?
> 
> I haven't tested it. To be honest, I don't know how to run the test
> items of mptcpd. Can you give me some guidance?

I just tested it this way, and here are the test results:

~/mptcpd/tests$ LD_PRELOAD=../src/.libs/libmptcpwrap.so ./mptcpwrap-
tester 
Test case 0: PASS
Test case 1: PASS
Test case 2: PASS
Test case 3: PASS
Test case 4: PASS
Test case 5: PASS
Test case 6: PASS

~/mptcpd/tests$ LD_PRELOAD=../src/.libs/libmptcpwrap.so ./test-
mptcpwrap 
Test case 0: PASS
Test case 1: PASS
Test case 2: PASS
Test case 3: mptcpwrap: changing socket protocol from 0x0 to 0x106
(IPPROTO_MPTCP) for family 0x2 type 0x1 fd 3
PASS
Test case 4: mptcpwrap: changing socket protocol from 0x0 to 0x106
(IPPROTO_MPTCP) for family 0xa type 0x1 fd 3
PASS
Test case 5: mptcpwrap: changing socket protocol from 0x6 to 0x106
(IPPROTO_MPTCP) for family 0x2 type 0x1 fd 3
PASS
Test case 6: mptcpwrap: changing socket protocol from 0x6 to 0x106
(IPPROTO_MPTCP) for family 0xa type 0x1 fd 3
PASS

~/mptcpd/tests$ LD_PRELOAD=../src/.libs/libmptcpwrap.so
TEST_PLUGIN_DIR=./plugins ./test-start-stop
Running non-interactive sudo check...
    succeeded
MPTCP is not enabled in the kernel.
Try 'sysctl -w net.mptcp.enabled=1'.
Required kernel MPTCP support not available.
TEST CASE: net.mptcp.enabled = 0 ...passed
Unable to load path manager plugins.
TEST CASE: net.mptcp.enabled = 1 ...failed

~/mptcpd/tests$ sudo ./test-bad-log-empty 
mptcpd: Unknown logging option: ""
Try `mptcpd --help' or `mptcpd --usage' for more information.
~/mptcpd/tests$ sudo ./test-bad-log-long 
mptcpd: Unknown logging option: "foo"
Try `mptcpd --help' or `mptcpd --usage' for more information.
~/mptcpd/tests$ sudo ./test-bad-log-short 
mptcpd: Unknown logging option: "foo"
Try `mptcpd --help' or `mptcpd --usage' for more information.
~/mptcpd/tests$ sudo ./test-bad-option 
/home/tgl/mptcpd/src/.libs/mptcpd: unrecognized option '--foo'
Try `mptcpd --help' or `mptcpd --usage' for more information.
~/mptcpd/tests$ sudo ./test-bad-path-manager 
mptcpd: Empty default path manager plugin command line option.
Try `mptcpd --help' or `mptcpd --usage' for more information.
~/mptcpd/tests$ sudo ./test-bad-plugin-dir 
mptcpd: Empty plugin directory command line option.
Try `mptcpd --help' or `mptcpd --usage' for more information.

These results appear to be unchanged from before. And in fact these
tests do not test userspace pm.

So it seems that this patch will not affect the tests of mptcpd.

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > 
> > 
> > - Mat
> > 
> > 
> > > Closes:
> > > https://github.com/multipath-tcp/mptcp_net-next/issues/403
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > > net/mptcp/pm_userspace.c | 37 +++++------------------------------
> > > --
> > > 1 file changed, 5 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> > > index 7fc19b844384..3824b4165421 100644
> > > --- a/net/mptcp/pm_userspace.c
> > > +++ b/net/mptcp/pm_userspace.c
> > > @@ -90,30 +90,6 @@ static int
> > > mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
> > > 	return ret;
> > > }
> > > 
> > > -/* If the subflow is closed from the other peer (not via a
> > > - * subflow destroy command then), we want to keep the entry
> > > - * not to assign the same ID to another address and to be
> > > - * able to send RM_ADDR after the removal of the subflow.
> > > - */
> > > -static int mptcp_userspace_pm_delete_local_addr(struct
> > > mptcp_sock
> > > *msk,
> > > -						struct
> > > mptcp_pm_addr_entry *addr)
> > > -{
> > > -	struct sock *sk = (struct sock *)msk;
> > > -	struct mptcp_pm_addr_entry *entry;
> > > -
> > > -	entry = mptcp_userspace_pm_lookup_addr(msk, &addr-
> > > >addr);
> > > -	if (!entry)
> > > -		return -EINVAL;
> > > -
> > > -	/* TODO: a refcount is needed because the entry can
> > > -	 * be used multiple times (e.g. fullmesh mode).
> > > -	 */
> > > -	list_del_rcu(&entry->list);
> > > -	sock_kfree_s(sk, entry, sizeof(*entry));
> > > -	msk->pm.local_addr_used--;
> > > -	return 0;
> > > -}
> > > -
> > > static struct mptcp_pm_addr_entry *
> > > mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk,
> > > unsigned int id)
> > > {
> > > @@ -331,6 +307,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff
> > > *skb, struct genl_info *info)
> > > 	}
> > > 
> > > 	list_del_rcu(&match->list);
> > > +	msk->pm.local_addr_used--;
> > > 	spin_unlock_bh(&msk->pm.lock);
> > > 
> > > 	mptcp_pm_remove_addr_entry(msk, match);
> > > @@ -408,14 +385,13 @@ int mptcp_pm_nl_subflow_create_doit(struct
> > > sk_buff *skb, struct genl_info *info)
> > > 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
> > > 	release_sock(sk);
> > > 
> > > -	if (err)
> > > +	if (err) {
> > > 		GENL_SET_ERR_MSG_FMT(info, "connect error: %d",
> > > err);
> > > +		goto create_err;
> > > +	}
> > > 
> > > 	spin_lock_bh(&msk->pm.lock);
> > > -	if (err)
> > > -		mptcp_userspace_pm_delete_local_addr(msk,
> > > &entry);
> > > -	else
> > > -		msk->pm.subflows++;
> > > +	msk->pm.subflows++;
> > > 	spin_unlock_bh(&msk->pm.lock);
> > > 
> > >  create_err:
> > > @@ -534,9 +510,6 @@ int mptcp_pm_nl_subflow_destroy_doit(struct
> > > sk_buff *skb, struct genl_info *info
> > > 		goto release_sock;
> > > 	}
> > > 
> > > -	spin_lock_bh(&msk->pm.lock);
> > > -	mptcp_userspace_pm_delete_local_addr(msk, &addr_l);
> > > -	spin_unlock_bh(&msk->pm.lock);
> > > 	mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN |
> > > SEND_SHUTDOWN);
> > > 	mptcp_close_ssk(sk, ssk, mptcp_subflow_ctx(ssk));
> > > 	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > > 
> 
> 

