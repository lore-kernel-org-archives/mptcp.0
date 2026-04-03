Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19B6A001
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775198746; cv=none; b=SGnsZPUwYCLreR850xQ2SY66n9P+AipjoaXTryItCHIm+a/XnfLtLSdgdTZuDNjfjhWk1fwteEh2D/n5Lsu0CkRKZa0CRbeo9jEiZULPYuxwGmNJQnUCsN7v3lCf9B8wX5tfngvwsntNcpGHe87kCRZ7ydyJJDxSfHCyaqHjKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775198746; c=relaxed/simple;
	bh=0hYal9PyaFNY4cb5Kv+nazqJbVrdoRXZT9xAQpbOLZY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=hhsZPOHksL62Lay9hodTG6P5h57M1jwyo88mQ6UEfSay+yzbjWYyE8Dn499nO9Z0W+aXqoMv1+a4ZT8dD+DUINRIf/AfogtE4nLsRLRyCXOr5gn/GC1DNSsx2NUZ+t52KnT9XjbXDBBLTE8IZfuIepDYJ6jYLgqcMgP+MUdjHWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kM9U7Vf6; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kM9U7Vf6"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775198741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KdTOgPEhIO/LU6qeUf5NeNE6j9sRVdJpcQHZKbpHFes=;
	b=kM9U7Vf6sUUMDq37mK9a5ftDmsVLEB6TKXs9ruzdHHz7xP+hut1RfYxCrQy1Gq/kthkBLi
	Ke8kUfU6kFuZs2CFa5ylJP89K8e5nGPd0QHbEPQtR3tfMshPH7q5D1r73t3i1VlW/T7Yew
	JR1/XY5Jd+Y1WidiTMxF0h7sj5qmQjw=
Date: Fri, 03 Apr 2026 06:45:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <bd405b7aaedd030858f609e936c811903e139f32@linux.dev>
TLS-Required: No
Subject: Fwd: Re: [PATCH mptcp-net v5 4/5] mptcp: fix the dead_lock in
 mptcp_data_ready
To: mptcp@lists.linux.dev
In-Reply-To: <e1f58d941ad141f9f96a24d1a1d9d6ca74cc2f5e@linux.dev>
References: <cover.1775033340.git.yangang@kylinos.cn>
 <8ed0aeb49f13410b25200d884c89ef3201d2c23b.1775033340.git.yangang@kylinos.cn>
 <159f8b70-4ffa-4eef-a3ca-13de3f8bc191@redhat.com>
 <e1f58d941ad141f9f96a24d1a1d9d6ca74cc2f5e@linux.dev>
X-Migadu-Flow: FLOW_OUT

-------- Forwarded message -------

From: gang.yan@linux.dev mailto:gang.yan@linux.dev=20
To:=20"Paolo Abeni" <pabeni@redhat.com mailto:pabeni@redhat.com?to=3D%22P=
aolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E >
Sent: April 3, 2026 at 2:44 PM
Subject: Re: [PATCH mptcp-net v5 4/5] mptcp: fix the dead_lock in mptcp_d=
ata_ready

April 2, 2026 at 4:02 AM, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni@=
redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:



