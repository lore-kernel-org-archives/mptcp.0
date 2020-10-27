Content-Type: multipart/mixed; boundary="===============6490624302064653089=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: send out
 dedicated ADD_ADDR packet"
Date: Tue, 27 Oct 2020 16:50:34 +0100
Message-ID: <661968e77dbf7245c58e121c4ea43890a08c6d4b.camel@redhat.com>
In-Reply-To: e8438a90864f67398b3b3a6cfa7dc94baac7206b.1603781696.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6446

--===============6490624302064653089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, 2020-10-27 at 14:58 +0800, Geliang Tang wrote:
> @@ -354,7 +355,6 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>  			if (mptcp_pm_alloc_anno_list(msk, local)) {
>  				msk->pm.add_addr_signaled++;
>  				mptcp_pm_announce_addr(msk, &local->addr, false);
> -				mptcp_pm_check_send_dedicated_add_addr_packet(msk);

Here...

>  			}
>  		} else {
>  			/* pick failed, avoid fourther attempts later */
> @@ -425,7 +425,6 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock =
*msk)
>  	spin_lock_bh(&msk->pm.lock);
>  =

>  	mptcp_pm_announce_addr(msk, &remote, true);
> -	mptcp_pm_check_send_dedicated_add_addr_packet(msk);

... end here the caller - mptcp_pm_create_subflow_or_signal_addr() /
mptcp_pm_nl_add_addr_received() - is already running from the
workqueue, so it would be nice to avoid another wq scheduling and send
the ack directly.

If you takes the workqueue sceduling out of
of mptcp_pm_announce_addr(), you can keep the above code unchanged, and
add the workqueue scheduling in the other mptcp_pm_announce_addr() call
site.

Not sure if the above is clear enough, please let me know.

Cheers,

Paolo

--===============6490624302064653089==--