>=20
>=20On 4/1/26 10:54 AM, Gang Yan wrote:
>=20=20
>=20=20
>=20 From: Gang Yan <yangang@kylinos.cn>
>=20=20
>=20 This patch defers mptcp_check_data_fin from __mptcp_move_skbs to avo=
id
>  deadlock.
>=20=20
>=20 When processing backlogged data in softirq context, __mptcp_move_skb=
s
>  directly calls mptcp_check_data_fin, which can lead to a deadlock if
>  the msk socket is in TCP_FIN_WAIT2 state. In that case,
>  mptcp_check_data_fin calls mptcp_shutdown_subflows, which attempts to
>  lock the subflow socket with lock_sock_fast() - a sleeping function
>  that cannot be called in atomic context (softirq).
>=20=20
>=20 The fix for such issue should be squashed inside the patch generatin=
g
>  the issue itself.
>=20=20
>=20=20
>=20 The correct pattern is already used in move_skbs_to_msk: if a data f=
in
>  is pending, schedule the work to be processed later in process context
>  rather than handling it directly.
>=20=20
>=20 Reported-by: Geliang Tang <geliang@kernel.org>
>  Co-developed-by: Geliang Tang <geliang@kernel.org>
>  Signed-off-by: Geliang Tang <geliang@kernel.org>
>  Signed-off-by: Gang Yan <yangang@kylinos.cn>
>  ---
>  Notes:
>=20=20
>=20 Hi Matt,Paolo:
>=20=20
>=20 Here is the response of AI review for this patch:
>=20=20
>=20 - Typo problem in subject line:
>  Already fixed in v5.
>=20=20
>=20 - Remove else branch:
>  It demonstrates a TOCTOU race, though the race window is extremely
>  narrow. The else branch is useless even without the race. So I
>  removed it in v5. WDYT?
>=20=20
>=20 Thanks,
>  Gang
>=20=20
>=20 Changelog:
>  v5:
>  - Fix typo in title.
>  - Remove the else branch.
>=20=20
>=20 ---
>  net/mptcp/protocol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20=20
>=20 diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>  index 326b5d4d79e7..88e19fa61b84 100644
>  --- a/net/mptcp/protocol.c
>  +++ b/net/mptcp/protocol.c
>  @@ -2247,8 +2247,9 @@ static bool __mptcp_move_skbs(struct sock *sk, s=
truct list_head *skbs, u32 *delt
>  }
>=20=20
>=20 __mptcp_ofo_queue(msk);
>  - if (moved)
>  - mptcp_check_data_fin((struct sock *)msk);
>  + if (moved && mptcp_pending_data_fin(sk, NULL))
>  + mptcp_schedule_work(sk);
>=20=20
>=20 Scheduling the worker when we are not in BH could introduce problema=
tic
>  delays. Instead you could factor out a ____mptcp_move_skbs() helper (a
>  better name would be nice!) not including the mptcp_check_data_fin()
>  call, use the latter in mptcp_data_ready() and in such function
>  eventually schedule the mptcp work as needed.
>=20
Hi=20Paolo,

Thanks for your review.=20
I'm=20a little bit confused. Does this mean the 'move_skbs_to_msk' should=
 be
fixed too? like:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6ce0d18c86b6..e90c8621683c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -869,13 +869,6 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk,=
 struct sock *ssk)
 if (unlikely(ssk->sk_err))
 __mptcp_subflow_error_report(sk, ssk);
=20
-=20/* If the moves have caught up with the DATA_FIN sequence number
- * it's time to ack the DATA_FIN and change socket state, but
- * this is not a good place to change state. Let the workqueue
- * do it.
- */
- if (mptcp_pending_data_fin(sk, NULL))
- mptcp_schedule_work(sk);
 return moved;
 }
=20
@@=20-909,6 +902,7 @@ void mptcp_data_ready(struct sock *sk, struct sock =
*ssk)
 {
 struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 struct mptcp_sock *msk =3D mptcp_sk(sk);
+ bool moved =3D false;
=20
=20/* The peer can send data while we are shutting down this
 * subflow at subflow destruction time, but we must avoid enqueuing
@@ -920,13 +914,17 @@ void mptcp_data_ready(struct sock *sk, struct sock =
*ssk)
 mptcp_data_lock(sk);
 mptcp_rcv_rtt_update(msk, subflow);
 if (!sock_owned_by_user(sk)) {
+ moved =3D move_skbs_to_msk(msk, ssk);=20
=20/* Wake-up the reader only for in-sequence data */
- if (move_skbs_to_msk(msk, ssk) && mptcp_epollin_ready(sk))
+ if (moved && mptcp_epollin_ready(sk))
 sk->sk_data_ready(sk);
 } else {
 __mptcp_move_skbs_from_subflow(msk, ssk, false);
 }
 mptcp_data_unlock(sk);
+=20
+=20if (mptcp_pending_data_fin(sk, NULL))
+ mptcp_check_data_fin(sk);
 }

Looking forward for your reply

Very thanks
Gang

>=20
>=20/P
>
